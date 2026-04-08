Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7F23EAB3
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616901; cv=none; b=ECL53rX5Bjoy7Yw7t1OqJkd5u1GNzH40JuiwUzua0TQ+qxRewQjgIvT+WhzWD2s/lnfslmJ4ZV/t7ku70S902MNQ/GCkBsx7mdJe/4w5zqa/xLwKx/tWvfijCeIBnjcsV4fwYHwNRrpKWD98MncUd2VTjh4lsJtXKyWdsgZ9pNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616901; c=relaxed/simple;
	bh=tr5IxtZ11UsWIWVQrnOVWKcMK1axbi12a0OdKzQm1M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tU8xRmC6P+5MUiH6DWW3tgSb102etulEOlLxu6gzCOh1S8OB8WaeYZU+EWyHQgCCWaOKiR1vu36stPDICQ97tHwqaAmHoIzcFx6aElwsVft69/O/ho/SGC416X83uNfKmnt/3uK8oEFZ4J04/AKVi2yxLnD3PYnum0zQKrOkKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w+nSys06; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w+nSys06"
Message-ID: <72c8f96e-1e07-4665-9581-2aac3b8d789f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775616898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9cmHtTvNqwk+H8u8VJooMBQ3UiN25FyNoMxaNmOZS8=;
	b=w+nSys06Sj/HX+TKkDOVqIdNeyIsc4Ov6ayDHFnwHmdx8wmSkkIOCjyAhB89eUBfVJl+Pr
	Th3XL3pPZpjA0KqnkArpYM3eX01ODoUaKPjeEsvg+zvi7o2CRNXt1GNvFO4IcfEK3CIpe7
	mFxboD7GY3TctCdf0y/1cN+Uct/Pnn8=
Date: Tue, 7 Apr 2026 19:54:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] bpf: Avoid faultable build ID reads under mm locks
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, song@kernel.org
Cc: puranjay@kernel.org, shakeel.butt@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com
References: <20260407223003.720428-1-ihor.solodrai@linux.dev>
 <e243df5b89176efe6cdf678bf9d588d619ad6d8426b1973e1beb4cf1c650c6c4@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <e243df5b89176efe6cdf678bf9d588d619ad6d8426b1973e1beb4cf1c650c6c4@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/7/26 6:05 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index da3d328f5c15..017ecbc22c96 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
> 
> [ ... ]
> 
>> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
>> +						    u32 trace_nr)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct vm_area_struct *vma;
>> +	struct file *file;
>> +	u64 ip;
>> +
>> +	for (u32 i = 0; i < trace_nr; i++) {
>> +		ip = READ_ONCE(id_offs[i].ip);
>> +		vma = stack_map_lock_vma(mm, ip);
>> +		if (!range_in_vma(vma, ip, ip) || !vma->vm_file) {
>> +			stack_map_build_id_set_ip(&id_offs[i]);
>> +			if (vma)
>> +				vma_end_read(vma);
>> +			continue;
>> +		}
>> +
>> +		file = get_file(vma->vm_file);
>> +		vma_end_read(vma);
>> +
>> +		/* build_id_parse_file() may block on filesystem reads */
>> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
>> +			stack_map_build_id_set_ip(&id_offs[i]);
>> +		} else {
>> +			id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
>> +			id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>> +		}
> 
> After vma_end_read(vma) drops the per-VMA read lock, can vma->vm_pgoff
> and vma->vm_start still be safely accessed here? It looks like the VMA
> could be split, merged, or freed by another thread while
> build_id_parse_file() blocks on filesystem I/O.
> 
> The non-sleepable path in stack_map_get_build_id_offset() reads these
> same fields under mmap_read_lock, which keeps the VMA stable. Here the
> lock is already gone.
> 
> Saving vm_pgoff and vm_start to local variables before vma_end_read()
> would close the window, similar to the approach in the procfs patch
> referenced in the commit message.

I think AI is right here. Will wait a bit for feedback before sending v2.

> 
>> +
>> +		fput(file);
>> +	}
>> +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24111574515

