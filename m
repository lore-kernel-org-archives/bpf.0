Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758816;
	b=ewUkb7SYHOdXy5zfs6Ayyp250Nm4abWWZFNlwYJvgSEs7y/Oh2Cq/MilSGE940PidJ6b
	 L3iyy6XAcVevCcjIB5fI54jhYoKrfEkLwVr5sWM1F8k4HXLWiJDZWZAvRTG/SoYf7NWM9
	 YT2gwu51DFXvokY5c7dTKbGvz6npRM69oY+jJyeNYDWM1gEWrFcZNfaebE2a3OOUnoza1
	 mhxAkbTOh8d1IRTBwZwgKTkQxAqDMq7d1xypbkGIVDVFeY6ptAuMUhmeM/JB+b32TD6Pk
	 kcu7YtaFvPku1XU+honxm6kszqRucslIlv/GB6VqImmWImBFVcf6+wFJyDd4JzECJsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=xCk3/rz0DOELcqiOfP0DbefR1Tzq2eC/yEUTX368PGI=;
	b=kW3+BxICIsambqzOJC4gPNw8riVMv13k0FspjowRW4YQynTsffIh8UoMqxngQ/PmxZER
	 b+BQYBZgmHPpQDnlibT4GMwK5Tlj8VnX8bJFEuHOR4GnDzvZ6BnMPGxJVUdKUDrOi5wtn
	 0PrmZA40dXnu7NrHJ97oYz6EYE5DOIkYaL/0feeo5LmHY9qvMmWHQj984nFJW1eoXyQxZ
	 vV+7lsfKHIdJ8PPHeLuWHyFVN/o9eDIFbEBsM792wK4JOM55+ukJvtJHgZOEGSX/0DMHw
	 beoqzeUgIrKPHPQOZ+nzgytV5puQA2lwIziJxRn6yUaRjcaXFyaj3EOo7nkeDDSAdBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=knxxNkEU;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0568606A336
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0568606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=knxxNkEU
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e5fb79ce82so839835ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758815; x=1794363615; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xCk3/rz0DOELcqiOfP0DbefR1Tzq2eC/yEUTX368PGI=;
        b=knxxNkEUj3H/maGy1vZXbPObigq0Lw5pTZSJ5WLraaakJIetgxF5pQYW9ISHAV4Yu7
         w162WqmqRsmINLrlMKRhnZsEHYO5Ny+wPBhy4p0NmmPaptph09DN4lxLAeeEuwXrsUSY
         YA2Tos0G/jghorJ0jf8BLfBbx0GuRKnlfFmLMd3pbUxvI/HsgYLfGKvwHp8wbcVUU7ag
         oOuFW0i9TJDGNHJdy4zkSIpWViNpdB0yyBVd3t1+otpHke60espzZqQv6Zk+UbcqwikY
         qh4yMRQkM7HQg5CFfuxNswKhZrrESU1bxxElr508pMjB7kwYJ0H1M0xHLrOae2rweqnC
         hDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758815; x=1794363615;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCk3/rz0DOELcqiOfP0DbefR1Tzq2eC/yEUTX368PGI=;
        b=trFzfD+YGF5vYVlHRodEReT/gYEDLjLmf2dt7/7YNicuYrv7sSayBqOJ5ETvHMOBgE
         kCjirmhpoHyYlAwBBhDCfa41KeRWfppjrDt3VMN/c3wil1+XLQ2spjWaZhSZKIsD0lNr
         hmwwbQ0fexC22F1vtIKwFBXjdcuE2DuYwlw6aVG7CAFrCcPsIcatupl0mt81AgCInL+e
         hg/PkNfF3k+qfMP/viNtDuatIUGGEPO2BrLjeOHbZ5DnaTuGb1lc6vwmEtnC+VkcxDF2
         ZA0N8n7AfKQuB12BTsLI8IBUoZC839dquL1AEx5HS2ZIYBePPS4Jsc0/3F/Y4p0dv/pB
         sWlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwheCptDjCCmnY4AzBi1WS3y8jOo4sYxst2rZeP6lt29sw7ZA5QZ59qqboJ0ZoQ1hKIwAA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gTVHofoZgBDcgQpGJ/xcJ2AhRaPolB/q8FGcGn4yetnCupNL7
	39fnh8Xh00Kt9UL47ZsVn9vvcDEEOzUkDtl6zWk5w4X39jBgLJG/EPs4
X-Gm-Gg: AYBFou23tDLb7zYfLBM7c4445k+Gq6HgX29GQLPOqBGFXjBB2BR1G1rHlMo8+jJDFtU
	BxxPBQ5U7PXjGQhgtlEKa5EG0bnK5V5bI0y/UeLX1PMmTYKjlQmKvKIXGqW4lV5vlREti6pgT42
	U0W2AldH4R3ieliOYeNnRe6TPIEHbjv3OajREpwovyY5BcVa5u5eJSBpb36GWPB/z/TQ21Agwg+
	L+T5OSVSEKvgT566BMFa++vDn25Psh+gh+of3heAhRkcG8xYC/FJCaieMdvhdyw3oumZk+dI62U
	Yedy1sYUqsDC3bOKoA28iNwfo6x1YRyBMQUQGV5BGkEpBMxTlK/ItqYs+dnzr1lJq187VufoXCH
	emV0/oyioW18ZLCgULhsn+G8XMHaaV5r8uVFxaQlHPJMmyhMhL0uw7LFaktyyMnYW6sehzEklKw
	uXJdveLaRNQJmhvGyvaIqdFqCckBqetg1d+vdHkGsR+Lvx2j6V/yNw3QR5Uyd6ECxytHsBhEzz+
	D79kv1ioGB0394Gb4mZpYqFFohXU4+mt6m+s3JiXoGJi9CKz0fyt44ZiUO6EGd4TydLAqSeRDa7
	RXR7HLt6TMY6PdDYThIvM1X+gRxXGzagIlfz6U7eCbg3dilY6Iif3izN7BYmUtfCeQgwgUl1F84
	XVIuRITS9gA2l/bmcYWePx9VSkmC4y8iSUg==
X-Received: by 2002:a17:902:e5c1:b0:2e8:1929:c8e4 with SMTP id d9443c01a7336-2eb36527d99mr133638285ad.60.1793758815155;
        Tue, 03 Nov 2026 18:20:15 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fe4dd2sm1063965ad.25.2026.11.03.18.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:20:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:20:13 +0000
Message-Id: <DMM2FJ2SNYYO.24TEJ05OOR08E@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let
 preemption cause false recursion drops in trampoline progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mike Bazov" <mikeba@sentinelone.com>
In-Reply-To: <CAPnbwjpv3bkGAKVjc7Eywgo-H4X6uDLYPJWFuSakGs_sBdgr3w@mail.gmail.com>
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com> <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com> <DML75890DWIX.EYB690LPBM1O@gmail.com> <CAPnbwjpv3bkGAKVjc7Eywgo-H4X6uDLYPJWFuSakGs_sBdgr3w@mail.gmail.com>
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

On Tue, Nov 03, 2026 at 01:28 PM Mike Bazov <mikeba@sentinelone.com> wrote:
> Thanks! fsession does keep entry and exit consistent. It doesn't recover
> the skipped runs though. I ran the selftest scenario with an fsession
> prog on __set_task_comm (7.0 kernel, lazy preemption, 20 rounds): Task
> B's entry and exit runs were both skipped in every round (entry_b=0,
> exit_b=0, recursion_misses=40), since each run still goes through
> prog->active while Task A is preempted mid-program.

Right.
fsession fixes the pairing. It doesn't fix the miss.

> What is the main obstacle to per-task tracking?

Today a fentry prog never runs twice at the same time on one cpu.
Existing progs rely on that for their per-cpu maps.

  task A, cpu 0                     task B, cpu 0
  buf = lookup(&percpu_scratch)
  fill buf
  <preempted>
                                    buf = lookup(&percpu_scratch)
                                    fill buf
                                    output(buf)
  output(buf)   <- data of B

A plain (*cnt)++ in a per-cpu map loses updates the same way.
Today B is skipped and recursion_misses counts it.
With the per-task check A sends a corrupted event and nothing counts it.

> And if per-task is not an option, do you have another approach
> in mind so that runs of unrelated tasks are not skipped?

Add bpf_preempt_disable().
Your test forces the preemption in the middle of the prog.
Explicit bpf_preempt_disable() will fix it.
And you'll have an easy way to see why disabling preemtion
for the whole program might hurt your own production.

What are run_cnt and recursion_misses of your progs on inet_sendmsg()
and inet_recvmsg() in production?
