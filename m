Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E23806B2
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 04:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776657955; cv=none; b=MqeoOksum8PwIars7dTR5O5AtSrFaphp1t9AzyS+it8wrGPfQSbMaEDKuAHzmayntWW9nZ7SpB+6qE3ENNMT5LYJUUn5cC7RCLQngNg/aYIHXt5FN479yXIuvgs5luFfXBRVMVYI8oKxnb/3kJZRnuwD1u+5xlFpt1bVT4ZwWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776657955; c=relaxed/simple;
	bh=LWGI2c6f+xOxw0O46cMe57bsbdV3nnADBzMhrOpnZEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=niCYhJw7qrxywhGhrapP/nwAKyHJet9/SgBEP+wG5xwpvyPI3IR5FnA0kAi7CuJgFBFIcOdrKYhUXpEaYXpMsXkse4TNpiemA+Bd8LeWZMRE3u6+mH+fH4m9KMiZpkMsT5G+RppwRF/0MxH+GZx12prBaQZoXkv+8cf/4D8ocwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS5BIcMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS5BIcMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA41C19425;
	Mon, 20 Apr 2026 04:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776657954;
	bh=LWGI2c6f+xOxw0O46cMe57bsbdV3nnADBzMhrOpnZEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oS5BIcMSPMoUfC4/mL7MWWAy8KJbzi6Ev0LIh7uBrp7ksoZRGQDE6+J09meAB+1/w
	 PDUPZSQgzD3YESt9T4M56Xg0oU084Y8LGnv0wxsCS2aYdRjjWcrapWppNv1VbPgtjM
	 HITQ82LRf7ZXDGGmjRyUmAe2aFF648Jxj3ZieuPCp/nv3OR4mbDC091EHFieu/+fIA
	 nBAo1S2Z8v1FRdM8+P1WjkQsHt9HMKwqwgsIM9R3Ih0KlAYAFKSjpBXPXQrj7osI+W
	 SSRw/Qz9TExJwALXR7xPBN+EDMVOEquL/M7eK2wudapzdXAzi6nLTIoNydKOLuxwtf
	 KwSLq4XMDjXdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type()
 for scalar regs
Reply-To: sashiko@lists.linux.dev
To: "Avinash Pal" <avinashpal441@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419040426.9672-1-avinashpal441@gmail.com>
References: <20260419040426.9672-1-avinashpal441@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 04:05:54 +0000
Message-Id: <20260420040554.9BA41C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Type confusion and non-deterministic behavior by accessing union m=
ember `reg->btf` before validating register type.
- [Low] Compiler warning due to mixed declarations and executable code.
--

commit e1d023d433c4be96ed8eba9f6b8df2ec2929d841
Author: Avinash Pal <avinashpal441@gmail.com>

bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs

This commit attempts to fix a NULL pointer dereference in
map_kptr_match_type() by adding an early return if reg->btf is NULL.
It targets a crash that occurs when storing a scalar value into a kptr slot.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221372

> For scalar registers reg->btf is NULL. map_kptr_match_type() passes
> this directly to btf_is_kernel(), which performs a container_of()-based
> offset access and triggers a general protection fault:

Since base_type(reg->type) !=3D PTR_TO_BTF_ID evaluates to true for scalars,
wouldn't the code jump to bad_type before ever reaching btf_is_kernel()?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f7..15b8f71074f93 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4545,6 +4545,18 @@ static int map_kptr_match_type(struct bpf_verifier=
_env *env,
>  			       struct btf_field *kptr_field,
>  			       struct bpf_reg_state *reg, u32 regno)
>  {
> +	/*
> +	 * If the source register has no BTF type (e.g. it is a scalar),
> +	 * it cannot possibly match a kptr slot. Reject early to avoid
> +	 * passing a NULL reg->btf to btf_is_kernel(), which would cause
> +	 * a NULL pointer dereference inside that function.
> +	 */
> +	if (!reg->btf) {
> +		verbose(env, "R%d is not a pointer, cannot store into kptr slot\n",
> +			regno);
> +		return -EACCES;
> +	}
> +

Does placing this executable code before the variable declarations trigger a
-Wdeclaration-after-statement compiler warning?

>  	const char *targ_name =3D btf_type_name(kptr_field->kptr.btf, kptr_fiel=
d->kptr.btf_id);
>  	int perm_flags;
>  	const char *reg_name =3D "";

In struct bpf_reg_state, btf is part of a union:

struct bpf_reg_state {
    ...
    union {
        int range;
        ...
        struct {
            struct btf *btf;
            u32 btf_id;
        };
        ...
    };
    ...
};

By checking !reg->btf at the top of the function, does this read an inactive
union member before validating the register type?

For instance, if the register is a PTR_TO_PACKET with range =3D=3D 0, could
reg->btf incorrectly evaluate to NULL here and return -EACCES instead of sa=
fely
falling through to the bad_type check below?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419040426.9672=
-1-avinashpal441@gmail.com?part=3D1
