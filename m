Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE3296BCB
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605308; cv=none; b=nVs4l4Cri6a+koTxQKtbnl6/sTxCh+HUA1cnKcAyk7obdk1H23lhku8BmMklH3e4F3heXN5hC4BPLmyLvEQh66jMfSJRlkCdqVssw7+rOiOjOHAXIqJraRWmmZciQtKmhcnanh+DsYX0zVeIqidRcrUoXMjapO7yoQv5I4zZqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605308; c=relaxed/simple;
	bh=S2SmuOpaKdMH99L035p4mj4ezeVtLYBDG6qbWJaF5c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZFMjUUEM4sf805AavxpzoG5KZbb5DWVdnuzuiqYCToBdU225MNOWrd9H2hq7KHIWFYwSz9PITdjuSPdAomP794fiB2HfnVXjG/t/C6bx6bUV0uf97ZU2N6WqP1fWFsWojoSYnX5V6ReAIwYJ0ylLTPG7gkZG2Af41vruG63Ik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h437t6Ym0zKHMpx
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:40:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5DDCB40561
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:41:40 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgCnjSl06l5q0Cf3Bw--.36020S2;
	Tue, 21 Jul 2026 11:41:40 +0800 (CST)
Message-ID: <8635b514-51a6-4715-956c-8de53c3604cd@huaweicloud.com>
Date: Tue, 21 Jul 2026 11:41:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 1/4] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260720134547.1289964-1-pulehui@huaweicloud.com>
 <20260720134547.1289964-2-pulehui@huaweicloud.com>
 <20260720135523.AB3461F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260720135523.AB3461F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnjSl06l5q0Cf3Bw--.36020S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw1DKF18Zry7GFW8Crg_yoW5ZF1xpF
	WfG3WkCw48Wrs29F1Iq3WkuFyxZF48WF1UCr1q9r18ZFyYvFWxKFyUurWfur9I9r4kGa1I
	qryjqr1Fqw1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1QVy3UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/20 21:55, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lockless access to `link->prog` in generic BPF link info retrieval functions and mprog logic can lead to a Use-After-Free when an updateable link replaces its program concurrently.
> --
> 
> --- Patch [1]: [PATCH bpf v4 1/4] bpf: Fix potential UAF in bpf_netns_link_update_prog ---
> commit 1e9631860a41f1ee87e0b9afa5e2e3ca3f35147e
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf: Fix potential UAF in bpf_netns_link_update_prog
>      
> This commit fixes a potential use-after-free race condition in
> bpf_netns_link_update_prog. By moving the old_prog and prog->type checks
> inside the netns_bpf_mutex critical section, it prevents concurrent
> BPF_LINK_UPDATE operations from freeing the program while it is being accessed.
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
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while looking at the lockless
> accesses of link->prog being fixed here, I noticed other places that might
> have similar race conditions.
> 
> For example, in kernel/bpf/syscall.c, bpf_link_show_fdinfo() reads link->prog
> locklessly:
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
> Similarly, bpf_link_get_info_by_fd() in the same file accesses
> link->prog->aux->id locklessly, and bpf_mprog_link() in kernel/bpf/mprog.c
> checks link->prog->type without locks.

patch 3 have been covered bpf_link_get_info_by_fd and 
bpf_link_show_fdinfo. patch 2 have been covered bpf_mprog_link

> 
> If a user-space thread calls one of these info retrieval functions and is
> preempted, could a concurrent BPF_LINK_UPDATE (like tcx_link_update or
> the one being fixed in this patch) swap out link->prog via xchg() and free
> it?
> 
> Since the reading threads do not appear to hold rcu_read_lock() or take a
> reference on the program, it seems the RCU grace period could complete,
> resulting in a use-after-free when they resume and dereference prog->tag or
> prog->aux->id.
> 
> Should we add RCU read locks or reference counting around these generic info
> retrieval paths to prevent the program from being freed out from under them?
> 
>>   	net = net_link->net;
>>   	if (!net || !check_net(net)) {
>>   		/* Link auto-detached or netns dying */
> 

