Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888533A9CB
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520007; cv=none; b=s6KErmZtrKrxZzOjfOjivTHp6ksXj/DgiI7NDhN3SKG1b8T+47qyhZ/+mXB3hmF0ChXNq9pkbKsGaRE6WBlMtTnLtX0w+ViixN+4aC0ih2qCVJau4MKYGVP45TxUthVltaRp8wL5z7dXL5vwoVsGx62CvCNdH2lDdRSJK/NfcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520007; c=relaxed/simple;
	bh=bowGpNjNGWrcUnk3C0TcIMGHkC9dLhRRR/dzk5qrFQQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ktd63EUS25r5MFy+u0ogUkH7ugXwkL/io4JtMxqVao/Pp+i5ZV63jR++0W26Y1AfjBh4Ip1KHcL11tTUQXhtb5TcGNbXrhYmys58/4TcDk6ydOyeMil3MkFaqhnF2ouPgqpooIgIEqdx7k4kkuEl9VxH2JNFsSKBUkjKFDmqBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3YH/KpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3YH/KpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E811F000FF;
	Fri,  9 Oct 2026 04:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520001;
	bh=FRnIKU9yGSjvEbgFSFutvt1hSdnOdABnitcml1T+F8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H3YH/KpQt9iMVqUV6WzG0jbOdnuIbSTRuGJUBar2/qAmZLaNsoITbfFOBShkaZIx7
	 nudbUdYJRjRTk59kb6YBP4s/ipnDpwVqIjAZNJx+DH3gbW821SNXOocMNtq9iGF101
	 p1ZCnLZy437mORcMLlbTfNuxnzGl8qeOTWjIR8BHmWGCIukeZPbO9P5jsLNuSDOmti
	 fUT9l5LLZHQoVZp0tUiRjUTfFTFkKquTeYEMErMgmGYjdSkaOXek5cvtm0M6avyGYv
	 8eWVxagEFEKvYXdSEkElSXsQJmYprRb9VWV2k0oaN3h7y5rE9Oatf5Tl0P9ovJWKmT
	 P06cPKDgOTboQ==
Message-ID: <sashiko-outbox-164828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 17/24] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009041615.34847-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041615.34847-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:26:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in bpf.h
--

commit 2303147a5a35e813efcbbbd93de02e9883d03746
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Add cleanup_info to bpf_prog_load_opts

This commit extends struct bpf_prog_load_opts by adding cleanup_info,
cleanup_info_cnt, and cleanup_info_rec_size fields. This allows a caller to
pass an exception cleanup table to the kernel via bpf_prog_load.

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
This isn't a functional bug, but does this multi-line comment in struct
bpf_prog_load_opts follow the preferred BPF subsystem style?=20

The BPF subsystem style guide mandates that all multi-line comments
should have the opening /* on its own line, with the comment text
starting on the subsequent line.

> +	__u32 cleanup_info_cnt;
> +	const void *cleanup_info;
> +	__u32 cleanup_info_rec_size;
>  	size_t :0;
>  };
> -#define bpf_prog_load_opts__last_field fd_array_cnt
> +#define bpf_prog_load_opts__last_field cleanup_info_rec_size

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041447.1709=
2-1-yonghong.song@linux.dev?part=3D17
