Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9886346A1B
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706855; cv=none; b=MKnPB+CypW5k/80PtBtPsQj2rBXw43qHbld5QuizN68Ul0y7WYgFN53Kit9lmUYzmpx5TjhrzTKRtFQSOoQfIvT9ocZHcmbOLByOhNTWIpLd/KC87VmyeOb9zDB43rn/EAAqzPKf8LNBBVWvkB0SYfAVBhPPWaIQ38fltOjY09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706855; c=relaxed/simple;
	bh=74EhMKTTzTUWmFM666Dx0peLK8qiWHcItix59C+owPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ja5+nVFypt1A6u7B0kLDZpqSyC78mmsNcpt3Gb9leXebmH5DR+haZpc39iSE2HndJs6OedEL/voZEvPmEfpSdm3PZzedYRzNEXr2zH0JcCYC4elxRKpC3UWHx2W0zZcM5DDI3+XN+yhquNBPyvnPOPka97WlYO/tV6WNQJp+SyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOgKuEFL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOgKuEFL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso12893765e9.2
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769706852; x=1770311652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhE/I+dmMmJ/eCvZyGe4V6UD2AvyycXLy63Ov5C2z7c=;
        b=hOgKuEFLsY3p4evOl14SoN1jSQw3eej4Pzyzi+thOxEoZfxHdXE2bEMnuDHiSce3qG
         6mSJdGyf9wEhXgWJueVDEBF7JYIYD7JsidT/CP17G5pQ/amUVhS1ZgE38rj/sJOsYWex
         gVCcoDm+jdrxMCZKkg3iKQVLymc64S6LYTRrZA+QKi0pdG1feirDjYp8rs85LUStC3Du
         zS5grbLO3EVx8FIRQmbt3Jlj7X/13NYyW1tkQMMmulq60E3rOdp4MC6sNBDvYMzFfy31
         co9rn8MrefYakwUzB7cCCnkFguczeusjT3yBuUZ4aEJ2NtPnZaOsvbnsZw/ghPBVd+DB
         Eudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769706852; x=1770311652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhE/I+dmMmJ/eCvZyGe4V6UD2AvyycXLy63Ov5C2z7c=;
        b=dD4MORfx/+9lpYAm3k3jY36LccdU+x+Eab0PjFJflyO/zjZwbJcfm89RU61hpYRUyc
         FxSQ0lpa8Qkau/2os+C8OcsyzUzYe+pPzxzTniOebVeql+gl+60ohLANhOgY9husFpyL
         kpja59QH2sviy3efnkVoTQ3Pe34LLhUcEStK2e1NpNf0IvXRQaZ/un6gdWGcOBG7Kg7K
         OMqw42NFkPWwg+slory+gKLtwYYKXQqYzjE8lDbche0Y+f+0oJAbMTyuSdBedZzcWKoE
         odNx5cG0fAPxQ/z9SvWaSJbPqDiRfF2Yjzes6ZzxD13vw7/szIGy6dObAYO35n+6w7/p
         J8LA==
X-Forwarded-Encrypted: i=1; AJvYcCU0M6QVKOM3HzvtFw/1ddPpiXjZt9W4iZXGU9hE/vVlbAL/TVod6miFyWyaLT1YVBBMqco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRxDndDQU8QzZpdzuwBBwvZMKtm3pL+ExcZo/ci1E1ecAB6K4y
	IM2cdqLw21/sIq2yqCvnI+fYxTV1oJ50GvZGit0lxVJ4PnZc9hhKxuB5
X-Gm-Gg: AZuq6aJXNlkjXxQ6bayy1Y2k1UTWkjzHubIK0XF8W27a2g2TmPUCZTPiUUILqRHbOh+
	bh69MySscRWYIH4KJvxx9AeI8q4sSjAKyguzr6qi4UmT5c/HqadJMjtsmtLgCo5nmRE510MxV2u
	rchyGlLpLTzXjIq8TCrjwfzCa6kFx8b3pNY1mRWWUYBjuZkzRdKh0rjlRA6IUO81MmgC2kpNOeA
	lurVa1ozqFeKoeimEUJhGV2YI+PDT700exTYM6YI8mpOmuT+Pryt1bhdUfNNSUVkUeBNrlRzw4g
	MmgMxWAqIoKOK+0zgHWcoBmEcP6Qfv1AldKk6U7khOqtExm/8Pr9B4Z1FtRxPj/DEdqB0UFM0AF
	kDthFQjXAKczO9YpDXZTx2938Ia1WAWgKMzj8QdxURCAJRaCa2MD+KqJQ6VZeJjMUZElBQ+O+LE
	862exRHIeYm2Wavfjm7Q2G0SDT0KQkh+hWy4+zbdS7qmP9ophWlg==
