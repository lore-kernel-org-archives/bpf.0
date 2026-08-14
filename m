Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D134CFAB
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687947; cv=none; b=RHQxYk5Fbef6kNgAVwjZzcMB7DVj1/Rut4Jb0qPAjvyU0BfDzxoSM7DjxeLskbYEoi0UhowYv/e7/Z7d0N+lQMYR933NwqUNzuvI1fdtx7vxjAbui00avgG/Gk1uZakKtR7kXqJqncFXwiM3MFKIIIn5OOQdtOKlo5zp0tOMqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687947; c=relaxed/simple;
	bh=ONS1Y9e0gWgh9g4MMK4gPnMrtrBh/FugRw96BqHpXLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPPPRQQ8wf8KPH4yOeiguEemN4RuGHMhGpOjqgEDSwE04RXyp8qcjZ9Ci4MwLEh1gdPut4lnHYZbM9vPpLVT48X9R3R4hhyKshB7+xkx/WRjnX6z7tD84FENf6avIU/E02NIvd8fvc78UOLeAaEhsqiiAYyKbOdgjp1s6oCc4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a5NC3hMg; arc=none smtp.client-ip=95.215.58.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a5NC3hMg"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ONS1Y9e0gWgh9g4MMK4gPnMrtrBh/FugRw96BqHpXLE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786687943; v=1; x=1787292743;
 b=a5NC3hMgrhZiXu/i+uZN5HZ5U8Qm9NFoThCxmXdtE3k+ozDHS/cgpX/pwDZqUOEB5htgB1B3
 FZbp0rsW3811rjS7Ch55oNtyC7tITnKWf100v8GBdPTZRI2LG+sF+GNdZorVYSfzhyDPFI379+I
 HYJSM7805mgTDDZL3nBxjzF4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 6545b2071ce9a338;
	Fri, 14 Aug 2026 06:12:23 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <23c9d6ee-3fa9-4e69-845e-2c30d9beeb7a@linux.dev>
Date: Fri, 14 Aug 2026 14:12:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 05/10] libbpf: Add support for global percpu
 data
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813152324.97937-1-leon.hwang@linux.dev>
 <20260813152324.97937-6-leon.hwang@linux.dev>
 <20260813154249.1CA831F000E9@smtp.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260813154249.1CA831F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/8/26 23:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] bpftool gen skeleton fails to generate fields for .percpu maps, breaking lightweight skeleton generation memory layout.
> 
> Pre-existing issues:
> - [High] A massive >4GB ELF section causes a gigabyte-scale out-of-bounds memcpy buffer overflow in libbpf.
> --
> 
> --- Patch [5]: [PATCH bpf-next v12 05/10] libbpf: Add support for global percpu data ---
> commit ba7ffd0a036fafab1adafd7c20bbbb6455fe6cf6
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> libbpf: Add support for global percpu data
> 
> Add support for global percpu data in libbpf by adding a new ".percpu"
> section, similar to ".data". It enables efficient handling of percpu
> global variables in bpf programs.
> 
>>     When generating loader for lightweight skeleton, update the percpu_array
>>     map used for global percpu data using BPF_F_ALL_CPUS, in order to update
>>     values across all CPUs using one value slot.
> 
> [Severity: High]
> Does this change break bpftool's lightweight skeleton generation for .percpu
> maps?
> 
> Looking at tools/bpf/bpftool/gen.c:get_map_ident(), the hardcoded sfxs
> array lacks the ".percpu" suffix:
> 
>     static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
> 
> This causes the .percpu map to be silently skipped during skeleton
> generation.

False positive.

The .percpu map has been handled correctly in get_map_ident() by
checking map type.

> 
> Since the BPF loader program is generated based on the true array index
> (map_idx = map - obj->maps), skipping .percpu in the generated C struct
> shifts all subsequent maps. Can this cause the loader program to read or write
> out of bounds of the skel->maps structure?
> 
>>     
>>     Unlike global data, the mmaped data for global percpu data will be marked
>>     as read-only after populating the percpu_array map. Thereafter, users can
>>     read those initialized percpu data after loading prog. If they want to
>>     update the percpu data after loading prog, they have to update the
>>     percpu_array map using key=0 instead.
>>     
>>     Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa825..e574870fb7169 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -1983,7 +2000,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>  	}
>>  
>>  	def = &map->def;
>> -	def->type = BPF_MAP_TYPE_ARRAY;
>> +	def->type = is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRAY;
>>  	def->key_size = sizeof(int);
>>  	def->value_size = data_sz;
> 
> [Severity: High]
> This is a pre-existing issue, but does this code cause a buffer
> overflow if a malicious BPF ELF file contains a data section larger than 4GB?
> 
> The 64-bit size_t data_sz is truncated into the 32-bit unsigned int
> def->value_size. The mmap allocation will use this undersized truncated
> value, but the subsequent memcpy below uses the original 64-bit data_sz,
> overflowing the undersized map->mmaped buffer:
> 
>     if (data)
>         memcpy(map->mmaped, data, data_sz);
> 
> Can this lead to a massive out-of-bounds write in libbpf?
> 
>>  	def->max_entries = 1;
> 

We must trust the BPF ELF file.

See Andrii's comment in v8:
https://lore.kernel.org/bpf/CAEf4BzbBpDQOG-xUArBzZa_qZ08q=QViH-bbFmqwLNesGvJLUA@mail.gmail.com/.

Thanks,
Leon

