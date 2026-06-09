Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0FD2DC357
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011896; cv=none; b=DTAwZaMYCKYFTSFq5+QqjJWRd3QNvg413+xXTd+6ZRmIWUfIme/hnCI+H7ZJ/cb8toUHA5pqN0rUSg0I+ATXsP1qGSStnVwJyJh3QuCtwpTAZn8aMe1ILn2wMQLWfMscdrlIZpzKqbhKy3yWllzHQKfVqrB4E4+FzjkzjRGNPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011896; c=relaxed/simple;
	bh=0xmxjg2IS734s9yoc13ENxvliZkD+iq5DTK2xBvHsas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtLET4kN8zt/h8uBpo97DVJulC5hL/vV8DNoOc+qjUIE3c7GLtrUG/RMm05QOHECe3hmFyL7cYaIvFNs2LYz9nCghLhZbqDi3FHv+o+tGppu8MzTR0blG8uRiLfe38+dOrye+AGkBRW3tNRliylt9YyZU5o9IDUEjgJALWnMGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESYeSx2k; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESYeSx2k"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bf046d4da1fso575691666b.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011893; x=1781616693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiRd0MLm7uHtPsSz2dkGgoU4DM2pIWpC6QKa5ae9i8A=;
        b=ESYeSx2kbKlDTqkAX9DwiUhf4XemA6XOU4vw1bMnuHYGIaHR0DKQ1AYZShhxXizoi2
         ljhHZuFVWh1FTkh9ZR4fX8Wi1XqsUAEVShjh5J0oktyykNiXoasIP5vS8cQvrBvnnn98
         jsW8Es9VAJENz4/6YwXAP1OQOo6P4JWVQrRLca2zarAvZSxou1+6UP7kc+bYoqWTRfs7
         +UbYbTD1ucNcfhZTKXRwtjRbYAZ4sodO11HlJIhwaGgHhKJkKb8ZhH2r+Lvg7bUymTtT
         aBOeqcAYkiQA7mBjgIHblp85QMYf0RfTWULDjsjhhf5WWHmFLCQXAkkUbncIjbbyz9Ik
         Xccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011893; x=1781616693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiRd0MLm7uHtPsSz2dkGgoU4DM2pIWpC6QKa5ae9i8A=;
        b=MuzT1MVnOnlc5RSUnPX+iqfjaMjHtu5M+eMAUwaTvuUqGEQFVX52sa+iF3GL8XtA4p
         T4Cd4+53fRjCSnh6ShMWytsVcvsceUw8CtEvmk4DB9rVdKx+Y+ZZpcd5MhgtAjOSb9Sf
         ntJUHANhPHSUDvR9HPNxMBbcUFlWoHV8pmFAmpqeoWQ09W6oFdeXGx0Kwkgos4Y+rAkq
         hQsopmhN+z59jlgksIz0lx9wZ93R3eSRghLdOH8bSru1L0thw5RoIq5kUXSZ+K0JRJCH
         ygtwWEaYes2+d3x/7ajri22UZ0mkFM3JEH0o5KxYgeSPs0l3GTYeod33u1bWnxE5yPPN
         iOtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wKAXoBMwfQqh4OZGrkIr4WlQrZ8crHK3yFLr/iBR4/tIRmEo8vt5f0JNym+8nq7StTfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXZBd2UMBdEZv5B1RnupUPoeGJp1tAE2NGdz32RiWxS9mkawH
	FaZpaI1K9aj/07rtGsrQwwIJYI7P0Z35MqUPuQmCtOyhirbV0mE1Egzlk8yxL/xm
X-Gm-Gg: Acq92OHQXS1qqSbVuZnodu8j83KV1fddkt8+U44D2/i9LZLMBKUqb7Epq9/bILPi4rs
	N/M22kAMCU/tO0f/3vjw8+m1hPKqEo3Iq6Rg9FDxh5k+JbZA4LJbEWOTiIE8wKBvKGytSjHCdb7
	oh4LaVbx9EvC0Ui2W/HE43d4IpWEQoV9+co7KEZ2I3qmLR6G4weF6C/i/EpIwW7yqYDYlByU2/w
	4rBENeGaDrtsjF1FDaXtoBu5c8PPJiJdF+9X3+iXJyihoQh8SgJflCARcSVOVOCHCGGN0ezvKOS
	99HMsPWnCyxGeV7Ld5D6IGCEq0OHZzlDW4yZH3OVGJZ7yQ2GXy8aohjoCS8vitRZnyLzQr7PFUo
	7gR9mmUkJU8rGyZ12OArzbATkd2RPPsBkYQ8wIZuXNTjCsLzjw0VuJuDewjyDcl9wV5jxHpsFgo
	Rhvl32MexOl8f70s5GGAQYSNvYWVYXknEI0e564nH6HWtOp+fzfoL+1FD5NMwT0McEbLmNqLM4c
	jWRD89ABZVOQMHBsdbtGw==
