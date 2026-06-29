Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE72379980
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747657; cv=none; b=WAD74gXTGNAVVMbqJYsrDQQATu2aSdvyc8uvbB5SjEV9yJ/b8rLhdTOmdKuOGkvOQyzWwUnlVb6AjSpu8Jsb0G2ot1PNY0LHMfPylTS7fMq8aXur9f933eYkvc70cqZoJhKYGBOtbUakbVq374x0OaSO0JHN1+pjdXJpiiT9Sfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747657; c=relaxed/simple;
	bh=9zseK9sRMg1oXMJBrFVO4kIA6vcmzgc+p2qc0ZucaJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z/XxOZn1v1XuvjgpVOd03vHmPtj4AkVRK7Ds1ZN1Muwrbmx7tdW8agnmznM+1S8UofuzAoD2na+a0+ortOPk6hENTndOKR/0C7reVvJOQWNJB5uV7PNqjkeToeIaVA5EsSISFkSH1Vybtb7h0hOfLZNL+aax7VmdSSNw1WIZJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQU6zMAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQU6zMAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD941F00A3A;
	Mon, 29 Jun 2026 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782747655;
	bh=o8XDFGheFq/99vy6xvWYsvQ0wbnRalKpZzS2LZ55Lb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQU6zMAndxSOa+MAK7sk4XvMnI4m1Q0g1jt0sNbYl7QlwkEetnuAwp1OfupcCbrO1
	 jFNKO1t/986i0t3DlOWWL3uxMPO1UCJD3xHBTm4hjDQA9ukHDso5Z2cWSuZt0o9yu4
	 eQOQk8E212IlupcO1nUfKWNla63KZtYfw/85lSknmtrq6Atum4+6Qv+bArTd+PLJP2
	 dt3+im3lv0LBQ65agNhXGLHsZGXmDNKqCxAgPZ+ysQbEGA1WilXC3Ah6zPhwbbVw9h
	 he65BbcW/WRBi0Ngq9ezvBA3zuq1H934oBilMRT5oYnaGwwyVuzbG+eaw3ozvmSq2S
	 2uSfBswXIsWSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 4/9] libbpf: Add support for global percpu
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629152406.52582-5-leon.hwang@linux.dev>
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:40:55 +0000
Message-Id: <20260629154055.6DD941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer truncation in `bpf_object__init_internal_map` leads to buf=
fer overflow when parsing ELF sections larger than 4GB.
--

commit 03705a88bed3644f27861637702d0bad3472613b
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add support for global percpu data

This commit adds support for global percpu data in libbpf by adding a new
".percpu" section. It enables efficient handling of percpu global variables
in BPF programs by using BPF_F_ALL_CPUS during map updates. The mmaped data
is marked as read-only after map population for syscalls.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7162146280a80..6e18a1628e139 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -1983,7 +1989,7 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>  	}
> =20
>  	def =3D &map->def;
> -	def->type =3D BPF_MAP_TYPE_ARRAY;
> +	def->type =3D is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRA=
Y;
>  	def->key_size =3D sizeof(int);
>  	def->value_size =3D data_sz;

[Severity: High]
This is a pre-existing issue, but could this integer truncation lead to a
buffer overflow?

If a user supplies a crafted ELF file with a section (like .data, .rodata,
or .percpu) larger than 4GB, the 64-bit data_sz is implicitly truncated when
assigned to the 32-bit def->value_size.

This results in a smaller mmap allocation based on the truncated value. Lat=
er
in bpf_object__init_internal_map(), memcpy uses the original 64-bit data_sz:

	if (data)
		memcpy(map->mmaped, data, data_sz);

Can this overflow the allocated buffer when parsing unverified BPF objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629152406.5258=
2-1-leon.hwang@linux.dev?part=3D4
