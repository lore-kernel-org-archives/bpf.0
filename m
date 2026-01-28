Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA3337BBB
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587251; cv=none; b=tLrFdHFla/LvM17186UHK4hshnZeWUvjDZ1oeYB/p07zB2ZNs+hvJvHKCqOQQEXMbBLibHcAOqkd6n2+r33ooSQmVNKOm+yxGqmON+WXTp7skb8nzXGhueJY/pCsgiXf8glRmDGGmfSmtIs65+0XDc5ktUozKiQnQrLqUmRWweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587251; c=relaxed/simple;
	bh=bNVn7PpawUGH4v94IzRVlox7pQhq180htLMah9n4ZYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDw8SB64WDj0pnyPoyLybJbAuKoRi/WoFpP9LxPGKUwaReGBPnzcOrkY9VMtdg7eSfBQ6P9wLRloebnJQBeLkgnN+l3CW8D34KEuNE79g/ZYW6JahQEn8aAEZqrM8i0u+lAesQozhqCyX3Na0IcTVcSDM9ja0sYtw/bg9ZVJr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HA74jAcc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HA74jAcc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480706554beso2167575e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769587247; x=1770192047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOz/mJtzptjbG9UgUIfZqgEEjdmwSn5lnDfZqyL3N2M=;
        b=HA74jAcc4IcSC3Sccri7n5Wbtw1VuyRVhOG8o46sZtsAn3Kvi4m5lukjwDJreLF+VL
         e24y9zRgXiQ59bOT83lcvlagTBbIBcN8NKs96S9KJ2BBQuRYJF72XXc9HcrN/MSMREKX
         T6W3rz8NaEgO+BpvN6N9MXAndQ1WLj906tpS0UqNvUp2qJC3P9IqVLA11cFIw+ypz8rX
         TxrmQ5Xfynbvvqdqhd/+0dQh/IW8/iHQ6P8wYJNmVz9byLPjGzP5LBYUMadsskWH/269
         6ofgkHFpfnc8K7GVNgH0IsKrrNyE5AaHiU4VjhooqEye7DnPrq+TN1CxB/a7MQAyX+Rk
         fHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769587247; x=1770192047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOz/mJtzptjbG9UgUIfZqgEEjdmwSn5lnDfZqyL3N2M=;
        b=Wo62I5M+nHIJla9OeQ1q2OgWq3nazrAy2iPquGC25IhN95TdcW65CUeg5MUAwzsi/0
         kLPFiFvga8LTjfFeH63pz9BYov5NxfSf9P7vUoD1x7D5wevZ66Y+Kt1bFrwUlRnRMF7F
         3AFnc4lQcIPpqXm4T5fJOir+bcVCvQsCF3XpgrDv3wBOkk3Zw/kaYYqPeg6up708hdsR
         MjSgJFtMeC2IkDYTeLId4zktcGeWBrHBAeEwBWBdpmrA9iN/WVxMYdqGCsiOCEj2pRbj
         MyKf+AWMrCa1v91AD9tkDDp9UXiBt5QlnaJEFg1vpqfQ0Q5CrAPPzPtU4c/29zoXYrCL
         +kgA==
X-Gm-Message-State: AOJu0Yzm82gVxIZ1Yc9wTru+Od0FJqgXoBHRv762vLhXiJKMYEUnOBBX
	XluhKrOV/49WkZ8+puAFLzKsXg4VgewIduTFRtIRzFbjDeusze+JKdxn9B76Nr0hgrE=
X-Gm-Gg: AZuq6aLr5Lk4qPbUbtb8acfvpsx3SCP2v27B/H7moAJfmOXyk7joD4LndGAL2dRg2Xs
	n9rZRY5XSTdRWF/0RVQlpbOJHoDpH35IwnQxeWbe3ZA5gQ2qc4DOgXc5OPG9DwtxbV8Zs/2Z26J
	SzoLPcTZ0AqDKHeFFJVpi0rCOnm6lZ2MizjY67yJnfGLNEgg8vx0unbuo+FGjqwv9AhPCFrlYYW
	QmhWfc9O2V8LB1PFpc70AGP8x7s3sNJPo2Uch6H/vZNxlcpQJVoOhQQNO6UNTg7Q5OSCwWw9tCm
	VZkI5GCk9/Zz7mtOmjrHhVsOCQcBzOO2Y6UcjA4y65+je9rZcdEl9Uc9WgrSZTLd8bRQRKABm0a
	ilkppUkTtaJodgxwgW94e1cG24zZO3EyLSEePjRtwIJoZ1ph1RJUAoiOmvb/nsyfdiLOCUl+zQX
	8pUm/SToywge/7j7zxBAgrLqGV
