Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BF3491D6
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473345; cv=none; b=Z5omo0b6KzILgvC8s0hkH7vHfRIS74u1j2hw6gQfO6x0Vk/5WjdAdNI0+Zj5+QIHwzAmJFUnOteOn4nP6moesmXO6K7sBrkGuXOo3GiD86vcNC4vqB5FFJR8RhBBrzFTTnFqJ8L88/r+oVNYB+c7f6rwGXiNEKI7zydIm69IF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473345; c=relaxed/simple;
	bh=RZX6r0mMjWGiun6WFfBsSkRzDJp5nUokF1ODPlAFnNk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SyeUgIuZST+MuRKJEVzjtjrUARnjncRIFhZBsraJy+k4xNNc1PpBv7NYxtFgVp63wjmCPyY+9xAzEND2SPO3J6gskaclSV1s9NHAbIyDN9q5zXetjQtyeZ5w8f8fIsCXjHQw4APIVvjmCz5WKdhRHiGZ3ch5tqj5FGvoeCSyYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MBcQ1lW5; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MBcQ1lW5"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PL8wk21218354
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 17:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=zLtBhFz0tdAolnQY96/OAWUhS/
	Hnuk9T/3HN0+aXwAw=; b=MBcQ1lW5ktV0V3ftxYgPOMu8E4zJtlRnAtgS5YcJ2f
	nvVZ7bbfl9TNgbJw4spKguFBqSujds/jwmtsvUm4Pv2p9XPO8sUu1noNx1NpCNlo
	cRICfQx21CbbbVDH9kKZnpHkSaOGeDkW8USydSm6heuZc3Isd3YmDq9J5Uu5TPkF
	3C0hxh4RKLLZC3SvCNEHS9S2+8vjZHZ4UdQBr1/FwLI52X+xlpLEG7Qv/HMfmcxf
	o520kLJFATpq+jWhnu0KUG83rEhx2tzhMdOvU2zKTlwMJwnA3wMBNNQwcsws5dbv
	8Je6cQwo9wp+H5TtcQyA41BfJ06quDPJWXg+uYluoZ5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4d42nnr64u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 17:15:39 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50925fed647so9974581cf.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 14:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473339; x=1775078139;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLtBhFz0tdAolnQY96/OAWUhS/Hnuk9T/3HN0+aXwAw=;
        b=YLrM5aVjhHhO9LFFfH2mJ5LVmzjwzooA5KcRmat7tl3AC/FflRcHnSBc0krW/zSF2k
         4FugRDy/KIrMvsIx7ZodTuYnNMm96zwHcLbxjRTU4lD7fwLRNY9chDadqtoLfmTJcpB1
         2K5nSHpeUyUeWibjEQD37L4mGMLML9gBZzyAB/0E6UcRkW7G/sPw+J3Qi9r9Ivii4sqO
         FKXm+MU2AX+EAsYO1LkMX6X99v45M3C19YB34flXSDOuCq5jPTZjhfV/DVSDMdj1tqk5
         ZzcpKHh+WtCpnA/wLr4UJqUULVvJIo4rPIeksMfVIlGHu2YYrAzUnXBQNqcVzzDMbDwl
         IKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8RaFVQZ1hpE6mphE7MoqPqKOpUS0a7nv9qVBCqDVpH2+RSrZ7x5+IY820GTu6ykoaMSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh1HpEAw41stXL2SJG8BxkcFAkxB5AikU/EbI7FdchBRiM7Bil
	I+AR+up5KTScgM1cgcbnv4fHUAq+JYNpSAmoPku+W83YXVYXD2wRSOZFxSf9HV42OHDcqDUBeyT
	OHIym22m/hjxdw9WLFNyTF/fXvGX6v3uBOVK5GzyuL2QbrE6PiQ==
