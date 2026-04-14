Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06712D1931
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198931; cv=none; b=C2ztO+LheUY6sROz6LLHeRY+hjrEK0JmUYWDXHoSWItqmRHLG6YBr0zQ8fP9ujd2plbKcMEILv0wIWfKTDLmEEPC8k6Mx9BUFD9SwEEsixizYM2o86qxnWx/6lCthi926Hl7HwWnpPcXF4Uxwxvs8yQw9hQwO69Qg/8t9mLxfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198931; c=relaxed/simple;
	bh=adOm0b5PLKbcD+/RPQsz466lOD3unkYQdbCXBZX4Fb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8oSQ6h1rEFMzpPKVR/AQ1JJQ6aPX6D5IGfrcJmeLw06ScAePjouov/ArvrikNxdWRlZK79FnmtpDtfs/FmaFjNaXPh2xRIPQXrpVSOzfaeBut98H2LsBb57fe4wsfVWK496j5ptBNICAFLYgknxTbtb4QWmCwenSi/hkANUS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lRFBKYLM; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lRFBKYLM"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EKRIf1878452
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 16:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=nLeT
	RRGmHX5BMpVtP+w58//ItyrkZ9dOA8UVe6ev+tk=; b=lRFBKYLMi6M71+q2z04O
	PrgzuYcimOMwgpRqxfzegjL42voJYBu14rD6eghtLednwYVfY1arPN4h3/UUYcWg
	fpyO5gUQMknmKcePDV1qnAgnCGWC1S5BibH7IfdGD176gCMdNha0TKOaqDUMVz50
	6wNzTXwqXBaDcuOnVSQ/Uewn/tKDOMEq0g4RFr+0og+ZRoB3rwUx0zgVtXbSViRW
	JKoq3v5fZzippF3MJoFOvOIH0bdxJ1Ber868W0eEEnugnBkaxL5dZgOYHlU+G+z+
	cY521DDO7UJSxS4hBRY6MxiT6sxRO/2Mb5uQsJLhIxVSXJ+IrvOBMiGFsKLDa0vk
	4Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dh86003y9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 16:35:22 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8dacf883e77so1178178785a.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198922; x=1776803722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLeTRRGmHX5BMpVtP+w58//ItyrkZ9dOA8UVe6ev+tk=;
        b=IlPJh+wESorqrvFjuEDKsRx/N6hSmsVe9olWTeHfsp71EaSvNzEsHDmNxKiTgUS18P
         f+PvMbemFtZuZEsEXxHTMk+9qq1o/1QdncjXApbSO3WtEDJYULSoZ8nActP0GzjZyipH
         1174rkGlmc688T12Kc4XAqGFeHwLzvz46k3ab3Qin/RDO7F9X+Vo9lhKvMsrIoxbMy32
         t7pR+d923ndLre740syj6fYCRU/i67SypmubYopLxZssXMtlL2pt3w92vUn12EeZjpWe
         5A6iT7wpyCGKAgOWep34aRBnVbohjcmmDfRUIrVwDlOavSTZBpIzd6hpWKR5RpzxjAKF
         AfLA==
X-Forwarded-Encrypted: i=1; AFNElJ+9eulfum45Jo0/n9IYh2u3t1OluxvJBNyhF6pgUG5/tNS+wDtYnBMH/YW6/N/eyFGgBRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxidhy18RTD7hAwZaFZpKCjJUTkCb7dpHHVtAy+YJbfotJiL7MZ
	Ng7qzDFEWWQMuEIlB215XmsQdq1xSK8bvS53fQJGnlrsPSSEyos7yWkn2Zi1lh8gaQjPLqyT1x+
	J1Hjb8QfYWf27BcIGlrfZxTqaTvUwWk4V8cFVuVYLz7EnWwNbIw==
X-Gm-Gg: AeBDievT+Sz6EeTxTukRW5naeXSgjflRoBsE2bctNQmwnjT0CuK+xgn+NMcTfQBGL25
	FWNXkNdkNTQ817KbtRHYH+I2J/JMGmhmymdyR6e9tIGkMPtyx0ZDvK+DbjTTZfHx15cBcbrLAC9
	UlhieTVKMTgyXaPSOaxsr0nkBLNrxMr7l7MX/DzLA/KC0f6bSuwbAFJ92H/pZiBAUrCpw/nk7oE
	lDWKWJJ3TvwBFuCClyniam3PYftsewajHL8Or//L0e1qe4TXjov+lRJ5zedGxKQUI2Se5haZLFv
	NZu7rJKtaPKeZAwTZZum/2k2Mrzk9nf1ZzCkjcjvYoNIg9X7fSrRtZRPE1asIVlUswy4ZKcvBwn
	379A5EebGHB1S16qQUm6MbDrxx593caHL5sVBqlMod1iW8Ql0w7ZedUMx1NqAjqcjMUHYB+o=
