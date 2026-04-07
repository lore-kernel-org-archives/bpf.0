Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308221257F
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775587079; cv=none; b=MTn3whZ87aOepCf5kzbiQAVsjlAXduWDYWadWxXb/2OvHxkD7+VoMkMzqiDUND6nerZR0yl3cME7BntXDckAeXhkQmcuqfFm/7MVAmAZZRg7cZ6wcQP8svbTUV/ZPCQjEmM84tj/ZTSnUXf4W5cE7Rt7CbznKMY57eAHLRYiEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775587079; c=relaxed/simple;
	bh=sFvbOoIQtPB8w4vjDrePJWVXlSv2qr5emH/yoWOftdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/bMz/eHrCmnudY7Gb4IfG1cJtyK+WJMaNPFu1ea4orR1FaEEWzMHXuURmaZLS2gdv7oABZ+Ixv2p7zJIytzw6NEdoKnNJyDlsrMj2q8XgxkRmSu34p5qCVX/E6BY8LHPczVpOwwryrXe9b0t7DaY94pZgrU71WFVJS+UoM3tpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dbOqKJf9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dbOqKJf9"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfdac74050so636439685a.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775587077; x=1776191877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CryZz1quunkh33nabMDcABtwXOAm695UMpux3s9zQE=;
        b=dbOqKJf9qaoApmW4ztY7WYAXl7SMz2cJKD8KEcF7tW+fOpErfRrtXTrNWpuDL6Wj3v
         Uzm6dJsESjJpeqeAs5znZ0FVvyUfAzCP5+rMrNdD7blYzlrUq3I1K7/tqzs3SMeEHPzt
         Vnga7OfzD/E7ZgTfd95bhU36rMTcduDsHJ+tIaXAdF6Q2MQBwaZKZnOxg2a72zYdiLVK
         mnVMRsyKBj++NAB81d+kH1D1RxpHGIZxKHtKqfKbReDhukR5f6Kbv5k0tJfr88+/1mkO
         RY7lcKRMVkMG+DCM3ehD75w1XBBEWL3ZetxZLBP3gr6F7u2aZOG64aLfWsLqDHqoQQQM
         XHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775587077; x=1776191877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CryZz1quunkh33nabMDcABtwXOAm695UMpux3s9zQE=;
        b=GtvGDxTlhjeLFUB2El6NM0nz+XVoC79zNAGoY84BZJQsluIq1sMcMoAQ0buOHyVwzo
         r0tjrbdLL9EOmntXbArnyBz36DFUkfWz1u99KgQPLAm4qe/qi+/g7cXDMJjlCspp6MWy
         VZ1oB5g1DPv+b9Rt3e+fwNnnztgQBRBoKaKc2OnuCHMYFgoFfXNBbSZh/VMGPECfbdkR
         GwkRkyRnIAXxh+n1GqVN2+pxfb5vGaplNaX6YDQId+uuqxBD7zf0Ig1i12o6BHSx2e8l
         YGwKk6FgE02aT3V5cD69Zn5NG8XXq2ORzMzkG6RzKM+zTnoQrgjonci41MiRSkMO0cYC
         N57g==
X-Forwarded-Encrypted: i=1; AJvYcCXNVF5pEVjPA7VmbbHE5Xa0p9iCHfX+9pMNSWjhP8EZhlfzLUe7j2bj7gi6Bo/o//JgDi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSRogx/awsduMd6BdGlyLmqvIWuGfvTb7Q/AHqahfThiDvSgU
	S3sPwFH1PmPUCNChTOVStoYoIbCKPCPWnn0Kspi22VVc/1hY0myyXJQ1knj4mrVJ42Q=
X-Gm-Gg: AeBDietsWIvwoJOo4Die5ZzLNqVywDodzCOM34/zCj/BAoestTZ5tmMYnimuLwospBw
	qMXR1NMviRj82xqoA1oY75N2/ZbGwbLIvjvG1fc85a2tLQ2nMwopGlvfziZgyvvofsrukRc02/g
	fCtnUh7C2G8vjWCfadNy3KBPiyR0hS60zrFy4r3EFDcLoHp4DzMVGOU1ZCO+AnI1KU7XAOi2tcJ
	lUj5BNwTGAAHg2z+FaZU7SdoqNnflYD+y0FFnsLp5haFSujNEaV7ifdecRM2hs2NjnX9aLEcbA4
	/gJU+1ZZQJEAnzRtjlKjn6Zdxm75kGyNe4o74fuKoEMtBORX+qtUwWWQCFiQUuMjy/rUa9jlILX
	PPl674xvY/zkURqSerhDj48mRYx3kvguaO6LC+eS9lqoEPiIuE2hO2K8RqWGa8z1t+s8p6lAEYf
	teEiU5c853/6CzT3D1Fhb+yjJkWiW1YhnyVFaqqDPHI2D+rT2k4LIHeKb5evYiRr5Eq80VvDaNN
	lvj5J3JZRFCpPEiyNbgjXU=
X-Received: by 2002:a05:620a:1a11:b0:8cf:def2:c356 with SMTP id af79cd13be357-8d41b9ddc4bmr2656844185a.11.1775587076669;
        Tue, 07 Apr 2026 11:37:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5c5cb5csm1368806385a.15.2026.04.07.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:37:56 -0700 (PDT)
Date: Tue, 7 Apr 2026 14:37:53 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	lsf-pc@lists.linux-foundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kairui Song <ryncsn@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>,
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>,
	Vernon Yang <vernon2gm@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	wangzicheng <wangzicheng@honor.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <adVPAS4PP7wK0Pxq@gourry-fedora-PF4VCD3F>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
 <acbgIKuwDsPvPjdF@cmpxchg.org>
 <adTonuzmUc2AzUhp@lucifer>
 <adU3P9fk8h-AmEp4@gourry-fedora-PF4VCD3F>
 <adU8VnzlLw9JUHB3@lucifer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adU8VnzlLw9JUHB3@lucifer>

On Tue, Apr 07, 2026 at 06:30:55PM +0100, Lorenzo Stoakes wrote:
> 
> > somewhat trivial work these days via <pick your favorite LLM> with
> > reasonably well designed interfaces.
> 
> Though to be honest, I did ask Claude to do this with some code before and was
> really impressed with how quickly it came up with something.
> 
> Buuut I've generally found the code LLMs produce... terrible? Really terrible?
> So I think you'd want there to be some level of human improvement there.
> 
> And in any case, maybe doing things this way will struggle to really represent
> real world cases (lock contention etc.) but OTOH, being able to simulate a high
> memory pressure environment with certain parameters even without [the rest of
> the kernel] interacting might still be super super useful for diagnosing issues.x
>

There is a concern people start looking at these tests as signal for
performance regressions - which is neither meaningful nor useful
(unless you fundamentally break list iteration or something).

But for trivial cases, you'd at least like to know under strongly
controlled aging and reclaim scenarios that anon/file memory is
reclaimed in a balanced manner - just as an example. 

If something breaks THAT assumption, you know there's a logic issue.

Likewise with comparisons between LRU and MGLRU.  It might be easier to
identify the behavioral divergences that way.

But i fear the whole page-table walk thing makes all of this a
non-starter.  That's turns into stubbing out like rmap and such.

~Gregory
