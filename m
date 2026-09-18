Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1003921F0
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703544; cv=none; b=KB0eks3l/9UuU8JrttF0eRTDb6DvomZ/1d2bPgjWIK5iczlHljEN6eGhHq+VKvGeBym9samkq2ScUUvq3x00wbfbKbfyRJxvu7aTkjaQ/I764QRg0rqJZpasXtQed2JpgzGK9BgwBem2fUUvuo5PNRLWxJJR4zR5+LJdxerg73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703544; c=relaxed/simple;
	bh=9x20TkljJNHxKIK/zjkcIgc/yoPrg9CuF6v5uG6qAko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Amgx9MpYh147fefOzZDrmojKccf9KWVqVk+1/dmzNtezn2vWFnP9sbA/0xqkNMsGBmT07o6PD2wkmISlPp50UzDCKF63DD0Vn8LPEV/RY6pK97Y192iv6g/jVQUWAhnHA57Tl6Qb46pASR6gRhBJkB2FoJw1eZc+HTAzvnyA3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZXe1v65Y; arc=none smtp.client-ip=91.218.175.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZXe1v65Y"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9x20TkljJNHxKIK/zjkcIgc/yoPrg9CuF6v5uG6qAko=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789703540; v=1; x=1790308340;
 b=ZXe1v65YUWUVMc6WuSv0vNZ1tQQiv3frykVERcplnRMlODaKRhIQrVOYZACgHciSiO4CeTrm
 /AfFsP8bkEBERsJU94scPP74BtM3/T+1eeW5WPaNIL5VuEZznhrAMi+bJHxlce7gl4gmBgA3Eur
 A/WjevV0VC0eu5kE+5oFbquo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ab91e2d44faea716;
	Fri, 18 Sep 2026 03:52:20 +0000
X-Mizu-Trace-ID: ab91e2d44faea716
X-Migadu-Flow: FLOW_OUT
Message-ID: <0c14df3b-bb30-45ea-9c58-47ef68ad39d7@linux.dev>
Date: Thu, 17 Sep 2026 20:52:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 16/20] libbpf: Carry the exception cleanup table
 through the light skeleton
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055807.3934205-1-yonghong.song@linux.dev>
 <20260917061838.F013C1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260917061838.F013C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/26 11:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] libbpf: unconditional cleanup_info emission breaks backward compatibility on older kernels
> - [Medium] libbpf: integer overflow in cleanup_info size calculation leads to OOB read/write
> --
>
> commit 076a2794e54df3a939c1a2aebf4467a8a0af5e41
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Carry the exception cleanup table through the light skeleton
>
> This commit adds support for carrying the exception cleanup table through
> the light skeleton during BPF program loads. It expands the bpf_attr union
> to include cleanup_info fields and handles endianness byte-swapping for the
> records.
>
>> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
>> index af3a04f161ac1..e9bb282a557a3 100644
>> --- a/tools/lib/bpf/gen_loader.c
>> +++ b/tools/lib/bpf/gen_loader.c
> [ ... ]
>> @@ -1011,8 +1016,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>>   			       load_attr->line_info_rec_size;
>>   	int core_relo_tot_sz = gen->core_relo_cnt *
>>   			       sizeof(struct bpf_core_relo);
>> +	int cleanup_info_tot_sz = load_attr->cleanup_info_cnt *
>> +				  load_attr->cleanup_info_rec_size;
> [Severity: Medium]
> Is there a risk of integer overflow here when parsing untrusted ELF files?
>
> If load_attr->cleanup_info_cnt is large enough, the multiplication with
> load_attr->cleanup_info_rec_size could overflow the 32-bit signed integer
> cleanup_info_tot_sz, resulting in a truncated heap allocation.

We should be okay here. In add_data, we will see:

static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
{
         __u64 zero = 0;
         __u32 size8;
         void *prev;

         if (size > INT32_MAX) {
                 gen->error = -ERANGE;
                 return 0;
         }
         size8 = roundup(size, 8);
	...
}

So size guarding above prevents integer overflow. add_data() also
applies to func_info_tot_sz, line_info_tot_sz, core_relo_tot_sz and
here cleanup_info_tot_sz.

>
> Later in info_blob_bswap(), the loop executes load_attr->cleanup_info_cnt
> times:
>
> info_blob_bswap() {
>      ...
>      for (i = 0; i < load_attr->cleanup_info_cnt; i++)
>          bpf_cleanup_info_bswap(ci++);
> }
>
> Could this lead to an out-of-bounds memory read and write over the
> truncated buffer, potentially causing memory corruption in userspace
> tooling like bpftool?
>
> [ ... ]
>> @@ -1085,6 +1101,9 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>>   	/* populate union bpf_attr with a pointer to core_relos */
>>   	emit_rel_store(gen, attr_field(prog_load_attr, core_relos), core_relos);
>>   
>> +	/* populate union bpf_attr with a pointer to cleanup_info */
>> +	emit_rel_store(gen, attr_field(prog_load_attr, cleanup_info), cleanup_info);
> [Severity: High]
> Will this unconditional emission cause light skeletons to fail to load on
> older kernels?

You are right. We cannot unconditional emit. We can only do emit
if cleanup_info_cnt > 0.

>
> By unconditionally writing a non-zero pointer (the offset in the data blob)
> into the tail of the BPF attribute structure, older target kernels that do
> not support the cleanup_info field might reject the BPF_PROG_LOAD syscall.
>
> Because sys_bpf verifies that all fields beyond its known sizeof(union
> bpf_attr) are zero using bpf_check_uarg_tail_zero(), it seems this could
> fail with -E2BIG. Does this break backward compatibility for all light
> skeletons running on older kernels, even those that do not use exceptions?
>