X-Received: by 2002:a05:620a:468e:b0:8d8:2a0:e17a with SMTP id af79cd13be357-8ddcfcb2d46mr2770767485a.50.1776198921792;
        Tue, 14 Apr 2026 13:35:21 -0700 (PDT)
X-Received: by 2002:a05:620a:468e:b0:8d8:2a0:e17a with SMTP id af79cd13be357-8ddcfcb2d46mr2770761585a.50.1776198921305;
        Tue, 14 Apr 2026 13:35:21 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb915b46bsm1196176385a.33.2026.04.14.13.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 13:35:20 -0700 (PDT)
Message-ID: <7dc54b9c-ba2b-4044-8cb7-b95ce89f1e09@columbia.edu>
Date: Tue, 14 Apr 2026 16:35:19 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
To: John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
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
 <6f40c513-af3e-45b6-9000-c61494a23bd3@columbia.edu>
 <70fd648a-efa1-465a-8e6a-51411dfd50b8@nvidia.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <70fd648a-efa1-465a-8e6a-51411dfd50b8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e402j6p/ c=1 sm=1 tr=0 ts=69dea50a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=N54-gffFAAAA:8 a=tHa68p0SAAAA:8 a=zHSXLxmVE_XwShEkr-4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE5MiBTYWx0ZWRfXwY7IvSzmzMiR
 JbcBrVkWpkZ0eo3I/wtXeoatsnMUMvftb5C8cS2qPfpVNqbGKRFDjYR/D2SCXkOA7jRnSG763+9
 vJtG2f/S4vno7WGfKSRlhxh4+U4vDrec6jXpeDiKtLpW4ibqEr6nNcx7M6Q/Yq6ST8N6kF76nUZ
 u5f2eCGq1zzghafcnissC015iw6W2Vek1Ufdcco2FLCwpYC56W7FDA1Ns+11vVp8OrQ0ZPc/E+n
 rcHKGbZaW/I4OcngViL1FrgJaPA3zPah5+Pjca0vcB+LR8ufOJyoedXsX3gaLuLwhVhHPA22qdZ
 uSNd1s2GTE6ShSUHRjbbd/9ubb7WAkoJFkn0JC1EU6/xnFbMIHT1EFYqPx44PGLIKUVefTs6zo2
 buV4jRsw2XQff+aKOU7kOrx2es1ww700+NK5M3igyl8XmZAE+FDVKHMTslqRIptNcinM22LNAYV
 3s7B+otL5EY08+OR0Sw==
X-Proofpoint-GUID: Ggd-1hEDdSfgjWXJNVEVuhwHmR-soz49
X-Proofpoint-ORIG-GUID: Ggd-1hEDdSfgjWXJNVEVuhwHmR-soz49
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11759
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 priorityscore=1501 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140192



On 4/8/26 8:21 PM, John Hubbard wrote:
> On 3/27/26 12:12 PM, Tal Zussman wrote:
>> On 3/26/26 11:43 PM, Matthew Wilcox wrote:
>>> On Thu, Mar 26, 2026 at 01:47:43PM -0700, Axel Rasmussen wrote:
>>>> On Thu, Mar 26, 2026 at 1:30 PM Gregory Price <gourry@gourry.net> wrote:
> ...
>> Yeah, unfortunately it's not so straightforward. As a simple illustrative
>> example, consider a file-search workload, where you search through a large
>> number of files over and over again (e.g., a poor kernel developer trying to
>> understand how the page cache works). This follows an MRU, rather than LRU,
>> pattern, and readahead doesn't help much, leading the active/inactive and
>> MGLRU policies to have similar performance (~40s runtime in a specific
>> benchmark we ran). In comparison, using cache_ext (our eBPF-based caching
>> framework), we can run an MRU policy and it goes down to 20s.
> 
> That's dramatic!
> 
> ...
>> It's been well-known in the academic realm for a while that there isn't
>> really a "one-size-fits-all" policy that works *best* for all workloads.
> 
> I think that that point has been less clear, outside of academia. In fact,
> MGRLU (to the extent that we believed we would eventually get rid of LRU,
> in favor of MGLRU) doubled down on the idea of one size fits all. So this
> is interesting.
> 
>> Yes, you can make a general policy that works *well*, but if you really care
>> about a workload's performance and want to squeeze out the last 10-20% (or
>> more) of performance, you need to be able to (1) experiment and (2) take
>> advantage of application-level insights. Being able to extend reclaim (in
>> our case with eBPF) enables that.
>> 
>> We wrote a paper about this that was published a few months ago [1]. Happy
>> to answer any questions and continue the discussion!
>> 
>> [1] https://dl.acm.org/doi/pdf/10.1145/3731569.3764820
>> 
> 
> Excellent work, I was delighted to find a well-balanced description of
> both older and more recent history of the Linux page cache there.
> 
> It's helpful to read this, even if we go with a non-eBPF approach.
> 

That's great to hear, thank you!

> 
> thanks,
> -- 
> John Hubbard
> 

