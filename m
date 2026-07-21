Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650403161BE
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784607713; cv=none; b=NJKgVXFpJ7kiTRr4hG5GZ4dWqJDlc8W1znA9yttZ++rY5bRfzsHMt3k0YGon/qWOEG1hIl1yZ62V9wvWnU3ujtqvzpm9VESpxhE8LmvxiAQ+AUppF+rDpaGHpY7NyQHahfdbwGP887i7U5HF681QEoJjSt8qxC+Psq3OL+Cmmd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784607713; c=relaxed/simple;
	bh=i/nX9nJzOiD6GLJJ6j16xLMuPLVio+Pc36dhBjPwNoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TMFWSOH7H7iMT/x8tUS/4LakJ8JFHaz7E2A4lBQfSiDJDm7YVSGvOXFixG7LUm+6/x5NgwTxTubzZf3JTj31EUjbMV1Yl+pOZuf98XjXCiHloYQ50kBpBuPHJs4rBUY58WFc9sAdMoqU5XCyGc3mXf1ii/pANBAvyArWJnjpvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5pR7tXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5pR7tXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F941F000E9;
	Tue, 21 Jul 2026 04:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784607712;
	bh=m7Sz+qKGgblRGE++kV7ZeGyKxKo0sGetc1DK7Qf36tU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R5pR7tXfKZj59Y9K3XtMbvhENhgGmFqGdAk0/sIzR3TDd5dEjygekV0khx26KGdOu
	 YNL6ONxuQyFgl7IsF4rzSngaCucJEW8d1x39K+2lDIXAhX+aPsAtc+QzSdk84HD1I7
	 6kSfkdMLzQj5tv4eEgaAGyYXL5CLuWl0k96JimUz341UdfAnATMb2ammdeejp9vtP8
	 whCJTCFPsnYNdjDmqO8B6Noksivyb3ph6jUMGpmmMPDvkr/14VKTSBoDMjZ4MeE72k
	 fH2xyXq2GWnLVdIyo2VsaCELRKywtHkfOP5JeMSsMngAcZdhttyg7nKuG5QT9kRfHq
	 HLqInU/9TL8Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type check
 in mprog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721041048.1394085-3-pulehui@huaweicloud.com>
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 04:21:51 +0000
Message-Id: <20260721042151.E6F941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Anchor link type validation is bypassed when attaching or detach=
ing bare BPF programs, leading to wildcard insertions/deletions and data ra=
ces.
--

--- Patch [2]: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type che=
ck in mprog ---
commit 830a4e62ebb8e98cc45b0ce829c6686aacafabc4
Author: Pu Lehui <pulehui@huawei.com>
Subject: bpf: Fix UAF due to missing link type check in mprog

This commit adds a link type validation in bpf_mprog_link() to prevent a
use-after-free when dereferencing link->prog for foreign anchors. It also
adjusts bpf_mprog_attach() and bpf_mprog_detach() to pass down the expected
link type.

> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
> index 1394168062e85..37ce91e0bcd21 100644
> --- a/kernel/bpf/mprog.c
> +++ b/kernel/bpf/mprog.c
> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>  		link =3D bpf_link_get_from_fd(id_or_fd);
>  	if (IS_ERR(link))
>  		return PTR_ERR(link);
> -	if (type && link->prog->type !=3D type) {
> +	if (type && link->type !=3D type) {
>  		bpf_link_put(link);
>  		return -EINVAL;
>  	}

[ ... ]

> @@ -243,6 +244,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>  		return -EEXIST;
>  	ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd,
>  				       flags & ~BPF_F_REPLACE,
> +				       link ? link->type : BPF_LINK_TYPE_UNSPEC,
>  				       prog_new->type);
>  	if (ret)

[Severity: Medium]
When attaching a bare BPF program, link is NULL. This passes
BPF_LINK_TYPE_UNSPEC (0) to bpf_mprog_tuple_relative() as the expected
anchor link type.

In bpf_mprog_link() above, the validation check is:

    if (type && link->type !=3D type) {

Because type is 0, the validation is bypassed entirely.=20

If a user passes a foreign link with a NULL prog (like struct_ops) as an
anchor via id_or_fd, the positioning logic treats tuple->prog =3D=3D NULL a=
s=20
'no anchor provided' instead of rejecting the invalid anchor with -EINVAL.

Does this allow wildcard insertions or deletions, and leave a benign data
race when reading link->prog locklessly? Should the expected link type be
explicitly provided when attaching bare programs?

[ ... ]

> @@ -343,6 +345,7 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>  	if (!bpf_mprog_total(entry))
>  		return -ENOENT;
>  	ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
> +				       link ? link->type : BPF_LINK_TYPE_UNSPEC,
>  				       prog ? prog->type :
>  				       BPF_PROG_TYPE_UNSPEC);
>  	if (ret)

[Severity: Medium]
Similarly, when detaching a bare BPF program, link is NULL. This also
passes BPF_LINK_TYPE_UNSPEC as the expected link type.

Does this bypass the new validation and allow wildcard deletions when using
foreign anchors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721041048.1394=
085-1-pulehui@huaweicloud.com?part=3D2
