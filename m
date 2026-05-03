Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3837C0E3
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829134; cv=none; b=A4Fd/RUKzg2WgjSpAA9BAjlYPyDUqz7OGgc4ugx3d4JHsX91zwXuxGzoQqf50UgcZBGcRzdQ698MNdm0KNN1VhemvmhyI+4cGPo//wjer0wChGsrYY0qBMM+YBliQDybyeLahjxu8D6TlPuejBsAecJSe2Qiya2euAh9qpCv/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829134; c=relaxed/simple;
	bh=CLS0bpPu2puj37Eabb+AgDor1kynV4ymaDxCl8+659A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQLEkVVdu79q8/plkiypMHHUASvEuTnf9XfmsrSCCO1QluGwlNmQS9HxQhwUBcP9Fshdnmm8FStHvHG/NPAiXrw8Kt8Ksg//CfmX6XKQAqZWtUQIaVZ0a5OgHUqL1m3XADOteRexVHRss7GKv82GC2rfrUBrDbflnSLa1SpZBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/bN7McB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/bN7McB"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f8b60e485so1571685b3a.0
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777829132; x=1778433932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8o9FalgtmoPunAjSjBWUFK3XFWYc8vHIp7TS6crtgE0=;
        b=k/bN7McB/l+vK6Hqo1odqhtEGwZJHmITjWd59HkrQHy83HDZWKkA6uL9PO2LqoSQQh
         NIMwCYTX9PfFXgIkqW9PT04DGfA35QSE94mSCSjty1hzAfFxQbR/gFvNStajKlu9Nj5A
         CwLakjNfJg1qQXgCqP7g6lQyZPpyhIhvQXXUB3K5F0OaRurQTsjvuyXn6jgJ7MEtX/pk
         5Oh07waBiWqTRLdPUSceto6k65ShfpV/LmvkiI9JQ/GFipRentsiLO9uAJFkT9V43MV2
         WJ9jA73uVyV/tMIMKg7P/WM1EgvUL9hzZu1hvFQaWw1Xd4kV0cwtn9OQtKOOlkRa0EIG
         mMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777829132; x=1778433932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o9FalgtmoPunAjSjBWUFK3XFWYc8vHIp7TS6crtgE0=;
        b=H1PjTkHvNvJ+9Gpglo8fg/RJWFIUMok+XXv3r88K7canZohmXiVw+iHR3zDpWdvciK
         +YYHnB7tCC6UnH4L1+KVvqvr1eEdcEaE861VgVOIuIuadhDb+7t62xpMrc2jsGg5nM7j
         K/JcxeXbEGzMdooMC5lERhcmSMNN7+FryvY+N1QvBb0K3IwWhHIcB7mmUUXqoCAf7Qoe
         gQjpjYnuD06NvvE18hxx150zcZdRACL7blAZe0YoyxhlHizDP0viKi/OZ41Qg5wjd75W
         3WEZapcfBN0nrhoKH2YJj7fC+XeoHMi4AfstQVBgrY+LlWr/E29+kJ8BeWXtenC/KciP
         Z9RQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7viO1GMLDg0fJIAindMpmXUQ/mvuVLx87WLnC5BDgwbylE75md6nWjm2nyDyryttxjkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQD1O2LceevVtAKc8lXXblJZdUvRjgdXIbZq/vSVP9mYcz2+s
	GHgvGoXpji2eozGHUIsr7ak6jf5bR/JXygResViv2X2ZchqG5PLHwakP
