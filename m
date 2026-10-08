Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9876443E31
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447180; cv=none; b=cssMEb/DqKkCu5qOENxc1E0n1cA6a1E6uDBk5wk82l0B+OCQ8z7TU9jpF1UTLgVQj8qIHvQawfc2MHmEjQ5bS5zxPvHBraJgi4N3rUStGvauDAQ2fvXw4lHVw5j23xfNMSTlQ+xgaF9VyUgk7rWKCo9ZIYgbt5TzCYqMq9gYGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447180; c=relaxed/simple;
	bh=cZ3D9mtGYfxhkhiw/BUOqHSuUHiH4e+iZqPX3EyMNMM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=t5fIi6XdK8ARQUghG4PZVnDY0zyj8gXHfDkdBSjJ0uInme2YuvmzmWAtiSkY/fU2QCxdRv1YyW+TxJ6cauHEw3rdyXr5hezvom8UmlijJb+L2zCJq2ux5KGlyK8qmKBPj7rEtyUwjxKQQ8Okv0a0DuGQc2eDOFAmSqDqy5q32R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDSIvcc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDSIvcc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2441F000FF;
	Thu,  8 Oct 2026 08:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447179;
	bh=Xr35ncw3ajaYwdAXy9DEMYddirITv9qO1MYf5VHjsPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YDSIvcc3f+N1ciUVro98mMPeFfcVIpIInNSTT8liqwAA7KBm8c+RmsraoqSwS5aUC
	 HWJns6jGrwO6GijFrIkGl/KOo4h0QXx7tS5/KX5tD74AdxUOvIGeQl6KDYdsv6X2+A
	 Rkhx0CI5I7jmGGP4bSVLqepRE2u+vEvnYHMx27Q9p+3g3X+ikvx1F/Hgbi2WCCnnCa
	 XroA6toU2gdCz28+eUJj+7EzcyamWYpSdnmQk/ACyupdF04EaDLUWwaWPUx20KLCrI
	 gzK4R/9a2eUn5KTBSJh60SLiVAEvCy9rWPBengtCQFe/N23Nfn1PqeekUNdvq+I78C
	 0ZK1AUWVE3wqA==
Message-ID: <sashiko-outbox-163808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 16/23] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008075121.3005539-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
 <20261008075121.3005539-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:12:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: libbpf misaligned cleanup_info read during verifier log ret=
ry
--

commit 44e841423bd633c0b2885ef9ad198f15d3871fba
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Add cleanup_info to bpf_prog_load_opts

This commit adds cleanup_info fields to bpf_prog_load_opts to allow
callers to pass an exception cleanup table to the kernel during program loa=
d.
The new fields are propagated to union bpf_attr for the BPF_PROG_LOAD sysca=
ll.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b49822d212aed..b4031f62bdee5 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
[ ... ]
> @@ -370,6 +370,10 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>  	attr.fd_array =3D ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
>  	attr.fd_array_cnt =3D OPTS_GET(opts, fd_array_cnt, 0);
> =20
> +	attr.cleanup_info =3D ptr_to_u64(OPTS_GET(opts, cleanup_info, NULL));
> +	attr.cleanup_info_rec_size =3D OPTS_GET(opts, cleanup_info_rec_size, 0);
> +	attr.cleanup_info_cnt =3D OPTS_GET(opts, cleanup_info_cnt, 0);
> +

[Severity: Medium]
If the first sys_bpf_prog_load() fails with -E2BIG, the kernel can mutate
attr.cleanup_info_rec_size to a smaller size.

During the verifier log retry block later in bpf_prog_load():

	if (log_level =3D=3D 0 && log_buf) {
		...
		attr.log_level =3D 1;
		fd =3D sys_bpf_prog_load(&attr, attr_sz, attempts);

If attr.cleanup_info_rec_size was mutated, the retry uses the smaller size
while attr.cleanup_info still points to the user's original array with the
larger stride.

Does this cause the kernel to perform misaligned reads starting from the
second record and parse garbage exception info?

>  	if (log_level) {
>  		attr.log_buf =3D ptr_to_u64(log_buf);
>  		attr.log_size =3D log_size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008074959.2993=
751-1-yonghong.song@linux.dev?part=3D16
