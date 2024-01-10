\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass {fdu-doctorplan} {2024-01-10} {v1.0}
  {Thesis template for doctor scientific research plan of Fudan University}
\RequirePackage { l3keys2e, xparse }


% 宏包报错信息
\msg_new:nnn { fdu-doctorplan } { l3-too-old }
  {
    Package~ "#1"~ is~ too~ old. \\\\
    Please~ update~ an~ up-to-date~ version~ of~ the~ bundles \\
    "l3kernel"~ and~ "l3packages"~ using~ your~ TeX~ package \\
    manager~ or~ from~ CTAN.
  }
% 检测 l3keys2e 的版本
\clist_map_inline:nn { l3keys2e }
  {
    \@ifpackagelater {#1} { 2020/07/17 }
      { } { \msg_error:nnn { fdu-doctorplan } { l3-too-old } {#1} }
  }
% 编译方式的报错信息
\msg_new:nnn { fdu-doctorplan } { unsupported-engine }
  {
    The~ fdu-doctorplan~ class~ requires~ either~ XeTeX~ or~ LuaTeX. \\\\
    "#1"~ is~ not~ supported~ at~ present.~ You~ must~ change \\
    your~ typesetting~ engine~ to~ "xelatex"~ or~ "lualatex".
  }
% 仅支持 xelatex 和 luatex 的编译方式
\sys_if_engine_xetex:F
  {
    \sys_if_engine_luatex:F
      {
        \msg_fatal:nnx { fdu-doctorplan } { unsupported-engine }
          { \c_sys_engine_str }
      }
  }

\cs_generate_variant:Nn \tl_map_inline:nn { xn }
\prg_generate_conditional_variant:Nnn \clist_if_in:Nn { Nx } { T, TF }

\clist_new:N \l__fdp_tmpa_clist
\clist_new:N \l__fdp_tmpb_clist
\dim_new:N \l__fdp_tmpa_dim
\dim_new:N \l__fdp_tmpb_dim
\skip_new:N \l__fdp_tmpa_skip
\skip_new:N \l__fdp_tmpb_skip
\tl_new:N \l__fdp_tmpa_tl
\tl_new:N \l__fdp_tmpb_tl
\box_new:N \l__fdp_tmpa_box
\box_new:N \l__fdp_tmpb_box

\cs_new_protected:Npn \__fdp_cover_infomation_center_underline_box:nn #1#2
  {
    \mode_leave_vertical:
    \CJKunderline*
      [
        thickness = 1pt
      ]
      {
        \hbox_to_wd:nn { #1 + 5mm } 
          { 
            \hfil 
              #2
            \hfil
          }
      }
  }
\cs_generate_variant:Nn \__fdp_cover_infomation_center_underline_box:nn  { Vn }

\cs_new:Npn \__fdp_get_max_text_width:NN #1#2
  {
    \group_begin:
      \clist_set_eq:NN \l__fdp_tmpa_clist #2
      \bool_until_do:nn { \clist_if_empty_p:N \l__fdp_tmpa_clist }
        {
          \clist_pop:NN \l__fdp_tmpa_clist \l__fdp_tmpa_tl
          \__fdp_get_text_width:NV \l__fdp_tmpa_dim \l__fdp_tmpa_tl
          \dim_gset:Nn #1 { \dim_max:nn {#1} { \l__fdp_tmpa_dim } }
        }
    \group_end:
  }
\cs_new:Npn \__fdp_get_text_width:Nn #1#2
  {
    \hbox_set:Nn \l__fdp_tmpa_box {#2}
    \dim_set:Nn #1 { \box_wd:N \l__fdp_tmpa_box }
  }
\cs_generate_variant:Nn \__fdp_get_text_width:Nn { NV }
% 用户设置命令
\NewDocumentCommand \fdpsetup { m }
  { \keys_set:nn { fdu-doctorplan } {#1} }


% 消除 CJK 警告
\RequirePackage { filehook }
\AtEndOfPackageFile* { fontspec }
  { \msg_redirect_name:nnn { fontspec } { no-script } { none } }
\AtEndOfPackageFile* { xeCJK }
  {
    \msg_redirect_name:nnn { xeCJK } { CJKfamily-redef } { none }
    \defaultCJKfontfeatures { Script  = CJK }
  }


\LoadClass [ oneside, zihao = 5] {ctexbook}


\RequirePackage { fancyhdr }
\RequirePackage { geometry }
\RequirePackage { xeCJKfntef }
\RequirePackage { tikzpagenodes }

\geometry
  {
    a4paper,
    margin = 2cm,
    footskip = 8mm,
  }


% 页码改成页脚居中
\pagestyle { fancy }
\fancyhf { }
\fancyfoot [C] { \thepage }
\renewcommand { \headrulewidth } { 0pt }


\ctexset
  {
    secnumdepth = 4,
    chapter =
      {
        name = {,、},
        number = \chinese{chapter},
        format = \zihao { 4 } \bfseries \heiti \raggedright,
        aftername = {},
        beforeskip = 0pt,
        afterskip = \baselineskip,
      },
    section =
      {
        format = \zihao { -4 } \bfseries \heiti \raggedright
      },
  }


% 信息接口
\str_new:N \g__fdp_examination_method_str
\keys_define:nn { fdu-doctorplan / info }
  {
    year        .int_set:N   = \l__fdp_info_year_int,
    month       .int_set:N   = \l__fdp_info_month_int,
    day         .int_set:N   = \l__fdp_info_day_int,
    name      .tl_set:N    = \l__fdp_info_name_tl,
    supervisor  .tl_set:N    = \l__fdp_info_supervisor_tl,
    department  .tl_set:N    = \l__fdp_info_department_tl,
    major       .tl_set:N    = \l__fdp_info_major_tl,
    research-area    .tl_set:N    = \l__fdp_info_research_area_tl,
    student-id  .tl_set:N    = \l__fdp_info_student_id_tl,
    examination-method .str_gset:N = \g__fdp_examination_method_str
  }

\keys_define:nn { fdu-doctorplan }
  {
    info .meta:nn = { fdu-doctorplan / info } {#1}
  }

\keys_set:nn { fdu-doctorplan / info }
  {
    year  = { \int_use:N \c_sys_year_int },
    month = { \int_use:N \c_sys_month_int },
    day   = { \int_use:N \c_sys_day_int },
  }

% 封面
\cs_new_protected:Npn \__fdp_cover_infomation_spread_box:nn #1#2
  {
    \mode_leave_vertical:
    \hbox_to_wd:nn {#1}
      { \tl_map_inline:xn {#2} { ##1 \hfil } \unskip }
  }

\ctex_after_end_preamble:n
  {
    \begin{titlepage}
      \setcounter{page}{0}
      \__fdp_cover:
    \end{titlepage}
  }
\cs_new_protected:Npn \__fdp_cover:
  {
    \begin{tikzpicture} [ remember~picture, overlay ]
      % 顶部的信息
      \__fdp_cover_topmatter:
      % 标题
      \__fdp_cover_title:
      % 个人信息
      \__fdp_cover_infomation:
      % 时间
      % \__fdp_cover_time:
    \end{tikzpicture}
  }

% 封面顶部的四项
\cs_new:Npn \__fdp_cover_topmatter:
  {
    \node [ anchor = north~west ] ( top ) at 
      ( 
        % [ shift = { (1.5em, 0em) } ] 
        current~page~text~area.north~west 
      ) 
      {
        \kaishu \zihao{5}
        \begin{tabular}{l}
          考试方式：\__fdp_examination_method:\\
          报名号：\underline{\,\,\l__fdp_info_student_id_tl\,\,}
        \end{tabular}
      };
  }
\cs_new:Npn \__fdp_examination_method:
  {
    \str_case:VnF \g__fdp_examination_method_str
      {
        {公开招考}
          {
            \checkedbox \, 公开招考 \space
            \fdpsquare \, 本科直博 \space
            \fdpsquare \, 硕博连读
          }
        {本科直博}
          {
            \fdpsquare \, 公开招考 \space
            \checkedbox \, 本科直博 \space
            \fdpsquare \, 硕博连读
          }
        {硕博连读}
          {
            \fdpsquare \, 公开招考 \space
            \fdpsquare \, 本科直博 \space
            \checkedbox \, 硕博连读
          }
      }
      {
        \fdpsquare \, 公开招考 \space
        \fdpsquare \, 本科直博 \space
        \fdpsquare \, 硕博连读
      }
  }
\NewDocumentCommand { \fdpsquare }{ }
  {
    \resizebox{!}{\fontcharht\font`M}
      {
        \begin{tikzpicture}[y=0.80pt, x=0.80pt, yscale=-1.000000, xscale=1.000000, inner~sep=0pt, outer~sep=0pt]
          \begin{scope}[shift={(100.0,1706.0)},nonzero~rule]
            \path[draw=.,fill=.,line~width=1pt] (2016.0000,410.0000) --
              (32.0000,410.0000) -- (32.0000,-1574.0000) -- (2016.0000,-1574.0000) --
              (2016.0000,410.0000) -- cycle(1866.0000,260.0000) -- (1866.0000,-1424.0000) --
              (182.0000,-1424.0000) -- (182.0000,260.0000) -- (1866.0000,260.0000) -- cycle;
          \end{scope}
        \end{tikzpicture}
      }
  }
\NewDocumentCommand { \checkedbox }{ }
  {
    % utfsym.sty
    \resizebox{!}{\fontcharht\font`M}
      {
        \begin{tikzpicture}[y=0.80pt, x=0.80pt, yscale=-1.000000, xscale=1.000000, inner~sep=0pt, outer~sep=0pt]
          \begin{scope}[shift={(100.0,1706.0)},nonzero~rule]
            \path[draw=.,fill=.,line~width=1pt] (2016.0000,410.0000) --
              (32.0000,410.0000) -- (32.0000,-1574.0000) -- (2016.0000,-1574.0000) --
              (2016.0000,410.0000) -- cycle(1866.0000,260.0000) -- (1866.0000,-1424.0000) --
              (182.0000,-1424.0000) -- (182.0000,260.0000) -- (1866.0000,260.0000) --
              cycle(1807.0000,-1301.0000) .. controls (1551.6667,-999.0000) and
              (1346.3333,-736.3333) .. (1191.0000,-513.0000) .. controls
              (1184.3333,-503.0000) and (1089.3333,-353.0000) .. (906.0000,-63.0000) ..
              controls (889.3333,-35.0000) and (863.0000,6.0000) .. (827.0000,60.0000) ..
              controls (803.0000,92.0000) and (777.3333,113.3333) .. (750.0000,124.0000) ..
              controls (728.0000,132.6667) and (695.3333,137.0000) .. (652.0000,137.0000) ..
              controls (599.3333,137.0000) and (557.0000,109.6667) .. (525.0000,55.0000) ..
              controls (498.3333,9.6667) and (471.3333,-56.0000) .. (444.0000,-142.0000) ..
              controls (414.6667,-232.6667) and (400.0000,-301.0000) .. (400.0000,-347.0000)
              .. controls (400.0000,-378.3333) and (427.0000,-409.3333) ..
              (481.0000,-440.0000) .. controls (529.6667,-468.0000) and (571.0000,-482.0000)
              .. (605.0000,-482.0000) .. controls (628.3333,-482.0000) and
              (654.6667,-442.3333) .. (684.0000,-363.0000) .. controls (713.3333,-283.6667)
              and (735.3333,-244.0000) .. (750.0000,-244.0000) .. controls
              (760.6667,-244.0000) and (778.3333,-264.6667) .. (803.0000,-306.0000) ..
              controls (881.6667,-436.6667) and (993.3333,-606.0000) ..
              (1138.0000,-814.0000) .. controls (1206.6667,-912.6667) and
              (1255.0000,-980.6667) .. (1283.0000,-1018.0000) .. controls
              (1339.0000,-1093.3333) and (1392.0000,-1157.6667) .. (1442.0000,-1211.0000) ..
              controls (1518.6667,-1293.0000) and (1635.6667,-1334.0000) ..
              (1793.0000,-1334.0000) -- (1807.0000,-1301.0000) -- cycle;
          \end{scope}
          \end{tikzpicture}
      }
  }

% 标题
\cs_new:Npn \__fdp_cover_title:
  {
    \node[] ( titlelabel ) at
      (
        [ shift = { ( 0cm, 19em ) } ] current~page.center
        % current~page.center
      ) 
      {
        % \zihao{-0} 
        \fontsize{30bp}{0em}\selectfont
        \bfseries \kaishu
        \__fdp_cover_infomation_spread_box:nn { 11.5em } { 博 士 生 科 研 计 划 书 }
      };
  }


% 个人信息
\cs_new:Npn \__fdp_cover_infomation:
  {
    \node[] (information) at
        (
          [shift = {(0, -0.1\textheight)}]
          current~page.center
        )
        {
          \begin{minipage} [ c ] { \textwidth }
            \centering \zihao {3}  \bfseries \kaishu
            \clist_set:Nx \l__fdp_tmpa_clist
              {
                学生姓名,
                报考院系,
                报考专业,
                研究方向,
                导师
              }
            \clist_set:Nx \l__fdp_tmpb_clist
              {
                \l__fdp_info_name_tl,
                \l__fdp_info_department_tl,
                \l__fdp_info_major_tl,
                \l__fdp_info_research_area_tl,
                \l__fdp_info_supervisor_tl,
              }
            % 获得个人信息的内容最大宽度
            \__fdp_get_max_text_width:NN 
              \l__fdp_tmpb_dim \l__fdp_tmpb_clist
            \bool_until_do:nn
              { \clist_if_empty_p:N \l__fdp_tmpa_clist }
              {
                \clist_pop:NN \l__fdp_tmpa_clist \l__fdp_tmpa_tl
                \clist_pop:NN \l__fdp_tmpb_clist \l__fdp_tmpb_tl
                \__fdp_cover_infomation_spread_box:nn
                  { 4em }
                  { \l__fdp_tmpa_tl }：\space
                \__fdp_cover_infomation_center_underline_box:Vn 
                  \l__fdp_tmpb_dim 
                  { \l__fdp_tmpb_tl }
                \skip_vertical:n { 2.85 ex }
              }
            \skip_vertical:n { 4.3cm }
            \__fdp_cover_time:
          \end{minipage}
        };
  }

% 时间
\cs_new:Npn \__fdp_cover_time:
  {
    % \node [ anchor = south ] ( date ) at ( [shift = {(-1.05em, 4.3cm)}]current~page~text~area.south ) 
      % {
        % \zihao{3} \bfseries \kaishu
        \__fdp_cover_infomation_spread_box:nn { 4em } {日期} ：~
        % \zhdigits { \int_use:N \l__fdp_info_year_int}
        \int_use:N \l__fdp_info_year_int
        \, 年
        % \zhnumber { \int_use:N \l__fdp_info_month_int }
        \, \int_use:N \l__fdp_info_month_int
        \, 月 
        \, \int_use:N \l__fdp_info_day_int
        \, 日
      % };
  }
\dim_new:N \g__fdp_box_width_extra_dim   % box 的额外宽度
\dim_new:N \g__fdp_box_height_extra_dim  % box 的下面的额外高度
\dim_set:Nn \g__fdp_box_width_extra_dim { 8pt }
\dim_set:Nn \g__fdp_box_height_extra_dim { 6pt }

\clist_new:N \g__fdp_chapter_page_clist  % 用来存 chapter 所在页面的页码，用于判定框的类型
\cs_set_eq:NN \chapter:nn \chapter
\cs_new:Npn \chapter_star:n #1
  {
    \chapter:nn * {#1}
  }

\RenewDocumentCommand{ \chapter }{ s O{#3} m }   % 注意#2 的默认值是 #3，如果为空的话目录和页眉就没有标题了
  {
    \IfBooleanTF {#1}
      { \chapter_star:n {#3} }
      { \chapter:nn [#2] {#3} }
    \clist_gput_right:Nx \g__fdp_chapter_page_clist { \thepage }
  }

\AddToHook { shipout / background }
  {
    \put (0cm,0cm)
      {
        \int_compare:nNnT { \c@page } > { 0 }  % 去掉封面的框
          {
            \clist_if_in:NxTF \g__fdp_chapter_page_clist { \int_use:N \c@page }
              {
                \__fdp_content_box_move:
              }
              {
                \__fdp_content_box_not_move:
              }
          }
      }
  }

\cs_new:Npn \__fdp_content_box_not_move:
  {
    \begin{tikzpicture}[ remember~picture, overlay ]
      \draw 
        ([shift = {(-\g__fdp_box_width_extra_dim, \g__fdp_box_height_extra_dim)}]current~page~text~area.north~west) 
        -- 
        ([shift = {(\g__fdp_box_width_extra_dim, \g__fdp_box_height_extra_dim)}]current~page~text~area.north~east)
        --
        ([shift = {(\g__fdp_box_width_extra_dim, -4pt)}]current~page~text~area.south~east)
        --
        ([shift = {(-\g__fdp_box_width_extra_dim, -4pt)}]current~page~text~area.south~west) -- cycle
        ;
    \end{tikzpicture}
  }
\cs_new:Npn \__fdp_content_box_move:
  {
    \begin{tikzpicture}[ remember~picture, overlay ]
      \draw 
        ([shift = {(-\g__fdp_box_width_extra_dim, -4em)}]current~page~text~area.north~west) 
        -- 
        ([shift = {(\g__fdp_box_width_extra_dim, -4em)}]current~page~text~area.north~east)
        --
        ([shift = {(\g__fdp_box_width_extra_dim, -4pt)}]current~page~text~area.south~east)
        --
        ([shift = {(-\g__fdp_box_width_extra_dim, -4pt)}]current~page~text~area.south~west) -- cycle
        ;
    \end{tikzpicture}
  }