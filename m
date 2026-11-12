Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446325;
	b=SyTE+iwZKwqyHIIlJqAwo+2+9+5cf5W8gApu2Or/S2zpzxQCu16ag4stzvIuYjubCzRp
	 ChiupgHgvHlAIBNlCL1uZZLegRGHq/7KzvE64+rer2yJamQVXduv4Bsqd8ztAJc7yPk/r
	 H6iUZOhj6L64h6jzdmyFesp6sKXtCFlLIthiZYgpjE5f+f7Fo7UZS5q+06phbiaNIIkkk
	 i8fd+jvlftfb8GYdwKssrFgLaSzMo07LOLVBHEyEqVcTOpIXh5hff0Xse3eUZ+CrtlNZQ
	 esMr2zB5EpX+JV8a1Sm8txs0D0cbBjseghl+l2Ilq4fdx001y+RcJ65xXkJiTRWEmXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=BbOODuGG0FNPjmT+T9b+kLN1Jw1z3hyQyq3dad9XfLI=;
	b=3Q63nfqjDeB3oHF3j6sF+k8KcgGAupoxi5jAQ310H4cQsT56vXZ0dy/RH1roVd9jbw+Z
	 92GHtYYgHnVNW0LppqKBvscGNsZ5+Z2BNJ5xWiKxEW6n/dbJT7rRE4tjM9vvJT3MlYoNX
	 sijwutGSYSFPtsZfpGkgvfJVATUp6nUFLj7VLdAb4DlZEBLfNRAmpWP5kCrjJfAj9+YN3
	 6w/VGdsWlGOtuGshAnHw7fTC9FEGhxLI2rAOkxxP2HeYL9V8oa/TM0mDWXeqDU2OtG82U
	 oZVVa60ihkEsbch0Wy3JeH1LKBmZhPhGmEm1reJVADHJNaNWzzakhu4lv+i6WyoSlQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x/N4LmaU";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9699606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 01:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9699606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x/N4LmaU
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso21570795ad.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794446324; x=1795051124; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BbOODuGG0FNPjmT+T9b+kLN1Jw1z3hyQyq3dad9XfLI=;
        b=x/N4LmaUUINrFgwptBM8QAlvbesRfu4BGD9yFRk/riBmXpTFAwL8LzBrtMivIx/h5M
         nnokgp4EAATpf3aI/KwuCHbZyiVUYrODGsx2gtQV/ThZX83DqA7Eb/P+fukzYMu6Gw7K
         XRqNTLL2ANJwV2q/XTaTBREHRukfZvTGYYmw8wU8EzmrLlMae4xXOqn1E7oDo2eAEvHF
         LHMMehFrGb1dJCVfV4StrJ5qftCuWhMd4iBMU8LC7pCNY6O7EaiqWXaclHbgUjralz8V
         R5SwrqA2tY47XgsCnvTJH2xUTV5REZbP7tX9Mseb+JP+Vb4EABFuxvzNc0K6WCp21vKb
         bunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446324; x=1795051124;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BbOODuGG0FNPjmT+T9b+kLN1Jw1z3hyQyq3dad9XfLI=;
        b=V9uiwWj8KkvuUmjmyLYTuxXx8x9z5O0luzLc4YhHoZPxvLa4ZiPwH1QZCBuJcL7fG3
         nRIiaSCEZ0Z7wrLh8mxZI0Fsb1bleIyD/isxqSmiKfGXoIQnc2RdPS1Qj19P+zmolTor
         Pit4llT3IGdJJ98CD/871Kl7wBvzgkzW+zGqkvZUsTPSSu1D49Y8FZhftUvCq7y3wiT5
         cDUc7snweti5EBfN52tWhxkigfvb9SITOrrD3U7DeXS11T4+XgpMqfwOqJYjO5earGIg
         quGimG9SECTNQnOQkguMLHBq7W75oP4xr3IoIEnWsEKFRGfO0gguSWGOQl2XnkpxCYVU
         lJow==
X-Forwarded-Encrypted: i=1; AL+hErHkjw/VMBTDaRgmZhyOguGqaMj+dth300POp9cpK3iVnp79k3j0juF+Dhy0W+aBPIJi9SE=@vger.kernel.org
X-Gm-Message-State: APuU4Z84qk2Ur7hDhWbZivwLb0mIffkLYFmG890QSuQ5C3V1/J4jzIBn
	7OjYsf1P12EbVLElhsreqXmTKeLGwbYlQUKr4SKph8QMnr7VhUPj3G3Z
