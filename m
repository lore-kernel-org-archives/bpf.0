Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503252;
	b=veQw2D9oYh9fDzINjCrC/kq/J/FQIi7s3xV+HtqLF5jGZ5w8xumGqyJWFNtapVHJ9wRR
	 NYYY59/hihj//ysY6AfS6cxlmUrzYbq/gOaHK+9cKp2O32Blw8ib3M+IrQnITgfnGU+XT
	 YsqFtIrJDStU/xSbPKodLF6HlIn9JFcY6nKp8l/NcefUw21T3jhBI57uvfdwV3KdHBYCc
	 pOtCq+x1vGS2A958HdSyM+bE7RAT4i3tvM5Et6x39VfASPfqzKMud/omLv64AHn2P3G3H
	 XnYwNqXKGQMswu02awX/oKSk/oJFftpIChKDDJpCnJhH5BznTnQngM71z+rbmibMhCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503252;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FbZweDIxhmL7siggWffrhdl3D49Th5aeEe2VbeYB8MQ=;
	b=M+XosJOejjdpWsxNGVCnhNvsERiRSKK0MwKofL6/QLGMGMeGX+ymx0BzwnHIMW9tdwCu
	 XK9knzjvz7hoGueBUULsUEus38n8xsrEW9XbvWDpYi93qd0ksdeCfVDdlhhB56jUd6bAH
	 2h0+J7dnMW1BznAylS3oSvHgwsk4EeQd8xbGRNNmIfWiq8p/Pg2dwNAOJCBo+yJlA9zBC
	 Z8yGhtjaXxg5OCHN5rnxH/IyvCPHWdH90BkqMTynDBZP6XaiDXRjL4ndJAX5xAIF3biu9
	 bNtIHOlXNM/xuTgPfsOSelvvjTUr0TbDXfgxkz7X+g1XAJevhyqzO8ZcPLWEepYYl9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AsHsd6iv;
	arc=none smtp.remote-ip=91.218.175.131
Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058FA606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 058FA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AsHsd6iv
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DY5Hprcbq1eAPJOCDEu5rT8kzGVBeBju20d+Mp3qU9Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793503250; v=1; x=1794108050;
 b=AsHsd6iv+QMCCWQMCEf+Jdxm7nXGSTHuufXbC+H9Va2YBuno7SRw/fjOnQnmLdqZwY8vHfgz
 3y+FEoSWmigW7CguhUpgy7DNRQUSOnQN0PKmPPF1N9JAdBjMFMOHHVB0prULwZrdVH3L/NTU66r
 v92lrCSOdpPT0Igh5kIZN/P8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 307f81ddaafada5e;
	Sun, 01 Nov 2026 03:20:50 +0000
X-Mizu-Trace-ID: 307f81ddaafada5e
X-Migadu-Flow: FLOW_OUT
Date: Sun, 1 Nov 2026 11:20:41 +0800
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
Subject: Re: [PATCH v5 1/6] mm/memcontrol: drop unused vmscan tracepoint
 include
Message-ID: <auawCfHE-jUUZunl@bogon>
References: <20261031090041.58574-1-ridong.chen@linux.dev>
 <20261031090041.58574-2-ridong.chen@linux.dev>
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
In-Reply-To: <20261031090041.58574-2-ridong.chen@linux.dev>

On 10/31/26 at 05:00pm, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> memcontrol.c includes <trace/events/vmscan.h> but does not use any of
> the tracepoints or macros it defines: all tracepoints invoked here come
> from memcg.h and writeback.h.
> 
> Drop it ahead of moving the vmscan trace header under mm/, after which
> <trace/events/vmscan.h> will no longer exist.
> 
> No functional change.
> 
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  mm/memcontrol.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 84f4a8fd4d16..8a35f5b635e0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -77,8 +77,6 @@
>  #include <trace/events/memcg.h>
>  #undef CREATE_TRACE_POINTS
>  
> -#include <trace/events/vmscan.h>
> -
>  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
>  EXPORT_SYMBOL(memory_cgrp_subsys);
>  
> -- 
> 2.43.0
> 
