Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655278;
	b=1rd3n2UURZ87cHjVPFOVA7BXDlGE1hEgK1vCE+Vn+8w2Tpe87v/niySXpmKSHqi29xSm
	 RMbjes/x15IHGLhxUbYw7GEfDC+cIPWnCiG8HWF1VXgHwDCXJ1nF/3CQUL0+wl5J4fs87
	 D05Gv/+qG8Mu0WOZzR4W0kW4gD4+dnNIAssLJ+JIw3aeK2BcdJgGXPLTA/O9yp/WKjOwy
	 tbBzLAVsMYiKmPRVezVTF568BBxIMY1LLDtaf/Goc4nynRobmouE/w62d0l3QPwUeAQHg
	 qwU8fZK2IvkC1qH0pagFLONEA1Qn3r3np8Jvn2hVkeUmdQwX6G0bHKnvNZdJGOcEhNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=0e+Ouu+6oLoZy2ujzXapWcEGF96bjKcfmd5hC33j504=;
	b=ny0Pzu1kK0knP+lltT1blmVkL6Qn1w2aIzuSH3nVcgDtSnKxwofkDiv31eNH50vY+y1q
	 P6lPNVW4KKGxEbTOg0uAMDFZM9dL1pbraOvcNU9hRMK/FYmeg8xhFMEqF7C7gzkPfOGRL
	 xxKbW63O6BUuxUc/Y0wj4lzgbsEfSOxoTnQdxgWqtPZxzd/qI1m4P6JwTtlyZ4uwpReQ0
	 8UWggIMrAcW9zPKGs4C9HrzC2XU2I9MGAcV0jWHW78egjloyItX+vf1SDBS/MoccQEmbP
	 kFtcOxIBUZD68X4aCHccP+dloSirNf2p70hck4E25s0oR6tcXK/lo7ZS6ML7wsIKoBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmHXJGPk;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03B606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF03B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmHXJGPk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so3926798b3a.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655277; x=1796260077; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0e+Ouu+6oLoZy2ujzXapWcEGF96bjKcfmd5hC33j504=;
        b=bmHXJGPkjT0iQQWrYHY7sMyXnEshrq4U4qqSkgr1yQNLs5XndAhbgAuEgGNipdAVzA
         Y/kpbeOd4V6KtAO+gVto16YC1OXlMWdopN84P40qpOAfBhWkeu3TlvNKmqdzjWkv9402
         XPbZjJVIzUPsX9dC8ibIjqU0cpmiM1zLBG8YZeHZqlMwEauunpmqjJ7+Um4D0iFH+N0c
         fSSlAQdFcv4LTcWYZoMMeUApUdEZhSDbBB+dzG9El7hJW3yTu63XexTMlR7e3nhkl902
         X/PLniWEHrA07+ix3ZGpIQcIlwYUj50YX721imnRnsrtxf4IoYCdrc+upH2iaaOcdUK6
         +jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655277; x=1796260077;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0e+Ouu+6oLoZy2ujzXapWcEGF96bjKcfmd5hC33j504=;
        b=wsFEv7X3cBcbG/dAlI18Mae7pzwUS0to2gZWWpAsOgNKrO1P+WQReEKCNGUVd+HebV
         foyO4jac6qomDXLI0dfTcxqyqrl9giBT2n9yQ6JFE0m4ruO5Qxj2QFas+awuZpQNEHL/
         3RGwCl+lobiNBKy5FRke7GWu3fhVOGJ9LhioIPHFaSNCXSHYBesUomqZ/i4Q8xxMCXr8
         mdjk30QeePTOwAcnntCY0mPeXfVeyGiy27qiG46vUKjB1I6xj6dwutGzjeLm/bWf+t5S
         ceLiQVLJnQw1OLRrogq+BCPmdvvCWi+6slJ42cOe87wBX6jjdk2hTpRsl6V1ckzvRS3Y
         y9Lw==
X-Forwarded-Encrypted: i=1; AL+hErHJbxdzk6D7j5hvKYCud+PR/GJA6jPrdjG5jnkprTPW8pRLRpuvCepBOkYbWUMTHBC1iK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Sgpv7quds7+pZ/4Y/mk2tGGb5SlPdgUaqR5v9NeRiWCsWvSBI
	4G6AtnKL8jSAPmqJXlgWOiPCZFO9211pVVpgqyxL9hfYgtCx22cf7elRKPBnlg==
X-Gm-Gg: AZFdTZelpgkDPqeuuo5DfacAx47c7WPXrViTWBrt0DLQK9DrnlmLUp97QNJybzrf026
	EgLFV+ij8CAiKS734Qc7Hsqk+P1ygpw5bsRUHfG6S3uAy7zDmJsjTdVbGlCIOpZLtZDs6Qr8Tl7
	sX8yET3Fn2pIglyhqiSh5vGN8uLOp0srly0gXmbgoVu9NLaUVm8WIJr/JZ1F9lN8cZL9hInid4N
	YPYUD1Ds5OcTgXH5WfCLLtundOHFNXrn6rvzlJk761F9cZJjv2DFfj09tsGOmFHmSGYfQcOiUJB
	0fifOOOSnaGVKxLAbqEO0vN6lRZTdSQBnaDyLgyRlz57on1s9fdWJB9rurvDvg2pS2T44LBiLwZ
	RxAvMat37wewLDqaeCs5EIY8eqVB647l2ds6znU5ocFDuq0aas4XTsCaVshwqwSb3rVRmjrHR9I
	fU8X7WxU5M+nqe/x4kDiKkqXAwcEl3xCyk8Vodj8HssXAnjvJRx/lp6/f6b+FRLkKb4gOHihRj9
	X4Id8sQvMUUb+oEkf/YV9fq5veUf+Re5vTpQJRodr6Onx8e04bvqyaC8nyltCahTbo8R3Gv5hsJ
	D9b9OfLfkzgCicQ87fVzUeRI84g4baGHaDkkRabUEePbK/b2Zmksaz5iJj5dAWffWmbx0Jvb39V
	JcfhDQif5Jb8fVMXLLDtCbPjzs5tdjqTOQTM=
X-Received: by 2002:a05:6a00:c08a:20b0:8c7:f59c:e82e with SMTP id d2e1a72fcca58-8c7f59cee72mr10451362b3a.36.1795655276950;
        Wed, 25 Nov 2026 17:07:56 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4c43bsm9633902b3a.26.2026.11.25.17.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:07:56 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 01:07:55 +0000
Message-Id: <DN4QO5PPVN0Z.1CO2JSCYRH04R@gmail.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>, "David Hildenbrand"
 <david@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman Long"
 <longman@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Peter Zijlstra" <peterz@infradead.org>, "Harry Yoo" <harry@kernel.org>
In-Reply-To: <20261125160409.GF2668804@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net> <awbvek-HS3OJYJGF@thinkstation> <20261125160409.GF2668804@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 08:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Nov 25, 2026 at 02:30:52PM +0000, Harry Yoo wrote:

>> One remaining accident we're aware is that we cannot attempt a
>> spin_trylock or local_trylock under pi_lock (even on !RT).

No. It's RT only. Already answered in the other email.
Nothing wrong with !RT.

