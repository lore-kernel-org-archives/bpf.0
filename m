Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3B401486
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542777; cv=none; b=LrRpFhaLsFtCdSL1t2p4rENsapyNbbiG/WMYs04BgV3Ae5zBv0BGbpLFR7FlqF2h55hOXFrxykxEZ2K6s5JOYZuUImre8X+ZHM8o5bI1WekOvNvV4vNIYyGG1hM5oLyZj+hsmfaLAjmClbfghDJKNZYZONfLdUyk2wb8dQvL2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542777; c=relaxed/simple;
	bh=dIto4muS7UcOqUig2ehWB4I/BI+/KjKt9hKiiyj8d3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt0Cs2zNQt4ouyLDp3n8qjYYYq2qHDCbuppxTXO+/PduPyfL/8OIzlTsuYPW/jPg5Qk6GoBFqQhoA/ykQ0myyveSetlNs8yQtg2GBf69eo0AHZVDZEwn9X++Cky7DEZiGOPqDRtcsOR+JaMAR0v3U2hmaGaOuUgb9Uu8Iw9jCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mzfNV+3/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mzfNV+3/"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509006c070eso9790841cf.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774542775; x=1775147575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kHkYNyleapDFkY2bZJbLnQJPE0yLAnN1/4w7u+RW8Y=;
        b=mzfNV+3/gn4OdUictm2ntDVIa7w0tH/Nx8ARendfMc/NUayxlcYdI9ECGHLjh8KQNP
         nh/WwcN4/yaKpQeKxWUZmK9QJqoQLN2Exe2shZDKN1VNu+V+bGPS3ASwhjsQwkIBI95g
         ei5Ou99QlwGPqQyGASHKfa0BZtYszBnitEhdXYCjESaDEbVGYX4Pc6+7ul0dQ+MfdvnT
         EGqS01DW8tLLOgBBdhbeFobVEsWaTWS9hofkVTpDxqD8Q9ylZowjPeaoPeD6q5+mCTx/
         cb4y/tTleCAdmCVNL2Wq1I4GA0IDfLiR8DdwE2caRXPJdk+lW9kBFvh0hzJW6u7Uqou/
         E3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542775; x=1775147575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kHkYNyleapDFkY2bZJbLnQJPE0yLAnN1/4w7u+RW8Y=;
        b=Jjo/6429Oir8s0vVI7COaNYCFxIs8OqUED3WQUu4S3BPBYNu47RP/gpbdDQzCqFp5V
         fBD2fBRQ/XtD8wSYWuw5gCBHXcyI9pAYBa7S095QpzXRpqkX9IcOv+3yqTwvCvQg6qjy
         ZKyT16EY4v+265aMwTq/tQanK8ii9qzSc9mboZ/jFIWxKJN/Rc4bgoMrE7qhrGUeIWIF
         eaTAVxxB6OxfDWBlJdqtN3Gkv/uVTO5guJtNlEXTpfxch2Rw+xSMndx9sFw+G3sswM+M
         Mhbj3ZgNS6NhLNGT1kjllEiVmb0USJLFSDa0CVTym8e0eu3YPfdjvZCyuUksM53LbkYf
         qikA==
X-Forwarded-Encrypted: i=1; AJvYcCVQClbTwx5K2Z9WGlJw4p36yeZJzxewpjm0XaPwIFIGW/esvEsxDOoM9/UrVFdya4zXVu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQnXnnxo7jT4vFZZZ3BpG5tjLSxU6Z3XANKhOSdxuheykE/4E
	la12/MqvkDRDKbq5GcINWN4/AaDCkOCXtOnbBCQmOzCzygKV35IHDn/ljbiu8EQPzao=
X-Gm-Gg: ATEYQzymcfAbawhEnJPAypJVOWopfchGKWLvDcmanLRfYUjLg2RNOgd12X40oI2D4rc
	l9illwvK4U8pAJV3BCx7BYI0zxC5sbYIyu1WGgAaoG8EGKgOiHT0G7pjeJZQmp5YFaHbAks13xQ
	0aCvAqrKKcSSPJEwFUYyNdbpm7eyWedOhVj5JKGOyLqzbe+ZXF0vpW6VqDvM94cFKkgU1Z29T/1
	sXtzLlGJy7uS1u+YK+pQJCmxh5plB4x4Yauv9vOihlelH1ZhG93AsAhIwC859ThJZw9Q2lRJw9q
	H4+Ke7fiAYHtaAJOd6Dsd+K27yiXoYGI3V3M//q0qwUI13FLoWFCB4Vde1KIrT3hfJVkcjkbQaz
	KrgEHIqV4ToG6ReV9wgQd1ed/gtYxAhiB13J0ziTWxX67tmSQV4aOaVyMZeuk6b6wmpeDYDnJnf
	gv+VgZInclVK2aBnIaMxFa
X-Received: by 2002:a05:622a:5c89:b0:4f1:b714:5864 with SMTP id d75a77b69052e-50b80acc65emr118120631cf.0.1774542775296;
        Thu, 26 Mar 2026 09:32:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::2:e5e8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9216e5dasm28216811cf.12.2026.03.26.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:32:54 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:32:52 -0500
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	lsf-pc@lists.linux-foundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <acVftLYT301ITlsO@gourry-fedora-PF4VCD3F>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>

On Thu, Mar 26, 2026 at 03:35:28PM +0000, Lorenzo Stoakes (Oracle) wrote:
> 
> Maybe a stage 1 can be to separate stuff into another file, because that'd
> actually be pretty easy to do for a fair bit of it, surely?
> 
> Can use mm/internal.h to handle stuff that has to link one with other?
>

Yeah i don't think we absolutely need to jump all the way to ops right
away, and splitting into a new file would at least give our eyes a rest
from the ifdef spaghetti.

~Gregory
