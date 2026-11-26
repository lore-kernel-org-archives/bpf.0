Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715109;
	b=c/NYS/NUb9Uetw4gNANsdlBS/MoV+kv1snV8zWE/nm4XyxLVAHf4QLNEHdUk9i8DlAik
	 twHTqSiaZvvuZ5I6XCphcI+7HKFfpQBHo4PTOoOxK6jfX4TDxsTTaafXdsFyUW89kHOl1
	 vU3vyjhybsA8D9FBxH9UGCCTDpEX5jqvZHZkyB2o/Yn9dTw6nA/R0Rhvy8MxY6TGYusha
	 CbvL4JhaO24CDG/1T1TXS6VEmoHLi9cFRjF8ndyiDPQEdeJPEmFjFQBuNbWV/iceOz8rp
	 2q6jicR4xaI/UICk1uRINlYaFT8+S89s+jtt17tRvD89LcdojSxIPJfFqjRAgp9ImzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715109;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=UVwKvUqZc3YTIGZQosfwnsDxlaSdrCZ8Jhlv1YMbjOM=;
	b=z1r7xCc4l0RKTf0O9NIoFDtepIenkwQ/w6wrlY2ofdaCzqYRaWK52AiqazSiDPX2CvkZ
	 bBlLcyBaT3BJdaEDvtlqJMUUK13toH6tKFc00/1NuaR7wZBpGuGzo8vTP1OIpTuAZAK3w
	 JIPaLoxcyLvJCg+tudI3HUxv9lqyJ7kZ47AT8zm8XPO/aoWGmFseDLoWgCbUD5ADjmVJA
	 JqM10zWLXmS+2eN9RGS+mAqt10W6ezm2U2VuJJjisC1vhHtRupjcIiiuPohKibrrbi9N9
	 D+f/kl0Ay9Rwlo/21xqJrMXvkfz411/UJd5d2rF9Ym7yHOHe9ZHOpwFsLTql/xnzFjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9KoWkCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87C606A327;
	Thu, 26 Nov 2026 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9KoWkCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F411F000C6;
	Thu, 26 Nov 2026 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795715108;
	bh=UVwKvUqZc3YTIGZQosfwnsDxlaSdrCZ8Jhlv1YMbjOM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=B9KoWkCz5lur7rU3+m/m0+34kzI7sd3+putoPB8nGh8af+bYaAqekCFoAHTTDTpTL
	 ZsLUQQ56kuB289CSTCGySB/Nina/JbyRyZ68huuATJcYmq4quRmbRbbZbAyPENQaTB
	 721r0/pqCreV8UMwFOSrd5GIrup56RPy2FDHsDeDB6bmCVukJFFBp6eanbSxnuyyG9
	 g0Irzy2agVNA1W6bN2lZJ5C4OTVcKekAucDEZTtMeWNjHmGZSp8s6AHEwTh9XSuHDu
	 SdmDi8WtP3LP0PT5NHhvQIVDNWEJIKBTTYFujFOLJB90Xq3M8rjaNHlpuIO3ns7rfv
	 8n703OMD6826A==
Content-Type: multipart/mixed; boundary="===============4556629013773228158=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0eb06d3a00f2e4d56c2f25db16eb8b02160387281fe455b0e0e5d7466492657e@mail.kernel.org>
In-Reply-To: <20261126170538.3471057-1-visitorckw@gmail.com>
References: <20261126170538.3471057-1-visitorckw@gmail.com>
Subject: Re: [PATCH v12] m68k, bpf: Add initial BPF JIT compiler support
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,corbet@lwn.net,geert@linux-m68k.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,gerg@linux-m68k.org
Cc: skhan@linuxfoundation.org,rdunlap@infradead.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,marscheng@google.com,eleanor15x@gmail.com,jserv@ccns.ncku.edu.tw,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,linux-m68k@lists.linux-m68k.org,bpf@vger.kernel.org,visitorckw@gmail.com,daniel@thingy.jp,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 17:45:05 +0000 (UTC)

--===============4556629013773228158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> m68k, bpf: Add initial BPF JIT compiler support

TL;DR: Nits only, no bug found: the m68k JIT hardcodes the tail-call limit
(0x7021) and the 44/48-byte prologue jump offset; suggests named constants and
a check so later edits don't quietly break tail calls.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 000000000000..96305a8478c7
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c

[ ... ]

> +	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
> +
> +	emit_16(ctx, 0x2068);					/* movea.l d16(%a0), %a0 */
> +	emit_16(ctx, offsetof(struct bpf_prog, bpf_func));
> +
> +	emit_16(ctx, 0x4ee8);					/* jmp d16(%a0) */
> +	emit_16(ctx, CPU_IS_COLDFIRE ? 48 : 44);
> +

[ ... ]

> +static void build_prologue(struct jit_ctx *ctx)
> +{
> +	int total_stack = SCRATCH_SIZE + MAX_BPF_STACK + 8;
> +
> +	emit_16(ctx, 0x7021);					/* moveq #33, %d0 */
> +

this isn't a bug, but could the tail-call counter be emitted as
0x7000 | MAX_TAIL_CALL_CNT instead of the literal 0x7021, so that a grep
for MAX_TAIL_CALL_CNT finds this place if the limit ever changes?

Similarly, emit_tail_call() jumps to bpf_func + (CPU_IS_COLDFIRE ? 48 : 44),
which only holds while build_prologue() emits exactly 44 or 48 bytes.  Could
that offset be a named constant that is checked against ctx->idx at the end
of build_prologue(), so a later edit to the prologue cannot quietly break
tail calls?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45866130532
--===============4556629013773228158==--
