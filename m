Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505693;
	b=ciae85W7whk7WfhbqbbHCw9S8kP3I8flaXPMWJ8Hy5JcNS+kaOj0PBWgGMAJnd9GVYw7
	 uNX/lCe2lLP2yVdGKyLalcH5kYzLdWf7cLJ8tfBTocpbeKU5+9FYM6xP/dlNT2FcaQLSZ
	 5yt/e9jA62HUTS5CgHsBcyjpelvm4pwfFpidfmhjOCmKP/+I5McOUtpaf2rpMV8Kqsa4H
	 mPdwfZ3ZwJ6c9KhV5Adkt3Vc2WFt4TrhYOHSibr4L53dOten0ocJGKd2Aqp+Jgslk1EWv
	 29Xz1FjRFUga7E+8aygtrGptXf5VxDJp85URZAnXT9z59Dd0Xzo0CDlx9iZeGLlgoMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505693;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=31WA8ctJSCGUr6/CoXZYxbi0iXEgWXplHNzMtGzZR/Q=;
	b=kjuLCRAlQnzM4kZlIK8Q9M3R1XUAIo2iuchPPGJeNfsLAFfes7f6+x2tIpu+3ozlFkYB
	 wURhUdiIEhVsTqHVDNt7QM9d5ISZ4yWWSL8oXUbynIaNmd2sI7Qj4ARR64dIfDQur4ExQ
	 vPSjS2MbUyRyqqUxanqZ6XexMHZiFLC9ArQthCIwDRFfn3USgHHjccv9ahBJDXestJgu5
	 r2glb0l+6Xr51o4hCdcp+rO3M2lxBncWEPQ4XQS7vE7+vgjBjdz15GteL/evb5ctsS5IR
	 t9GxWPHuOXEZAgkesjetv1oBHRZugoCZ/HCOg35qCGM6OFgLnfEK/0rhlIkRCdniE5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ni69Ghof;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F40606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ni69Ghof
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A621F000CA;
	Thu, 12 Nov 2026 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505693;
	bh=31WA8ctJSCGUr6/CoXZYxbi0iXEgWXplHNzMtGzZR/Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ni69Ghofbc52vX8/cvQOA+VW4mjpCwro5MkZMRaVbd9o3YVN00kN28TICpvHUYsyx
	 +6nSUAKRdsassyBhHGTGyPfjE2wWKfzbeSvuI88ck+thflGj2hZBWqAHnVgoRxeLIs
	 Rw5AYmEzPvibHOOh4DovJQ5udRXADp8aBvuFFJv1GR0kZCLpHjy2b2vg1/C4ELJNRf
	 yGwLdhp6ye3kE5Y/czcTxKwsKVlCIdisGjokuHKn7f//ea5IKgk0K1C0erLTpPyT4W
	 H1ZC0B+N4nY07wqbOY5+xx7T3YeUNJjL9Vd8Q0zvd2dEJN/5y0njIosBnlKlsyAfYl
	 JlYTc4emUNyhQ==
Content-Type: multipart/mixed; boundary="===============6092304072687231429=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f933eb8eaac3f8f409a92d630b1635eae2dee8135a8e98b7f873daac08b3eb39@mail.kernel.org>
In-Reply-To: <20261112164610.1917256-8-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 07/10] resolve_btfids: Say which registers an instruction reads
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 17:48:12 +0000 (UTC)

--===============6092304072687231429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Say which registers an instruction reads

TL;DR: In resolve_btfids, uses_of() may miss registers read by TEXT_OTHER
opcodes, e.g. RCX for rep stosq, so the uses field may be wrong; effect on
tags is probably negligible.

> diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
[ ... ]
> +	u32 uses = o.implicit_uses;
> +
> +	if (o.unmodeled)
> +		return TEXT_ALL_REGS;
> +	for (unsigned int i = d.MII->get(inst.getOpcode()).getNumDefs(); i < inst.getNumOperands(); i++)

This isn't a bug in the common case, but is uses_of() complete for opcodes
that have a TEXT_OTHER pattern?

read_opcodes() clears o.unmodeled for every opcode with such a pattern, and
the pattern can only add defs:

	} else {
		it->second->unmodeled = false;
		it->second->implicit_defs |= pattern->defs;
	}

So for these opcodes uses_of() trusts MCInstrDesc to list every read.  For
x86 STOSQ the table notes that this is not true:

	/* A rep prefix is not a part of the MCInst */
	{ "STOSQ",		TEXT_OTHER, .defs = BIT(RCX) },

RCX is added to the defs, but nothing adds it to the uses.  The MCInstrDesc
of STOSQ has implicit uses of RAX, RDI and DF, so decode() of "f3 48 ab"
(rep stosq) would return uses = BIT(RAX) | BIT(RDI), while the instruction
also reads RCX as its count.  That contradicts the text_insn.h comment ("The
registers which it reads. TEXT_ALL_REGS if the decoder does not know it")
and the commit message ("An opcode with hasUnmodeledSideEffects() reads all
registers, as it writes all registers").  The existing "f3 48 ab" test does
not set .uses, so run_tests() does not catch it.

The consumer added later in the series, transfer_based() in 900a02fbf86e
("resolve_btfids: Don't list an error that follows work on an argument"),
reads !(insn->uses & based) as "computed from no based pointer".  If RCX is
the only based register going into rep stosq, it would clear RCX and RDI
from the based set instead of keeping them.  The effect on tags is probably
negligible, but the field looks wrong for an opcode that the table handles
on purpose.  Nothing later in the series changes text_mc.cpp, text_mc.h or
STOSQ.

Could a TEXT_OTHER pattern name extra uses (for example .uses = BIT(RCX)
for STOSQ, ORed into implicit_uses)?  The comment about TEXT_OTHER patterns
in text_mc.h would then also need to say that they cover the uses.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43267213382
--===============6092304072687231429==--
