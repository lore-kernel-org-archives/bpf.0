Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F192701DA
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622821; cv=none; b=eVSyUZx7iobFo9tYP3HTMMoeynSAsx1TKVYg5OtEqSVO1cJwLCQ6gYj79WuvfG37BMn1tu/XRxkDtaLYLZ5/sqldL3uLHYNe7VYuoiCWVlQMzkpcPBraHLlIA7vcs13uK0Bux4aoLbWMINMuc/owLagLXF2M5XSS2cAO1xyaPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622821; c=relaxed/simple;
	bh=g3ksIWwzW61/DSZ8056NoXp/hxo1dwFet4DkU1hfKeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMCMNAcffWjZPeyfUP8vvq++Qh2N1tpKd2VqgzBlMQu+saboZ99NeSJldYSDtCAox3c4TcNh8NUZeetnxIrsgW50qP+2HnpfGL95KeeP0yMHyAJyUXbOlUtjbogrRzFEpryF591G8sMvOqf2IGcCN9qEaH3NU2ocgAyxsIeILqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsrn/hkG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsrn/hkG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48538c5956bso21225125e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774622818; x=1775227618; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNlzl2JGxNn212yyZGPDbwZ4zn10Z40+YHWy82PSZGY=;
        b=Xsrn/hkGpOhzQc0fLy54NTYXDXf5gx+AfkafX2aDh/X5N4emL+WQ8kjMDu70RuXD2H
         OLmKmquoltKnq8aso71NERuFCj8fq7EHe2StQYE5jFML5mF8sVSG0rUEnNyLDLSYrRS5
         vFaG/TdHDt8NFp5agUlnidCkU7k+H7nNF0tU+ISf/pJDYLp51Bw2I9Uf6/L3M8ByCtoM
         U8Ix4nzxHdrMR1FtrOO3ZCXFmpe0GDEjJp9JK2LZ7KpuVUdyT4hFnchEajkR1RvL0Ya5
         Tove/YiudFCiCFXBTqNup8x3zxy+Ip9cUrqNOMwe67S0fSw2Jj4MhV46ii+vuVugDQHm
         XgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774622818; x=1775227618;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNlzl2JGxNn212yyZGPDbwZ4zn10Z40+YHWy82PSZGY=;
        b=EZ6/PzVhAaXADJ2IXDb1v0N0XqLV6nIHegNAe0uVpnwVlII9r/1ac4CWOTjr8HjA5a
         lCL/LWdAVmu28xQJEjjPnvGP+TRofwND/dUSUOcQaFIPaymvNOFvZDtwK2/+zssUKnFO
         8JUIHtVnrhjsh+WAdPxZWJnOkDMg9iRlJUXbhGhabuHPgKLkpBqWadU3n33hdBXeu2pC
         lbZwJnJ5emaLTRn1+JVyLHLX2nj18CRfqzx39LL/Y1ppJ1SPScwzTi93bXGcUUmm+nZN
         qHYe7AKXJt5/KHC+/83eno+vHpYUKYHCWdrn64deHGYr6TjKmwc95B76xAT4VPpTWIt+
         7Qjw==
X-Gm-Message-State: AOJu0Yx33q8CR8QVH9UVvDMVCaofp7AZZEVt6kuIAJlnRQeCDkPQpNNc
	9GCjQq7XHValt+HAeHZyaoXQHCYOCEvRYXxvTD4xeu1KhdmMvinpnvIl
X-Gm-Gg: ATEYQzy2EUp1ZkIioTmxDx/wc2dBHAe5TVz/unw98Nv8YwA044G85flP89s/CIj5z/x
	J3rSeku49tra7e3zYKkYn+Y0Tg61gHh5ILfqt4s/ipnCbdzq8YCJnlNAkr1W2Ua65UywSAyrr/b
	Jx7LKcauwME1SpLD1WvdGBjdnBloE8qsFU2RA4+PyUWkGorqN+pF7sMBkthzY77IlH9Q0/ALGog
	hIft2iUVGCZF7dArzwgHW6NRDyNb5zg66FHZHExXI1Bj6sJKp/8O9Ifa08MaPsQ6HOeVXRUk3Xp
	dZLS6Px/RClGEZYgJvepr49NA5qCoYpVXYJCTSbCj8jklHjlxPrVd7ZONzQWOBU+Bmj1dRlZ0/L
	r51b83oAPj0NM7EETa4QyHzyBIWy5H4IVnsL1DsKy/tkb/J9ckUKZP3b/1mY9Ro6ovc2AmfMdXn
	Pf8vao69yvyaJQeBVNcQCqMDlYjH8+Bd7IdA==
X-Received: by 2002:a05:600d:17:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-4872911c031mr30272385e9.12.1774622818411;
        Fri, 27 Mar 2026 07:46:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c845b8sm90644375e9.4.2026.03.27.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:46:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH 2/2] bpf: Migrate dynptr file to kmalloc_nolock
In-Reply-To: <CAP01T74SDG+yAp5y3J7u_3=TtBporsykcnUCDnFsxKBVGTXeBQ@mail.gmail.com>
References: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com>
 <20260325-kmalloc_special-v1-2-269666afb1ea@meta.com>
 <CAP01T74SDG+yAp5y3J7u_3=TtBporsykcnUCDnFsxKBVGTXeBQ@mail.gmail.com>
Date: Fri, 27 Mar 2026 14:46:57 +0000
Message-ID: <87cy0pib32.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Wed, 25 Mar 2026 at 22:12, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_rcu for
>> bpf_dynptr_file_impl, continuing the migration away from bpf_mem_alloc
>> now that kmalloc can be used from NMI context.
>>
>> freader_cleanup() runs before kfree_rcu() while the dynptr still holds
>> exclusive access. kfree_rcu() then defers the actual free until after
>> a grace period.
>>
>> Add struct rcu_head to bpf_dynptr_file_impl for kfree_rcu().
>> ---
>>  kernel/bpf/helpers.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b197b6978f1a..b349c8a34e50 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1736,7 +1736,10 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
>>  };
>>
>>  struct bpf_dynptr_file_impl {
>> -       struct freader freader;
>> +       union {
>> +               struct freader freader;
>> +               struct rcu_head rcu;
>> +       };
>
> Sorry, this is confusing to me. Why do we need RCU gp wait before freeing here?
> bpf_mem_free() didn't do any RCU gp before.
>
Double checked, I think you are right, there's no point to do
kfree_rcu() just kfree() should do, as concurrent access to dynptr
should not be possible and after discard() nothing should be able to
access it anyway. Thanks.
>>         /* 64 bit offset and size overriding 32 bit ones in bpf_dynptr_kern */
>>         u64 offset;
>>         u64 size;
>> @@ -4427,7 +4430,7 @@ static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
>>                 return -EINVAL;
>>         }
>>
>> -       state = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_file_impl));
>> +       state = kmalloc_nolock(sizeof(*state), 0, NUMA_NO_NODE);
>>         if (!state) {
>>                 bpf_dynptr_set_null(ptr);
>>                 return -ENOMEM;
>> @@ -4459,7 +4462,7 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
>>                 return 0;
>>
>>         freader_cleanup(&df->freader);
>> -       bpf_mem_free(&bpf_global_ma, df);
>> +       kfree_rcu(df, rcu);
>>         bpf_dynptr_set_null(ptr);
>>         return 0;
>>  }
>>
>> --
>> 2.52.0
>>
