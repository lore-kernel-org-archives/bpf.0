Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405785;
	b=boKju0qCRD9D4kcFrOFPz1hb4nKXLtL1ixxecq2lg1H1VEfxgb/MZkYOz9LSiDHtd2xV
	 cbDhLG2K0xpb6Xz9IsYmxFhzy1KVp955EcZC6k7yLFzmuMZZSp6XS9je5VmDer2+r6ust
	 XE+7guE7Yw7aYQ3AfXxveQFH0/uhEaqptmM02Mk8rT45K96brfcRn7GZLRcn9LBpj6zo9
	 FQV8oDfIhgqrTxCEyOKquonNPOoPxZCH/CmGBToaEv143quy5vazekpT9IRF27wpB62Bi
	 UQwVFpUybGjfsoqrrr35cU3FiMl3/Ck4UUgWQlosSfqf/CuPT9ZMXbtjmm4U3CuaTuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405785;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=baHVzQWK6QitYPoz7RmaiN67zEu21Ve7wKubwk9k4yY=;
	b=GJK/3jgX3B4nFA2cUt0mqvZXtTE+cpt33afCIXLEMOCiPLJqCJW8eEV6zi9Q61NB6pR4
	 RtwwSnQ33tFfnXYHo6nzN/eK/ie4u6QaXbILCcXh4BSpf8FziGrKTRJakwaA4sCALGxg5
	 gTRpb9urnsG3/bo28C9DW233ESrSAPLWGoZqw7g29Snqsex4aT1XrX2NbfNypvVyT97Hi
	 HOhKw2JGW0IbLKOOJ6Jv3iYbmyThXPOKJayJwkuMk6v+kZ29syrXWCMixUWupQN7pZNjJ
	 6Wu5DJ0Oka1mCpet6hOAOCzlvmKPSuqqirFTgvRIO4s+2aVzD9WG6fO02ZYmVUX/eyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LImvnGYL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A57606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LImvnGYL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5781F00A02;
	Sat, 31 Oct 2026 00:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793405784;
	bh=baHVzQWK6QitYPoz7RmaiN67zEu21Ve7wKubwk9k4yY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LImvnGYL8w8HxHAAgi8VnDWm8ejLDa7bNUXzCsJnhGuiTwDT0bEw/GBBov5ibRJ7F
	 EAPgMNv9umlDl/Qlb6TG4JxFc2rc8pbGZVkb5rIwsuXg8q/fWzOsANtInh8vJjmDLy
	 ZE+Cprzb6IEwZTSoLCf+GxWxm0YblhditsoP8kG+v9vLgHlUb+e52yj3xkZoMFVcP5
	 g4ahlcrzo4e1bBMFMd2Xp+rGy7eDj/VfMnVK0SlDWLwOqhRUsEVBJiPMn4BcY9/XqB
	 QOBdovG5mNsjh6OqZFgwGxsQlue0y3bSy1xnS8CeDY319ZHfz5zxrC098Cy2SWLdoe
	 q7/ZXkKgEy+jQ==
Content-Type: multipart/mixed; boundary="===============4602126625831348860=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <68d4cce002dd78be96cb549d4d228cec0fca46ae9be77a82b7521bd56c06f684@mail.kernel.org>
In-Reply-To: <20261030233355.1836749-4-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 03/13] docs, libbpf: Document complete BTF annotation strings
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,alan.maguire@oracle.com,cupertino.miranda@oracle.com,david.faust@oss.qualcomm.com,irogers@google.com,jose.marchesi@oracle.com,vineet.gupta@linux.dev,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 00:16:24 +0000 (UTC)

--===============4602126625831348860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> docs, libbpf: Document complete BTF annotation strings

TL;DR: The BTF docs drop the old bare attribute-list form for kflagged tags
without noting it. Older kernel BTF uses it, so consumers following the new
text may print "address_space(1)" uncompilably. Should btf.rst mention it?

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 29de1222c3e7..98c1f0440f8b 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst

[ ... ]

> @@ -539,8 +540,9 @@ normal type tag, and the ``name_off`` encodes btf_type_tag attribute
>  string.
>
>  If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
> -__attribute__, and the ``name_off`` encodes a string representing the
> -attribute-list of the attribute specifier.
> +annotation. As with decl tags, ``name_off`` encodes the complete annotation
> +string, which ``btf_dump`` prints unchanged. An attribute specifier must
> +include its wrapper, for example ``__attribute__((address_space(1)))``.
>
>  2.2.19 BTF_KIND_ENUM64
>  ~~~~~~~~~~~~~~~~~~~~~~

The old text, which described the string as the attribute-list (for example
aligned(4)), is removed without any note that BTF in that older form exists.
Should the format reference say something about it?

Kernel BTF already in use is in the older form.  pahole emitted kflagged
arena type tags as "address_space(1)" via --btf_features=attributes (commit
21cb33c7e065, "kbuild, bpf: Enable --btf_features=attributes") until
27a78c2e7eee dropped that pahole feature.  resolve_btfids then emitted the
same string:

    #define TYPE_ATTR_ARENA "address_space(1)"

until 0c5eab4faab1 changed it to "__attribute__((address_space(1)))".

The kernel accepts both forms.  btf_ref_type_check_meta() only lets kflag
through for type tags, and btf_type_tag_walk() / btf_ptr_has_type_tag() skip
kflagged tags without looking at the string.

A consumer written from the updated text prints such a tag unchanged and
gets "void address_space(1) *", which does not compile.  libbpf's own
btf_dump_emit_type_chain() now does exactly that:

    if (btf_kflag(t))
            btf_dump_printf(d, " %s", name);

Later in this series, fd1278be39e3 ("bpftool: Normalize legacy arena type
tags before C dumps") adds a bpftool special case for this string, and its
message says "Older kernel BTF encodes kflagged arena type tags as
"address_space(1)"".  No later commit in the series touches btf.rst, so the
format reference never mentions the legacy encoding.

Could sections 2.2.17 and 2.2.18 add a note that BTF produced before this
change (pahole --btf_features=attributes, older resolve_btfids) stores the
bare attribute-list, so that consumers know to expect it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41147288626
--===============4602126625831348860==--
