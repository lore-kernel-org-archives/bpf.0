Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D737F738
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645368; cv=none; b=mfRJCEw//uxAkYCGYo5MDKIo/Zop4vnQIRJX50QGUQcwbsYs/hA4jg5jK1B4Rp4EulB31k6RBINDXifXWqCPFqHGsHNMBe7b0RbyxnimQ9Sn5FFQXjRlBbxI+omrIxt2oTwztPTlQC90Yxt6hyejI9ymY4QZH0hOP8S6xJshnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645368; c=relaxed/simple;
	bh=pBu865joFVe85JVTOBwNVQFZC3vq13cNHGr43GQYHcQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=bLIQsOZKZ9rrA8qeM9v+DMOATv/hOh8co/a5QzKg6NzbtlM+Yzq6U+vAbVVSsDxG1K/gBqxTIWTMODqY/IDi+1Bkv1t6D7uJ75WoWI8ZRo8dWV3JRaYpN0Jk8yYlILffRrCECmGr0+tN2IU//gvNF0RDi936o4+fk7Cb7kU/eA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr3kEv5V; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr3kEv5V"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398b3c37877so262458a91.0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791645366; x=1792250166; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CAhU/f94yA5MJ19+HwlVBcw68pCp5HAO2C8k5hVfaXY=;
        b=Kr3kEv5VYzpCLDV+fk/Po0cxqP7Eiayod/RuRukGZQGi3WOv6SICRRBD1KiHLRHOgg
         WnmS0KODbqrf32a3YTR949CZWAI+v/LTR2bnyzz8hmJKzEbQNjMLJmIh7V8oceKaWG8M
         +tE+hYhRYmgk7rS6pmI0Ed4A8Us5bVoJ+M3a4Yggaed4CnOBNNMKZQ+mEfue5Ki8WRxj
         foq3rg6qu/mCFF3OBrdgO31QEWEC3tl5++8YGM8iscivBu0LCSu1RCrcqTgk1dZXUE26
         MjhbMCZB7q59AddRhjkOMlikkyoa4arlqjMJsNNaHaywrykSy2HGI4w6xvlq/YO/iLgn
         eL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791645366; x=1792250166;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAhU/f94yA5MJ19+HwlVBcw68pCp5HAO2C8k5hVfaXY=;
        b=12M8cnUsAhKAoymcSOeaF9KxYS7b80Kp5I0z1x+0m8OxYlYosN8t6DUlvZcNO91hPO
         vTFwoFHIMuw9WlYYSr8Y7copdS8OkpOIHufSO+MZTZA6O+8C7IuUQyRLkUvtCgwAzpE1
         1qIDOJ1NpE/4GA57PnYP+b9jHQtBJdQFl9snpyMoN/qyw8usQSZOhBTxg4qzyvMIZgMO
         3xYlKUGYivxL6hT/M5oeyoxsfXSM9isAv8T8H5SyhDoDHKZpzz3fgoJMCBY0KkFsqM0l
         iGsTgHeF5QQ0xb1p0c3FXtAfXcteah4q8pBcnoCtPzTXvuq83OmiL7JLjUmbncU+QjtH
         1KrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHzNuq/j4eEV5/wFyeGoEYSzjR9ACaLaBi1sQdOtQgfJGoFJXMbsEHhWOsNsAMekbvoso=@vger.kernel.org
X-Gm-Message-State: AFq9FYKM9+szFyVCyxgsbKopvBVqJoO+b4nmuy4ITto4i6HFeikvVeGo
	blKEvZeIfttLOvyqxU9ah+/UBrxNmNg8as4k6ys+N1E3A2l3BrJ7xNyK
