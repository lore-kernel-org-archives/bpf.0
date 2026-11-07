Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017718;
	b=vu7oc8BnJ4oEYqQVjw9hMG1p3zxzeJIQeV5qJfxSOapNR7tu7Gn6JT6R6LAd2aY9JznF
	 pkJrKJtcK1Sy1PDT+mNr9C3powaEky0FLmGweTCh0THd5mq/13647vpMmhB2GDiEueFsk
	 C7d/LMC28ELhJbZo8tURW4v6zffq0P1oEnlrvgzWstzmh9WL7OUlAQQmoDoZDwer0zC2O
	 D5Dph/KwvMfEAWrYi8znoYwLGntHjSt5UcLPgDLGvmG73kmx9UM0/SaZUgKukqB5jq7WV
	 2NcMI0RaUigvYKDJnS6ez9+pfpVwvKuOzjqtqkh4gbOKPB8sF2z3JHmeSBYp1Gstckw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wikFKZw4t4TcuII1gnI7d31HqgOIm3ag7690hAeyUhA=;
	b=kBL+OM67yzjFuWb8Zf62VgCzanKaiUsAqC6BvKPIQDiU3kgzPZvMvQIa/EaCFf8YabQl
	 CgzdbYc+NqqW4KkjhxOTXVXD6+xOfk8uAlG7TzjSEe+O0qVtfTtbeIUIywzSdonKmMm/p
	 GlkWNLJ/LqyHS7pVHRSUuH5QCzOpyg6cKYJYV8UFWdX99qHghcohAj3EuDJnszSuYr7Hg
	 ag/RrTRU/n1wCukIDHrqb+1WGXWwpGImaoATRxi/hjC4TZxbdyjCXu/OyhC6ieYbJMqS2
	 /5FwMLFlk+cV3LqL51XGmpT52lazhYLVqpWbE/HU2LNN8WQTsHTuBuwYry/Z89xDngw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=McOLOv5u;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852B606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 02:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0852B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=McOLOv5u
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso12161615e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 18:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017716; x=1794622516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wikFKZw4t4TcuII1gnI7d31HqgOIm3ag7690hAeyUhA=;
        b=McOLOv5uPocWeQYs0J1CzVJ7oBNbutOabdLWzEtIfCRWBUAA2m8Wu2kL80jD1lvS+n
         uFgN/1vvBLiQvUFmFRTDDb9M/uRzvPlc7PT+dGnruVgq1F92pmDgc0F9gM4Z6n2wVUHN
         P2mFThHUwLk8/DKJix4h4qSZNfeODvzOeQYMHOz4/kdOBlhCY3bUNu7NrJMG/hoMOUyk
         /MNw4U0a/pUNCUFvMKgip2erjFOM6UUSU/1S+uisqkjfvpbgVfK6Pi/bfzk26d4IodeF
         UkW+oilNBdVGw7J0aiTIUhJc+I5dzoor2yJVr1nbAefpoZBEk8kevntUjR4ui1/CsxvR
         ZApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017716; x=1794622516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wikFKZw4t4TcuII1gnI7d31HqgOIm3ag7690hAeyUhA=;
        b=Hbs9x9lpHT+sgGTju7tI5oIMTiQ2dGUeiIousT6EASXyiVG+73UuDdm0c/qUPByvWs
         E3aZ6QoRo8qzDfeqy3rP9VgY43JQ53PoaTDw/0AxzcKAu6dCBhIRzi4KMbSyUXyJwn/L
         wP9lpIuUsrnz4DEtk/8UDKC75n3trKK+lAdyjnZmJ2R52rlfYsFn8RxSWXp8rPfVSUL3
         GFb3abQyWg+bpmRB+CDzsjBP+VIL2UCl29iiEZVZfRRYhqEAc2j1ieL3qdiBJ23TXrNK
         sFau230kRjbwkWrBMUlK8JtGw2nBzntNeQhJHZZHT2jUruC7QkrfhcFUlMBisonZXDCo
         C/hQ==
X-Forwarded-Encrypted: i=1; AKwUvByrBQvwOw4khXtMtaEkJ81zVjkhSDakYMbOF0Uvi1m26ywuoMmwXufI4g6ut3bIxb2sk3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mwwcCu5KjO+73cAJ5dhmc25W80VLYnJhGcVjs0LMOvsjSbaTM
	DXyGp+05X1O4sxI9sd0FjaIKuEStQh5Pe/Jld4cRSnY0sCWyPyfDjgMs
