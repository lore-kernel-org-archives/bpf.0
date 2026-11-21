Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795235731;
	b=zUi/oJL4f40tB9MzvgZhrxO2hHGFYRdOkDpVOcloz9W5+wOl875IRD9l4cs2AWT4qszV
	 RbpdIiaANMo44tYEfoWuyBYPu0BAC0pIOquDWIfxaqWDSj7USj9UFC0K+WqEA7/9enhhJ
	 XZSZV8LoMmuBZRD6VeFWoQo20ggfIVja+LxL8ySx1qUSC41vNAYCO0OJUOeyb75LSDL/T
	 20CY6tT5tmb25+hayCYM7rXIdacKoWu55gCs6zOyooUTk0mF5OBXIs6QB4gvhOdBfZgrT
	 SXdWVaFLGf1/g91n51Xo2RhDIpVeh31x1NCkVQ/gUACgDTG+icdy7vZNpKzYRwi+2/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795235731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9R6zaVIvtgH5jzl+qiEpRbTjV5svwtDU6V7VCAEyGSE=;
	b=BzkwmIK0hatTDSF7QvXWPvpc5KhQ5+Ttru29mS9IwXZ3LvvLXe3gewUFyTiQcQTnT6PL
	 SuiOIoajVvBmDT6cIJgEkb57PNh1FGBdFDJ/4VlqZL+up3I24Uuf9sg/okXPDx877GwVs
	 d2C0+u5qhTOSurBDNs1unh2zTP89m2qDXztReyL5qcn8wn4Z0QRkNRd6bjB6GfD6tnEAX
	 0ea4NRcllQSpURAZIkT+97fpPHW1S8WS4BCSoLxBzCWwZRObjp4EjtK7y9rPZCh4KhYNC
	 XTGnda0f8oyvXQbNqx7mkdYAnGyBh147GM/5swqPEGa50qpfafFs7oCMLLEesYHfBcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rJ0c2FQa;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650A60A2601
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 04:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8650A60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rJ0c2FQa
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-498f5fa5103so932361f8f.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795235728; x=1795840528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9R6zaVIvtgH5jzl+qiEpRbTjV5svwtDU6V7VCAEyGSE=;
        b=rJ0c2FQaY85mIEKE24XBYeYjXwakqGKvCspyEqc+nGoiqY9yc0PAHhZJRYpl2fKHn2
         O50f1TU4idsNGR07JZbjcZU0laQtv6liqd+7rrLCV+8p6QmcHXK/IVrFnt3vTLbQie85
         3woJ9AHBJldjrKS+CSpG61enN7z2T8GquENXxfXDL7z6l0JP7DLMBsLx9HByvehXn1AH
         g1ts1UUBeoOhhEcjHszVysVxjIwWNKF3IwPiB3N3AX7UxwtVD3UGs50Gq/00NVq6a9uR
         N7vGunDQWZxzaArUXcroPjo4CKWW+yILZSW7N/gIWXLga+QzSNAgq9FwAwNexgFdkHdS
         wxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795235728; x=1795840528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9R6zaVIvtgH5jzl+qiEpRbTjV5svwtDU6V7VCAEyGSE=;
        b=QH41G2ZWwBE9B2BojGJyfsetiobm1U1hgsk0MufgxmFu0356QzoRvepfQhtXLd/2C5
         S4HNfnpmiBf4ogpCKPpppbFLShQikAOoMDddcvNz6JkxMYe1rtkBg679o+lpuBhVZBov
         rliiFdCoQXN1cAdofxtONMQzLp0caU5x0GkL3kF87Q0+aDFjWRSkamogKFeNBgcAkIwT
         ITlTv8Zi4y/0awXL05c3iimgpG/Qc8ybT8tKvQwBeBr7y1FebrMlfhCYYcyPcX6t+xXz
         LhVONNZkpzQCUOr2vcWCqeefUBcCEkIJf2iU5wtvkvLU3ixFU/CX+VCZ8GV3UlQDAOTP
         MFPA==
