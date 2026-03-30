Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76920366056
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895031; cv=none; b=nQdnNw5sDuKKKe4FWxX5z7lYogTuXoKQa+YW6Bz4qGoQkfVQujR4HznvrtH+4ZLtkmzTjS8itFYEjj0p3/v7JVZopEvdLccgcQE5VCgCqywC6ml33FfITJuBsOIctPqUeOE74/ZqonHwboY3QGtiAQQuVc518yceh54dZ2lzNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895031; c=relaxed/simple;
	bh=Pcgs5Hkr4phayDZ50JP7J5wb8LbRgXIBOs0UAGQXJLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGe40/oV+tS9huysoxYhgOVveCpAzKqBWzlOdsck0wimCjlQn0VnAP3k5v0N44olOohvLBdo4EwjAGKT5Yx9Bmuu5NglXOsTLCxUCrJS2MVwfApR8EahUGeYXEWU1I9TgilKVGldegDXsnz8R4is0+2BCRxWfBEMJ5UmWByifO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8udjpri; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8udjpri"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509069a7a7fso83331cf.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774895029; x=1775499829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dn/bjNHe8mXuBFDqP6eCP0Ayq1fUbkFOeaQGMlTxTyY=;
        b=X8udjpriK9nVmT+dASf9puGAAimxxqHtkjo1KfuZLuh3W+cIcfsZgkt+yMPpO773kX
         Fv0nlIzeErk23hsUKO8/KeNgbNhL2k2x4LPVQcY9zyipNrJDJYIp8gac2x/jV9I6I9NV
         bHxdDfgbmsogxiKrSu35YFmPvv/7/DIcnyjGF74OSOdXfTwfhZmTMTIl3p6ItcZ4yb2/
         OWrMfnTkUeuDGhIH2RBPyhLWrxKls9Qilq41vrp6LRruEflzlx4KKjMZHC2APzz9e/y0
         BupP5qiRmybiuw8JiM735w+OHJuoxiJKirzxYSG0crE4QqNIVrKhlG1FfhLb76VdmfVE
         NytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774895029; x=1775499829;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dn/bjNHe8mXuBFDqP6eCP0Ayq1fUbkFOeaQGMlTxTyY=;
        b=pVSbUjULF6RkhIRJBOmzMFIKxARdataNOigrtZlwi9G3cs4xV48IsJgoii1PFZ7nHH
         IfDV010maE1keVnWF66agoEWoe28GeMiwnTOGfxst/QB0gBipGatsz55kh1Zx7oAR7MN
         /ec8YQ1BeTIAIEzBW+nUy4R0GuzHftO/bLko+9kb8rJwo18zCGOnASkya4f3JaWLp6Rf
         yvbPGo9uaTnCMvsdQK1c1yQMcEWHSoiZCeJsvS5K20Z/OCQx74F7b6XHAb+qyDSuSMBz
         f5UX6LMVAhEOVs4acLejp6yQCsqUa16mf6dB7W9Lusvur5z0bQliK4IvgF8KWAbwjDmu
         pOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpG4hMvoQDpM4osVAtPis/D3fnj1pasX2DsJgFV3VRvIFR+S6Z3DT7Zj6ixAkkk+YTFlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GDpXTH3LcChVprE9xzseBl4BJ7ZlLNNiqxTkfDLzyyBTxe1G
	9KUnbnMYAqCFuJXAU8uUk12softFC6o+EZF+yhbOxIzyqecETq46kLEy1UtLoIPpyg==
X-Gm-Gg: ATEYQzz/01eazxN+y/xnLK5vXHS/Dv286/aeifqDC+Dn4ktM9EXLAOIX+92K/t0vpWO
	b88M72uyxeNP9xnKbFZAkNWb+o9h6GcwFmXnEZa9LaoW/dlqeKhm6AdQCC/Idmby2v8mWdoPoh4
	Xe9PHC9B5ZoH1imNCoSHTEdZMK4zn0vbr2EV6J0mwGPXn19Dhpj1XapKnMRCR3CVxXMSOFVQCuI
	w+ZpHTlberZbWuGIfqyM/fS7nTat1Zcz0J8TRHqryO3I/vG7uUygXoMX1m6BVguTdMe3bgwcq7m
	ZWniNtcyH73SxfJYBBhinghKfaBUu0Ayanp/BGKSmOQu+60kKcfhC9YnQT319Q+beaV6dD8s0X8
	i1k+RccqRiwsbZMVW9BTMdVunKM9dRiRQ1Pa9yzBoQdfPg3wUervzxfsPjg/q9VRDCTQ3hXUuYE
	/HcT0u8lzLyOwa607f5gZSog==
X-Received: by 2002:a05:622a:9d4:20b0:501:4eae:dbfc with SMTP id d75a77b69052e-50d2d70abecmr1067521cf.5.1774895028948;
        Mon, 30 Mar 2026 11:23:48 -0700 (PDT)
Received: from [192.168.1.27] ([130.44.176.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028073afesm655287485a.37.2026.03.30.11.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 11:23:48 -0700 (PDT)
Message-ID: <6a1fc935-2bf2-411a-8dd6-cb1ac4e85c1d@google.com>
Date: Mon, 30 Mar 2026 14:23:47 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Levi Zim <i@kxxt.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Matt Bobrowski <mattbobrowski@google.com>, Josh Don <joshdon@google.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
 <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
 <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
 <1c7bfc3f-c327-4777-a70f-48144aa0864f@google.com>
 <CAADnVQJqs-z00-m-Qdavv0bGSwqV2tUz+61+h-aw5ze_EPDoXw@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJqs-z00-m-Qdavv0bGSwqV2tUz+61+h-aw5ze_EPDoXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 9:29 PM, Alexei Starovoitov wrote:
> 
> See Ed's reply.

thanks for the hints!

> I'll double down on request to share your prog that hits 1M.
> We're working on removing the limit completely,
> so the more tests the better.

unfortunately, i can't easily do that since the program hooks into 
ghost's BPF prog_types and not sched_ext's.

that said, we're working on porting my "flux" framework (which is what 
my scheduler uses) to sched_ext.  so one of these days we'll have 
something you can build.

thanks,
barret


