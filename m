Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F05234994
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826781; cv=none; b=QfLEhNCgBTFwEAOZjN6/e8KJ55iqCsp428ShPvgyOMZu0jy2WAigYPlTdJXWC6rKqu1MuJen1eQvCuZuuAnfd60qxwLkhuEQPsbzJfcvbOC5bN2jFY4ry/yiYKAy0P0QX76p7rhQqstbmdDvHNanf5UXDOspApyu4aOB4HwP1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826781; c=relaxed/simple;
	bh=Pk1BIm0lqh5ur3FQ6Knoqs2zL9N//uW3jlhl5b3jusg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myOj3vKH14vaabcVPDt4pgcQwo7PjlLwHtP3TH6ABRakKyzv5vcXsrulivnAxuUdtYFVizWNESCjc+Autxb4/DLdaJ75/yFblqNKY9wa6KdPrfKnor117gZ8pCdzy7jOZuKMEkaECfvnsalHPLnqLSPB/SZ1IIiuebn3G0Kb5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JinfpAlm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JinfpAlm"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso2883331a91.1
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780826780; x=1781431580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTMG8mIogyYbD/8xMSvWFnmoPcyNgu951VhFI7hriLs=;
        b=JinfpAlmm4EF0N86dR3yny9O/JYM1aCuH2DLJUfRYBBENXTt39QQWNfPX4T1MnbT12
         j97ksHc3JjsRDcqCf9En25Hx3+ft5WSty5/pM8gZIU7oaNdS1K120eH5pp09kZwNTfb6
         JmYHC+x0GzdIUlamTpEZbJuHGZjUUJPIV8KltaJYUAqQBcOIpLnRh4a5SYaQgRcYb5P9
         3xdPcva99o6rq3sEVucgg9CAUs7HszYUSqsTasEKfpakmGsPsI5r17iEvpcml4kwtXHk
         YZTFKGDjQfGUrhl1T2fNavl84SXKXAgaMEllZj+vN59+tX65mQkQkKXU6goldf5AD2e6
         n8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780826780; x=1781431580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTMG8mIogyYbD/8xMSvWFnmoPcyNgu951VhFI7hriLs=;
        b=WomAfAcOXg/NMF58mXmcRBq49M/Blzf1knmS5KWiXoMUf4gKjDhRT6rIpMvGM3xRjo
         ExlR1+tvVn9BnNLwz3Z1knT5ghh876glC2lBA54dz+Kn4N14NJBldkZyoNII/n3sPnMe
         5VjhihuF0x+HyY3HX5MU2nha6FFCuciduPVPBaixtbeV/QrAk8awl0/zmM7VEx60prkz
         SO5B8ePu66U8yDzkpFcxx27On7848MKof0YUtsKrNnynQrf60UPdkcqjrSaaf8BWm7x3
         u+XZQFKaBKc6l4MzHoCKVx15J/I3zM6GRWOQmZrqRuta4ZZ49I1l8tsy2nPCyfzODnFc
         v9Hw==
X-Forwarded-Encrypted: i=1; AFNElJ8VXHZXGO16obAnXB79/gtAY+jda4XTbCSFwDVqHvOC/iNmvOFDd9biOTdQNilWApDLpPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTTbdBYM8ZiokgKtU3QwBOP8dve1o6ieae0mlnANQL8ETjcrS
	tnqWUYvy7UAcBUV3tionG4g3baRiXz1qtp1CeQXvEeZ1/CDDdfTUNbHd
X-Gm-Gg: Acq92OHasbqSXCVCoJ6/DrVX3uEdnPoWJdflFPa6KIpZ4E0My2VUZWvWGgN+WoyfISx
	R4Is96vtxMRYJM+q3ubT28fy2jSTF0kiK/QtqsBk7hrspBeTdSNPJT0+LqyKuT6Jv34BZ4M/dbr
	nNLaMOauB1CWE+ZmX4N4McpHYv+H7djZQjIVA1eMuich+cEHnV34ryPDhKjs8TDsYl7m5zLWAjF
	lElT/gWiEowhCx8CBkSwvwclJSTfPCQg+qaKB+t9F9L+M8VpbaIGRyK8V7ojFsAA6mqeZLWAgic
	SknJlqL6XUdwLZCF+dLktbdKMv/YIzrB20DawBkmWllmcm5XAQUbCMxKCYRgXHWegXsmoNGxnkz
	ARExvAQFUH3gyQ++V/WUCqohU+Jqf7k7fYpZv+MBh/o5RLaMyeN7LYDetIVXeEEEDUc8qOV3vHt
	GC84q3rEfoiNSFCPYIvpXO91x8RGjBlAKpxbeLkTs31zErqof4E0gZnpeWTW1W2+sWVC0nrG1Hz
	WNe9Fq4
X-Received: by 2002:a17:90b:57c4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-370eea202f0mr11651823a91.8.1780826779939;
        Sun, 07 Jun 2026 03:06:19 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d1fec67sm14948047a91.11.2026.06.07.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 03:06:19 -0700 (PDT)
Date: Sun, 7 Jun 2026 10:05:40 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Juntong Deng <juntong.deng@outlook.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v3] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
Message-ID: <64l5t5yu77d5xg4jqjjwyqr2k75f2pi2vl7yus4oczgosjrpyx@2ink2pha4wt5>
References: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
 <DJ2OO6CSLUR6.2AGL1QQ2QSSDR@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DJ2OO6CSLUR6.2AGL1QQ2QSSDR@gmail.com>

On Sun, Jun 07, 2026 at 10:44:41AM +0200, Kumar Kartikeya Dwivedi wrote:
>>  kernel/bpf/helpers.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b5314c9fed3c..226c31ccb5d6 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2912,7 +2912,14 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
>>  {
>>  	struct task_struct *p;
>>
>> +	if (in_interrupt())
>> +		return NULL;
>> +
>
>This seems too broad, I would just drop this hunk. It seems unrelated to the fix.
>IIUC we only need the bit below to prevent the original NULL deref.
>
>pw-bot: cr
>
>>  	rcu_read_lock();
>> +	if (!task_active_pid_ns(current)) {
>> +		rcu_read_unlock();
>> +		return NULL;
>> +	}
>>  	p = find_task_by_vpid(vpid);
>>  	if (p)
>>  		p = bpf_task_acquire(p);
>

Right, the NULL check alone fixes the crash. The async-context guard was
added on Yonghong's v1 request: in softirq current is unrelated to the
packet, so the looked-up task is meaning less even without the crash.

Drop it entirely, or keep that intent with a narrower predicate?
in_interrupt() is also true under spin_lock_bh(), so !in_task() would be
more precise.

