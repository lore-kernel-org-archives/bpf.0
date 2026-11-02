Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583432;
	b=xh3lcAjITGXpXaVLgwYfj008puBY9pCXQeuzxna39osYsjEJYoM2yUsZJJAbR5gAHAzW
	 BBMk2Uzd2NbXSMu1V/qQVvgw4+TWRpk/THaHczbp6+Rq00JhcLbqd8UhFcsk+5ymUmlcW
	 FvGq54m0FFn8Sh5tM5q9Vwcy/tXIyGp8ySId6l1VA8tRiW4Z7qwEG1gL5O5Un3gEROWmM
	 VISAyWyc6YzRcq7a6W1V5NJDxv3JO5H3sHZHcAF3GBzkhCxN3HOMmkYqChR4ZIaOn3ZTu
	 51INws0txBnH6E6PH6R1z15U+NMcaLnoBpXIE7iBQN70urmvOiQJbR7mqkLeudNyTfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583432;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=60rYsd/AjRckt1lyvYj4vtHp2+NMHTUyTXpQRwJ1gH8=;
	b=LeJ+ObmSP8x6v/O0k4TJ1oh7iwIRTk5biDBAxk7nXqC7URcW0JTZcQWaJaOd4lDxQmtq
	 tiVo3UFBKDxlW/eJsMqIfgpWWpsPszOkT/CHiNuq018XW2wx67aD5qxeDaMlta6sXYjPl
	 dRGpGwGpeQ1IM6m8WNyONXyUO8qSQB1MBivuq6zKmWFAW8ouXeTUGCE1CYS5qEWUUem10
	 Qta4fGi9e+x+aE1v3buF8VAfpq1vnLTnDWYqa875XAnK8TIoWZ/jRFoXy+fMv6Lfb3F0I
	 sDpsq1bV+r72gYlsSZFcJz27IXBXHuTS7Ev4K/0/DWsYcBKxmydvHMTuZLwkalNG1OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EIUPFzWs;
	arc=none smtp.remote-ip=95.215.58.203
Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C7606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6C7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EIUPFzWs
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mF5HCW1rYzYU+/byn7lpiTMdUmKESV7ryiW//mc/fP0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793583429; v=1; x=1794188229;
 b=EIUPFzWsp6gKLfS2+RhRYiXCqrdqUabhe/sOw3lewqSPsFfLEKGo9dyTZGA7Fc4FdWkDngVW
 uOkrdFdJBaFlmqIFKOqBFznjvBuCiH2Cw7P/jUJ9wqaqdfkQFktp6gO2FhQKyvT23ovTOEAd0zB
 cctPkGPMsGXw39Hy7JgaCc8I=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7b95e43db45818e8;
	Mon, 02 Nov 2026 01:37:09 +0000
X-Mizu-Trace-ID: 7b95e43db45818e8
X-Migadu-Flow: FLOW_OUT
Date: Mon, 2 Nov 2026 09:37:05 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH v5 2/6] mm/vmscan: move vmscan tracepoints to a local
 header
Message-ID: <aufpQS0XL-CD9YW_@bogon>
References: <20261031090041.58574-1-ridong.chen@linux.dev>
 <20261031090041.58574-3-ridong.chen@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031090041.58574-3-ridong.chen@linux.dev>

On 10/31/26 at 05:00pm, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> Move include/trace/events/vmscan.h to mm/trace_vmscan.h so that the
> tracepoints can be extended to reference vmscan-internal structures such
> as struct scan_control, which is not visible outside mm/.  This mirrors
> what several other subsystems already do with their trace headers (e.g.
> fs/fuse/fuse_trace.h, fs/gfs2/trace_gfs2.h, fs/lockd/trace.h).  As they
> do, set TRACE_INCLUDE_PATH to "." and add mm/ to the include path of
> vmscan.o, the only user that defines CREATE_TRACE_POINTS.
> 
> No functional change.
> 
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  MAINTAINERS                                        | 2 ++
>  mm/Makefile                                        | 1 +
>  mm/shrinker.c                                      | 2 +-
>  include/trace/events/vmscan.h => mm/trace_vmscan.h | 4 ++++
>  mm/vmscan.c                                        | 2 +-
>  5 files changed, 9 insertions(+), 2 deletions(-)
>  rename include/trace/events/vmscan.h => mm/trace_vmscan.h (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aaf2825ac945..2ad01107fa05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17653,6 +17653,7 @@ F:	Documentation/admin-guide/mm/multigen_lru.rst
>  F:	Documentation/mm/multigen_lru.rst
>  F:	include/linux/mm_inline.h
>  F:	include/linux/mmzone.h
> +F:	mm/trace_vmscan.h
>  F:	mm/vmscan.c
>  F:	mm/workingset.c
>  
> @@ -17802,6 +17803,7 @@ R:	Shakeel Butt <shakeel.butt@linux.dev>
>  R:	Lorenzo Stoakes <ljs@kernel.org>
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +F:	mm/trace_vmscan.h
>  F:	mm/vmscan.c
>  F:	mm/workingset.c
>  
> diff --git a/mm/Makefile b/mm/Makefile
> index 2a3ec53d62ee..277b97f7f8d7 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -32,6 +32,7 @@ KCOV_INSTRUMENT_vmstat.o := n
>  KCOV_INSTRUMENT_failslab.o := n
>  
>  CFLAGS_init-mm.o += -Wno-override-init
> +CFLAGS_vmscan.o += -I$(src)

One nit:

Does it really need the above line? It affects mm/shrinker.c too, did your
shrinker.o building fail?

Seems it's redundant because kbuild adds -I$(src) -I$(obj) for every object
in the directory since commit cdd750bfb1f7 ("kbuild: remove 'addtree' and
'flags' magic for header search paths"). Please correct me if I am
wrong.

Other than the nit, this patch looks good to me,

Reviewed-by: Baoquan He <baoquan.he@linux.dev>

Thanks.
>  
>  mmu-y			:= nommu.o
>  mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 4fb424e721bc..4fbdade6d2f6 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -3,7 +3,7 @@
>  #include <linux/rwsem.h>
>  #include <linux/shrinker.h>
>  #include <linux/rculist.h>
> -#include <trace/events/vmscan.h>
> +#include "trace_vmscan.h"
>  
>  #include "internal.h"
>  
> diff --git a/include/trace/events/vmscan.h b/mm/trace_vmscan.h
> similarity index 99%
> rename from include/trace/events/vmscan.h
> rename to mm/trace_vmscan.h
> index 8a872990b4be..ad90f0e9bf2e 100644
> --- a/include/trace/events/vmscan.h
> +++ b/mm/trace_vmscan.h
> @@ -648,4 +648,8 @@ TRACE_EVENT(mm_vmscan_kswapd_clear_hopeless,
>  #endif /* _TRACE_VMSCAN_H */
>  
>  /* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE trace_vmscan
>  #include <trace/define_trace.h>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9959ca158ce8..79d2d614afd0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -71,7 +71,7 @@
>  #include "swap.h"
>  
>  #define CREATE_TRACE_POINTS
> -#include <trace/events/vmscan.h>
> +#include "trace_vmscan.h"
>  
>  struct scan_control {
>  	/* How many pages shrink_list() should reclaim */
> -- 
> 2.43.0
> 
