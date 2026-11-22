Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795352104;
	b=q1mcd7J49XVTRo2xqTmKWqbg6IuQjfqGujNJlPcXeWec7P+Ou5QpOk1ynEKZgLzhIghJ
	 R+8E3xZgtoPP6WyFelxZ58Wi1v1FPGLa2434w5S8onOGufHPGQH2kR9H4kKZdLSPrvcNA
	 ymN8ru8ka8Bx7xcGOGkYy08XPPh+7mBEItKJ2nrd3xb2eJ8OOmfQnMDDE28va2XFrvy7h
	 +bKPkYNTkGQg297rGuD3K5C6BGxeIFPvIz54XKS9nW7KEOeGPPHzdmM8H5F2GvTZBuQzi
	 XU+0vLKYCwonZqGqiNEpmgHgFMEeBHyFdl/R/m//WxdvorPWpOQJN7NNM2acXO5mfSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795352104;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dkKfOoQs/dXnnQtCBJKFzaQD7kfDnR0ghUbp3m+VdUs=;
	b=tKbJt3p1Mbq6hypgXB8957pGHxkyOXkB31RwapHgr28mOBIvWTZqud9tynX4nAr2CpFO
	 kaAZ5mijHNJKZLSRvrmEv+JyRhhyhqd26IxlSpAw+TK5hX19IvD/QgiUFotvLqpw/XqrC
	 fkn3WIZMwv8NH8R45lUIOVM9E0BGzztabf3Fq6FhudIWVYM06FeKxMTqZ14YiUQelqYnr
	 ayzGKegehiKynITYZd9Km3Cca/12wgnJSUmCf/Jab62ceTWuQeWFrSxkoKU0hMMwjC6tL
	 XQYOukC2gH7D7MYmnyXcOrQXMQsuFa/BLC62rTjbNr8/3Xys1WYH8LydHajzzJigTMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9V2s7lv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E5606A32A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9V2s7lv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673861F000C0;
	Sun, 22 Nov 2026 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795352103;
	bh=dkKfOoQs/dXnnQtCBJKFzaQD7kfDnR0ghUbp3m+VdUs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z9V2s7lvfHpjLhJafRJo73j8drz2CAgF8UZqsRVrKQEoKm10JxaTWwSGIHbPfiNWD
	 CCgCuq4W0Kipa82L68RRCP7Hr7BKojC0zdeFjgCVYa4JZW0JlXFnQWfMPYbJZMwuzr
	 SampRYt66RRpe217bbd3ywzwiis5JYG7hLAkUzDEZs52yREMv9qjqOEsMRk4LeLQ6n
	 kHJGuFIDO3Olk4YuE1ioUdVYRNVGWLJYBds488ofliPQEbS2H8yF3e188upVo/2D6o
	 B/03NEQ8Lwd82AqjaO13X/Ux2hOnyYS40RHqnPKXvkszIX3L3h9I3M43YhNtOeLAOw
	 sm7rNAIasA5og==
Message-ID: <sashiko-outbox-227936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/2] bpf: Add bpf_memmem and
 bpf_dynptr_memmem kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhishek Khade" <abhishekkhade69@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261122123427.287521-2-abhishekkhade69@gmail.com>
References: <20261122123427.287521-1-abhishekkhade69@gmail.com>
 <20261122123427.287521-2-abhishekkhade69@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 12:55:02 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: premature budget abort and false -ENOENT in __bpf_memmem()
--

commit f4f47306c408f1db78f7a970c2e8068a144b300f
Author: Abhishek Khade <abhishekkhade69@gmail.com>

bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs

This commit adds the bpf_memmem() and bpf_dynptr_memmem() kfuncs to search
for binary byte sequences within flat memory buffers and dynamic pointers.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 937a0d7d68390..46336909c48a3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3409,6 +3409,120 @@ __bpf_kfunc int bpf_dynptr_memset(const struct bp=
f_dynptr *p, u64 offset, u64 si
>  	return 0;
>  }
> =20
> +#define BPF_MEMMEM_MAX_LEN (2 * 1024 * 1024)
> +#define BPF_MEMMEM_MAX_NEEDLE_SZ 4096
> +
> +/* In-kernel binary byte sequence search using memchr() and memcmp() */
> +static void *__bpf_memmem(const void *haystack, size_t haystack_sz,
> +			  const void *needle, size_t needle_sz)
> +{
> +	const char *h =3D haystack;
> +	const char *n =3D needle;
> +	const char *end;
> +	size_t total_cmp =3D 0;
> +
> +	if (needle_sz =3D=3D 0)
> +		return (void *)haystack;
> +	if (needle_sz > haystack_sz)
> +		return NULL;
> +	if (needle_sz =3D=3D 1)
> +		return memchr(haystack, n[0], haystack_sz);
> +
> +	end =3D h + haystack_sz - needle_sz + 1;
> +	while ((h =3D memchr(h, n[0], end - h)) !=3D NULL) {
> +		total_cmp +=3D needle_sz;
> +		if (total_cmp > BPF_MEMMEM_MAX_LEN)
> +			return NULL;
> +		if (memcmp(h, n, needle_sz) =3D=3D 0)
> +			return (void *)h;
> +		h++;
> +	}
> +
> +	return NULL;
> +}

[Severity: High]
Can __bpf_memmem() exhaust total_cmp prematurely and cause bpf_memmem() and
bpf_dynptr_memmem() to return a false -ENOENT when the needle is present?

Adding the full needle_sz to total_cmp on every memchr() match charges for
needle_sz comparisons even when memcmp() mismatches on h[1].  With a 4096
byte needle, 512 occurrences of n[0] before the real match push total_cmp
past BPF_MEMMEM_MAX_LEN on the 513th occurrence and abort the scan early.

Because __bpf_memmem() returns NULL on this budget abort, both callers turn
it into -ENOENT, making a complexity bailout indistinguishable from a
missing pattern and allowing trivial evasion when scanning untrusted
payloads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122123427.2875=
21-1-abhishekkhade69@gmail.com?part=3D1
