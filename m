Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795046828;
	b=sqnJm4+ASr8fOUKCiKZ3yfKsMS+P1NXmHRMhXs2Ykv8tQ6C6KsTisXqWVo47rFD0lpoD
	 MiQiWLKGLk3ogbiR1CMPY7smbD1WlH8rA+05B9GBUDGkKbTUhxwvlxuSM7oxnIDWe66dR
	 OXNdRjhFJk/6aja9hxC6xh21Bcy8mjXHZTYm0pauG39Gfve0ZWhaSkAfzfYKDtumpcJbf
	 5wGc+d/3SYLUAev/76aFwuutOBbkjshKOJzsRGg/qTDCDlbqzGKcGdpCHTS7/nRiTRzyt
	 cD3dO+MGW37RrQPDoAUbavI+5OSHJA4NLrEgocuNxHYL2L+zeaDyTP/H+386ZWx45cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EWi8bkR9h3tHXm8j7DxgMM6UdzZIdJvfItB6nSFm4tY=;
	b=WOjamu4/vJ4PwwSiL1VO2OIEcBiHK8BWI81GsdZ2PgSY+1UDbXVsRdvK/2mGRrOGx20C
	 3/kJHJbRHYAs9qdKK5s1iJOCVVkv2mp+n/sWmBNMOt8VabXAqv1vsz67Gr+hnE5Ev5n0V
	 +rqrGhSdDvOuRV2i8hMXDT6GgvC73o/0Nnqihl0fpkA/iI9P4rQNHShvBOu21lEnubsox
	 utwhY4m7+31S+QNjnkY+FqDB2KiRaXspZxP6h8YTypJ4dewTMyScMvMrqj0ann87nE6K6
	 CI+UV2hwHxqZn4Bc8exLRm/3GVfl4pIFswd+o6WXv0zU/Rin8+vwW7AIbP4ZhEsEaEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP9p8f46;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EA606A333
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E84EA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP9p8f46
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-492f0a1b685so1152861f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795046826; cv=none;
        d=google.com; s=arc-20260327;
        b=HH1LrbQ6GTX99dlMXyBYo0dDe4XyJihFmpcNi87jQhYzGRI84AXnV/iK1GYofbfvB3
         p995i5Zr6OEDAngcNh6ej0A3St3L2S2bA9oQWLuR45ahCklpefN19aiZC/s6CXdrsHES
         H54Gt5m+AA6kHGmiS7GEE2B3XMBZfEWTuqKjyU7Ab6Hh2YZWtFKJMS/43yVXv9q4hUtq
         Sts8Kq2e7GJ8taN/KvpofId41KXhhma+79RYemIUHYBM2XwxYL1lNBEWVmhIcquqyP3n
         NxlOamSHIeHHX8pYO7CB2rVRMnla7hQouBYK88P7GZKS5tXuqvQ0Hnq7PwgHD1FUGW5c
         mawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EWi8bkR9h3tHXm8j7DxgMM6UdzZIdJvfItB6nSFm4tY=;
        fh=L5m0YfpZti5yXZXJSICTzxAGVVIOZds/N/bplyjUi1U=;
        b=oOwNNQv8fCnMiBwZuDT0F9ilO8MNMKKm0OgDRsL5ohVe5FaEp/y62O174a6wBc2jEI
         I9DkndXgNx3LjhGicgYmPjvYWn5m5JzzwfxgIJZMri4TWnboI2t+EkpKSSywbZmFDCbg
         Wq4sPO6ClqOf2EZAOHafHN45OdzhuOHuhUG7M5joE0fp0yjsqFDMMOuKsC/5dSNtNrxf
         v52KrRTXAij9CAo7JzOa7W1O5vIZxvzkHhXj53YK24dq8d7IwL7cFt7uGwP8VUgVvgLB
         QAXarXmDBJ47TH4JkayJQRxKHXcVkfMyd/oQA+0kSkgn6C3KpThyId7TyToTPOadhO9d
         JYMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795046826; x=1795651626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EWi8bkR9h3tHXm8j7DxgMM6UdzZIdJvfItB6nSFm4tY=;
        b=cP9p8f46PWAzvIwsal+Oj/JMpU7RCpSeHhsiOV8GbRs14hBLT3UDPNgmzghKA1f3VO
         aBvC0BHG76DlFMTY/ByIoGmL9yUqTGSD5OqHLDUxXFKB6drwrKN3PMGhzNzM9azOdsIk
         71V2W+QrflObnpqCmyAdMmNbQXVvbWurS2v1dCxda2JQ9jkDOeVm1NUmaHzBxI6V4lmy
         nrlzzyKCpLjUf4FJHGPsgWOwBMpGR1h5PNu0HwDchTqdHngaI8cwf1qo6YmNJ2mMhYoC
         /EILkvbnJpXvZ1CzlWJy/PL3sJAssRwFETE0NazzRYwTzFYSmLD+GwW4h1tc+hVoo6+1
         ECvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046826; x=1795651626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWi8bkR9h3tHXm8j7DxgMM6UdzZIdJvfItB6nSFm4tY=;
        b=rJstqCI7R5XBpybbXlbwNL9ynMILL6NEbl2BQwUIhlhfYlXHpY4YvNWEnG8gRgETtH
         dJeBIjWzMCdC1sy/hkOV3rFT2KNyWJnxwBfhNCqyNUPWHcsEWGE6XPK2AY2SnodQwcDQ
         L9fKUAY402nN/vE2soRZn1G0ptBz6HmCvuLie9Zn6ZKXdYdDCr9rbJIkJEsOz7gxte57
         8trwmeThkys36kU9O3iekri92jmy3EeRUDlx/CtDs4AWrd9cCcNZe18rPNkNRqaNqlhH
         Scr2KBOEx152oIwGnKvfOEEY/9znWRP4e/ic/ZdKmQR5FN6pm2H71sBFQPqKo11aGTOa
         f+Ng==
