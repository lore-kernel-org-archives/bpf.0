Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592830BF68
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288655; cv=none; b=dRlbh7xyKrCiXUObTt4SGw25dUzWPV652na+WsH+/asLqjXLAlDEr5RDoItd0sXVnyuN+d3/V08MjKcxyH+OQe8guG23IEDtrbkOtVy4aRr6z+7FMlhpWDWn9Q5k61Wrs7ChQiaSszP+zvYCqlV22jdsGmmvEWKU2BuTrKCVJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288655; c=relaxed/simple;
	bh=eJCAJ2PphsFWriba8cs40BeEPSpFdCPrUnLRe/h/hTM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NGuMDsDbsNdP0FveseP9vAurhVoJLU+4zH+W33z2u/MqImyTjvMEleWbmutVccHCpAulBEkwDSsbYNe7Nn30nbJmJCXBnSkDL0aFQMK3wG833ZV3wkhbCiNoQ/FrrsDXveoeLDPGVc+MQbxlkcScCU17plk+IyObC9wHdSaYEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOY2/jeX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOY2/jeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D6F1F000E9
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288653;
	bh=T6Vo+yyF7eXP7qcV4fT0SQNhgeTFe4pjYbhkswIg2ks=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SOY2/jeXgHoRhbrbBI/MHANQidNHmQ9aZD6NrnWQeOPVKiXKYFnQQ+F6iAXCDSOFr
	 RQZJZuGikje7lq1mDLwl2oMOiXBVTiwlhUYUkw+XSatQnU0NWXj9gBkYucCeJ1BVUx
	 j8N1vgZxd4FrzxZqkkMeEi6zoXfmijn9Eoj2fByLuTmb7StiOTXl4zVcC1LT74TJ11
	 Ia+dTkEYVtmv9Frjxb3dAY/WqP726T1Brpzyq12fkEhXKMbQfRuuEq0uDxndwEkUFT
	 jyDGchXk0OkkPWyaXfiVKonN5Fa7RB3Hd5RGdKlTIHTKIZGYD1Po4r5Q4/5Yi6aIOm
	 Lh2i++hOmk8Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf, docs: add LOAD_AQCUIRE and STORE_RELEASE
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
References: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 14:50:53 +0000
Message-Id: <20260520145053.B4D6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The documentation for `LOAD_ACQ` omits its non-standard register=
 semantics, incorrectly implying it follows standard `STX` rules.
- [Medium] The patch introduces a direct contradiction in the BPF ISA speci=
fication regarding the support of 8-bit and 16-bit atomic operations.
--

commit 4a364f35f447b6c2f70368f613fd99a53b9e5f28
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, docs: add LOAD_AQCUIRE and STORE_RELEASE instructions

This commit documents the LOAD_ACQUIRE and STORE_RELEASE atomic
instructions in the BPF instruction set specification. It updates the
table of complex atomic operations and adds descriptions for their
execution semantics and memory barriers.

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

[Severity: Medium]
Does the documentation for LOAD_ACQ omit its non-standard register
semantics?

BPF atomic operations are encoded as STX instructions, which conventionally
use dst as the memory base pointer and src as the value register. However,
LOAD_ACQ reverses this pattern by using src as the memory base pointer and
dst as the destination register for the fetched value, acting like an LDX
instruction.

Additionally, does the documentation need to clarify that the loaded value
is zero-extended into the 64-bit destination register for 8, 16, and
32-bit accesses? Omitting these details might lead to incorrect
implementations based on standard STX rules.

> +be aligned, but are allowed for any access size (8-bit up to 64-bit
> +operations).

[Severity: Medium]
Does this introduce a contradiction with the global atomic operation rules?

This paragraph states that 8-bit and 16-bit accesses are allowed for
LOAD_ACQ and STORE_REL. However, the global rules in the Atomic operations
section strictly mandate that 8-bit and 16-bit wide atomic operations are
not supported.

Since LOAD_ACQ and STORE_REL are classified as atomic operations encoded
with the ATOMIC mode modifier, this creates a contradiction in the
standard. Should the global rule be updated to reflect these exceptions?

> +
>  64-bit immediate instructions
>  -----------------------------

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-bpf-insn-d=
oc-v1-1-74d7dada9bfc@bootlin.com?part=3D1
