Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EC4F4D01
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625217; cv=none; b=AExHEpdjkHHlgvT48l6AS4Gy0N5BiEb8D5t0YLtIwdr868mE+kB5YacaYYHk22HIvzbw2RZ+o1CIiAI6MbCdFfbgN+tDVOagN2traUJlCuChRhvK+DfCO4QNnkaDq2WlJo1xgbHKA+swhsUk6NE9+MvVeGoCZ0cewJ+8HzZhWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625217; c=relaxed/simple;
	bh=Zk9v1AgymRlYisZpavaslPz7jkuhdPLECq3wBBDV6KM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TvfL4Yii4J7jh3hm8smchm+6gVSBf0LPlQwvVojpBVQHgJ92/w34CaPcWpFN7d0/26d0MZ8vzUTJ1qZgRzsTEmcKsCXFw6j6cBZ+w1JMQCU4egwSULV1ZOfZpVdEt5vqeiqqCl/8XG2aO2u9qnSqkwpUGSOPZZ5DVyziWlSC0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc8pR24i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc8pR24i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FCB1F000FF;
	Mon, 28 Sep 2026 19:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790625212;
	bh=u5RDhX8rO65XWjw7AcQGtdoDFUUHlO93CrdzLx83feM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Cc8pR24ispe9Nxsskopn872vyGGmqmsVKmhjxXUiRwGEvw9/AJ2cH9eq1ZdhjCxv6
	 MWv3oNr2OyculBETHQjLX9RRrGa4rtdvuNMXZdcpb/wd61j4yOepx+gRTxeHJCuYpq
	 kA9wmZXGUdJOz2RGqJfIGRiF3Y7Johay//GJyXw9IIoD8ifGGtyAcVlGsSmVCcffWo
	 4YOvPzLV4Z3GyiEoF5ZXLqmEhFGc2rpobXrojZwqpPsNjY/1WSwf+kqJ6uejdA9AbR
	 ADn+wsdw48jQh4bP9xNGcOUM88mIa0BkEWqC1ktsKMVA9kFrIJ9eD3M3r8QIcHV9hK
	 d1lIa6vWhUHCg==
Content-Type: multipart/mixed; boundary="===============0151256475181154666=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <caefde4dfb91214529bfacc6bc746d8df5fface2c1587550a29a3575566d0ecb@mail.kernel.org>
In-Reply-To: <20260928185334.1004200-11-ameryhung@gmail.com>
References: <20260928185334.1004200-11-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/11] bpf: Check global subprog memory arguments in the common path
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 19:53:31 +0000 (UTC)

--===============0151256475181154666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 183759f1e014..811342e3c041 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8aa1336453a4..ad18b6ab7e88 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9036,8 +9042,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
>  		type &= ~PTR_MAYBE_NULL;
>  	if (base_type(arg_type) == ARG_PTR_TO_MEM)
>  		type &= ~DYNPTR_TYPE_FLAG_MASK;
> -	/* Allow allocated memory for kfunc ARG_PTR_TO_MEM but not helper. */
> -	if (is_kfunc(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
> +	/* Allow allocated memory for BTF-defined ARG_PTR_TO_MEM but not helpers. */
> +	if (!is_helper(meta) && base_type(arg_type) == ARG_PTR_TO_MEM &&
>  	    type_is_ptr_alloc_obj(type))
>  		type = PTR_TO_MEM;
>

[ ... ]

> @@ -10863,7 +10883,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  	 * verifier sees.
>  	 */
>  	for (arg = 0, slot = 0; arg < btf_type_vlen(func_proto); arg++, slot += nslots) {
> -		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, slot);
>  		enum bpf_arg_type arg_type = fn->arg_type[arg];
>  		argno_t argno = argno_from_arg(slot + 1);
>  		const struct btf_type *t;
> @@ -10875,34 +10894,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
>  		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
>  		    base_type(arg_type) == ARG_PTR_TO_ARENA ||
> -		    base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
> +		    base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
> +		    base_type(arg_type) == ARG_PTR_TO_MEM) {
>  			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
>  			if (ret)
>  				return ret;
> -		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
> -			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
> -			if (ret < 0)
> -				return ret;
> -			if (check_mem_reg(env, reg, argno, sub->args[slot].mem_size,
> -					  BPF_READ | BPF_WRITE, NULL,
> -					  NULL))
> -				return -EINVAL;
> -			/*
> -			 * PTR_TO_PACKET get passed as PTR_TO_MEM, preventing
> -			 * us from adjusting bounds tracking info.
> -			 */
> -			if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) &&
> -			    sub->changes_pkt_data) {
> -				bpf_log(log, "%s is a packet pointer, but func#%d may change packet data\n",
> -						reg_arg_name(env, argno), subprog);
> -				return -EINVAL;
> -			}
> -			if (!(arg_type & PTR_MAYBE_NULL) &&
> -			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
> -				bpf_log(log, "%s is expected to be non-NULL\n",
> -					reg_arg_name(env, argno));
> -				return -EINVAL;
> -			}
>  		} else {
>  			verifier_bug(env, "unrecognized %s type %d",
>  				     reg_arg_name(env, argno), arg_type);

Routing ARG_PTR_TO_MEM through check_func_arg() adds a check_reg_type()
step that wasn't in the old path. The old btf_check_func_arg_match() code
called check_func_arg_reg_off(), then check_mem_reg() which eventually
reached check_ptr_to_btf_access() for PTR_TO_BTF_ID registers.

Does this break PTR_TO_BTF_ID | MEM_RCU? Looking at check_reg_type() in
verifier.c around line 9050, the mem_types array only includes
PTR_TO_BTF_ID | PTR_TRUSTED for the PTR_TO_BTF_ID case. MEM_ALLOC objects
are handled separately by type_is_ptr_alloc_obj() conversion.

Before this patch, check_func_arg_reg_off() accepted PTR_TO_BTF_ID |
MEM_RCU with fixed offset, then check_mem_reg() sent it to
check_ptr_to_btf_access(). For program types with
env->ops->btf_struct_access, the write check was delegated to that
callback since MEM_RCU doesn't satisfy bpf_may_fault_on_deref().

As a concrete example, in sched_ext struct_ops programs:

  struct task_struct *p = scx_bpf_cpu_curr(cpu);
  // or p = scx_bpf_tid_to_task(pid);
  // Both are KF_RCU_PROTECTED | KF_RET_NULL, so after NULL check
  // R0 becomes PTR_TO_BTF_ID | MEM_RCU per the kfunc return handling.

  // Tasks from bpf_for_each(task|scx_dsq, ...) are also MEM_RCU

  __weak int f(u64 *v) { ... }
  f(&p->scx.dsq_vtime);  // or &p->scx.slice

The old code verified this because bpf_scx_btf_struct_access() allows
writes to those specific fields. The new path would reject it in
check_reg_type() with:

  "R1 type=rcu_ptr_task_struct expected=fp, pkt, pkt_meta, map_key,
   map_value, mem, ringbuf_mem, buf, trusted_ptr_, ctx"

Programs that loaded before this patch would fail with "Caller passes
invalid args into func". The commit message says "Preserve their
read-write access check" but this appears to change the acceptance
criteria for BTF pointers.

The existing selftest trusted_btf_field_to_writable_mem confirms that BTF
field pointers passed to global mem args went through
check_ptr_to_btf_access() under the old code path.

Should check_reg_type() continue accepting PTR_TO_BTF_ID | MEM_RCU for
subprog ARG_PTR_TO_MEM and leave the access decision to
check_mem_reg()/check_ptr_to_btf_access()?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36470745096
--===============0151256475181154666==--
