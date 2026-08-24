Received: from mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB033839A1
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602552; cv=none; b=GwZ8Ksrbk+zPqhsQaL1iQqFVLcbfLcNQrVfAZb4fPsZ3TIkweGs8cFQo+r//dkT6zQhHBUxRQItnaTk0HjB5tunr74CBXbnDpMWXdt0swBh6uanzsiy+DXPSrOu2BYmGKLWxaS/B4hY9YlAgQcGFMkV0rhs91FWTIYNAbQgKYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602552; c=relaxed/simple;
	bh=nLzdm/qCP+HJMriRMsBX2NapVlTGsrYyj+a9BUlHHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS/PH73ye6qctEab+KNOHlWxSLQ2kRp/28/n7T8o7nK06tfkznMXcOICOOSVMvtltO4kch990/bWc3Syu7EdCRzP+zudi52J/7Z0Icd3U9GMT8+3sJgIfS9FXJDBpUbHJu8PHcmnndFl2hEfTIfqnUsQKiGJmoGNkMCJTFy7dM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JkRXcuAV; arc=none smtp.client-ip=95.215.58.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JkRXcuAV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nLzdm/qCP+HJMriRMsBX2NapVlTGsrYyj+a9BUlHHi0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787602547; v=1; x=1788207347;
 b=JkRXcuAV7eH9fS9NjOutkiyCjEus98SYFLEZEHYx3Mh3T2oCfMUKsWBvxZP5J3kTmFwJiDc6
 u2Ey5dOKKyqPluUZX6HwlJSo7obEc4whhAAY2e5FWWRQL4w55FswPR9BCPcGaL21B8vfsd1Utik
 sndRQtWsmFo9pe6rKawzi/0o=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost (2a03:2880:10ff:5::)
	by smtp.migadu.com with ESMTPS id d3cffa5edf59e1e6;
	Mon, 24 Aug 2026 20:15:46 +0000
X-Mizu-Trace-ID: d3cffa5edf59e1e6
X-Migadu-Flow: FLOW_OUT
Date: Mon, 24 Aug 2026 13:15:41 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v4 0/2] bpf: BPF-driven proactive memcg reclaim
Message-ID: <aoyl4IrvfUl8swv_@linux.dev>
References: <cover.1787205002.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787205002.git.zhuhui@kylinos.cn>

On Thu, Aug 20, 2026 at 02:12:25PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> This series lets a BPF program decide when to trigger memcg reclaim
> and how aggressively to do it, based on whatever runtime signal it
> chooses to observe -- rather than reclaim only being triggered once a
> cgroup's usage crosses a fixed threshold. The core idea is a pair of
> new kfuncs, bpf_proactive_reclaim() and
> bpf_proactive_reclaim_swappiness(), which give BPF direct access to
> the proactive reclaim path so this decision can be made in BPF policy
> rather than hard-coded threshold logic.
> 
> This was originally part of a larger series posted here [1].
> That series also adds a memcg BPF struct_ops (memcg_charged,
> memcg_uncharged, below_low, below_min) for synchronous, in-line memory
> protection decisions. That mechanism and this one solve different
> problems -- struct_ops hooks run inline on the charge/reclaim path,
> while the kfuncs here are for asynchronous, out-of-band reclaim
> decided independently by a BPF program -- so they are reviewed as
> separate series. This series carries only the async reclaim piece.
> 
> Compared to v1, the kfunc interface has been reworked based on review
> feedback: instead of a thin wrapper around
> try_to_free_mem_cgroup_pages() exposing raw gfp/reclaim-option knobs,
> the series now provides use-case-driven kfuncs that perform one
> proactive reclaim pass with the same parameters memory.reclaim uses.
> The bpf_thread_wq patches from v1 (old patches 2-3) are dropped from
> this series: following the discussion in [2], the cgroup-aware
> workqueue is being superseded by a disaggregated set of async
> primitives (bpf_kthread/bpf_waitq) that will be developed separately
> (discussion in [3]), and the selftest now queues its reclaim work
> through bpf_wq.
> 
> Patch 1 adds bpf_proactive_reclaim() and
> bpf_proactive_reclaim_swappiness(), sleepable kfuncs that perform one
> reclaim pass on a target memcg, like a write to memory.reclaim: swap
> is allowed, and the anon/file balance follows the cgroup's swappiness
> or an explicit override in [MIN_SWAPPINESS, MAX_SWAPPINESS] plus
> SWAPPINESS_ANON_ONLY. Both go through a shared helper,
> bpf_proactive_reclaim_pages(), which guards against reclaim recursion
> and calls try_to_free_mem_cgroup_pages() with GFP_KERNEL and
> MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE, the same parameters
> user_proactive_reclaim() uses, and unlike memory.reclaim they do not
> retry until the requested size is reached. Both refuse to run when
> the caller already holds PF_MEMALLOC or has a non-NULL
> current->reclaim_state, since a nested try_to_free_mem_cgroup_pages()
> would clobber the outer reclaim's current->reclaim_state (e.g. MGLRU
> dereferences current->reclaim_state->mm_walk); the reclaim_state
> check also closes the window where try_to_free_mem_cgroup_pages() has
> installed it but not yet set PF_MEMALLOC, reachable by a sleepable
> program attaching fentry to the generated trace iterator function.
> The size argument and the return value are both in bytes, matching
> the byte-based unit of bpf_mem_cgroup_usage() and
> bpf_mem_cgroup_page_state() so callers can mix them without manual
> page/byte conversions. An out-of-range swappiness is reported with
> (unsigned long)-1 rather than 0, since 0 cannot be told apart from a
> pass that reclaimed nothing.
> 
> Patch 2 (selftests/bpf: add memcg async reclaim test) ties the kfuncs
> into a worked example: it watches the WORKINGSET_REFAULT_FILE counter
> of a high-priority cgroup as a proxy for memory-pressure impact, and
> once it starts climbing, proactively reclaims memory from a
> low-priority cgroup via bpf_proactive_reclaim(), with the reclaim
> work queued asynchronously through bpf_wq. The test asserts that the
> monitored cgroup's workload finishes faster once async reclaim kicks
> in, and -- as timing alone cannot distinguish a working reclaim from
> a no-op one -- that the BPF program actually made reclaim calls and
> reclaimed bytes, via counters it exports through its .bss. This
> demonstrates the end-to-end use case: BPF observes pressure on the
> cgroup it wants to protect, and reclaims from the cgroup it wants to
> reclaim from, in one self-contained mechanism. Note that, without
> bpf_thread_wq, the CPU cost of the reclaim work is not yet attributed
> to a chosen cgroup; that part waits for the async primitives work
> mentioned above.

All of this is unnecessary text. You don't need to explain the patches here and
then again in their commit messages. Please remove this explanation.

Also don't need to give history. Just explain why you want to add memcg reclaim
kfunc and what use-cases you are looking into. (Ask your AI to be very concise
and precise).

