Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438891;
	b=mykzlnADmyccJg13MXlZzuV+huZj2nGGhqURSarYONQJZ6CeA/FMrc2SePwlWE0xaflT
	 udtntMFNfOa4tVkoNRUX4R1BFmXqdoQj755fRdK7l8kRA1XjPonMkZS+0f0aAEtwbME8S
	 ZMgGyD4yW4JOhqFFVS33FvH6yqYlNEeutIUzldOK2gpug4vd6j8bnHtoufR/BonN+XsEi
	 h+sA8mnjOzbUJkl0jGRai5bBG3WazH8z2uPcCpLTUQDTkcOCqNV97yapyegBrmYP87hn8
	 zjc2fLd/sbJCB35vaLHZjemF3iOwMdBREDlbhaBLnvzLMWb2+mvcyLWhC5y9DNrwLLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438891;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=/He75rqZEHTrbQuKFrcjCckncTUr+jB2aL3GERrJXuo=;
	b=wwaAip4pcVPhhhBOX5JkO0vPdttGpdZAqFXmNPzwZe4S8w17hontk3KI8JILreAU38YR
	 rR4X8XhWyWYjGMHlx5kwqKtJdfHmi/R9NGKH6+cXyuZPRsAPx5NWf8KkhMVkh6SfUBmXS
	 wUvBrEdOUgXuq0HQRk80tDIFRbnqTSqBtn9NmyijCitOndqEuNGnv6gSD1cZeiFefEs54
	 z4LGci7674hf1IaD4GGC3utgAX3x8jcIJPUMBXvkDQQmtuLeD2jK6M0BAGUcibqY0SM8k
	 O2NwzvmUrZyAualbwoRUfXGc6G7AGXfQN0WUEa2HxTyofYPf2ZMDQzcz7lnYWZNFDjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.42
Received: from mta1.migadu.com (out-42.mta1.migadu.com [95.215.58.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14B606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 09:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC14B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=08Ba43Ng1QTJoClFmEOcfURkhCB+iyftKxXyUWNmLKg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793438888; v=1; x=1794043688;
 b=sVxs5SaDkDBa09uTFu4hFJOaqrtNtfEPrN2fBpSuwy9ko181eiquYUD8AOWi9trGcmunnpcx
 sLJzJIJ+JB9/1wP5f764vUWk8rhW4KYWW1Qfb0Kx6k3KcUZKmeE4KbhbIDn+wtMKR2i8l7yWZgt
 o5KYGeBJItZdvSCZKs9EPhTo=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 034d958c6540cbee;
	Sat, 31 Oct 2026 09:28:07 +0000
X-Mizu-Trace-ID: 034d958c6540cbee
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
Subject: Re: [PATCH v5 2/6] mm/vmscan: move vmscan tracepoints to a local
 header
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261031090041.58574-3-ridong.chen@linux.dev>
Date: Sat, 31 Oct 2026 17:27:45 +0800
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
Message-Id: <9F0BED6B-4992-4F67-A8C6-D9550FBCEF22@linux.dev>
References: <20261031090041.58574-1-ridong.chen@linux.dev>
 <20261031090041.58574-3-ridong.chen@linux.dev>
To: Ridong Chen <ridong.chen@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 31, 2026, at 17:00, Ridong Chen <ridong.chen@linux.dev> wrote:
> 
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

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks

