Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBD2F1FFC
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780863953; cv=none; b=r1N2cwgaLhv8Z4Y6zjxp5BYP3E7aoAvwYq74CY/m0Y1qwZXh16+lg0g9BdRYCovIukhNMg7zzo1tx03P1syZiIV1KHa+0TJD9I1LlmjncQm3/W3pTJwaDVz6ksjQqCV5y6WZQit4OyJE6yEOx39NHUZiH6apJaUN8MY8PPF0xJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780863953; c=relaxed/simple;
	bh=0AYM95sf3V55Wu1pVp1h+t5ELZfMN4ZP9zwhTo8B6vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iynq8Arov/wn+Qh2lKgmOHt9viuq2XgfvcwyAgQL+eA3l2VQXlrufx1kLDMXRLKCQ0Jltzy04Ahyfe8x+QmDr4zR7QyNZjmI4R1LipWW3EayujAhfE+Ka52cEeY3kcIJfZ+kuvNpczrAh85bB3nNP3j/K++LlcG1lsJeld33H70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVIMwBec; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVIMwBec"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so7117536a12.1
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780863951; x=1781468751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aE6bEbXxAkV9gyfWuq9igYhJmeyZpDNULoO8JLGwBBc=;
        b=VVIMwBecVmZN3EcLh1WYtBzViz6W+JjXCYVYR9Yv4WC0m3oVJCi8Guxk6Krug3KV1I
         gdhMJJJFNDb6un1rzw0J5Uy2ekS53k8+GJsRnBblW1adCFB+W4bW5CXZ2Eg6Erja80jz
         dwI+RDoARpG6guJrcrG7m6oMZUT/zgCWyO2nslPWS3FvE6b0NgvM6Px4p8lG4IWTMRAF
         4IeVsF+7p4AjGHqjDyT0N2x2uS2/NOJVEf4POEDfaje9CVjSQCsynlK3IV1bbkCmSmHO
         wkrJo2ZcfSk0h7LwxniM+ZSuo9EmB74Us/4uzYu3YXonb3qrrzyxx7BrKEeZz+40fMHU
         RhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780863951; x=1781468751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE6bEbXxAkV9gyfWuq9igYhJmeyZpDNULoO8JLGwBBc=;
        b=U5KMFmciV/2vnwMJtohC04S/MInMlxhZqxJ2aCyjiC5IN0ysv7Iy5gq/EelvMHgSwh
         7x8nRQjABi+h3QyphXGBeqyhfSi5q2PzwPYpx1SE6bMJmtXonUEXGwtUYpV5pCBFtFUF
         eWxY87YpULJhA5yfamKtI1t06Z/PGC1MO4oPc3LlnkHRue/BWOQLVN9u9tEiy52pwBMW
         dnrlFVgVKOOR/Hq8f1U7WPefRf4SdhUo2DcTFVYxaosEHNVcVKOK3VqfAgQut+j7ykDU
         /pJwgQSrJI1ZJcb1ZBewW01fuHOGS/rnHNQEUi/UT6yVTN/C4qqPe+oyTRNtcLEciswU
         LVsA==
X-Forwarded-Encrypted: i=1; AFNElJ/wGuKynYK8f2X2EWwUOOXqAe1SgExTLFxh1fxTEKSeYxRsc8ys3XtKPyEx7l/CL2jcKtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xOw4VcgOXpVPFzEgG0W92PkaD/wuAphN+Ou6LnFN/umLYhwb
	Bnabn4qXB+lb6hl0mmi6wNTAuQYjlaoy+MzjO8A00FfPYfcvlAQM+rVb
X-Gm-Gg: Acq92OGvfxWr/XLm/e63WRkeM/G1L6tv5+elE98VOqKGa3oDiBhHRyEhA0ujEEh9hm9
	YwcK6XkawPpqiWzNWYeRWHVOTXK3OKGdJ1OvWYa+tV4UU1k9r9BemygVPkj8hqKvgugIScvYl3q
	XlA2wHZhwkY2jF3BLn+7MAruvjOLJogSTx7r0S0wyswiS2qWZQefGVFMUuTkDEK/UnIebjy1Sk/
	pYh8UBkLwAEBXyxED8AGj4ZT76xfZ4YtXeb9G/WXoQDpSUAnbOTVyQyuCaIIimdvulEBsxpP+hK
	3MbikJleef3x5/8laASQypFOdyY0xRj/OTzQKy6qzPJ/OV2gaFwl+YtlhstbCL6WQmtLcgPfNL/
	xmRo+PJsCq0tOZe5iyVmb/R4PkdPR4rymnNyz3YcETqki1c2Mn9nGNONJbwsZfQIwT4b4E1qSc3
	kK1q4/dN4jADPAhEAt3wIsd+gn8CCqwMamlEvE8ePDJrQs4eB1sEC/DH10nTfb50eBk/2TCrkn9
	waagY/oI6GjXeKdZuLI6w==
