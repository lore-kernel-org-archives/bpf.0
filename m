Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153711;
	b=oC/Up6p12+ND/AminwsUa2BSfdH94bAxJVbSccPt9QplVEuHTZNtUXd1OJ2BkGzx0ucq
	 aj8LY4w4eGpgNd46+nLibblcIVYcFiQNMEVLjE2ZJ1BU9VhsSvXZiRKDqyxWEffkS4a53
	 G/+azmfIdLsboqVbpQ7wt1xjEEuD1oy3WXEZrAeWSL8waVhihffU1XM8BWM+/PwWqP6Y2
	 SacVsQOGKcffLhlzt++nroaZJlfBNrZ1c/8VTb7hWeyfpsc8dsef1U4kdoaOw9IxcZ3UC
	 1Zs1c5yzYld2zZ0EgxlvIqPsRXNUOrC+aYSh9peSujVYFNGgmNT7NeGT3mos3Fe8rDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=QGinyiMrrwZtrLAfiO31oHhjeyRs9IZr6anPmafpqog=;
	b=ZphHWmWr+ksv0Ku5C96pm8JhJ8MGViyXYbvm6doBMcc903WHtOQN1xRUAjgH3YMA604M
	 K/mTIjvoBiRmek03xLeVrY1umO2pwP20Mm/V7f0BwSfIHxZ1iNZku77jjFOWNu8xPc/qd
	 UBzNiUpvTJyZc7qFzP3m8UqvoEGz65z/tC6+hAn2/fylY8lj71gk7iSZvEFty753oK0zP
	 uJHOPyMaXiRSlKQPULSFLiqqs+9aCReMkg6K1LPlK/R43ylc5uQc7J2T/uQUV7qE0Llzx
	 D7yZfCnzkfXrtusbX+CGJKWEQbJU2jtsbEGSsFBGrwX63IMJDtUT49hsCsYYrl9inAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8lVUKZu;
	arc=none smtp.remote-ip=74.125.225.65
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109C606A322
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7109C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8lVUKZu
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-48e0c9fdb31so206660f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153710; x=1793758510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QGinyiMrrwZtrLAfiO31oHhjeyRs9IZr6anPmafpqog=;
        b=r8lVUKZuN6uvUJKLLmZGBXMDYKcXy4fKleu/9Ilp16H3YTy4MXEI8qaVyv8z9r0wRm
         BoIILtbnNxSVt0SOJQE1QrIvMPzgauViV+lvK2MWbRQC/Zr7T4dQ8s4R04NPigUOsSHZ
         80MvkqYEp6t9eQ/TjQ72QvGXJjJHet6tdPdSew5wdiV8JsgUtASPLw9GaY2AaNcCJKIy
         50verKtmrAPPcMQuiPzuujXRp2oY0bCebOl3Toulf7WoxANpNd9g6/8if3MP/6vjTqFW
         pINolhhix0+3QqYDO6JbUidulPvdCiC5kRYOZjSjYRuYjz8SaUEDlKqvrqnRF/VDI68G
         zR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153710; x=1793758510;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QGinyiMrrwZtrLAfiO31oHhjeyRs9IZr6anPmafpqog=;
        b=YAWQ0vSQWP2wSUuXPqrlYsVIvkrFiRGcQVIWajZ7IpS6GDSnUbwdeHzbUoqEGna3zq
         tSEFqxvtOj4QRROGjdkZo8bYnAmDUYgCtTHVU21r1u/FwgyJdv9blC1lSIxDmCivEp6A
         9bPeVlrFBeStb5lS/XGLTVcsP4JClda//+XgpYHde0qFh9xoH7BHm5BBviSTXhtM7doG
         vbK50zcYSVLYP1XNDlw1uxDWHTfxXcLHeeK88S290k/oGarJXhZm4je0SAmJXp5YfSBx
         14fZ7RTS5fn7cLg2AI3YXmIfpKnkvjMUudOjWAyU6Zsj0TfYjgOH/9Kdcc51KXyRTcMH
         RdPQ==