X-Received: by 2002:a05:600c:450b:b0:47e:e946:3a72 with SMTP id 5b1f17b1804b1-48069c5fed2mr44222975e9.27.1769587246995;
        Wed, 28 Jan 2026 00:00:46 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm118235395e9.4.2026.01.28.00.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:00:46 -0800 (PST)
Date: Wed, 28 Jan 2026 09:00:45 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
Message-ID: <aXnCLWYbQ8xZ2IyO@tiehlicka>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-8-roman.gushchin@linux.dev>
 <aXiHok-3SKqLncCf@tiehlicka>
 <7ia4tsw6hi93.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ia4tsw6hi93.fsf@castle.c.googlers.com>

On Tue 27-01-26 21:12:56, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 26-01-26 18:44:10, Roman Gushchin wrote:
> >> Introduce a bpf struct ops for implementing custom OOM handling
> >> policies.
> >> 
> >> It's possible to load one bpf_oom_ops for the system and one
> >> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
> >> cgroup tree is traversed from the OOM'ing memcg up to the root and
> >> corresponding BPF OOM handlers are executed until some memory is
> >> freed. If no memory is freed, the kernel OOM killer is invoked.
> >> 
> >> The struct ops provides the bpf_handle_out_of_memory() callback,
> >> which expected to return 1 if it was able to free some memory and 0
> >> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
> >> field of the oom_control structure, which is expected to be set by
> >> kfuncs suitable for releasing memory (which will be introduced later
> >> in the patch series). If both are set, OOM is considered handled,
> >> otherwise the next OOM handler in the chain is executed: e.g. BPF OOM
> >> attached to the parent cgroup or the kernel OOM killer.
> >
> > I still find this dual reporting a bit confusing. I can see your
> > intention in having a pre-defined "releasers" of the memory to trust BPF
> > handlers more but they do have access to oc->bpf_memory_freed so they
> > can manipulate it. Therefore an additional level of protection is rather
> > weak.
> 
> No, they can't. They have only a read-only access.

Could you explain this a bit more. This must be some BPF magic because
they are getting a standard pointer to oom_control.
 
> > It is also not really clear to me how this works while there is OOM
> > victim on the way out. (i.e. tsk_is_oom_victim() -> abort case). This
> > will result in no killing therefore no bpf_memory_freed, right? Handler
> > itself should consider its work done. How exactly is this handled.
> 
> It's a good question, I see your point...
> Basically we want to give a handler an option to exit with "I promise,
> some memory will be freed soon" without doing anything destructive.
> But keeping it save at the same time.

Yes, something like OOM_BACKOFF, OOM_PROCESSED, OOM_FAILED.

> I don't have a perfect answer out of my head, maybe some sort of a
> rate-limiter/counter might work? E.g. a handler can promise this N times
> before the kernel kicks in? Any ideas?

Counters usually do not work very well for async operations. In this
case there is oom_repaer and/or task exit to finish the oom operation.
The former is bound and guaranteed to make a forward progress but there
is no time frame to assume when that happens as it depends on how many
tasks might be queued (usually a single one but this is not something to
rely on because of concurrent ooms in memcgs and also multiple tasks
could be killed at the same time).

Another complication is that there are multiple levels of OOM to track
(global, NUMA, memcg) so any watchdog would have to be aware of that as
well. I am really wondering whether we really need to be so careful with
handlers. It is not like you would allow any random oom handler to be
loaded, right? Would it make sense to start without this protection and
converge to something as we see how this evolves? Maybe this will raise
the bar for oom handlers as the price for bugs is going to be really
high.

> > Also is there any way to handle the oom by increasing the memcg limit?
> > I do not see a callback for that.
> 
> There is no kfunc yet, but it's a good idea (which we accidentally
> discussed few days ago). I'll implement it.

Cool!
-- 
Michal Hocko
SUSE Labs
