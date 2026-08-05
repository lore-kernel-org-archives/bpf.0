Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C3A3A873B
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785904305; cv=none; b=jUVxBOVRNibiRzXb6u+UhXfj/f1FM4lY+EJWQYlEQ/Jmi7aeKQrEExriH04JDFUm5+AbNquA6luiENI1zZ05LXgiKoO3PNc6uIdLUazuesTjY1bOLTXkcxzc80iLpLUQ0M+7Rhf2IQub9NkDfWH7V09DAmHYBg6ga4JVzk8rrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785904305; c=relaxed/simple;
	bh=YkY1nrrDou86jxN6ZAxvZTZU2TaKj4Sv5wplf3cPcKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRsjjpAAIhDxT+W3/grNNm4fqzRr95fxkip1bGwXukBrZJ8YYcovgqaaysdWaUCHo+m3Xl/chgUwr2HWCIqMCQqy5LyRvOgP4KCbq9Zxk99zt97vB6ylqdYo8tKOMVczYkVefR7rMFbbQ4+5pxw+IOWjzijUHeSjxDiPk9n+uLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hFHYG3fCHzKHMKM
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 12:31:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3441440641
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 12:31:36 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBXks6lvHJqA9urBA--.64158S2;
	Wed, 05 Aug 2026 12:31:34 +0800 (CST)
Message-ID: <4fe63eb8-04c4-4f85-900c-6be0cf6aba80@huaweicloud.com>
Date: Wed, 5 Aug 2026 12:31:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260805035342.349421-1-pulehui@huaweicloud.com>
 <20260805040507.DF3031F00A3A@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260805040507.DF3031F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXks6lvHJqA9urBA--.64158S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWUKry3Cw1rtr1UJFW7XFb_yoW7Xr47pF
	Z8GFyUGan8Wr4vvr1vqa48ZFWFvr4kJF15Krs0qr1ruF43XFyFgry29rWY9Fy3ur1kuw1I
	vr90vF1jkw1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/8/5 12:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The commit message claims to reject the link update with -EPERM, but the code actually returns -EINVAL.
> 
> Pre-existing issues:
> - [High] pl->storage is not rolled back in the error path of __cgroup_bpf_attach(), leading to a Use-After-Free of cgroup storages.
> - [High] Lockless access to `link->prog` in `bpf_link_show_fdinfo` and `bpf_link_get_info_by_fd` can lead to a Use-After-Free.
> --
> 
> --- Patch [1]: [PATCH bpf v5] bpf, cgroup: Fix storage null-ptr-deref after replacing prog ---
> commit f5ba6e7a5022bb7261a93a1c9312a6415db0249f
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf, cgroup: Fix storage null-ptr-deref after replacing prog
> 
> This commit fixes a null pointer dereference issue when replacing a BPF
> program attached to a cgroup. It addresses the problem by rejecting link
> updates if the new program's cgroup storage is incompatible with the existing
> link's program.
> 
> Link: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicloud.com
> Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com
> 
>>      Fix this by rejecting link update with -EPERM if new_prog's cgroup
>>      storage is incompatible with link->prog.
> 
> [Severity: Medium]
> The commit message claims to reject the link update with -EPERM, but the new
> code actually returns -EINVAL. Could the commit message be updated to match
> the implementation?

Oops, sorry about that. I forgot to update commit message as I thought 
-EINVAL seems more appropriate here.

I'll wait for the review feedback first. If the patch looks good 
overall, I'd be very grateful if the maintainer could fix up the commit 
message on apply. Otherwise, I'm happy to resend.


> 
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 4355ccb78a9c6..5cc9b2d92fd58 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
> 
> [ ... ]
> 
>> @@ -1056,6 +1070,9 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>>   	if (!found)
>>   		return -ENOENT;
>>   
>> +	if (!cgroup_bpf_storages_compatible(link->link.prog, new_prog))
>> +		return -EINVAL;
>> +
>>   	cgrp->bpf.revisions[atype] += 1;
>>   	old_prog = xchg(&link->link.prog, new_prog);
>>   	replace_effective_prog(cgrp, atype, pl);
> 
> [Severity: High]
> This is a pre-existing issue, but while reviewing this code I noticed a
> potential use-after-free in the error path of __cgroup_bpf_attach().
> 
> In __cgroup_bpf_attach(), bpf_cgroup_storages_assign(pl->storage, storage)
> updates the storage pointers in the existing program list element pl to point
> to the storages of the new program.

Fixed.

https://git.kernel.org/bpf/bpf-next/c/6655c409707e

> 
> If a subsequent operation like update_effective_progs() fails, the code jumps
> to the cleanup label:
> 
> kernel/bpf/cgroup.c:__cgroup_bpf_attach() {
>      ...
> cleanup:
> 	if (old_prog) {
> 		pl->prog = old_prog;
> 		pl->link = NULL;
> 	}
> 	bpf_cgroup_storages_free(new_storage);
>      ...
> }
> 
> In this cleanup block, pl->prog is reverted to old_prog, but pl->storage is
> never reverted to its original state. Any newly allocated storages for the
> failed program, which reside in new_storage, are freed via
> bpf_cgroup_storages_free(new_storage).
> 
> Because pl remains in the cgroup's active program list, its storage array now
> contains dangling pointers to these freed RCU-reclaimed storages. Can any
> future execution of the BPF program dereference them, resulting in a
> use-after-free?
> 
> 
> [Severity: High]
> This is a pre-existing issue, but I also noticed potential lockless access to
> link->prog which could lead to a use-after-free.
> 
> BPF link types that support dynamic program updates (such as cgroup links)
> replace their attached program by atomically swapping link->prog (using xchg)
> and then calling bpf_prog_put() on the old program. This decreases the
> reference count and defers the actual freeing of the program until after an
> RCU grace period.
> 
> However, bpf_link_show_fdinfo() fetches link->prog locklessly and
> dereferences its tag without holding rcu_read_lock():
> 
> kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
>      ...
> 	const struct bpf_prog *prog = link->prog;
>      ...
> 	if (prog) {
> 		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>      ...
> }
> 
> Similarly, bpf_link_get_info_by_fd() fetches link->prog and accesses its aux
> field without RCU protection:
> 
> kernel/bpf/syscall.c:bpf_link_get_info_by_fd() {
>      ...
> 	if (link->prog)
> 		info.prog_id = link->prog->aux->id;
>      ...
> }
> 
> If a program update occurs concurrently and the reader thread is preempted
> long enough for the RCU grace period to elapse, would the old program be
> freed before the reader dereferences its memory? Should these accesses be
> protected by rcu_read_lock()?
> 

Fixed.

https://git.kernel.org/bpf/bpf-next/c/863f3ddd0b8a