X-Received: by 2002:a05:600c:c081:b0:480:73ef:e73b with SMTP id 5b1f17b1804b1-48073efe766mr36452205e9.25.1769706851867;
        Thu, 29 Jan 2026 09:14:11 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:57:5cbc:5f79:1d06? ([2620:10d:c092:500::7:48a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd77b8sm143306795e9.3.2026.01.29.09.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 09:14:11 -0800 (PST)
Message-ID: <c8e3d519-234a-4192-9759-fc4560ad0433@gmail.com>
Date: Thu, 29 Jan 2026 17:14:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Yonghong Song <yonghong.song@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org,
 linux-mm@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com,
 syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
References: <20260128183232.2854138-1-andrii@kernel.org>
 <a1214f2e-dbf7-41d9-ad8a-703193c84b67@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <a1214f2e-dbf7-41d9-ad8a-703193c84b67@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/29/26 15:52, Yonghong Song wrote:
>
>
> On 1/28/26 10:32 AM, Andrii Nakryiko wrote:
>> Fix PROCMAP_QUERY to fetch optional build ID only after dropping 
>> mmap_lock or
>> per-VMA lock, whichever was used to lock VMA under question, to avoid 
>> deadlock
>> reported by syzbot:
>>
>>   -> #1 (&mm->mmap_lock){++++}-{4:4}:
>>          __might_fault+0xed/0x170
>>          _copy_to_iter+0x118/0x1720
>>          copy_page_to_iter+0x12d/0x1e0
>>          filemap_read+0x720/0x10a0
>>          blkdev_read_iter+0x2b5/0x4e0
>>          vfs_read+0x7f4/0xae0
>>          ksys_read+0x12a/0x250
>>          do_syscall_64+0xcb/0xf80
>>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>>   -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>>          __lock_acquire+0x1509/0x26d0
>>          lock_acquire+0x185/0x340
>>          down_read+0x98/0x490
>>          blkdev_read_iter+0x2a7/0x4e0
>>          __kernel_read+0x39a/0xa90
>>          freader_fetch+0x1d5/0xa80
>>          __build_id_parse.isra.0+0xea/0x6a0
>>          do_procmap_query+0xd75/0x1050
>>          procfs_procmap_ioctl+0x7a/0xb0
>>          __x64_sys_ioctl+0x18e/0x210
>>          do_syscall_64+0xcb/0xf80
>>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>>   other info that might help us debug this:
>>
>>    Possible unsafe locking scenario:
>>
>>          CPU0                    CPU1
>>          ----                    ----
>>     rlock(&mm->mmap_lock);
>> lock(&sb->s_type->i_mutex_key#8);
>>                                  lock(&mm->mmap_lock);
>>     rlock(&sb->s_type->i_mutex_key#8);
>>
>>    *** DEADLOCK ***
>>
>> To make this safe, we need to grab file refcount while VMA is still 
>> locked, but
>> other than that everything is pretty straightforward. Internal 
>> build_id_parse()
>> API assumes VMA is passed, but it only needs the underlying file 
>> reference, so
>> just add another variant build_id_parse_file() that expects file passed
>> directly.
>>
>> Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API 
>> for /proc/<pid>/maps")
>> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>>   fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++---------------
>>   include/linux/buildid.h |  3 +++
>>   lib/buildid.c           | 34 +++++++++++++++++++++++++--------
>>   3 files changed, 56 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 480db575553e..dd3b5cf9f0b7 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm, 
>> void __user *uarg)
>>       struct proc_maps_locking_ctx lock_ctx = { .mm = mm };
>>       struct procmap_query karg;
>>       struct vm_area_struct *vma;
>> +    struct file *vm_file = NULL;
>>       const char *name = NULL;
>>       char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
>>       __u64 usize;
>> @@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct 
>> *mm, void __user *uarg)
>>           karg.inode = 0;
>>       }
>>   -    if (karg.build_id_size) {
>> -        __u32 build_id_sz;
>> -
>> -        err = build_id_parse(vma, build_id_buf, &build_id_sz);
>> -        if (err) {
>> -            karg.build_id_size = 0;
>> -        } else {
>> -            if (karg.build_id_size < build_id_sz) {
>> -                err = -ENAMETOOLONG;
>> -                goto out;
>> -            }
>> -            karg.build_id_size = build_id_sz;
>> -        }
>> -    }
>> -
>>       if (karg.vma_name_size) {
>>           size_t name_buf_sz = min_t(size_t, PATH_MAX, 
>> karg.vma_name_size);
>>           const struct path *path;
>> @@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct 
>> *mm, void __user *uarg)
>>           karg.vma_name_size = name_sz;
>>       }
>>   +    if (karg.build_id_size && vma->vm_file)
>> +        vm_file = get_file(vma->vm_file);
>> +
>>       /* unlock vma or mmap_lock, and put mm_struct before copying 
>> data to user */
>>       query_vma_teardown(&lock_ctx);
>>       mmput(mm);
>>   +    if (karg.build_id_size) {
>> +        __u32 build_id_sz;
>> +
>> +        if (vm_file)
>> +            err = build_id_parse_file(vm_file, build_id_buf, 
>> &build_id_sz);
>> +        else
>> +            err = -ENOENT;
>> +        if (err) {
>> +            karg.build_id_size = 0;
>> +        } else {
>> +            if (karg.build_id_size < build_id_sz) {
>> +                err = -ENAMETOOLONG;
>> +                goto out;
>> +            }
>> +            karg.build_id_size = build_id_sz;
>> +        }
>> +    }
>> +
>> +    if (vm_file)
>> +        fput(vm_file);
>> +
>>       if (karg.vma_name_size && 
>> copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
>>                              name, karg.vma_name_size)) {
>>           kfree(name_buf);
>> @@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, 
>> void __user *uarg)
>>   out:
>>       query_vma_teardown(&lock_ctx);
>>       mmput(mm);
>> +    if (vm_file)
>> +        fput(vm_file);
>>       kfree(name_buf);
>>       return err;
>>   }
>> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
>> index 831c1b4b626c..7acc06b22fb7 100644
>> --- a/include/linux/buildid.h
>> +++ b/include/linux/buildid.h
>> @@ -7,7 +7,10 @@
>>   #define BUILD_ID_SIZE_MAX 20
>>     struct vm_area_struct;
>> +struct file;
>> +
>>   int build_id_parse(struct vm_area_struct *vma, unsigned char 
>> *build_id, __u32 *size);
>> +int build_id_parse_file(struct file *file, unsigned char *build_id, 
>> __u32 *size);
>>   int build_id_parse_nofault(struct vm_area_struct *vma, unsigned 
>> char *build_id, __u32 *size);
>>   int build_id_parse_buf(const void *buf, unsigned char *build_id, 
>> u32 buf_size);
>>   diff --git a/lib/buildid.c b/lib/buildid.c
>> index 818331051afe..dc643a6293c1 100644
>> --- a/lib/buildid.c
>> +++ b/lib/buildid.c
>> @@ -279,7 +279,7 @@ static int get_build_id_64(struct freader *r, 
>> unsigned char *build_id, __u32 *si
>>   /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
>>   #define MAX_FREADER_BUF_SZ 64
>>   -static int __build_id_parse(struct vm_area_struct *vma, unsigned 
>> char *build_id,
>> +static int __build_id_parse(struct file *file, unsigned char *build_id,
>>                   __u32 *size, bool may_fault)
>>   {
>>       const Elf32_Ehdr *ehdr;
>> @@ -287,11 +287,7 @@ static int __build_id_parse(struct 
>> vm_area_struct *vma, unsigned char *build_id,
>>       char buf[MAX_FREADER_BUF_SZ];
>>       int ret;
>>   -    /* only works for page backed storage  */
>> -    if (!vma->vm_file)
>> -        return -EINVAL;
>> -
>> -    freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, 
>> may_fault);
>> +    freader_init_from_file(&r, buf, sizeof(buf), file, may_fault);
>>         /* fetch first 18 bytes of ELF header for checks */
>>       ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
>> @@ -332,7 +328,10 @@ static int __build_id_parse(struct 
>> vm_area_struct *vma, unsigned char *build_id,
>>    */
>>   int build_id_parse_nofault(struct vm_area_struct *vma, unsigned 
>> char *build_id, __u32 *size)
>>   {
>> -    return __build_id_parse(vma, build_id, size, false /* !may_fault 
>> */);
>> +    if (!vma->vm_file)
>> +        return -EINVAL;
>> +
>> +    return __build_id_parse(vma->vm_file, build_id, size, false /* 
>> !may_fault */);
>>   }
>>     /*
>> @@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct 
>> *vma, unsigned char *build_id,
>>    */
>>   int build_id_parse(struct vm_area_struct *vma, unsigned char 
>> *build_id, __u32 *size)
>>   {
>> -    return __build_id_parse(vma, build_id, size, true /* may_fault */);
>> +    if (!vma->vm_file)
>> +        return -EINVAL;
>> +
>> +    return __build_id_parse(vma->vm_file, build_id, size, true /* 
>> may_fault */);
>> +}
>> +
>> +/*
>> + * Parse build ID of ELF file
>> + * @vma:      file object
>
> Should this be
>      @file:    file object
> ?
kernel-doc comment should start with

/**
instead of
/*

(additional asterisk). Not sure if that is important,
but it gets different highlight color in my editor.

>
>> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
>> + * @size:     returns actual build id size in case of success
>> + *
>> + * Assumes faultable context and can cause page faults to bring in 
>> file data
>> + * into page cache.
>> + *
>> + * Return: 0 on success; negative error, otherwise
>> + */
>> +int build_id_parse_file(struct file *file, unsigned char *build_id, 
>> __u32 *size)
>> +{
>> +    return __build_id_parse(file, build_id, size, true /* may_fault 
>> */);
>>   }
>>     /**
>
>

