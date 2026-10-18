Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB935F184
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304640; cv=none; b=m9PZpgDcX1wpinpwWQsiM4A+z9Ye5DUTEsqDNSqna8t/pbwt4CRJBBEV/e9xvNExkfDsV+a1cVfINtHonGquToueLqCbJX6NzFKeOq3rFGdxwobMf3ppANEF3+Nd3hiLDJaKSeOWMECZspgDssN0KlzAd5BBCdtzcKPVG/rz9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304640; c=relaxed/simple;
	bh=ca9EFdmImteOcjpe5yBCxJmpUsSf//J8IIqoyidnIw0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=GUPvLlcq5EjGL6WFVn+jV3y/dj8yQXSYgMRIDo+BnMzE+Wn92lgRG7WhpG5C/SJcZrvDGyU7zGsDGAvcm+6WMu1QdTVuHPvzauhpe56dM1hDSzfJIqG3OMh0CPFsdEzEuhrYv/9DN/CoMyzeWeZtmfB0dPWHYj9QoF2PPNlVKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD6Oq9TO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD6Oq9TO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2DC1F000C4;
	Sun, 18 Oct 2026 06:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792304638;
	bh=sVo1bzDTAekeDKOQrvpCpyMtlXC5YV/323fBMFs1HnA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KD6Oq9TOe1WOx5J3ya72QQCdmbNuR+FdtoCzAdRpIBqJduek7allI4r/xuKtmQOg9
	 KrdcVk+fzv8FEVhvoET/yHHEB//66oWJVAMFWwIlvXQJI2a3/jnLOh4czshLAYfqjN
	 oE1CjkBPW+0pxIIbufwOGbjmbyMOk/SjaN+DZnolsWKj/oNQ2K7JDT76XrKJdml8a5
	 FG/RNfkASO+w1fXckjk4wbHeA3DsJPPiLb0Mw2AW+M7xX+DvNAVqFJQruHRWVdcGRx
	 Nbz6gi4Yi95Ghd5sGbjbz/C+9HcKO2Oei7T3rjPqasB8XsWJ246IlQaPdHoQkhqtBY
	 RdJtY+HWK5H8Q==
Message-ID: <sashiko-outbox-175987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject packet dynptr slices in
 mutating helpers and subprograms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <a49e4bcfaa33c4efd7e2f15e0d8fc117ca254780.1792222148.git.rakukuip@gmail.com>
References: <cover.1792222148.git.rakukuip@gmail.com>
 <a49e4bcfaa33c4efd7e2f15e0d8fc117ca254780.1792222148.git.rakukuip@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 06:23:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] bpf: check_func_arg() rejects packet dynptrs on static subprog=
rams
- [Critical] bpf: bpf_is_kfunc_pkt_changing() omits dynptr probe/user copy =
kfuncs
- [High] bpf: local dynptrs falsely treated as packet-changing in verifier
- [High] bpf: visit_insn() unconditionally marks dynptr writes as pkt-chang=
ing
- [Medium] bpf: check_func_arg() calls dynptr_reg_type() before slot valida=
tion
- [Medium] bpf: check_func_arg() changes error message in packet access sel=
ftest
--

commit f9f5c54032b2d6a161d1ff99ce27d3be9660ce7c
Author: Luxiao Xu <rakukuip@gmail.com>

bpf: Reject packet dynptr slices in mutating helpers and subprograms

This commit rejects passing packet pointers, packet dynptr slices, and
packet dynptrs to helpers, kfuncs, and subprograms that may change packet
data. It also models bpf_dynptr_copy() and bpf_dynptr_memset() as
packet-changing and uses a stack buffer fallback in bpf_dynptr_copy() for
non-linear skb destinations.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index bce7b5abcfda3..9382d1d821291 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -598,7 +598,8 @@ static int visit_insn(int t, struct bpf_verifier_env =
*env)
>  			 */
>  			if (ret =3D=3D 0 && fp->might_sleep)
>  				mark_subprog_might_sleep(env, t);
> -			if (bpf_helper_changes_pkt_data(insn->imm))
> +			if (bpf_helper_changes_pkt_data(insn->imm) ||
> +			    insn->imm =3D=3D BPF_FUNC_dynptr_write)
>  				mark_subprog_changes_pkt_data(env, t);
>  		} else if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>  			struct bpf_call_arg_meta meta;

