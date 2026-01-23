Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76282494F0
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191563; cv=pass; b=fGpxCHuPJ6IfXf7eoTPtmBPHFHlObZox2w8UiqOjhyOw3r0i+XVAHrwRMDQvDeYjbrHYlDBsoHzCi7RuFfzo/iN/JsQTrhNuMMhVPwmvPh6eJ4pjsrAc1ebu4frMcuXelh4PxEwj4zAzb0pDosQb84AVbbr8Ffc8d2Xwhhyh3Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191563; c=relaxed/simple;
	bh=FcLGkCfuB/sIPTdRBcsJjPn4bR/XfGlb046z63lGRwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyZO2ACnGNrto0X1bkfViyvh4yKpFNGL2CXMqISzHcth27Qm07aBtLp7uZh2q7wRhedS++1S82gWS0mmXGDp5V7C+8Luo/a7ezM6ZxuHkRQ3dfhMnSKOppvELlXZyUA8pc3OYUIGZoCmCfLxCK9ZOxcEVcPm9srJ7g1Lp9DtvJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsZO5qEF; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsZO5qEF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so28381855e9.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:06:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769191560; cv=none;
        d=google.com; s=arc-20240605;
        b=JTBZUHWmLlxh8XsXgWwNyGSmBdPgZzRx2VVoNBxs8FyMP8dHvCKlU429H0LHITC5Zo
         bfvcPB1ebhZnBD9Npn/rdr7eC03nTywSeD4h+Ijc9W57GM2INwFoNQwkbHtIvuY/OApD
         bsaVZWapOIw4+FcjgcxrlkWc41O5jZ4EUb/syvSb5a3vcH43f01NAmTYSj7UEZJcJ8+d
         Ltrqkvec61P6PPeRjHd8QxOiHhrzx3EqEud3cL2VJfwA0yW8q1+WIhKbECdfhsVBQnd7
         eE1zJOLvKK7HQq/FCdiK7orOvW98rkG9bxYz+zR9nLbf1z32E5AThYLZNDlTA/RffD5F
         mjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FcLGkCfuB/sIPTdRBcsJjPn4bR/XfGlb046z63lGRwk=;
        fh=UGlA0nwkL8NkpqnqVroLYEh3Qbl9LvsWCGZRUJb9Kaw=;
        b=klrO4x3kwv6tD+fWMzhyMlJHR2IEVnCZFRWci9FVk23PThXm5CDOKqMbu/Kr8uc1lA
         L5dcTVcjYn61DCyDEzWPNCmtqka+Wemk1FJY5Okg6kkNolzjjhESBFbQX21mTdW3iZim
         Q6+B8MZCc+NSA1zdxDg1HnIp1FGRUU7+3zJhUzl0PtRQ1IWesD5N/yZiEpAFKda0kz7n
         yKj9o8hPQvKBmHkPfu7uzbw5TuKlewAUZs8ww/iuSb4I/fWzvyUo7hUqZggHr7i9OxQF
         QLunxpEZWzFjb69Q6BmsNoxSeRigryCrK7a0HfqF6tNkGDJiju2wuHEWzO6mspEdmo2/
         yFpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769191560; x=1769796360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcLGkCfuB/sIPTdRBcsJjPn4bR/XfGlb046z63lGRwk=;
        b=SsZO5qEFM0nALChMkEi2p9ZATcjTr5HTxbYzAnRie6x4E5G4uUomhl2EAucw4kba9o
         llXEqsadVqEDPvXoGyebXn4D/qQq1jG+P1lKXrVAUPQrN6PNWYf50FKXH7PgH5zf5j6m
         ZYHiRCZiCDyNZWFXawDkCS7bhWiPjEIOhBOow6UizK7AOE2wQW9J1RQxQgaHWo8knIoc
         98tfzgeilcYII/YN6Y8Pj7dFzCt97QtmKopCUS8/018wYNIeBVisr38zetITPCXoGVpM
         /vpfIiuarYkN5KSsvulQhpu/E+RYP/yFtyTOyyJvH2YH8tvd0fHUVLwf4J15kAUAyngT
         IVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769191560; x=1769796360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FcLGkCfuB/sIPTdRBcsJjPn4bR/XfGlb046z63lGRwk=;
        b=ZudaDdUIcpKf1QWbO15cXYgKaPWCW0C9ufUt/jlQLyhSgR3WWc3hgaSJiJlhlrhBSg
         PXBGsqH6Gutx+NuT4CQn5QcgYUBAia+54t/ABNoKb2/2eYBgSIRZhFH/L9PMlvo2Aj6V
         Ua3Wro7dZSM2MawipZbivmiMEX/mwkrw68FM8gF+tic9g37eq6YdS/gCGeKFtUq/dD5G
         bwEYQZVdtMDt7KL11HprlzhFnmgXNgUIKrw+LA/D7IzD3qU0xVdhDNPli+MYX/Wx65T5
         j4m5MTLN0YwaoAWgoH/+/6AmYp8km+sc6XeB1mCr6SbtQoKlRGm1XBNKvKbGAVK+ZlYP
         gR0w==