X-Gm-Message-State: AFq9FYLKe+WT1Tdx4Un+tod0OX2Fvgx5iqPV2tY7Hmafp5sA5kCBR+MH
	L+hnPlUAVEl4tpSM5F7rUOIiucwFbDE6YhgeRvD6lW+9dHFJB4+nPzAylR+IYnf/
X-Gm-Gg: AYBFou1YuUTQjEp6c9ViPcR4jd7s0so7Rjt8KQo1OjkShiswmruNs68WTerM3OF5pSv
	YCcI0m6h8zqQ/3Kfsbhnaftg2t+DaD6/bXah2IS3VPQvobM/l6LLGMlrZzED5jQmQI1eg20c8+U
	UpFl3QqCYgpkXyevThZLV+SNhVxKfkspO/o5DFctDJaXU+uqtg/FlBVaJLqm2cQueQEL0lCtL4i
	7KP6yD3gS7gpRr2TPycIqQMZCHSGdYx6SQ2BnuuPnN/pUmPUVWucuMPYHz9aKiXizSw8ecHc3jB
	6HxiFgMt/Xe5vWF2aDr0pEidQLvaXUiU+My8ZLb5Bv27k96RbNgs+vOUNyL1W6QaIMnVf6WKafB
	UFkCj0YPScxqf8yyCqfKc6FUzyTLl4IWu6VQMVTRPCwbmxmNpao0nebt0h+qk/ICIdzEbezm0oI
	u5CihX8v3Z/QvCKBC0Ej30dgE9wLn1eeZ/ffxPcc0qAc8qKI3SJdSHNmwsDH5Hqdk7RLoFqGX4o
	468bIRPhe0QoKGdPE95J+vuZV5EO7yofXTSfB1ajn67mJ7cUyKCjBkZDGKSFhirXIezzKaIIU9w
	jEzXmi+hNDQ+/gX16tuboX84Eaeu2zwU+NuR0IWWmtQHWYizJFQLFpNi4a7OLOEmCd2n/tL5IPA
	x+eYC/4pCgUO7va+ezsyHpIXe4nBCFQ1vYy/y5JraydC4d7cEteXsVAEL5MrRWl6A6GMP
X-Received: by 2002:a05:6000:104b:b0:48b:4a2:8175 with SMTP id ffacd0b85a97d-48e5d308277mr2011252f8f.43.1793153709469;
        Tue, 27 Oct 2026 19:15:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd35c2sm25220146f8f.39.2026.10.27.19.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 01/11] bpf: Give a helper a way to call its callback with a pad
Date: Wed, 28 Oct 2026 03:15:08 +0100
Message-ID: <20261028021508.1203900-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-187312@kernel.org>
References: <cover.1793147364.git.memxor@gmail.com> <03d6c53ccdf3eb0f5503eae9f9ffa5e6570549c3.1793147364.git.memxor@gmail.com> <sashiko-outbox-187312@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:20 AM CET, sashiko-bot wrote:
> [...]
> [Severity: High]
> Can evaluating the macro arguments in ___bpf_call_cb() on arm64 and
> __bpf_call_cb() on x86-64 clobber the caller-saved local register
> variables before the asm_goto_output() statement is reached?

Right: the compiler keeps no local register variable across a call, and
a call in the evaluation of a later argument clobbers the ones set
before it. The next version evaluates every argument into a temporary
first and sets the register variables from those.

> [...]
> [Severity: High]
> Could the compiler eliminate the *slot = to store in bpf_unwind_leave()
> (on both x86-64 and arm64) as a dead store to the current function's stack
> frame right before returning?

Right, and gcc 15 does drop it, on arm64 and x86-64 alike: that is why
the gcc runs of BPF CI returned from every helper but the array iterator
instead of unwinding. The next version stores with WRITE_ONCE(), on the
shadow call stack too.

> [...]