[Severity: High]
Won't marking any subprogram that calls bpf_dynptr_write(),
bpf_dynptr_copy(), or bpf_dynptr_memset() as changes_pkt_data during CFG
analysis cause regressions for programs that only write to ringbuf or
map-backed local dynptrs?

In visit_insn(), BPF_FUNC_dynptr_write is unconditionally marked via
mark_subprog_changes_pkt_data(). Similarly, for kfuncs in visit_insn():

	ret =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
	...
	if (ret =3D=3D 0 && bpf_is_kfunc_pkt_changing(&meta))
		mark_subprog_changes_pkt_data(env, t);

meta.dynptr_dst_type and meta.dynptr.type are zero at CFG analysis time, so
bpf_is_kfunc_pkt_changing() returns true via !type for every
bpf_dynptr_copy() and bpf_dynptr_memset() call regardless of the target
dynptr type.

At the end of bpf_check_cfg(), subprog_info[0].changes_pkt_data is copied
to env->prog->aux->changes_pkt_data:

	env->prog->aux->changes_pkt_data =3D env->subprog_info[0].changes_pkt_data;

This causes several issues when a program only writes to local
(bpf_dynptr_from_mem()) or ringbuf (bpf_ringbuf_reserve_dynptr()) dynptrs:

1. In sock_map_prog_attach_check(), attaching a BPF_SK_SKB_STREAM_PARSER
   program fails if prog->aux->changes_pkt_data is set:

	if (prog && attach_type =3D=3D BPF_SK_SKB_STREAM_PARSER &&
	    prog->aux->changes_pkt_data)
		return -EINVAL;

   Stream parser programs cannot create writable skb dynptrs, yet any
   stream parser using bpf_dynptr_write(), bpf_dynptr_copy(), or
   bpf_dynptr_memset() on a local or ringbuf dynptr will now be rejected on
   attach.

2. In check_attach_btf_id(), a BPF_PROG_TYPE_EXT (freplace) extension
   program is rejected if prog->aux->changes_pkt_data is set while
   tgt_changes_pkt_data is false:

	if (prog->aux->changes_pkt_data && !tgt_changes_pkt_data) {
		bpf_log(log,
			"Extension program changes packet data, while original does not\n");
		return -EINVAL;
	}

3. A global subprogram that takes a packet pointer, packet slice, or
   read-only packet dynptr and copies data into a ringbuf or map dynptr via
   bpf_dynptr_write() or bpf_dynptr_copy() is marked changes_pkt_data, so
   check_func_arg() rejects passing the packet argument to it and
   check_func_call() invalidates caller packet pointers upon return.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ec136cf377c13..d1a1a37e1f479 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9616,6 +9619,24 @@ static enum bpf_access_type func_arg_access_type(e=
num bpf_arg_type arg_type)
>  	return BPF_READ | BPF_WRITE;
>  }
> =20
> +static bool helper_changes_pkt_data(struct bpf_verifier_env *env,
> +				    enum bpf_func_id func_id,
> +				    const struct bpf_call_arg_meta *meta)
> +{
> +	if (bpf_helper_changes_pkt_data(func_id))
> +		return true;
> +
> +	if (func_id =3D=3D BPF_FUNC_dynptr_write) {
> +		enum bpf_dynptr_type type =3D meta->dynptr_dst_type ?: meta->dynptr.ty=
pe;
> +
> +		return type =3D=3D BPF_DYNPTR_TYPE_SKB ||
> +		       type =3D=3D BPF_DYNPTR_TYPE_SKB_META ||
> +		       (type =3D=3D BPF_DYNPTR_TYPE_LOCAL && env->cur_state->curframe);
> +	}
> +
> +	return false;
> +}
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slo=
t, u32 prev_slot,
>  			  struct bpf_call_arg_meta *meta,
>  			  int insn_idx)
> @@ -9903,6 +9924,22 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg, u32 slot, u32 p
>  		enum bpf_access_type access_type;
>  		bool known_memory;
> =20
> +		/*
> +		 * PTR_TO_PACKET gets passed as PTR_TO_MEM, preventing us from adjusti=
ng
> +		 * bounds tracking information.
> +		 */
> +		if (((is_subprog(meta) && meta->subprog_may_change_pkt) ||
> +		     (is_kfunc(meta) ? bpf_is_kfunc_pkt_changing(meta) :
> +				       helper_changes_pkt_data(env, meta->func_id, meta))) &&
> +		    (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))) {
> +			verbose(env,
> +				"cannot pass packet pointer %s to %s(): function may change packet d=
ata\n",
> +				reg_arg_name(env, argno),
> +				is_subprog(meta) ? meta->func_name :
> +				(is_kfunc(meta) ? meta->func_name : func_id_name(meta->func_id)));
> +			return -EINVAL;
> +		}

