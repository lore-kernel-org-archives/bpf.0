Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B238F253
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436443; cv=none; b=WBNZbZgv9Pe4drKWx2SELH5Qq8ujJYqZJZ3cyKekPJ7BvvBmY+8GTboPKRms4DD+hZnRP1Optspcboqihx09Vcr+XuGTs1AC7/HtNjHcmDod1EgOqz683KQmcEPJO6ObxR+lTLGDkY97YU5jBtLajWVdhCht7gr1oeys/slGgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436443; c=relaxed/simple;
	bh=05uRaWUcaOG/Q/CWJc/l3BnefdP/MWiBuuzMMUHj9ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzmKWiOQ3PUSAVJeac9njGps6XlKj+qI9m7wR60yPnIUpl3bgq/6nTkLvj+YGexxRkUtnZJhn9WHW/jWSu0NHnqxlmkxwQwwU7ZMUrDul74M0vCKy064hHnNaSBLMvfSWFQsAp/bRH9PRe4vlgI5UyVE6Z6O8OKZGLexX8mF+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xG6JBmrM; arc=none smtp.client-ip=91.218.175.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xG6JBmrM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=05uRaWUcaOG/Q/CWJc/l3BnefdP/MWiBuuzMMUHj9ko=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789436438; v=1; x=1790041238;
 b=xG6JBmrMklm9hb4prYYVKhT91g9W8p/yh24RxHsUyes/Efqo68xd1mIPhyqat/8RSxqSv/gB
 RBzYZxWBJ8naglS9uPzcsXgY9qTEsqov1G6p0D1Yw2BecHxXJR8FtaGkDtyXLoXF/WgkbYgMtNO
 YSq0O1Hd8W6GLCpIN8A10vCg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 98afbac615a21c5e;
	Tue, 15 Sep 2026 01:40:38 +0000
X-Mizu-Trace-ID: 98afbac615a21c5e
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 18:40:34 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Hui Zhu <hui.zhu@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v10 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Message-ID: <aqihfvKMqJAudSQK@linux.dev>
References: <cover.1789091855.git.zhuhui@kylinos.cn>
 <e00910f328c129fea716e9fd031dada328e60313.1789091855.git.zhuhui@kylinos.cn>
 <DLF8UFBL6NEL.MAD9F5418DIG@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLF8UFBL6NEL.MAD9F5418DIG@gmail.com>

On Mon, Sep 14, 2026 at 08:17:09PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri Sep 11, 2026 at 4:20 AM CEST, Hui Zhu wrote:
> > From: Hui Zhu <zhuhui@kylinos.cn>
> >
> > BPF programs can observe memory pressure on a cgroup (e.g. refault
> > stats via bpf_mem_cgroup_page_state()), but cannot act on it:
> > triggering reclaim on a chosen cgroup requires writing to
> > memory.reclaim, which BPF cannot do. Add bpf_proactive_reclaim(),
> > a sleepable kfunc which performs one proactive reclaim pass on a
> > given memory cgroup, similar to a write to memory.reclaim but
> > without retrying until the target is reached, so that when and how
> > hard to reclaim is BPF policy rather than hard-coded thresholds.
> >
> > Since some bpf program types may be invoked while holding fs locks,
> > limit the kfunc to BPF_PROG_TYPE_SYSCALL only, to avoid deadlocking
> > in filesystem shrinkers on the reclaim path. A SYSCALL program can
> > invoke the kfunc directly, or asynchronously from its bpf_wq or
> > task_work callbacks, which run in process context and keep the
> > SYSCALL program type.
> >
> > The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> > following the precedent of high_work_func(), the memory.high
> > workqueue fallback. Note that only the reclaim target is capped: the
> > actual scanning work and its duration are not bounded. Reclaiming more
> > than one batch is left to the BPF program rather than enforced by the
> > kfunc: with one call per bpf_wq callback and the same work item
> > requeued for the next batch, the program can also stop submitting
> > batches in between, e.g. once the target cgroup is dying.
> >
> > Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> > ---
> >  mm/bpf_memcontrol.c | 88 ++++++++++++++++++++++++++++++++++++++++++++-
> >  mm/internal.h       | 10 +++---
> >  2 files changed, 93 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> > index 716df49d7647..d8827bc388ef 100644
> > --- a/mm/bpf_memcontrol.c
> > +++ b/mm/bpf_memcontrol.c
> > @@ -8,6 +8,8 @@
> >  #include <linux/memcontrol.h>
> >  #include <linux/bpf.h>
> >
> > +#include "internal.h"
> > +
> >  __bpf_kfunc_start_defs();
> >
> >  /**
> > @@ -159,6 +161,74 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> >  	mem_cgroup_flush_stats(memcg);
> >  }
> >
> > +/**
> > + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> > + *                         cgroup
> > + * @memcg: the target memory cgroup to reclaim from
> > + * @size:  the amount of memory to reclaim, in bytes, clamped to
> > + *         MEMCG_CHARGE_BATCH (64 pages)
> > + * @swappiness: the reclaim swappiness, in the range
> > + *         [MIN_SWAPPINESS, SWAPPINESS_ANON_ONLY], where
> > + *         SWAPPINESS_ANON_ONLY means anon-only reclaim, or -1 to use
> > + *         the memcg's own swappiness
> > + *
> > + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> > + * memory.reclaim, but without retrying until @size is reached.
> > + *
> > + * Only the reclaim target is capped: @size is clamped to
> > + * MEMCG_CHARGE_BATCH, following the precedent of high_work_func(),
> > + * the memory.high workqueue fallback, which bounds each reclaim
> > + * request the same way. The actual scanning work and its duration
> > + * are not bounded. To reclaim more, call this kfunc repeatedly
> > + * instead of passing a larger @size.
> > + *
> > + * The kfunc can be called directly from a BPF_PROG_TYPE_SYSCALL
> > + * program, synchronously in the context of the thread running the
> > + * program, or from the bpf_wq and task_work callbacks of a SYSCALL
> > + * program, which run in process context and keep the SYSCALL program
> > + * type. It is registered for BPF_PROG_TYPE_SYSCALL only, because
> > + * generic sleepable programs may run with filesystem locks held or
> > + * in NOFS/NOIO contexts, where the reclaim path could deadlock on
> > + * those locks via filesystem shrinkers.
> > + *
> > + * For asynchronous reclaim of more than one batch, driving the
> > + * reclaim from a bpf_wq callback is recommended: call this kfunc
> > + * once per callback and requeue the same work item for the next
> > + * batch, instead of looping inside the callback and monopolizing a
> > + * workqueue worker, and give each target memcg its own work item,
> > + * as high_work_func() does with one work item per memcg. Whether
> > + * to submit the next batch is up to the BPF program, which can stop
> > + * at any point, e.g. once the target cgroup is dying.
> > + *
> > + * Return: The amount of memory reclaimed, in bytes, or 0 if @size is
> > + * smaller than a page, or (unsigned long)-1 if @swappiness is out of
> > + * range.
> > + */
> > +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> > +						unsigned long size,
> > +						int swappiness)
> 
> I'm going to have to request one final change, sorry.
> 
> I think long is more meaningful as return value than unsigned long. It's already
> restricted to MEMCG_CHARGE_BATCH. We return error for various arguments, we
> should probably change to -EINVAL.
> 
> Apart from that it looks ok to me, but please, also wait for Shakeel to review
> the set before you respin v11.

My only feedback is: please don't write essays in the comments. Just couple of
sentences should be sufficient. (Please ask your AI to be very very concise for
the comments and commit messages.)

Other than that please follow Kumar's suggestion and send the next version.
