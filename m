Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792913166;
	b=5kiwOteuMEfYyZolrL+F7//+6cNSVEQsw4EQ3CnJlpLroka9yp+Sp2YvaOmEcxEvq85/
	 8QP5X+/mwt5HBQgjMRe0lK1qgIVIcyEFTLFHTCf3cegsvUp7RisdcyI2VvG0dh9E1JUMg
	 4rcvf/gg/d/rPpPLxFHZFQMwOa9YNo78UNHIfBVHQ8lhqKWQBNNAj04vHlHBKyzbEks13
	 raB46s4PJbY77sQveWNjRHTEZzk56ihWLmyyhd+ZrIcJtaOn0TuDNrhiIIHLOBoOe4drf
	 N95A3MvexPCYrfiqV2koRWKJOd5/nmLxaUUDNujW++PFRrggzXB0y5VcMcXlYG5v6vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792913166;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=j9KSsqg4A137dhfxHCtQJ3v4H0Z3Fv0RGgyT9sIdyTM=;
	b=3DL5H4xagYuDk+ioTFTL5Rm51S+tpTatcQ9qsRKRA7ObuoHOgzFrGrsOjMt7vTjjw3GA
	 Tn52TCU3jAz0DJ5TZl6QdOZ+dWZ5K9FohuOlYjHIxo24NRhsCBSa62SPlz0wkERnPyBYT
	 xHlEOeu6iFiCrt5yq8G1pj0SbciRLWlT1ZCaLrgWOajuYGxck6war7FKBkxJWXLFaeriM
	 7NzF4GjVPQVkgmEZLxDaQjASfgKEsJ7cpNNqPrdOyczOMTdEFZ1TZd33enFbOh3tclu14
	 CmMQjOqL1RYt/HAVH5CuOiAaWglS7JTFkqrG+OwvFNK8zGlEgOd0BezKAipWWWU19yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SrylrmSI;
	arc=none smtp.remote-ip=95.215.58.108
Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D458606A31E
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 07:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D458606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SrylrmSI
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EX8dlYfY5NSf0gGAQukKQCIqou6iNOsLwD+U7YkkxHM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792913161; v=1; x=1793517961;
 b=SrylrmSI51G99gfF6hP20BW1YezhxVFD2E9TcQm9rb+kJyGod8R9UFeYM6oOD81yF6EmKP2a
 Cc7uTvxq0o6eOPxCE4pAEqTqOXP3yM9Z7W4JamGMlFNRx6/ZfN5JtJTLvu3e35ENVW7M1jFEBZL
 wR28/ZW6JvosYCN7CyRmoWgg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 483da7f721b1c77a;
	Sun, 25 Oct 2026 07:25:59 +0000
X-Mizu-Trace-ID: 483da7f721b1c77a
X-Migadu-Flow: FLOW_OUT
Message-ID: <c9df96da-983e-4803-9082-472f5294d50e@linux.dev>
Date: Sun, 25 Oct 2026 15:25:46 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] mm/vmscan: pass scan_control to
 mm_vmscan_balance_pgdat_end
To: Barry Song <baohua@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org,
 Ridong Chen <chenridong@xiaomi.com>
References: <20261019034426.2354049-1-ridong.chen@linux.dev>
 <20261019042308.2372396-2-ridong.chen@linux.dev>
 <CAGsJ_4z7u_PtSkjm+kH7JX_ZZDLSnGr1teHq6By0ovgB23O8_w@mail.gmail.com>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <CAGsJ_4z7u_PtSkjm+kH7JX_ZZDLSnGr1teHq6By0ovgB23O8_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/25/2026 6:24 AM, Barry Song wrote:
> On Mon, Oct 19, 2026 at 12:24 PM Ridong Chen <ridong.chen@linux.dev> wrote:
>>
>> From: Ridong Chen <chenridong@xiaomi.com>
>>
>> balance_pgdat() passes sc.order and sc.nr_reclaimed to
>> mm_vmscan_balance_pgdat_end as bare arguments. Pass the enclosing
>> struct scan_control instead and read the fields out in TP_fast_assign,
>> consistent with the other reclaim tracepoints. highest_zoneidx stays a
>> separate argument: it is a balance_pgdat() parameter, and
>> sc.reclaim_idx may differ from it by the time the end event fires.
>>
>> No functional change. The tracefs event format (TP_STRUCT__entry and
>> TP_printk) is unchanged, so tracefs-based consumers are unaffected.
>> BPF programs attached via raw_tp/tp_btf see the new TP_PROTO and need
>> to be adjusted; tracepoints are not a stable ABI (see
>> Documentation/bpf/bpf_design_QA.rst).
>>
>> Assisted-by: LLM
>> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> 
> Could we combine patches 4–7 into a single patch? The changes
> seem a bit too scattered across separate patches.
> 
Sure, I split the patches just to make them easier to review, since each one 
contains only small changes.

-- 
Best regards
Ridong

