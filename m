Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C522F12C5
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787022934; cv=none; b=FMjFRJIV5dvgz/7a60nnOWLYT0vXbKS7fxddzi20/vUxYrBZEaaZ7JxVILEt2oKgLn0biPBVaEGbgBeQt0xt3kCP+IVXDdgxjiEpmyHLaSRqk0tXvnfuVnW6vXhKVEpNbNGZswTfDDSUNAOLgS/cD3cAb1VcTr8E2y5FidZj5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787022934; c=relaxed/simple;
	bh=QPjkqeMQzOAZpb/zyY52x+vxw+KmNvb6bRJRhWPK3mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IypcxxynIoojInRs3JpO9D2TLw4LLE3YiH/dRpzGA/vscpk8gznNDngiaE84jUqdjrpjjaQzuLZfU2p/jX9qXs+JuEpHL22YgouOVm8sUkuSGF5P46uZaBl0sMk1kyolpZw3c4iXDhczOTx/gNGfZNZT1xyAfnhS7DCVQ84K628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fWoEI2Ao; arc=none smtp.client-ip=95.215.58.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fWoEI2Ao"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QPjkqeMQzOAZpb/zyY52x+vxw+KmNvb6bRJRhWPK3mw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787022923; v=1; x=1787627723;
 b=fWoEI2AoSNK4ISQ1bMiEYIXBx5uvD5XXW9ySANPlXaBYKAxH7qk0XdW0mBooYSkDLJ+fIIfs
 TlPY2+0FvliuUTHqVRldHeucnVQdr9HWvl3Dc5yU0VnrKGXJ2GhFYRh8XLK6hkn7lHiia6ZjdHA
 JD0asjkYetuble1r1tROkbJc=
X-Envelope-To: bpf@vger.kernel.org
Received: from fedora (117.129.78.49)
	by smtp.migadu.com with ESMTPS id 68147398b43ced4c;
	Tue, 18 Aug 2026 03:15:22 +0000
X-Migadu-Flow: FLOW_OUT
Date: Tue, 18 Aug 2026 11:15:12 +0800
From: Hao Li <hao.li@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	kasan-dev@googlegroups.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 1/5] mm/slab: cleanup deferred free handling
Message-ID: <aoPN2evd_u09IxfR@fedora>
References: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
 <20260807-kfree_nolock_kmalloc-v1-1-ba993cbf7a60@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-kfree_nolock_kmalloc-v1-1-ba993cbf7a60@kernel.org>

On Fri, Aug 07, 2026 at 03:50:27PM +0200, Vlastimil Babka (SUSE) wrote:
> In deferred_percpu_work_fn() we have a bunch of single-use local
> variables for the various llists. Remove them and access the lists
> directly.
> 
> In defer_free() make it more obvious and documented what we are doing.
> Also restrict guard(preempt) to only the necessary part.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slub.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)

Looks much cleaner now.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
