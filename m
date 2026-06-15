Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E673B531A
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555341; cv=none; b=TdLzOhaaI/Vz7iT5rf08QL57i9ABN8HjtphNJ6lStotS3Z2x3VwuDQLfkHPIDFZRqW69ZYwgXaZAHYiRzi4gJhFI+6jJfEUahdDW0rYnEq8niNYTFZYHcrUw8bBUm8bCsUMennFQ7xcfK+ROchOIlMN7Iw7nMeix0VrntXPk6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555341; c=relaxed/simple;
	bh=3W+exRfVeOk+9d4eMCZYeHa57RR+U+1NmggjR9Z7Tho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FVR1F9Uh19XrRBmhKknoPRwzoqE5yyjuLoJSpHNuf2nwvNIrBGlJ0jDDpS8LDKGsXaU9K2r4p5om2mqffwmI/2gIIMjhEHm6gIQjImD6pANQQk/OhrRiZyJLadG+RiIysZ9OF4I6LDgJUVF1T/IE32Epah9nyrJDGEc8sHwjqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6ivGIk/; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6ivGIk/"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-486b95fcdc7so1820185b6e.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781555338; x=1782160138; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiFoued8hhJkTkOiQh/Lgu3tiJjlRn9mesPkFyFrrsg=;
        b=K6ivGIk/dUzCp6FY447cJc48etvgQxTXHMv7Zu9hF6fT4SFzxcWDFO6iFA6UmCGRT/
         tsU9Zpep6J29yDEYJqnn39+hNxEkiKG8s+/Lqo9Oik7Epeu1eVb/VI6PflvZFN1ZVFwy
         DA714N5KKMQ0VuwrHU86WdZrXQ5yc3DyrVWV8ctzDianCldBzb232hXI4GHVxp+uO4tQ
         12rmd/YUMyhUY7K2zVwdvr1vhRVB7W8qFWurbGE4FlhUx4TswBZlVvQZky/bbZp8n/h2
         ITZxh2RruvR1Kc/HjDujSMJHtl5igFwsARw8Ujstz45BMQ1MN814a7k9I95U9mzyVdGC
         pgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781555338; x=1782160138;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiFoued8hhJkTkOiQh/Lgu3tiJjlRn9mesPkFyFrrsg=;
        b=DHaW2tXpUOTEwA1Unnr306VsQtysBsseP2NpaWbmRy2VXmDPw7iEVhLBjPK8lCn/LP
         7DhCACKLC8Y6gqVws9Mh2WIeyRUeliVU91cquO/RZtYgWhFjq/a/Fjalxx3jUBUqsJE2
         e4jQijGyhIbI3OXBmPyXu2zWiIU26HvjwZecUzB0zgQYPFWV6K6840MgAH78b+ElzulQ
         FB+J7LnjiJx8ViRxkry+jU9eOIGsHw2SGVhgG7Tfn7h633e8WB510KyXeZHp6X8LWuTc
         7Gr8P6ezdNCx859ikiAKZLx6a69kGQvjBw++SNyujjte/DPRrO0BhhJOvgTS/q9Fwq7S
         31Sg==
X-Forwarded-Encrypted: i=1; AFNElJ9H8jEW7O/or4GsZc8FOcBCqBZOEdGnmR3PhiQ5R3HWu2jZNhG5PNG830uGqkPigE9qOSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmxdVjDV5U7LAGfVoaw39Vb6Bb75kukmrXN9OQ5Y4FXOc48sK
	S3XrSr7WnVqYn/+/p92+wZteLM861kR1JU//pj8AVE+kJzhQac8qFxE0
