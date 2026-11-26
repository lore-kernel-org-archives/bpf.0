Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725581;
	b=KFtHG3bsAhHh6YMr6M8V7hdTYGVQQc32SjwSfLwJRvuu9XoA+Ya99uL7S8csEVdHUo9E
	 f6nGdNl/HCuDiFQENT4DPycJgECVk03Izl5LYB5R4LrAihnKsnGQN/rrxhJZ/ovZn/bCN
	 dAOTEAg7jBIbmob47MBG65miOKd5bAgv97jjCIaXo5U+RmwNIjIdNc0tKKNp6po76r/bY
	 igpNablSMIj0H68jMU/xypOzbjDzldVnRyL1i842ZCr4bOz0Z3d3wMMvvUQpG2Bv3Q69H
	 M1/Ee0Zdi5nNCAgYa30SXdzmuosq5vnZoalGy67CC2p4JSqvQzgQM1xPhL6dIJx31Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=1ULurqX3SBBqjAdy7fFaPWDUCghKvLpjXthTQufVgQQ=;
	b=PDCikgOgP1NIdGogmH4TSsFAhT8xe1hOPdFrRg9jP5l+kne2TsfOUm67lTFI285f0x6d
	 p6eLvrOwJ2Qw58QRjcGe6jrW8SXABSmF5FwCvcw6SjFHfgGSsLBgWJzEJx64/Vw+RSLd5
	 mO1ogc092BR+qXSE0pu01x9HMEX4HJawciRpqccCHxkFlNhM2+Y5ZB/k/Lx3YKsnNIeLK
	 m8uWmooA25iGzVJFWEwJ0W3zA474IYazoLqLCGUIyxtwLGsZhoR6UlFriLRBgMWJjrx7O
	 SWHOhGTICMTqEdAq+L9X5AhYsx+AoHREYsUGbqcBqA6uk5roaCUXE/5AT50CJ0kVAvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=decMy6mI;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460E606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8460E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=decMy6mI
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f0a0d1a1e5so23516345ad.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795725581; x=1796330381; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ULurqX3SBBqjAdy7fFaPWDUCghKvLpjXthTQufVgQQ=;
        b=decMy6mIngbwbYrdEb3XYeS+NQ4EySEQf0DNiQq9vS4bfEoI1ftzY5klrUE/UYoZpl
         UJTEh1N9WBu+1uy7ktAYMpGHWGdj9YaPpaMtz0xCbw18tuoAGODHZ3U8GmHb64nLa+7b
         kYCxJ4+yu9fYrkvdOKV6/BHnMiXQLY9AH+u6kmDneT1d+7AKLLg23WJ8a6Ll5yY0QeBv
         4WXmn4PK1NHFfby7xDDtCG6MAN8EpYHTumAQ7lNIeDxrSVbru47az0IpHD3iAGvnuleG
         WdVJwjHlLtg2ey9qVGk6ercNXpoECLfuAFg1WnEKIAfElgLu9pLLnVZ43TQCw8mUzStX
         hbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795725581; x=1796330381;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ULurqX3SBBqjAdy7fFaPWDUCghKvLpjXthTQufVgQQ=;
        b=snFkgYwrpKfDlRoExPPjWze4M0gpvx/btGmPDj3A7efty0V3phoitCXYeN63U7jy9X
         rDLXh3rc0EvOBIzw6aRkBGrtWFprFlgK7fPy+pCXpkENcjskkaRQMtUoe+aRAO46lcXm
         0ik7tnu/07zOKvfJJua+1p+toc+QYW9A8GonGt/aFuFOdWY/1rkVps51VFH03RxFEF8F
         EVL5K7vVuuxaggXrNopqHGqwToPqpHCRUBHp233ykBjrpbODS+DaENYbst9IZz+JnqBR
         uG6fDjYMA7XNW558FtQN71zGIxf41Jlogb9nI+bW1yHpERJQuekdwzkO/CbXm7943kK9
         MdDw==
