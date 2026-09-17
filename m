Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEA3BBFB4
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622575; cv=none; b=ft516pejs4Xcz6l2Tfm8mkssAoOpehJQQOz/xhcaMkdP+n6bUDB/Us11qk5zf7gaV43FF+nhWwNjsbKH9nsKlY8wWwTkXrfsT3xdGuNNb42J/98zOUwdkxBCBD11ZjKn29LW+NZ2UsMQq97Sg2o2vxwhSbD9PaDEwE3Jz3YPqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622575; c=relaxed/simple;
	bh=moLm0EqipBbW/Kccooxf2Odn7bFKD9Y+EZ4YvbRC8WU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gbZ3M3reV6heaFWtUq2rTDjHLSguwoJfedFNk1c5gBi5TwSbxJLtLWSK9rvBDD3yrIhcidP7KdzH/vMBCm3tTtKn2FxXe855qrWKXzLiKpPcLwVWnHcIXvO76zk5ADN1+aoHlpgW7AP0LUDrvoB72s2xcV71lMCfHL9mrfEgR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv4VUmWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv4VUmWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487CD1F000FF;
	Thu, 17 Sep 2026 05:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622574;
	bh=13TfV17yBYNe6CYYdbztB+huE0mYoKjC9Dk50OhyhZw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mv4VUmWEZK9vf1WxWU8jK+Cpt7bJP/Jp6/VCrybv+CcKKVjNaqOVeJdFHaUm3QpWY
	 7ZulJyNU9hdW6IuUddjTZClHtxDbfLt48flIx4GFRil0fG7D25EAYZ7jbauKFPGkFV
	 1D5yICC1l8tmuTsSZX7RgZ706jy0oQaPF7Mftqmct6phTw9XYYvsAhCG5p601Zte47
	 fJN9FFxnwvDc2De6yAym7srZMvx962oIZ93QMbnRMmSZMpRFHhvjeAc/9BoO+GaKmh
	 Iz3a3oRbE+F/gy61W3asFRturPzxWy5alEW1iRkR76/V+7B51gI61TNc0Qp4BT3Dqu
	 vTD2FDbD0ORFw==
Content-Type: multipart/mixed; boundary="===============5532677064711485521=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e6055fb14ceaf6cb1578d60e528708850341b4962410a9fb6dc5f5be9313241f@mail.kernel.org>
In-Reply-To: <20260917041712.1860722-2-tangyazhou@zju.edu.cn>
References: <20260917041712.1860722-2-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf-next 1/8] bpf: Add UHMUL and SHMUL instructions
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org,ast@kernel.org,eddyz87@gmail.com
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 05:22:53 +0000 (UTC)

--===============5532677064711485521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> These operations are inspired by the UHMUL and SHMUL instructions introduced
> as part of the PQR instruction class in sBPF sBPF (Solana's BPF variant)[1].

Could you drop the duplicated "sBPF" here? It reads as "... in sBPF sBPF
(Solana's BPF variant)" which appears to be a copy-paste error.

> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index 39c74611752b6..3c2cde11fa234 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -330,6 +330,8 @@ register.
>    ADD    0x0    0        dst += src
>    SUB    0x1    0        dst -= src
>    MUL    0x2    0        dst \*= src
> +  UHMUL  0x2    1        unsigned high-half multiplication (``ALU64`` only)
> +  SHMUL  0x2    2        signed high-half multiplication (``ALU64`` only)
>    DIV    0x3    0        dst = (src != 0) ? (dst / src) : 0

[ ... ]

> @@ -379,13 +381,33 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
>
>    dst = dst ^ imm
>
> -Note that most arithmetic instructions have 'offset' set to 0. Only three instructions
> -(``SDIV``, ``SMOD``, ``MOVSX``) have a non-zero 'offset'.
> +Note that most arithmetic instructions have 'offset' set to 0. The following
> +instructions may have a non-zero 'offset':
> +
> +* ``SDIV`` and ``SMOD``: ``offset == 1`` selects the signed variant.
> +* ``MOVSX``: ``offset`` selects the source operand width.
> +* ``MUL``: ``offset`` selects the multiplication variant (see below).
>
>  Division, multiplication, and modulo operations for ``ALU`` are part
>  of the "divmul32" conformance group, and division, multiplication, and
>  modulo operations for ``ALU64`` are part of the "divmul64" conformance
>  group.
> +
> +For ``ALU64`` multiplication, ``offset == 1`` selects unsigned
> +high-half multiplication (``UHMUL``), and ``offset == 2`` selects
> +signed high-half multiplication (``SHMUL``).

Does this addition silently make UHMUL and SHMUL mandatory members of the
existing divmul64 conformance group? The document's own rules at lines
123-125 state that "supporting a conformance group means it MUST support
all instructions in that conformance group", and the unchanged sentence
above says "division, multiplication, and modulo operations for ALU64 are
part of the divmul64 conformance group."

UHMUL and SHMUL are ALU64 multiplication operations, so by that classifying
sentence they become members of divmul64. Because group membership is
defined as MUST-support, every runtime that currently advertises divmul64
conformance (rbpf, uBPF, the Windows eBPF runtime, and any other
implementation tracking RFC 9669) would become non-conformant the moment
this text lands, even though their code has not changed.

The classification is also internally ambiguous. The document states at
line 320 that "ALU64 instructions belong to the base64 conformance group
unless noted otherwise", at line 136 that "base32 includes all instructions
defined in this specification unless otherwise noted", yet the two new rows
carry no group note at all - only a parenthetical "(ALU64 only)". A reader
can arrive at base32, base64, or divmul64 for the same two instructions.

The expected pattern for new optional instructions in this document is a
new group with its own label (compare "atomic32"/"atomic64" and
"divmul32"/"divmul64", each introduced as its own bullet at lines 141-147).
The patch adds neither a new bullet nor a note on the new rows, and the
changelog does not mention conformance groups at all.

Shouldn't UHMUL and SHMUL either be assigned to a new conformance group
(for example, "hmul64"), or carry an explicit note that they are not part
of divmul64? The existing conformance framework was designed for capability
discovery between runtimes and tool chains - growing an existing group
without notice breaks exactly that contract.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35182532243
--===============5532677064711485521==--
