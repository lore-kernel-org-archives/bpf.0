Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426247F786
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048883; cv=none; b=EOuxBOG6v+TmeQZ8vxz3aauH7bjSc8a2g15qpYE66PMQ/R/mFCiv6mlAj42xflIrJpkpI4bYBSbwtzjpAheueJ/VRtcxfga+ccwRqaGFeDrKtv9Hrt7Lupc/JzcSA0Xs/YXAMHx/h38PSKLwD8T/T+idEvgbCfKAGXAWkT1lkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048883; c=relaxed/simple;
	bh=Eg4BlBPGGwNwJ9Rh1W3Bs0H6wmnj2nNQcrtBtsSFCAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EE/VGiiR/EYGwFB0mQCpG7yK89PHE4Idw777vSBClyGHDW72WWDqDQ+SvhfvvRD5BaXjuAXNhAycdBt76NTHlVW3AkcxEqr5TVAEGp2vXgGZK5OM+OO7CoeEfpVS2tVhlkza7YogdU+1AvMKGfTGsDr36BsdhpPPlp/xgtVRKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyCqccTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyCqccTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFA51F000E9;
	Thu,  6 Aug 2026 20:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786048881;
	bh=H/pfQcyCgQmd9XZNq8GVlI2rQsXEFpArGh5fsO5Ul6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KyCqccTfF263JeaM/lj0KArk3M3nUcu15uzgU3lap4NAxnPFIpjH76Fa5MXaYj/yW
	 dhvSCj8GcibAe4dV2+iH3mxgwJ616s6L8B/ByxEwAKFbMffaFuzIzWogUpBsHCQSXA
	 BO19RWpfK2CmOPDsnqkxOrtaTMXKkwsmbNKJgo1O/ajULbve2QUjF4NwR7ML9csrwI
	 rh+eXQk6ZffSNva2vJP3Z00zmvfIJKLiCuu2i9TIgJ7nFOlpklwognwLhYggACIdQf
	 k7ne5SvNYva77Nxl16ieNjKi2oAf6+JNCrHDLvPtNxWDTt/65bBpi5TTRXjMkhPi6A
	 mSAbmaoezcKNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Reject load-acquire from pointers
 requiring fault protection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806201047.333389-1-daniel@iogearbox.net>
References: <20260806201047.333389-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:41:19 +0000
Message-Id: <20260806204121.BCFA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A pre-existing flaw allows merged untrusted pointer types to bypas=
s BPF_PROBE_MEM rewriting for plain BPF_LDX instructions, leading to kernel=
 panics upon NULL pointer dereference.
--

--- Patch [1]: [PATCH bpf-next v2 1/6] bpf: Reject load-acquire from pointe=
rs requiring fault protection ---
commit e15f6fca389dca527ccadeba23f22ab6d2f2f36d
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Reject load-acquire from pointers requiring fault protection

This commit prevents BPF_LOAD_ACQ instructions from using pointer types that
would normally require fault protection (like untrusted pointers or bare
PTR_TO_BTF_ID). Since BPF_LOAD_ACQ is not rewritten to use BPF_PROBE_MEM
by the verifier, a fault from these pointers would panic the kernel
instead of being safely handled. The fix explicitly rejects these unsafe
source pointer types for load-acquires.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e6233c0081d10..648c5784178ec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4923,6 +4923,30 @@ static bool is_arena_reg(struct bpf_verifier_env *=
env, int regno)
>  	return reg->type =3D=3D PTR_TO_ARENA;
>  }
> =20
> +static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
> +			       struct bpf_insn *insn)
> +{
> +	const struct bpf_reg_state *reg =3D reg_state(env, regno);
> +
> +	/*
> +	 * A BPF_LOAD_ACQ is not rewritten to a BPF_PROBE_MEM load by the
> +	 * verifier, unlike a regular BPF_LDX. The JIT would emit a plain load
> +	 * with no exception table entry, so a fault (e.g. NULL deref) crashes
> +	 * the kernel instead of being handled.
> +	 *
> +	 * Reject the source pointer types that a BPF_LDX would have had that
> +	 * fault protection applied to, i.e. the ones bpf_convert_ctx_accesses()
> +	 * turns into BPF_PROBE_MEM: a bare PTR_TO_BTF_ID and any PTR_UNTRUSTED
> +	 * pointer (untrusted btf ids, untrusted MEM_ALLOC, rdonly untrusted
> +	 * memory). A PTR_TRUSTED pointer is not among them, is not converted,
> +	 * and stays allowed. Same for the other flagged PTR_TO_BTF_ID variants
> +	 * (MEM_ALLOC, MEM_RCU, ...), hence the exact match on the base type.
> +	 */

[Severity: High]
This is a pre-existing issue, but does bpf_convert_ctx_accesses() actually
rewrite all PTR_UNTRUSTED pointers as the comment suggests?

It appears that if control flow paths merge at a BPF_LDX instruction,
save_aux_ptr_type() in kernel/bpf/verifier.c merges their pointer types:

    if (type & PTR_UNTRUSTED || *prev_type & PTR_UNTRUSTED)
        merged_type |=3D PTR_UNTRUSTED;
    if ((type & MEM_RDONLY) || (*prev_type & MEM_RDONLY))
        merged_type |=3D MEM_RDONLY;
    *prev_type =3D merged_type;

If one path uses a valid memory pointer like PTR_TO_MEM and the other uses
an untrusted pointer like PTR_TO_BTF_ID | PTR_UNTRUSTED, they merge into
PTR_TO_MEM | PTR_UNTRUSTED without the MEM_RDONLY flag.

However, looking at bpf_convert_ctx_accesses() in kernel/bpf/fixups.c:

    case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
    case PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED:
        if (type =3D=3D BPF_READ) {
            if (BPF_MODE(insn->code) =3D=3D BPF_MEM)

This switch statement doesn't have a case for PTR_TO_MEM | PTR_UNTRUSTED.
Could this allow a regular BPF_LDX instruction to bypass the BPF_PROBE_MEM
rewrite and cause a kernel panic if the untrusted pointer path is taken at
runtime and is NULL?

> +	return insn->imm =3D=3D BPF_LOAD_ACQ &&
> +	       (reg->type =3D=3D PTR_TO_BTF_ID ||
> +		(type_flag(reg->type) & PTR_UNTRUSTED));
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806201047.3333=
89-1-daniel@iogearbox.net?part=3D1
