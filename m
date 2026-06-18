Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB21F30BB
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759157; cv=none; b=bkp6AjR/yzJbjRN1cuOfuQ71uDJD+t3S0tGg8js+vfJyTFhOJAbbTyGuRlK2E2/5t/t89BExgpSk0cstQ3nY6VqOhZOum0ivBhPRBA3SOnsx/EXy8VTyRAtWOIEGCq1n9p6T2YCf/XmdZs6NqiWZ14c/niUymo+bRpXix0h3dzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759157; c=relaxed/simple;
	bh=e5nZ9CI0XdIPWCf5kUW1S/FaaKqlQmQc6SW1UpCN42Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjCntJFIU1B7dPXNtdC1HcQEGenlYMjW9QRLOkVsZTha+Cc+0jXEczI2vdmTBz2JUvm2uZ1BskuuTuJvHNUY33B0eOAnHSg5LwSEdB9N1rzzKY7gBj3s65YvZ4FtpHusKMmcc2uusjwrEzh5bXHIQ5g5jl+nGEW2Mc42aWdxy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NX2tQQui; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NX2tQQui"
Message-ID: <24784bcb-a33d-4b97-bac3-6585329bfd93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781759153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIyK1rEcx3ahlc01GPP5u4wcQgfbWN8KP5ZsOtgM8wg=;
	b=NX2tQQuiHXETttIQ1n+4Qw2zPSLUda5o0rvuksYwwHY1O15OsJmP9+9ef93yTjW5OOFewq
	nSvN32AghldDiOJg12pteFY0Mv+CnDTq+r/n3giHt57GP1qlXku3VPK9sOrRbEWVqUxUjq
	jXSaYnvpnlXq6t6/cz8JJrRQEjt6BjA=
Date: Wed, 17 Jun 2026 22:05:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Question: BPF stack build-id lookup while holding mmap_lock
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260618033152.1541795-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260618033152.1541795-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/17/26 8:31 PM, Runyu Xiao wrote:
> Hi,
> 
> While auditing lock ordering around faultable build-id lookups, our
> static analysis tool flagged the BPF stackmap user-build-id path, and we
> manually reviewed it against the current tree.
> 
> The path we are concerned about is the sleepable helper path:
> 
>   bpf_get_stack_sleepable() / bpf_get_task_stack_sleepable()
>     -> __bpf_get_stack(..., may_fault = true)
>        -> stack_map_get_build_id_offset()
>           -> mmap_read_trylock(current->mm)
>           -> build_id_parse(vma, ...)
>           -> __kernel_read()
> 
> `build_id_parse()` can read from the backing file while mmap_lock is
> held.  That can form an ABBA dependency with file read paths where the
> inode side is held first and copy_to_user/copy_page_to_iter can fault
> and then need mmap_lock.
> 
> A minimal Lockdep reproducer preserving this BPF stackmap carrier and
> the reverse file-read edge reports:
> 
>   WARNING: possible circular locking dependency detected
>   __kernel_read
>   stack_map_get_build_id_offset
>   __bpf_get_stack
>   *** DEADLOCK ***
> 
> The local fix I am considering is only for the faultable build-id path.
> It would snapshot the VMA file reference and offset metadata under
> mmap_lock, drop mmap_lock, and then parse the build-id from the file
> reference with build_id_parse_file().  The existing no-fault path would
> remain unchanged.
> 
> Roughly:
> 
>   1. Under mmap_lock, find the VMA for each user IP.
>   2. Take a file reference and snapshot vm_start/vm_pgoff.
>   3. Drop mmap_lock.
>   4. Parse build IDs from the files.
>   5. Fall back to reporting IPs if the faultable path cannot safely
>      release mmap_lock or allocate the temporary snapshot array.


Hi Runyu,

A patch implementing more or less this algorithm has recently landed:
https://lore.kernel.org/bpf/20260525223948.1920986-1-ihor.solodrai@linux.dev/

I recommend doing a search on lore.kernel.org or other mailing list mirror
in advance, to avoid unnecessary or duplicate work.


> 
> The tradeoff is that build-id parsing would happen after releasing
> mmap_lock, so the VMA/file relationship is represented by the file
> reference and copied metadata rather than by holding the VMA lock context
> through the file read.  That avoids file I/O under mmap_lock, but may
> change edge-case behavior if the mapping changes concurrently.
> 
> Does this direction sound acceptable for sleepable BPF stack helpers, or
> would you prefer a stricter fallback-to-IP behavior whenever build-id
> parsing would require faultable file I/O?  Another option would be to
> avoid build-id parsing entirely in the may_fault=true stackmap path unless
> there is an existing BPF/MM helper pattern I should reuse.
> 
> The local draft subject is:
> 
>   bpf: avoid faultable build-id lookup under mmap_lock
> 
> Thanks,
> Runyu

