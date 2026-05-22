Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C5357D0B
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471200; cv=none; b=K7O3PWQdsFcx+jeJ96mGbCMKMTKelG/ypLqJyfBoF8U85LWg9of91E+eB6DGwK77DAnQqs4n4CXS72oplMjYhxCa8V1qbf25s2cro+Xp/3FZ1pnQvJX3PhVi+ONS2rqhCmfSeXQrZnwMx8R8eR5lMILJQi8KJ4xu/ww8XZFF9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471200; c=relaxed/simple;
	bh=CMN0nDDVAelqnXdkRz/2vCYPAAlZFowN1WynyV87724=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yzy0cr5dKn3tw3SOZJeU9bHRDO9M1qjt5Nc3TlzadcxQeYuxTDP4Gp1UX9GVvabAsNAPtmThi0M4qVmROqBIVBPbttcWgJl/L2FZPxiKvldiSAYNIToOu1v0M7pd/U9HTJXqPUulLO1yt0QffEknLdoa8BLG0iPqU2yi2me+hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L2KfDK0l; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L2KfDK0l"
Message-ID: <2f9d7a3f-2f60-4aed-8120-6d0bd292116a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779471194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxwAE1SO/yvmGfDZFab1CFYsqCT01AEpOLb4qV+sd08=;
	b=L2KfDK0llgcawhgCAD9XAZK0YAMxRTf1KiHqaT1spOy1c2jQVdUsXTuDXMmqXpqpVe43oZ
	4t1tOlFQ7ScybeX7xSTfS2FZGmX577x2E/saxNFKSjd3lcqoVy11XgKJ83I1IYLDocxJRu
	HhaMAe17+E6ivTzMlv8EgqCZWW130q8=
Date: Fri, 22 May 2026 10:33:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Factor out stack_map build ID
 helpers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260521225022.2695755-1-ihor.solodrai@linux.dev>
 <20260521225022.2695755-2-ihor.solodrai@linux.dev>
 <CAEf4BzbjpeQd3A4CHSPO3o8PB2koGsUa2+ggWPjQqd8Ra+F2Bw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzbjpeQd3A4CHSPO3o8PB2koGsUa2+ggWPjQqd8Ra+F2Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/22/26 10:16 AM, Andrii Nakryiko wrote:
> On Thu, May 21, 2026 at 3:51 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Factor out helpers from stack_map_get_build_id_offset() in
>> preparation for adding a sleepable build ID resolution path.
>>
>> No functional changes.
>>
>> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  kernel/bpf/stackmap.c | 51 ++++++++++++++++++++++++++++++-------------
>>  1 file changed, 36 insertions(+), 15 deletions(-)
>>
> 
> [...]
> 
>>  /*
>>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>>   * They will be subsequently:
>> @@ -165,44 +187,43 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
>>  static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>                                           u32 trace_nr, bool user, bool may_fault)
>>  {
>> -       int i;
>>         struct mmap_unlock_irq_work *work = NULL;
>>         bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
>> +       bool has_user_ctx = user && current && current->mm;
>>         struct vm_area_struct *vma, *prev_vma = NULL;
>> -       const char *prev_build_id;
>> +       const unsigned char *prev_build_id;
> 
> = NULL ?

Sure, why not.

> 
>> +       int i;
>>
>>         /* If the irq_work is in use, fall back to report ips. Same
>>          * fallback is used for kernel stack (!user) on a stackmap with
>>          * build_id.
>>          */
>> -       if (!user || !current || !current->mm || irq_work_busy ||
>> -           !mmap_read_trylock(current->mm)) {
>> +       if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)) {
>>                 /* cannot access current->mm, fall back to ips */
>> -               for (i = 0; i < trace_nr; i++) {
>> -                       id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>> -                       memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>> -               }
>> +               for (i = 0; i < trace_nr; i++)
>> +                       stack_map_build_id_set_ip(&id_offs[i]);
>>                 return;
>>         }
>>
>>         for (i = 0; i < trace_nr; i++) {
>>                 u64 ip = READ_ONCE(id_offs[i].ip);
>> +               u64 offset;
>>
>>                 if (range_in_vma(prev_vma, ip, ip)) {
>>                         vma = prev_vma;
>> -                       memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
>> -                       goto build_id_valid;
>> +                       offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
>> +                       stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
>> +                       prev_build_id = id_offs[i].build_id;
> 
> you are not updating prev_vma, so why updating prev_build_id... it's
> confusing because this serves no purpose, yet the code is there, so
> whoever is reading this should be asking the question of "what am I
> missing". Am I missing something?

No, you're right, it doesn't look necessary.

I think this is AI slop: it took too literally the "no functional
changes" part and essentially copy-pasted a piece of code under
build_id_valid label before continue. My oversight, will remove.

> 
>> +                       continue;
>>                 }
>>                 vma = find_vma(current->mm, ip);
>>                 if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
>>                         /* per entry fall back to ips */
>> -                       id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>> -                       memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>> +                       stack_map_build_id_set_ip(&id_offs[i]);
>>                         continue;
>>                 }
>> -build_id_valid:
>> -               id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
>> -               id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>> +               offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
>> +               stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
>>                 prev_vma = vma;
>>                 prev_build_id = id_offs[i].build_id;
>>         }
>> --
>> 2.54.0
>>

