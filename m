Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462481;
	b=no6wI+jzQ88TfIeMJp7RVrtkXMIVMmW2wmrIIO12Mf4xZSqFH3qqTGfTVpVTDDsz/jWh
	 inx8npucps4f7Shs3GWyToON/qny5Et8K5DDvQ3P3L/QEXM7/bRBOjnXRoEW+ldLTKxw2
	 hIFYnFOVabuFYU2S01hWKzbj4f6NOFZum7ARZgcuvi8gMFjP1vEF1OHPmkztrc2om4Oec
	 SnCaVGFwco13Fpi0hlYSi1M8aB2EsgS3mw1kfjowGjUBJZmZT+sLQPyoCGcWc4ttB2lmI
	 22d14OG92Ob5hZD82F5HT789tv7u4vSiMsuvugkBKVivdqMDUi6fRqYZ90TMa5kmTxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5Iwx53FddK31aCeF3yTsYcRGG3DAdKI2xVbjXFtQkwA=;
	b=RQbq1ofCGJFfnFxicNwPEIzTjbt/8SCfo2OyN/kKpAJM7hlDeu1ApyXEQPkHdDPE/ih9
	 X/1pgWKasrmELxvx4eu2m+p4T8HafZNu4ilYr6eYKd4zFk3AleUveshsIkpOvggjOja2I
	 lf+vFJgBtdERGOGMFc/ZtjNnNCo0LSWMVfERJJJdbphu7NPSvvVNufwNCSv6bU953Yycj
	 wWOQAfxNlMJGwifcl7dhRsmbUjVEKIkq/1vQqEIdUww25JtUCVKyQ/vg2t05JKh2f548s
	 N+21ttk1MmT1CQzIF3z7QQtUExw9v2mGeCDyPESjMmCB+DM+9OsjBzol8cdTTQeqQvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oBihJ65C;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA27606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 02:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA27606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oBihJ65C
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1605049f8f.2
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 19:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792462479; x=1793067279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Iwx53FddK31aCeF3yTsYcRGG3DAdKI2xVbjXFtQkwA=;
        b=oBihJ65CMLYBqYHD9hPzlwUnnU21Djjlk+0ywA8lRRGdNyRHqBkmkB2lVi7j7VuJ1l
         MPwAaFfom20siTmykpM4ACL2ty3lpQ6vyWJJmpPI8ZNX5UWUMWNCT76IcffFNMOUGFTk
         ORdK+O3A4W904mNRG0BhTfAQ3NjS8YqXkkKvnV12Bxd9kRss/cY1Tv6b9jyxrJCeHjml
         1UVPVfEtj0r/j8yx2gjVcG3pxob+11ZYhiUZjgUj33HkXufAXfebmxat2Oeiaf2Mav0z
         Vvwv6t7UGKyBpY9zHG+AYKsyBiV69wdVVX/+3Y2olVz6L5eDY0ngAgoqozcmxhtarnNO
         JaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792462479; x=1793067279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Iwx53FddK31aCeF3yTsYcRGG3DAdKI2xVbjXFtQkwA=;
        b=QYUzcDMK+H94xlUQ9HIGZuR9m/5v/8AD0Gdw/fFm9t8ds0C+T7CDRgT0RThW7W2an+
         R1/AVfXTUb3bkX72F9xx5yNoVu0gilr70jGrJOZ+WJhMn4tQeX3aOcqROQfPAHiRCVQt
         bymdIaGZadNQsIRdM497tIUjxOr52xMBMFSK8rF5Ail3b5jvklCvV1/Pr7nTAo8Qvzk5
         UuRX7WBaMcuffP8/OUe/ww03W0yt1UZ/l4iTnsjhzXEPqwe8ETb+IZjZkfqnZaOMZlGm
         Mo5oUz5ZzaZmMcS3qBQl0YgRFOP3PLgLWFD99HcJj1pVAUhrxNWiUi5yuO7gydmt/WWE
         JkWw==
