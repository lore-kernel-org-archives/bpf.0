Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF033F326A
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815241; cv=none; b=AXhBg2Z63O2DqEcJy8XRj+VWks+PzxZc0yeEVw/6wlVLNLwp61QxG3gLEEtiK3uzAsUw2kopYwnPp50yoyz64cymrD9a3RUshiLpRemzjxLCcYRd0JWDLQElMXJSZkodTyCg8vHAwa6avjlY2opkjuqRBwYiJoWAi7gSa7e0PbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815241; c=relaxed/simple;
	bh=7IXLJ3ElHImU7xwnCXVrcoHfxP82y2bp1VOtsqBrpaQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=C+AknQXpuDo3MZnrZdzK5NR8gAdQm/kVX/JXJPx5cBWua+pFQTLMFiDaxigvnQsX8Ytl83ESOZ7u/TPIIAeH2HjXLVS1kCMIn1/y3QwLMG6deT/RltPmrmq2i4P8Ux4sGrSIHmRXaNsZkcqTC7F+9ORb/Irpyx6gI2I3kVMzWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gILMfpgL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gILMfpgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908161F0089B;
	Mon, 12 Oct 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815240;
	bh=fk/pfSmg43HeSNQblxNidgshpvt9YZw70HbavMFs7jA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gILMfpgLtwgGWtF8o1IFjyQ8D4k6xBR9zqHArlWIPIZ+a6MEhHlKct6ULpmWAGCzp
	 SthKwaC/PTvID/Q31BQI37L8OgOvCRoo+1hU0xjPAS+ybOTdlpmdu+zNRYiHSrOckw
	 EPZED6AeZX6poU0LtkZG+vv70oknuawQ4lrIPSByhApEQm92Us7SZAo53F3PH0+zgo
	 Waa2wzDAW1LZdSP3z/hGCGQ3Yn/lr4UfhLCD3OhKZPLKoV7udtBX8LWYIKKBLOnFHZ
	 xOHjAtGKBkPVi2Q3exa98lpQ0UyguwIqns9R7cHpKnFiPM/WfTrliH/scdhbMHCtUM
	 BN3nJ8QEX27kA==
Content-Type: multipart/mixed; boundary="===============1359357869832005222=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a29d33df45253af09ae446ce4890d5d5d43c76fa3448633e6c37b1eac7e1a9f@mail.kernel.org>
In-Reply-To: <20261012133711.4030594-4-memxor@gmail.com>
References: <20261012133711.4030594-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Turn loads of __arena pointer members into arena pointers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 14:27:18 +0000 (UTC)

--===============1359357869832005222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Turn loads of __arena pointer members into arena pointers

TL;DR: The check meant to reject an insn loading an arena member on one path
and another member on a PTR_TO_MEM path may miss it, so path B could silently
load a wrong value (memory safety holds).

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index b2fa7e8bedf3..bbb653df6b6f 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -870,6 +870,36 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,

[ ... ]

> +static int arena_member_fixup(struct bpf_verifier_env *env, int idx, struct bpf_insn *insn,
> +			      struct bpf_insn *buf)
> +{
> +	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
> +	int cnt = 0;
> +	u32 base;
> +
> +	if (!aux->arena_member)
> +		return 0;
> +	if (aux->non_arena_member) {
> +		verbose(env, "an insn loads an arena pointer member on one path and a different member on another\n");
> +		return -EINVAL;
> +	}

Does this check catch every path that loads a different member?

non_arena_member is only set from check_ptr_to_btf_access(), after the walk
returns something other than PTR_TO_ARENA:

    if (ret == PTR_TO_ARENA)
        return check_arena_member_load(env, regs, value_regno, flag, tname, field_name);
    if (atype == BPF_READ && value_regno >= 0)
        env->insn_aux_data[env->insn_idx].non_arena_member = true;

A plain BPF_LDX is verified with allow_trust_mismatch set, and
save_aux_ptr_type() merges PTR_TO_BTF_ID on one path with PTR_TO_MEM on
another:

    if (allow_trust_mismatch &&
        bpf_is_ptr_to_mem_or_btf_id(type) &&
        bpf_is_ptr_to_mem_or_btf_id(*prev_type)) {
        *prev_type = merge_ptr_types(type, *prev_type);

The PTR_TO_MEM path is handled in check_mem_access() by the
base_type(reg->type) == PTR_TO_MEM branch (check_mem_region_access() +
mark_reg_unknown()) and never reaches check_ptr_to_btf_access(), so it never
sets non_arena_member.

Consider a struct_ops program with an arena, where r6 is the trusted args
pointer on one path and PTR_TO_MEM on the other.  The second case can come
from a bpf_ringbuf_reserve() sample, bpf_rdonly_cast(p, 0), or a load of a
non-struct pointer member (WALK_PTR_UNTRUSTED -> PTR_TO_MEM | MEM_RDONLY |
PTR_UNTRUSTED).  Both paths reach:

    r0 = *(u64 *)(r6 + 0)

Path A sets arena_member.  Path B is merged into ptr_type as PTR_TO_MEM
(possibly with MEM_RDONLY | PTR_UNTRUSTED).  In bpf_convert_ctx_accesses()
that ptr_type goes to the default case, and arena_member_fixup() then sees
arena_member && !non_arena_member, so it appends:

    w0 -= lo32(kern_vm_start)

(and the JEQ for a __nullable member) to the shared insn.

At runtime the value loaded on path B is silently replaced with
(u32)(val - lo32(kern_vm_start)).  The verifier still models it as an unknown
scalar, so memory safety holds, but the program reads a wrong value and is
accepted, rather than rejected as the commit message describes:

> an insn that loaded an arena pointer member on one path and a different
> member on another is rejected by the fixup pass

Would it work to reject in arena_member_fixup() when base_type(aux->ptr_type)
!= PTR_TO_BTF_ID, since a merge with PTR_TO_MEM leaves PTR_TO_MEM there?
Alternatively, non_arena_member could be set for every BPF_READ with
value_regno >= 0 that does not go through check_ptr_to_btf_access().

No later patch in the series changes this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38258617362
--===============1359357869832005222==--
