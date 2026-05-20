Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480F2D94B5
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292975; cv=none; b=SPqXuw5alrUYsxrL2XGMbKzy4RDw4LCaf+Qg7F4F2tOnGAptlCZtmRapX6W849Bs91VKwiX3ciEM6EKof6J3jb4WjtoN77DkOgzwYBERnhpfqxbLKpPi47KTIW8O8PY9KUMz4O0eve4tGK+XmUeIRiO7mejF/x/hlBaoADNWuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292975; c=relaxed/simple;
	bh=i6y26YhttaKmLBPeKqy0Leb7dCRLw6b4M56+LDY8hKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=swlT0CCeIBJduh+D1ZYB7F3eVf9Mjjy9qJcM/G9tMZEdyXcF0sU00V2/d8pSinxnTjl37RL0SBmrX2Qye6u5JMTenDvZXvVLP3A5l9mP3x4KFwLrAwFgvfVot1XQSIy+vzvLdLOZUHxsLeC+LpoTC52DtkF3E0p2D8eZZW74IY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv9yJWPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv9yJWPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01E91F000E9;
	Wed, 20 May 2026 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779292974;
	bh=j254kdeoTfAxVBAax007p8CkWzP4ipflrqXXSpLPPGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gv9yJWPzrZbRsnA8BosrFuTBYOniexFNH0V0MqdtjOyciRHq02OXUJLuye+re1+bo
	 HjT9sjL5x3ypGuo+TT9encXAlb+nM2Tm7ULN1rKpdhuGCtVclgB5hrbq2G2Sf2JU7a
	 ipjeENp2bDUPrBzQBr3Iyn5+SyACOX5pxWiNLwYaiaLVwS3JbMPEQLfls4KjSq5w2V
	 bfVS69eH3dUZwX3cKclKlJtejqx7j5dyFWaHKRN5Hm4YY/kAQEQ7ubMkSzK5fgt2n4
	 F85NIW29oDlYyEpZ+9X5Xwt19DcyCr9h9IHtiQ2HpaKNGghoxzTQ0er50wGC6QA/w5
	 xGAeskoFhRwlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 02/20] unwind_user/sframe: Add support for reading
 .sframe headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-3-jremus@linux.ibm.com>
References: <20260520154004.3845823-3-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:02:53 +0000
Message-Id: <20260520160253.C01E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Integer overflow in SFrame section offset and size calculations =
allows malformed headers to bypass bounds checks on 32-bit architectures.
--

commit 2144f643835a311bd7c4b9df269057ea5516231a
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add support for reading .sframe headers

This commit adds basic compile infrastructure and support for reading
the .sframe section header in preparation for unwinding user space stacks.
The sframe_add_section() function currently reads the header and
unconditionally returns an error until subsequent patches improve it.

Link: https://lore.kernel.org/all/f27e8463783febfa0dabb0432a3dd6be8ad98412.=
1737511963.git.jpoimboe@kernel.org/

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> new file mode 100644
> index 0000000000000..d24e9d4f8bef7
> --- /dev/null
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -0,0 +1,136 @@
> +static int sframe_read_header(struct sframe_section *sec)
> +{
> +	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
> +	struct sframe_header shdr;
> +	unsigned int num_fdes;

[ ... ]

> +	header_end =3D sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> +	if (header_end >=3D sec->sframe_end) {
> +		dbg("header doesn't fit in section\n");
> +		return -EINVAL;
> +	}
> +
> +	num_fdes   =3D shdr.num_fdes;
> +	fdes_start =3D header_end + shdr.fdes_off;
> +	fdes_end   =3D fdes_start + (num_fdes * sizeof(struct sframe_fde_v3));
> +
> +	fres_start =3D header_end + shdr.fres_off;
> +	fres_end   =3D fres_start + shdr.fre_len;

[Severity: Medium]
On 32-bit architectures, is it possible for these offset and length
calculations to wrap around?

User-supplied 32-bit fields from the SFrame header (fdes_off, num_fdes,
fres_off, fre_len) are used to compute section boundaries using raw
arithmetic. Since unsigned long is 32 bits on those architectures,
operations like header_end + shdr.fdes_off or num_fdes * sizeof(...)
could overflow.

If a malformed header contains values that wrap the 32-bit address space,
fres_end might appear smaller than sec->sframe_end and fres_start might
appear greater than fdes_end, completely bypassing the validation check
that follows.

Would it be safer to use the <linux/overflow.h> helpers such as
size_mul() and check_add_overflow() to protect these arithmetic
operations?

> +
> +	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
> +		dbg("inconsistent fde/fre offsets\n");
> +		return -EINVAL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D2