X-Forwarded-Encrypted: i=1; AL+hErE6MjXu9uoE09FusJajAIxBUqmSx+3IxxoPtstGAm5jSDP6ql6DP7CXF2IurKhyNPssGS8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NmKCzj+15oTKDeEF0Jc/QhzIEtrrERvDm28BOKE9+9REfhJOP
	j+faQ6qItI8xV7irWfjGOA1J92hL86T0xFDNnEHmF2vz7HYIm3uwK+9xGpCVIY+/rliECHA++b6
	JXzr9+zbU+PAc8y3TEhZ8XSNdS+hUTKM=
X-Gm-Gg: AZFdTZd51qvTgWcLOobsb1oYAHB06cVthlKpFeo7VVry+nX/JuMVfoNbXHayHFzXkea
	rYFQabzIxvpvJj8+sQ1WP/BA5U+W4z/MX3fFxNmaTVTbz7DGf5QoZ9xO2W+SMze43MzulsKKyGA
	PjqYgalrZFCi+BqAtohBVSoHkv3qdNBiOGp6UzjDM/6G3F77zvBes5nXoGf5/5ysyIhlxE0GBjk
	HXlHUey67YqERqtVaPLD7rm4lOJHTOpdRFHeypXdNHA0+ab0DmsxWiMA6J8RO5w9rZ9YZudEzI6
	XmfIMZor6fk9Sso8CRYvprzY+SAmjoCDRl8vyo24lyBG7Bybf+jAFYVISywMTO+eCfSZx5kYV8x
	qyNd6m84XNGE5wUsXWHFIgYEy2b2pXh7aiLXzW6jTVWOIN5bXVau/VnVSC11Z73UiDBzsfQ+ckT
	qd8hx1pW7ZR02tI3cdhHw=
