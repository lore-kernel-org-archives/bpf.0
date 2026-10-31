Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441579;
	b=d1nJyh/M5eBXow4ptuOlxMhbaCF0cR7A1smcItO+z4qXx9jq5i78eEIiQgQdWX+z+pAi
	 yGTQOJAAfbQsUnl0CNXKB5Q2YbXB1T7+9ykAQguSfns6d2kr6ap7p17BgQfFqWVvy+Fal
	 cB8q4Gn7wv2ZLLFBG0PggUWI229KsknCo6SmgxaoGbKRxAl1cHukpicr8IPX6Ye6CGuhJ
	 E2CFXLPv9DzbFCzJSt6Reoyv45d3ltm7D1sFa7IUV4dx6NrJV1lG7jeNd0n4KBrQYkZA/
	 z8nEX2Mm4laxlPSkLAjDi0bMlIUNw/oTxQaLy2UWK89Cm6aWaacDfhKj99LetuxxwcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441579;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=dDCOuaNWdFHWDg4eo0if1LTvwbtTxO+pnWs7/GHeHF8=;
	b=f5ybpk6S+mLt3lKiXSRTjQNotJMGhmhpQ4L+dwEaUG/mtm5m6MZryygkXlCk+hs2ElMY
	 1/sq4xk3/BI0juqDyGDuO+9OuwUQCW2MmcsQ5e9jUgTdzibeLfJnbpYXqskJk1KuaFpYe
	 yZ3SvkHfxMmWItuLtWmbuByXh1xj0b2rRFxgwMyKVjXC/WOfrrVp5jgPd5HjeTh5iOAyB
	 2fLM7Z71Yj5oBNmunBA7xZAvdL+10Z9TUqa/NEjvy/IUx4YC5SGiEb/BE+hnCNsMdHJ9H
	 ckrIcC8qzKK62OyGOaiPlWca9pKI28BYbJatHwa9iIIt4BmH9BHas9ffSQ1n1XW8Xxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oLB06oPt;
	arc=none smtp.remote-ip=91.218.175.81
Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D542606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 10:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D542606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oLB06oPt
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lZTmGrotgsDGI65tFXKRdBILlZ1ISbBZpIj7+K9DZDI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793441574; v=1; x=1794046374;
 b=oLB06oPtTuGAdIRr8hXKWIyuAE/VFfRZ2aSmX+nn2L9fhl77u8r1uFIBARMhGEesrc4oTcLk
 Ny18QOASskvHzGJGUQU9J9Xr62mA/lMG67loRk4XIPBfwTHygeyAP57pQtg+X9uScl77eSjNhc9
 ynBvjhd1WXGHSz4P5Yf3JqXA=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 3800c739b860db0f;
	Sat, 31 Oct 2026 10:12:54 +0000
X-Mizu-Trace-ID: 3800c739b860db0f
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v5 4/6] mm/vmscan: pass scan_control to the vmscan
 tracepoints
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261031090041.58574-5-ridong.chen@linux.dev>
Date: Sat, 31 Oct 2026 18:12:27 +0800
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Dave Chinner <david@fromorbit.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
 bpf@vger.kernel.org,
 Ridong Chen <chenridong@xiaomi.com>,
 "open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org (ope>)
Content-Transfer-Encoding: 7bit
Message-Id: <DBDE2024-5586-4938-A8A5-B6247E2B2BF2@linux.dev>
References: <20261031090041.58574-1-ridong.chen@linux.dev>
 <20261031090041.58574-5-ridong.chen@linux.dev>
To: Ridong Chen <ridong.chen@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 31, 2026, at 17:00, Ridong Chen <ridong.chen@linux.dev> wrote:
> 
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> Several vmscan tracepoints spell out reclaim state as individual
> arguments, all of which the caller already holds in struct scan_control.
> Now that the struct is visible from the trace header, pass sc directly
> and pick the fields out in TP_fast_assign instead of spelling them out
> at every callsite:
> 
> - mm_vmscan_direct_reclaim_begin, mm_vmscan_memcg_reclaim_begin and
>  mm_vmscan_node_reclaim_begin: gfp_mask and order.
> 
> - mm_vmscan_lru_isolate, mm_vmscan_lru_shrink_inactive and
>  mm_vmscan_lru_shrink_active: reclaim_idx, order and priority.
> 
> - mm_vmscan_reclaim_pages: nr_scanned. nr_reclaimed stays a separate
>  argument: it is the return value of shrink_folio_list(), which does
>  not update sc->nr_reclaimed.
> 
> - mm_vmscan_balance_pgdat_end: order and nr_reclaimed. highest_zoneidx
>  stays a separate argument: it is a balance_pgdat() parameter, and
>  sc.reclaim_idx may differ from it by the time the end event fires.
> 
> No functional change. The tracefs event format (TP_STRUCT__entry and
> TP_printk) is unchanged, so tracefs-based consumers are unaffected.
> BPF programs attached via raw_tp/tp_btf see the new TP_PROTO and need
> to be adjusted; tracepoints are not a stable ABI (see
> Documentation/bpf/bpf_design_QA.rst).
> 
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks

