Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746778;
	b=ZD3nPEO0i4Kz69JBa2dwWdwdu3uddHQU/cNXHdoIWw5n+ue2HKrYW3XglintUeh2e8xP
	 UJxJT39Vc7PzTxdwNdcNbqf0EjKEZl6V9W+IY98Nz+kJzqvd5Fr2C1JEEu1xsNd3FsnlN
	 WL13zXHqgXvtQ/dQhsvmSfbCR2psVp/2yLj3/OzuBS0x8NbBoCB3x8guXCT+rSpa8Autx
	 77l+at2mOQiD9MIz77QaVDSgQ/4z1CiP5nkXVElFsbftaGI7tNChNXz7tvhPin5DGxHr8
	 2sEEQkpFw+aclW9p69rE1fv9nplLS3rjincdR5IILYliInkBz+znmRZGgJXNq3unC3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ydMMlRlvKD4+ZXddDB+MGj/bQlE9snOtIjTCA4e2fWU=;
	b=JCfp5mh/br0FFnf22CqDUcSmUOzM+xumFUApOyO+zP6Q7Qv6nTyPusszf5MtLvI2vWc9
	 RsHEJXkzAkt4C0zq4faD7dyNUSBPT+/DdrJwwO2TFDd0X6LV0V5ATr5gwJjP4LFcL6wr8
	 qESyc1+cvPfT33dFM8hV4QVephm+5qxxpKLQdD27Aq/lC/4s7hYpbl7lbIrYZQAweqbk+
	 jCGPfLaZwDwpe9rvU3F0odbxhSduW3564dpw3QnRC4TclFFJLqjKo8revaIRXQXLP5StS
	 LzoXSJTLq1/xB3N+DSuNvsTzijd45L1azcjMfAbcxclnMuqlnjGDYyK6hGT5hbr9zDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ce1Ey9AX;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C2606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 22:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE5C2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ce1Ey9AX
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so498765e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 14:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746776; x=1794351576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ydMMlRlvKD4+ZXddDB+MGj/bQlE9snOtIjTCA4e2fWU=;
        b=Ce1Ey9AXuoGoy8R3OFsrW/g3ms2+IN1O1kCcz8hXtzkqjwqPm9+G6tGeTMYc1MQNlb
         9fQ/y8Ogxhg++9Xqs59KzK5peKTA4Vk+Q8jKEouA5x7TNt7eKtiOVZoFrjTYWWrXW1mu
         yENPPIcShwYgWPMWgHg2dXkCVGXA3l4YI7IEpLtKHFE3mDbrd/ysIyknWe6GeFlPs/TW
         tGbEB/80DgO321y4UPBSsz/tLQErFEv16HXt7haebR5AZyGr0SAZskA9lFHNTa9iYIqH
         23Ow+ypEb8iLfYC3lbItM0ic8A+bNd1w5xEgRbp/Hk0WLI9Tc2H7vmtkwWYG1lAo49F+
         ioTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746776; x=1794351576;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ydMMlRlvKD4+ZXddDB+MGj/bQlE9snOtIjTCA4e2fWU=;
        b=wdWw/23K+ZC60cEvuVG4uPeppXokEp4s2ChJ+Dv0Rgil2xVzx0ydV71FipPpp8c34A
         ph+3C4lRkm2LUiMwS36OsdVg/RMqbiB7blbg2I07Wkuhax+1iiNRJQdp/AAYgCMrUDoP
         xrTvnbeTx2cvuWfXvgx7Qf+dJA1/fbytu/4Y3pkvsNcfR4dQRyqKDD+UUw1PpPLWwMUe
         /FipkhFgegiqyMUqPKjdw+TBd4yR1tg29Z+O9HUX/EPrUJmIhuYtE3ytLTPCsgqGP/sQ
         w5Cp2cBkpOIwcONBZN9x8Fz2aZTFlfQuAy131jUpCotKia75iMRrPAcpszCdVsvnGRYn
         rOtQ==
X-Gm-Message-State: APuU4Z+O+ZVPznBMhjTx5QPEFDpzsoh11a4/6tB+o5o+lL7cjrk9HgiB
	G3WcA52fyBZVgqFpvNhOU3d2ioVBcsGmOCMdeLVf2y6EvHEXJ+mHfIp0fb9cNxpAuWU=
X-Gm-Gg: AYBFou0abyelhlyNfdrrq2dlpmttf8O7dsbjnxhc5ssbKezGPFjVOAWVJifWDhzfTDC
	wSEvqM92OOy4dLhGYAa6AbzDtT9ugr2wW5KaEcaxhBheGPJ4zUHRkhf4AOyi8no9+xJE0lxtacO
	bnSXaZF1kp8ZhjHhOz0nLEV+vNyfz8H0G80lJdNJek8EXxEc6KxyR6ViPZfVKLPbN/dipWtVIOf
	DsYKJiMpVVCqCLA9OCHCgzugkwzreac7s3OjyNAMKMQTDJWK//Tbynb7hzrIKMDlUQefawrcT1L
	JtmB3BizCGdW+hkO1iovaO76GdFimK6jn0BZYJx2iuusjRbNV6fMP7wmi2KgU0HnRgLhEGcKDjg
	fZ+KVlyG6FD/mj+gEd3pkTv2+OrpWMtrShAqJ7ngxXNDt6mWno0WVM/X119mO5vUW0sgNmO5kNV
	KoyDNgKTbjyb13JhwFeh3K7oq5c3hWsjVikq0afWifHVuip2IE2zlbV8IRvYEJrINKAwzK2dO0Q
	Kaz3rmEhtwQggYSQthXMdNFljbaHp/bY4EwROEs1FUMwjn1dzae5O8HR3RVCflWWOqqzfY1aiLw
	FDQongGUbOQpTxFzhQJwcCrovItzegWJCzH9vk/RPmR5xqH089zW0hNdbJ37CPXqBKKLqOlubsy
	nSdlenEMf1+w=
