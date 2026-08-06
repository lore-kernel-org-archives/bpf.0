Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA81485CD6
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040710; cv=none; b=rScQNDIAfK86MuuKjcmunNL0jR82UUJR3TAffBG8r7jtTUxF7uUvrUMvkHV4pG/7Tadystv5sVOmhXzA6K9Py0m1NI/YW4CNgGc8dXIjeuTr9eyiWpPc7AUGQFchn/GXzNNpCnXQymIo1RK0dOKn2ZjHBtYCOAX+vLjpFcYvhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040710; c=relaxed/simple;
	bh=OAnGXhoMWN0VX4aRXp3qSN6EwUoruIJ70j69kxghWfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GreeK/jo8q5119S9SnG68FUldJ02FnQ0wBGw7bVS+n4zn3oSCVjxFQstCZK3X42pULMdjaTLwqwhctElVknGIoF9ARq0aWy7kftMoPpA2r18apnL0fQxitk0Q/OrqnvBUVwWK2bWi1WgMcxUCWOno7PhT1sHB5cKB/zsc3wTP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNN3IMG1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNN3IMG1"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1701558a91.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786040708; x=1786645508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRxIpMxQf2eH73MswyccHSNChNNfT/J5n/NCnkKxEHE=;
        b=rNN3IMG1BNlGchnOjZlFZrkh2BI0nTwD6or5ACQrLo2bfQYsxI4LX8sKNjYEiew29w
         d7NlyengXoAoaRY6LL8O8zFGtGG8r1dXVYGAr4hzEGxxYD8AH+Ojh00kISYTcYrQvwST
         Pb3jXyPVZMU8MusBD+A0pIPluCWmxCH4Y9gfY3nLdG2RPWH9mzPXo1lxSeVFyTRasuV3
         jI+iII9LvtQHQLRX5lilQEw2PrhRsj62shYDOvIGX+lIJCKoODd5h12wLoalfAw+qBEd
         MsrtW4hsc0krY8hWLd88cS/kL0J1Iuj7Cnh2ngid9CB2RirbLRXCBopExXv2KwP/nOLp
         h7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040708; x=1786645508;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRxIpMxQf2eH73MswyccHSNChNNfT/J5n/NCnkKxEHE=;
        b=SSZuHQqVNsIeCsojF4B5FJ8We8OuIQDas5Z4d6rZcjZCp1owy3XPuEZveVmX6sdaRe
         pyxfYFX9TwT4ii+uJ7x9Bpzvi3YunWzw7dMd0++/8z/2A5V/YCU4ns8eFnmEuoGTTBP9
         v3qDsDqA6jOkkgcmoYKGXUf++YZ6BfK4pNCXzaw75KLTLzgZTB0Okp/Ny2Y+EYxIoSSg
         SHDdqG/qUwf+wyvlRfjd6hn5/ghlx84eKZAbh/FGiyRD/6snNjH8PTftLXAmJxkt0wyF
         yHAvB42I6SpdZE/V9uFuLhcU5RFuCiMn5QQlivLYB7PwQiVAYsb322rHf3XSUCmVHhmV
         HARQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIWzHgSwYtaIHeEdKDtiCs3QdvSJHrZ+owJ7z70G70Dzv+RVYKOwmz7U9+pOlD09/wFJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotuK7moO++v3B//opoN8edX957WnpxIZ7yFaoNx+P+aps23iT
	K8sBzMmFLPY16U5gM3V+Es2iDCLHSQWDq3QRC7o0SulRYVTh+GYsZl+M
X-Gm-Gg: AR+sD12cmqfmuXOmB0LRyf5KzGrM9OxzFogJhaS6AE3IRbuVHIkj68GI0xj21dxRYOz
	ednpvqPM7qxWEDniekLlJ/RE4rlvtlmCXHjs4sGibOapD7syg3/m58eLuwmfQQd0PZXbeBflhLK
	37LNLz9la/JUb0FRleR4QFzborWVvXhL0zHb+EheUuNHkG5tqeralSnlBkPSj55BTx8oM0VAcyM
	e277rL/GJRlLa/xmpdEt4jcHSiq4bkFjIEMHvsvbOItBROIXn3Qsh9ha7mPcMrtA0b9Fyzpnmrr
	2VYf2uXSI3T6aJ0ogkN5yB384eUFdquofsTu190SMP3DeASGT+DKsM4gB05sXCRzouUCwdKzESL
	btQ8UHnYw8pC4/XkZJu1Tb0nTvvqkwCTQdDIP2DNpeCDmVWLI9pFdCwVUQy1NRFThicvx+w3PLm
	jpKRBv6eWBS1JdMquy9N4PObHqbs94HQqORAFt8DnnYZZBHW0R1UIdbRurdD8DFivrtx3tWQwlr
	so3xvuo
X-Received: by 2002:a17:90b:3889:b0:381:973e:fa08 with SMTP id 98e67ed59e1d1-3903c5cfba2mr14353244a91.18.1786040708017;
        Thu, 06 Aug 2026 11:25:08 -0700 (PDT)
Received: from devvm16600.scu0.facebook.com ([2a03:2880:9ff:6e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867bc261sm29668669eec.28.2026.08.06.11.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:25:07 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:25:04 -0700
From: Ziyang Men <ziyang.meme@gmail.com>
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Vernet <void@manifault.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mykola Lysenko <mykolal@meta.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com, bpf@vger.kernel.org,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests/cgroup: add memcg_stat_cross_cpu
 correctness test for flush
Message-ID: <anTRgIZe5wgAsdCU@devvm16600.scu0.facebook.com>
References: <20260721174833.1232771-1-ziyang.meme@gmail.com>
 <20260721174833.1232771-3-ziyang.meme@gmail.com>
 <f83b6c93-b32e-434a-94b7-68628a2e8527@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f83b6c93-b32e-434a-94b7-68628a2e8527@linux.dev>

On Wed, Jul 22, 2026 at 11:42:58AM -0700, JP Kobryn wrote:
>On 7/21/26 10:48 AM, Ziyang Men wrote:
>>Add a test_progs selftest that verifies the memory-cgroup BPF kfuncs
>>return values that agree with what userspace reads from cgroupfs, across
>>a whole cgroup subtree that has been charged on many CPUs.
>>
>>It complements the existing cgroup_iter_memcg test.  cgroup_iter_memcg
>>calls the memcg kfuncs on a single cgroup (BPF_CGROUP_ITER_SELF_ONLY) and
>>only asserts each value is greater than zero, so it never checks that a
>>value is actually correct.  This test compares the kfunc values against
>>what userspace reads from memory.stat, and checks every node in the
>>cgroup tree.
>>
>Can you extend the existing test instead of adding a new one?

Hi JP,

Good suggestion. Actually extending the exisiting one was the plan in the v1.
However, existing selftests with similar purpose is the cgroup_iter_memcg, which
is in the bpf/. After discussed with the bpf reviewer in v1, we think this
selftest may suit better in the cgroup/ rather than the bpf/, since 1) it tests
the cgroup functionalities (bpf is a tool), and 2) together with the selftest,
this patch serials also ships a common Makefile lib.bpf.mk for easily compiling
selftests for other subsystems using bpf. Currently there is no other selftests
in cgroup/ relies on BPF and we think it is good to put this selftest here as
the first consumer.

We appreciate any possible suggestions. Thanks very much!

Best,
Ziyang