X-Gm-Gg: AYBFou18MZde3gKzKdglvdy22QF6VgFp2/AUrea9rulsqOeuJrD531OikF8Weg0O6GS
	Lnv3kh87OmW79rnmKhEpP84x+U2QBW0RU9Z6mYmzVxwItUh327A0vxktepB5shgTkXLONihph7X
	gtLk2rvjewQQePWH6mH0xcztoNWUmgk9bRmyeh+DNpmDvol52pZEJMrQddGGovWGhLK9lP3ux3X
	ro2YiTdTC6mb244DdwmQyMqcTFoHTGLStw+BasHLgn9Po6x6jbbosx5CZ/amOAmpqx+LYuKX1hl
	jjzoItVNmyjGWmfUMXdlFrm+s7tW8zPyLuuZVNzeusB3Deou7jsuJR2ZMfn55XcPyQgA6Nfa+Nf
	GC8uPz5uvykA+ImUyl+kEPFw6vn6NuIAyabWXUS+Js1f6gN2Dv3Ce+h0gBseZpBM078gkuRYsQa
	GFykLip9aXoQbTZpLNgeVyXbXEJ7DLIEguwu40tMYlbyejcixIiDqmj5YXLIPSQZ6TCh0/lGIKf
	OGZ0r2/bg4A5QDsHRzefNOFrkBo9u9rigIcXa597Hz1bTS7hMJUr9S1kohVB4bOGAUIi4IbEBZk
	6+HroW4OUVAArdeQMIcpKvzdrsjfyI48vL61ch+4PGx/VlYQart4Tq2KXIhb0cID/fvrmT31BhD
	6q/r5Wt/hcG7+w0cfZ/FNNKmGLsg4o2CiBA==
X-Received: by 2002:a17:902:cf4a:b0:2dd:ad74:ac28 with SMTP id d9443c01a7336-2edd7752fa1mr45783595ad.26.1794446323913;
        Wed, 11 Nov 2026 17:18:43 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7d964sm25621155ad.32.2026.11.11.17.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 17:18:43 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 01:18:42 +0000
Message-Id: <DMSU4S7392QQ.357Y29RMDZ8BJ@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "JP Kobryn" <jp.kobryn@linux.dev>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
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

On Wed, Nov 11, 2026 at 11:39 AM Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org> wrote:
> This series checks recursion per task instead. Each run already links a
> run context into the task's chain (current->bpf_ctx); the run context
> now records the program, and the check walks the task's chain.

The link walk doesn't look too bad,
but pls share bench trig-fentry/exit/rawtp numbers.
Maybe we should do a per-task array of progs instead to detect recursion?
It's likely more cache efficient than link list walk.

Just for the record here is the illustration of
the case I was concerned about earlier:

  task A, cpu 0                     task B, cpu 0
  buf = lookup(&percpu_scratch)
  fill buf
  <preempted>
                                    buf = lookup(&percpu_scratch)
                                    fill buf
                                    output(buf)
  output(buf)   <- data of B

               today              with the series
  -----------  -----------------  -----------------
  run of B     skipped            runs
  event of A   correct            has the data of B
  who sees it  recursion_misses   nobody

A prog with a scratch map of its own is correct today and
that's what plenty of production bpf progs use today.

This patch set will make them send corrupted events, and nothing counts
this corrupted events. Today, at least, you have a miss count.

Please add it to commit log, so that trade-offs are clear.
Commit log here and in cover letter talk about 'what'.
It needs 'why' and 'trade offs'.

Also should we add an verbose warning to the verifier that
when the tracing prog that uses per-cpu maps might have corrupted
per-cpu data? I know, no one is reading the warnings unless they
are verifier errors, but above scenario really worries me.
I thought about automatic insertion of bpf_preempt_disable() for such lookups
and bpf_preempt_enable() in epilogue.
Maybe that's the way?

> - Timed may_goto keeps its budget per program and CPU, as before: a run
>   in another task can renew the budget of a preempted run.

Not quite.
Today prog->active rejects B before the first insns of the prog.
These insns set count and timestamp.
With the link list approach every B gives A 250 ms more:

  task A, cpu 0                task B, cpu 0
  spins on may_goto
  <preempted>
                               enters the prog:
                               count = BPF_MAX_TIMED_LOOPS
                               timestamp = 0
  spins for 250 ms more

On a hot function A never ends, and it holds rcu_read_lock.
So the promise of may_goto that I just fixed a week or so ago
will be borken again.

pw-bot: cr