X-Forwarded-Encrypted: i=1; AKwUvBw73O/cgiP5UF6nSngGmA4lonXh8gX5E8biMrmLlYm1oAGLQ+PERgYzXHiaMIKItPzKPQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLu8PD7q7j1Zi47/DkKnCBKvo1W8OQcAA90kuMhLy7xmSf0Mdu
	fL+WV9uqH0KbRq7YQ7zgEci3juD+cNcroEItZIDsEKGySa0k9lCU2T++
X-Gm-Gg: AYBFou0rhPOFgJjP4g4/LauRrywIUeHAMhXLjL6re7BXgX9I50R2Or9NhhebqWqQwHT
	EyH6/XeOi1tdjokqaqacDd9k7x/thFL1K6Paes0S5T4odnvDBZlKUQD+y3LJ78cZWb3v80deWWN
	aW+CNpHO/icuK1/8P5kaCnLzhvCwurfqpIcB+JdApGPFsgQtkVOJFwMWzST/Tp5NQxGBOvjnyL7
	kcImqWOqfsurjIrHRh7AYwyTqlUxsa9K6wxGaAE/JobGE6/mnPU5Vs4E3oRTKlU9fbYOKVSYtng
	2sVS5bsmLU9u/jdPsR7TjrVMMqr5KyweTtnupMpxHvXUB9mSArN3BfCSNlvZ7CsLz/alIgysRG8
	TVJaL3BSrnCJrPkbMg91zxcbTuHIxuDiZkz8SceRAbB8m+55saREiLA2DpCoQeiVzNi73N/y+WT
	uecNhLvXwEDUoJV7FjJvKLXGKF9iDYNTOxlHIpGu5YgPWpuGuMdSckjAb4qSD4xF87FO48ueSeT
	G7wQDaFPMW6fXbM4lWgN+/1Ih6141sA9QyE32f1pMNMrHgoYDUfhp6jxO6NdYiWGKckcgViiU2f
	NJ/C6DZF8jlC8/RTaVW3mfJnDnYks8p4CCvCE5s4ILKJPy00gZDY+muJqO1sYP7YDcNAHJuNmwc
	FJBSZVxU1NA==
X-Received: by 2002:a05:6000:491d:b0:488:5852:6ee3 with SMTP id ffacd0b85a97d-48e07bc2f43mr19882172f8f.34.1792462478968;
        Mon, 19 Oct 2026 19:14:38 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9c92-6501-cda9-90cd-4e49-75d9.310.pool.telefonica.de. [2a02:3100:9c92:6501:cda9:90cd:4e49:75d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208b1sm2879816f8f.33.2026.10.19.19.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 19:14:38 -0700 (PDT)
Date: Tue, 20 Oct 2026 04:14:36 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Harry Yoo <harry@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Stevens <stevensd@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] locking, mm: Add atomic allocator trylocks on
 RT
Message-ID: <atbOS2rs94fB2red@gmail.com>
References: <20261005070625.8871-1-kmehltretter@gmail.com>
 <asZ8jmWNoGk5tYce@thinkpad>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asZ8jmWNoGk5tYce@thinkpad>

On Wed, Oct 07, 2026 at 07:15:29PM +0100, Harry Yoo wrote:
> On Mon, Oct 05, 2026 at 09:06:22AM +0200, Karl Mehltretter wrote:
> > On PREEMPT_RT, a BPF task-storage program attached to sched_waking
> > can deadlock when kmalloc_nolock() obtains an rtmutex-backed allocator
> > spinlock while try_to_wake_up() holds p->pi_lock. Releasing the allocator
> > lock can enter priority-inheritance or wakeup code and re-enter scheduler
> > locking.
> > 
> > The first RFC [1] rejected every non-preemptible caller. That prevents the
> > deadlock, but it also rejects BPF arena allocation and faults under the
> > arena's ordinary raw lock.
> > 
> > This RFC instead adds an atomic owner state for bounded PREEMPT_RT spinlock
> > trylocks. Atomic acquisition succeeds only from the completely free state.
> 
> Please don't skip discussion stage and jump into submitting a very
> intrusive change across locking and mm, assisted by LLM? :/
> 
> I don't think attempts to tackle this problem will make progress without
> discussing and getting buy-in from (PREEMPT_RT) locking folks.
> 

Sebastian, Peter, Thomas, did you have a chance to look at the locking
direction here?

Thanks,
Karl
