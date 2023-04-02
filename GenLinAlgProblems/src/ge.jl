# Using the computer to produce a nice layout of the computations
function ge( matrices, desc, pivot_cols; Nrhs=0, formater=to_latex,
             variable_colors=["blue","black"], pivot_colors=["blue","yellow!40"],
             comment_list=[], array_names=nothing,
             start_index=1, func=nothing, fig_scale=nothing, tmp_dir="./tmp", keep_file="./tmp/pb" )

    M = size(matrices[1][end],1)
    N = size(matrices[1][end],2)-sum(Nrhs)

    pivot_list, bg_for_entries, ref_path_list, variable_summary = decorate_ge(desc, pivot_cols, (M,N); pivot_color=pivot_colors[2]);

    h,m=nM.ge( formater(matrices), formater=x->x, Nrhs=Nrhs,
               pivot_list       = pivot_list,
               bg_for_entries   = bg_for_entries,
               variable_colors  = variable_colors,pivot_text_color=pivot_colors[1],
               ref_path_list    = ref_path_list, comment_list=comment_list,
               variable_summary = variable_summary,
               array_names      = array_names,
               start_index      = start_index,
               func             = func,
               fig_scale        = fig_scale,
               tmp_dir          = tmp_dir, keep_file=keep_file    )
    h
end
