Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F451E443
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762552; cv=none; b=Qd1qegcradpftYwroHJnhuH3f9I0fuefv5VGgnYXGQDiJ8ZNsgdxi+vqpqN7HBhnc4Zby/u5cY90X6Ybq7LLMkoRgaP4h2lCXgbWyjrvarcPYSNSqqp6eqnTXZqiTkXT+OS5yEk/nl/R+Dt67D98Kr2H5w2e+XmYbUbo1wxvmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762552; c=relaxed/simple;
	bh=iouTRwcP6p6sORyaAyVd4nF2CdJPsrPN00jaStu4b50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sfo9XmWP8fkTU/tMzvLrEdwQuEtEBlesnNzUiev98V2hOFhZoqZf6/RB6XAKorhhfPrJZpGDRbn8vhBxWvugD0SZg2Es99DwhANu6jd7qugTmvoAysPjIQuGaffHTL69952BIoOSxSWNb150xywDVZr6MCe7y8X0SjvirNqKcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EKgnW5eN; arc=none smtp.client-ip=91.218.175.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EKgnW5eN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iouTRwcP6p6sORyaAyVd4nF2CdJPsrPN00jaStu4b50=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789762545; v=1; x=1790367345;
 b=EKgnW5eNwYUSMYi5mLGwEpSgf1iuBPjL2JNsjN9V8Z4AWUyhTuyHTlqbrnI3o2JQb1SpB/ga
 voRD2QcxnU3iRxaoU298g2+1Rla74UTd64Py1s1csV2goaMYeprRBXa/r73SR9I4GwRda318+qT
 KEbVBbKAycznOlIdshhkj4S4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 67fa36d92599c8ae;
	Fri, 18 Sep 2026 20:15:36 +0000
X-Mizu-Trace-ID: 67fa36d92599c8ae
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 13:15:35 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Hui Zhu <hui.zhu@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Barry Song <baohua@kernel.org>, Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v12 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Message-ID: <aq2bo5Q-YUj7lkxn@linux.dev>
References: <cover.1789714023.git.zhuhui@kylinos.cn>
 <02f0a8dc45a840d7801ec17e0c1168f7dacf9b73.1789714023.git.zhuhui@kylinos.cn>
 <b115ece2-33a1-412e-ac25-38f339a13599@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115ece2-33a1-412e-ac25-38f339a13599@gmail.com>

On Fri, Sep 18, 2026 at 12:45:01PM -0700, JP Kobryn wrote:
> On 9/17/26 11:58 PM, Hui Zhu wrote:
> > From: Hui Zhu <zhuhui@kylinos.cn>
> > 
> > BPF programs can observe memory pressure on a cgroup, e.g. refault
> > stats via bpf_mem_cgroup_page_state(), but cannot act on it:
> > triggering reclaim requires writing to memory.reclaim, which BPF
> > cannot do.
> > 
> > Add bpf_proactive_reclaim(), a sleepable kfunc performing one
> > proactive reclaim pass on a memcg, like a write to memory.reclaim
> > but without retrying until the target is reached, so that when and
> > how hard to reclaim is BPF policy rather than hard-coded thresholds.
> > The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> > as high_work_func() does for memory.high; reclaiming more is left to
> > the program, which can call the kfunc once per bpf_wq callback and
> > stop at any point. It is limited to BPF_PROG_TYPE_SYSCALL, because
> > other sleepable programs may run with filesystem locks held, on
> > which the reclaim path could deadlock via filesystem shrinkers.
> > 
> > Convert MIN_SWAPPINESS, MAX_SWAPPINESS and SWAPPINESS_ANON_ONLY from
> > macros to an enum so that they are emitted into BTF and usable from
> > BPF programs via vmlinux.h.
> > 
> > Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >   mm/bpf_memcontrol.c | 62 ++++++++++++++++++++++++++++++++++++++++++++-
> >   mm/internal.h       | 10 +++++---
> >   2 files changed, 67 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> > index 716df49d7647..c5d7f29ade85 100644
> > --- a/mm/bpf_memcontrol.c
> > +++ b/mm/bpf_memcontrol.c
> > @@ -8,6 +8,8 @@
> >   #include <linux/memcontrol.h>
> >   #include <linux/bpf.h>
> > +#include "internal.h"
> > +
> >   __bpf_kfunc_start_defs();
> >   /**
> > @@ -159,6 +161,48 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> >   	mem_cgroup_flush_stats(memcg);
> >   }
> > +/**
> > + * bpf_proactive_reclaim - proactively reclaim memory from a memory cgroup
> > + * @memcg: the target memory cgroup to reclaim from.
> > + * @size: the amount of memory to reclaim, in bytes, clamped to
> > + *        MEMCG_CHARGE_BATCH.
> > + * @swappiness: the reclaim swappiness, in the range [MIN_SWAPPINESS,
> > + *              SWAPPINESS_ANON_ONLY], or -1 to use the memcg's own
> > + *              swappiness.
> 
> The ANON_ONLY enumerator shouldn't be included as part of the range. I
> would change this to [MIN_SWAPPINESS, MAX_SWAPPINESS] and then specify
> that ANON_ONLY is a special mode like -1 is.
> 
> > + *
> > + * Performs one proactive reclaim pass on @memcg, like a write to
> > + * memory.reclaim but without retrying until @size is reached. Call it
> > + * repeatedly to reclaim more than one batch.
> > + *
> > + * Only available to BPF_PROG_TYPE_SYSCALL, because other sleepable programs
> > + * may run with filesystem locks held, which the reclaim path can deadlock
> > + * on via filesystem shrinkers.
> > + *
> > + * Return: The amount of memory reclaimed, in bytes, or a negative error.
> > + */
> > +__bpf_kfunc long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> > +				       unsigned long size,
> > +				       int swappiness)
> > +{
> > +	unsigned long nr_reclaimed;
> > +	unsigned long nr_pages;
> > +
> > +	if (swappiness < -1 || swappiness > SWAPPINESS_ANON_ONLY)
> > +		return -EINVAL;
> 
> Related to the previous comment, you treat the special values as part of
> the range. It works currently, but creates a layout dependency on the
> enum. I think it would be more future-proof if you did:
> 
> if (swappiness != -1 && swappiness != SWAPPINESS_ANON_ONLY) {
> 	if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
> 		return -EINVAL;
> }
> 
> The previous comments I brought up are now resolved, so assuming you'll
> make the changes above you can include:
> 
> Reviewed-by: JP Kobryn <jp.kobryn@linux.dev>

Hui, please make these changes and just send this patch in next version.
