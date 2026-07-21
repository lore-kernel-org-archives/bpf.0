Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4F3C6A41
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625260; cv=none; b=F+2QSkJN9w6zBAkiRK1HRJ1UgQ0NUHpBF1lScVEbwdaYum7u+pYs9JQKdGm0QEYVmyFXsIdZ41z2h8JwrYJsEw4D5cD3ff2gvDCIT24nolmjnxNfmjkUnWnNNUwMITOEyqNPhF4SKxjwuCjO+1XmoGrXH/xzfZMmqfXrjU95VFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625260; c=relaxed/simple;
	bh=90LezclH39XFxSapEqzsa/UAxXIZmYzFAObAkt2Edf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eB8fTDp2x7IxltUjPNuhueQVby3nmFBVeioSiXTFoyPyo34c66KsqUy5cBzgdhoHf5yv+YimmEkbUj6JYyHB4gVFCf0737QF7kCqkXrhm4/xxx82bsKhvsyf+nVs+1Vgttfpu+GISuqAygxG307wU5M/lwoatfG29YB+oJ+B3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h4BWY6s5rzKHMKl
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:13:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C4D4D4056D
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:14:11 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgC3nSljOF9qNWwTCA--.25971S2;
	Tue, 21 Jul 2026 17:14:11 +0800 (CST)
Message-ID: <9ca18f8e-73c1-4ced-a0bc-f515329b57eb@huaweicloud.com>
Date: Tue, 21 Jul 2026 17:14:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 1/4] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-2-pulehui@huaweicloud.com>
 <20260721042823.9901A1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260721042823.9901A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC3nSljOF9qNWwTCA--.25971S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw4rtFykKr1kKw4xCrg_yoW5ZF13pa
	y3JF1xAw4j9rsrur18ZF1kuFy8XF18WF1jkr1DZF1kAFyavFWFgFyUWrWfur9Y9F4kGa1I
	vF1qqr1rt345ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/21 12:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lockless access to `link->prog` in generic link VFS operations (`bpf_link_show_fdinfo`, `bpf_link_get_info_by_fd`, and `bpf_mprog_link`) can lead to Use-After-Free if `BPF_LINK_UPDATE` executes concurrently.
> --
> 
> --- Patch [1]: [PATCH bpf v5 1/4] bpf: Fix potential UAF in bpf_netns_link_update_prog ---
> commit 5e4c7fbc6ffdce928d3526471c4a856d31dd1aba
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf: Fix potential UAF in bpf_netns_link_update_prog
> 
> This commit fixes a potential Use-After-Free (UAF) in
> bpf_netns_link_update_prog by moving the checks for old_prog and
> new_prog->type inside the netns_bpf_mutex lock. This prevents a race
> condition when multiple threads concurrently execute BPF_LINK_UPDATE on
> the same network namespace link.
> 
>> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
>> index 25f30f9edaefd..9fc62db1441c6 100644
>> --- a/kernel/bpf/net_namespace.c
>> +++ b/kernel/bpf/net_namespace.c
>> @@ -171,13 +171,17 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
>>   	struct net *net;
>>   	int idx, ret;
>>   
>> -	if (old_prog && old_prog != link->prog)
>> -		return -EPERM;
>> -	if (new_prog->type != link->prog->type)
>> -		return -EINVAL;
>> -
>>   	mutex_lock(&netns_bpf_mutex);
>>   
>> +	if (old_prog && old_prog != link->prog) {
>> +		ret = -EPERM;
>> +		goto out_unlock;
>> +	}
>> +	if (new_prog->type != link->prog->type) {
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>>   	net = net_link->net;
>>   	if (!net || !check_net(net)) {
>>   		/* Link auto-detached or netns dying */
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but it looks like other generic
> link VFS operations might suffer from a similar concurrent update issue.
> 
> Functions like bpf_link_show_fdinfo() and bpf_link_get_info_by_fd() in
> kernel/bpf/syscall.c, and bpf_mprog_link() in kernel/bpf/mprog.c read
> link->prog locklessly without holding rcu_read_lock().
> 
> If a userspace thread calls bpf_link_get_info_by_fd():
> 
> kernel/bpf/syscall.c:bpf_link_get_info_by_fd() {
>      ...
>      info.prog_id = link->prog->aux->id;
>      ...
> }
> 
> And a context switch occurs just before accessing link->prog->aux->id, could a
> concurrent thread executing a BPF_LINK_UPDATE command on the same link replace
> link->prog and call bpf_prog_put() on the old program?
> 
> If the RCU grace period expires before the preempted thread resumes, would this
> result in a Use-After-Free when accessing prog->aux->id?
> 
> Similarly, in bpf_link_show_fdinfo(), could reading prog->tag and prog->aux->id
> locklessly trigger the same race?
> 
> kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
>      ...
>                 prog->aux->id);
>      ...
> }
> 
> And in bpf_mprog_link(), could dereferencing link->prog->type locklessly
> result in reading freed memory?
> 
> kernel/bpf/mprog.c:bpf_mprog_link() {
>      ...
>      if (type && link->prog->type != type) {
>      ...
> }
> 

This series already covers these scenarios.

