Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9092989BC
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202687; cv=none; b=VyL8WgdXkQv7OaxslDGqZdfsnBFQEd1zfXmIgMvokw3AqUXr0mnsK0/ctY2+gMgWHLVOnVna9QX8PmPiKpD8im/0stsB2znKU9MqT8ak3V5EI3+LLlvjxdel8ZvX4bX7Gj+a6ph2CCpLokTtK/mBkRcr+lrYa3tpEp+t4wS/KKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202687; c=relaxed/simple;
	bh=DEFSS2q02pWP6UUYlrxXuu9KfDptScqFb1kgIJb/BJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNBxUAddWHdNkJnBG6UFnWdzuhOTBwHVC2uiJ6bkHqNGDejKlCExryVe+FACrUAgywvddwqh4Zv00wykqJKIVH7TxqDuVGXJ0uAf8Nu/uPRjYFsvqv7HSPRdqbh1vsGadfeO6T1Gaqhtg3LmaZNr8a0853fZMKAgVOmARfdrLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UenZrEk4; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UenZrEk4"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ELR7Kf935473
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=OB6p
	idPOLogYNyD7EEIfdqKqbTJQgvZ9at6gZ/qm2j0=; b=UenZrEk46SZcHtFJ+Nb/
	fAr5m0bGK1fniVV7xmiFAY040zcT8vaHuwvuxVxJrMYbQ/zsRlyiKAxBEhoVHg0o
	6qwwUwYgH1AfiKYfzAnxuDCVaYVjtRtWW70Z+A4DcgesmW1x7yjUeBzDwCG+PlnN
	CwvWMCtVMNCc4LTK/Nr7dsBDSjiv43QXfAn+lmv02jmXdearK6k9/eFjW5J2slFu
	H4AwoG6CxV0JL4H8uDkYl61V+5TT1hbMUaz2d2SMV96nL7O9UVaQXJGGDrwa8eHw
	wQoPgrbOctjF9NwG/8osy/tOG/ldJv+/bMH0NL+ep2pzoH0QgHPCwIbWMMGZVtDY
	0A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dh873rq4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:38:03 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8acaea1ffe7so81678026d6.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202683; x=1776807483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB6pidPOLogYNyD7EEIfdqKqbTJQgvZ9at6gZ/qm2j0=;
        b=gUFRd0S8EmKYRqr0Gsy1Z/LfJ5cBEfD4X03FnpZKS92/2YDLBqeSZziBdFnBpLDGJM
         NABIgqsaL8Ws+cve3Qb1DZsTWVGmBeeAghGuSE3ewLaxAbz/uJdzkXhpbjUROJC+ATcN
         LuR1aQbomhMtRnlTETUZKOahzGQZmgrA+E+NQ6L56jCg7ancIhK1fELsc1PZB1QWGaFt
         XMbgut6Ect5eVJhM9hV44sb2Ax2fgd7FTGJJ2Gt54OXMcog/8mjxkhrpBud7OsfBY/c+
         1Sku8gj9hFiDRTt51CoB1FsQI8dHdkI47MkbeAd7ZMJT8LyS0vVpUB+pypi/YhiH9Dqh
         N2zw==
X-Forwarded-Encrypted: i=1; AFNElJ/sMZV/h25oGrpWI8X70OvdIyRfi53dpNk0npoZGZN3Gkq9Xur7rj0qsnSSEwws3R41WyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP462qUS4oN2nPuX8npTxiws7K+Ecrb0BoIx/76wKaaEn+NmEC
	J8quxznchOnAeb7OIMIVCpjMmcJZV6QJ4XqIxFgWmK1f+vrGd8tOkHvqdnx8tacvC/gVIzBcRlu
	nU5ux/c8cV5aSK6ySW5JzRF17PIUlwr4JwmKmKzUQ8h41ilKWvQ==
X-Gm-Gg: AeBDietSCR8iJH8zEFjcGXbfTPLrVzCSc9xU98XdO+UDqwj7NNC+7vtiLIG+Bgpqtmf
	rPRjjeP2W5bvQ+mTGPKL14S8g4jJr+gqricmNqi9kdAfQzu2Ne8LoNuhNgnhO1E8/tjMm6xHAbE
	Yh6a8OF0gnKnIZn2WqHuofJeXoC40tYmTpIDaSqYmooFadUeKqU9XIxSk15qMoQBj/tLH2/uWJJ
	QViqnG7aLcpVde3csi9a1lirIP//YeqGUeKewewxtpouKBLrQgT3r6eeCCC1MB0aZTE1HrdnTXl
	Izfjut0U7JjKP40YvD26bgrQ8f7Q+Uk6Riig1I/PpTn7utIKqbf/wgmDaHgLNjeOqZv9FAUAe6l
	nBzPtS353kVdYhdqFLoip59OUhg3cAH6wZ1MYFTSCimVM/j0PasSGOlQIFSmyr4cu/Kx53J0=