X-Received: by 2002:a17:907:704:b0:bec:2d9f:2aa7 with SMTP id a640c23a62f3a-bf3738f975fmr588322666b.24.1780863950676;
        Sun, 07 Jun 2026 13:25:50 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05176ed22sm762764866b.6.2026.06.07.13.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 13:25:50 -0700 (PDT)
Message-ID: <2f88db13-a881-429b-98f2-9fbb311b2ff2@gmail.com>
Date: Sun, 7 Jun 2026 21:25:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 1/3] bpf: Fix NMI/tracepoint re-entry
 deadlock on lru locks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
 syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com,
 syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
References: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
 <20260603-lru_map_spin-v2-1-7060cfb6cdac@meta.com>
 <DJ1F2K7SET77.3JQ2IJHY6H584@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DJ1F2K7SET77.3JQ2IJHY6H584@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 10:00 PM, Alexei Starovoitov wrote:
> On Wed Jun 3, 2026 at 11:55 AM PDT, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> NMI and tracepoint BPF programs can re-enter the per-CPU or global
>> LRU lock that bpf_lru_pop_free()/push_free() already hold on the
>> same CPU, AA-deadlocking. Lockdep reports "inconsistent
>> {INITIAL USE} -> {IN-NMI}" on &l->lock (syzbot c69a0a2c816716f1e0d5)
>> and "possible recursive locking detected" on &loc_l->lock (syzbot
>> 18b26edb69b2e19f3b33).
>>
>> Prior trylock and rqspinlock based fixes (see links) were nacked
>> because compromised on reliability.
>>
>> This patch converts every LRU lock site to rqspinlock_t and adds a
>> recovery path for some failure windows to avoid node leaks.
>>
>> Failure recovery:
>>
>>  - *_pop_free top-level: return NULL; prealloc_lru_pop() already
>>    treats that as no-free-element (-ENOMEM).
>>
>>  - Cross-CPU steal: skip the victim's locked loc_l, try next CPU.
> 
> These two make sense.
> 
>>  - Post-steal local lock fail: publish stolen node to lockless
>>    per-CPU free_llist; next pop on this CPU picks it up.
>>
>>  - push_free fail: mark node pending_free=1. __local_list_flush(),
>>    __local_list_pop_pending() reclaim the node from pending_list.
>>    __bpf_lru_list_shrink_inactive() reclaims the node from inactive
>>    list. Nodes from active list are reclaimed by __bpf_lru_list_shrink()
>>    or after __bpf_lru_list_rotate_active() demotes it to the inactive.
> 
> Here I'm getting lost. Feels like either mechanism free_llist
> or pending_free trick should do it.
> I don't understand why both are necessary.
> 

The free_llist change was introduced mainly for the steal path:
the node has been detached from the victim's list, but we can't 
attach it to our own pending list because reacquiring
our loc_l->lock failed. We stash it on the lockless free_llist - otherwise
it'd leak.

pending_free is used when the node should be freed but we can't detach it 
(failed l->lock), so it's marked pending_free and other code paths do the 
deferred detach under the lock.

> Overall it makes sense, but I looked at this lru logic long ago,
> so please repost without RFC and let AI find issues.
> 
>> @@ -318,8 +315,10 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>>  	struct bpf_lru_list *l = &lru->common_lru.lru_list;
>>  	struct bpf_lru_node *node, *tmp_node;
>>  	unsigned int nfree = 0;
>> +	LIST_HEAD(tmp_free);
>>  
>> -	raw_spin_lock(&l->lock);
>> +	if (raw_res_spin_lock(&l->lock))
>> +		return;
> 
> just return? I'm missing something.
> 

No nodes have been moved yet at this point, so failing the lock leaks nothing.
The caller (bpf_common_lru_pop_free()) continues with __local_list_pop_free()
(which should return NULL), and then falls through to the cross-CPU steal path.

