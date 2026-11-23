Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406825;
	b=lFqvWmnedD7IgHEHh1h1MNJDnRvbYajY3jJkafo//a/aGngz918jQhW1eFcbvdJag/a3
	 AMt5M7gfNq4tnRI+iyH5HME8sSw8lwQqZFTS7KYT1Z3BCi8mRrHCDdpYTwRtyB+RPXOxl
	 YTtZfTLUU7fScNSrT0p852IdoeMrLjSR2VUJk6Dd/2qikCGe2by/BQFJLYXsRlyXsJJrf
	 WunixHXCNt9lkxYLWMBZkJLi7phrAJhjhZkS97pZDWuxcWCewZBx70ljODONSsMXxgAyP
	 GOJ0X0CMosBgcozMpfxBdSmh48OnPfklfW/Pnx0KJ7cREN/+AYmVBw/wF2z9q0D7kLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=LLWUQJfbd+q8VyoErsrKDBDgdA9nzb7m7pgg7/PG2U4=;
	b=OLn1a/1qc/blnLUOEcepz7HChrjqpX1DWRQsPs1uwuDrXEVcnk0h9CbOypJkuo+LwWJS
	 3Tytx4KEoH0Kf4ZO/QRwKK8qF4JBBOR83QZYmGQtoMCGBKcSqw0+m3PYILeE7nONvuW7B
	 6sjXx7Oe1FRd6qqPADt2Jwwgk19E5E1j10TeDQJRa5M5/I29lHsPknDv9Q13Xz5x+Ckby
	 n+ga9MDjZLxGLRahSIltpsO3hU6sYOw6Iva7tr6BTAoVw9VFgv69XzGk7UbjhGKW0zmu+
	 icz44jssUl7KP3nrNxpY9C8FQ1eifNHE9Az1a5lbVAgZIcfb0OXUe5C6thm7MKEJyUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrkVMVM8;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC8606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5CC8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrkVMVM8
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1151254a91.3
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 20:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795406824; x=1796011624; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLWUQJfbd+q8VyoErsrKDBDgdA9nzb7m7pgg7/PG2U4=;
        b=zrkVMVM8fiHIA2UIO1Um5i49tmxW5eAK/JbbSxShAL8W/6EY0z524g/bRIpvKqlMDo
         6aKIXn27f6nZ/hN1j3RBtpx3nDs//cfaPPVaWZR6AvCdt+HOKLsKNZvWbsjXNtuO+SN9
         /aI/c9/i1dEUrMglw2IFAf3wpR5tBymGIoQFag5KJ+JqP29kvrOa8hCq6xBemxljADkW
         tzXv0bBUBqcFmUpbcirQeDeWwn9tD2B/2MUi9/4BtsfklBJX/0KFxHRZZrRkHs/zfdEe
         Zma8doDyTSAzPcxB2PShBO+k9yTHKjjM7rRECrAgOvOz2+Za8g3vZm0zubw0SFWmzqwk
         YNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795406824; x=1796011624;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLWUQJfbd+q8VyoErsrKDBDgdA9nzb7m7pgg7/PG2U4=;
        b=or/4UJu3PksgIJg8YgVQMEHvOBWwjVLWTz+yZfj3Kq9Z6+9WFvlI6Ck6I9Q3CMTpuo
         1snsLHnslh2QUc4pLZz7FbXwohm84lVoPPeiZzBl5USinHSjqDqKNybdWP1q7Z2jkU5g
         TiZ6AO/BBaywVE0Xok9tzu4yI78Ee3JpScxJrFYabAUe7VHowMH4HG8LpoyT4xCnr2kK
         Gkh5PB9zO8Jont2Z9/jtQmEcO19wK+bpJi2esg0SkEdEHJT/8780Udy9wdM6eER/FIO0
         exkEBm7ZlSsq/MUOduaoyf5Tffgm7CuJ90BOILAYCiPZH0EU/OAyJQt1/0vQCWhz1ZwM
         K+6g==
X-Forwarded-Encrypted: i=1; AL+hErEbFd5ugYXgOCEsTRxjfThXRHBfRSjKWjxBaAH3Fmnhsvz5qWgPqQvRNw2a3gNjrkAOjxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gGj1jaUl1WYgo4Oa6/Ogg6EXrQ99CzS44FLg9X8haPduTbOYm
	mO+HHMzovlmjpwtfnEj5uoClauoy0O4xuDGOdKbNAOJ9621AxxjV9432
