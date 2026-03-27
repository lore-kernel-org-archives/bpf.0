Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94386347
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640627; cv=none; b=c2V2BO7Qvu+Ac0sX3VKAbo+eXYw9Jkbj3oRQ8JcisXj4Ozon016MFtANGHvKE2TDBHc7CvXAdyk8j+QXVkBRmfe8J6obgQphoxFjPkuf7JIn/FWTYLlu/MQzfMtUUF6BSYdlDjlO5yXBLFHBgKZ50sTLbGSzoTHFOCOA6jY02Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640627; c=relaxed/simple;
	bh=u7TP/JsqBOYtb90MWsXcsU2CGL3817VGGapqJXtiP8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix1L/YcpDQwjyBOKbXfzW73bgtkwIJm9tcM/AI1G+1KbzoGYPx5mkYkGvFFH82Mp0bd/koC/TKfNLc1hqaxOZgR0QhtM10ky5SGRDeHk9eYIHP6rglJ2Fxfb0ocXGmgFck7Vajf3XCIwK4jxmy+ocTy+XWIAYi8Z+EFOQfwbLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gnY/o/m2; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gnY/o/m2"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a05955720so29378406d6.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774640619; x=1775245419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ycsjbas8cC1Onl2FsApYb1y1z6bcYUHR+E+PGpMszI=;
        b=gnY/o/m2Dt2Ylp705PZQGa5v0M2M/AM8V3tzBzp/stnBp/jfNtfPONjIbtUZPYRPDN
         WJZc00SefPAWU6rT1d6BM1DxlMjkMcJFr300wqrm0Le7ilGX5g9AZv/LSZiuPn/VOeoz
         EUeioVu5B7v2qq4BH7L5HE79CDvhyDBl6ozYJijOCVi/FKY6nC6n0W1e9R6fkTqF37A9
         KNOUoeCluuKovReVOMB/vGR11F+hKFpniFPNkmhRaXoyn1zM5oRP3DbWvWbzWAF9BMZ6
         xo83wCh3IcgnIVQANyudbJqjZDr7SZo/jo1UGWYOmD2cbFa2qR9jFk+wzOxRbfxEpG/Z
         ABkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774640619; x=1775245419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ycsjbas8cC1Onl2FsApYb1y1z6bcYUHR+E+PGpMszI=;
        b=Aza6Aix0FOmYa+FOgK7oi0gtOQLM1QG8/ba4BEQ91k3w4InQFgWJedT1u9mjyWjujH
         1n9caBwMCF4Pm2RElm//11cbNnJFXaXxOM+z1brhnIX8/Y2eTNe5yRWkth48XcdzOz+A
         1N+3KgOKweTBmdNxzaf/bbaYgOIhLf8jVhXCNOtuGbZFdMKpjVHbncPlMDJSe8zjJSk6
         RCOCWkp5PK1X/4V62W1KU4suhxSpgPRmXsHXH7AZeqxEuXtiQsoVuz0cDb6H2B1dZHIj
         LrXLybbQd5LymOflTDqq5eDe4kTX+kuw3yF6nrnHXgbR/jT8wxLEbYDfKNH5rgS6/idh
         r3tg==
X-Forwarded-Encrypted: i=1; AJvYcCVKaqyD0JYe3eLkE84DKTAJh4s3Gocit32YAjMeBzLO/uULyEJYeh9SnddqYIGh/r53U4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvg3flB0Gsb/BXILvdnKxqpTmKe7ouiugqbWCBh3Ya1uQH/Xjh
	U5DPDovi2RnQUK/SpUtLtI1g+jZIA+8OkqBRxKJR7ZIOpTeIxNaBWJ1uKU3AVoBz2Ys=
X-Gm-Gg: ATEYQzzvuHIoqu6Opel+e6TKo7aMl2wUxYJvi5GzXP3ghxQVT63nWFhmBvGxPKjYNUJ
	vS2tKiTmXE3zBIISxgIO7x4Ur3RP4p/jo1nSIAXTdfOsUZHEycRxrd+zPWq810IUCkRibEKNeDg
	5HQea30CcVEiITFt6ykvsiY1/zVzGQAaqgAH6wRhxa06R0beQ3hs5arYJPLGnBTtI6JwIG4j+l5
	f77iENFGcoPCAL/0MnwvjIVRoU2uvMF+IgM7beuMQViVzjMnHTS/j44QcQHqdY4IdyWlsqqTujS
	6BG9LBWk50A2EGZr4X79SkM2ZOl10L5MH9cV80vlFhYeSe8bB5bSrpiK4LoTykFSfvAmrNVf7KX
	/9H4vy+I0qg4LW+2alytybYug4FvpKCDEqm03HdqH40Bwk27wlhcmciL6e/Myk0/M4cUmlOcUMu
	IcMN5JkUcVLQwPyULYNbL9IRB+Gt+dzCPG5UTJYOxa2BwCRfwReSbYPjybmse5gVA2tXRn/30nc
	S7V
X-Received: by 2002:a05:6214:4901:b0:89e:a170:6af2 with SMTP id 6a1803df08f44-89ea170721bmr11920846d6.41.1774640618959;
        Fri, 27 Mar 2026 12:43:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (158-94-182-130.mclarenap.oninferno.net. [158.94.182.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecbba4bd0sm797206d6.11.2026.03.27.12.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:43:38 -0700 (PDT)
Date: Fri, 27 Mar 2026 14:43:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Tal Zussman <tz2294@columbia.edu>
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
	Alexei Starovoitov <ast@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kairui Song <ryncsn@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
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
Message-ID: <acbd5lKEh8xa1IQk@gourry-fedora-PF4VCD3F>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
 <acTaRgusrxfCoKqe@tiehlicka>
 <ac05d923-7871-4691-8d26-eff41b3a3db0@lucifer.local>
 <CAJHvVchSfGDubPhir0SgZfr_BcpN5oq_7AY4AZ587_ucgY4Apw@mail.gmail.com>
 <acWXdvHx9mYqvT2w@gourry-fedora-PF4VCD3F>
 <CAJHvVciAmX9OFLBSahwvXL=E+3xnDsL2aE4WKfDBFqaT1Gu+Qg@mail.gmail.com>
 <acX8_XMQYA0-NGUW@casper.infradead.org>
 <6f40c513-af3e-45b6-9000-c61494a23bd3@columbia.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f40c513-af3e-45b6-9000-c61494a23bd3@columbia.edu>

On Fri, Mar 27, 2026 at 03:12:16PM -0400, Tal Zussman wrote:
> 
> It's been well-known in the academic realm for a while that there isn't
> really a "one-size-fits-all" policy that works *best* for all workloads.
> Yes, you can make a general policy that works *well*, but if you really care
> about a workload's performance and want to squeeze out the last 10-20% (or
> more) of performance, you need to be able to (1) experiment and (2) take
> advantage of application-level insights. Being able to extend reclaim (in
> our case with eBPF) enables that.
>

This just makes me think going all the way to reclaim_ext and re-writing
MGLRU as an eBPF extension in an effort to simplify the code/maintenance
and keep what works working is the least-worst option.

But this is a naive take, i'm sure making that interface stable would be
even worse than just maintaining both LRU/MGLRU.

~Gregory
