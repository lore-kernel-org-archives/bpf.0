Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57144BC97
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252384; cv=none; b=hJ6tJ5H6N0kCoXWZPJ70C5qnjNwQtJtE1j9ZejqnTbdvcm7SJ9UHxVP0tuG8urxkplHGKQfmmiuQ//vSi6v539zkRn1NlS9Umo0rE6a+7UuSofvsZb+wzto0Z9ZhJxqy2C4ojwSPDv1XGRUJs0X3h0RZQJN8dlEgUl8+h8PxFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252384; c=relaxed/simple;
	bh=ApIuOWppljXb/9NDw8d37YfPe8lCpcWiAN6+AtsKgS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nujvCXnduXF+N3cDFZ6mTEzJBHzqUVSaArr5/TGZsAikZm4h/jLe5I4MUiBH8C0NkyFH2KMrDuXbQXuq+ph07GbXDr+TSa3BAt4SkyVlpCp45l/uGuDzD0JyMMGpocsioRacaf3NBS+96qmQAKHUZZbhYuVtFdIf+H55/fJL8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPvTHmZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPvTHmZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE081F000FF;
	Thu, 24 Sep 2026 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790252383;
	bh=gbpubcYZitStKQ5ON9ek2GNgp9GLHH77Unl6IE6MZXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SPvTHmZPm3/d1J7vfcHOF+0TYrqj9LRT3jSHiOuvzKZc7Pse6SX7vzT3gITFpIxgp
	 Mq3IU67Cp+A6N4bEDMXxqjEsoUm+2ILwJEzsLsanNQ+rkGcEe8ZrWmFHiHIEYCHV8G
	 SJQNbjr/GvibNkB8ALpNOWPYoECgxtGIoW1IqVYQuRlRpVVmRQfUGWF6YWumViOVpl
	 eBmawnL8UIyhRvuoK524m2KNOyZQbmB4RCFhuJcxrcFb5KKyklAKckKeIV/1xeXbmk
	 TA7KRVLbl5aeD7timYCFa/Z64WvLmN379cBy1YCWe8TW4NQMM8l5A3Ncd2FDf6a4f3
	 qw8jF+RY3cCFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 11/11] Documentation/bpf: Describe new
 location-related BTF kinds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924111428.75957-12-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com>
 <20260924111428.75957-12-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:19:42 +0000
Message-Id: <20260924121942.DCE081F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] bpf: LOCSEC info.vlen 16-bit limit overflows for large ELF secti=
ons
- [Low] bpf: contradiction between LOCSEC name_off rule and example
- [Low] bpf: omitted BTF_LOC_PARAM_FBREG and register/offset layout from LO=
C_PARAM spec
- [Low] bpf: omitted LOC_PROTO vlen strict matching requirement
--

commit 2cc26415b9bc105cbaaa995ced64eca8f5ea9509
Author: Alan Maguire <alan.maguire@oracle.com>

Documentation/bpf: Describe new location-related BTF kinds

Update BTF specification to describe encoding schemes for
BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC.

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 004aa1058d857..29de1222c3e73 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst

[ ... ]

> @@ -563,6 +568,80 @@ The ``btf_enum64`` encoding:

[ ... ]

> +2.2.20 BTF_KIND_LOC_PARAM
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``struct btf_type`` encoding requirement:
> +  * ``name_off``: 0
> +  * ``info.kind_flag``: 0
> +  * ``info.kind``: BTF_KIND_LOC_PARAM
> +  * ``info.vlen``: number of 32-bit location value words
> +  * ``size``: size in bytes of the represented parameter: 1 through 16
> +
> +``btf_type`` is followed by a ``struct btf_loc_param`` and ``info.vlen``
> +number of 32-bit value words.::
> +
> +    struct btf_loc_param {
> +        __u32 flags;
> +        __u32 values[];
> +    };
> +
> +The ``flags`` field describes how to interpret ``values``:
> +
> +  * ``BTF_LOC_PARAM_CONST`` describes a constant; the value is stored in
> +    low-word, high-word order when it requires 64 bits.
> +  * ``BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_CONST`` describes an address of=
fset
> +    relative to the runtime base address of the kernel or module image.
> +  * ``BTF_LOC_PARAM_REG`` with one word describes a register number; wit=
h two
> +    words it describes a multi-register parameter.
> +  * ``BTF_LOC_PARAM_REG | BTF_LOC_PARAM_OFFSET`` describes an address he=
ld in
> +    a register plus an offset. Adding ``BTF_LOC_PARAM_DEREF`` dereferenc=
es

[Severity: Low]
Does this documentation need to clarify the layout of the values array for
this flag combination? It isn't clear that the register number occupies the
first 4-byte value while the offset occupies the remainder.

Also, does this section need to document the BTF_LOC_PARAM_FBREG (0xfffffff=
f)
reserved value defined in the UAPI header? Implementers will be unable to
correctly decode or encode these values without these details.

> +    that address. ``BTF_LOC_PARAM_REG | BTF_LOC_PARAM_DEREF`` with one w=
ord
> +    dereferences the value held in the register.
> +  * ``BTF_LOC_PARAM_SIGNED`` makes a constant or offset signed. A consta=
nt's
> +    signed width is ``size``. For a register-relative offset, its signed
> +    width is the number of offset value words times 32 bits.

[ ... ]

> +2.2.22 BTF_KIND_LOCSEC
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +``struct btf_type`` encoding requirement:
> +  * ``name_off``: offset to a valid ELF section name
> +  * ``info.kind_flag``: 0
> +  * ``info.kind``: BTF_KIND_LOCSEC
> +  * ``info.vlen``: number of inline sites in the section

[Severity: Medium]
Will this 16-bit info.vlen field overflow for large ELF sections?

The info.vlen field is structurally 16 bits, allowing a maximum of 65,535
inline sites per LOCSEC record. Large sections like the vmlinux .text secti=
on
contain significantly more inline sites, which will cause an overflow during
BTF generation.

Should the unused 32-bit size field be used for the site count instead, or
should the specification document how to split a large section across multi=
ple
LOCSEC records?

> +  * ``type``: 0
> +
> +``btf_type`` is followed by ``info.vlen`` number of ``struct btf_loc``.::
> +
> +    struct btf_loc {
> +        __u32 func;
> +        __u32 loc_proto;
> +        __u32 offset;
> +    };
> +
> +The ``func`` field is the non-zero type ID of the ``BTF_KIND_FUNC`` being
> +described. ``loc_proto`` is the non-zero type ID of the associated
> +``BTF_KIND_LOC_PROTO``. ``offset`` is the location address offset relati=
ve to

[Severity: Low]
Should this document the strict structural length matching required by the
kernel verifier?

The kernel BTF verifier in btf_locsec_resolve() strictly requires that the
vlen of a BTF_KIND_LOC_PROTO matches the vlen of its associated
BTF_KIND_FUNC_PROTO. Missing this rule could lead tooling to generate
valid-looking BTF that the kernel will subsequently reject with -EINVAL.

> +the runtime base address of the ELF section associated with the LOCSEC.
> +For example, a LOCSEC named ``inline.text`` contains records for ``.text=
``
> +whose offsets are relative to the runtime base of that section.

[Severity: Low]
Is this example contradicting the name_off requirement?

The documentation above requires name_off to point to a valid ELF section
name, but this example uses "inline.text", creating ambiguity for
implementers parsing the BTF to map LOCSEC records to actual ELF sections.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924111428.7595=
7-1-alan.maguire@oracle.com?part=3D11