X-Gm-Gg: Acq92OHGDcvjiRKTOjSjHv6jNOpWfJhjcCc5vKMw2N9tLTt/qWljg5wmSzUNa+SY7AS
	TlPKKaR6FEejqh6A3erEoziEb05OFfO8jPXQzbcKn26d4JckpoSaIlYfXm8EyJA2Ei/yZX4i/zI
	ycFtS9H1zHGvNXiJscH2pXNkWMXnLx13U78RBEHmQCDWeI+ohJO5VhjB7PMhv2gv9suLJFU7aHO
	5UH+yHMSm+x/xaLRzAbC9OvOhT/G7gh47sdjY4WMSBU6SsMuVM8jhqchPK9DcL74zwAWmLazFAi
	upsu3rjiIJ5iRXmciZmczQN561hBFtKW05xrSFs4wHL1T5EYSNwPjU528DQT4w+uGWTsMbhDdQZ
	l6lwcI45MY9QLWHEzrpboOoFSH15syItRFIPDZ5nqy26atHoeSUEA+8thi3f20GyM5i7W+zaPEq
	Ng9ruoDpycCVuSu+zKzQBoOxfGDRGpIATRBYBqjnqVAtCBNA0hYe2HG6fnZzyYQJUOhs+nYHWn6
	w3kw+e2Hspqd/5vrg==
X-Received: by 2002:a05:6808:690a:b0:47c:b38c:a19a with SMTP id 5614622812f47-4884c10168bmr462076b6e.14.1781555337911;
        Mon, 15 Jun 2026 13:28:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd9fd3sm3252791b6e.7.2026.06.15.13.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:28:55 -0700
Message-Id: <DJ9WNQFQ2B2R.1JSNL1RNABV6Q@gmail.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 0/9] mm/slab: introduce kfree_rcu_nolock()
 and improve slub_kunit coverage
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Amery Hung" <ameryhung@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>,
 "Suren Baghdasaryan" <surenb@google.com>
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> Not the best time to post a series, but didn't want to delay posting
> the series for too long. no pressures ;)  This is aimed to be queued
> for review and testing after the merge window closes.
>
> This series is based on next-20260612, and is also available on
> git.kernel.org [3].
>
> To RCU folks: It would be great if you could kindly take a quick look at
> patch 4 and either ack or nack the patch ;)
>
> To BPF folks: Ulad asked to share workloads to measure performance
> of kfree_rcu_nolock(). Unfortunately, I focused more on correctness
> and have not spent much effort on that. It would be nice if BPF folks
> could help evaluate it on their relevant workloads.

kfree_rcu_nolock() needs to replace bpf_mem_alloc which is backbone
of bpf maps and bpf local storage.
So all of the selftests/bpf/benchs/run_bench_*.sh
will exercise it one way or the other the replacement is complete.
In other words performance is absolutely critical.

>
> To PREEMPT_RT folks: The most relevant part is allowing
> kfree_rcu_sheaf() on PREEMPT_RT (patch 6). It carefully avoids sleeping
> by acquiring the locks via local_trylock() or spin_trylock_irqsave()
> to avoid sleeping within a raw spinlock. When trylock or unlock is
> unsafe, kmalloc_nolock() always fails.
>
> Changes since RFC v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Reduced complexity and intrusiveness (Uladzislau Rezki)
> -------------------------------------------------------
>
> While discussing concerns about the complexity of adding allow_spin
> handling with Ulad (Thanks!), I realized that adding complexity to the
> kvfree_rcu batching is not strictly necessary: only slab objects need to
> be batched, they are already batched by rcu sheaves, and slab already
> supports unknown context. So it is enough to implement only a minimal
> fallback for the sheaves path.
>
> I tried to avoid making intrusive changes to the existing kvfree_rcu
> path as much as possible. struct rcu_ptr is renamed to kfree_rcu_head
> following Vlastimil's suggestion, and it is used only in the
> kfree_rcu_nolock() path for now.
>
> As a result, the complexity is significantly reduced and the series
> became much less intrusive. This is also reflected well in the diffstat
> below.

Overall looks good to me.
btw sashiko was confused in few cases.
Not everything that it flags needs a fix. Sometimes it's not an issue at al=
l.
It only sounds like one.

