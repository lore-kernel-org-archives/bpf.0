Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7A360ED2
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375101; cv=none; b=b0WobPf5V9Aq63MlunyqERKPf3j3S8KklUF7p9rOLGCa0wgzcK+9YUq0VsBjmTgmoLSspyUDeoE0Kqs3rIl7jFxO5eaarOCyUYsRwzKYP9n8UAOcqh0wSz0u/Ybknhi7b+kpjNLgs8mtrm3HCjL9KeQypg8zSKDnaMTQgpTSHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375101; c=relaxed/simple;
	bh=YXaQMXGlDmyv+/uTWczafdSFwPCJfMlh5BuF7lt0F0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRM1TGMaTxMmj9503ePcOG9BKlJr9PAhPbF3OlSOsGiUMhS0/prhGMCxYQRVGkRboknmb3f9tcj/vC9c7IjMWy7Rp4H+yj138dpxyAQUPrPe/X08cRQCuuIrYF72qf1Y2ROhl2+ZIGBP4qyYjUfAbBi4CAxFbuBfB8S4STjxk1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjCVTC64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjCVTC64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85421F000E9;
	Thu, 21 May 2026 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375099;
	bh=/bmwOcHaexk1VsKUXNqlub8o/LPJ1PF8asH38TI4NjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DjCVTC64LmsjijHtv2lXSdObViBlFKhisIa0X78UjwyvONhL7UvtBeHAnTaUkdru+
	 cgxitj9V6IQjsABDhSMdOfbdu2nc+e1E1GYnoNk9P10vPPETvwBq5brIxaCW1fKGmQ
	 jjfTdTpeSmy0KvoI4ydf1R7FyBpMZrFzUr7DXtTZohPdmdUou5z2M/HY96Rvh4Hyau
	 pNZ2YrFdnuYRrA6EJFxpXwCzMe8tqTSPNGekFayUpjcT/96cBw4PNvWKbvJ+uZZGyP
	 ftL7W9OIyBi7Wsa4u869poIzP7G5b/Z5vtjAoePY62Z+OC15bBIQfy7Zj7Jbu2w8Vj
	 Hd62SxB+Ifocw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 02/20] unwind_user/sframe: Add support for reading
 .sframe headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-3-jremus@linux.ibm.com>
References: <20260521142546.3908498-3-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:51:39 +0000
Message-Id: <20260521145139.C85421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calculations for sframe section boundaries lack overflow checks, a=
llowing malformed headers to bypass bounds validation on 32-bit architectur=
es.
--

commit 054ec0b1d4b6a41d4be90015daaf62a201f3ec3b
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Add support for reading .sframe headers

This commit introduces basic infrastructure for unwinding user space stacks
with sframe. It adds functionality to read and validate the .sframe section
header from user memory.

Link: https://lore.kernel.org/all/f27e8463783febfa0dabb0432a3dd6be8ad98412.=
1737511963.git.jpoimboe@kernel.org/

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> new file mode 100644
> index 0000000000000..d24e9d4f8bef7
> --- /dev/null
> +++ b/kernel/unwind/sframe.c
> @@ -0,0 +1,136 @@
[ ... ]
> +static int sframe_read_header(struct sframe_section *sec)
> +{
> +	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
> +	struct sframe_header shdr;
> +	unsigned int num_fdes;
[ ... ]
> +	num_fdes   =3D shdr.num_fdes;
> +	fdes_start =3D header_end + shdr.fdes_off;
> +	fdes_end   =3D fdes_start + (num_fdes * sizeof(struct sframe_fde_v3));
> +
> +	fres_start =3D header_end + shdr.fres_off;
> +	fres_end   =3D fres_start + shdr.fre_len;

[Severity: High]
Could this introduce a regression on 32-bit architectures where these
boundary calculations overflow?

On 32-bit systems, operations like header_end + shdr.fdes_off and
num_fdes * sizeof(struct sframe_fde_v3) can overflow and wrap around to
small values. For example, if a malformed header sets num_fdes =3D 0x100000=
00,
the multiplication by 16 evaluates to 0.

This might allow a crafted sframe header to satisfy the subsequent
fres_start < fdes_end and fres_end <=3D sec->sframe_end checks, storing a
deceptively large num_fdes and out-of-bounds section pointers. When the ker=
nel
unwinder later processes this section, it could attempt to iterate over
millions of entries or read from wrapped addresses, potentially causing CPU
stalls or soft lockups.

Could safe math helpers like check_add_overflow() or size_mul() be used
here to prevent silent wrap-arounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D2
