Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FE363096
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841854; cv=none; b=MWt7UpYXFCFFILd874LjxSPwsBa6LFVclx6arHYvQsLuWGrORgd2VurvWao2qZYKPRSc0+Nj5MG6AARHjFuq6lyKSkWkGV/ZDkCWOTbPhf4j4XkbIs9xdeleX+3ze6XUb7QRkwA8NCTQ0JGI3NOBn/lZKRb0yrPSHwniu/JSlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841854; c=relaxed/simple;
	bh=UcqyNHXZvx2r6WjOFg4/qjzvwa+voeCemJ2lL0pUUTo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=WCy7pn0m/FVHF/1bveFr1yAnsYmyKWBsobq9RNhWZsKZ4/uVd/w1WeB4pTRnKEK+upHce0JF4xtQgTZRGXODS5VaWXQO9Vg0u1wAuJURsVUQhWcV9VybpyhDoUr97LjbQdNilF+l2arN60w/LVF0YJ3i5oOjNGFhwiOaUMRTCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZGOIzqV; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZGOIzqV"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1432917a91.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841852; x=1790446652; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXlL+5LiPO2Gr9S8btdNT0yhev55DeOp6fa7hhJR9YM=;
        b=iZGOIzqVjH3KpgRpSYo4htAvx6vnlXJB+5uicB07fMADM3UWjWyD51s8PeF7W6XOPa
         PcNjDMkqBqakhq8iNuW30ueylE8qP4Ki+ZEpVfkgFfLe+uxJvzR7EV5pYza4xoqCHL3B
         Qf0XtBJsaGcsc3ILJhWG+aBa2ThnUbB8Ex7FVOLrKZOnz7irLgvdG3Y2R/Jhzu2Dgif7
         rkPScs2pgv6x4o9ku5qv56MP07RmZVjRb+7O71KYQLZigrx+X0BkH2cVSB5YLLbRbw95
         9btNpI5xE8Uf4wuz6NIve8n0eA/LdhNgPmVKE7Cva4qHtxR72maDh8jd/UV4TCMWrvVr
         KXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841852; x=1790446652;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXlL+5LiPO2Gr9S8btdNT0yhev55DeOp6fa7hhJR9YM=;
        b=RAxJ67K5F3RqsIhcK1JzZwPkAf/oQTUh2HllRmltmU/OuEAv5v1R0eXG/xXv+cXVdY
         g+OXAMNnDH/wO7jByYxjvdYLYutnzuvJwKgPTu2QnLjZ4A4WiEKs+/a+uRfkW4Fh693I
         Nx+3uvZgpm/LKUxm1KkrloaHwDBnhUFzy070LtOl9uZRY5ADS94qeEvFXiXQVtXpmixZ
         xJvqNkkxwRaJCmUPH8T4flhceFJZg6ebtaipRI0FQdEy+JiJUqjghm+g54r+nmNDYu+m
         u5fNRHT2CtZ/8aGOl1cWWi7eoXR9ptUB2fYP1pnv+bPA/nGEHN6he0hMtcHkPmr6EAhh
         bmmA==
X-Forwarded-Encrypted: i=1; AKwUvBxt7mvXU7lWXnpv4wVjBcoD+E+v7h4rJECMOrsJfc3zInGU5pq+1DqnNzQKXzMZdMhiYwo=@vger.kernel.org
X-Gm-Message-State: AFuF++nTOHN/8euMXiPKidkH7a93o7mauIoCmbwHO1Uf181n6WGMm75X
	j22eKbtc+u7fuSsPPtAh4uuZUpwgVve4wthgjerPtmXfWQHQJwMeiUcH
