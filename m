Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64573CFF69
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893140; cv=none; b=SAgqa9xqYMqUeEqkhZhWvf3zWr6Mot16y9GE/LA1l9cRjRCiFl2lbYDRNmpqgJ7QQ3bLR6HhjCx4Fq5idEiC6ZhuSThbQmCyLGe+yLwNcVCFp68F1s+WLjJwRGOlsF9BvTTsizpcaN9f+wRi6Z/wuMN/xbxOstVElzKfhT865jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893140; c=relaxed/simple;
	bh=q40Bb4yC1vFYL4hBSNZZ2fpYSivOYbdOhfcR/WTvBWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMAv/mmiG6GBuyXqXhwOVcpTWPdyupabFv3TRFtLRdQi3tkSzDIKtU1zfWrnoGxm4mSgip1N4WLPy//cf7HN8bJbUQnjrkubc6p51Mz8Mwk4OgnsB5su8qDe0wiUFnFgEoQAR6d+SBgBDNd6gY7wa8JME2D4/EsHThMZOgrANCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu/Dm7+y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu/Dm7+y"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-380544d00b1so172713a91.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782893136; x=1783497936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATkY/UkeDjPG9vR3v3KTopmQsHuhM0ifXwleHL+P32I=;
        b=cu/Dm7+yR6b7woGIFTN4iwA1lTHv/yqvmJQdeEdh8yTUQZqofimME2kD3HDV5KJAYx
         PGAA9ZxMku69aRs1DSXPgTixmNRwfgI1z52YRzwnxTULKm7ss5ygETDg/t/+kFS7ng6p
         /SP8mC8nsTeAFB7SmXeha0oQFZbt/jQPYJ73ZhfLU6rnA88uuR2CXyP0obM7J+iLwTpX
         bvMDhmvLilxOQjk0ggffG26YIOu9t/yRs26oBBciy9DnmnxQx6os+zHf+izDLq4GVxOS
         Ow+OW7sxts7ZqhPsQxeFRzDyXf9mG6jmumjjYohYjkxwluSBrBHhUQL4JtSpfQiTiQKf
         UZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782893136; x=1783497936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATkY/UkeDjPG9vR3v3KTopmQsHuhM0ifXwleHL+P32I=;
        b=nU1wGrD70jZj9rJlNBLyqU3Zm/DFgL3jBzQ66G4GF/YmqKurQ2n6ufgRiOAUnbeUXV
         rYkIvRorz3a5j8osIOVEej0GOw221QZx40EL9HdnMzIDTkgPGbOtLtbEpwn8kfhypGwq
         7MYB4AcOEeoOC4qfrmgJdz1ZMOxpkWvpEajx9en1SgSBaNSc+6j1zieyimW3tZEH1ihS
         rGgaNc6lzp7Os2HWnV7M1VIwDvVBBdcZtZitXLBbe8KCYUAeIGF4UzfnpWtV38SbQSp/
         KNXqui8HZQ9SVK/ZBCv/A1qvaFuD8tXxnYu3GhGHY/+1U5Nu8XkVtXcGN2Cb6PDQ2EAr
         DM4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpIGmy0ACNodoct+W36Y0XN/7GDf5zUPJDT9b1yhv/qojLdrWXPgGcW2xtk4ppp9F3Oi10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLThgvqaop+p5uNnTgSNFcCA4EY4oA52dStXiGQIfN5M2Wcc7Y
	EAQXrZO35X3pqmGDTRB5NbrIwN1uVDC3zHVf05v9EyZkIRuySVkVBXWJ
