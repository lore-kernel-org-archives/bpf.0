Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D021D3CC
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814951; cv=none; b=mGuYAUov+qyKeN267uIwaXOYKrsDS0kGPNfA6nKWDEmPZxsR2fTRL90fz0Gu+PZGzkADSQ7kJ4tCGbRWLkCRUUjW7pA7o9f4yCFrxqDvjBjR0jKc+/IZ8Yr35DwYcK6w+dDPPFeZ9xTud2cnH8bqJDo+wtgT79bd9fntQ6Odc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814951; c=relaxed/simple;
	bh=H012cvQr+VpKO70ngb2geNjmZ8+ATogouv6fwUah+ag=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDI8WnKNt6m5PRyS1gzzuqkxsqHiKoHJOzDs+Z61sBkMlRKl9gbIKBvEYw+JmfkBwwWkWhQxOJ+LHilpzovPwAy0BCCw/TT9a7xGhxHowUG+Vu+i+UUbL37oCp4FZzbhFVVxK6VFfvUhqfa9WwP6rn2m0GfZ0+ZRBO247Q0ASd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azDoyft4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azDoyft4"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso2232549e87.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 05:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770814948; x=1771419748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deALlWWmUYhI7Qq/UdLZZQ3FMP5Fpo1V2LM+cbD7E+4=;
        b=azDoyft40sKdFn977XN48qhdAADr2n5H+XfKrgnvoT3haRaoUwC4KEWCqMYAkn2oHq
         9tru40UjunQQm/3embdu837wFwVhYXSOvYM1f1SgZavWIvQsKf8Ugsr6V7EvG4/xKH/u
         RPRpLMTnVdQjyHHPDTvHMMTLTEPej2DChyJVxY+l9yuW8zoYCU1gXy9JayoN4R/t2dHi
         REbsp292khu19BSyZkEC4YD7pNZS1bp5QZYW2K/NbHzfLf9aNTn7bJS7QoqKrZuZf8pG
         oJ9dhiWp60IM3aTmQ1o32xIIaJwLZiLeZZ3ooA7RHloi1CJeyB3jZBSW/+mlcGfPUQXZ
         TE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814948; x=1771419748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deALlWWmUYhI7Qq/UdLZZQ3FMP5Fpo1V2LM+cbD7E+4=;
        b=WKNs91qaaaL+Was+d80cXfDV8VcbS1l0PdS5+Dk1Ha+wY6BDzSGywuw2xiVzMk1BAt
         U2fHDQEXcKfa+lOvAuF+wE5hn03Pf8lK0qSQRtxHlJ5gHamCnHfGkRbbZNRpeO/merWv
         aXS3oQ/xCzvdz1mluxA3NKSDdnPhr+HyEisQ0pIylAd9pZAaVTbEx93U6hoyhDNruRa1
         ZX3nxQKRSi+IF93L1XLithe6Yj1G+BXav314sR1yMjKgmxrbDWLIZ+lAzaV/6V9l+vJ7
         tcyFpEo4dVe1MWsPA7Kp9desAHQMP+YuST3gmbXwE0KhtA67OIPSSYyJ2wh/rHE/XR0U
         0kew==
X-Forwarded-Encrypted: i=1; AJvYcCX9klGLGMgLIfxRThtMiv/2zCJhzrOQTPqlV9dpElUgD2mAyZl9ga17jfWQX0B4XKN3VPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+aSGKjrFgnZsaFiO2lm7xAfawYxmjAM7lW7UqACQDhc1CFcz
	KH1JRj36sQq46tpPhaki9xQENavXY9kTy6IyoWqKou+ZByF7RftQ00/K
