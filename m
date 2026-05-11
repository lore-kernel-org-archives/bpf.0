Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B01E3DCD
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778464193; cv=none; b=f/vDiIkXdSZmn6Jl2nrreVhj8zu9QiB9LBHuGFQ/ZfsYoOsxZg/s5Bqz7xXhtkIsLPHZT6x8VZe/tAdyXMHjx2AprKQxdIgkpjHqN45/JQD4GC5RISHCJ6JrwB+kbcOgVucmiVXA4vI+0QB3xieyhyd4N0+ib+nGOB9rEpo1U+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778464193; c=relaxed/simple;
	bh=Jx4XS5wyKbq7T5KE5vQJ0AGGGHfHjRthrIB01SfH0F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSaiONyKaOvYPtGOEsfbiCoWseVnLUZ4XPDTlSKaq9jYjKOOOEi6d8EUT98MdEyXLBk7oR+zOo677zODZK+3m9bYYXqaDnYamrEa+IbJLaA2PZfPHmOXlBlZlhgQ6J3FAZn5apAOHh0Qmy0R2Am0oKmR18YC8V4CHeqVTPQdte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P00l7H8r; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P00l7H8r"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bb0d18c7f9so34083717b3.0
        for <bpf@vger.kernel.org>; Sun, 10 May 2026 18:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778464191; x=1779068991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhB9fCxPYHAt/1E8KLkKkXcaVh6sGzX9RYj9Tds5So4=;
        b=P00l7H8rxqqPuY1YRPy9pUBy8em1zf/3T3W+nTLBtQp7RweTiwLuy7WCW2OEaeMj0M
         7MKpY49mRN417lWB7ZStYcVzfqh6VTCmtMHSBkHzTnZDX1Pq8MWSbdcJ1hyCPYzPuQkg
         2pOwxZ634dMdVqSFqyGYCWvWLlmlMi+DMqsNYsIkADRTK+g29GImJlAXHV7mEKIr9TL+
         Oa3zb/pqacjLg5+9A2of9r6lCXNxOoeQDE1xLeU1UGYdNww8pmGOR7UQ9JGEvaZQjM7N
         hldkNMvNwLvzaYL2tz8rkdHByp+nOx78tqvH69TGrCFk+XzpiqdV6VlaHgSUXmpxWw/r
         dR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778464191; x=1779068991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhB9fCxPYHAt/1E8KLkKkXcaVh6sGzX9RYj9Tds5So4=;
        b=ate8DFWmy+pOg2z/S9ufMg2J0SNEID25K20TuBxBHw6AhpTuhuAVjaJPgOGDpaOnhS
         nerTO4ZQJ9CWZJIVotKfaNnxSOPUfGQdZYbr8Uedq/8D3rLI6LMkClyXl3DOcskHHOxo
         DVkCQQ2XieklcE7j7JA2yTuRXtONIchF1kKVsleOCywx3n0zpSsKrUyzzWYgeXjyaeH4
         xITMh6wFBMid132YB4yuasU6B5LuTLGZte5/VzsRjeFMfNZQ4NJ8O4QAvMqVYTmD4Pse
         cH/0a6Gjq/wLnvisEG5SUSKyoFIX7Xrw8nd6+fC3YPvarAF9huuIE0Dxo2fY+P5OQX4W
         vAXA==
X-Forwarded-Encrypted: i=1; AFNElJ8xvQv7r0Vi1d5fJI5Jg+pprgGaMGpHq7q8f0n5kyNDmeEFghNEG3rBcsD5EEB1DgsESVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5PvfS6bp9dG5yNMgChUNjKIiKR5wjjorC7o95iH//SHUngpB
	Kze5kOUFMVEbEjjlb0GBvdL0K9SSskcEsr4veczahWAL58E2pkxy2ik/agzwiyMr
X-Gm-Gg: Acq92OGE5YpMah+NUDS82v4RqAqr+jrfUsETbusKY2i2pKutVxYzW2STRZv5KB6PWX0
	nceav+lToKa7Dfwn8ho2KrJL/ywBccI8Kw8omGClVdBqlt64ANEaBUHLKgf6Wqa3PTeHKYOaxKS
	Bx8dol0/+Hoo0WOFer0C6BDpey8WBHLBG+ovJx4KURTwT4c/NmoFQ8Yt09Mnth4qoXINVYuFFj6
	QGNaYvuzHYNlyL3iIqXN2YAJ2FmZgbAEEex8CtOWMDUlpJG9cRVhKVqfhnk1/kjlsT90IsAhgd8
	OLgTZpoqxrUgBL5pp2XfCnOYoL2eopaOFuwkwsNLM2GWGtlwu7F/5a+se/6FE5oZ+YiLFWnOBrk
	FoNYCD7+B27ZrsuIOah5xuS1L65IAg5PlPnwtCkVahYrPfFABQAsAeCJxnv3LCleCA6Xq6pV2dN
	Ni8iJqk1uyfRqeb/7GNP2XbTGQsTNzqxHlPU8LdE+jPbh5V5j6vll2YPMR1dZYBFYrjSfi
X-Received: by 2002:a05:690c:c0d8:b0:79a:3655:9df5 with SMTP id 00721157ae682-7bdf5dc6e2cmr224710627b3.12.1778464191088;
        Sun, 10 May 2026 18:49:51 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4060:ee75:92ff:98db])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm140128157b3.23.2026.05.10.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 18:49:50 -0700 (PDT)
Date: Sun, 10 May 2026 21:49:49 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <agEnc0aYMhuIeDlq@zenbox>
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org>
 <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>

On Sun, May 10, 2026 at 03:38:08PM -0700, Alexei Starovoitov wrote:
> On Sun, May 10, 2026 at 8:14 AM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> >
> > Any help or guidance on this would be appreciated!
> 
> sorry for the delay. Everyone was at lsfmmbpf for a week+.
> 

