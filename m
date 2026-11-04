Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774564;
	b=lfy6r2OylrWTjopLGFIvH/yRb515zfjOQDKvHXRJ0cMwyutIyfVMozRGe1bRRWNq7Aq/
	 KRYU33Jaz3ySd1x8YDrRktn3R/OZwktP3XtcFd9xrxprLnz4sl/txZ64FhSS+J2hxOtFL
	 1yVQxv2oMWLbuolnCVbFET1JhRCn5BqIC5/dEaKHT5dbZBCS56J9yk4gHxXBr5SxzGY5F
	 LwIctC4SYyoqnka5oYFUQ6X2yNxjJAJiCZWHIhQIRARN79NTumTYbO/lJHRAWvDbQJBdq
	 IuPeGephm62zidQ0dqRaiDPfZgkq7c4vmDPlnB51kBbWVd5e8hNry8Bwmn3sJdWWruA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CaIA/Sr2kiTxJs6D9LfjF0iFIQjHh5ZBby7zBRLnjyI=;
	b=rAsewnx7v1z8o42dRZPjNauB1fmMXkXjaMxPWvKW8ibBwleyZoDvBbheheUJAFKWh1xY
	 dLw2HBFLIe5S4h0hAmNSaPqYkeyZBxX7rM6CJrQ+GnB0+b6JWUI/OQT/uRIgpTuNpAuFX
	 UJK3ascwo5zhjeBumdRnwY8g0IjHxGRxe8C67E/27a14j48Snym0IVoaw74DHbZcTvdO0
	 LXTwDRubd3sjPA1LWqp9LXFgZVlVuim7YTc2dLZolszwFov1Oi0mU4FevhD09nzSQe/RJ
	 A6fiqeKVEruzpKPLWW06zYS+c5u2n3Ovl+GZl2J9OLaH1YlihztPXAmzwYyAti4dIdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="fC4/WDT5";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44B606A330
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 06:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F44B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fC4/WDT5
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so627793eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 22:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793774563; x=1794379363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CaIA/Sr2kiTxJs6D9LfjF0iFIQjHh5ZBby7zBRLnjyI=;
        b=fC4/WDT5oFZPWEWs60Q7RhuQZP4DJQe877ZJJI5AU7bF0gQrNjO5hGkH+3W/0KW5gw
         y77bERCqeS/9ocgr+2YbIxL0MU3EpNYL2hfq0FlDomKr7jM5/7L5JmuLAENe+1XuT/EV
         PTt72eKpBaHTGw82zOPYckddDQr6LDMsL/wcOFm7Ti3M/26Lxc9DbAy5JAeE0zPSrV+N
         OzRi6rNNV5Tf7k5usFH+FtGX1SGr76HKuj5Wf+m4Kf9XoNbmcp05AhYsFp26Vy1Tou5e
         PBkIZn42tGID6PUU8fX5iFI7V3+Kt7b+3yL0JJODXQxGXRWVLz+q4ELKzfxDBAVvsNCa
         U71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793774563; x=1794379363;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CaIA/Sr2kiTxJs6D9LfjF0iFIQjHh5ZBby7zBRLnjyI=;
        b=sSmNcQ8RbRmU8cIV2A8cpAmc5nFmOSWIyUiAp3I3MG5IJ/ma/zthzwckpfrxaZ6u4V
         5pGrsBi081k4kbD+hpW/vu0NoVViaDXaXvAfFXVR5MNuhhYDLMySRrgy5OoIt2m31TJC
         vXvufGGePlmG8IHN5M80bz+2u2ZxIjTDFB77WzM4DviXwpF4cXb1xZm795vZVvtDST3s
         noYZx2AIZgDJ4/UkUg7SR4Bk7rwatFwt8xefjwySeHd/oRsoHuHGsUuHOTmmZZcS0A8y
         txIzDHkKAQousPMcbTxnt6Qve4xMqVMHBmkfR0CSGSmMwoalL/xt3azCJai/0G4bC/ph
         eyjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzniVLeKaZJyCBYK9bXl2zyBi7oJUR+0QRqhtzZKLjZIduBaJ0RmSleMs0dNwOrLkqXZbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gENQ/wdUlEz4e/IbmNhXAwDLTguWt/0Dd1vatGm4KvKOzp9rE
	PN54TW6QCPfFasDP39c1g2k8bIdpfjQ3ybQuuJ3KHvl7AR0zXv1WmqNnMFUEx6PlblI=