[Severity: Medium]
Does intercepting reg_is_pkt_pointer_any(reg) here break the
test11_cls_unsuitable_helper_1 selftest in
tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c?

That test passes PTR_TO_PACKET in R3 to bpf_skb_store_bytes() and asserts
on the error message from check_helper_mem_access():

	SEC("tc")
	__description("helper access to packet: test11, cls unsuitable helper 1")
	__failure __msg("function access to the packet")
	__naked void test11_cls_unsuitable_helper_1(void)

Because check_func_arg() now rejects reg_is_pkt_pointer_any(reg) before
check_helper_mem_access() runs, the verifier emits "cannot pass packet
pointer R3 to bpf_skb_store_bytes(): function may change packet data"
instead of "function access to the packet is not allowed".

> +
>  		/* The access to this pointer is only checked when we hit the
>  		 * next is_mem_size argument below.
>  		 */
[ ... ]
> @@ -10005,6 +10032,17 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg, u32 slot, u32 p
>  		break;
>  	}
>  	case ARG_PTR_TO_DYNPTR: {
> +		enum bpf_dynptr_type dynptr_type =3D dynptr_reg_type(env, reg);
> +
> +		if (is_subprog(meta) && meta->subprog_may_change_pkt &&
> +		    (dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB ||
> +		     dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB_META ||
> +		     dynptr_type =3D=3D BPF_DYNPTR_TYPE_XDP)) {
> +			verbose(env,
> +				"cannot pass packet dynptr %s to %s(): function may change packet da=
ta\n",
> +				reg_arg_name(env, argno), meta->func_name);
> +			return -EINVAL;
> +		}

[Severity: Critical]
Should this check be restricted to global subprograms rather than all
is_subprog(meta) calls?

In btf_prepare_func_args(), struct bpf_dynptr * parameters are translated
to ARG_PTR_TO_DYNPTR for both global and static subprograms. When
check_func_call() verifies a call to a static subprogram, it first invokes
btf_check_subprog_call() -> btf_check_func_arg_match() -> check_func_arg()
with meta->btf set and meta->subprog_may_change_pkt =3D sub->changes_pkt_da=
ta:

	err =3D btf_check_func_arg_match(env, subprog, btf);
	/* Compiler optimizations can remove arguments from static functions
	 * or mismatched type can be passed into a global function.
	 * In such cases mark the function as unreliable from BTF point of view.
	 */
	if (err)
		prog->aux->func_info_aux[subprog].unreliable =3D true;
	return err;

Because static subprograms are verified inline by check_static_func_call()
with the caller's exact stack state, passing a packet dynptr to a static
subprogram is safe. However, returning -EINVAL here marks the static
subprogram as BTF-unreliable.

Worse, if the static subprogram takes stack arguments (more than 5 argument
slots, so bpf_in_stack_arg_cnt(subprog) > 0), setting unreliable =3D true on
the first call causes btf_check_subprog_call() on any subsequent call to
return -EINVAL immediately at the top of the function before
btf_check_func_arg_match() can run check_outgoing_stack_args():

	if (prog->aux->func_info_aux[subprog].unreliable)
		return -EINVAL;

When check_static_func_call() then steps into the static subprogram and
executes an r11 stack argument read, check_stack_arg_read() dereferences
caller->stack_arg_regs[spi] without check_outgoing_stack_args() having
validated caller->out_stack_arg_cnt or allocated caller->stack_arg_regs:

	if (spi + 1 > bpf_in_stack_arg_cnt(subprog)) {
		verbose(env, "invalid read from stack arg off %d depth %d\n",
			off, bpf_in_stack_arg_cnt(subprog) * BPF_REG_SIZE);
		return -EACCES;
	}

	caller =3D vstate->frame[vstate->curframe - 1];
	arg =3D &caller->stack_arg_regs[spi];
	cur =3D vstate->frame[vstate->curframe];
	bpf_diag_mod_begin(env, &cur->regs[dst_regno], arg, BPF_DIAG_MOD_WRITE);
	cur->regs[dst_regno] =3D *arg;

If a second caller did not write outgoing stack arguments,
caller->stack_arg_regs is NULL (causing a NULL pointer dereference) or
smaller than spi (causing an out-of-bounds read).

---

[Severity: Medium]
Also in check_func_arg() under case ARG_PTR_TO_DYNPTR, is it safe to call
dynptr_reg_type(env, reg) before process_dynptr_func() validates the stack
slot?

dynptr_reg_type() looks up the stack slot and reads
spilled_ptr.dynptr.type directly from the anonymous union in struct
bpf_reg_state:

	spi =3D dynptr_get_spi(env, reg);
	if (spi < 0)
		return BPF_DYNPTR_TYPE_INVALID;
	state =3D bpf_func(env, reg);
	return bpf_stack_slot(state, spi)->spilled_ptr.dynptr.type;

If reg is not an initialized dynptr (for example, MEM_UNINIT or a stack
slot holding a non-dynptr spilled register where mem_size or another union
member happens to equal 3, 4, or 5), dynptr_reg_type() will read that union
field as BPF_DYNPTR_TYPE_SKB, BPF_DYNPTR_TYPE_XDP, or
BPF_DYNPTR_TYPE_SKB_META before process_dynptr_func() checks
is_dynptr_reg_valid_init(). In addition, if dynptr_get_spi() fails on a bad
stack offset, calling it here and then again inside process_dynptr_func()
will log duplicate error messages.

>  		if (is_bpf_dynptr_clone_kfunc(meta) &&
>  		    (arg_type & MEM_UNINIT)) {
>  			enum bpf_dynptr_type parent_type =3D meta->dynptr.type;
> @@ -12541,7 +12579,8 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  			return -EFAULT;
> =20
>  		if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB ||
> -		    dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB_META)
> +		    dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB_META ||
> +		    (dynptr_type =3D=3D BPF_DYNPTR_TYPE_LOCAL && env->cur_state->curfr=
ame))
>  			/* this will trigger clear_all_pkt_pointers(), which will
>  			 * invalidate all dynptr slices associated with the skb
>  			 */
[ ... ]
> @@ -13592,7 +13635,19 @@ static bool is_kfunc_bpf_preempt_enable(struct b=
pf_call_arg_meta *meta)
> =20
>  bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
>  {
> -	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]);
> +	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]))
> +		return true;
> +
> +	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_copy]) ||
> +	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_memset])) {
> +		enum bpf_dynptr_type type =3D meta->dynptr_dst_type ?: meta->dynptr.ty=
pe;
> +
> +		return !type || type =3D=3D BPF_DYNPTR_TYPE_SKB ||
> +		       type =3D=3D BPF_DYNPTR_TYPE_SKB_META ||
> +		       type =3D=3D BPF_DYNPTR_TYPE_LOCAL;
> +	}
> +
> +	return false;
>  }

