Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4F280CF6
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391303; cv=none; b=nIbRcKri7dmcK+dd9lzXoxhUtKbTLHoi+DdPc/+pSY3AlMGe8XxGtEetZ+8e8MLxX8wzzpxIKNxzqxKJ4JC/aMLOXOlamBM/RlKq9sNGQFOp37R7sG+VKt2ZFun6TIEj4q6Bo1LxhunJ/5aZBatypfibi3kmAPPEKtecJp3UWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391303; c=relaxed/simple;
	bh=pZI8fPm07dl+KqTSM8LsAZQzKn90LROEAUQmjkkmf3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc4czj5ZlFrXzjq3kleByFEYC8B8yqsRM2D5EOaPZqzlSDc+LgCqsrAYVcgJGe23Xl3c3yaiYMu9HMUmMz5EZsqpC24KIr1ObmtT6okDIZy79QLkmrSX2uyW4BHBHU3BXdg1HrDvRsdM11xccjKML9QZsC8RuxmmELKw3f7jhA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CpoHom8G; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CpoHom8G"
Message-ID: <bd23783b-9afc-48c9-8bd5-31f4920187e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776391300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bm9Z/ucq0cd2+9drlQWcJ2mswUWqzt44n0bM3O+MOFc=;
	b=CpoHom8GVE8lKTET85dYgXUcHNqw3VfZAkJAiFUApJKI+ZwKgxuRlAlG5RVLadaG+rvFsX
	PWDcY2VIyTGG5yHgSk/4vLsU4xAN0Pukh+Rh5IFPHY8Nu69Fqhhbt0IlRndNMaQ/kA9T1N
	oJvWNFmgdBLHhHoNeC5osEZhMM5ktME=
Date: Fri, 17 Apr 2026 10:01:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 6/8] bpftool: Generate skeleton for global
 percpu data
Content-Language: en-US
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260414132421.63409-7-leon.hwang@linux.dev>
 <20260414212650.4F89BC19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260414212650.4F89BC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/4/26 05:26, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] Missing read-only memory protection for `.percpu` initial value buffer in generated light skeletons.
> --
> 
> commit e61b5ee6e5a7cee758b644de0f6b4aaea40f020c
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> bpftool: Generate skeleton for global percpu data
> 
> Enhance bpftool to generate skeletons that properly handle global percpu
> variables. The skeleton includes a nested structure for percpu data, which
> is marked as read-only after loading so users must update the map directly.
> 
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
> 
> [ ... ]
> 
>> @@ -847,7 +851,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>>  	bpf_object__for_each_map(map, obj) {
>>  		const char *mmap_flags;
>>  
>> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
>> +		if (!is_mmapable_map(map, ident, sizeof(ident)) || bpf_map_is_percpu_data(map))
>>  			continue;
>>  
>>  		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
> 
> The commit message notes that after loading the skeleton, maps.percpu->mmaped
> has been marked as read-only.
> 
> By skipping the .percpu map entirely here during light skeleton generation
> in gen_trace(), does this leave the user-space buffer for .percpu writable?
> 
> If a user modifies skel->percpu after the light skeleton is loaded, will it
> silently succeed without actually updating the kernel per-cpu map? Does the
> generated light skeleton need an explicit mprotect(..., PROT_READ) for the
> .percpu initial value buffer to enforce the read-only constraint?
> 

The mprotect(..., PROT_READ) was added in patch #4.

I think it'd better to move the change to this patch. Then, readers
won't miss the mprotect().

Thanks,
Leon

