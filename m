Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8733329E5C
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774638748; cv=none; b=GXSmipG/4AjytpYUuVMNG5dHNBl+07swNsOFCulbdsX51hi6Dj2PMdxZ8V2Tbc8MtlwkibCUEn38XvWovu25EDfA4YrHtbPgzi6juk+l1Kx+nfnRoBrl5Qmf4t8zPHW9g0nPt740b9GqoZ6c4z0YBaEhN3GtiITRbD5j4/FdM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774638748; c=relaxed/simple;
	bh=ro/Wp+++SFZZgn6/weFW6585IXuEl+0Rz02cL/GOfYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoaAcCqzKsPVsAt85btb0pJALK156ZTqNE8puXPC91oHWKuuVQAFKK5vydpmjnjPqe9VHwETiBo5vk6MEPMW9FSDLl/7vkLCT+dxhYGgVijZzVoeAC3oksf4egR4F4FAcMzisa/og7k7JsEyXFnV1kN0cKzNdX+6N9sFaxAy1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=pHEHuKoL; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="pHEHuKoL"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RIjhV23122052
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 15:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=wSs7
	LoklCS7ghay0+uBwQU5R4fTsrDEUffYAtAgQcNw=; b=pHEHuKoLkH6PQUV9Psn8
	ai+/QfIz7KPO+U0xJU0AKdKn8ABVeQ/Cw9Jv2uj6vQUGF/XPcdPFcFYYnWKm86wr
	tS154faYFIDct0CtBpvZdbmHKqclSYCdhG0vofPxB5TYiBXh1YZtMI0oPK4v9jBO
	HCSyU5k5OgoDQbEfkJo2A0B9/NKVeo4L4IXHOaZZKNSb6QnBXXjj2JH+oNXUeBEl
	N5BM7tSKcNX/zKIh642ErJKq3hgpe5rXLE19okB/F8qrk7crvTM60W9S5iO5HwEV
	iyqT6EgJj4B7ZVwMwJYNzqmBPPuX50qlrv+DJBKGksukh9879DO7a9IbhdlX43VO
	gQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4d5wgj175j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 15:12:19 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfcebeb1f3so375344785a.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 12:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774638738; x=1775243538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSs7LoklCS7ghay0+uBwQU5R4fTsrDEUffYAtAgQcNw=;
        b=hLzKnTh5MAcc6WmzIbf1Dk67MEOs60e9mA6fRoh7Q1V2JktE3vVKmi5C+LP6HQWyvk
         I8BUB3mKwmADh3bRKPI1jFNpCsouy5OWRhQupCEFmjcX80BtOMzz6DxSRpQCPCoUKx20
         X2tXDFp8BxxoLghusRMltLVhS6lTSX8q0pXGAtCoCyTwWeHc2kZnmsQH4cVA5/Ums34n
         m7bXR5KLWdUJhfiAs2RRix2onFjabNK7unBbZbdrWfBjQAmIzHhHM/9C8mJR7eLUd/lU
         OuDPTm92wuinyEO7nSBbFClFBbt8ymFV0EmUVILfAvK0r2MOcfElUJy5L9hnSeRNziX7
         wwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrEUsdHWJJPZWpGP5LOMwjKTUgY96VG8pm153ano11YP1tToZ4wBJAnrBOEze47kGZSow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhsgpr9LmeckLbvmJZlG+aXhmZ/U3Np26kv5WnKiQvZPUhMcFl
	6dsnn6aCuqQCJc9Oj4YJjZcCZe+9xD3fViavgA2HzvY0PDE79b+zyQDWwGlxdggCHv/Jlj3jlPr
	hA3SsvudLnMjvL7CC87vUBKvZuMigYkADxmUBtyXCUzzhPO5Z5g==
X-Gm-Gg: ATEYQzwSyb6A6PM4P9G+eMDXtl5Po+HWmfgdO1TIYTB27pDEDZoyDn3c4hAESHFXwkx
	LT/Jz3LiwYHCNpF3N0WVcaqJp4SMBqO35eNbyZ4sA5ndJyR5Ohsnqz/wVbrx9pKYHHYCNUU+rcU
	sVof2TQrhYAaXTrjAa5nuoVUJuf4I4sRiB19l7wzo5mB4QhY9aL9UgRvdlWtnyDBLVh/+YO3NxI
	Q8+53tEO7BJaHh1e4ii/GLm+crs6YUswT1bpuZM3y1M5nh3cH9zUumwVv41J6FIdnDpox7xJci/
	vooEXnzXDnpJAw9FQElE5sWtU8weGxLpewYhMpg5w75jybntbdSKB4C2Pz5vzmYYrrzRMuaD4NZ
	q6G70xeVodEI1Ll3ShSQfkXcjT4Gtp+MWn6o=
X-Received: by 2002:a05:620a:1a0d:b0:8cf:f2ec:c52c with SMTP id af79cd13be357-8d01c5bdfc6mr513892185a.7.1774638738526;
        Fri, 27 Mar 2026 12:12:18 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0d:b0:8cf:f2ec:c52c with SMTP id af79cd13be357-8d01c5bdfc6mr513885685a.7.1774638737754;
        Fri, 27 Mar 2026 12:12:17 -0700 (PDT)