X-Gm-Gg: AeBDiesYoUMmtRpU1hgU4aXl2fGS9sMcvu1Hosbn5Mx25XQ3VeU3vAWiah44IASwHaF
	o98c6FnfXZeKPJ83jNkCocTyktZBJtSWHiIJYFeROMdYH6/IIHdoPfZhLK8IEVQIGphFedeiIAK
	csJQFGby/3D4wcsOpZNmBW1FcZMK+mLKxpb8fQm5uQ1o3izFSpE1/O/DzJY/deYDYSrwk/5QKbs
	HGHfln79vRcbgKsBdHRzhrZcW3oEsG2BX/viFNt5cWPNhbiuABdQAqfsr4EAT1eZ/Ad9LzDBJxW
	EmMJZtACf4slV4pb0v/2CGMnrws2d4HtAwQaqmvjgwHipyEzVdZd5h031yT0Y7YTdl5xNoo2As6
	XWl/Ko9fHiesBkYg4Tm/rDWw2woueGatCST1LIbWvCVoSCpIK0jciABjquHV9ohoQBxmZNMuUZZ
	dqN+q6pHZMWBEv5BiW1hIMgFzdD+vzgL5uJeFE2ePsw4EY5mkU5aN2y0J5kA==
X-Received: by 2002:a05:6a20:72a7:b0:39b:949d:6078 with SMTP id adf61e73a8af0-3a7f1a1d68cmr7007462637.6.1777829132163;
        Sun, 03 May 2026 10:25:32 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b1fe12sm8672423b3a.47.2026.05.03.10.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 10:25:31 -0700 (PDT)
Date: Mon, 4 May 2026 01:25:25 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] Using BPF in MM
Message-ID: <821acd4c-d443-44d0-842d-26ff45e2f54d@gmail.com>
References: <7ia4o6j4c5y1.fsf@castle.c.googlers.com>
 <014f3c0a-7c6f-4f64-95cd-b7b69d804880@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014f3c0a-7c6f-4f64-95cd-b7b69d804880@kernel.org>

On Tue, Apr 28, 2026 at 10:12:16AM +0200, David Hildenbrand (Arm) wrote:
> On 4/28/26 01:57, Roman Gushchin wrote:
> > [LSF/MM/BPF TOPIC] Using BPF in MM
> > ----------------------------------
> >
> > Over the last decade, BPF successfully penetrated into multiple kernel
> > subsystems: started as a feature to filter (out) networking packets,
> > it captured its place in networking, tracing, security, HID drivers,
> > and scheduling. Memory management is a logical next step, and recently
> > we saw a growing number of proposals in this area.
> >
> > In (approximately) historical order:
> >   - BPF OOM
> >   - BPF-based memcg stats access (landed)
> >   - BPF-based NUMA balancing
> >   - eBPF-mm
> >   - cache_ext (BPF Page Cache)
> >   - memcg_ext
>
> There was also the BPF THP control.

Hi David, Roman,

I submit a new series "mm: introduce mthp_ext via cgroup-bpf to make
mTHP more transparent"[1] to implement BPF-THP, which has excellent
performance data through stress testing. For details, please refer to
the patchset cover letter.

Although I did not attend the conference in person, I have been online
throughout. Please feel free to discuss any latest progress with me
online. Thank you!

[1] https://lore.kernel.org/linux-mm/20260503165024.1526680-1-vernon2gm@gmail.com/

--
Cheers,
Vernon

> >
> > There are some obvious target which haven't been covered yet:
> >   - BPF-driven readahead control
> >   - BPF-driven KSM
> >   - BPF-driven guest memory control
> >
> > Despite a large number of suggestions only a relatively small feature
> > (query memcg statistics from BPF) made it to upstream.
> >
> > It looks like using BPF in the MM subsystem comes with a set of somewhat
> > unique challenges and questions to be answered.
>
> [...]
>
> I think you are missing one of the most important points: Unclear ABI stability
> guarantees.
>
> One the one hand, we are told that there are no ABI stability guarantees, and
> that we can change hooks (add/remove/modify) any time we want.
>
> On the other hand, as soon as there is some ebpf program out there that we
> break, you can rest assured that there will be trouble.
>
> In the area of THP, where we don't even know which hooks we will need long term
> and how they would look like, that was one of the reasons why the BPF THP
> control was rejected.
>
> --
> Cheers,
>
> David
>
