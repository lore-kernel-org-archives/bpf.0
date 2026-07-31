Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC83403E0
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526825; cv=none; b=JVAHPego0WD8o3W3+MASK3xfH9xjlaW2s43kLGp2DxkzpR5PkrIWXHrcRYN0YU1gRSYj+ziufsj8yH68WGcCmMVKINBU1qEdHjNiE3H5t5pxlL/eGnQhJyd3YLF6poLWFxkJQpNHBrCFq0B8ukQJMffnXKrAZxecX7ggbpifkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526825; c=relaxed/simple;
	bh=5MAd36KrAfWy7MmTrAdWHhIoFGpDBJNkMBUMQTl2LHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGU6xLhVIU3uGDuFFkaffNVOzudP/opQ5XTNg8S3CxdD313BoazI8py5kKU14Fg1VxoM4IbmlpoVGbXPpnvbL6rftWphcmttom8s+3FidC4m+8Ru60N8kuWeb0TQsUCi3UT5yP25VDueXf+U74cfXXA+m2dGmd3UsZmfR+ngJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3SbSHMp; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3SbSHMp"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-667f1390f58so1877378d50.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785526823; x=1786131623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MrmHZvijAbsBM4kIIyUU8PQWNQGu2ozzMacZdGzdvKY=;
        b=G3SbSHMpR/cmzY0z7GSqVofaX1dXKJzVM/CYq3Tc/5DrBwtuRN5qX+X7f4z9NjEj4K
         JlrqAztj/Hs7yLtRxKyHKIVSJpb85Z43AFhMQ9fxIl0haaNn2gdiuiCwqLoPlM+fuPCb
         tMdGOEnWQMEHYswYNFch9SpBYTz2Hacdwft9C2uzzRup1Dc+VIAqpKoubgcgdDrWWd1P
         DNZVYYBqR5PXZIp8aRW6lJVRg5hkCZ4kg1Fr8239wSKnZyHKz55sYaPx2dfqTYn16vXy
         UqMYW1URDeBddeHciiRKwunHuBBhUfjfttEs4Wnb5LgptshQfSUdHzwiFJnrlhpLCehF
         8Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785526823; x=1786131623;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MrmHZvijAbsBM4kIIyUU8PQWNQGu2ozzMacZdGzdvKY=;
        b=Xm+sV6Lmtacpvoe3eKR2DmS7GyYSNs5eZwWkRn3BnPRxKIwJXfwJZ8KVkBQeuK1QDF
         s1965+QX5Hc6zCndOv+RzYhiqe4eZogzp1JUXKcrMi80q1wp9j4R1sKfl/VPa1kW/lHg
         obcSC9g1Xec2IihvtdH5fgD/KGqB93PCijv3AG348is8bhJ8WhUAt5FDlHlYTKdApwgP
         b7nhmy6PfwyBiROefieBUCjR9H3tvztgEe7jXUZNAjw+T5zwf/cQDtljbba8zna5VkNL
         dyrx6tSE7QG1DrVhmPZQkiUhgNNtnPS1LeztAbUdtJz8MpRx/N8cvGR2UyaXmXpLhzRK
         qDRw==
X-Gm-Message-State: AOJu0YxUaxP5E3U6LCgwy1CDNwOLnk9hF/2GML2B3JVQ06+KKppIQjjl
	EklN8JZT3Zt2rZKn+zCCxooTmA5ZQUrPBcgEWz++D9sw2jpnM8Kj5daDG3b0QEXz
X-Gm-Gg: AR+sD11GLft6LKmujRJcU0zVHcwvtVJqQuV5LaKKAGL1bvpJ/s3OF8FruWg0s7gg7St
	34OlbB8TseBPIasG0XU1hA0FQPDpMaO2k/DlqALVI9OG3NSulBGL8VcRsXD3jAL4oA2+uaMZrIh
	X/TbNzGTWNfbRwXcfAMziVPP3pNWt5N5dkJX5Ta8j4KK7P+q81AMr5/suTOj4tLpNt549Ni85uV
	Et8kgFA5s3lB36oDrj8CPbNyY3Zig4D3ncjOjjMo+pGm33U5MAS2r6S6BLmSb7PnqonkTxJU2//
	RGagv4iJv9KqoVUAN4RZfVE0X644eFjx7LDLXT6UoaBl1jT/9aLkdl8aocNLNcNvsx/OaywExVs
	9dfM1eEKUN3YdEa9Fy/EriwRIX1H+Qft+VpPd9fNmvm2RKYMvZSlcvWOB1QDlnxM6z62l0ft56N
	nABBSbELMayOJ1+Kf0+MeOSkVFZLBMIr7q8XrbyxDuyUkcsLx0nJtO0c3CDMeVjv/VzG5/Vv4k1
	pj+j44pOathUU68chtLxw==
X-Received: by 2002:a05:690e:edd:b0:664:7d5d:4390 with SMTP id 956f58d0204a3-6694efcd4e1mr1211866d50.1.1785526822618;
        Fri, 31 Jul 2026 12:40:22 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d52:64e9:32ac:b832])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948e5ee60sm1175497d50.8.2026.07.31.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:40:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:40:21 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 10/13] bpf: Add the bpf_landlock_restrict_binprm
 kfunc
Message-ID: <amz2tVz-P5Hrwm5B@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <20260731022047.189137-11-utilityemal77@gmail.com>
 <20260731024637.9D4E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731024637.9D4E81F000E9@smtp.kernel.org>

On Fri, Jul 31, 2026 at 02:46:37AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Multiple calls to bpf_landlock_restrict_binprm() do not compose; a later call replaces a previously staged restriction instead of intersecting it, violating BPF LSM composition principles.
> - [Medium] bpf_landlock_kfunc_filter incorrectly restricts the release kfunc bpf_landlock_put_ruleset to only the two bprm sleepable hooks, violating the stated design and preventing valid reference cleanup in other LSM hooks.
> 
> [Severity: High]
> Does replacing instead of intersecting the ruleset break the BPF LSM
> composition principles?
> 
> If multiple BPF LSM programs are attached to the same hook, a later call to
> bpf_landlock_restrict_binprm() replaces a previously staged restriction
> rather than layering or intersecting it.
> 
> This allows a subsequent program to completely bypass and discard the security
> policy enforced by an earlier program.
>

It was agreed upon here [1] that it's better to just replace the domain
rather than allowing multiple calls to this function to build a
multi-layer domain. Merging staged domains creates issues of running
into the maximum layers and introduces unecessary complexity.

As for multiple BPF LSM programs trying to overwrite eachother's rulesets:
that's nonesense. There is no security boundary broken here. The ruleset
composition should happen in userspace before this kfunc ever
gets called. Pathological BPF programs are not part of the threat model.

Justin

[1] https://github.com/landlock-lsm/linux/issues/56#issuecomment-4825919649

> > +}
> > +
> 
> [ ... ]