X-Gm-Gg: ATEYQzw36QhvoueexKg4LhBRY1MxXjRfeL1Sdgc7aRC/qIAYyhyWUmfR1YMm8CVoar1
	vTR0yH4Kism8pO+b56DFg9bnQ3Ix5CiU3+n2SURQojh/h1CD1dSUnAej6HmHa8X5mCc3pAb2ysU
	L/o78AktS5PNUfkOpH4LzqJ/4CD9gehdUMUdjJvAz7bQ0U0dAqB/P97j0JQH4NRKu8mrt5Ys+8J
	x5XSs+PaKODgxXxE79kIc1dWIJQMKQpIhorCB4ICGNVCOZAs+qQUqHtUtSe0EyuItiFVINrdLlU
	ffsz0ZBT+mMZUVH3SjrsPq8Xmm7SMB6WaZqM3sBgg1X0hU386UceZVOFoQE9zgfhg4U03CvATFG
	u3D/yaDod22Mj4jwiLMWd6Y2PrWcX6ksdKEe/VHvAv8S+
X-Received: by 2002:a05:622a:2294:b0:50b:1e21:174f with SMTP id d75a77b69052e-50b80aff737mr78589281cf.0.1774473339037;
        Wed, 25 Mar 2026 14:15:39 -0700 (PDT)
X-Received: by 2002:a05:622a:2294:b0:50b:1e21:174f with SMTP id d75a77b69052e-50b80aff737mr78588551cf.0.1774473338313;
        Wed, 25 Mar 2026 14:15:38 -0700 (PDT)
