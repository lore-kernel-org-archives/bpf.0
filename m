Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42444035C9
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538673; cv=none; b=YKSbJUUT9jrQacQjzynDu09s0lzdvZTE2AAwO5RD28/L6drxqeATAawyv33X1vIduMGFAId3D2pIz3/kmp4HD7Kreee5ub9FhdKk7VzddoRRk1tQyS23MwowSITwgLXDYt7g7QE9ygHOYP2MvvIhyc7dj0diTrdvjtvQgoPx7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538673; c=relaxed/simple;
	bh=nT+Xs3xIbIaPyc7WwKRINCLOr1g7D3DJ1PJ9Uud6yaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uafUYx3fzY4JZ/AzBeiF9RjHx6a/J3rNkQL6DMlHchbGkuGu5//CUMxxvVWZVUH0BD+4yo4JuDUyF6re+N3Cy+KEKmvoe4D5NJCN1OuqebQC92mqK78DBCc8dfhGLIt8baY5UwUJuv3LCyNsijkaKusGGuQ4P96zklVhpkLspRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HVV2Vp/+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HVV2Vp/+"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a0ecbc713so12390776d6.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774538671; x=1775143471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bIk59MTMskTJurRtc6jFkcPp9I+cldWKz4vCxcp4e8Y=;
        b=HVV2Vp/+3ivH1JihZueLh21JMGPF9hZB6P8eFpnqBIyvtKD6EbzQqKiZ00nrZkQOec
         ouwxmLDfuSBK3Psp9HnjY21fZSrC/oZEGkLnJjrkxYDtOIS1mHBu66FAr6p0ziuCrDFM
         fHsTd+7fyeMt3RG32oUNUN5RgUi/tIQntAQ0bHHfAZ2A54iD/5stmUAsWEE+A06gS1tu
         xLo2HHXkwftp6cl3EklMUywkcsQVW3mMd1Mz0NdzVxsaAcohh/w4Jud34MgC+H7tuLPL
         7kVi0TLZmCjkxca5hqTUHyaEVNzYajcS5QgkOgeUj8Jd4ABECBwYxRd/4TLeoptm/4k5
         mQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538671; x=1775143471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIk59MTMskTJurRtc6jFkcPp9I+cldWKz4vCxcp4e8Y=;
        b=hPOjW+Kp4TeLIeIscbwO1lRFtVoOU1ZgON70ZBYMPJ8VHgibhrhp2Xw1Ecy20+cRnM
         AvBsk0cNiMWAXqsHjbh+j/3GbUO1Xwj2Cmq3WG45rfGtxtfpB0+aflKf0Vc0KCcPiAGd
         PVmfwuOuYdCXuDb3OMktLYhu8cEq7n4JijeTV2re+Im8eB3XiOl6P6REb1qkKycEdhaw
         phLEyOlxi/MfzUFDlWcC7sPdOBheg8w1Fo068sIc6gfWQ3KSEDkN6M9+tXMNT+9Lw16f
         om2CEb5Yy/w/CEr1BpvlKqXzU1GlcjWwPAr4dNQ06T6KnSmqdBVLJ+VeGmi/tV+DA9V/
         ca6w==
X-Forwarded-Encrypted: i=1; AJvYcCVkK+dCjQyFKF0T9WhikGaWRJAK/h4U5UXCxC4JL0MNevjdlkVUjMCQoC9bfCiWNFR/cZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBn5iduyuGU64s2u9YFWLgHmy7wDTMCgi04g9jtJDlc/Dbnc9
	zwfElat10NTO4pOMAifDjBYpeTeEc6Vh8xMuJwPpSjqSTAsJNQPSfhNipDAq8nUD1uY=
X-Gm-Gg: ATEYQzxfj0t3ZfD/4TRbOviIFHRVzigcf06syWAA33h8kW/nqYHEwJr1ALQpF06OC4G
	oDxAIIfpNXr/bsDLmsKS8QRau2rcrZpKaZmKbp5HB7VTJTyvworI7uiSYsi7iobxXW1Hj5uDZoM
	6gbZppm6V/rAeMd0X62zcXGdmXAOWI30epWa4ZZDG2q80YYnhpEvLj2yXtj4OJsdQsO76JjS4Ds
	yqX/va5gkZVWOM35zutUMRpZFle7FmaR3C1FJ6Eq+IrMxVoRcW5uggE9GFDmTNyYHO6VUAJUF64
	xMqPn4zR+Jl7E6q9hK1GXu9ddr58ja1gTHSGcOBBnfz9Qg6aIDZsHBpYWIv0W99/NlYrXQ3uS51
	NDcECC7BeuvqcraM7SL6sWn4rbadpb101DE5JnqUEblR+CwaH4Z/JOJP58k3X9pD2de3C7WywOt
	TdzvTtG4fFcBxJ0HvVEdq9ISrulqNP2Lc=
X-Received: by 2002:ad4:5d43:0:b0:899:f495:1a17 with SMTP id 6a1803df08f44-89cdde45098mr24691616d6.15.1774538670605;
        Thu, 26 Mar 2026 08:24:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::2:e5e8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd588487dsm27153366d6.11.2026.03.26.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:24:30 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:24:28 -0500
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
Message-ID: <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>

... snip snip snip ...

> >
> > How Do We Get There
> > -------------------
> >
> > Do we merge the two mechanisms feature by feature, or do we prioritize
> > moving MGLRU to the pluggable model then follow with LRU once we are
> > happy with the result?
> 
> Absolutely by a distance the first is preferable. The pluggability is
> controversial here and needs careful consideration.
> 

Pluggability asside - I do not think merging these two things "feature
by feature" is actually feasible (I would be delighted to be wrong).

Many MGLRU "features" solve problems that MGLRU invents for itself.

Take MGLRU's PID controller - its entire purpose is to try to smooth out
refault rates and "learn" from prior mistakes - but it's fundamentally
tied to MGLRU's aging system, and the aging systems differ greatly.

  - LRU:   actual lists - active/inactive - that maintain ordering
  - MGLRU: "generations", "inter-generation tiers", aging-in-place

"Merging" this is essentially inventing something completely new - or
more reasonably just migrating everyone to MGLRU.

In terms of managing risk, it seems far more reasonable to either split
MGLRU off into its own file and formalize the interface (ops), or simply
rip it out and let each individual feature fight its way back in.

~Gregory
