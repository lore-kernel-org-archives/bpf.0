Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35403F788A
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423551; cv=none; b=K8wOUruzLRJtngqeBj2bbDnI7NnWQulh1qzq63/Z8kBYjynvOp/g/K8+UVC/I8KnfKg2Gvln5CQoyaMyUAPeYPeRloPL96uQIoAqzphWr4+4ni2I8OQQGKD7YQ2i9cKzM5Bq8mt7MlBU4SCvHHhok8hMDdoVDQKLZEU+01gYJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423551; c=relaxed/simple;
	bh=/Sih+XRaMvKUi5HbyUAxjXj1H8hGna1zEvcl18aCtvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KH74MeI5mNROVbT0DdUqtleWsD0MsQvlUp73GzPu6PFxCitKUGdpZVAxfzdA9QApwEtlh00y3CpDZbpaunKFfbPraWY92il23KUcBPHbLFvAoK9fBOc1TWndvTmDYWFyEKVEIO5AHdpaOk8RHD6wNte7DJtJ1sEM1Hqg0KCiYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ptM/X1lQ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ptM/X1lQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783423532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfC+N1K3TSy/cGkxRZ2lG4ZYNj45NnkjD9xRp36K1PQ=;
	b=ptM/X1lQej7pl0RZa1OAAx44ROVqEE4675mV7gg7ZImNDxA0ExOjFtqxVc8GK5W1olkRu3
	VP2mXQHDeZ4I7VYLGpN6F5N9NfuS/cupNvZvbPyLQ+GMU1IoVPyHlWtUrsEnLfj9+QqGnN
	9FX84WBGh0OBVa/JoS8ZiCDZwQfbYqQ=
From: George Guo <dongtai.guo@linux.dev>
To: yangtiezhu@loongson.cn
Cc: chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel@xen0n.name,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 00/11] LoongArch: BPF: arena features, exceptions, private stack and may_goto
Date: Tue,  7 Jul 2026 19:25:20 +0800
Message-Id: <20260707112520.380471-1-dongtai.guo@linux.dev>
In-Reply-To: <dd02bf32-e447-2191-6cd5-7b7441f9a9b5@loongson.cn>
References: <dd02bf32-e447-2191-6cd5-7b7441f9a9b5@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> Please provide the test execution logs to ensure they don't fail.

Test execution logs below, LoongArch (2-vCPU QEMU/KVM 3A5000 guest),
based on 7.2.0-rc1 + this series:

  Feature                          Test(s)
  --------------------------------------------------------------
  1  offset / TCC pointer           tailcalls
  2  internal-only MOV (percpu)     cpumask, percpu_alloc
  3  timed may_goto                 iters
  4  private stack                  struct_ops_private_stack
  5  exceptions                     exceptions
  6  sign-extending arena loads     verifier_ldsx
  7  arena atomics                  arena_atomics
  arena gating (regression check)   arena_list, arena_htab, verifier_arena

