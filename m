Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24358348C5A
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695527; cv=none; b=ruGb+u68+S/GnnKbWSui2AVpCniTQBlMRM4osGLM6ZswZ1iYVMLKCSXSp6nyW+eOwGBW21e53mjDQ81DEja5YJuMRfvqh4T8212XVSrXLLoIyT+8ysjUrn5ePk5CA2opES3JJsazpTZWJSeK6TvusaOrRYOhobS/vN4yheJM4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695527; c=relaxed/simple;
	bh=szs1zGNtwAe9zU5IivuE6VB0v07MT3/91enKevhmxyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uA9Sce5xTxcBGQ5xPQLtrH84WAsFSo5xkjYKa4K8nDm5WdMeHsqiSNYDJkfRqiAff5gZFEaSeO00aRKS/W5tWbFV2tzT9G75cDP0E9mas2Jp30lAXKvpb/kQisUpvgJ2ImcBvq4DIwaWOKITPT8Qn/kGBJ9IZX/uftvDxsVjvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRGMBzMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRGMBzMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883411F000E9;
	Fri, 10 Jul 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695525;
	bh=26cgZ0DrFdFb1b5TCQyvVv7Xx0ozWOqm3mR1ERezy0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MRGMBzMgQBXRdt7l+2WSIVDAQ6MJ+Wgq2ZDsfxzxPpYlTxSp2DLgyQTIOGq+zpXXJ
	 lfabZ96anmIwUvkYFUzpeJ0ifgWL4dwGCbv7OACtVjzj2i0lgSX2e2/F7sqpWxEJzZ
	 P8pxilwf1TsN9eroEO864kfYWd/ET48I19bmH8zabT+TfU2Fe70zw44q67k262y4zy
	 I6CZu+Ily1ycBolARR94w959MgEWoujPCOxV+mstx0cSKGlat7IF3ysy1zdJZQRRlu
	 F/JbAfN/id/e1TGmYffWn88KJRsUlB4ci9AAhbGAiIvqgOl/I0aoyyPhFJZIDLwq1i
	 lGhcohKkuuffQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Reject >8 byte return values on
 return-reading trampoline paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260710144404.2579671-1-yonghong.song@linux.dev>
References: <20260710144404.2579671-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:58:45 +0000
Message-Id: <20260710145845.883411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The x86 BPF trampoline generation under-allocates stack space for =
16-byte scalar arguments (e.g., __int128), leading to an out-of-bounds stac=
k write that overwrites the saved RBP and return address.
--

--- Patch [1]: [PATCH bpf 1/2] bpf: Reject >8 byte return values on return-=
reading trampoline paths ---
commit 8947b8106804bc7e7328c045366441fc0d165459
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject >8 byte return values on return-reading trampoline paths

This patch rejects BPF trampoline attachments for types like fexit, fmod_re=
t,
and struct_ops if the target function has a return value larger than 8 byte=
s.
Previously, the trampoline accepted 16-byte return values (e.g., __int128) =
but
only saved and restored 8 bytes, which corrupted the return value seen by t=
he
caller.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6515d4d3c0032..26d281b77a6e7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19137,6 +19151,14 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>  		if (ret < 0)
>  			return ret;
> =20
> +		if (tgt_info->fmodel.ret_size > 8 &&
> +		    attach_uses_trampoline_retval(prog->expected_attach_type)) {
[Severity: High]
This is a pre-existing issue, but while this patch addresses >8 byte return
values, does the BPF trampoline also have a similar problem with >8 byte
arguments?

In kernel/bpf/btf.c:btf_distill_func_proto(), 16-byte arguments like __int1=
28
are accepted, but __get_type_fmodel_flags() does not set BTF_FMODEL_STRUCT_=
ARG
for them because they are BTF_KIND_INT, not structs.

In arch/x86/net/bpf_jit_comp.c:__arch_prepare_bpf_trampoline(), the stack
size calculation relies on this flag:

		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
			nr_regs +=3D (m->arg_size[i] + 7) / 8 - 1;

Because the flag isn't set for __int128, it is incorrectly counted as
1 register, under-allocating the stack space by 8 bytes per 16-byte
scalar argument.

Later during code generation, save_args() computes
arg_regs =3D (m->arg_size[i] + 7) / 8, which evaluates to 2. It performs
two 8-byte stack stores, which will underflow the allocated boundary and
overwrite the saved RBP and potentially the return address.

Could this lead to out-of-bounds stack writes for fentry/fexit programs
attached to functions with 16-byte scalar arguments?

> +			bpf_log(log,
> +				"Attach to function %s with a >8 byte return value is not supported =
for this attach type\n",
> +				tname);
> +			return -EOPNOTSUPP;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710144404.2579=
671-1-yonghong.song@linux.dev?part=3D1