X-Gm-Gg: AYBFou0tEs0lV3HglAIynvhjd9NyfgbahEIW4nAuYZIWaJuzsJ6u3dnO4xnoMovP6MW
	fZAjMcqDml3+yCgn0rAPHC6bwes1hZ2Sq/bNDQ4Mda7uzBP2vaI294k5iP/xPjkZ/egG/+9OfHK
	6UvqWjWAhsvYPMstoDtXTMjRxPrgyshJBsddE/TWTQkD88E6yiCRp++Yqf3waVHtmsx7i84jJ3w
	bUps+tBl6rIQ4lGMKRdEEj4OmUor/wd0m2bDJpR3ryTVxLvJA64IEs0hlRctB33HUoMNmIVfDB2
	JFmeZ9iduh9MsQ0AaH1HrZCk2auyNGJEEtQuS97IbM1P1t0A6FE0aVlV4s5dWTw/bQmS/Ge8gRK
	4eec+tcftuxFt8Aiy3jxj9slTPeO7AfMhoAZef7t89RQ1m4ORyqicfPZf1unOlFYih/PsjAGY/l
	0+qIiX6uKkSxG03plr6Wpaln8b55mXTeurschZZbkMmP2Z7xAhNVfytoABtpilk2psfAbeq+R7Q
	5G1FgDbE2NDLolqEKRqW/DtT4EYiS/K3wkoBSrhVjB3sDQ8I2Bun96ZthbCn0PE/eO1fdPfspnJ
	gF6Z
X-Received: by 2002:a17:90a:d44b:b0:3a8:e1e:3390 with SMTP id 98e67ed59e1d1-3ab3afd49c9mr4437717a91.56.1791645366135;
        Sat, 10 Oct 2026 08:16:06 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f4737esm8539860a91.7.2026.10.10.08.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 08:16:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 15:16:04 +0000
Message-Id: <DM199Y25XQ6Q.X5YFLA8I7RSJ@gmail.com>
Cc: <rdunlap@infradead.org>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <jserv@ccns.ncku.edu.tw>,
 <marscheng@google.com>, <eleanor15x@gmail.com>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-m68k@lists.linux-m68k.org>, <bpf@vger.kernel.org>, "Daniel Palmer"
 <daniel@thingy.jp>
Subject: Re: [PATCH v7] m68k, bpf: Add initial BPF JIT compiler support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>, <corbet@lwn.net>,
 <skhan@linuxfoundation.org>, <geert@linux-m68k.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <andrii@kernel.org>, <gerg@linux-m68k.org>
In-Reply-To: <20261005185251.2422114-1-visitorckw@gmail.com>
References: <20261005185251.2422114-1-visitorckw@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Oct 05, 2026 at 06:52 PM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> Tested with the test_bpf.ko:
> test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
> test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]

test_bpf.ko doesn't go through the verifier.
It has no bpf-to-bpf calls and no callbacks.

> Changes in v7:
> - Size subprog stack frames from stack_depth instead of MAX_BPF_STACK.
> - Preserve callee's r2 across BPF_PSEUDO_CALL for aggregate returns.
> - Clean up state on extra_pass failure in bpf_int_jit_compile().

So these are fixes for bot findings in the code that was never run.
It doesn't work. See below.

[...]

> +	emit_16(ctx, 0x4ee8);					/* jmp d16(%a0) */
> +	emit_16(ctx, CPU_IS_COLDFIRE ? 48 : 44);

When the target prog has subprogs its prologue is the is_func flavor.
It's 110 bytes, and 44 is in the middle of
move.l %d0, BPF_R2_LO(%fp). The cpu executes 0xfff0.

> +static void build_prologue(struct jit_ctx *ctx)
> +{
> +	int bpf_stack = ctx->prog->is_func ?
> +			round_up(ctx->prog->aux->stack_depth, 4) : MAX_BPF_STACK;

stack_depth can be more than MAX_BPF_STACK.
may_goto adds 8 bytes on top of what the prog uses.
See stack_depth_extra in bpf_do_misc_fixups().
When the prog uses 512 bytes the counter is at r10 - 520.
That's where movem.l saved %d4 and %d5, so the C caller of the prog
gets them back corrupted.
The target of a tail call reuses the frame, so every frame needs
that extra space.

> +	if (ctx->prog->is_func) {
> +		const s8 arg_regs[] = { BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5 };
> +
> +		for (i = 0; i < 5; i++) {
> +			int offset = 8 + i * 8;

jit_subprogs() sets is_func for func[0] too, which is the main prog.
It's called from C as bpf_func(ctx, insnsi), so 8(%fp) is ctx and
12(%fp) is insnsi. This loop makes R1 = (u64)ctx << 32 | insnsi.
Every prog that has a subprog or a callback reads its ctx
out of prog->insnsi.

arm32 and x86-32 JITs don't support bpf-to-bpf calls.
Drop them from this patch.
Add them in a follow up when you can run test_progs.

pw-bot: cr