[Severity: High]
Why is BPF_DYNPTR_TYPE_LOCAL treated as packet-changing in
bpf_is_kfunc_pkt_changing(), helper_changes_pkt_data(), and
check_helper_call()?

1. In bpf_is_kfunc_pkt_changing(), returning true when type is
   BPF_DYNPTR_TYPE_LOCAL means that during check_kfunc_call():

	if (bpf_is_kfunc_pkt_changing(&meta)) {
		bpf_clear_RET_pkt_reg(env, &regs[BPF_REG_0]);
		clear_all_pkt_pointers(env);
	}

   any call to bpf_dynptr_copy() or bpf_dynptr_memset() writing into a
   map-backed local dynptr (created via bpf_dynptr_from_mem()) will clear
   all active PTR_TO_PACKET pointers and packet dynptr slices, even in the
   main program at curframe =3D=3D 0.

2. In helper_changes_pkt_data() and check_helper_call() for
   BPF_FUNC_dynptr_write, the condition checks:

	(type =3D=3D BPF_DYNPTR_TYPE_LOCAL && env->cur_state->curframe)

   However, global subprograms are verified via do_check_subprogs() ->
   do_check_common() with state->curframe =3D=3D 0:

	state->curframe =3D 0;
	...
	init_func_state(env, state->frame[0],
			BPF_MAIN_FUNC /* callsite */,
			0 /* frameno */,
			subprog);

   Meanwhile, env->cur_state->curframe > 0 holds when verifying static
   subprograms and synchronous callbacks (such as bpf_loop() or
   bpf_for_each_map_elem()) inline via setup_func_entry(), where dynptrs
   keep their actual backing type and BPF_DYNPTR_TYPE_LOCAL is a genuine
   map-backed dynptr. Inside any static subprogram or callback, this check
   falsely rejects bpf_dynptr_write(&map_dynptr, 0, pkt_ptr_or_slice, len, =
0)
   and falsely invalidates all packet pointers across all frames when
   writing to a map-backed dynptr.

   Furthermore, if check_func_arg() already prevents passing packet dynptrs
   to global subprograms that may change packet data, can a
   BPF_DYNPTR_TYPE_LOCAL dynptr in a mutating global subprogram ever be
   backed by a packet?

