Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486734;
	b=VBmKK3LlAhSBpqtq8RbpjCijsUAhhnnhS8Nm3TCiit2PCitiB6dAWxBIafevSqUgA9MJ
	 Lac9tQyTdLDHS/JYBrKadUkZ5brXdT5gc+dURjLnMLhNGcNRrUdBbMtB+Jv6PC5EQeC7K
	 zkYBg5nX+W2R3hq12uLC8u3SWRmNvb6ExvgHtI4IMopoW/ZnGY8d//GdupuMjTbc1tqq7
	 AlL6tLuXcQEIO3wD7xeeoQDoGAkqDoYjJQgUVrPaJNY/FJBWUavs7UIkmizcQ7L1a/81g
	 yJ4bBVe0cFx04zVn30Jea7Ndt0Z8++F1rd9eQ+50JKhEqSHRicO+LwzJNIAny14eSZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486734;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=HlLZ9zGeNEup/rHEpny5JmMLv3fK5Tlr0wrd1y6qyXY=;
	b=IyehdeazHh7byR9b+KkNcUk1oI0F9BQd4+6EE4e0bC68+aQClf3AB21Vv+KHZmHrlzKV
	 uzGg5Lky3C6qKoDkU1anjwTPM3L97ARLHaBvAsTLg9n4/oAfno0gEu2EFr1gspVZsWLKb
	 UY1S0Y9Eu5OF1dIKIf1ep/uJdktsCtP7shtA8THnZ6kvtFk4AvHLeMyIgogZI/bTIUzev
	 9eT69ICOP02J8d/cXDoidcFznhZqxLcjQc6vpAeu1il1n9JE0Sy0gf0NITNlnwYIn3vX4
	 S+P4pLPN+uLdY0rn6L4VQXEadRHwB3DBzMneJThZTGetMBUgOl17YknbE7jk6F5aoqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwlNOE9A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC9606A31A;
	Tue, 20 Oct 2026 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwlNOE9A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C421F000C4;
	Tue, 20 Oct 2026 08:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486734;
	bh=HlLZ9zGeNEup/rHEpny5JmMLv3fK5Tlr0wrd1y6qyXY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EwlNOE9A6HClJkvde0kvUnzaqmRf601biMcVfJWjPPZAPytYo3tQ2sQspN5IdLrr8
	 j1LKmnLBwQ4VpNLE939lziDV64lDN1ppA9OjHtxyFTQorxqVCeeqqvOCfFJG7p8Egx
	 tn7AU4U63x6jl0VWqgQjuQbUS9YZsLXNhaLarB2KdlyJTu4oVzLwf45aPqOM5euA2P
	 9jQrzNi9IlM4mQS7knsGSVoJN6EHvMXzKQSveHO0qJdIlLJfLo4pPB7MU15S2LWNtj
	 3qnN98lfGiaC2xxxviQYyqR0znEe7mJN2E/F3jaWyI1VXLxrGWxhz1C6ns+teAQ8l3
	 MT8nrF3+l/xEg==
Content-Type: multipart/mixed; boundary="===============0961616978328380911=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a02301c0ff8593349602f81cdf0c21f1b38db0b60118f8eed3199a6a38330234@mail.kernel.org>
In-Reply-To: <20261020083713.905006-1-yanxia@cmss.chinamobile.com>
References: <20261020083713.905006-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH bpf-next v2] tools/bpf: Remove legacy BPF tools
From: bot+bpf-ci@kernel.org
To: yanxia@cmss.chinamobile.com,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: yana06070@163.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,corbet@lwn.net,skhan@linuxfoundation.org,rdunlap@infradead.org,richardcochran@gmail.com,netdev@vger.kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 08:58:53 +0000 (UTC)

--===============0961616978328380911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/bpf: Remove legacy BPF tools

TL;DR: Nit only: the reworded filter.rst sentence says the instruction table
lists opcodes, but it only has mnemonics and descriptions, so the new wording
may mislead readers.

> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> index e0b9dc14a9bf..ee35cea6face 100644
> --- a/Documentation/networking/filter.rst
> +++ b/Documentation/networking/filter.rst

[ ... ]

> @@ -213,9 +210,8 @@ contains a miscellaneous argument that can be interpreted in different
>  ways depending on the given instruction in op.
>
>  The instruction set consists of load, store, branch, alu, miscellaneous
> -and return instructions that are also represented in bpf_asm syntax. This
> -table lists all bpf_asm instructions available resp. what their underlying
> -opcodes as defined in linux/filter.h stand for:
> +and return instructions. This table lists the assembly notation and
> +the corresponding opcodes defined in linux/filter.h:
>
>    ===========      ===================  =====================
>    Instruction      Addressing mode      Description

Does the table that follows actually list opcodes?

It only has three columns: Instruction (mnemonics such as ld, ldh, jeq, ret),
Addressing mode, and Description (prose such as "Load word into A").  There
are no opcode values like 0x28 and no BPF_* opcode macros from
linux/filter.h or linux/bpf_common.h in it.

The old text said the table showed what the underlying opcodes defined in
linux/filter.h "stand for", which matched the Description column.  The new
wording reads as if the opcodes themselves are listed, so a reader looking
for the encoding of an instruction will not find it there.

Would something like "This table lists the assembly notation and what the
corresponding opcodes defined in linux/filter.h do:" keep the original
meaning?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39395316270
--===============0961616978328380911==--