X-Forwarded-Encrypted: i=1; AJvYcCXfXsKJBz+gazePewQkhJ4ZpNKLaj1VeKcBjvwGtpAFl7Fq3XG4j8uVoY0aVdSXYSik4jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwYJnpJgxRs/reDq4zliT/B6Jz0xxMdFacxhsMaqbHBLnqzSP
	zwl4z5/0wSoPUihvvId0qJ26PHqLeO4mhl9MBjXtFzaD2bJTYdv3/mEt8f8lXml1PsoJ+NiyRVa
	5/z2jK8gicRjgSwoN0yI5Tm+y/flwUZ8=
X-Gm-Gg: AZuq6aK7SKBWrK0Vx1h+0+KpKCVLIJZNtR1yowiJ5o69EZE5HjIidyI6L6GS/TBS+lK
	23EuAbMSPHZoSSAGk1UWtvwTyFGJ4VXOPqpqAQts4lJRLRcd1tJfB//SC5NtTxzMqnWNY9w9kUn
	qsYX4x2GLHbMAZuPYX5wh4kPOxGfbp/CMfDTPbUGQjnJTUy4UUtBmdSFmwQrNO7EnmsTgp7CirV
	EHnbGGPwtYkrMvy0p+govsPHcMmb+6wt2YHcGjTa40pT/fW01cLJN4gNAlS0u5hsQLB0f9ANlZz
	/giCE62nS83/FeIcvblsTcuEToVFZqG2xW51nwhxZqn7Vcrojm7QHLgoIn402e3V++QGqpEX
X-Received: by 2002:a05:600c:621a:b0:47e:e076:c7a2 with SMTP id
 5b1f17b1804b1-4804c95e12dmr71414205e9.15.1769191560210; Fri, 23 Jan 2026
 10:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <20260123-sheaves-for-all-v4-8-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-8-041323d506f7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 10:05:48 -0800
X-Gm-Features: AZwV_QjSjoenDUCyXmvsb5KH8Pd0BwP5NV53NJnMQ1RHDoaNt4mnnL7gEc0SK7E
Message-ID: <CAADnVQKW2Z62+xC5NUsx4ynqbwPh5yn_EJJrQ4kcPab6KWUK-A@mail.gmail.com>
Subject: Re: [PATCH v4 08/22] slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> Before we enable percpu sheaves for kmalloc caches, we need to make sure
> kmalloc_nolock() and kfree_nolock() will continue working properly and
> not spin when not allowed to.
>
> Percpu sheaves themselves use local_trylock() so they are already
> compatible. We just need to be careful with the barn->lock spin_lock.
> Pass a new allow_spin parameter where necessary to use
> spin_trylock_irqsave().
>
> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
> for now it will always fail until we enable sheaves for kmalloc caches
> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Alexei Starovoitov <ast@kernel.org>
