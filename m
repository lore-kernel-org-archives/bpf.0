Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88537E2F4
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201076; cv=none; b=mUzrLmfjjhR26+lNPSwpBf1Debwk95/t7dntwDeaBBdA5vySX1oQwWCIukWc36V3AKX3ybOwesPxeTsy5qs0F1A+tcgCdB/akTp+RstTFa463oc0rrm//l5YrsaVinqzCCFDgoXVm6LtGd5ISMF1hiczWhywvuwOC9feFqJ39Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201076; c=relaxed/simple;
	bh=mCEJ4FFASO+9Hz2ANmb4ZMiHJapQS0Os9jNmIt47P7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHtIbgVM0xv6AORa3ouPkDVuStI3CTn0iXVwTsJfaDjuFmK4N4lxvrQM4vjfJxTlyyi4r8cdQDBLbPbbri60HctWBg6m4/6YBkeuN+1nzyuAvCmS83taR64PQHRyV4ZDWCwQ8ydJPnLJaC4n3Cc3CF5npPX3H4Bk9/LLzvKlGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QG0GQTbN; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QG0GQTbN"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EKtuN6223639
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=AuEH
	nX7kWxd/FJTGvaPpHXaoXjFIOX0QyT6a184ATdM=; b=QG0GQTbNnyHpwda/t77d
	6fq+HVtXWEJrsdQVu/03mkSTpwxi87OUzza7DZOWRzZ+ogd8K9baJGr5E4/tWb4e
	6lxpVsFVmJ1bwsq0f9L3t8DsPQXPwQcFI1/GC4wzG3IPN6Z4xBOdw2JegcVXBtJ2
	mRiVPTwwgvinYm7bNB4L+DwGVyID7zpDDp4tpYpnSpEIp6huYzhGcY3eVKGkfAkI
	PEWyzwSBPHH+dWdOKV2jlvoLTPM+GZyCrXcSX//oNog7aU+j8TUpT7d55gssU1Dz
	fSR5aglc/ibAsYWkIAI5TTbJr7BL+1hneXKgwTD6YLzC/cAqghgylgEbIgNbt6pU
	VQ==
Received: from mail-qk1-f165.google.com (mail-qk1-f165.google.com [209.85.222.165])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dh8718s36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:11:13 -0400 (EDT)
Received: by mail-qk1-f165.google.com with SMTP id af79cd13be357-8cfc61fc9b8so1106517285a.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776201073; x=1776805873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuEHnX7kWxd/FJTGvaPpHXaoXjFIOX0QyT6a184ATdM=;
        b=rw6qqJhRP0zRVfmKIptZtm88WwE+WDOPXa0t84XhWja3iQyL+RYqXzGZ6OopcwKWc7
         O39nnf1aCvcdbUgeauox5bg8EMeeDA5DhgOEtVMKXizicnaNeMe0QjoZbluzBvdZxY62
         FzkZVJfIVJmkYunqA/0LbA85hjaGgcilpXzDbSnc+DeeyQ4Rn260IHv0blF2dwsOMC6h
         lUXRWQbCZINcQGnClK4ni09yscZYU0cmTNU2ia6/vzrFmVM9HTSOo7fUmbdxsliT8Sbw
         d4F5+4c1bY5ElFuRk9cxenkM43XjFCtt3BSC2z1FPbfRpTPmitK0mJOaw3mgPRvIjyXu
         0mtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WTnemuu1dnp6Gw7q3o2Np6m5c1u1w0CL+K1bevSIjedhrB3FG+2rnSbRgjb2PHoFppjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEYiCYJY19eqUYTH6RsDGvc8x6My3t84cmB74fKZZpLBwlnzs
	Lsm5X1mlGLztZcNb0X/C/nNocGWA15cT19s1XNS5Ddi4txEFz51XL8ZscA6HnrZOQTtxuXPHEeY
	rErfi8YffUi8S71Fl6VwCbOMZWnXrZ9BGOu6KjxpwFiaH5fYkhw==
X-Gm-Gg: AeBDiev5LMMzG1Hs1i5O4NEHlz6I71jzM6jJhIA0M7fmvxUjZ5PzE8X/FPAMN4p9R9+
	xZ0kcQjg9tu4IjJf0COw3p/b4U27MBvvVpgGq/+ytwda8/MdeTHrXzlwFg6de9jfDa0+P1ifOVv
	UvdWd3avxP2/06YXxBMpCLawUNo3pjfK5UalSk7TIS7yvTJ5v9dmuztYI8SHwLnWAv+uxyyDK5n
	wRMX3WgBLgoiqWacw0ecWQXFpn7pj9SSBGOKVx43xnZcKdd5BSd++tGDj3jBCpyjaNOl+cCq1Ci
	g3jNKGKTshtjPw3ncOQ/m1Qy80hoxTEIy0pNM1FFMMk/HZHPqWAc6LleBe2Kq3sjXdwMFdTRFOi
	0V8Rfl4ckxQwBpmIaj6gpVdi/jTrBxA/7+udd7PyC8UdZ/f72yen1D7Q7vA9BDTjbGHb05CY=