X-Forwarded-Encrypted: i=1; AL+hErHUcdfJlrG8peM6mPMC7b+JmrGc5RmSCM3K9V4ZJKZ4UIxmDKEtxZ+yT8d0tajSe1Pp3jw=@vger.kernel.org
X-Gm-Message-State: APuU4Z90UaNnwr2zsCsKvl0FGv28GgDXaHfb3hdFTWwUTvmsXJY09wCH
	i7e+u2vNzPd2Ej90YZWj75CtiH2veSk8vov+S1Ax595H6EJSOpAJbu9E
X-Gm-Gg: AZFdTZeVarBYF6XBPkpsxADMjD/KoBDcOGWdaaFCfjQwDOdJjp8G6dKtUIPbdgpBZdY
	vTjTSEtatMaXe53X3VQrqkqcepxVF1IXEHjh0WVKOfMD086FU7Do1ayyOw5WXxID7+Pfs+qkUj8
	gdOPAyxt6dO5b8BQi6SGXyUWJsGP2L0vLGRrWLWoIomwaZgnNecWvUL2ClLYOTngDUw1sFVuV3x
	kkhTKomzX3yrvYA1P1rT55bnfuqlwrxBh22cIj8BuCvMH6mBNW/PY/T1FdTl8ZlYgTEXY0Sp5NJ
	LrvfTDHIRWBqs1WlqBgdddM4LZ46o/HazKcK+HtvRx/lhKh8x2YHCElvFkfuLjgkNEZRDx6JGhJ
	NXPPKgV3davb3UuzLlHkCbuhVuYren8ohoqkhq8tPHPapg8se4r0J+aBvT8u74taaMB9MtWVH6H
	zlP+osKt9tysYFtHb93Xbsxux7J9D97fTfjKX/hwgUFhAIufRQGsTzaFLnIRVOSwZbOpictcpgK
	4BZ8DV8q3mlO0kAdHsBYJpm8it8g1Xb1KVw6J5avxISTsd/kch69qvRrS+sv9ybwuGwqbnNaxgi
	Hkib/nKVPg46J4EoNtSYssbOKoMQja1pdhvgKbWzMeikhg/yBuJS0Jbdn93OKnFn31wxrBl4Usw
	jnn3IwTtIQ/FnsmlYf3F8r7jndmzmKeOFhK4fDCRxdVVAzU5571YbFnRwrwjr5ZY8rny7IyocnI
	U58ieD2MASrlhV+r8KyKERAfxa5dECZqBH
X-Received: by 2002:a05:600c:820d:b0:4bb:7b4d:6396 with SMTP id 5b1f17b1804b1-4bb887e21c6mr111271405e9.3.1795235727586;
        Fri, 20 Nov 2026 20:35:27 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-aeb0-6801-ad74-bca0-dc5f-7242.310.pool.telefonica.de. [2a02:3100:aeb0:6801:ad74:bca0:dc5f:7242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm214023515e9.0.2026.11.20.20.35.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 20:35:27 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Stevens <stevensd@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] locking, mm: Add atomic allocator trylocks on RT
Date: Sat, 21 Nov 2026 05:35:13 +0100
Message-Id: <20261121043513.20538-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261020152708.3atPlnSl@linutronix.de>
References: <20261005070625.8871-1-kmehltretter@gmail.com> <20261020152708.3atPlnSl@linutronix.de>
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

On Tue, Oct 20, 2026 at 05:27:08PM +0200, Sebastian Andrzej Siewior wrote:
> What is it that you try to achieve and why. Why is !PREEMPT_RT not
> affected? Half of the problems origin from PI-boosst.
> Why has the nolock an rmutex-backed allocator.

The bug still reproduces on v7.4-rc3. 

GDB caught n->list_lock's unlock re-entering try_to_wake_up() under p->pi_lock.
kmalloc_nolock() uses normal SLUB locks. On RT they are rtmutex-backed, unlike
!RT.

> can_spin_trylock() skips hardirq and NMI. There is a trylock on the
> local_lock_t.
> Why do we have this mess and couldn't we avoid having it?

This was IRQ-disabled task context, so the check passed.

> I looked at the patches and there something about hardirq-atomic waiter.
> Wen don't have this. I don't think we want.

OK, I am dropping it.

I plan two patches: move range-tree allocation before arena->spinlock, then
restore the RT check that rejects non-preemptible callers. Does that sound like
the right split?

Thanks,
Karl