Received: from [10.206.160.184] ([129.236.226.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b92136161sm7879901cf.7.2026.03.25.14.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 14:15:37 -0700 (PDT)
Message-ID: <0b1293ca-7a1f-4358-bc20-15784452238d@columbia.edu>
Date: Wed, 25 Mar 2026 17:15:37 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, bpf@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Emil Tsalapatis
 <emil@etsalapatis.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josh Don <joshdon@google.com>, Greg Thelen <gthelen@google.com>,
        david@kernel.org
From: Tal Zussman <tz2294@columbia.edu>
Subject: [LSF/MM/BPF TOPIC] Upstreaming cache_ext: Custom Page Cache Eviction
 with eBPF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BG698qtmz8AwuG9pxm-3k8o_KJdnFh_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE1NiBTYWx0ZWRfXzK9e1b3SfZGs
 gOQA1hex4gTj90TWlzNI75nG/61KHpRFcErjO0dUGOVp7uJECnzFBgXywWnrpF7wiql4NphIB5o
 qqvwWKkc54GjQrmPsXKN9QbWC+uzo3OL+RnwJLpM6nNoP0wn5Nc2NkmwrkaBldRxrOVkuEi2ylN
 s+PSSKFVBt0hd9TeW8GIsN6BUKXi9XhnRnfIQj3EXeH5vBYbu3lIJxvZIngUdnwmVpgGkHV+N7Q
 9XxBYoL9Jv/zrN5U6czb64qHABc4r7BbfGe6h3apaSQfPaKCtPC4eK7a157PuJUt7xNcd6PGjq1
 /Myn68R/OSPeC5qY1O4EoxQvXVh+rgtl49sJiGH4dHM5ErOZatP+VkFWcHnfir2Fh1iSPUXOr7d
 hWVaikRLre7H374OiFDS66FdyBEEac7vbBekTVqeXv3PoD6ssmxdYXglhHIGHmRC8alB16QHhIf
 s1bWUAeMR36dmki8JEQ==
X-Authority-Analysis: v=2.4 cv=A/th/qWG c=1 sm=1 tr=0 ts=69c4507b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=QOUmeeuX5y9IvSxXHa6D2A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=UVq9kkz1AAAA:8 a=OGjWj8McAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=H0umD5oqAAAA:8 a=ZOhZhaf62XQlCQ4KXVUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=UYjydHh6ynBBc6_pBLvz:22 a=du2hvLAJtKcNxoDMbUSS:22
X-Proofpoint-ORIG-GUID: BG698qtmz8AwuG9pxm-3k8o_KJdnFh_Z
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11740
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1011
 impostorscore=10 bulkscore=10 adultscore=0 phishscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250156

Hi all,

This proposal is late, but I've been encouraged by a few people to submit
it, so hopefully it's not *too* late...

I would like to propose a session to discuss cache_ext, a framework that
allows applications to customize page cache eviction policies using eBPF.
This work was published at SOSP'25 [1] and presented at LPC in the eBPF
track [2]. The preliminary code is available at [3].

This topic spans both MM and BPF, so it might fit best as part of the joint
BPF+MM session that Roman and Shakeel have mentioned [4].

Background
----------

The kernel offers two built-in page cache eviction options: Active/Inactive
LRU and MGLRU. Neither is optimal for all workloads, and the existing
customization interfaces (fadvise, madvise, sysctl) are limited and often do
not behave as expected. Applications that need better caching behavior today
are stuck either living with the default policy or implementing their own
userspace caches, which are hard to share across processes and often still
rely on the page cache as a second tier.

What cache_ext does
-------------------

cache_ext uses eBPF struct_ops to let applications define custom eviction
policies that run in the kernel. Inspired by sched_ext, it provides:

  - Six policy function hooks: init, evict_folios, folio_added,
    folio_accessed, folio_removed, and admit_folio (admission filtering).

  - An eviction list API (kfuncs) for creating and manipulating
    variable-sized linked lists of folios. Policies can use multiple
    lists.

  - A batched eviction candidate interface: policies propose up to 32 folios
    per eviction request; the kernel validates and evicts them.

  - Per-cgroup isolation: each cgroup can run its own policy without
    interfering with others using per-cgroup struct_ops programs.

We have implemented eight policies on cache_ext, from simple (FIFO, LFU,
MRU) to sophisticated (S3-FIFO, LHD, MGLRU), as well as application-informed
policies. Our evaluation shows that matching the policy to the workload can
improve throughput by up to 1.7x and reduce P99 latency by up to 58%, and
that, in general, no single policy is best for all workloads.

The kernel changes in our prototype are roughly 2000 lines total, of which
only about 210 lines modify core page cache code, 80 lines touch the
verifier, and 80 lines touch cgroup code. The rest is self-contained
cache_ext functionality (eviction list kfuncs and registry operations),
but much of this can and will be simplified.

Discussion Topics
-----------------

1. Interface design

   Right now the page cache is not modularized. cache_ext adds hooks into
   the page cache in an ad hoc fashion, inserting struct_ops callbacks at
   six points in the page cache. Is this the right abstraction? Are there
   page cache events we are missing? A longer-term goal could be a more
   systematic modularization of the page cache to make it amenable to
   extensibility, but that is a much larger effort -- we would like to
   discuss what a practical first step looks like.

2. Relationship with MGLRU

   cache_ext is currently built on top of the active/inactive lists
   infrastructure. Can we instead make use of MGLRU's infrastructure (e.g.,
   the access bit scanning)? This also raises the question of whether we can
   split MGLRU into reusable infrastructure and policy, so that policies
   could build on MGLRU's infrastructure while replacing its policy logic.

3. Eviction list data structures

   cache_ext implements eviction lists as kernel-managed linked lists
   exposed via kfuncs. Could we use BPF arenas instead, as sched_ext does?
   And how would arenas affect the ability to fall back to the kernel's
   default policy when a BPF policy misbehaves or fails to propose enough
   eviction candidates?  Are the eviction interface and data structures
   powerful enough as-is?

4. Path to upstreaming

   cache_ext was developed on Linux v6.6. We are currently working on
   rebasing to the latest kernel and should have more progress in the next
   month. There are a few other issues we plan to fix and clean up along the
   way, but in general, what does the path towards upstreaming cache_ext
   look like?

5. Future extensions

   Beyond file-backed page eviction, there are natural next steps that could
   be explored down the line. Prefetching customization has been looked at
   before (FetchBPF [5]). Extending cache_ext to cover anonymous memory and
   swap decisions has also been mentioned as a natural extension. This
   could also have interesting interactions with Shakeel's memcg_ext
   proposal [6].

Links
-----

[1] https://doi.org/10.1145/3731569.3764820 (SOSP'25 paper)
[2] https://lpc.events/event/19/contributions/2165/ (LPC talk)
[3] https://github.com/cache-ext/cache_ext
[4] https://lore.kernel.org/lkml/aa9SB6OzocfwL9kO@linux.dev/
[5] https://www.usenix.org/conference/atc24/presentation/cao
[6] https://lore.kernel.org/lkml/20260307182424.2889780-1-shakeel.butt@linux.dev/

Thanks,
Tal