---

[Severity: Critical]
Are the dynptr probe and user copy kfuncs in kernel/trace/bpf_trace.c also
missing from bpf_is_kfunc_pkt_changing() and __bpf_dynptr_copy()?

Specifically, these eight kfuncs are registered in common_btf_ids for
BPF_PROG_TYPE_UNSPEC (and therefore reachable from networking programs):

- bpf_probe_read_user_dynptr()
- bpf_probe_read_kernel_dynptr()
- bpf_probe_read_user_str_dynptr()
- bpf_probe_read_kernel_str_dynptr()
- bpf_copy_from_user_dynptr()
- bpf_copy_from_user_str_dynptr()
- bpf_copy_from_user_task_dynptr()
- bpf_copy_from_user_task_str_dynptr()

They call __bpf_dynptr_copy() and __bpf_dynptr_copy_str() in
kernel/trace/bpf_trace.c, which fall back to calling __bpf_dynptr_write()
in a loop when bpf_dynptr_slice_rdwr() returns NULL (e.g., on a non-linear
skb dynptr):

	for (off =3D 0; off < size; off +=3D chunk_sz) {
		chunk_sz =3D min_t(u64, sizeof(buf), size - off);
		err =3D copy_fn(buf, unsafe_src + off, chunk_sz, tsk);
		if (err)
			return err;
		err =3D __bpf_dynptr_write(dst, doff + off, buf, chunk_sz, 0);
		if (err)
			return err;
	}

When dst is a non-linear BPF_DYNPTR_TYPE_SKB dynptr, __bpf_dynptr_write()
calls __bpf_skb_store_bytes() -> bpf_try_make_writable(), which can
reallocate skb->head via pskb_expand_head(). Because
bpf_is_kfunc_pkt_changing() does not include these kfuncs,
check_kfunc_call() will not call clear_all_pkt_pointers(), leaving existing
PTR_TO_PACKET pointers and packet dynptr slices pointing to freed skb->head
memory, and allowing bpf_probe_read_kernel_dynptr() or
bpf_probe_read_kernel_str_dynptr() with size > 256 to read from a freed
packet slice on subsequent iterations of the loop.

> =20
>  static u32 kfunc_abi_slots(const struct btf_func_model *fm)
>  {

[ ... ]

>
>
>

=E5=AE=8C=E7=BE=8E (Wait=E2=80=94do not output anything after the blank lin=
e!)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792222148.gi=
t.rakukuip@gmail.com?part=3D1
