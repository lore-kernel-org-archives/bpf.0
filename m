Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45E332EA2
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209412; cv=none; b=K62kPx6Vz9XCTs4ay1GfBSUifLlYUHimDbFOy9Kv5EYXyqQW7U2URPMq+NeH8cOYDdHeTG7cSFom9ZkT5ixAEeby3tVS/KBZu/VhykJDM/FkINegZMq8svYo9EsepW+NMLdAGFHBEp0OLEhzp6PYHh/Lr7cP7LRLyrcFlffnB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209412; c=relaxed/simple;
	bh=JOyG8x8EOnxSt91rzktpbyZlPHcNc8Nf9OkxgzcK+zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Em33M4q5dOsHtr/+ou47zOe0kg42OVIZCus2sbQ9tWR+WJPQ+0b6Jz4KifvMdjajJcORkPdDXspqJ3u7gr8sdDTeyTiGUW4jNYrlljzdxOQAg3VrgaU+gA0HwYuBpjTpffLxxuscBPNTuF6ssq+9kmc7Y9Od8ShGI1caSwX+eyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h8LXy5m2KzKHMPd
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 11:29:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9A50D4060A
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 11:29:59 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgB3tNA2ImhqCfnXAA--.13737S2;
	Tue, 28 Jul 2026 11:29:59 +0800 (CST)
Message-ID: <1f0fde0b-9d4e-4bd5-bcad-67c7a60f9867@huaweicloud.com>
Date: Tue, 28 Jul 2026 11:29:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260728023259.2813482-1-pulehui@huaweicloud.com>
 <20260728023904.CCF9A1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260728023904.CCF9A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3tNA2ImhqCfnXAA--.13737S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw4xKr1kWFykXFW7twb_yoW5Ww48pF
	43A3WDCa1jgrsFvr18Xw18urWUXF48WF1UKrn2vF1rAF1YvrZYgFyUurWfur9a9F4kCa1I
	qry2qryxt348ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/28 10:39, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Lockless, unprotected access to `link->prog` fields allows Use-After-Free and TOCTOU bugs when a link's program is updated concurrently.
> --
> 
> --- Patch [1]: [PATCH bpf v2] bpf: Fix potential UAF in bpf_netns_link_update_prog ---
> commit afa2c5a0786c29e2f3227e6c9b10cbfcd8407bc9
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf: Fix potential UAF in bpf_netns_link_update_prog
> 
> This commit fixes a potential use-after-free in bpf_netns_link_update_prog
> by moving the checks for old_prog and new_prog->type inside the
> netns_bpf_mutex critical section. It also uses guard(mutex) to simplify
> lock management.
> 
> Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com [0]
> 
>> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
>> index 25f30f9edaefd..81006a242618d 100644
>> --- a/kernel/bpf/net_namespace.c
>> +++ b/kernel/bpf/net_namespace.c
>> @@ -171,33 +171,28 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
>>   	struct net *net;
>>   	int idx, ret;
>>   
>> +	guard(mutex)(&netns_bpf_mutex);
>> +
>>   	if (old_prog && old_prog != link->prog)
>>   		return -EPERM;
>>   	if (new_prog->type != link->prog->type)
>>   		return -EINVAL;
>>   
> [ ... ]
>>   	old_prog = xchg(&link->prog, new_prog);
>>   	bpf_prog_put(old_prog);
> 
> [Severity: Critical]
> This is a pre-existing issue, but can this concurrent update race with
> lockless readers of link->prog in other parts of the code?

The follow patch has been covered this issue.

https://lore.kernel.org/bpf/20260728025457.2814876-1-pulehui@huaweicloud.com

> 
> For example, in bpf_link_get_info_by_fd():
> 
> kernel/bpf/syscall.c:bpf_link_get_info_by_fd() {
>      ...
>      if (link->prog)
>          info.prog_id = link->prog->aux->id;
>      ...
> }
> 
> Or in bpf_link_show_fdinfo():
> 
> kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
>      ...
>      const struct bpf_prog *prog = link->prog;
>      ...
>      if (prog) {
>          bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>      ...
> }
> 
> Could these lockless reads lead to a use-after-free if a thread executing
> bpf_netns_link_update_prog() swaps link->prog and drops the reference to
> old_prog, and the RCU grace period elapses before the reader accesses the
> freed program's fields?
> 
> Similarly, in bpf_mprog_link() in kernel/bpf/mprog.c:
> 
> kernel/bpf/mprog.c:bpf_mprog_link() {
>      ...
>      if (type && link->prog->type != type) {
>          bpf_link_put(link);
>          return -EINVAL;
>      }
>      
>      tuple->link = link;
>      tuple->prog = link->prog;
>      ...
> }
> 
> Could this lead to a time-of-check to time-of-use error or a dangling
> tuple->prog pointer if a link update occurs concurrently?
> 

