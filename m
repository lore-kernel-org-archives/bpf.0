Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5B3E51EC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745704; cv=none; b=kXoSSP2CYUujXBpA14YA05PXL9j3XPYr7nV5kNZ8EYKx0O6h1WWZE76NDZnQPRIbDLmVFiSdCDSVbIWcCPxAWhXmQfY7QN0CfWm9Pctrlo6prMeVTXL1n5E6+MGb2ARBaZ8YQ8caEs3RRBvrZPkiHnZfVpBotGc4xAKs4x3moBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745704; c=relaxed/simple;
	bh=lFYGK2Bn5yYHoqjqOoX9WSrXJJCkuDwXkeXdecDxnv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQISQuaZIEB8QX7VDS3RzriYJydFKeYAVjY5PPKwfpLU5gcS9HbS5RZeY1i+nRk21FKv5YUc8Tqwp3vxyZdyM7/Zrb7Jv46OK2wjrmcXHVmLdC2Lad4wyUXmqn3UuTYulqtvghH9YN6WM6/lTJ1bf6B2nscvx4GU9CmotZVRVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neAnFO0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neAnFO0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880C11F000E9;
	Fri, 14 Aug 2026 22:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786745702;
	bh=WiRDavzohFap2XrU5lZaXSSis3fiqnYc5CQyq92733s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=neAnFO0flTMRaTmuZbbIqNEjhg5n9vonPnJPjBfGDHFmvQ8li27GJ8JzQidfQrA8j
	 lM+g3p2g/09Ogo6RGNAjNZvx0JEUMV0zq/jz9oCVhsRSBSo758v8WvHtYoi8gF1rvf
	 lxtBUeOG3Xyp3qexd4eYICLGctPPFZqB18ncEaIqMACC72OF1zIT8XQNlxZuG7DHCM
	 PM04ZjsZikFy0r2ffokq/DJ0QzhxsWuVJ80y8xGET710bULTcD5/gBklBBvEJLjcXe
	 SUaJ9IaideaFC/eOsWvGrTJ0UuSdywoAmf7Ua5calhs0xO0gkXXPgJROH1GIEbSQon
	 14b7ASqMPGlRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Keep fault protection when merging
 pointer types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814215301.709827-1-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 22:15:02 +0000
Message-Id: <20260814221502.880C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The verifier fails to emit BPF_PROBE_MEM instructions when a s=
afe pointer type (e.g., PTR_TO_STACK or PTR_TO_MAP_VALUE) and an untrusted =
memory pointer type (PTR_TO_MEM | PTR_UNTRUSTED) reach the same load instru=
ction via different branches. This completely bypasses the newly introduced=
 merge_ptr_types logic.
--

--- Patch [1]: [PATCH bpf-next v2 1/6] bpf: Keep fault protection when merg=
ing pointer types ---
commit f6edd0237d3f5f1dd3f7b1e12e20100d5ce150cd
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Keep fault protection when merging pointer types

This commit fixes an issue where merging different pointer types in
save_aux_ptr_type() drops flags like PTR_UNTRUSTED. It introduces
merge_ptr_types() to properly normalize and combine pointer types so that t=
he
BPF_PROBE_MEM rewrite remains intact.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6ac1afced20bf..ad6ccd5cf51db 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17092,20 +17097,12 @@ static int save_aux_ptr_type(struct bpf_verifie=
r_env *env, enum bpf_reg_type typ
>  		    is_ptr_to_mem_or_btf_id(*prev_type)) {
>  			/*
>  			 * Have to support a use case when one path through
> -			 * the program yields TRUSTED pointer while another
> -			 * is UNTRUSTED. Fallback to UNTRUSTED to generate
> -			 * BPF_PROBE_MEM/BPF_PROBE_MEMSX.
> -			 * Same behavior of MEM_RDONLY flag.
> +			 * the program yields a TRUSTED pointer while another
> +			 * is UNTRUSTED. Merge them into a type which keeps
> +			 * the BPF_PROBE_MEM/BPF_PROBE_MEMSX rewrite when
> +			 * either side needs it.
>  			 */
> -			if (is_ptr_to_mem(type) || is_ptr_to_mem(*prev_type))
> -				merged_type =3D PTR_TO_MEM;
> -			else
> -				merged_type =3D PTR_TO_BTF_ID;
> -			if ((type & PTR_UNTRUSTED) || (*prev_type & PTR_UNTRUSTED))
> -				merged_type |=3D PTR_UNTRUSTED;
> -			if ((type & MEM_RDONLY) || (*prev_type & MEM_RDONLY))
> -				merged_type |=3D MEM_RDONLY;
> -			*prev_type =3D merged_type;
> +			*prev_type =3D merge_ptr_types(type, *prev_type);

[Severity: Critical]
This is a pre-existing issue, but does this bypass conflict resolution
entirely if reg_type_mismatch() returns false for both types?

If one branch provides a safe pointer (like PTR_TO_STACK) and another branch
provides an untrusted pointer (PTR_TO_MEM | PTR_UNTRUSTED), they evaluate a=
s:

kernel/bpf/verifier.c:reg_type_mismatch() {
	return src !=3D prev && (!reg_type_mismatch_ok(src) ||
			       !reg_type_mismatch_ok(prev));
}

Since neither base type is in the reg_type_mismatch_ok() switch statement,
it returns true for both types, causing reg_type_mismatch() to return false.

If the safe pointer reaches save_aux_ptr_type() first, we wouldn't enter
the else if (reg_type_mismatch(type, *prev_type)) block at all.

Does this mean merge_ptr_types() is skipped, the untrusted pointer type is
silently ignored, and we might fail to emit the required BPF_PROBE_MEM
rewrite?

>  		} else {
>  			verbose(env, "same insn cannot be used with different pointers\n");
>  			return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814215301.7098=
27-1-daniel@iogearbox.net?part=3D1
