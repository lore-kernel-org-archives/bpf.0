Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D23368A9
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073150; cv=none; b=W4QSVUqEVRgrzGCEx3J9FBRzNfdKuKWzljynxSHF2NTjtYOgKfwL01X214hLksFzey31fterqhqD01r4n7+k/cul9z0giWZE8goMRLYelTTaI2+XOyL8HjCBNTnkrA27XKkpKY7wvcwrnE5fVQIX3SFVCY7fAVbg4hW8XND8LJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073150; c=relaxed/simple;
	bh=DiUjgW3HjQA7W8GZ1DckQdi32GmqBAyKGq4b6fgiers=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hKfd2S2D8QSASYfPH2En+UYe/rTg5lOhrTro586lKu+AIWxdk9hKle2kXjma3MCl0FP1rwIahDrhgpjuLcT2WuD4iU9SvVIB+ip+yrawUsnvlilo7L+a3rpl+Hct4TAM3Za08Y8WPkBD7K8Eek6SNFCYvLu3oLFJABlDoM/UzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Nso5+vQY; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Nso5+vQY"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646DCD483405040
	for <bpf@vger.kernel.org>; Wed, 6 May 2026 09:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=xHmT
	w4fIwM3z3gJhFmLMXTuoGlxEtSsjJTeGNucv6ck=; b=Nso5+vQYQ27Degd46N3l
	QS/1WJJ4wi4bgnqt78x0zWzC3MfSsVH9wf9rZnwJPfUH+gJMXITivRn89GQHQLfd
	vh36KAg9Rnayh1/8E4QmzG2mSdCiGLgNvN2ngI9FhcyFL3GTQku/zpugwwud0K/X
	65Rt3O8pC92lyPBO7sHGxAHUXPvWLg/lBfrQFV92i7zz1HvS/seozhEwx4YpRath
	1wP9YnIIqQQ5cU8JJOqMFwVeUsz7y3IUoYTAx1EJ59zhJcWXqGUyo2VJVBc14CC7
	/GdBVx0WIMp1HAx9Z/CVi7nm5mHgydZNNV0yZiCZgq/O+I6ewzO+UOZZ4b9zCWlh
	hA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dypju4n17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 06 May 2026 09:12:20 -0400 (EDT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56eeff9a41bso13184270e0c.0
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073140; x=1778677940;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHmTw4fIwM3z3gJhFmLMXTuoGlxEtSsjJTeGNucv6ck=;
        b=VgIh+5HMDr1i8lBJs5eMrRKBNrmjJeDGLsN6GcSCBSkuvu5/j5W9Bfw5+Ipt/Z01Vp
         6/MXyx1mnCWjUCEHsXXZ6RL5WX7+65JRkbnzNDOHUMfIKaGvQA8/G4eRuFdPljqoKR2r
         mKpfqXJicbA6qSvODjhOXuit0oD89nsvT2snPs+msKf5oXukZZF8lml4Xz0iW7z1mion
         7WLhMK2pcIGuZkshHN37CXcmTfEcCX6CDR7cmjD1npejcLuNLDXkTlYDL2zDu6ex5KuR
         9f2NbMT5XgMRrwp7SsqhLvvCInyxW2fkhI9kqf0RPupUjEqu/8mDjnl0WXE4xXUCa9/Z
         1P0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8/GxjKeufw1BkDqUnt1smrjYip4e6Xj/0qh5YbwxWgjFvGjsGjt+m+ntxQK4QbUjGpE1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaRPuutbH7TnZjsemkSpXdg3gPTLbXelSIxOKUcwFsZe6F91H
	HA6MQFwKB+NNuQf207VTJhY44iJd+2C1U9XxeDlDR7Lfltd0nvxrmCelseIt17jqHAM6iuXvxQu
	fQnw2jXG24YP3nI7tawC86biAEPtg0YYFbTjtulecXAaFbXvFIA==
X-Gm-Gg: AeBDievRStcH2IqirT5TyzvcjQsOtKJlg99nicbsyjANB6eWDO2oUx3NFkPXOoqJ6zm
	T9GYFhp/HHogkLv9YnjVdDYB6sNgVBNqtNA3uKrBYjBsKSqFeR4butK+pM4M0izjQ25cE835Gs+
	UpdEjLWU7kWVut7MkCTaBGmPn0NT+/mRvfyjs4A/+C0FxFK3mSPnIbbtgEsSjMin6trZSgpapm/
	eTEmqdUNhbjXIeQ8yiZDztR6lQGTlMIgEUf/zpjS5yUjvq4XK+jQPZQ884IaiHRGkMjsgbwrJus
	tC1n6QqeUiv/1Yr3LYgZlCgglOdQKyJBrN7Kq/3CoGVpcs0qmTd0YQJAssFLLeqm4O92cPSiI/Z
	p1dHxeSLZvwQrsvQC7gnliC6k0bNzSzTe+JP17U3eiFQ=
X-Received: by 2002:a05:6122:3d01:b0:56d:2ca7:fbc3 with SMTP id 71dfb90a1353d-57559509d20mr1588607e0c.5.1778073140214;
        Wed, 06 May 2026 06:12:20 -0700 (PDT)
X-Received: by 2002:a05:6122:3d01:b0:56d:2ca7:fbc3 with SMTP id 71dfb90a1353d-57559509d20mr1588530e0c.5.1778073139573;
        Wed, 06 May 2026 06:12:19 -0700 (PDT)
Received: from [10.211.9.35] ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aaa0fsm63102255e9.7.2026.05.06.06.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 06:12:18 -0700 (PDT)
Message-ID: <f02be3f5-8f1c-4448-92e6-14465ab24c52@columbia.edu>
Date: Wed, 6 May 2026 15:12:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Upstreaming cache_ext: Custom Page Cache
 Eviction with eBPF
From: Tal Zussman <tz2294@columbia.edu>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, bpf@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Emil Tsalapatis
 <emil@etsalapatis.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josh Don <joshdon@google.com>, Greg Thelen <gthelen@google.com>,
        david@kernel.org
References: <0b1293ca-7a1f-4358-bc20-15784452238d@columbia.edu>
Content-Language: en-US
In-Reply-To: <0b1293ca-7a1f-4358-bc20-15784452238d@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AS2PRzsyiQDUG3VKxWi3lrAsOal_Bhh9
X-Proofpoint-GUID: AS2PRzsyiQDUG3VKxWi3lrAsOal_Bhh9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzMCBTYWx0ZWRfXxwEQyvki5hla
 NLAixcWr2jpOvyKkfjnAX2pKGUKl4ShzCZ1YPUroaDl+iR3zA7m1MYyPEVvSrznsqXx7ZiLqmSb
 r4zbJy6XLnuYh1iSK9UCofDVlSwh0+4px9WRpBydoczf1Gpe/ri05qhqdyrYdQpj8tj2LN6hFhB
 DWyqkSlRBpaXbcoN/1+iloYcw9GGb6PVOkBY7vlCNKqDYipOxq2+l6kFg5JDXpeCwx9SVQ11zCz
 KEVkX2uVwrZBFyYUL7XtF+0n5aMOz7fiBRG6kMnXklG9NyDT7ckAVtQg3fByeIGar5kBIp22+Jc
 ZVo2QTHp2evnZvrAk4HgI9WLtIjawSGRQfDpO8qhlWX+KkY5S2wkVdYibRyJOcqvFuuBzQoCxQd
 gwmBPzwCEnAQWQFJRhTquRKwNcSe8nBrpZI4v0Pa21Xh89/HvPBaXuXe6wfkjiZ9ZoPk9KyIcne
 RW9I9q73BdQKlNuiK4g==
X-Authority-Analysis: v=2.4 cv=VeDH+lp9 c=1 sm=1 tr=0 ts=69fb3e34 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=tB6HjC2E8F7nLDkxGPwPUA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=UVq9kkz1AAAA:8 a=OGjWj8McAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=H0umD5oqAAAA:8 a=6G-Ez4ltAAAA:8 a=HJccVVA8XwGZjw0NcJEA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=UYjydHh6ynBBc6_pBLvz:22 a=du2hvLAJtKcNxoDMbUSS:22
 a=S3KgPZztbmJfj4cihBTF:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11777
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=10 impostorscore=10 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060130


On 3/25/26 10:15 PM, Tal Zussman wrote:
> Hi all,
> 
> This proposal is late, but I've been encouraged by a few people to submit
> it, so hopefully it's not *too* late...
> 
> I would like to propose a session to discuss cache_ext, a framework that
> allows applications to customize page cache eviction policies using eBPF.
> This work was published at SOSP'25 [1] and presented at LPC in the eBPF
> track [2]. The preliminary code is available at [3].
> 
> This topic spans both MM and BPF, so it might fit best as part of the joint
> BPF+MM session that Roman and Shakeel have mentioned [4].
> 
> Background
> ----------
> 
> The kernel offers two built-in page cache eviction options: Active/Inactive
> LRU and MGLRU. Neither is optimal for all workloads, and the existing
> customization interfaces (fadvise, madvise, sysctl) are limited and often do
> not behave as expected. Applications that need better caching behavior today
> are stuck either living with the default policy or implementing their own
> userspace caches, which are hard to share across processes and often still
> rely on the page cache as a second tier.
> 
> What cache_ext does
> -------------------
> 
> cache_ext uses eBPF struct_ops to let applications define custom eviction
> policies that run in the kernel. Inspired by sched_ext, it provides:
> 
>   - Six policy function hooks: init, evict_folios, folio_added,
>     folio_accessed, folio_removed, and admit_folio (admission filtering).
> 
>   - An eviction list API (kfuncs) for creating and manipulating
>     variable-sized linked lists of folios. Policies can use multiple
>     lists.
> 
>   - A batched eviction candidate interface: policies propose up to 32 folios
>     per eviction request; the kernel validates and evicts them.
> 
>   - Per-cgroup isolation: each cgroup can run its own policy without
>     interfering with others using per-cgroup struct_ops programs.
> 
> We have implemented eight policies on cache_ext, from simple (FIFO, LFU,
> MRU) to sophisticated (S3-FIFO, LHD, MGLRU), as well as application-informed
> policies. Our evaluation shows that matching the policy to the workload can
> improve throughput by up to 1.7x and reduce P99 latency by up to 58%, and
> that, in general, no single policy is best for all workloads.
> 
> The kernel changes in our prototype are roughly 2000 lines total, of which
> only about 210 lines modify core page cache code, 80 lines touch the
> verifier, and 80 lines touch cgroup code. The rest is self-contained
> cache_ext functionality (eviction list kfuncs and registry operations),
> but much of this can and will be simplified.
> 
> Discussion Topics
> -----------------
> 
> 1. Interface design
> 
>    Right now the page cache is not modularized. cache_ext adds hooks into
>    the page cache in an ad hoc fashion, inserting struct_ops callbacks at
>    six points in the page cache. Is this the right abstraction? Are there
>    page cache events we are missing? A longer-term goal could be a more
>    systematic modularization of the page cache to make it amenable to
>    extensibility, but that is a much larger effort -- we would like to
>    discuss what a practical first step looks like.
> 
> 2. Relationship with MGLRU
> 
>    cache_ext is currently built on top of the active/inactive lists
>    infrastructure. Can we instead make use of MGLRU's infrastructure (e.g.,
>    the access bit scanning)? This also raises the question of whether we can
>    split MGLRU into reusable infrastructure and policy, so that policies
>    could build on MGLRU's infrastructure while replacing its policy logic.
> 
> 3. Eviction list data structures
> 
>    cache_ext implements eviction lists as kernel-managed linked lists
>    exposed via kfuncs. Could we use BPF arenas instead, as sched_ext does?
>    And how would arenas affect the ability to fall back to the kernel's
>    default policy when a BPF policy misbehaves or fails to propose enough
>    eviction candidates?  Are the eviction interface and data structures
>    powerful enough as-is?
> 
> 4. Path to upstreaming
> 
>    cache_ext was developed on Linux v6.6. We are currently working on
>    rebasing to the latest kernel and should have more progress in the next
>    month. There are a few other issues we plan to fix and clean up along the
>    way, but in general, what does the path towards upstreaming cache_ext
>    look like?
> 
> 5. Future extensions
> 
>    Beyond file-backed page eviction, there are natural next steps that could
>    be explored down the line. Prefetching customization has been looked at
>    before (FetchBPF [5]). Extending cache_ext to cover anonymous memory and
>    swap decisions has also been mentioned as a natural extension. This
>    could also have interesting interactions with Shakeel's memcg_ext
>    proposal [6].
> 
> Links
> -----
> 
> [1] https://doi.org/10.1145/3731569.3764820 (SOSP'25 paper)
> [2] https://lpc.events/event/19/contributions/2165/ (LPC talk)
> [3] https://github.com/cache-ext/cache_ext
> [4] https://lore.kernel.org/lkml/aa9SB6OzocfwL9kO@linux.dev/
> [5] https://www.usenix.org/conference/atc24/presentation/cao
> [6] https://lore.kernel.org/lkml/20260307182424.2889780-1-shakeel.butt@linux.dev/
Slides: https://talzussman.com/slides/cache_ext_lsfmm2026.pdf

Thanks,
Tal

