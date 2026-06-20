Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC618A92F
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781988892; cv=none; b=dXko3fIC3uvX574igknIRfVNwcSdfUUHc/DtFUrv3USko0QNITFhKrqVT/tkt86x6Qw/ywigP7nePMmo14TgZmDjkjNuX9+6NCfPzdqd5AvURZDO13wXbbjeslwuK81qUDC7iyu6l1X9NI/Z1T/9Oby1velfWtZwUxQNcCnQ7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781988892; c=relaxed/simple;
	bh=hoyWPSh53vkdoKN1ko25Ca+FPJMsXh3cNqjZJxcRRrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm7inmeuBfOXSevtDCYzA3ttnqrtZvwZy1+TWfjJEi3kng2miLBQwqkyLoxJ5149k/gMncPXEath5LpeUlP1E+ktqpuWiYHDLZdrhqBAWztT4T4rAGs1ncA4cyZKIAXy5bdkqTvCSAte9CwPNSxCtWs0zg8bM4b+l8/q4teaT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jb29XCiN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jb29XCiN"
Message-ID: <125e95fe-36f0-48f5-8888-ccfd944606a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781988888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiHXj3HckvwS/mpx9wfuAVXvq6RrK1VlpJ2FZCgggxc=;
	b=jb29XCiNDn9BPRTH0uNqkOA3cUxq2HUD/12OWZq3kPHTbgAgpYpUbhO04wkzPNPNWw550x
	Tc+G90Inx1+bOOZERITsjgEXN9akFwiddy09DU9gR7DUyqbaIwvtripZX+wxepYtNbp4MR
	7JVs+tSxjQjfh+p1UpLCRErF8wpiEr8=
Date: Sat, 20 Jun 2026 13:54:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix effective prog array index with
 BPF_F_PREORDER
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev, Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260619063520.2690547-1-ameryhung@gmail.com>
 <20260619063520.2690547-2-ameryhung@gmail.com>
 <20260619064625.545CE1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260619064625.545CE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/18/26 11:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] This problem wasn't introduced by this patch, but replace_effective_prog() erroneously uses the logical index returned by effective_prog_pos() as a direct physical index into the effective BPF program array. If previous detach operations failed to reallocate the array and left dummy_bpf_prog elements in place, the physical index does not match the logical index. This causes bpf_link_update() to overwrite the wrong program slot (e.g., the dummy) leaving the original program untouched in the active array while its reference is dropped by __cgroup_bpf_replace(). Once the RCU grace period expires, this leads to a Use-After-Free when the kernel executes the freed program.
> --
>
> commit f837441f68b1fdb520696422a141ec421e2d50ae
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Fix effective prog array index with BPF_F_PREORDER
>
> This commit introduces a shared helper effective_prog_pos() to accurately
> determine a program's position in the effective array by replaying the
> placement logic. This fixes an issue where preorder programs caused
> replace_effective_prog() and purge_effective_progs() to access incorrect
> slots, corrupting the array or causing a use-after-free.
>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 83ce66296ac19..4355ccb78a9c6 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
> [ ... ]
>
>> @@ -960,27 +1006,15 @@ static void replace_effective_prog(struct cgroup *cgrp,
>>   		if (percpu_ref_is_zero(&desc->bpf.refcnt))
>>   			continue;
>>   
>> -		/* find position of link in effective progs array */
>> -		for (pos = 0, cg = desc; cg; cg = cgroup_parent(cg)) {
>> -			if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
>> -				continue;
>> -
>> -			head = &cg->bpf.progs[atype];
>> -			hlist_for_each_entry(pl, head, node) {
>> -				if (!prog_list_prog(pl))
>> -					continue;
>> -				if (pl->link == link)
>> -					goto found;
>> -				pos++;
>> -			}
>> -		}
>> -found:
>> -		BUG_ON(!cg);
>> +		pos = effective_prog_pos(desc, atype, pl);
>> +		if (WARN_ON_ONCE(pos < 0))
>> +			continue;
>>   
>>   		progs = rcu_dereference_protected(
>>   				desc->bpf.effective[atype],
>>   				lockdep_is_held(&cgroup_mutex));
>>   		item = &progs->items[pos];
>> -		WRITE_ONCE(item->prog, link->link.prog);
>> +		WRITE_ONCE(item->prog, pl->link->link.prog);
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does replace_effective_prog()
> erroneously use the logical index returned by effective_prog_pos() as a direct
> physical index into the effective BPF program array?
>
> If previous detach operations failed to reallocate the array and left
> dummy_bpf_prog elements in place, the physical index would not match the
> logical index. This could cause bpf_link_update() to overwrite the wrong
> program slot (e.g., the dummy), leaving the original program untouched in the
> active array while its reference is dropped by __cgroup_bpf_replace().
>
> Once the RCU grace period expires, could this lead to a Use-After-Free when
> the kernel executes the freed program? Should this instead use
> bpf_prog_array_update_at(progs, pos, pl->link->link.prog) to correctly handle
> the presence of dummy programs?

Indeed this is a prefixing bug and can be fixed in another patch. If I undersand
correctly, the logic like below:
    __cgroup_bpf_detach
      update_effective_progs
        failed doe to out-of-memory:
           purge_effective_progs
               ...
               bpf_prog_array_delete_safe_at(...)
               /* dummy prog is in the effective array */
    __cgroup_bpf_replace
      replace_effective_prog
        ...
        item = &progs->items[pos];
        WRITE_ONCE(item->prog, pl->link->link.prog);
        /* dummy prog in effective array, but pos may ignore dummy prog during accouting. */

So for in replace_effective_prog(), bpf_prog_array_update_at() is the right way to fix.

