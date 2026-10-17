Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401573B388D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205870; cv=none; b=FGit1XQfP4dV871rQsDOCxK6Yr7mStOc2EEFIAZq5c/hPHXQsv3by0y8pKjpFoc49bgHuiYnuSxbyTNn809OazDl04hbjo26YJcIL4E7lLxNfZeThfnv/fBadSExY6TeyeYBGdw5BDAZ1+5CeO9zmBCjNuwdh0KSHfnSnhpo83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205870; c=relaxed/simple;
	bh=iqWnMLtRaoxRcLzW+lw4lMIc/XVCeUgYwGv/NEdj8nA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=qhhEdQKCSbqcodBs5FHsj2ZokAD3OodgcRsKYDfjYuVdTOLbVVOEVON8Z0omzZ1eDP9N0R+4ay3NfbptAID35UXMpxWQEWauJy0L9bKRgmbGhvBkBoUvOFlLuTv+z62fWmP2ECRNj/kzr/9hU4ZbOnww9e5nLV7zv/0BbfsEoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1ZMel6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1ZMel6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939C81F000C4;
	Sat, 17 Oct 2026 02:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792205866;
	bh=O1ElseHlU0jXOmBaUj7afmkKGrvP1zGsQA8Xdx846BI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=C1ZMel6dz0xgRN+PuJnB5Nj/BnqK1LyXKQYRLdAI8KKTOMYRkkXx/vZ24qNobynuU
	 WxDGdK/f3e87g4aOfMFxt8xuxCzaFEYW+jSnAFhuqyYvyE+kCi++JA10gxSUkOISO+
	 kpeiRqbgSVUMikRbNfB3RH8bKUPquX5tY4yyWCzciIrpCHegIGsNtPSl29A012AJ/u
	 Qz0p8kZTc98W/lQbNvPCZ/QBaI/t62e267xMCJbTjImHhzLa14sYNX+RkFY65DUlC4
	 yXuuzu13fsJnKfTWMXK07Y+uKPvY8Y657xKmUozfQNgDrQZMIktLrMJKnQ2Drk3g7d
	 z7iunrSfFXDdA==
Message-ID: <sashiko-outbox-175215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 18/25] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261017025303.1928466-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
 <20261017025303.1928466-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:57:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] libbpf: multi-line comment in bpf_prog_load_opts violates BPF comme=
nt style
--

commit a97157c7935f8f71aa63285b4b87c0084fc0c397
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Add cleanup_info to bpf_prog_load_opts

This commit extends struct bpf_prog_load_opts and bpf_prog_load() with
cleanup_info_cnt, cleanup_info, and cleanup_info_rec_size so callers can
pass an exception cleanup table to BPF_PROG_LOAD.

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 826d9cc9ab65d..64699e0e4e1a8 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -128,9 +128,17 @@ struct bpf_prog_load_opts {
> =20
>  	/* if set, provides the length of fd_array */
>  	__u32 fd_array_cnt;
> +
> +	/* exception cleanup table: cleanup_info_cnt records of
> +	 * cleanup_info_rec_size bytes each (struct bpf_cleanup_info),
> +	 * holding instruction indices into insns
> +	 */

[Severity: Low]
This isn't a bug, but in struct bpf_prog_load_opts in tools/lib/bpf/bpf.h,
should this multi-line comment place the opening /* on its own line to match
BPF comment style:

	/*
	 * exception cleanup table: cleanup_info_cnt records of
	 * cleanup_info_rec_size bytes each (struct bpf_cleanup_info),
	 * holding instruction indices into insns
	 */

> +	__u32 cleanup_info_cnt;
> +	const void *cleanup_info;
> +	__u32 cleanup_info_rec_size;
>  	size_t :0;
>  };
> -#define bpf_prog_load_opts__last_field fd_array_cnt
> +#define bpf_prog_load_opts__last_field cleanup_info_rec_size
> =20
>  LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
>  			     const char *prog_name, const char *license,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017025129.1914=
859-1-yonghong.song@linux.dev?part=3D18