X-Received: by 2002:a17:907:c244:b0:bec:ef6d:f5be with SMTP id a640c23a62f3a-bf373af9fd1mr915623366b.46.1781011892490;
        Tue, 09 Jun 2026 06:31:32 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055305d40sm1031052366b.45.2026.06.09.06.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:31:32 -0700 (PDT)
Message-ID: <6461e40c-d5a9-41a5-aaba-bf063de67d3f@gmail.com>
Date: Tue, 9 Jun 2026 14:31:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Reject bpf_obj_drop() from tracing
 progs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Justin Suess <utilityemal77@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com,
 kernel-team@meta.com
References: <20260609093719.2858096-1-memxor@gmail.com>
 <20260609093719.2858096-2-memxor@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260609093719.2858096-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/26 10:37 AM, Kumar Kartikeya Dwivedi wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
> bpf_obj_drop() runs bpf_obj_free_fields() synchronously for
> program-allocated objects. When such an object contains NMI unsafe
> fields, a non-iterator tracing program can reach that destruction from
> arbitrary instrumented context, including NMI.
> 
> NMI is likely one instance of this problem, and other instances would
> include possible unsafe reentrancy. Deferring bpf_obj_drop() is not
> appealing either: it would add delayed-free machinery to a release
> operation that otherwise has straightforward synchronous ownership
> semantics.
> 
> Reject bpf_obj_drop() and bpf_percpu_obj_drop() from tracing programs
> unless every field in the object's BTF record is explicitly NMI safe.
> Note that while bpf_rb_root and bpf_list_head would be NMI safe on their
> own to free, the objects recursively held by them may not be; be
> conservative and just mark them as not NMI safe for now.
> 
> Use a whitelist for the NMI-safe field set instead of listing only known
> NMI unsafe fields. Locks, async fields, unreferenced kptrs, and
> refcounts are known to be NMI safe because their destruction is either a
> no-op, simple state reset, or async cancellation. Referenced kptrs,
> percpu referenced kptrs, uptrs, graph roots, graph nodes, and any future
> field type are rejected until audited for arbitrary tracing and NMI
> contexts. This is less susceptible to future changes in fields that were
> previously safe by exclusion, and to new fields being added without
> updating this check.
> 
> Convert the existing recursive local-object drop success case to a
> syscall program in the same commit, since this verifier change makes the
> old tracing program form invalid. The test still exercises
> bpf_obj_drop() releasing a referenced task kptr from a safe program
> type.
> 
> Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h                           | 29 +++++++++++++
>  kernel/bpf/verifier.c                         | 16 +++++++
>  .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++++++++++++-
>  .../selftests/bpf/progs/task_kfunc_success.c  | 13 +++---
>  4 files changed, 92 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 62bba7a4876f..0654d2ffadc1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -492,6 +492,35 @@ static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_f
>  	return rec->field_mask & type;
>  }
>  
> +static inline bool btf_field_is_nmi_safe(enum btf_field_type type)
> +{
> +	switch (type) {
> +	case BPF_SPIN_LOCK:
> +	case BPF_RES_SPIN_LOCK:
> +	case BPF_TIMER:
> +	case BPF_WORKQUEUE:
> +	case BPF_TASK_WORK:
> +	case BPF_KPTR_UNREF:
> +	case BPF_REFCOUNT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline bool btf_record_has_nmi_unsafe_fields(const struct btf_record *rec)
> +{
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return false;
> +	for (i = 0; i < rec->cnt; i++) {
> +		if (!btf_field_is_nmi_safe(rec->fields[i].type))
> +			return true;
> +	}
> +	return false;
> +}
> +

Do we need this stuff in the header file? Why not put it into the verifier.c?

>  static inline void bpf_obj_init(const struct btf_record *rec, void *obj)
>  {
>  	int i;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce..3b43e2bd0f2a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -205,6 +205,7 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int id);
>  static int release_reference(struct bpf_verifier_env *env, int id);
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
> +static bool is_tracing_prog_type(enum bpf_prog_type type);
>  static int ref_set_non_owning(struct bpf_verifier_env *env,
>  			      struct bpf_reg_state *reg);
>  static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
> @@ -12881,6 +12882,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			    int *insn_idx_p)
>  {
>  	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
> +	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>  	struct bpf_reg_state *regs = cur_regs(env);
>  	const char *func_name, *ptr_type_name;
>  	const struct btf_type *t, *ptr_type;
> @@ -12957,6 +12959,20 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	if (err < 0)
>  		return err;
>  
> +	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
> +	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_type(prog_type) ||

We have sleepable tracepoints, are we going to reject them as well? I wonder if there is a better way
to detect NMI context in verifier.

> +	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracing progs. */
> +	     (prog_type == BPF_PROG_TYPE_TRACING && env->prog->expected_attach_type != BPF_TRACE_ITER))) {
> +		struct btf_struct_meta *struct_meta;
> +
> +		struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
> +		if (struct_meta && btf_record_has_nmi_unsafe_fields(struct_meta->record)) {
> +			verbose(env, "%s cannot be used in tracing programs on types with NMI unsafe fields\n",
> +				func_name);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	if (is_bpf_rbtree_add_kfunc(meta.func_id)) {
>  		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
>  					 set_rbtree_add_callback_state);
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> index 83b90335967a..e6e95c1416e6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> @@ -68,6 +68,36 @@ static void run_success_test(const char *prog_name)
>  	task_kfunc_success__destroy(skel);
>  }
>  
> +static void run_syscall_success_test(const char *prog_name)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct task_kfunc_success *skel;
> +	struct bpf_program *prog;
> +	int err;
> +
> +	skel = open_load_task_kfunc_skel();
> +	if (!ASSERT_OK_PTR(skel, "open_load_skel"))
> +		return;
> +
> +	if (!ASSERT_OK(skel->bss->err, "pre_run_err"))
> +		goto cleanup;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +		goto cleanup;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(opts.retval, 0, "retval"))
> +		goto cleanup;
> +
> +	ASSERT_OK(skel->bss->err, "post_run_err");
> +
> +cleanup:
> +	task_kfunc_success__destroy(skel);
> +}
> +
>  static int run_vpid_test(void *prog_name)
>  {
>  	struct task_kfunc_success *skel;
> @@ -140,7 +170,6 @@ static const char * const success_tests[] = {
>  	"test_task_acquire_release_argument",
>  	"test_task_acquire_release_current",
>  	"test_task_acquire_leave_in_map",
> -	"test_task_xchg_release",
>  	"test_task_map_acquire_release",
>  	"test_task_current_acquire_release",
>  	"test_task_from_pid_arg",
> @@ -151,6 +180,10 @@ static const char * const success_tests[] = {
>  	"test_task_kfunc_flavor_relo_not_found",
>  };
>  
> +static const char * const syscall_success_tests[] = {
> +	"test_task_xchg_release",
> +};
> +
>  static const char * const vpid_success_tests[] = {
>  	"test_task_from_vpid_current",
>  	"test_task_from_vpid_invalid",
> @@ -167,6 +200,13 @@ void test_task_kfunc(void)
>  		run_success_test(success_tests[i]);
>  	}
>  
> +	for (i = 0; i < ARRAY_SIZE(syscall_success_tests); i++) {
> +		if (!test__start_subtest(syscall_success_tests[i]))
> +			continue;
> +
> +		run_syscall_success_test(syscall_success_tests[i]);
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(vpid_success_tests); i++) {
>  		if (!test__start_subtest(vpid_success_tests[i]))
>  			continue;
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> index 5fb4fc19d26a..d63a79ee33dc 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> @@ -140,17 +140,17 @@ int BPF_PROG(test_task_acquire_leave_in_map, struct task_struct *task, u64 clone
>  	return 0;
>  }
>  
> -SEC("tp_btf/task_newtask")
> -int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
> +SEC("syscall")
> +int test_task_xchg_release(const void *ctx)
>  {
> -	struct task_struct *kptr, *acquired;
> +	struct task_struct *task, *kptr, *acquired;
>  	struct __tasks_kfunc_map_value *v, *local;
>  	int refcnt, refcnt_after_drop;
>  	long status;
>  
> -	if (!is_test_kfunc_task())
> -		return 0;
> +	(void)ctx;
>  
> +	task = bpf_get_current_task_btf();
>  	status = tasks_kfunc_map_insert(task);
>  	if (status) {
>  		err = 1;
> @@ -191,7 +191,7 @@ int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
>  		return 0;
>  	}
>  
> -	/* Stash a copy into local kptr and check if it is released recursively */
> +	/* Stash a copy into local kptr and check if it is released recursively. */
>  	acquired = bpf_task_acquire(kptr);
>  	if (!acquired) {
>  		err = 7;
> @@ -220,7 +220,6 @@ int BPF_PROG(test_task_xchg_release, struct task_struct *task, u64 clone_flags)
>  	}
>  
>  	bpf_task_release(kptr);
> -
>  	return 0;
>  }
>  