X-Received: by 2002:a05:620a:31a3:b0:8cf:d579:4aff with SMTP id af79cd13be357-8ddcd602be5mr2722040385a.16.1776201072720;
        Tue, 14 Apr 2026 14:11:12 -0700 (PDT)
X-Received: by 2002:a05:620a:31a3:b0:8cf:d579:4aff with SMTP id af79cd13be357-8ddcd602be5mr2722034285a.16.1776201072103;
        Tue, 14 Apr 2026 14:11:12 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb915b738sm1204569985a.32.2026.04.14.14.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 14:11:11 -0700 (PDT)
Message-ID: <d002a0dc-c54a-4d91-98ce-75154363b7f5@columbia.edu>
Date: Tue, 14 Apr 2026 17:11:10 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
To: Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
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
 <6f40c513-af3e-45b6-9000-c61494a23bd3@columbia.edu>
 <acbd5lKEh8xa1IQk@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <acbd5lKEh8xa1IQk@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE5NyBTYWx0ZWRfX6riRt8lidVjn
 QUunLsAuZM44/w0u3gy6uWb5FgsMKneLpg9FIbiW6X+ihZmuYGKbfZFuV7W3dk6eeu6ENStrwJX
 PagCp1IQ6suzAaaii2S2AUmV7QGSCHKBWuMVMd7oUUawJuWITZ+P4yHpGA18DOQu+V4oeEmr1wY
 QS6WsvfmF7HOQfHS6Ke5Dl5jqIFl3yS6vqV37dYti9XVq7YqCBWN9DDkEDNDAOW8NgHVDjkLgsa
 HAuRcB+rrZGCZNvxTrsRQ9KhG4T5qUZLCA2dieJ3Si8kSzKnw8Hmqe9HtzGdN0t6PYCZIZicvdy
 nJCvvDmw1IZY4cfxfaKkhnj2IdBmeykzgXP1UOjb/uy9u94ZwiN3CZwQd4qA8MTA0jRZoDmhFvk
 RyKqZveOyUdVzofCWzRybFnVQ/RhJzTsjJxjBgfyShI7EsoftVrrWz8WR73FXu/dXd0PJaBRsAz
 0oQ3r3v300+VUep2vXQ==
X-Proofpoint-GUID: i277Knp1rpG2jF64g-A0239tVjeoEwpO
X-Authority-Analysis: v=2.4 cv=ar+CzyZV c=1 sm=1 tr=0 ts=69dead71 cx=c_pps
 a=5ey4wx+Zq7WofmSZfw+15g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=mJhthyEqkmu8OjK3UDMA:9 a=QEXdDO2ut3YA:10 a=Hk_3rHtPZjukzhIBiY5U:22
X-Proofpoint-ORIG-GUID: i277Knp1rpG2jF64g-A0239tVjeoEwpO
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11759
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=10 impostorscore=10
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140197



On 3/27/26 3:43 PM, Gregory Price wrote:
> On Fri, Mar 27, 2026 at 03:12:16PM -0400, Tal Zussman wrote:
>> 
>> It's been well-known in the academic realm for a while that there isn't
>> really a "one-size-fits-all" policy that works *best* for all workloads.
>> Yes, you can make a general policy that works *well*, but if you really care
>> about a workload's performance and want to squeeze out the last 10-20% (or
>> more) of performance, you need to be able to (1) experiment and (2) take
>> advantage of application-level insights. Being able to extend reclaim (in
>> our case with eBPF) enables that.
>>
> 
> This just makes me think going all the way to reclaim_ext and re-writing
> MGLRU as an eBPF extension in an effort to simplify the code/maintenance
> and keep what works working is the least-worst option.

That may very well be true, at least on the policy side. In fact, we
implemented an MGLRU policy in eBPF. The infrastructure side is a different
story, as Shakeel has pointed out.

> But this is a naive take, i'm sure making that interface stable would be
> even worse than just maintaining both LRU/MGLRU.

Putting eBPF aside for a second, I'm of the opinion that separating reclaim
policy from infrastructure and creating such an interface would actually be
beneficial for maintenance long-term. There's no clean separation between
policy and infrastructure right now, making the code less readable and
potentially affecting performance. I'm in the process of collecting some
instances of such overlap and assessing what their impact is.

Now, once you have such an interface... eBPF falls into place pretty
nicely...

Thanks,
Tal