No worries! I hope it was an enjoyable trip and I look forward to
hearing about the conference.

> All of the solutions so far are way too complicated.
> bpf_kptr_xchg() has to remain inlined as single atomic xchg
> without slowpath otherwise it ruins the concept
> and makes usage unpredictable.
> 
> Let's step back.
> What is the issue you're trying to solve?
> 
> the commit log say:
> 
> > A BPF program attached to tp_btf/nmi_handler can delete map entries or
> > swap out referenced kptrs from NMI context. Today that runs the kptr
> > destructor inline. Destructors such as bpf_cpumask_release() can take
> > RCU-related locks, so running them from NMI can deadlock the system.
> 
> and looking at selftest from patch 2 you do:
> 
> old = bpf_kptr_xchg(&value->mask, old);
> if (old)
>   bpf_cpumask_release(old);
> 
> so?
> bpf_cpumask_release() is fine to call from any context,
> because bpf_mem_cache_free_rcu() is safe everywhere including NMI.
>

My mistake on that. I picked a bad example for the test, but the test is
just exercising the nmi dtor path, and doesn't rely on the particular
type of kptr. I just picked one that was easy to acquire a reference to.

This dtor is safe. task_struct dtor, cgroup dtor, crypto_ctx dtor are
not. I've annotated why here:

crypto_ctx:

  __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
  {
  	if (refcount_dec_and_test(&ctx->usage))
  		call_rcu(&ctx->rcu, crypto_free_cb); /* UNSAFE: call_rcu */
  }
  
  __bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
  {
  	bpf_crypto_ctx_release(ctx);
  }

task_struct:

  __bpf_kfunc void bpf_task_release(struct task_struct *p)
  {
  	put_task_struct_rcu_user(p);
  }
  
  __bpf_kfunc void bpf_task_release_dtor(void *p)
  {
  	put_task_struct_rcu_user(p);
  }

  void put_task_struct_rcu_user(struct task_struct *task)
  {
  	if (refcount_dec_and_test(&task->rcu_users))
  		call_rcu(&task->rcu, delayed_put_task_struct); /* UNSAFE: call_rcu
      */
  }

cgroup_release_dtor is more complex, goes through ultimately through
callbacks to:

  static void css_release(struct percpu_ref *ref)
  {
  	struct cgroup_subsys_state *css =
  		container_of(ref, struct cgroup_subsys_state, refcnt);
  
  	INIT_WORK(&css->destroy_work, css_release_work_fn);
  	queue_work(cgroup_release_wq, &css->destroy_work); /* UNSAFE:
    workqueue */
  }

More generally, unless it's a BPF allocated object or doesn't rely on
locking/call_rcu or workqueues, the dtor is unsafe.

> hashtab introduced dtor in bpf_mem_alloc,
> so bpf_obj_free_fields() and corresponding dtor's of kptr-s
> are called from valid context.
> 
> What is the problematic sequence?

So from the beginning stepping back.

The problematic sequence:

1. ref kptr (i.e task_struct, cgroup, crypto_ctx) xchg'd into map. 

2. in a tp_btf/nmi_handler (NMI CTX) program we drop the item from the map
   with that referenced kptr field.

3. dtor runs in the nmi context

4. dtor runs call_rcu/queue_work/some bad thing in nmi, causing deadlock.

You can see this demonstrated in my task_struct reproducer [1].
It causes a deadlock by deliberately releasing the last reference to a
task_struct via a ref kptr in nmi, getting it to call_rcu and deadlock.

The typical solution to this is to run the nmi unsafe code in non-nmi
context by offloading to NMI work, as you proposed.

The problem is we need space to for the jobs we enqueue. The required
information to run the dtor is the dtor function and the original object
pointer. The number of dtors that can run in a single tp_btf/nmi_handler
prog is nearly unbounded.

The other problem is even though bpf_mem_alloc is safe in NMI generally,
we cannot allocate in path that destroys an object. If the allocation
fails due to memory pressure, we leak the object.

There are a few options, all with drawbacks.

1. Dynamically allocate the job. Non-starter, failing to allocate is
unrecoverable, memory pressure means we can't ever schedule the dtor to
run.

2. Store job ntrusively in the object : Requires a safe place to place
it within the object. Bad because not all objects have a space we can write to.
Non-starter.

3. Within the map slot (after actual kptr): Taken with my initial approach in v1.
Significant complexity and requires per-map changes. Feasible but very
complex and would need DCAS or locking to make updating the map slot and
our job information atomic.

4. Wrapping the kptr in a box and storing it in place of the kptr [2] :
Proposed by Mykyta. Would break direct load access to kptr objects.

5. Make every dtor nmi safe individually. This would require a lot of
duplicated code and require updating every destructor invididually.
Feasible technically, but seems brittle.

6. One that would be the least complex, would be forbidding xchg operations
that can run the dtor in NMI context. That would preserve the inlining fix,
but limit our usage of referenced kptrs in BPF programs that run in NMI context.

The approach here:

7. Allocate a new spot for a free job every time we xchg into the map
and put it in a global list. When in NMI and we run a dtor, we pop a
job from that slot and use it to offload our work via irq_work. If
we're not in NMI we run normally. Downside is this breaks inlining for
ref kptrs.

...

I may be missing something critical, but everything I've looked at
points to this problem being much more complex that it initially seemed.

I'm happy to discuss further and do a respin.

Justin

[1] https://lore.kernel.org/bpf/383afba6-f732-49bc-a197-147b9d8b1a29@gmail.com/
[2] https://lore.kernel.org/bpf/51a054a0-e57f-49dc-9527-36da0535087c@gmail.com/
