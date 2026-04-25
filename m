Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0930F94D
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152573; cv=none; b=XESURrTg23oBZ9ZnTHWVbwyHSaZMfu3gRGhw5KtM3SJGt5Kz6yOFmuh0jUbuN0TQVkf+lEfIL3FrLf5SMJvTpaBhl/1dd/pC5DB2m6MsQIwc3O+leCnMiCgLRBpjafZ6LWjV83UOPjtTua345XfjtdTUuYzCAbfa4gYR4QekTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152573; c=relaxed/simple;
	bh=qc0mVPQyGh+SW7E35KSMO6uJugzB5IXY33WJQgWPiaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWmYSRoHtvdh9G9j4Xx0UEGbW41RGITiXKKt5aS2SS66nABHVfucnWkTXW377ABInNMIVCT5w9kd04gD+GgCrtlgq9ANTnFL9YW8Y/RrlsTXGS7YH+Ir94UjtMNteJ2vSuy86HK0C3zU52Dfpz/7lkECXVL4GA1FL5nWOzGxGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJPDpwc0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJPDpwc0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso82896885e9.3
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777152570; x=1777757370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+F6/9VY5tZp7f5vfaYUJsGaCr+Vq/4Qqd1ilzezcj0=;
        b=NJPDpwc08JrOVywpGcGL18JOzjAqMROjHSO8xnfrB1gqet/DY+AJiEJH530NY/VR5X
         nvum2lVVgyC8oRdyQK1ZWOMgtwHIs5qlTXagNGgjbBO8EF25JOu6qq+hKbvoMbUw4K4K
         ahRFOUzN3VZSCYD1PemTMllgu9JfgT0J/xwP5m39N0bqNWj/0rlPB6YANCgspB0Wcpem
         d1CZ+/K8Xd3MbCUtltgUMWtgTIRKxr8szeSbdNhP6yUfN2cdjJpYiLWsiE2ZQ+uSt0ux
         jCwXYWFR2lMR2yxHu3e8mhKOIVKR1VEp0MFJmZhUd5QlPpePbl255laPgX3i9l8mmznL
         JSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777152570; x=1777757370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+F6/9VY5tZp7f5vfaYUJsGaCr+Vq/4Qqd1ilzezcj0=;
        b=kO/dkAzInjOqUaibzYhgAwd0DfuzQVdaQtkMQSBcKsH1Og1wJV72tY0v4c6UNKsZuk
         8vrI8jVz2qvaM/cSw0DGC0Tbdymc1KgK1VwS1Ba26zKYmL4pWGWb9CPSTJXLHFt72lPG
         I58R/kqXnyowf5RGzGiPrp0diuiBh6xApOIA48rR1n9Kc8BFouegyC9Xj0wfjs+WD9ah
         T9qr7R29yxDUiiNyRE6aOFdtirMUYOKNkj4rmuAHecfbGvz4skn6RYasTZygiWEa94y4
         hYKUHkbkiYLqDjeOG/eCqhWapOPwy2CPsZesVZIc3AzjZtB8EkR2kA+lL/rKU6+HcMA3
         p0og==
X-Gm-Message-State: AOJu0YweZmzqeO8ocPnCXmTbgE/NHYEeqoHHVJyNjD7D7VdslzE/8cxZ
	h8Fyf3FLS6gClc28T8uPvAi7BkC/S+1XU+YitrwYdtQc6hiBxhRWEHWT+LnQHg==
X-Gm-Gg: AeBDieuQZzKFL9A9ynNgxjSgdST1FhB8j5WgD0e7iTGYetln1GatyKu5keF4+bKZs8N
	xR+Fda/egD1C4HkMRsSxKd800akr7NaB0LyBfabcWe+PLhyq3hH0sKXkPit+ub4Ce3OCmpOPsiy
	7WZvHI/XbMP5FtaVKw0EtWiMD7sFfp7pb9S4nG566KO3B5xo2SR6XhxMATRnyKwMzGj7kuRHMvp
	T1sEnLV7P689trreR3pLWvfshk/BnSQG0p2Zt6ztVIT7S+tlM9bEo4XEicb+ti2Wd6SSx9qxZyT
	cYQPnKi6Noho/D4Bo+Dm1xy/L2dZy7LyKXWPjASBgMaoIWvRatAiXYe+LrzJis7QnrC/LmHSrNf
	e5TtbZnZpK6xLlV/+63qQxIsTGeGySf8NO/76qA9DFjRBFes5TE1bm0ZpJeCDgiGF7l71giyM+t
	hs+kZ3OVewBDsy8AIrBL/d1NQ+RS78l077iaRi3/Mrcc4tcxKaRO7dJ/wcdsFlYUuGgUab9QyWP
	VlE6wUsTSCepHNmB4IjTxylCMad9YKM