X-Forwarded-Encrypted: i=1; AL+hErFxp6UriGBI+VlHgSOjyes3kKRLdcKWJbEciFFpysp0KDM4/F+YAGsWtt40WPh9UArxIRY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uUSzCsptaPpAT1NH2vXIeZYmrM7fyS8ga3nzKip08002qaZ6P
	6JimkOh3xQQYMlHAf6Q5s30thnGUBW9X9ZcARcw0mJYvX/fk/g9XzCJnTgDAVg==
X-Gm-Gg: AZFdTZdpzdq5mK3yGEiQ+NVlIavvuTVxcOOw8AnIdeWDBJ4EpYBjRzWIZNYhWXifh3M
	tYvHJcA4aT3NQaJ3F0kk3w3B3tcFfwkrWc7zhOyKsI3RMwLt5owLAaBIxlGXR5VwQYyimxpv7hn
	f+Rzhu3DP+qhWNKymaPbfuwHldmA6wT4JE68rYHLht9pNj/aibk9qDyzFubdbYLubxJv333k+NA
	a5IQ6xkdd5BAZQ+B0TNBIRpZAngcIUFluejwhpNl8R0uV4aCqdzjSOFlqpH6MnYExcrLIBkAbRq
	PeBdb+36/FdzxYc3mNDb/+HAbMc1ZnHwFBTP+OPTPL4rTilsXQvoLFXqKgYgHD/chUFy4Qes4O6
	g7Exb/uimr5K2qpQiMUXkhYQU8C7fP+WpXUV98Vk5zG/Vus0rha7Ri3m519N2yYAK3U0ksxfjkD
	HyekO4wDJYMzHhxbzgtlYa3lB0fGxldv424ZaAGV/OlZuMP3p5C8Mal8d+v3wjWlUzm1jGMICdh
	NLpDZpRfGyTC4larU2uS5ofPvI223TIkoOfrRyRahgPpRGFcFG/Cs2cV3YdGow7AEXwPcXsx1Vc
	DilWjLDIu5vDqBfFmQNsY5faVZPGmq4rt7ZHu5vj2YxIdKJfF4jNE2VIdsN4/D7x21YxZpoZ0Wp
	oNj2AfmUJjfodmqyR7YPHPlQ9hmgJ2/V8mQ==
X-Received: by 2002:a17:90a:da88:b0:3ac:a11a:7c84 with SMTP id 98e67ed59e1d1-3b41c982dafmr20430646a91.65.1795725580807;
        Thu, 26 Nov 2026 12:39:40 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d026d6fsm11352777a12.19.2026.11.26.12.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:39:40 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:39:39 +0000
Message-Id: <DN5FLAUM107A.TFWY9O1V23F3@gmail.com>
Cc: "Harry Yoo" <harry@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-rt-devel@lists.linux.dev>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Hao Li" <hao.li@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>,
 "David Hildenbrand" <david@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman
 Long" <longman@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Peter Zijlstra" <peterz@infradead.org>
In-Reply-To: <20261126094403.GA49833@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net> <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com> <20261126094403.GA49833@noisy.programming.kicks-ass.net>
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

On Thu, Nov 26, 2026 at 01:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
> Allowing this on !RT makes people think this is 'OK' and then the RT
> people get to fix endless crap again :-(
...
> You're actively creating something that doesn't and cannot work on RT.

There is nothing for RT people to follow up or to fix.
The diff doesn't introduce any new failure mode or a path.
alloc_pages_nolock() works this way since v6.15.
On RT it returns NULL in NMI and in hard IRQ.
It allocates in all other contexts.

The API that people call is kmalloc_nolock() or alloc_pages_nolock()
and the contract is the same in every config:
any context, and NULL is a normal result.
The caller's code is the same on RT and on !RT.

> Locking constructs should behave identical across the configurations to
> avoid divergence and create problems.

Conceptually I agree, but my bot points out plenty of practical
RT vs !RT differences which are way bigger than
this internals of kmalloc_nolock():

  where                      !RT                        RT
  -------------------------  -------------------------  ------------------
  debug_objects_fill_pool()  allocates in any context   preemptible() only
  printk(), legacy console   spinlock_t under raw lock  printer thread
  vmbus_isr()                spinlock_t in hard IRQ     irq thread
  kvfree_call_rcu()          uses kfree_rcu_sheaf()     skips it
  local_trylock()            works in NMI and hard IRQ  fails there