$ sudo ./test_progs -t tailcalls
#476/1   tailcalls/tailcall_1:OK
#476/2   tailcalls/tailcall_2:OK
#476/3   tailcalls/tailcall_3:OK
#476/4   tailcalls/tailcall_4:OK
#476/5   tailcalls/tailcall_5:OK
#476/6   tailcalls/tailcall_6:OK
#476/7   tailcalls/tailcall_bpf2bpf_1:OK
#476/8   tailcalls/tailcall_bpf2bpf_2:OK
#476/9   tailcalls/tailcall_bpf2bpf_3:OK
#476/10  tailcalls/tailcall_bpf2bpf_4:OK
#476/11  tailcalls/tailcall_bpf2bpf_5:OK
#476/12  tailcalls/tailcall_bpf2bpf_6:OK
#476/13  tailcalls/tailcall_bpf2bpf_fentry:OK
#476/14  tailcalls/tailcall_bpf2bpf_fexit:OK
#476/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
#476/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
#476/17  tailcalls/tailcall_poke:OK
#476/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
#476/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
#476/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
#476/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
#476/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
#476/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
#476/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
#476/25  tailcalls/tailcall_freplace:OK
#476/26  tailcalls/tailcall_bpf2bpf_freplace:OK
#476/27  tailcalls/tailcall_failure:OK
#476/28  tailcalls/reject_tail_call_spin_lock:OK
#476/29  tailcalls/reject_tail_call_rcu_lock:OK
#476/30  tailcalls/reject_tail_call_preempt_lock:OK
#476/31  tailcalls/reject_tail_call_ref:OK
#476/32  tailcalls/tailcall_sleepable:OK
#476/33  tailcalls/tailcall_cgrp_storage:OK
#476/34  tailcalls/tailcall_cgrp_storage_diff_storage:OK
#476/35  tailcalls/tailcall_cgrp_storage_no_storage:OK
#476/36  tailcalls/tailcall_cgrp_storage_no_storage_leaf:OK
#476/37  tailcalls/tailcall_cgrp_storage_no_storage_bridge:OK
#476     tailcalls:OK
Summary: 1/37 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t cpumask
#98/1    cpumask/test_alloc_free_cpumask:OK
#98/2    cpumask/test_set_clear_cpu:OK
#98/3    cpumask/test_setall_clear_cpu:OK
#98/4    cpumask/test_first_firstzero_cpu:OK
#98/5    cpumask/test_firstand_nocpu:OK
#98/6    cpumask/test_test_and_set_clear:OK
#98/7    cpumask/test_and_or_xor:OK
#98/8    cpumask/test_intersects_subset:OK
#98/9    cpumask/test_copy_any_anyand:OK
#98/10   cpumask/test_insert_leave:OK
#98/11   cpumask/test_insert_remove_release:OK
#98/12   cpumask/test_global_mask_rcu:OK
#98/13   cpumask/test_global_mask_array_one_rcu:OK
#98/14   cpumask/test_global_mask_array_rcu:OK
#98/15   cpumask/test_global_mask_array_l2_rcu:OK
#98/16   cpumask/test_global_mask_nested_rcu:OK
#98/17   cpumask/test_global_mask_nested_deep_rcu:OK
#98/18   cpumask/test_global_mask_nested_deep_array_rcu:OK
#98/19   cpumask/test_cpumask_weight:OK
#98/20   cpumask/test_refcount_null_tracking:OK
#98/21   cpumask/test_populate_reject_small_mask:OK
#98/22   cpumask/test_populate_reject_unaligned:OK
#98/23   cpumask/test_populate:OK
#98/24   cpumask/test_alloc_no_release:OK
#98/25   cpumask/test_alloc_double_release:OK
#98/26   cpumask/test_acquire_wrong_cpumask:OK
#98/27   cpumask/test_mutate_cpumask:OK
#98/28   cpumask/test_insert_remove_no_release:OK
#98/29   cpumask/test_cpumask_null:OK
#98/30   cpumask/test_global_mask_out_of_rcu:OK
#98/31   cpumask/test_global_mask_no_null_check:OK
#98/32   cpumask/test_global_mask_rcu_no_null_check:OK
#98/33   cpumask/test_invalid_nested_array:OK
#98/34   cpumask/test_populate_invalid_destination:OK
#98/35   cpumask/test_populate_invalid_source:OK
#98      cpumask:OK
Summary: 1/35 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t percpu_alloc
#288/1   percpu_alloc/array:OK
#288/2   percpu_alloc/array_sleepable:OK
#288/3   percpu_alloc/cgrp_local_storage:OK
#288/4   percpu_alloc/failure_tests:OK
#288/5   percpu_alloc/test_array_map_1:OK
#288/6   percpu_alloc/test_array_map_2:OK
#288/7   percpu_alloc/test_array_map_3:OK
#288/8   percpu_alloc/test_array_map_4:OK
#288/9   percpu_alloc/test_array_map_5:OK
#288/10  percpu_alloc/test_array_map_6:OK
#288/11  percpu_alloc/test_array_map_7:OK
#288/12  percpu_alloc/test_array_map_8:OK
#288/13  percpu_alloc/cpu_flag_percpu_array:OK
#288/14  percpu_alloc/cpu_flag_percpu_hash:OK
#288/15  percpu_alloc/cpu_flag_lru_percpu_hash:OK
#288/16  percpu_alloc/cpu_flag_percpu_cgroup_storage:OK
#288/17  percpu_alloc/cpu_flag_array:OK
#288/18  percpu_alloc/cpu_flag_hash:OK
#288     percpu_alloc:OK
Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t iters
#162/1   iters/force_clang_to_emit_btf_for_externs:OK
#162/2   iters/create_and_destroy:OK
#162/3   iters/create_and_forget_to_destroy_fail:OK
#162/4   iters/destroy_without_creating_fail:OK
#162/5   iters/compromise_iter_w_direct_write_fail:OK
#162/6   iters/compromise_iter_w_direct_write_and_skip_destroy_fail:OK
#162/7   iters/compromise_iter_w_helper_write_fail:OK
#162/8   iters/leak_iter_from_subprog_fail:OK
#162/9   iters/valid_stack_reuse:OK
#162/10  iters/double_create_fail:OK
#162/11  iters/double_destroy_fail:OK
#162/12  iters/next_without_new_fail:OK
#162/13  iters/next_after_destroy_fail:OK
#162/14  iters/read_from_iter_slot_fail:OK
#162/15  iters/stacksafe_should_not_conflate_stack_spill_and_iter:OK
#162/16  iters/force_clang_to_emit_btf_for_externs:OK
#162/17  iters/consume_first_item_only:OK
#162/18  iters/missing_null_check_fail:OK
#162/19  iters/wrong_sized_read_fail:OK
#162/20  iters/simplest_loop:OK
#162/21  iters/widening_stack_size_bug:OK
#162/22  iters/iter_err_unsafe_c_loop:OK
#162/23  iters/iter_err_unsafe_asm_loop:OK
#162/24  iters/iter_err_too_permissive1:OK
#162/25  iters/iter_err_too_permissive2:OK
#162/26  iters/iter_err_too_permissive3:OK
#162/27  iters/delayed_read_mark:OK
#162/28  iters/delayed_precision_mark:OK
#162/29  iters/loop_state_deps1:OK
#162/30  iters/loop_state_deps2:OK
#162/31  iters/loop_state_deps3:OK
#162/32  iters/triple_continue:OK
#162/33  iters/widen_spill:OK
#162/34  iters/absent_mark_in_the_middle_state:OK
#162/35  iters/absent_mark_in_the_middle_state2:OK
#162/36  iters/absent_mark_in_the_middle_state3:OK
#162/37  iters/iter_while_loop:OK
#162/38  iters/iter_while_loop_auto_cleanup:OK
#162/39  iters/iter_for_loop:OK
#162/40  iters/iter_bpf_for_each_macro:OK
#162/41  iters/iter_bpf_for_macro:OK
#162/42  iters/iter_pragma_unroll_loop:OK
#162/43  iters/iter_manual_unroll_loop:OK
#162/44  iters/iter_multiple_sequential_loops:OK
#162/45  iters/iter_limit_cond_break_loop:OK
#162/46  iters/iter_obfuscate_counter:OK
#162/47  iters/iter_search_loop:OK
#162/48  iters/iter_array_fill:OK
#162/49  iters/iter_nested_iters:OK
#162/50  iters/iter_nested_deeply_iters:OK
#162/51  iters/iter_subprog_iters:OK
#162/52  iters/iter_tricky_but_fine:OK
#162/53  iters/iter_stack_array_loop:OK
#162/54  iters/iter_pass_iter_ptr_to_subprog:OK
#162/55  iters/checkpoint_states_deletion:OK
#162/56  iters/iter_arr_with_actual_elem_count:OK
#162/57  iters/iter_subprog_check_stacksafe:OK
#162/58  iters/iter_new_bad_arg:OK
#162/59  iters/iter_next_bad_arg:OK
#162/60  iters/iter_destroy_bad_arg:OK
#162/61  iters/clean_live_states:OK
#162/62  iters/absent_mark_in_the_middle_state4:OK
#162/63  iters/stack_misc_vs_scalar_in_a_loop:OK
#162/64  iters/iter_css_task_for_each:OK
#162/65  iters/cgroup_id_printer:OK
#162/66  iters/iter_css_task_for_each_sleep:OK
#162/67  iters/iter_next_trusted:OK
#162/68  iters/iter_next_trusted_or_null:OK
#162/69  iters/iter_next_rcu:OK
#162/70  iters/iter_next_rcu_or_null:OK
#162/71  iters/iter_next_rcu_not_trusted:OK
#162/72  iters/iter_next_ptr_mem_not_trusted:OK
#162/73  iters/iter_ret_rcu_test_protected:OK
#162/74  iters/iter_ret_rcu_test_type:OK
#162/75  iters/iter_ret_rcu_test_protected_nostruct:OK
#162/76  iters/iter_ret_rcu_test_type_nostruct:OK
#162/77  iters/testmod_seq_empty:OK
#162/78  iters/testmod_seq_full:OK
#162/79  iters/testmod_seq_truncated:OK
#162/80  iters/testmod_seq_getter_before_bad:OK
#162/81  iters/testmod_seq_getter_after_bad:OK
#162/82  iters/testmod_seq_getter_good:OK
#162/83  iters/num:OK
#162/84  iters/testmod_seq:OK
#162/85  iters/task_vma:OK
#162/86  iters/task:OK
#162/87  iters/css_task:OK
#162/88  iters/css:OK
#162/89  iters/iter_tasks_without_lock:OK
#162/90  iters/iter_css_without_lock:OK
#162/91  iters/iter_tasks_lock_and_unlock:OK
#162/92  iters/iter_css_lock_and_unlock:OK
#162/93  iters/iter_css_task_for_each:OK
#162     iters:OK
Summary: 1/93 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t struct_ops_private_stack
#468/1   struct_ops_private_stack/private_stack:OK
#468/2   struct_ops_private_stack/private_stack_fail:OK
#468/3   struct_ops_private_stack/private_stack_recur:OK
#468     struct_ops_private_stack:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t exceptions
#113/1   exceptions/exception_throw_always_1:OK
#113/2   exceptions/exception_throw_always_2:OK
#113/3   exceptions/exception_throw_unwind_1:OK
#113/4   exceptions/exception_throw_unwind_2:OK
#113/5   exceptions/exception_throw_default:OK
#113/6   exceptions/exception_throw_default_value:OK
#113/7   exceptions/exception_tail_call:OK
#113/8   exceptions/exception_ext:OK
#113/9   exceptions/exception_ext_mod_cb_runtime:OK
#113/10  exceptions/exception_throw_subprog:OK
#113/11  exceptions/exception_assert_nz_gfunc:OK
#113/12  exceptions/exception_assert_zero_gfunc:OK
#113/13  exceptions/exception_assert_neg_gfunc:OK
#113/14  exceptions/exception_assert_pos_gfunc:OK
#113/15  exceptions/exception_assert_negeq_gfunc:OK
#113/16  exceptions/exception_assert_poseq_gfunc:OK
#113/17  exceptions/exception_assert_nz_gfunc_with:OK
#113/18  exceptions/exception_assert_zero_gfunc_with:OK
#113/19  exceptions/exception_assert_neg_gfunc_with:OK
#113/20  exceptions/exception_assert_pos_gfunc_with:OK
#113/21  exceptions/exception_assert_negeq_gfunc_with:OK
#113/22  exceptions/exception_assert_poseq_gfunc_with:OK
#113/23  exceptions/exception_bad_assert_nz_gfunc:OK
#113/24  exceptions/exception_bad_assert_zero_gfunc:OK
#113/25  exceptions/exception_bad_assert_neg_gfunc:OK
#113/26  exceptions/exception_bad_assert_pos_gfunc:OK
#113/27  exceptions/exception_bad_assert_negeq_gfunc:OK
#113/28  exceptions/exception_bad_assert_poseq_gfunc:OK
#113/29  exceptions/exception_bad_assert_nz_gfunc_with:OK
#113/30  exceptions/exception_bad_assert_zero_gfunc_with:OK
#113/31  exceptions/exception_bad_assert_neg_gfunc_with:OK
#113/32  exceptions/exception_bad_assert_pos_gfunc_with:OK
#113/33  exceptions/exception_bad_assert_negeq_gfunc_with:OK
#113/34  exceptions/exception_bad_assert_poseq_gfunc_with:OK
#113/35  exceptions/exception_assert_range:OK
#113/36  exceptions/exception_assert_range_with:OK
#113/37  exceptions/exception_bad_assert_range:OK
#113/38  exceptions/exception_bad_assert_range_with:OK
#113/39  exceptions/exception_throw_from_void_global:OK
#113/40  exceptions/non-throwing fentry -> exception_cb:OK
#113/41  exceptions/throwing fentry -> exception_cb:OK
#113/42  exceptions/non-throwing fexit -> exception_cb:OK
#113/43  exceptions/throwing fexit -> exception_cb:OK
#113/44  exceptions/throwing extension (with custom cb) -> exception_cb:OK
#113/45  exceptions/throwing extension -> global func in exception_cb:OK
#113/46  exceptions/exception_ext_mod_cb_runtime:OK
#113/47  exceptions/throwing extension (with custom cb) -> global func in exception_cb:OK
#113/48  exceptions/exception_ext:OK
#113/49  exceptions/non-throwing fentry -> non-throwing subprog:OK
#113/50  exceptions/throwing fentry -> non-throwing subprog:OK
#113/51  exceptions/non-throwing fentry -> throwing subprog:OK
#113/52  exceptions/throwing fentry -> throwing subprog:OK
#113/53  exceptions/non-throwing fexit -> non-throwing subprog:OK
#113/54  exceptions/throwing fexit -> non-throwing subprog:OK
#113/55  exceptions/non-throwing fexit -> throwing subprog:OK
#113/56  exceptions/throwing fexit -> throwing subprog:OK
#113/57  exceptions/non-throwing fmod_ret -> non-throwing subprog:OK
#113/58  exceptions/non-throwing fmod_ret -> non-throwing global subprog:OK
#113/59  exceptions/non-throwing extension -> non-throwing subprog:OK
#113/60  exceptions/non-throwing extension -> throwing subprog:OK
#113/61  exceptions/non-throwing extension -> non-throwing subprog:OK
#113/62  exceptions/non-throwing extension -> throwing global subprog:OK
#113/63  exceptions/throwing extension -> throwing global subprog:OK
#113/64  exceptions/throwing extension -> non-throwing global subprog:OK
#113/65  exceptions/non-throwing extension -> main subprog:OK
#113/66  exceptions/throwing extension -> main subprog:OK
#113/67  exceptions/reject_exception_cb_type_1:OK
#113/68  exceptions/reject_exception_cb_type_2:OK
#113/69  exceptions/reject_exception_cb_type_3:OK
#113/70  exceptions/reject_exception_cb_type_4:OK
#113/71  exceptions/reject_exception_cb_type_5:OK
#113/72  exceptions/reject_async_callback_throw:OK
#113/73  exceptions/reject_with_lock:OK
#113/74  exceptions/reject_subprog_with_lock:OK
#113/75  exceptions/reject_with_rcu_read_lock:OK
#113/76  exceptions/reject_subprog_with_rcu_read_lock:OK
#113/77  exceptions/reject_with_rbtree_add_throw:OK
#113/78  exceptions/reject_with_reference:OK
#113/79  exceptions/reject_global_subprog_throw_with_reference:OK
#113/80  exceptions/reject_with_cb_reference:OK
#113/81  exceptions/reject_with_cb:OK
#113/82  exceptions/reject_with_subprog_reference:OK
#113/83  exceptions/reject_throwing_exception_cb:OK
#113/84  exceptions/reject_exception_cb_call_global_func:OK
#113/85  exceptions/reject_exception_cb_call_static_func:OK
#113/86  exceptions/reject_multiple_exception_cb:OK
#113/87  exceptions/reject_exception_throw_cb:OK
#113/88  exceptions/reject_exception_throw_cb_diff:OK
#113/89  exceptions/reject_subprog_rcu_lock_throw:OK
#113/90  exceptions/reject_subprog_throw_preempt_lock:OK
#113/91  exceptions/reject_subprog_throw_irq_lock:OK
#113/92  exceptions/reject_set_exception_cb_bad_ret1:OK
#113/93  exceptions/reject_set_exception_cb_bad_ret2:OK
#113/94  exceptions/reject_out_of_range_global_throw:OK
#113/95  exceptions/check_assert_eq_int_min:OK
#113/96  exceptions/check_assert_eq_int_max:OK
#113/97  exceptions/check_assert_eq_zero:OK
#113/98  exceptions/check_assert_eq_llong_min:OK
#113/99  exceptions/check_assert_eq_llong_max:OK
#113/100 exceptions/check_assert_lt_pos:OK
#113/101 exceptions/check_assert_lt_zero:OK
#113/102 exceptions/check_assert_lt_neg:OK
#113/103 exceptions/check_assert_le_pos:OK
#113/104 exceptions/check_assert_le_zero:OK
#113/105 exceptions/check_assert_le_neg:OK
#113/106 exceptions/check_assert_gt_pos:OK
#113/107 exceptions/check_assert_gt_zero:OK
#113/108 exceptions/check_assert_gt_neg:OK
#113/109 exceptions/check_assert_ge_pos:OK
#113/110 exceptions/check_assert_ge_zero:OK
#113/111 exceptions/check_assert_ge_neg:OK
#113/112 exceptions/check_assert_range_s64:OK
#113/113 exceptions/check_assert_range_u64:OK
#113/114 exceptions/check_assert_single_range_s64:OK
#113/115 exceptions/check_assert_single_range_u64:OK
#113/116 exceptions/check_assert_generic:OK
#113/117 exceptions/check_assert_with_return:OK
#113     exceptions:OK
Summary: 1/117 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t verifier_ldsx
#636/1   verifier_ldsx/LDSX, S8:OK
#636/2   verifier_ldsx/LDSX, S8 @unpriv:OK
#636/3   verifier_ldsx/LDSX, S16:OK
#636/4   verifier_ldsx/LDSX, S16 @unpriv:OK
#636/5   verifier_ldsx/LDSX, S32:OK
#636/6   verifier_ldsx/LDSX, S32 @unpriv:OK
#636/7   verifier_ldsx/LDSX, S8 range checking, privileged:OK
#636/8   verifier_ldsx/LDSX, S16 range checking:OK
#636/9   verifier_ldsx/LDSX, S16 range checking @unpriv:OK
#636/10  verifier_ldsx/LDSX, S32 range checking:OK
#636/11  verifier_ldsx/LDSX, S32 range checking @unpriv:OK
#636/12  verifier_ldsx/LDSX, xdp s32 xdp_md->data:OK
#636/13  verifier_ldsx/LDSX, xdp s32 xdp_md->data_end:OK
#636/14  verifier_ldsx/LDSX, xdp s32 xdp_md->data_meta:OK
#636/15  verifier_ldsx/LDSX, tcx s32 __sk_buff->data:OK
#636/16  verifier_ldsx/LDSX, tcx s32 __sk_buff->data_end:OK
#636/17  verifier_ldsx/LDSX, tcx s32 __sk_buff->data_meta:OK
#636/18  verifier_ldsx/LDSX, flow_dissector s32 __sk_buff->data:OK
#636/19  verifier_ldsx/LDSX, flow_dissector s32 __sk_buff->data_end:OK
#636/20  verifier_ldsx/Arena LDSX Disasm:OK
#636/21  verifier_ldsx/Arena LDSX Exception:OK
#636/22  verifier_ldsx/Arena LDSX, S8:OK
#636/23  verifier_ldsx/Arena LDSX, S16:OK
#636/24  verifier_ldsx/Arena LDSX, S32:OK
#636     verifier_ldsx:OK
Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t arena_atomics
#1/1     arena_atomics/add:OK
#1/2     arena_atomics/sub:OK
#1/3     arena_atomics/and:OK
#1/4     arena_atomics/or:OK
#1/5     arena_atomics/xor:OK
#1/6     arena_atomics/cmpxchg:OK
#1/7     arena_atomics/xchg:OK
#1/8     arena_atomics/uaf:OK
#1/9     arena_atomics/load_acquire:OK
#1/10    arena_atomics/store_release:OK
#1       arena_atomics:OK
Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t arena_list
#4/1     arena_list/arena_list_1:OK
#4/2     arena_list/arena_list_1000:OK
#4/3     arena_list/arena_list_1_nonsleepable:OK
#4/4     arena_list/arena_list_1000_nonsleepable:OK
#4       arena_list:OK
Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t arena_htab
#3/1     arena_htab/arena_htab_llvm:OK
#3/2     arena_htab/arena_htab_asm:OK
#3       arena_htab:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t verifier_arena
#584/1   verifier_arena/basic_alloc1_nosleep:OK
#584/2   verifier_arena/basic_alloc2_nosleep:OK
#584/3   verifier_arena/basic_alloc3_nosleep:OK
#584/4   verifier_arena/basic_reserve1_nosleep:OK
#584/5   verifier_arena/basic_reserve2_nosleep:OK
#584/6   verifier_arena/reserve_twice_nosleep:OK
#584/7   verifier_arena/reserve_invalid_region_nosleep:OK
#584/8   verifier_arena/basic_alloc1:OK
#584/9   verifier_arena/basic_alloc2:OK
#584/10  verifier_arena/basic_alloc3:OK
#584/11  verifier_arena/basic_reserve1:OK
#584/12  verifier_arena/basic_reserve2:OK
#584/13  verifier_arena/reserve_twice:OK
#584/14  verifier_arena/reserve_invalid_region:OK
#584/15  verifier_arena/arena_kfuncs_under_bpf_lock:OK
#584/16  verifier_arena/scalar_add_arena_ptr:OK
#584/17  verifier_arena/arena_ptr_add_arena_ptr:OK
#584/18  verifier_arena/scalar_xor_arena_ptr:OK
#584/19  verifier_arena/arena_ptr_add_to_non_arena_ptr:OK
#584/20  verifier_arena/non_arena_ptr_add_to_arena_ptr:OK
#584/21  verifier_arena/check_arena_arg_ret:OK
#584/22  verifier_arena/iter_maps1:OK
#584/23  verifier_arena/iter_maps2:OK
#584/24  verifier_arena/iter_maps3:OK
#584     verifier_arena:OK
#585/1   verifier_arena_globals1/check_reserve1:OK
#585/2   verifier_arena_globals1/check_relocation:OK
#585     verifier_arena_globals1:OK
#586/1   verifier_arena_globals2/check_reserve2:OK
#586     verifier_arena_globals2:OK
#587/1   verifier_arena_large/big_alloc1:OK
#587/2   verifier_arena_large/access_reserved:OK
#587/3   verifier_arena_large/request_partially_reserved:OK
#587/4   verifier_arena_large/free_reserved:OK
#587/5   verifier_arena_large/big_alloc2:OK
#587/6   verifier_arena_large/big_alloc3:OK
#587     verifier_arena_large:OK
Summary: 4/33 PASSED, 0 SKIPPED, 0 FAILED

Thanks,
George