X-Received: by 2002:a05:6214:4905:b0:89a:1364:1027 with SMTP id 6a1803df08f44-8ac8617efafmr306359506d6.14.1776202683053;
        Tue, 14 Apr 2026 14:38:03 -0700 (PDT)
X-Received: by 2002:a05:6214:4905:b0:89a:1364:1027 with SMTP id 6a1803df08f44-8ac8617efafmr306358966d6.14.1776202682633;
        Tue, 14 Apr 2026 14:38:02 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84cb0474sm132012676d6.40.2026.04.14.14.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 14:38:02 -0700 (PDT)
Message-ID: <5c1205ec-cbcc-4976-85d3-0643083bfbba@columbia.edu>
Date: Tue, 14 Apr 2026 17:38:00 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
To: Lorenzo Stoakes <ljs@kernel.org>, John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Gregory Price
 <gourry@gourry.net>, Michal Hocko <mhocko@suse.com>,
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
 <70fd648a-efa1-465a-8e6a-51411dfd50b8@nvidia.com> <adddpxFfWIO9a2Ih@lucifer>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <adddpxFfWIO9a2Ih@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XOcAjwhE c=1 sm=1 tr=0 ts=69deb3bb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=eZBIlsz9hca5io5qbP0A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: b3vaMeNibCSf51mxR9-PKV9BwgSkVv2W
X-Proofpoint-ORIG-GUID: b3vaMeNibCSf51mxR9-PKV9BwgSkVv2W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIwMiBTYWx0ZWRfX2wpc/1piBTcz
 j/9eekn+llsnvvXPiHpc/vuIt2li8f36Yw8QiJPTzjVDQmh9GG1RfP7qEWygXxBv45nCUQFmoqk
 Tc69Sila9hA8C48kmPuMUcDD4XM0a0Oq3UusgAC+wW5ziUnokyJTjoD2RsNXCB8Dcy5WNDKQL2z
 4XI8I9d98XFXqLLN26LYmWmIDP780Pj05lczBaicXeB0nz9PJGG1Hmushh99Nlk2KGoQxCwh2vQ
 7iC+P4xHd+qwpR5fgbwpb5XMVSMcXDivoWYTDdM8Hf6kcZM1Z+b2/H/xWf6KpL0iBjF9VLdUVbp
 akSPe3eaYQ2xB5liTN42WFEIB9zbcEJzRcJnhGgZufasKICTg/D3Ekrp2rtWd3UnjKxB3eR0DtF
 ZB3I+D68+5Kp1c28ranrnvD9kSj7C58yjHborINcOJ1jttzhNqPrx4Jmaww++Ydjy9jw9QFN7DY
 gUeDBM9s4PCwIKoTPWA==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11759
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=10 lowpriorityscore=10 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140202

On 4/9/26 4:22 AM, Lorenzo Stoakes wrote:
> Yes, thanks for that, it's interesting!
> 
> But I would say for now we need to defer any consideration of bpf being a
> thing until we actually get things into shape in terms of improving and
> modularising the existing reclaim mechanisms.
> 
> mm has been far too keen to take features without paying down technical
> debt first and it's been very costly, so before anything else, we must
> ensure that reclaim is both long-term maintainable and maintained.
>

Completely agreed that cleanup is necessary and modularization is a big step
towards that. I do think it makes sense to think about what eBPF would look
like as part of that future though. It would be a shame to do all of that
modularization work, then decide to integrate eBPF later on and realize that
we need major changes to make that happen (but, given a well-designed
interface, I think that's unlikely to be a significant issue).

> In terms of reclaim bpf as a concept in general - reclaim is so very
> sensitive to even minor changes, and I fear that people might find
> something that appears to dramatically improve matters in one scenario, but
> end up with an unusable system in another.

That concern is precisely why we implemented per-cgroup policies. We found
that running each application with a policy that works best for it yielded
greater overall performance. System-wide policies may need something more
generic, but if you can make them more granular, you can specialize more
without running into such issues. This was simple enough to do given that
the LRU lists are already per-memcg, and eBPF (is about to) support
per-cgroup struct_ops programs.

> A bad sched_ext implementation might result in poor responsiveness, but a
> bad reclaim_ext implementation might result in a soft-locked system, and I
> fear that it might be quite easy to do that.

Anecdotally, having implemented about a dozen policies across dozens of
workloads, we never ran into a soft-lockup. That's not a guarantee that it
can't happen, but with a properly implemented fallback/watchdog to ensure
that pages actually get reclaimed as necessary, this should be manageable.
sched_ext actually implements such a watchdog to kick out misbehaving eBPF
schedulers.

> In any case, we can look at all that once we are in a better place with
> reclaim, which Shakeel's proposal focuses on and I'm very much in favour
> of! :)
>
> Cheers, Lorenzo
> 

