Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A33F8704
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289700; cv=none; b=dkNvvObUjLal3uZGdXOB/M2T3RHQgMwdP4Rkz5aEIZTOXOrU2PZKprTVNpGckIiw1ijYTp5HDylfse1K/OHuKObEKRvICnac11COOo5IA77jiXDoX4Seru8MtHPycu7sPQe3END/ZGsX9CpkxlnS2Ov/XTq3hbKq5qEM7ZrHjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289700; c=relaxed/simple;
	bh=bgXt9c4zxA02uFUAduq0lI9ie5AiC3yxv2tFFKWY33M=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZIHGtaFfHblM2Jj7OBYlZhqoRgt89hcUyDe9g7DfWrygjRQUtvb+w3zJh8YXpkS2fQRLe5enjOGJKdv0Ad0BwDUN1GAHMJ+pQc9YdOI77g8hwmslqSSy//q1OacYKxPvKzjvEQfhb7eWUl7QPA06ccn56gx23e9GfBtrddF6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAjSN+mi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAjSN+mi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321331F00893
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779289699;
	bh=WWFivPTx91zuXcI5r/x1cQI4IilmWchj9LSqeR14CfI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jAjSN+mi22RKXmJbA0W1cdN2/X/68+nLKvRi3GZrAhtq7kQZ0rwSirqLuOKwy21lZ
	 WclgfHmy/x7bQXtAAiv4eiynCxqg6DYJMGE6tE22fyV/dDl7dLePctoZhEWO29GJPq
	 G9+V/UZwCFQVcUAO6MWZ7lFROrWzjIOGbhP5tgryp30VzZwrrotKFXsTH+7Tx8bG/0
	 rnYBXB02EyteAxTs/jmcTcDAcoYSDxNSHI3ggM6JINDMLVe4gsNQ8nUxyWM/cyKv8W
	 WSzXM80FYkTj1gZI44SzXw6S26Ec02KoqKwd5MmCvTsTM87eETJJjkCdpDUmwywiBt
	 5Ra+xkNPq/fWA==
From: sashiko-bot@kernel.org
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: add LOAD_AQCUIRE and
 STORE_RELEASE instructions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520143619.ruoAK0kKBUl1hdo1XdaRgCXMG0kniz395UgfgbgLZ_w@z>
References: <20260520143619.ruoAK0kKBUl1hdo1XdaRgCXMG0kniz395UgfgbgLZ_w@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 15:08:18 +0000
Message-Id: <20260520150819.321331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The documentation omits the operand semantics for `LOAD_ACQ` and=
 `STORE_REL`, specifically failing to document the reversed register roles =
for `LOAD_ACQ`.
- [Medium] The newly added text claiming support for 8-bit and 16-bit opera=
tions directly contradicts an overarching rule earlier in the document.
- [Low] Misspellings in the commit message.
--

commit 602df8abb53d7640dd0c274cc2b3fa86997d31dd
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, docs: add LOAD_AQCUIRE and STORE_RELEASE instructions

This commit adds documentation for the LOAD_ACQUIRE and STORE_RELEASE atomic
instruction modifiers to the BPF instruction set specification.

> bpf, docs: add LOAD_AQCUIRE and STORE_RELEASE instructions

[Severity: Low]
This isn't a bug, but there is a typo (AQCUIRE) in the subject line.

> Commit 880442305a39 ("bpf: Introduce load-acquire and store-release
> instructions") instroduced the LOAD_ACQUIRE and STORE_RELEASE atomic

[Severity: Low]
This isn't a bug, but there is a typo (instroduced) in the commit message
body.

> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 39c74611752b6..4f10bcd031509 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst

[ ... ]

> @@ -721,6 +723,11 @@ The ``CMPXCHG`` operation atomically compares the va=
lue addressed by
>  value that was at ``dst + offset`` before the operation is zero-extended
>  and loaded back to ``R0``.
> =20
> +The ``LOAD_ACQ`` and ``STORE_REL`` operations implement lighter LOAD and
> +STORE memory barriers than full barriers. The corresponding accesses must
> +be aligned, but are allowed for any access size (8-bit up to 64-bit
> +operations).
> +

[Severity: Medium]
Does this section need to clarify the operand semantics for LOAD_ACQ and
STORE_REL? BPF atomic instructions are encoded as BPF_STX operations, where
dst usually points to memory and src holds the value. However, LOAD_ACQ
behaves like a load where src points to memory and dst receives the loaded
value, swapping their roles. Without explicit documentation, anyone
implementing an eBPF VM or JIT based on this standard might incorrectly
assume dst is the memory base pointer for LOAD_ACQ.

[Severity: Medium]
Does the allowance for 8-bit and 16-bit operations here contradict the
overarching rule earlier in this document? There is an explicit statement
earlier in instruction-set.rst that 8-bit and 16-bit wide atomic operations
are not supported. If LOAD_ACQ and STORE_REL are exceptions to that rule,
should the earlier rule be updated as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520143619.ruoA=
K0kKBUl1hdo1XdaRgCXMG0kniz395UgfgbgLZ_w@z?part=3D1