X-Gm-Gg: AfdE7cmCc+RETXULgltJjK14QGNHqyAtU4gvVltx7g9mWitD4sMaHMq9w8WIbNo1KZ1
	f7kn63/kYz9zeH6YylE1nBtai9+B6glO4eciNQmeJrCF0AcpslVBkr4I+yDpVe7JL4pCGCtShRo
	+MaafPG6W6GtHYgaSrDkU73FiJywlKqqLugn5HrCWZplAZVR8prJOebFm4WLXvq0j/EbNSYAwHJ
	aUG9EcHBsWvICsRHGysrUcth86D31M21dzSTwpVtxWkknyyrPrXtal1rIR+qvUPzxqqf2PX2j9s
	xEGLgM8YQAJRxjsxrtm4yNFxk2xPpl9KkCsY/dqY5tgf+g8NIDwcMBAJiJr8L/vBM2GA3yl7qPa
	QELStiiwq9blXRf2C0rMs8nSp8cn2xl51wxWKjNL5XPEn3oNw9s/RIJAQQ5xdq8YmOPfP0GDRng
	BzRJUGwI/NYdFtbH40u89b/wYc2u8Ftke52mm7jYeVgtjXIsHh
X-Received: by 2002:a17:90b:5250:b0:37f:caf3:171a with SMTP id 98e67ed59e1d1-380aa0bd23bmr605211a91.4.1782893135604;
        Wed, 01 Jul 2026 01:05:35 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097da1a0fsm380096a91.2.2026.07.01.01.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:05:35 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:05:23 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: move security_bpf_prog_free() out of RCU
 callback
Message-ID: <3o66qg4u2op5x4qnqehhf52zctn4so62zqxk3ib4llfabc6ctx@gxnstpfvhqjf>
References: <20260626093711.2969648-1-rhkrqnwk98@gmail.com>
 <DJMRMXI4W803.1JAJC33ATPG1M@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DJMRMXI4W803.1JAJC33ATPG1M@gmail.com>

On Tue, Jun 30, 2026 at 04:17:26PM -0700, Alexei Starovoitov wrote:
>On Fri Jun 26, 2026 at 2:37 AM PDT, Sechang Lim wrote:
>> __bpf_prog_put_rcu() is the call_rcu() callback for non-sleepable programs.
>> security_bpf_prog_free() called from there fires bpf_prog_free in softirq;
>> if a sleepable LSM prog is attached to that hook, might_fault() BUGs:
>>
>>   BUG: sleeping function called from invalid context
>>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5038
>>   preempt_count: 101, expected: 0
>>   Call Trace:
>>    <IRQ>
>>    __bpf_prog_enter_sleepable+0x1cd/0x320 kernel/bpf/trampoline.c:1255
>>    bpf_trampoline_6442549705+0x53/0xd7
>>    security_bpf_prog_free+0xde/0x130 security/security.c:5465
>>    __bpf_prog_put_rcu+0xab/0xd0 kernel/bpf/syscall.c:2365
>>    rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>>    handle_softirqs+0x236/0x800 kernel/softirq.c:622
>>    </IRQ>
>>
>> The call_rcu/call_rcu_tasks_trace split reflects the freed program's
>> sleepability, not that of any attached observer.
>>
>> Move security_bpf_prog_free() to __bpf_prog_put_noref() before the RCU
>> deferral.
>>
>> Fixes: 1b67772e4e3f ("bpf,lsm: Refactor bpf_prog_alloc/bpf_prog_free LSM hooks")
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>>  kernel/bpf/syscall.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 630d530782fe..f14c3f0f8827 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2362,7 +2362,6 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
>>  	kvfree(aux->func_info);
>>  	kfree(aux->func_info_aux);
>>  	free_uid(aux->user);
>> -	security_bpf_prog_free(aux->prog);
>>  	bpf_prog_free(aux->prog);
>>  }
>>
>> @@ -2378,6 +2377,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>>  	if (prog->aux->attach_btf)
>>  		btf_put(prog->aux->attach_btf);
>>
>> +	security_bpf_prog_free(prog);
>
>I don't think you can just move it like that, since LSM side
>may rely on RCU GP.
>I think removing security_bpf_prog_free from sleepable is cleaner.
>

Ah, that sounds right. Will fix in v2.
Thanks!

Bests,
Sechang