X-Received: by 2002:a05:600c:8581:b0:4af:29b9:32d0 with SMTP id 5b1f17b1804b1-4af29b933ddmr187445445e9.32.1793746776047;
        Tue, 03 Nov 2026 14:59:36 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab3ea6a9sm132321295e9.15.2026.11.03.14.59.35
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:59:35 -0800 (PST)
Message-ID: <77c77ec9-4a89-441a-a929-19b7f2cec689@gmail.com>
Date: Tue, 3 Nov 2026 22:59:34 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fail rhtab inserts and deletes with IRQs
 disabled
To: bpf@vger.kernel.org
References: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/26 6:46 PM, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> A BPF program can spin forever on a resizable hash map's bucket lock
> that its own CPU already holds.  Inserts and deletes take the
> rhashtable bucket lock, a bit spinlock that can't detect re-entry.  The
> resize worker calls the hash function with that lock held, so a kprobe
> program on the hash function that deletes a key of the same bucket
> never gets the lock:
> 
>   rht_deferred_worker()
>     rht_lock(old_tbl, bkt)
>     rhashtable_jhash2()
>       kprobe program
>         bpf_map_delete_elem()
>           rht_lock(old_tbl, bkt)
>             /* spins with IRQs disabled */
> 
>   [   29.890449] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   ...
>   [   29.906964] NMI backtrace for cpu 0
>   [   29.906977] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
>   [   29.907021] Workqueue: events rht_deferred_worker
>   [   29.907041] RIP: 0010:rhtab_delete_elem+0x15f9/0x1c80
>   ...
>   [   29.907139] Call Trace:
>   [   29.907145]  <TASK>
>   [   29.907193]  rhtab_map_delete_elem+0x61/0x120
>   [   29.907208]  bpf_prog_12e9295082de5b34+0xa0/0xee
>   [   29.907231]  trace_call_bpf+0x2ca/0x930
>   [   29.907334]  kprobe_perf_func+0x106/0x700
>   [   29.907381]  aggr_pre_handler+0x8f/0x110
>   [   29.907403]  kprobe_int3_handler+0x335/0x750
>   [   29.907433]  do_int3+0xd/0x50
>   [   29.907445]  exc_int3+0x165/0x340
>   [   29.907467]  asm_exc_int3+0x39/0x40
>   [   29.907477] RIP: 0010:rhashtable_jhash2+0x5/0x360
>   ...
> 
> A program in NMI over any holder of a bucket lock can do the same.
> 
> A bucket lock is only ever held with IRQs disabled, so return -EBUSY
> from deletes and from inserts of new keys when IRQs are already
> disabled, like the other hash maps do on re-entry.  Lookups and updates
> of existing keys don't take the lock and still work.  With the fix, the
> delete fails with -EBUSY and the resize finishes.
> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 1s.
> 
> Fixes: 16b4d3e2fb24 ("bpf: Implement resizable hashmap basic functions")
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> This is the check Alexei suggested on the RFC of the series [1].  It also
> stops perf_event and other programs that run with IRQs disabled from
> inserting or deleting keys.  I can turn the reproducer into a selftest
> if that helps.
> 
> [1] https://lore.kernel.org/all/CAADnVQKvp2tnQSWW4Kh3ofGLvaEYJ47kyZeNUscAH_DShw8XHw@mail.gmail.com/
> 
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/rhashlock.c

Thanks for the patch. Looks good, currently we rely on bpf_disable_instrumentation()
to protect bucket lock from re-entrance, but it's not called by the rehash, which takes
the bucket lock.
bots highlighted another problem - potential infinite loop in the lookup. I think
it's a separate issue, that needs another fix, as we probably want to keep at least
lookup in all contexts.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/hashtab.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6e2115477cb9..1a9f07b71bca 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3144,11 +3144,14 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  	int err;
>  
>  	/*
> -	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
> -	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
> -	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
> -	 * raw tracepoints, which we don't have in rhashtable.
> +	 * rhashtable takes its bucket bit locks with IRQs disabled and can't
> +	 * detect re-entry. With IRQs already disabled this CPU may already
> +	 * hold one, e.g., in NMI or in a program attached inside the resize
> +	 * worker's locked section.
>  	 */
> +	if (irqs_disabled())
> +		return -EBUSY;
> +
>  	bpf_disable_instrumentation();
>  
>  	if (rhtab->map.key_size == sizeof(long))
> @@ -3261,6 +3264,10 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
>  	if (atomic_read(&rhtab->ht.nelems) >= map->max_entries)
>  		return -E2BIG;
>  
> +	/* see rhtab_delete_elem() */
> +	if (irqs_disabled())
> +		return -EBUSY;
> +
>  	elem = bpf_mem_cache_alloc(&rhtab->ma);
>  	if (!elem)
>  		return -ENOMEM;
> @@ -3268,7 +3275,6 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
>  	memcpy(elem->data, key, map->key_size);
>  	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
>  
> -	/* Prevent deadlock for NMI programs attempting to take bucket lock */
>  	bpf_disable_instrumentation();
>  
>  	if (map->key_size == sizeof(long))
> 
> ---
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> change-id: 20261103-bpf-rhtab-irqs-disabled-c4646c9e0fe2
> 
> Best regards,
> --  
> Mani Tofigh <mt4022@columbia.edu>