X-Received: by 2002:a05:6000:26c4:b0:4a4:1267:350a with SMTP id
 ffacd0b85a97d-4a6331c6d5fmr10036299f8f.5.1795046826107; Wed, 18 Nov 2026
 16:07:06 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114001846.873499-1-andrii@kernel.org> <20261114001846.873499-2-andrii@kernel.org>
 <avxJjTWOp250aDYC@willie-the-truck>
In-Reply-To: <avxJjTWOp250aDYC@willie-the-truck>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Nov 2026 16:06:55 -0800
X-Gm-Features: Aa3M54ohy-eIhH22eDuxovMjFXOGOFVwvlzmEgw11hhd4u67Vz7wgMvDgsfWW0g
Message-ID: <CAEf4BzY7bs2y70tb7cSFrWiTZuhNkfqqVOiTL2WnawMxCFnn3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] arm64: perf: Don't report the caller twice
 in caller-regs callchains
To: Will Deacon <will@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org, peterz@infradead.org, 
	jolsa@kernel.org, rostedt@goodmis.org, ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 4:33=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Nov 13, 2026 at 04:18:44PM -0800, Andrii Nakryiko wrote:
> > perf_arch_fetch_caller_regs() sets regs->pc to the return address of
> > the function it is used in (CALLER_ADDR0), but points regs->regs[29]
> > at that function's own frame record, whose saved LR is that same
> > return address. perf_callchain_kernel() reports regs->pc and then
> > unwinds from the frame record at x29, so the caller shows up twice at
> > the top of every kernel callchain built from perf_fetch_caller_regs():
> > tracepoint events, software events emitted by __perf_sw_event_sched()
> > (context-switches, cgroup-switches, cpu-migrations), and
> > bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
> > tp_btf and fentry/fexit programs. E.g., for a tracepoint program
> > attached to sched_process_fork:
> >
> >   __traceiter_sched_process_fork+0x44
> >   __traceiter_sched_process_fork+0x44
> >   kernel_clone+0x250
> >   ...
> >
> > Use __builtin_frame_address(1), the caller's frame record, the same
> > way kunwind_init_from_caller() does, so that pc and x29 describe the
> > same frame.
> >
> > x86 had the same duplicate entry, fixed by commit 6d08340d1e35
> > ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"")=
.
> >
> > Fixes: 5b09a094f2fb ("arm64: perf: Fix callchain parse error with kerne=
l tracepoint events")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/arm64/include/asm/perf_event.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/a=
sm/perf_event.h
> > index ee45b4e77347..13efb46f0fe8 100644
> > --- a/arch/arm64/include/asm/perf_event.h
> > +++ b/arch/arm64/include/asm/perf_event.h
> > @@ -15,7 +15,7 @@
> >
> >  #define perf_arch_fetch_caller_regs(regs, __ip) { \
> >       (regs)->pc =3D (__ip);    \
> > -     (regs)->regs[29] =3D (unsigned long) __builtin_frame_address(0); =
\
> > +     (regs)->regs[29] =3D (unsigned long) __builtin_frame_address(1); =
\
> >       (regs)->sp =3D current_stack_pointer; \
> >       (regs)->pstate =3D PSR_MODE_EL1h; \
>
> This doesn't look right to me. Presumably, the compiler is now going to
> emit the first step of the unwind, but it has no idea about the different
> stacks that we have, the meta frames or the invariants that the walker
> in arch/arm64/kernel/stacktrace.c takes care of.
>
> So we should continue to unwind from the current frame, but then perf
> can discard the duplicate leaf entry if we don't want it. After all,
> it's perf that's passing in CALLER_ADDR0 for __ip.

Thanks for feedback! I just sent v2 which follows (conceptually) what
x86-64 does, please take a look when you get a chance. I'm not sure
about PSR_MODE_EL1h vs PSR_MODE_EL1t hackery, but that's what my AI
suggested and it promised it's fine :)

>
> Will