X-Gm-Gg: AZFdTZdrvHH3n7cNMmQcZhX35p/RkcjJ7z+aXBc46t+/UHypJHxD36KM6weIa6l65Wa
	eRLnclaEDYZ51khGv7Ft4PoVo0IgS1q92Gz3A4H3P//XWC/fBQhJjCnVatHfUB9ktZ0kymftyah
	wm1I/HXJEtnpNdxLSHxBvvts6183Q+8ENSUVizIMyToKSNsJJA/ugTTu9ApnQhDvvRvaSU1Ngsb
	QPoFh2xyPp4+qg6YsgmJl9sk7r25/Zow6G0RuiWs0fFUwnSJ9W7BTMmHKLeraVzQXf3YquEtpg6
	cz8c8cNbyfWbdT76DtfU3azBTWkSAgMGer+UevbDM6fcBrehK52E1p8kfG5qR287npJvFrqU9w7
	GnZnSVZv27HXQjFfIhjft4eiedhkQXwsrx0cL+fKwTUAtFnYImoiqLM4IYlgZ9oVwLRtgU7J83c
	reU4kFuO/IoUW4cioQc2WnCUADSykP+rxnt9MhI9nitqPvo9c8dT6So23u2/mFsX5yuDwFAkSqS
	b20qgag4csttkq6mP1t8bePZ7EBwIBZNAwMK4PVCdYtvS7mh0ZUgutREIi2iR14w2YuOFsCy5rz
	MVJ+eMZikDm5bKjaRCrT3NL4gO6K9OwxI42izNNx7TTRA2TWiEd/ADFP5BrzDViM9zgq7vB+0lt
	fmVk3zrf2az6rJWXcHOHqJS3+cuUz8I9fzA==
X-Received: by 2002:a17:90a:e70c:b0:3b0:d551:ab2 with SMTP id 98e67ed59e1d1-3b41c955b0emr9277361a91.51.1795406823840;
        Sun, 22 Nov 2026 20:07:03 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm15511490a91.4.2026.11.22.20.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 20:07:03 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 04:07:03 +0000
Message-Id: <DN2ALO12MI1Z.3HI553HDMO2FL@gmail.com>
To: "Ryan Roberts" <ryan.roberts@arm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>
Cc: "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
References: <20261117172341.3152407-1-ryan.roberts@arm.com> <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com> <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com> <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 22, 2026 at 12:58 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> I view this patch as a fix to arm64, not as a fix to BPF. I haven't changed any
> BPF code - I've only removed an out of date comment in BPF code, which assumed
> the code path was for Spectre v4 only. But that's not true since Commit
> dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier").

Fair enough, but the arm64 part of that comment is stale.
The verifier relies on nospec for v1 since
commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1").

> arm64 was previously nop'ing barrier_nospec() despite seemingly needing it in
> the same situation as x86. I think this is orthogonal to whether or not the BPF
> interpreter permits speculation attacks in other places?

Not quite. In the interpreter the barrier sits behind an indirect branch:

  goto *jumptable[insn->code];

arm64 has no retpoline, and the prog can train this branch.
With a wrong target the CPU skips ST_NOSPEC and runs the next insn.
So the interpreter is still not safe.
Yet you're arguing that you're making bpf interpreter a viable option
on arm64. That's just not fair to users.
Say it in the commit log that you're fixing one tiny issue and leaving
giant security hole in place.
With that I'm no longer nacking it.

> Looking at bpf-next, it is still possible to deselect BPF_JIT when building. If
> this is such a security issue, shouldn't we disallow that on arm64, or at the
> every least make it an EXPERT option?

Yeah. Good point. Let's disallow it on arm64 and x86-64.

I'm thinking to push something like this

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index d705d7b..8b8688d 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -26,8 +26,8 @@ config HAVE_EBPF_JIT_KASAN
 config ARCH_WANT_DEFAULT_BPF_JIT
 	bool
 
-# Used by archs to tell that kernels that were compiled with BPF JIT support
-# have no BPF interpreter.
+# Used by archs to tell that kernels with the bpf() system call have the
+# BPF JIT compiler and no BPF interpreter.
 config ARCH_WANT_BPF_JIT_ALWAYS_ON
 	bool
 
@@ -36,6 +36,7 @@ menu "BPF subsystem"
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
+	select BPF_JIT if ARCH_WANT_BPF_JIT_ALWAYS_ON
 	select IRQ_WORK
 	select NEED_TASKS_RCU
 	select TASKS_TRACE_RCU