Received: from [10.206.53.25] ([129.236.228.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e52db60sm605598185a.46.2026.03.27.12.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 12:12:17 -0700 (PDT)
Message-ID: <6f40c513-af3e-45b6-9000-c61494a23bd3@columbia.edu>
Date: Fri, 27 Mar 2026 15:12:16 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
To: Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc: Gregory Price <gourry@gourry.net>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        lsf-pc@lists.linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Chen Ridong <chenridong@huaweicloud.com>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Alexei Starovoitov <ast@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
        Wei Xu <weixugc@google.com>, Kairui Song <ryncsn@gmail.com>,
        Nhat Pham <nphamcs@gmail.com>, Barry Song <21cnbao@gmail.com>,
        David Stevens <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        wangzicheng <wangzicheng@honor.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
 <acWXdvHx9mYqvT2w@gourry-fedora-PF4VCD3F>
 <CAJHvVciAmX9OFLBSahwvXL=E+3xnDsL2aE4WKfDBFqaT1Gu+Qg@mail.gmail.com>
 <acX8_XMQYA0-NGUW@casper.infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <acX8_XMQYA0-NGUW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzMyBTYWx0ZWRfXwyXwoZIRsAz7
 EP4jhTvdhv45gh+8viaN/FI3tsUPbYpLAJwpbhYTsK1YZhUAd4EDPNEjVdWFYM0IWBb44Ew604G
 XqaJwjaGz9bQ28Q1svy/bafET9mDCzwm/Q+0mBj4rBOcz7gGoH+GwqO1pf/4vRr1kwtKj24/Wrl
 0llTXNyndCRiM673uxFZwgUpvklzCZ7efC4c5DpOD3gITdX4h3vJiPJP38Hg8kM81y6II8wM86D
 rUYAa9dzVrPHHF8HLid+lW44lTDtjP3e9dbbNktpJaLdxP7h4hSQsmDyidwodQ9yHNxkOkYnYm9
 rF59XK25Lq5KUc+nkUO7Yt++02/LwRMc4ATHMqeIVLGCuMST9WiPtp0/12cvKp3viwNmz3APTd1
 JExvmH+pbOLHf5lNZtRnXtqUmUkg3vqJYDwVpfkC5dPDfTuUXSKLT74xpx4Pq0J5QC8+9Sjr6af
 BXWJD78j7o0n3c1HAxg==
X-Authority-Analysis: v=2.4 cv=A5th/qWG c=1 sm=1 tr=0 ts=69c6d693 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=i0E64eHTdvG+y2bc1TXZ9Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=N54-gffFAAAA:8 a=tHa68p0SAAAA:8 a=bNtxNjT4IcQ00HAFgbQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-ORIG-GUID: LfZ25xIzQjVKhZ7CJJ8TAzrlwQpYt2hk
X-Proofpoint-GUID: LfZ25xIzQjVKhZ7CJJ8TAzrlwQpYt2hk
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11742
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=10 bulkscore=10 impostorscore=10 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270133



On 3/26/26 11:43 PM, Matthew Wilcox wrote:
> On Thu, Mar 26, 2026 at 01:47:43PM -0700, Axel Rasmussen wrote:
>> On Thu, Mar 26, 2026 at 1:30 PM Gregory Price <gourry@gourry.net> wrote:
>> >
>> > On Thu, Mar 26, 2026 at 01:02:02PM -0700, Axel Rasmussen wrote:
>> > >
>> > > I think one thing we all agree on at least is, long term, there isn't
>> > > really a good argument for having > 1 LRU implementation. E.g., we
>> > > don't believe there are just irreconcilable differences, where one
>> > > impl is better for some workloads, and another is better for others,
>> > > and there is no way the two can be converged.
>> > >
>> >
>> > I absolutely believe there are irreconcilable differences - but not in
>> > the sense that one is better or worse, but in the sense that features
>> > from one cannot work in the other.
>> 
>> Right, agreed. I mean a case where we have workloads A and B, such
>> that there does not exist an implementation that can serve both well.
>> If such workloads were "common" to me that would justify a reclaim_ops
>> / pluggable abstraction layer. My thesis is that they are "not
>> common", so I'm a bit skeptical the abstraction is worth it.
> 
> That isn't what Tal was telling me at Plumbers.  Adding him to cc so
> he can dispute you in his own words, rather than my clumsy paraphrasing
> of what he said.
> 

Yeah, unfortunately it's not so straightforward. As a simple illustrative
example, consider a file-search workload, where you search through a large
number of files over and over again (e.g., a poor kernel developer trying to
understand how the page cache works). This follows an MRU, rather than LRU,
pattern, and readahead doesn't help much, leading the active/inactive and
MGLRU policies to have similar performance (~40s runtime in a specific
benchmark we ran). In comparison, using cache_ext (our eBPF-based caching
framework), we can run an MRU policy and it goes down to 20s.

This is also true for more complex workloads, like an HTAP-like database
workload, where we have lots of small GET-like requests and a few large SCAN
requests. We find that the SCAN requests pollute the cache for both
policies, leading to eviction of the (small) GET data and degrading
performance. fadvise() doesn't help much, but using a custom policy that
separates the GET and SCAN data into two different queues can yield a 70%
throughput increase for GET requests. This was tested on Linux v6.6, so it's
possible that various MGLRU behaviors have been improved, but the underlying
structure remains.

It's been well-known in the academic realm for a while that there isn't
really a "one-size-fits-all" policy that works *best* for all workloads.
Yes, you can make a general policy that works *well*, but if you really care
about a workload's performance and want to squeeze out the last 10-20% (or
more) of performance, you need to be able to (1) experiment and (2) take
advantage of application-level insights. Being able to extend reclaim (in
our case with eBPF) enables that.

We wrote a paper about this that was published a few months ago [1]. Happy
to answer any questions and continue the discussion!

Thanks,
Tal

[1] https://dl.acm.org/doi/pdf/10.1145/3731569.3764820
