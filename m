Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163111;
	b=IxRtP1oH0KpmA9vCB8svbKmwMImdpaZcKNVbdbUH3njBeOUxWkOCRQG1oYgLaTK0Khfl
	 Q3KwIoiv28OIuHY1MNlga71ZslXCYN9x/0OK4DFL1BELagtfQ9CRMjIkLkExzvMiK4yyM
	 TkF6QI8WxeXx50jwjdc6G0rQJAcLq0ia3jKQti0B4AqFk3ziU1b/DxdSlpn3mGBF6Yx+f
	 aG0COCzmuleQRBWvngNnqTXzE1OZcLKm50s6kf3ZLy7c4HGhs2cfyiqv7M3NwtsY6wC/d
	 RHXK9L8UXD+1EHq7B4ZLowRwyAeqVn5/K7rH5K/A+CbBBs/ODJjZbHSUKxqS+8AOw4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163111;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=XV8RySojotWcJFaOolqssSkG2uXJbfTp9SWYwhQ17i0=;
	b=jTl7slqBbrX3kb0pOKY9jOkyAe/umi9go8+GFtIEsMVeD0dnCTH9WNa2H/mUaN/ewenn
	 jodxs2JJaUgl6Vm96gihplhUgZ7Ono60mxZ+jD5EJ+uWACv+ri9VvhEL1xD4gMitk+tyj
	 jexaOGAAy6W5rD78w4B9oYUTK41q+6B++0AQ+anDdNcNP6pRzvmS9r2cm3tcnLCCJltJ0
	 XdYgXM5BqDZX4nH/ElAzS6aBGCC0j4OUJIhMWAWqqRzzIEIaYF1SN+Je7OCL9Babcl4PV
	 ktsyiIOjh90g99w7kdlvqQ6AyUuBCG5cdy7eNtwx1VFuNzfTCglf4cQa5+zv2Ksl+qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnT5Jjzm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAE606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnT5Jjzm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38261F000C4;
	Fri, 20 Nov 2026 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163111;
	bh=XV8RySojotWcJFaOolqssSkG2uXJbfTp9SWYwhQ17i0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EnT5Jjzmv85LTq3rcrKAeP1qrX8rN1ggAyUrSyfFdqRBVj0pEv6IQ9H8K/lyQoKqk
	 oW2ws01pK3gs7D2REAelv2yggKTRTb9KgSUw+97G6XWH+VmthAxoQ3evsrbYrGLw44
	 lPlTdZIs+Yfzc1CbxTAp7oXJwuZGreg7UDsC7YUMQ+GsOBpeNx2X6W7cEC7ZnhEPoK
	 pdpm7u9DZqxO5lfCvTkuEXJL+rWpvzZHi4cOik8FxBJAyWcjAX0KCqLI/fh0XBvld/
	 LqwnQU9oCSuHsXodC015av8XOS51VhnNSUydaPG+s4Wb/6hn8FcdUKSuQVQo88ApD7
	 EtWgI/ii4h6Og==
Content-Type: multipart/mixed; boundary="===============4173948025042138649=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ff74e144fb871a287cea9ca6ac2821347ca5c76a4cfeafc1bdfe9e47dac01e7a@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-7-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 06/49] bpf: Record what each insn reads and writes
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:09 +0000 (UTC)

--===============4173948025042138649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Record what each insn reads and writes

TL;DR: The new LD_ABS/LD_IND liveness rules likely change the logged register
masks, so the compute_live_registers ldabs selftest probably fails unless its
expectations and comment are updated.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -2680,7 +2691,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
>  			break;
>  		case BPF_ABS:
>  		case BPF_IND:
> -			/* stick with defaults */
> +			def = mask_widen(ALL_CALLER_SAVED_REGS);
> +			use = reg64_mask(BPF_REG_6) | (mode == BPF_IND ? src : 0);
>  			break;
>  		}
>  		break;

Does this change break the ldabs test in
tools/testing/selftests/bpf/progs/compute_live_registers.c?

That test still carries the comment "No rules specific for LD_ABS/LD_IND,
default behaviour kicks in" and expects the old live_regs_before output:

  __msg("2: 0123456789 (30) r0 = *(u8 *)skb[42]")
  __msg("3: 012.456789 (0f) r7 += r0")
  __msg("4: 012.456789 (b7) r3 = 42")
  __msg("5: 0123456789 (50) r0 = *(u8 *)skb[r3 + 0]")
  __msg("6: 0......7.. (0f) r7 += r0")

With def = r0-r5 and use = r6 (plus src for LD_IND), the masks computed by
bpf_compute_live_registers() for that program become:

  insn 5: ...3..67..  (expected 0123456789)
  insn 4: ......67..  (expected 012.456789)
  insn 3: 0.....67..  (expected 012.456789)
  insn 2: ......67..  (expected 0123456789)

log_program() prints these masks and test_loader matches __msg() literally
and in order, so test_progs -t compute_live_registers should fail on the
first of these messages.

Should the test expectations and the comment be updated in this patch, or
in a selftest patch placed right after it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============4173948025042138649==--
