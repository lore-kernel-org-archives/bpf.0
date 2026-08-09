Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826ED248F57
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289381; cv=none; b=SuIiM6zVsBBFdar/tUB87CxwKiCEO/PcrwKPNLlNAj/14+ApxhQSlSBEkl6Lk9oxO35ynjbT6182C1hEBmdOz7e6o7F0pnMf1uKRro+lBJJuUJ+CpvJW/RiGWpQtCU0dlR74rC/mK0NJDbOiMLTJQaZlctabBcxIkrmWqFdux+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289381; c=relaxed/simple;
	bh=bvbdFADDIltehw2NfV6jmVZISGZvFrNXG8WBby1qjZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M+vTqjj+BbAVNraJQicIge52rLnqWxi7DP1C5bAoacMVv5ofsFdBuxGVcJD8AFSuHXuKLu9jxLvFnTUHiYc2bbCf40MfBB88hPQ2loClKjxGWvndvAmamwXMRXUZ3DwYeG+cGuul0XX0UTwlLukmcAQuSLVVMshyH5Ju/UA5/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR3/mtbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR3/mtbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFDF1F000E9;
	Sun,  9 Aug 2026 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786289380;
	bh=9P6sYD8mlM+YzbGThs/UbNtgYAndTC/8evsC6hhIAuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GR3/mtbl9waClDAvfXRTxEJwJVPvn38SN3arv9MNXrNPdgcI/G4LbDkA+liOazkOH
	 O28Y1v7O2UpmpGNfPG5lUCbmf4C4GBtAKmWCY6axmrd0jZFkCdaQeWtJowYlo0XNbY
	 Em8oFZRhMbfmct/YSEXIFiLmf3Ecb3EpKNcVhjqRZcekdlajiTeA5Sme2kxqP20xoM
	 5zV4s+iXLIDp/1bWUv8ex3Xg3e6kOaEDsDxh/ISJMqNQjiY6pjt/ufqiIEXa3WKcNN
	 ZCjSrIe56X85RtcVoDqSwVcmAc8u8Kv2Zx6133gDRwWbjKVY52748R8fx5stqkvVfx
	 WccQBhEx9bw8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 12/13] selftests/bpf: Add tracing_multi bpf
 prog link info test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260809150111.45000-13-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-13-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:29:39 +0000
Message-Id: <20260809152940.0EFDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing array sorting in user-space targets leads to flaky test
- [Medium] Uninitialized stack variable `fids` passed to kernel
--

--- Patch [12]: [PATCH bpf-next 12/13] selftests/bpf: Add tracing_multi bpf=
 prog link info test ---
commit 5ee3239754522a052ad0eb2cf3e2485319bff581
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tracing_multi bpf prog link info test
   =20
Verify the link info works well for bpf prog targets of tracing_multi link.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index 0918321c8e63d..a5f8bfcb1e07a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
[ ... ]
> @@ -467,13 +489,48 @@ static int setup_tmulti_targets(const struct bpf_pr=
ogram *prog,
>  	return -1;
>  }
> =20
> +static int setup_tmulti_bpf_prog_targets(const struct bpf_program *prog,=
 int token_fd,
> +					 const __u64 *cookies,
> +					 const struct bpf_program * const *target_progs,
> +					 struct tmulti_target *targets,
> +					 __u32 *btf_obj_id)
> +{
[ ... ]
> +		targets[i].cookie =3D cookies[i];
> +		targets[i].id =3D prog_info.id;
> +		targets[i].func_btf_id =3D func_btf_id;
> +	}
> +
> +	return setup_tmulti_btf_obj_id(prog, btf_obj_id);
> +}

[Severity: Medium]
Will this lead to flaky tests? The kernel sorts the tracing_multi targets b=
y a
computed key during attachment.

When returning link info, the arrays are returned in this sorted order, and
verify_tracing_multi_link_info() asserts that they perfectly match the targ=
ets
array at the exact same indexes.

However, unlike setup_tmulti_targets(), this function does not call qsort()=
 on
the targets array. If ID allocation wraps around or another process allocat=
es
IDs concurrently, this might fail non-deterministically.

> +
>  static int verify_tracing_multi_link_info(int fd, const struct bpf_progr=
am *prog,
>  					  const struct tmulti_target *targets,
> -					  __u32 btf_obj_id, bool has_cookies)
> +					  __u32 btf_obj_id, __u32 count,
> +					  bool has_cookies, bool tgt_progs)
>  {
> +#define TMULTI_CNT (TRACING_MULTI_CNT > TRACING_MULTI_BPF_CNT ? \
> +		    TRACING_MULTI_CNT : TRACING_MULTI_BPF_CNT)
>  	enum bpf_attach_type attach_type =3D bpf_program__expected_attach_type(=
prog);
> -	__u64 addrs[TRACING_MULTI_CNT], cookies[TRACING_MULTI_CNT];
> -	__u32 ids[TRACING_MULTI_CNT];
> +	__u64 addrs[TMULTI_CNT], cookies[TMULTI_CNT];
> +	__u32 ids[TMULTI_CNT], fids[TMULTI_CNT];
>  	struct bpf_link_info info;
>  	__u32 len =3D sizeof(info);
>  	int err, i;
[ ... ]
>  	memset(ids, 0, sizeof(ids));
>  	memset(cookies, 0, sizeof(cookies));
> @@ -496,7 +555,8 @@ static int verify_tracing_multi_link_info(int fd, con=
st struct bpf_program *prog
>  	info.tracing_multi.ids =3D ptr_to_u64(ids);
>  	info.tracing_multi.addrs =3D ptr_to_u64(addrs);
>  	info.tracing_multi.cookies =3D has_cookies ? ptr_to_u64(cookies) : 0;
> -	info.tracing_multi.count =3D TRACING_MULTI_CNT;
> +	info.tracing_multi.func_btf_ids =3D tgt_progs ? ptr_to_u64(fids) : 0;
> +	info.tracing_multi.count =3D count;
> =20
>  	err =3D bpf_link_get_info_by_fd(fd, &info, &len);

[Severity: Medium]
Does this code leave the fids array uninitialized?

The other stack arrays (ids, cookies, addrs) are explicitly cleared with
memset() before being passed to the bpf_link_get_info_by_fd() syscall, but
fids is not. This could potentially cause issues with uninitialized memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809150111.4500=
0-1-leon.hwang@linux.dev?part=3D12
