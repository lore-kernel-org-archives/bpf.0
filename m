Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE341F5D7
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037640; cv=none; b=nlSb3/AQr4EchMiqrHnkn3G/owl0XOwkI45jKq/+wGAfwJRnay2fSUZZMX+Bs0moAFKSRDHwXu8k3wgtSumQCnRFuJXgqUrA9GPmU+10XieBnUAbdSZj6b5nh/yHjGXfvF9TPNWqdBb8Gma+9NNtQ0QHIGKR0X848MHrffCx78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037640; c=relaxed/simple;
	bh=IqO5Hf27WC60eA0uZHpXPAGjybW/9K1DOkRvW1FktxA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=AI4qB2GfPcBGv4KS4Mc1c9QEGQeasnXYa/Jc9r0WWZShndSacPEcR4bxRFZsdGfkGnrJnLBF44kUAdDbLA/WAoCfi9TEgLWbPQO+7t5gXZaApd3M99koEsLDxiRtNod7dF+F/gzkS7z8+kjmq+ePtICseOdzih64Jxx1n4J2EHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwhB9XRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwhB9XRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF01F000C4;
	Thu, 15 Oct 2026 04:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792037635;
	bh=X/NBIbzu5Egv/A8dxtHyEA8F1qZJjjb9X7Vs0hcIciY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WwhB9XRaCM1NdDiA+0BUsJ+wZSLMN5xpBZc4GCU9gKiXyu+5/3ayz+03uAOqGYeVb
	 MW80H77IHLtI2q97CbQ3QBEw1cssICq8YsMEwlJy9Cht45vM9Bzc4r3K6/nVRnV7vz
	 wcAQKKTymS3xVF1GTQgAyG0x6AuIU67iqO0bHz/QmZIi8JAtNHnX//eJFmlGWaZTTT
	 pfjM7kG0FJUvXPXn/RruYXD4LOJ5jR5u2jeBL3toum3FUi5s/NiSBVpY1WK+HTQRFG
	 19ARtRiwK1CnHegiAir3CPvHtyPQVke2igMNYy2Z8jNAkaEC9U8xZ/v/mYO4DWHynz
	 ADRqTJaECR9mw==
Message-ID: <sashiko-outbox-172238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 19/26] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261015040321.864586-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
 <20261015040321.864586-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 04:13:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in bpf_prog_load_opts
--

commit 7622c492adc459370a78a700a25047031969a083
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Add cleanup_info to bpf_prog_load_opts

This commit expands bpf_prog_load_opts to include an exception cleanup
table. It adds cleanup_info_cnt, cleanup_info, and cleanup_info_rec_size
fields, which are then passed to the kernel via bpf_prog_load.

[ ... ]

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
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style? The subsystem guidelines strictly require that the
opening /* for multi-line comments be placed on its own line.

Could this be formatted as follows to match the standard?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015040143.8540=
70-1-yonghong.song@linux.dev?part=3D19
