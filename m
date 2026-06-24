Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029730E0F8
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294539; cv=none; b=IB2RsLnTA+nMucfm+KBspBlvAbaLKpf2HcjECJHUPbmvXZvpR1jiW4HCYmpxGDR6EeC4OnoRVYHxxhSbxX6pUDv0TJ7QKrN8tKxcc0ac8eP2RNZ5ViCiuFBmU5qFyuMV762zK+DsSyzcCmBF7Q8/txKjXd9+NFxxNB3rXZf16Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294539; c=relaxed/simple;
	bh=JVdaLswED9na2XKTEv1pKV9EYP40W6EY711U8zhN0E4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b0XqanVsCnneZAhcpnBg77zGGAOCBRkmvN0XEXRaYWpEt60ecke9jeBRhrZewrm6/YQw5nb9BtqSIbKpbIbyGsNPTsCPswVGPUd2wYctNjfZEKOylpY4kduM1dAYr+6DjJtHF7aONxhJoN4ft1e2aXG7F0yiLnv2292y8tGJoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVC05Hwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVC05Hwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E4F1F000E9;
	Wed, 24 Jun 2026 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782294536;
	bh=ZvON/XjCTknn7EOtxrI8atfDXlTHocOBD5haEGgwoWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVC05HwjyB/UcTP43YOcTS5a9XB4x2bAcYsI6YeMJuZfQJetSoEjzPT4R5X/GehW2
	 BN7mbjH/f1K21zKArNxymY4HuOErDKrdmoHrvfZq5ISwPlZygxyXduhUTJUih0/KTt
	 vTlMY+zG269PcR5OkuUuQFZ9k8KJs7Fu1JNINI48kDxcosn/4g0dgvtUnfvNEhH4EE
	 lAmsNW7StgrMgNji5IR5OmFoz5hCg11z9zKeY1bPABJ+TJQSzhOo0es8suseJ4y4mU
	 rc0NWwFGs2ZvcQWYL14MgswG5eOCTB9ESiXeBP982Y4b9KfG9AGFSrCwgHI+7bNFwD
	 ASi69EYapQvNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: add bpf_memcmp kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624093638.117062-2-lange_tang@163.com>
References: <20260624093638.117062-1-lange_tang@163.com>
 <20260624093638.117062-2-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 09:48:56 +0000
Message-Id: <20260624094856.79E4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf_memcmp bypasses verifier memory bounds checking by using _=
_ign arguments, creating an arbitrary kernel memory read oracle.
--

commit 29136173f7ef78c9e1fa53cea458359e9ef94899
Author: Longjun Tang <tanglongjun@kylinos.cn>

bpf: add bpf_memcmp kfunc

This commit adds a new bpf_memcmp kfunc for binary memory comparison in BPF
programs. Unlike bpf_strcmp, null bytes do not terminate the comparison,
making it suitable for comparing fixed-size binary data like MAC addresses
and UUIDs.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8e196c9b7c50f..897e8d71eae45 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -4070,6 +4070,48 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, co=
nst char *reject__ign)
>  	return -EFAULT;
>  }
> =20
> +/**
> + * bpf_memcmp - Compare two memory regions byte by byte
> + * @ptr1__ign: First memory region
> + * @ptr2__ign: Second memory region
> + * @size: Number of bytes to compare
> + *
> + * Compares the first @size bytes of the memory areas @ptr1__ign and
> + * @ptr2__ign. Unlike bpf_strcmp, null bytes do not terminate the compar=
ison.
> + *
> + * Return:
> + * * %0       - The memory regions are equal
> + * * %-1      - @ptr1__ign is less than @ptr2__ign
> + * * %1       - @ptr1__ign is greater than @ptr2__ign
> + * * %-EFAULT - Cannot read one of the memory regions
> + * * %-E2BIG  - @size exceeds the maximum allowed size
> + * * %-ERANGE - One of the memory regions is outside of kernel address s=
pace
> + */
> +__bpf_kfunc int bpf_memcmp(const void *ptr1__ign, const void *ptr2__ign,
> +			   size_t size)

[Severity: Critical]
Does the __ign suffix on the pointer arguments bypass the verifier's memory
bounds checking?

If the verifier skips type and bounds checking for ptr1__ign and ptr2__ign,
could this regression allow passing arbitrary scalars as pointers?

Since the function reads from these addresses using __get_kernel_nofault
and returns a byte-by-byte comparison result, can this be used as an
arbitrary kernel memory read oracle via binary search?

Would it be safer to use KF_ARG_PTR_TO_MEM (for example, by using a __sz
suffix) to enforce static verifier bounds checking instead of relying on
runtime nofault reads?

> +{
> +	const unsigned char *p1 =3D ptr1__ign, *p2 =3D ptr2__ign;
> +	unsigned char c1, c2;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624093638.1170=
62-1-lange_tang@163.com?part=3D1
