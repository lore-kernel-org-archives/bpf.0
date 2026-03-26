Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAB39DBC6
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557051; cv=none; b=r4DQMufwPkiqT380OzhkB5TAbi2Yqzi4Oym/5YYFOJ4YDXlm1P/H9Jyx2Bz2yooRyetuJlGh6oM6oPsNhcdI7S33U1xvyhyH6qAGoO0j79JJ/JxwLqpgu48tEdUL1lB7fETll4L72IrOPgCLQUEE7tWjQUA/VJMb/QjzaRPKH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557051; c=relaxed/simple;
	bh=MFuStYaTciGnTN4F0M0soWQLcMi2bMJJDLwUQ3uHv68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQsQclhwOjl8qV+3I9c9wQb9HJ+8u736oXOnG7xx+rQZCEm5cNCpgPTOuNaeXR01vittwiruq3AYEOTybBRO9ugxBYPZvWlQv6mrI+sbiG2lYET6bqeIao8WuNxsUk/0u/0RkY+MDih99OsNO3sDLIJB5qI6qIJVZMaNndVT/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qZbivxfQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qZbivxfQ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd7ecedf2cso158269385a.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774557049; x=1775161849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtpETcl3yk6gc9JzFTgqg++pyqjs/XxnbLkYQgCVFgc=;
        b=qZbivxfQ0kZ3LWINeIp6YXOjb0UO4V+Sx61Y6AV5ZpPIbVPIp1G0JjqaALutilNdCh
         cGyXmJPqswiUxXFT/KHy9pmnOT4MP0cxGvywoN+UsGLXqsADkabZl/7z1ibwaWogm/yF
         d6zndqU4tIOqGwji/zLv8EQYYhyvOSebu4DiE7HKGIvZApSR3XuIfpfepllDCP1WBl/l
         qn9KQTucpKNkfEt6CNJS3kohOamugheE2aKH+39r8mbCfr9Zv34Hvu1vGKMSkqBdU4oz
         iVjJav2MFNK5f22hrU+bF0hOwDmSK1VBPR2c34kRpn2ItE720zU7qlDx35pAaFsXnNRG
         gpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557049; x=1775161849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtpETcl3yk6gc9JzFTgqg++pyqjs/XxnbLkYQgCVFgc=;
        b=pNELPIp5wbl0D7SadLd9Eok46zsqwOHEQeguI9KQDWiiFAyHMwt2DWPU5nxGwNDErU
         Og1xZhgP5xiZ2U8P86snr5GRetyYEsE7j8LpJoqjSIQ+biTqRZXur83ghvGjVc/ROsF6
         YTfKJbz3Wy0aWMh4CmBTlHNhwzRFB8D+PWGCD7Ru9R+HiLIVl2bDU9jiZxH++4wtbpTq
         9z/uQANlkFPcS6PrLC/BLE55ZqMuPlBX71nNu65ThrzAzHJ2EM2FN0J68yI0CdBGRx/k
         s04IBraI2+ZMCsa5JLzbbmP7W2t2Bbh5PwFY8y43vD0fhwgKj4Ac4O+5/oeHoc5losd3
         kFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtYQPF3rR7C3tangu0onJ5L6ZmjIjwRZgZipVu5wSRQaT1kaotEwHWaRdi0qww1d3AaAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BgYhNIlfJxV7EjA+NCeZ87KNayGN4FrUCjZdkh+OygaZLWAi
	ht55pSJrS3p/V3dGD7Wup7T9Vmgpd65x0uhxlr6s+WLhh2Q3vZnkVo8iZLStOvysMS8=
X-Gm-Gg: ATEYQzysAa12LTqCZKWys67+KTxM2ht9K5omAFWNgot6x/CNQri2TZ8T5Kukb0eht1x
	Q+MTm5SLD854DQ6smMfoppFfq3UK4mSme/A9mMpiZ4Vqis9d9Y6SANB4KjLRP1ZksuoFDNmeYno
	oF/ck5Vkzdrq+I1OueMegicY/nx40MubgAmZ/x7K6U7GPU9wMllkcs+6ZZEFnP2dg+ErTSg5oOD
	Ehlz5VZn2DA/7OtIZL+9vsnHh3qEnDraBWnEYcCv07S8mCpqhgdL9ocdvCMv4g9wHl5vj+phTOs
	FOsdgWkLgaXEr047fAfjp/1ei8wNm/8gOcJBBUFDDHA5I/anDta42R/8UGFkX6n6s5W4TA1Ss39
	NsL8ezgjaswRpfBPbUGHVzE+yVbhxLuVMS3uSVTP+Thtl54yJwRVgD8ZbE4elqaYpDozRw7c5O7
	nOia+xtyYMPzCYqwqAKafL
X-Received: by 2002:a05:620a:198c:b0:8cf:d804:4567 with SMTP id af79cd13be357-8d000f20fcfmr1253345285a.23.1774557049133;
        Thu, 26 Mar 2026 13:30:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::2:e5e8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4ca250sm323370585a.25.2026.03.26.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:30:48 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:30:46 -0500
From: Gregory Price <gourry@gourry.net>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	lsf-pc@lists.linux-foundation.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <acWXdvHx9mYqvT2w@gourry-fedora-PF4VCD3F>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>

On Thu, Mar 26, 2026 at 01:02:02PM -0700, Axel Rasmussen wrote:
> 
> I think one thing we all agree on at least is, long term, there isn't
> really a good argument for having > 1 LRU implementation. E.g., we
> don't believe there are just irreconcilable differences, where one
> impl is better for some workloads, and another is better for others,
> and there is no way the two can be converged.
>

I absolutely believe there are irreconcilable differences - but not in
the sense that one is better or worse, but in the sense that features
from one cannot work in the other.

> - My sense is MGLRU is "close", meaning as Kairui said in "average"
> cases it is substantially better, and the gaps are both fairly narrow
> / edge-casey, and very solveable.
> 

This is a really, really bold claim.  So much of this is workload
dependent, and LRU has decades of battle-testing while MGLRU has barely
been around 4 years.

~Gregory
