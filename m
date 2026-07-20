Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A4403EB3
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549620; cv=none; b=hk0+9VVZBT6lIGu7zGgYvjL0eg/DLuyFTcJ/6PwLp1dTC69Kbuaw7ghLxNyGEP0q10VYw9YPySFYuqoJD8Ly8wrZIZOIPkwsMKn1NveujgN3CivN40vmT1qfS9MlzlUWCm9xCB1JRPrpm4uOC3JW2I1zomlnHyWVzB1X1BWAuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549620; c=relaxed/simple;
	bh=heOPBCbaaGOhuNjPI/1LS6G49s6fGhop6KU5pCc5vWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+skJ9S2NT2CVEWhppp08ORE83wvBi9kQJWRSs/2PbpFVBxsNVjpsACOJVdJj3jSdvgJcCzY/r3GEkRjsfV2GvxwAQ+O3ZI/NActD8uuaWzO4Wc3mYDj3BeGpS1xJEWOQVbSc/Uojfdngd5AbQZ/ZyFXL2E9caYXs7WpgF4ARSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h3fY12JCSzKHMQH
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:12:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B5CAA4056E
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:13:33 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCXxlftEF5qit6sBw--.17778S2;
	Mon, 20 Jul 2026 20:13:33 +0800 (CST)
Message-ID: <77b763f8-fd19-4e40-aa0c-abbb5e290553@huaweicloud.com>
Date: Mon, 20 Jul 2026 20:13:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/3] bpf: Fix potential UAF when reading bpf link
 info
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260720033055.1215477-1-pulehui@huaweicloud.com>
 <20260720033055.1215477-2-pulehui@huaweicloud.com>
 <20260720035032.6C8021F00A3A@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260720035032.6C8021F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXxlftEF5qit6sBw--.17778S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw47CryDArW7WFWUCFg_yoW5try8pF
	W3G3Wjk3WUKrs2vw1kXF18AryF9F4UWF1UKr1kWF18ur1avFWSgFyjgrWfuryakr4kGw4I
	v34jqr1Dtr15ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/20 11:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] bpf_netns_link_update_prog checks link->prog locklessly, allowing a TOCTOU race that violates atomic replacement guarantees.
> - [High] Concurrent BPF_LINK_UPDATE can race with bpf_mprog_link to cause a Use-After-Free when dereferencing link->prog->type.
> --
> 
> --- Patch [1]: [PATCH bpf v3 1/3] bpf: Fix potential UAF when reading bpf link info ---
> commit 5b8e0ac8575ebc387f2ddc7dee211697bb704588
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf: Fix potential UAF when reading bpf link info
> 
> This commit addresses a potential Use-After-Free issue when accessing
> link->prog without locks in bpf_link_show_fdinfo and bpf_link_get_info_by_fd.
> It resolves the problem by acquiring both normal RCU and tasks trace RCU
> read locks before dereferencing the program, preventing concurrent freeing
> during bpf_link_update operations.
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 6db306d23b479..2458c68146b95 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3490,13 +3491,23 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>>   	}
>>   	seq_printf(m, "link_id:\t%u\n", link->id);
>>   
>> +	/* prog can be sleepable */
>> +	rcu_read_lock_trace();
>> +	rcu_read_lock();
>> +	prog = READ_ONCE(link->prog);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but since you are fixing lockless
> dereferences of link->prog here, could a similar TOCTOU race happen in
> bpf_netns_link_update_prog()?
> 
> kernel/bpf/net_namespace.c:bpf_netns_link_update_prog() {
>      ...
> 	if (old_prog && old_prog != link->prog)
> 		return -EPERM;
> 	if (new_prog->type != link->prog->type)
> 		return -EINVAL;
> 
> 	mutex_lock(&netns_bpf_mutex);
>      ...
> }

I will move forware the `mutex_lock(&netns_bpf_mutex)` in next.

> 
> Two threads concurrently calling BPF_LINK_UPDATE on a netns link could both
> evaluate the old_prog != link->prog check locklessly and pass it. If they
> acquire netns_bpf_mutex one after the other, would the second thread
> blindly overwrite link->prog, overriding the first thread's update and
> violating the BPF_F_REPLACE API contract?
> 
> [Severity: High]
> This is also a pre-existing issue, but does a similar Use-After-Free race
> exist in bpf_mprog_link()?
> 
> kernel/bpf/mprog.c:bpf_mprog_link() {
>      ...
> 	if (type && link->prog->type != type) {
> 		bpf_link_put(link);
> 		return -EINVAL;
> 	}
>      ...
> }
> 
> If a thread calls BPF_PROG_ATTACH on a tcx hook (holding the sleepable
> rtnl_lock) and supplies a relative_fd pointing to a netns link,

emm, the link referenced by relative_fd cannot be a non-netkit or 
non-tcx link. We need to add a restriction here.

> bpf_mprog_link() executes without an RCU read-side critical section.
> 
> Could this thread be preempted, allowing a concurrent BPF_LINK_UPDATE on
> the same netns link to replace and free link->prog? When the first thread
> resumes, it would dereference link->prog->type where link->prog now points
> to freed memory.
> 
>>   	if (prog) {
>>   		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>> +		prog_id = prog->aux->id;
>> +	}
>> +	rcu_read_unlock();
>> +	rcu_read_unlock_trace();
> 

