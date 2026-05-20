Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1D21B191;
	Wed, 20 May 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291993; cv=none; b=GLJQS2LIcieCn6sf7aQ3O66CMdqRIcpYJEP34l6UFPlnIhwWGKujgrrBKlwYR463Pg1ns4Tt+d/iBNjBTOVlHg72uLBH++UQjXHGnVqA4FZS82srLQSG/GwCjUhtBg/JbviSM1H8IWvVGX2dLgkNuWR7oWrQTntmReQXlkn4rh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291993; c=relaxed/simple;
	bh=TZH+rMvDegQFwVaH2eD2Rg2dbmHi6ZAZjsZrA9rPr38=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=DLqY/YwaUENw8P39harIMYISR3avdpx9RQY5EFYJnSoSfZfbfE4nSoH0PUDjzASa4LA4xMji/QH3hb3K+Ff1MXP6CFaO0DMiMA/3nZxQvNGNAECyVExdzq+S5/OGUfSQFPMrnbx6gKNBmapY6ygtEMV1lGTjO2hvznryGIIIA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kw6X2Lwj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kw6X2Lwj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 85D6E4E42D03;
	Wed, 20 May 2026 15:46:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5685060019;
	Wed, 20 May 2026 15:46:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E16D7107EA299;
	Wed, 20 May 2026 17:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779291986; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cfRNTAH818IUWJGgb+bd+5zxVp7Fbl8Z1v24qdUzGL0=;
	b=kw6X2Lwju3TtqEBuOKmLsB+JigNLGt59g+g/cA5d6IuQt/telkpinXB0YbLU683p4uIA6n
	V5Igu5qKadZccexFqmTviykYCbfSQRgYJ2eN4V8OPCiqsLd0mvZlut0eSp+O8zTFnG8b5y
	wpyEd+6Apvg05qvhSGxQxrNciwTHSMCt6M9pubSzyejSEasLD29mi/j5BkOdsTMsuIiecS
	fIHviMkJOS9TdXU9SEpdLbpG4zWd0BMWSnwlXdy6M+K8rOg+7KnzDh0l4GpzgW3mw5Fguk
	VbR959r0UCY63T9B1NB178G3x6DkQtOMwFB/o1u0oGpAXd5GecudhILUpvtzIw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 17:46:21 +0200
Message-Id: <DINMD7Y3ZG8Q.3GZGX7SX9CN57@bootlin.com>
Subject: Re: [PATCH bpf-next] bpf, docs: add LOAD_AQCUIRE and STORE_RELEASE
 instructions
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>, <bpf@ietf.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>,
 <void@manifault.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
 <ffe4e22a8e5d0fceefa7f9ecb378e038b4686aa417addd57d2af243b67607c0a@mail.kernel.org>
In-Reply-To: <ffe4e22a8e5d0fceefa7f9ecb378e038b4686aa417addd57d2af243b67607c0a@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed May 20, 2026 at 5:18 PM CEST, bot+bpf-ci wrote:
>> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Doc=
umentation/bpf/standardization/instruction-set.rst
>> --- a/Documentation/bpf/standardization/instruction-set.rst
>> +++ b/Documentation/bpf/standardization/instruction-set.rst
>> @@ -695,22 +695,24 @@
>>    *(u64 *)(dst + offset) +=3D src
>>
>>  In addition to the simple atomic operations, there also is a modifier a=
nd
>> -two complex atomic operations:
>> +four complex atomic operations:
>>
>>  .. table:: Complex atomic operations
>>
>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>    imm          value             description
>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> -  FETCH        0x01              modifier: return old value
>> -  XCHG         0xe0 | FETCH      atomic exchange
>> -  CMPXCHG      0xf0 | FETCH      atomic compare and exchange
>> +  FETCH        0x0001            modifier: return old value
>> +  XCHG         0x00e0 | FETCH    atomic exchange
>> +  CMPXCHG      0x00f0 | FETCH    atomic compare and exchange
>> +  LOAD_ACQ     0x0100            atomic load with barrier
>> +  STORE_REL    0x0110            atomic store with barrier
>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>  The ``FETCH`` modifier is optional for simple atomic operations, and
>> -always set for the complex atomic operations.  If the ``FETCH`` flag
>> -is set, then the operation also overwrites ``src`` with the value that
>> -was in memory before it was modified.
>> +always set for the ``XCHG`` and ``CMPXCHG`` complex atomic operations. =
 If
>> +the ``FETCH`` flag is set, then the operation also overwrites ``src`` w=
ith
>> +the value that was in memory before it was modified.
>>
>>  The ``XCHG`` operation atomically exchanges ``src`` with the value
>>  addressed by ``dst + offset``.
>
> [ ... ]
>
>> @@ -721,6 +723,11 @@
>>  value that was at ``dst + offset`` before the operation is zero-extende=
d
>>  and loaded back to ``R0``.
>>
>> +The ``LOAD_ACQ`` and ``STORE_REL`` operations implement lighter LOAD an=
d
>> +STORE memory barriers than full barriers. The corresponding accesses mu=
st
>> +be aligned, but are allowed for any access size (8-bit up to 64-bit
>> +operations).
>
> Does the LOAD_ACQ documentation need to clarify its non-standard register
> semantics? BPF atomic operations are encoded as STX instructions, which
> conventionally use dst as the memory base pointer and src as the value
> register. However, LOAD_ACQ reverses this pattern by using src as the
> memory base pointer and dst as the destination register for the fetched
> value, acting like an LDX instruction.

True, I can specify that both are anyway supported by a STX instruction.=20

> Additionally, should the documentation clarify that the loaded value is
> zero-extended into the 64-bit destination register for 8, 16, and 32-bit
> accesses? Omitting these details might lead to incorrect implementations
> based on standard STX rules.

I guess I can add this detail, yes.

> This contradiction creates specification ambiguity: the documentation
> states that LOAD_ACQ and STORE_REL "are allowed for any access size
> (8-bit up to 64-bit operations)", but earlier in the document (line 671)
> explicitly states "8-bit and 16-bit wide atomic operations are not
> supported."
>
> The instruction encoding section (lines 667-671) only defines two size
> encodings for ATOMIC mode:
> - {ATOMIC, W, STX} for 32-bit operations
> - {ATOMIC, DW, STX} for 64-bit operations
>
> No encoding is shown for B (byte/8-bit) or H (half-word/16-bit) with
> ATOMIC mode.
>
> If LOAD_ACQ/STORE_REL truly support 8-bit and 16-bit sizes, shouldn't the
> encoding section document how B and H size modifiers work with ATOMIC
> mode, and line 671 clarify the exception?

This point, and the corresponding mentions to the "atomic32 conformance
group" and "atomic64 conformance group", made me realize that the kernel
doc seems to be in sync with the eBPF ISA RFC
(https://www.rfc-editor.org/rfc/rfc9669.html). It makes me wonder if
it's really ok to add those LOAD_ACQUIRE/STORE_RELEASE mentions in the
kernel doc only ?

> Alternatively, if LOAD_ACQ/STORE_REL only support 32-bit and 64-bit sizes
> like other atomic operations, should line 728 be corrected to state
> "32-bit and 64-bit operations" instead of "8-bit up to 64-bit operations"=
?
>
> For a standardized instruction set specification used by multiple
> implementations (verifier, JIT compilers, potentially other BPF runtimes)=
,
> internal contradictions can lead to implementation divergence and
> interoperability issues.
>
>> +
>>  64-bit immediate instructions
>>  -----------------------------
>>
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/261706=
28668




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