X-Gm-Gg: AYBFou2K6SP+MvRmSozRw0bU+I/ll3L1l4ON4i5sMEvKHe/5aIHhkgh3wFgI0aAZ5fT
	dhrynV/NcgCvAeUQeAK+bZL3BEXcwcHJpo9yU/i4eeilZQnXvTN6UoiychLcfY/nYoWvRkzWUwZ
	sOAK725lVDPwcW7+zWYk8tPJH1OInD+fUbxb9K8AjwymKmiLg8O9s2RjtfK8MBqPb2A1hqOI7Tz
	+9hMsFj81BeGXcesZJVaVOFxerjcUAp1LvqA6cNGEKYaGNUhhbcdUsolnpQBG7POpHuHPGfETUB
	NhBhb/7JfGH4TqEUXLQIh9F0aEPQirIwJ7zjzOc5Mo+5LL2v4Dsm1VlboS16vlBCl6rkJeH43KE
	pbX3o9smF3k0YxxqPtqFQZ1TFQPi8n4feMLrboTDTZzG5F+SvePJHlMqse2QqjLTtUAvt5N/qQm
	my5Cf1wDR+9BF7ktYMK3WkXpQPMQF1cojkxG/i0BAGDHnY1CNRHXKU+xDwRI7JgUVDkkpNSSjW7
	1UE2QiJ5wkEcFb7J+NCbCj2zoPxFUukTdH9OxIASK7Z67ZpuyH/iWF/Tj89ZsrLE8DYoP5iVOtK
	i0s=
X-Received: by 2002:a17:90a:d005:b0:39d:f731:e5f3 with SMTP id 98e67ed59e1d1-39e54f0e839mr11355351a91.24.1789841851709;
        Sat, 19 Sep 2026 11:17:31 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55b83602sm4333791a91.1.2026.09.19.11.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:17:31 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 18:17:30 +0000
Message-Id: <DLJHZEZMLW0F.27OPPS218CX9Q@gmail.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Brendan Jackman" <jackmanb@google.com>, "Amery
 Hung" <ameryhung@gmail.com>, "Swaraj Gaikwad"
 <swarajgaikwad1925@gmail.com>, "Clark Williams" <clrkwllms@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, <linux-mm@kvack.org>,
 <bpf@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible
 context on PREEMPT_RT
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Harry Yoo" <harry@kernel.org>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>
In-Reply-To: <20260919171443.90512-1-kmehltretter@gmail.com>
References: <20260919171443.90512-1-kmehltretter@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 19, 2026 at 07:14 PM Karl Mehltretter <kmehltretter@gmail.com> wrote:
> Allow preemptible context only, as v6.19 did. A held raw spinlock
> implies !preemptible(), so the locks of the caller do not have to be
> known. With this change both machines pass 10 of 10 boots.
>
> The nolock allocations then fail on PREEMPT_RT from every context with
> preemption or interrupts disabled, also where no scheduler lock is
> held. Creation of BPF local storage from such a context fails, as it
> did in v6.19.

6.19 had this check in kmalloc_nolock() only. alloc_pages_nolock() and
free_pages_nolock() allowed irqs disabled since they were introduced,
and arena was sleepable only under a mutex back then.

[...]

> diff --git a/mm/internal.h b/mm/internal.h
> index 38b1165212c94..29646c4afb419 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1641,10 +1641,14 @@ static inline bool can_spin_trylock(void)

[...]

> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi()
 || in_hardirq()))
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
>  		return false;

No. This kills bpf arena on RT.
Since 7.0 arena_alloc_pages() and arena_vm_fault() take
raw_res_spin_lock_irqsave(&arena->spinlock) and call
alloc_pages_nolock() and kmalloc_nolock() (from range_tree) under it.
With !preemptible() here bpf_arena_alloc_pages() returns NULL for every
prog, sleepable included, and a user space fault in arena gets SIGSEGV.

As Sebastian said in
https://lore.kernel.org/r/20260831143500.x-saxdAs@linutronix.de
raw_spinlock_t is fine in general. pi_lock is special. rq lock too,
I think, since rt_spin_unlock() can end up in try_to_wake_up().
The check has to be about those and not about every irq/preempt
disabled section.

pw-bot: cr