X-Gm-Gg: AYBFou2NMao35F1FFq8aMDlJHfgu72L1QsQvC7lwTnPbGg7aIzmvjAr2gJPqha5i2TO
	mqFpjntF52DU3csAZa6Esm8s8ss4T5nAnhTz0XTl47X/cb8nSP/TB5yaDvt/NQkdjiuioaW/nTS
	IPEk4vt2raGRnd1c1uBUEymGURcEtpM8EURhjVKRVfJE/FdNWq33NTOPmLApJ9AI9VV6iNhcmLx
	VZlOp5gAoWJRYo9exglMhIYILIqoOhDI8ZmrX3mHDQa3ZrerIVcU2ZahROL8gPSNQKBAwaL9zG0
	9QZ7ZgDHrrSjul9p3dCwSTsXAYbj5kpVJ1TNbkF1XGDSTub/5s9cRIDtAJk0zxcnpKMJpSTMybZ
	IpTwNO8m2r1ZrS2rhHruwBYrYBCbgJB8PluV2kz/QZL6ktL0h1qDFf/eDLqsLNiJpCeDHjl5BU5
	CC0OSlOHfoZVyJJ8ijUHILnhSBbC3WDnoaw+Rid2JG0Gr0LV1GHrlgOHXJQpgQhYPRdtPuXQ/q5
	4NUd2qOzarOPoGzvXJ+Ozc0C0zzaGtTGvfgaijwPCppzCbdG011rNUZiYwZR05Z/jdHF9YxyULf
	+au2R7X6QW03X2n0+sTgPvYbGOUFGQtj+L4vnMq3xFtL55NZF04ULyfdyI6OP8JUdbubIEJvfjH
	VoQ==
X-Received: by 2002:a05:600c:4e8e:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4b6e054a25cmr71898355e9.34.1794017716295;
        Fri, 06 Nov 2026 18:15:16 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5f11sm6367449f8f.49.2026.11.06.18.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:15:15 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com,
	tj@kernel.org,
	tglx@kernel.org,
	frederic@kernel.org,
	anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
Date: Sat,  7 Nov 2026 02:15:07 +0000
Message-ID: <20261107021509.968928-2-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106102315.GT1813469@noisy.programming.kicks-ass.net>
References: <20261106094343.174905-1-radu.m.toader@gmail.com> <20261106094343.174905-3-radu.m.toader@gmail.com> <20261106102315.GT1813469@noisy.programming.kicks-ass.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 06, 2026 at 11:23:15AM +0100, Peter Zijlstra wrote:
> So is_idle_task() is also true for idle-injection tasks. I *think* that
> is also right in this case, but it wasn't mentioned.
>
> That is, we can have tasks that are not rq->idle for which
> is_idle_task()/PF_IDLE is true, those tasks will also 'run' an idle
> state, see play_idle_precise() and its users.

You are right on both counts, and it should have been mentioned. v2
names it.

I agree it is also right here, for the same reason the idle task needs
it: during injection the CPU does run an idle state. play_idle_precise()
sets PF_IDLE and loops on do_idle(), so TS_FLAG_INIDLE is set and
tick_nohz_irq_exit() has exactly the work to do there that it has for
the idle task. What it is not is confined to sched_ext - it reaches the
idle_inject() users, intel_powerclamp and cpuidle_cooling - and v2 says
so rather than leaving that for a reviewer to find.

Writing it up also showed that my claim the new gate is "strictly wider"
than the old one is wrong, so it is gone. PF_IDLE is set by
cpu_startup_entry() and not by init_idle(), so a CPU on its idle task
before that point satisfies idle_cpu() but not is_idle_task(current).
Nothing is lost there, since TS_FLAG_INIDLE is only set inside do_idle()
and so tick_nohz_irq_exit() had nothing to do, and nohz_full CPUs are
covered by tick_nohz_full_cpu(cpu) either way. But the gates overlap
rather than one containing the other, and v2 states that instead.

Patch 1 is dropped from v2 at Tejun's request; the reproducer stays in
the archive and the fix links to it.

Disclosure: this reply was written by Claude Opus 5 (Claude Code) and
sent on my behalf, in the same session as the patch; the patch changelog
carries the same note.