X-Gm-Gg: AYBFou1DPLFW2zsSG8qB+q4mptfNFcA8QdEj6hjUNDMHJ4HHJ+z4KHGqGubPlN3Sm0w
	MaK3NzTNjc0GGKdk+7WjN9tDLy0jQYlAUPnZWYjeQttBhQtiApKV2UCHQ7wRIlZIB/36p2ZffI4
	WbKr3EFnf2vd+H5ZfqHNrAZ+YWmUfVFj8t1s4mOxm9CCklBgJEJJXpUwHiYFrCWGpR6pUd72l+i
	FGwO2tInAB7TfBvDrrhtbZ3uAgYQe0ChHW8iFhUuCgyKY/kiOpUrUHHXw4EzBn83FpsKV4Df8lk
	m/67n6uDFbRtm4JR72EdXKd3P5Y4mM7ODXqguRFQc2CE8XE3P25itiKIDO2axZ0RJHqR5YxtSav
	Lpom+0Repg5lePe0FJN7w4GiZE7k/uJMGPbH3HA4hA+svlJeOB4j6EVw8N8Uxf7BJQrh/UTiQdt
	9P9B95XBvDisPjyuP26wsybbwJTUPQ/gfrHYZbGotU+lDh5eLoJlPrP8F1vaUj5m9yzQQl2bgKa
	18+5MMLe3+AxYxkVfEfhcrPf71Qf8+wIJqcuKs4fNdtAXTIhPEY1LvJU7BgOFBNQv8s+KXVZzx9
	pJCQZjnQjVp3QVPKk2FZKP1T/wnzrwZQhRrqxQ==
X-Received: by 2002:a05:7022:1711:b0:1ae:59d6:91d7 with SMTP id a92af1059eb24-1ae59d6945fmr17559078c88.40.1793774562347;
        Tue, 03 Nov 2026 22:42:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([61.251.99.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c57430sm5905073c88.18.2026.11.03.22.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:42:41 -0800 (PST)
Date: Wed, 4 Nov 2026 01:42:23 -0500
From: Gregory Price <gourry@gourry.net>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, hannes@cmpxchg.org, mkoutny@suse.com,
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com,
	joshua.hahnjy@gmail.com, ying.huang@linux.alibaba.com,
	ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/mempolicy: add per-cgroup weighted interleave
 controls
Message-ID: <aurTz8SiB-nQ22lJ@gourry-fedora-PF4VCD3F>
References: <20261103122816.48037-1-lizhe.67@bytedance.com>
 <0efbf4db1decd8e6bb6a5fcdcf897314@kernel.org>
 <03bceb67-d362-47a6-b555-ed5aa1f9bd3e@bytedance.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03bceb67-d362-47a6-b555-ed5aa1f9bd3e@bytedance.com>

On Wed, Nov 04, 2026 at 10:44:46AM +0800, Li Zhe wrote:
> 
> Does that distinction make the cgroup-scoped override acceptable? If not,
> could you suggest a better way to support this kind of administrative
> weight override without adding new mempolicy syscalls?
>

I'm a little confused why cgroup-anything is needed here when you could
just override the weight table / interleave functions.

I don't particularly like the idea of bpf hooks for a single mempolicy
mode as opposed to something more generally useful - and I question
how useful task-mempolicies are in general for tiered memory systems
(they also affect kernel allocation placement, which is not great).

You have many patch proposals recently trying to adjust the mempolicy
components and I think it might be helpful if we could chat a bit
about what big problems you're actually trying to solve.

I get that you want better control over task/task-groups, i think that
can be useful - but I also know that demotion immediately mucks all
this placement logic up (and we can't check vma / task policies at
demotion time) so I question how realisitic the value of these
extensions will be.

~Gregory
