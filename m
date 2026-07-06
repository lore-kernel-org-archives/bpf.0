Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C36382374
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357100; cv=none; b=SfNyvP1BMOfTz9fEgUVRcAJBGkAGUvcijAtkE3FcywFZXGiyEjd4vliIBULxwBbVBP17dpkHEZx7OxmrsGQlI6Nu61AlDLV+SODxNEjHgWyCZndtIe2iGVUmSqaX9N6ivDSas8HtJD1tESYktT6ujIEChdjMaOvDJfqUAlkr8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357100; c=relaxed/simple;
	bh=ww7lCt6NpJeU6KKhYEyofAyOhJWk5zB8DqbthydSzU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUplq2LMPt29VHwDjeZTAl2pN4yhB+0NsirkthHVQUleiB8tBaLb8Cr+MTTLkvYzBX+5QwY/ojYX1zthIyB9FueXKxH8cUVzXpa2ToGz7xyEKiMpAdgJ8lVpLwmB3FLCW0JyQ5Bu4HZOzqeai3wJJZins+Z49y6T55K1FRIuEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYUkjdZS; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYUkjdZS"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc7ef596c6so2764405ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783357099; x=1783961899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCktVGKDr9d58r4vlA1PSQeqKAytnjdIS32qXzkgbaU=;
        b=KYUkjdZSCIF4b0cm2KLL1+10MAj23ccTmUc7MQPUafwirB0sEGz14heT4laggVu9uZ
         +tvO182u5QGm3t4ErE4v/NDt/k8jyal5qb8mt3sgv/AzSBtNzzS2A9KSgouMf6nf/Dxo
         xoYCDjg00EwOK3ZUHJq8AhPVtotUS1K8K9Cr1mM+JydpE9v8A9dHcGosjGoTMWI+5+Su
         9ootqqn1lGrbqHz8JJbgJg0kR/PSWTQleTA3kN29Gpku7Km35oVrhXAaqpdVQ3aRVIYl
         hoG7QVfwArwykWmz0DgtCsuMZ3AFkMOqkPhhzuZIg2biEES3YCN0P9NoOltv9D8sHb5p
         OG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357099; x=1783961899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCktVGKDr9d58r4vlA1PSQeqKAytnjdIS32qXzkgbaU=;
        b=fNlndESljdzXQPD3fnccZUmXVb6XbfL3AKq/As3W/K6wRCEYxU1Xg56Vi2sUH/ZrQM
         KUx1Wz/Gk2UNShJDyD20q4Bm7S0eyDIUUWGwNPmkn3QB1xo6yiWMtThmf3FNmN5uoqHY
         S42DFfqnDRFAlGvcFrfC3lCl703Y2e0e6NVu5hrLQ9Qc5HcST1/GyEG4UznDerwAWVqG
         CyabmdPEC4y4FN4m06Eaue0Klyo41uKZp0ARhinUY9tWhT8OQM+HhXDq6wr5fhVFX9fE
         GbsL6AiSgc+qN7136DmP9GpHvSduhVA8XrYaA0ew+wm6m3ugYLfNMPELC4WZvmahIbm0
         tMpw==
X-Gm-Message-State: AOJu0YyWAFzZH2O/mbShWseBJ/HzG+0ZJdEoRUtFmc0+yZslCu8lxqhc
	02u/pVRvuuY/WCOPFkxQs+Bdc1tsNCDN0QiSfCbut3PFnnIV9iy2nVHt
X-Gm-Gg: AfdE7cn/QqMvUU86Vgdhiw6R5Hipl9MixGjML1xludDeaZ0jUVoiion5Yft7Jia7pEq
	AjFUIkIZj6C1VPE9/lEgggscnIFXMWrVo6Hqp2BpeZFLPiotMTMkS5t6oGM4MOoFdYhMzz0ENUT
	8UbxtctEXv4cUDgBjPj5KYDLB5qVHBB0dFW4hgdpbmlSzu0tnAWorBe1mY5b27B4+1sRTuP4ISu
	o8ChwcY5krHGwS7HOQ7osqITuZRWql8jHmFAWNuvmy31VRlpzRk+tuCGqB/OlI2JiHIBYlRsJ+z
	wxZ1Ly04Ch+g5cAc0VydHlTPs/B5CIF13LC5iLdPMEt3RzsjxNgHh4ZbOlEtfSg83JOfjs91KEn
	+AOOhVuOZQ95pr8u93M8AuOWK9Xz8rYorK7+D3Em7+GdDoPUP9b67n8wJNqY+2iJw24gXbhF0sy
	vtbHImBKoHQARHB/7d
X-Received: by 2002:a17:902:d4c7:b0:2ca:ce91:f027 with SMTP id d9443c01a7336-2ccbf08784fmr14779995ad.36.1783357098686;
        Mon, 06 Jul 2026 09:58:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260acsm54342455ad.6.2026.07.06.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:58:18 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:58:09 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706093525.13030-3-mahe.tardy@gmail.com>

On 07/06, Mahe Tardy wrote:
> Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> sending data. This provides a mechanism for BPF programs to emit
> telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> socket types with IPPROTO_UDP protocol but could be easily extended to
> SOCK_STREAM and IPPROTO_TCP in the future.
> 
> The API consists of six kfuncs:
> 
>   bpf_ksock_create()   - Create a socket (sleepable)

[..]

>   bpf_ksock_bind()     - Bind socket to local address (sleepable)
>   bpf_ksock_connect()  - Connect socket to remote address (sleepable)

Since you're doing only UDP for now, maybe you don't need bind/connect? The
kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).

>   bpf_ksock_send()     - Send data through the socket (sleepable)
>   bpf_ksock_acquire()  - Acquire a reference to a socket context
>   bpf_ksock_release()  - Release a reference (cleanup via
>                          queue_rcu_work since sock_release sleeps)
> 
> The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> can be called from SYSCALL programs only. While bpf_ksock_acquire,
> bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> programs.
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The kernel socket is wrapped in a refcounted bpf_ksock
> struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> may sleep.
> 
> The kfuncs are only compiled when CONFIG_INET is enabled, as they
> specifically support AF_INET and AF_INET6 sockets.
> 
> The socket operations go through the expected LSM hooks instead of
> by-passing them like many kernel sockets since those are created by BPF
> programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> exposed to LSM progs, has a re-entering protection to avoid recursion.
> Also, because of the LSM checks, we prevent the use of the kfuncs from
> asynchronous workqueue as the current value would then be invalid.

[..]

> A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> kernel sockets that may exist in each network namespace. Out of
> simplicity for now, the settings is host wide but the counters are per
> network namespace.

What is this guarding against? Rogue bpf programs creating too many sockets?
