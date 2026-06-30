Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEED264617;
	Tue, 30 Jun 2026 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789629; cv=none; b=dVMqlWjeFG3MgYiC2JfjoPt8Hc/0wLW8Wtb072sKaewvO7gczDFiMJUUiBuyQw2FRKqWQn4tv4rQGqTCT7wxSGsyU9I9L2kpic73KFuAjFMdN4zwxqtp3Iq0hKlEJ4RnbAW7H1Z36p+3+SfznHrRFUowZAkWwIW566X8M8wDmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789629; c=relaxed/simple;
	bh=swaQKFcypHEmfbvLvBQR/YUrccAsRYRbulEv2sYbc4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QNWfnrcLXnm4tThPZAsnz1DRZf0Vb5ThRcqTuNdvlDRap1YTQ7izbg4iTuSsPr2aR+VdgrJXDep+QZar4+tlOcExr/tssUUQOucFSclJpl8ZFVa8BYHZFm7y52yQURvu6PY01drB+rF4dYb1W42YzMLelRxhkebotiuECQnhv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP6g7IZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP6g7IZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB51F000E9;
	Tue, 30 Jun 2026 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782789627;
	bh=4hWZaKzlBi1FrYoSVvny91d73NS37LVCJkUUjmHaVPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lP6g7IZxcbu2mjV+QOK4TD+PHg1+sQLyf37/kkvnQGXKVpwGyrOmmoe/J7W/ZHwEA
	 jXQAo1dnlfXBBYiiizfkYitaHJwh0JD+KbeTKAmhrWSl2cVDvqMnYo2e7CmbM8TgGD
	 OzlHqdkJa20o226dXmTa3mrIcbdLs+SHTNeTdoRGNE9jWWiaH+x0MyipOhgEV1jfJp
	 JA169bqtg2BpZaD57rF5NUzX5WskMWAtDqIdzMbLiITAaBbtLL1CgqLRH9vjWI2AHI
	 9ahLwWtg0E+ldz2jsFrYvvIMrtk6j6uCWM8Iqh//9LH84eRyTdqjkA9VaKsV9QAw0d
	 mVwgU0w42dI+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/sched_ext: use btf_vlen() helper in compat.h
Reply-To: sashiko-reviews@lists.linux.dev
To: luoliang@kylinos.cn
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260630031246.2618216-1-luoliang@kylinos.cn>
References: <20260630031246.2618216-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 03:20:27 +0000
Message-Id: <20260630032027.92BB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch fails to resolve the `-Wsign-compare` warning it claim=
s to fix because `btf_vlen()` returns `__u32`, not `__u16`.
--

commit 4880227aa1b0e483fd0500c9f49fa0639cd32d8b
Author: luoliang <luoliang@kylinos.cn>

tools/sched_ext: use btf_vlen() helper in compat.h

This commit replaces open-coded BTF_INFO_VLEN() lookups with btf_vlen() in=
=20
compat.h, intending to fix a -Wsign-compare compiler warning.

>     libbpf already exposes btf_vlen() for exactly this purpose; it
>     returns __u16, the natural width of the vlen field, and the usual
>     integer promotions turn the 'int < __u16' comparison into a plain
>     'int < int' so the warning goes away without any cast. This matches

[Severity: Medium]
Is this description accurate?

Looking at the definitions in include/linux/btf.h and tools/lib/bpf/btf.h,
btf_vlen() is defined to return an unsigned 32-bit integer (u32 or __u32),
not a __u16:

static inline u32 btf_vlen(const struct btf_type *t)
{
	return btf_type_vlen(t);
}

Because it returns an unsigned 32-bit integer, won't comparing it against
a signed int still trigger the -Wsign-compare warning?

> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/inclu=
de/scx/compat.h
> index 602f07061ee39..5b92e9c85d03d 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -42,7 +42,7 @@ static inline bool __COMPAT_read_enum(const char *type,=
 const char *name, u64 *v
>  	if (btf_is_enum(t)) {
>  		struct btf_enum *e =3D btf_enum(t);
> =20
> -		for (i =3D 0; i < BTF_INFO_VLEN(t->info); i++) {
> +		for (i =3D 0; i < btf_vlen(t); i++) {

[Severity: Medium]
Does this code still compare a signed int 'i' against the unsigned 32-bit
return value of btf_vlen(t)?

Other places in the kernel (like kernel/bpf/inode.c) and bpftool typically
avoid this warning by either declaring their loop counter as a __u32, or by
explicitly assigning the result of btf_vlen() to an int variable before the
loop. Should one of those approaches be used here instead?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630031246.2618=
216-1-luoliang@kylinos.cn?part=3D1
