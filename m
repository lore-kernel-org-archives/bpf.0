Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845168;
	b=4iwJm9dEK2i1Er+GbyFLGAHBpcgVzMzw50Atl2fIgY6WPHdCyEt0Z49jbGFvL9wZzLbs
	 ch+tp3RZ9JMY8JGqwymGvtndHcq6ehR9uYznb/xQ/nz5A76upXHJHUndub/eiIj9zd40L
	 OO+vTnpzFWJo/m2R8V/qVBppm9RlFLOMSsJOxPBH+QPFt+et4WZACI4gx9YK7YUOekPRj
	 btM895mvuTG5y6QW/Iy7TExGdupFlb04XQzS2k8gHgLZrslTDm8uG4Y0vDxjCYABB05dX
	 SEe+5t5z2f2pmZUwUyp2jXE0OeOW8ykbh9eNRxlH2p+gnGsEbte5Sox2uYI8N07R0Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845168;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jk4f67CP2F8u9guOsap+3oWE34HJGSx2VsHVoJmQcEQ=;
	b=2RczuM5Fnyv/6Wfz4hue1AgMc8rDGnH+JYkAxRbSJ4Zd1YWvFzEMyMKUvhqzXLyScu/U
	 0qgjdngH2EAzhuKr0mFF8oOApQLWF5epCFUoTk+NZukxui9eLoHKiJ20vRGtWx49mv8UP
	 LmWEHu7uIqADW7G81IEMcdO1SRl+K+If3x4Qrl+iTADPox/vjZmiMpXcxMXjsSrS5+D4O
	 URzzrmR13rD/jXc5sREajJIwPWleHvg/KsavMWxfUYcFZByzYfhwnEBVDXY1+hbHox9TJ
	 gOZKbw5w4v3cK3VuiLg7niTVDIhFdz8Z8iBzYi19X+9R70EIG+EHSSc5baRbME37lHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9kJkrdp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B95606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9kJkrdp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB731F000C4;
	Mon, 16 Nov 2026 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845168;
	bh=jk4f67CP2F8u9guOsap+3oWE34HJGSx2VsHVoJmQcEQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=N9kJkrdpWqdDRbw7vvdvp77FLAXWTeP3Pjhb/puQt9Jjiuyhz0Xv9C5fgRlwqWPJn
	 kdbEzYgmgUmVLKeGLTpZV2QUSNmbdYhjmefO0OvO+k9XNP28AO5qVpjxqe1T2HZnAo
	 fFQHaqstVv8TyMlaY1rFTqaSabA1GvOJOC17ZJkIFoP2VGteTaIZ6KWczQF5DcVphv
	 VoN7eMxTFCxZ9hwY12fa4oMxR1YnIT2KcOt6hKNRQ3BxWKsroVQTrEldGLjv7NOkS+
	 0evDLfpoEnCmb1iNNBmMhntJHHiJy6pM3u0zpqZhGx2EinfcCgi0f5O4TR87u+/s0A
	 TD0FePVSRvoEg==
Content-Type: multipart/mixed; boundary="===============8147075745057409316=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7b99ce30e1ddf3a88b7e8066298daf0fc8a4e7e80f51d9123303d08e0c7fc018@mail.kernel.org>
In-Reply-To: <20261116152626.4032587-3-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/21] bpf: Fail the load when there is no memory
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 16:06:07 +0000 (UTC)

--===============8147075745057409316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fail the load when there is no memory

TL;DR:
- Unconverted CO-RE (bpf_core_apply) allocations may still wake the memcg OOM
  killer during load
- Constant-blinding allocations lack a mayfail flag, so ENOMEM-fails-load may
  still hit global OOM
- Commit message overclaims "all allocations"

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -3017,10 +3017,10 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>  	prog = bpf_jit_blind_constants(env, prog);
>  	/*
>  	 * Fall back to the interpreter after blinding failures, except when
> -	 * the loader was killed.
> +	 * the load has to stop or has no memory.
>  	 */
>  	if (IS_ERR(prog)) {
> -		if (PTR_ERR(prog) == -EINTR)
> +		if (PTR_ERR(prog) == -EINTR || (env && PTR_ERR(prog) == -ENOMEM))
>  			return prog;
>  		goto out_restore;
>  	}