X-Gm-Gg: AZuq6aJNRr514tCNNJfPNfwrFdBwIHopJWB8bSlKo/LFb44Rf4MGOtUPiRh13sS+GJI
	EAm5VHbxXPMEU7/G/epaxRCtUUpebfGOP4Y8I3wztpbWqLKvvwJl/TKIrSNLfBJd7w5/7V6XWyd
	6o31zA7p3kXSSz9eBUBZn1G8nRxbc5QsEcXo7egGsHgD4Ep7SOQYpabmTai237v3zGgsS3Q5g+V
	CHPd3sAemJYin96Zwc8RXxLVaSa2276KmQLPVi61wznEN9ejyEgzXbfv+k8L7Fd+uFxfsYyNNR6
	JQ9otdtL+5UjdzNQlDagmC9k/uXlycPIYCdp0UQtbBffnePvi+LS5TbQ6Pt8nWZP6kR51SjUZj3
	xTYHBD5wh1fxrZ2Iu0oeKor8UFwCGy/aWHIwW86qxDn7eorl8C76WmoPAASdCnm6V
X-Received: by 2002:a05:6512:8014:20b0:59e:45ae:7035 with SMTP id 2adb3069b0e04-59e45ae70c4mr4201894e87.3.1770814947718;
        Wed, 11 Feb 2026 05:02:27 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f89a356sm313641e87.92.2026.02.11.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 05:02:27 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 11 Feb 2026 14:02:24 +0100
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] mm/slab: introduce k[v]free_rcu() with struct
 rcu_ptr
Message-ID: <aYx94NTsLfQyvflY@milan>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <20260206093410.160622-2-harry.yoo@oracle.com>
 <aYxXE6CC0XQr1KNK@milan>
 <aYxdleYc7_TWj9To@hyeyoo>
 <aYxfumz5IlwBDS4n@milan>
 <aYxnfk6kCZ66CaOJ@hyeyoo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYxnfk6kCZ66CaOJ@hyeyoo>

On Wed, Feb 11, 2026 at 08:26:54PM +0900, Harry Yoo wrote:
> On Wed, Feb 11, 2026 at 11:53:46AM +0100, Uladzislau Rezki wrote:
> > On Wed, Feb 11, 2026 at 07:44:37PM +0900, Harry Yoo wrote:
> > > On Wed, Feb 11, 2026 at 11:16:51AM +0100, Uladzislau Rezki wrote:
> > > > If this is supposed to be invoked from NMI, should we better just detect
> > > > such context in the kvfree_call_rcu()? There are lot of "allow_spin" checks
> > > > which make it easy to get lost.
> > > 
> > > Detecting if it's NMI might be okay, but IIUC re-entrancy requirement
> > > not only comes from NMI but also from attaching bpf programs to
> > > kernel functions, something like:
> > > 
> > > "Run a BPF program whenever queue_delayed_work() is called,
> > >  ... and the BPF program somehow frees memory via kfree_rcu_nolock()".
> > > 
> > > Then, by the time the kernel calls queue_delayed_work() while holding
> > > krcp->lock, it run the BPF program and calls kfree_rcu_nolock(),
> > > it is not allowed to spin on krcp->lock.
> > > 
> > > 
> > > > As i see you maintain llist and the idea is simply to re-enter to the
> > > > kvfree_rcu() again with allow-spin=true, since then it will be "normal"
> > > > context.
> > > 
> > > It tries to acquire the lock and add it to krcp->head, but if somebody
> > > is already holding the lock, it re-runs kvfree_rcu() with irq work.
> > > 
> >
> > Check no_spin on entry, if true, llist_add, queue-irq-work. Re-enter.
> 
> That is much simpler! Actually, I tried this way during the initial
> implementation. I like its simplicity.
> 
> But I wasn't sure about performance implications of the approach
> and switched to current implementation.
> 
> It'd be nice to hear Alexei's thoughts on this; I think he'd have some
> insights on performance aspect of this, as we have something similar
> in slab (defer_free).
> 
> > You might need to set-up interval to prevent frequent bouncing.
> 
> You mean an interval to wait after queueing the work, before it gets
> processed, right?
> 
Something like that. Not ping a scheduler as soon as we added an object
to be freed after GP.

--
Uladzislau Rezki