X-Received: by 2002:a05:600c:828d:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48a568fb048mr311015995e9.8.1777152570208;
        Sat, 25 Apr 2026 14:29:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm567441425e9.12.2026.04.25.14.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 14:29:29 -0700 (PDT)
Message-ID: <464871b4-c7e4-4e71-98b9-a2cb48531640@gmail.com>
Date: Sat, 25 Apr 2026 22:29:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 05/10] bpf: Allow timers, workqueues and
 task_work in resizable hashtab
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260424-rhash-v3-5-d0fa0ce4379b@meta.com>
 <20260424210537.57D82C19425@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260424210537.57D82C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/26 10:05 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Unbounded iteration over the entire hash table inside a single RCU read-side critical section in `rhtab_map_free_internal_structs`.
> - [High] Race condition in `rhtab_map_update_existing` allows concurrently initialized special fields (timers, kptrs) to survive map updates.
> --
> 
> commit 1516bbfa3123276ce6abdd224ad40eb2ca633302
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf: Allow timers, workqueues and task_work in resizable hashtab
> 
> This commit allows resizable hashtab maps to support deferred callbacks by
> enabling timers, workqueues, and task_work field types. It also wires up
> bpf_obj_free_fields during element deletion and map teardown to properly
> clean up BTF record fields.
> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 000caa2c7f4cd9..ba03797b896020 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> [ ... ]
>> @@ -2945,11 +2944,15 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
>>  static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
>>  				      u64 map_flags)
>>  {
> [ ... ]
>> +	/* Free special fields, and reuse memory similar to arraymap */
>> +	rhtab_check_and_free_fields(rhtab, elem);
>> +
>>  	if (map_flags & BPF_F_LOCK)
>>  		copy_map_value_locked(map, old_val, value, false);
>>  	else
>>  		copy_map_value(map, old_val, value);
> 
> Does calling rhtab_check_and_free_fields() before copy_map_value()
> create a race condition with concurrent BPF programs?
> 
> If a concurrent program acquires the spinlock and initializes a new
> timer or kptr right after rhtab_check_and_free_fields() finishes,
> would those newly initialized special fields survive the update?
> The subsequent copy_map_value() call intentionally skips special fields.
> 
> Should rhtab_check_and_free_fields() be called after the copy completes
> to ensure no concurrent modifications survive the element update?

Even calling rhtab_check_and_free_fields() after the copy_map_value()
does not guarantee that concurrent BPF program does not hold a pointer
to the value and uses special field like timer.

> 
> [ ... ]
>> @@ -3033,6 +3037,25 @@ static struct rhtab_elem *rhtab_iter_next(struct rhashtable_iter *iter)
>>  
>>  static void rhtab_map_free_internal_structs(struct bpf_map *map)
>>  {
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhashtable_iter iter;
>> +	struct rhtab_elem *elem;
>> +
>> +	if (!bpf_map_has_internal_structs(map))
>> +		return;
>> +
>> +	/*
>> +	 * An element can be processed twice if rhashtable resized concurrently.
>> +	 * Special structs freeing handles duplicate cancel_and_free.
>> +	 */
>> +	rhashtable_walk_enter(&rhtab->ht, &iter);
>> +	rhashtable_walk_start(&iter);
>> +
>> +	for (elem = rhtab_iter_next(&iter); elem; elem = rhtab_iter_next(&iter))
>> +		bpf_map_free_internal_structs(map, rhtab_elem_value(elem, map->key_size));
>> +
>> +	rhashtable_walk_stop(&iter);
>> +	rhashtable_walk_exit(&iter);
>>  }
> 
> Can this loop trigger RCU CPU stall warnings for large hash maps?
> 
> The function rhashtable_walk_start() explicitly acquires the RCU read lock,
> meaning this entire iteration over potentially millions of elements occurs
> inside a single RCU read-side critical section.
> 
> If the map contains many elements, looping without yielding could block
> RCU grace periods for an extended time.
> 
> Would it be better to periodically drop the lock and yield, similar to
> how other map structures handle large iterations?
> 
yes, I'll address these rcu stall issues in v4.
