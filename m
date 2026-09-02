Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95E39891F
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340992; cv=none; b=fAyVdaXN5xn/d20e63WUjmumGxt4fIjDmUpc8JT7oa848n0QHZnAd0YhYXJGFf5Z9mES2RKaFkctQDR36zm+FNNU8KzVgRfxDN42bsFGwmXwO6OPEFcOghhlAqYSoYykOQoMtCE9490452kXYGilSHN7kr9GWITYOvdkvAf8Q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340992; c=relaxed/simple;
	bh=N/38aNm8ErIR9ceMSJtwxsuK1GayDbLsZvzi8a2HJaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jglwSmXhOXuUbeM3aHU6yPh7xfCB5jUwavkouzljJE9PMGzUFELUR+9bIxJpYUyfoSIYfhqiMwmzhsyaaeyxjCErwIn41pEICXvOKHBo2vVxgNTgPnfMvBoIbr6gcHhRHJFrvB7XTksyXGBzqONQcYJiUTtjVh2RyXaSmefAnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aflryCuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aflryCuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B95E1F000E9;
	Wed,  2 Sep 2026 09:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788340990;
	bh=QkB1IUNt/US9uFUwRTp6Y8sH2Hx8yptwpbtei/4ItME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aflryCuFi9MvM737Yif7wMly5vezLEcqEiNAY4C0fpI74PqfOCOCjgVOFKYPqrveE
	 wZplhz2VW+TVUSByEzkO3h5m9eN8QE/SYHs/YAaABrTu6J2cai/v95OjnQKymPfLWt
	 k8Vzv+l519r3X5lnMvc6H3ZIR8qeaB5TlSrbETlW5pD33XWKJdexcbVUK4JwqFWFN+
	 VCQVV+2S31qlDZ/9WAuy+xtP4iaEm7xVealPe4RQxGqfRNIGZ8KEa0HoFMEtxJgu2o
	 Gh/D8N1u5FKBmQVVk6jeRjKSwzSETEfkKOD+baksBpNI6TJoIXXrOLToCfPAMYE/SR
	 ytHrjwb9zeYFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Reject oversized unknown BTF type
 records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Amirkan" <markdamirkan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902091126.59281-1-markdamirkan@gmail.com>
References: <20260902091126.59281-1-markdamirkan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 09:23:09 +0000
Message-Id: <20260902092310.5B95E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pointer arithmetic overflow in `btf_parse_type_sec` bounds check a=
llows out-of-bounds memory access on 32-bit architectures.
--

commit ecf66a907aa5b49ad6ebbe3433e5a171a1a7138e
Author: Mark Amirkan <markdamirkan@gmail.com>

libbpf: Reject oversized unknown BTF type records

This patch changes btf_type_size_unknown() to calculate type size using siz=
e_t
and rejects sizes greater than INT_MAX. This prevents massive unknown types
from wrapping to negative values when cast to int and crashing libbpf.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index c783359977b46..83a7f199f37df 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
[ ... ]
> @@ -448,7 +449,15 @@ static int btf_type_size_unknown(const struct btf *b=
tf, const struct btf_type *t
>  		return -EINVAL;
>  	}
> =20
> -	return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_=
sz;
> +	type_size =3D sizeof(struct btf_type) + l[kind].info_sz +
> +		    (size_t)vlen * l[kind].elem_sz;
> +	if (type_size > INT_MAX) {

[Severity: High]
This isn't a bug introduced by this patch, but since we are explicitly
allowing type sizes up to INT_MAX, could this trigger a pointer arithmetic
overflow in the caller?

In tools/lib/bpf/btf.c:btf_parse_type_sec(), the size is bounds-checked like
this:

		type_size =3D btf_type_size(btf, next_type);
		if (type_size < 0)
			return type_size;
		if (next_type + type_size > end_type) {
			pr_warn("BTF type [%u] is malformed\n", btf->start_id + btf->nr_types);
			return -EINVAL;
		}

On 32-bit architectures, if type_size is close to INT_MAX and next_type is
high in the address space, next_type + type_size can wrap around. This would
cause the check to erroneously evaluate to false, bypassing the validation =
and
allowing out-of-bounds memory access.

Would it be safer to subtract pointers to prevent overflow here:

		if (type_size > end_type - next_type) {

> +		pr_debug("BTF type size %zu for kind %u is too large\n",
> +			 type_size, kind);
> +		return -E2BIG;
> +	}
> +
> +	return type_size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902091126.5928=
1-1-markdamirkan@gmail.com?part=3D1