The commit message says "Use one mask for all allocations of the verifier",
and this hunk makes -ENOMEM from bpf_jit_blind_constants() fatal for the
load.  Are the allocations inside bpf_jit_blind_constants() covered by that
rule?

  bpf_jit_blind_constants():
    linfo_unblinded = kvmalloc_array(nr_linfo, sizeof(*linfo_unblinded),
                                     GFP_USER);
    ...
    clone = bpf_prog_clone_create(prog, GFP_USER);

  bpf_prog_clone_create():
    gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
    fp = __vmalloc(fp_other->pages * PAGE_SIZE, gfp_flags);

Neither call has __GFP_RETRY_MAYFAIL or __GFP_NOWARN, so under global
memory pressure they can still reach the OOM killer or print an allocation
failure warning before returning the -ENOMEM that now fails the load.

The path is bpf_check() -> __bpf_prog_select_runtime(env, ...) ->
bpf_prog_jit_compile() -> bpf_jit_blind_constants() whenever blinding is
requested (bpf_jit_harden).  bpf_jit_subprogs() reaches the same
allocations for programs with subprogs.  These allocations are not
memcg-charged (bpf_prog_clone_create() does not use bpf_memcg_flags()), so
the memcg case from the commit message is not hit.

Other verifier-path allocations that keep a plain mask are
bpf_jit_add_poke_descriptor() (krealloc_array(..., GFP_KERNEL), called from
bpf_do_misc_fixups()) and the func[] array in jit_subprogs().  The func[]
array is converted later in the series by 8aac70a8f47f ("bpf: Remove
BPF_MAX_SUBPROGS"); bpf_jit_blind_constants() is not converted anywhere in
the series.

Should the env path of bpf_jit_blind_constants() pass
GFP_USER | BPF_GFP_MAYFAIL, as bpf_patch_list_commit() already does for
bpf_prog_realloc()?  Otherwise the commit message could limit its claim to
the GFP_KERNEL_ACCOUNT sites.

> The verifier allocates with GFP_KERNEL_ACCOUNT. At the limit of the memory
> cgroup this wakes up the OOM killer, and the loader dies:
>   memory.max = 64M, program needs 120M
>   before:  Killed
>   after:   bpf() = -ENOMEM
> Use one mask for all allocations of the verifier. Most of the patch is:
>   sed -i 's/GFP_KERNEL_ACCOUNT/BPF_VERIFIER_GFP/'

Can a CO-RE load at memory.max still be OOM-killed from inside the
verifier?  The patch does not convert the GFP_KERNEL_ACCOUNT allocations
reached through:

  bpf_prog_load() -> bpf_check() -> bpf_check_core_relo() ->
    bpf_core_apply()

kernel/bpf/btf.c:bpf_core_apply() {
    ...
	specs = kzalloc_objs(*specs, 3, GFP_KERNEL_ACCOUNT);
    ...
	cands.cands = kzalloc_objs(*cands.cands, cc->cnt, GFP_KERNEL_ACCOUNT);
    ...
}

bpf_core_find_cands() also reaches populate_cand_cache() (kmemdup() and
kmemdup_nul() with GFP_KERNEL_ACCOUNT) and bpf_core_add_cands() (kmalloc()
with GFP_KERNEL_ACCOUNT).

bpf_check_core_relo() runs for every load with attr->core_relo_cnt != 0,
which includes light skeletons and loader programs.  try_charge_memcg()
only skips mem_cgroup_oom() for __GFP_NORETRY or __GFP_RETRY_MAYFAIL:

    if (gfp_mask & __GFP_RETRY_MAYFAIL)
        goto nomem;

None of these masks carries __GFP_RETRY_MAYFAIL, so the memcg OOM killer
can still be woken from the verifier, which is the "Killed" outcome the
commit message says is removed.  The tree at the end of the series still
has GFP_KERNEL_ACCOUNT in bpf_core_apply().

Separately, bpf_prog_verify_signature() converts the "data" kvmalloc() but
leaves sig = kvmemdup_bpfptr(usig, attr->signature_size), which allocates
with GFP_USER | __GFP_NOWARN.  That is not memcg-accounted, so it cannot
cause the memcg kill, but it is another verifier allocation that does not
use the one mask.

Should the bpf_core_apply() and candidate cache allocations be converted to
BPF_VERIFIER_GFP, or should the commit message be narrowed so it does not
claim all allocations of the verifier?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43899902250
--===============8147075745057409316==--
