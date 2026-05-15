Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8871A6813
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778889573; cv=none; b=lcZciqqinZNyZqW8JLiQORuKfDXfwsYNns03JMZAES8q8z1f3ZoK28iJEdA5zzniv1dMY1QuYnP20F1/YMOXTXyDL4SQv59gESC5aAejRBwccdp66kiaEXkOd7HbARLfFfTLAI6E6xoaY3yFTTP/bKUPbXVLCMTbP+6LkuIoeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778889573; c=relaxed/simple;
	bh=mw6auwkjUUD3KIZSifXUfwufE0ZoQK+RylWPyoQH7hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sX+H2OhUnu63+4j14qEenkDWmLUfZnNaVIALBeb8U0gVX4w6L7l+JTAN4zIks9P+jHFjDlP7kzt0jrE5bJJsPqGvZiCLXW9J6ctoAX3tNwzmzLzS2R/Ob6bKTdOi2rniQT3hQQw8XJGFndIjNedgu4SMQbGVC/kh1F4TSZoFUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ruQTs39K; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ruQTs39K"
Message-ID: <c99ca87d-2835-4e49-815f-663452c9c156@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778889568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3OgqK5CrfHdFOiX516osZ1BrYrCBElo1qeS3xSA1TU=;
	b=ruQTs39KDzuARxjY8pkeT+TGUlWgS+7bb0WOOgKLhMxb1k768dz6YuGwGq96Zi2bHGX6+7
	bnMD8ss7IQac43foQHreQLcuI5GEzZuTdkgBSm8bflO7UvCg20gIzT0kRcHl+4v+9vQbbm
	zKj9HMIQZIoZppjW2c8VPcBQMe0HQVc=
Date: Fri, 15 May 2026 16:59:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/3] bpf: Cache build IDs in sleepable
 stackmap path
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260515005244.1333013-1-ihor.solodrai@linux.dev>
 <20260515005244.1333013-4-ihor.solodrai@linux.dev>
 <CAEf4BzYYmA7=pSe--McfQNP=SEkPnZyhBLb-_-eB8XS4Gtw2QQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYYmA7=pSe--McfQNP=SEkPnZyhBLb-_-eB8XS4Gtw2QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/15/26 3:40 PM, Andrii Nakryiko wrote:
> On Thu, May 14, 2026 at 5:53 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Stack traces often contain adjacent IPs from the same VMA or from
>> different VMAs backed by the same ELF file. Cache the last successfully
>> parsed build ID together with the resolved VMA range and backing file
>> so the sleepable build-ID path can avoid repeated VMA locking and file
>> parsing in common cases.
>>
>> Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  kernel/bpf/stackmap.c | 56 ++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 53 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 08f7659505d1..7336fd55c856 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -230,13 +230,33 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>>                 .vma = NULL,
>>                 .mm = mm,
>>         };
>> -       unsigned long vm_pgoff, vm_start;
>> +       struct {
>> +               struct file *file;
>> +               const unsigned char *build_id;
>> +               unsigned long vm_start;
>> +               unsigned long vm_end;
>> +               unsigned long vm_pgoff;
>> +       } cache = {};
>> +       unsigned long vm_pgoff, vm_start, vm_end;
>>         struct vm_area_struct *vma;
>>         struct file *file;
>>         u64 ip;
>>
>>         for (u32 i = 0; i < trace_nr; i++) {
>>                 ip = READ_ONCE(id_offs[i].ip);
>> +
>> +               /*
>> +                * Range cache fast path: if ip falls within the previously
>> +                * resolved VMA range, reuse the cache build_id without
>> +                * re-acquiring the VMA lock.
>> +                */
>> +               if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
>> +                       vm_start = cache.vm_start;
>> +                       vm_end = cache.vm_end;
>> +                       vm_pgoff = cache.vm_pgoff;
> 
> isn't this unnecessarily convoluted way of doing things? If we are
> here, we know for sure a) how to calculate offset and b) we need to
> memcpy. So just do that here and just then maybe jump all the way to
> id_offs[i].offset setting. Or just fill offset, status and memcpy
> build id here and continue.
> 
>> +                       goto build_id_valid;
>> +               }
>> +
>>                 vma = stack_map_lock_vma(&lock, ip);
>>                 if (!vma || !vma->vm_file) {
>>                         stack_map_build_id_set_ip(&id_offs[i]);
>> @@ -244,9 +264,21 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>>                         continue;
>>                 }
>>
>> -               file = get_file(vma->vm_file);
>> +               file = vma->vm_file;
>>                 vm_pgoff = vma->vm_pgoff;
>>                 vm_start = vma->vm_start;
>> +               vm_end = vma->vm_end;
>> +
>> +               if (file == cache.file) {
>> +                       /*
>> +                        * Same backing file as previous (e.g. different VMAs
>> +                        * of the same ELF binary). Reuse the cache build_id.
>> +                        */
>> +                       stack_map_unlock_vma(&lock);
>> +                       goto build_id_valid;
>> +               }
> 
> same thing here, file matched, so memcpy(build_id), calculate correct
> offset, set offset and status, unlock and continue. This logic is
> pretty straightforward, IMO it's cleaner to copy-paste these 4 lines
> than dealing with the goto maze...


Eeh... it's a style preference I guess. I had two memcpy() points 
originally, and then Mykyta suggested to consolidate them, so I did.

Having a single "build_id_valid" point with a common "ok" sequence
makes sense to me, but at the same time I am not allergic to 4-line 
copy pastes.

AFAIU with your suggestion we'll still have a label at
id_offs[i].offset = ... so it's not like we'll get rid of goto right?

> 
> 
>> +
>> +               file = get_file(file);
>>                 stack_map_unlock_vma(&lock);
>>
>>                 /* build_id_parse_file() may block on filesystem reads */
>> @@ -255,11 +287,29 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>>                         fput(file);
>>                         continue;
>>                 }
>> -               fput(file);
>>
>> +               if (cache.file)
>> +                       fput(cache.file);
>> +               cache.file = file;
>> +               cache.build_id = id_offs[i].build_id;
>> +
>> +build_id_valid:
>> +               /*
>> +                * In the slow path cache.build_id points to id_offs[i].build_id.
>> +                * Cache hits leave cache.build_id pointing at a prior slot,
>> +                * triggering the memcpy here.
>> +                */
>> +               if (cache.build_id != id_offs[i].build_id)
>> +                       memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
>> +               cache.vm_start = vm_start;
>> +               cache.vm_end = vm_end;
>> +               cache.vm_pgoff = vm_pgoff;
>>                 id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>>                 id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>>         }
>> +
>> +       if (cache.file)
>> +               fput(cache.file);
>>  }
>>
>>  /*
>> --
>> 2.54.0
>>

