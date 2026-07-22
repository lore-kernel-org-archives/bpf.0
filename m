Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C3479877
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706335; cv=none; b=jSCncycqebDodDqT5KG+8EJNtpn3FFSWJvZDvV9Xb25RDMiGIIjlOzq1OhsD5QWo8/geNiyblzvFaTnf4PYU35Igx8oBUkHO2nEq+0E6zaRvdjias+DIS8+cMTanJHjlejliemn8lmTFStH+DVm20Tj7QD3bdmojLEg5c9+NtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706335; c=relaxed/simple;
	bh=tNRfhs7szQnX/DAu9O31dg2ZGOSy9ZUJxMOYibyUDt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4EhIUFTmGTTlvlxWxShAE538VYQq6bUJ5GP9G9CZQlj8NtB6Pt2zh/zm9m97TS1r8m4wlZEjIchyM/+Ql92MX/hC7vmDedt+iWqfLy74QreI+ZbMbCQCYro/CoqndS1AnBUXP30uUiH/nWyI5u0uY6tzyZJ0FcDel/lyg9iZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4mW20FS3zYQtHN
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:45:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B0B1F405C1
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:45:30 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXBlj+dGBq1N6JCA--.34309S3;
	Wed, 22 Jul 2026 15:45:30 +0800 (CST)
Message-ID: <1a5665f4-9781-4bd3-b7fb-1f98e1f94520@huaweicloud.com>
Date: Wed, 22 Jul 2026 15:45:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 1/4] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-2-pulehui@huaweicloud.com>
 <20260722073624.CEAAC1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260722073624.CEAAC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXBlj+dGBq1N6JCA--.34309S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw45XF48Cryrtw4Dtwb_yoW5Gw4xpF
	yfC3W7Cw1UKrnF9F10v3WkZFy8ZF18WF1jkr1DZ3W8uF9Ivr9agFyUurZ3ur909F1kC3WI
	qr1jqw1Dtw1UZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7
	M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl
	6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU1ItC7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/22 15:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Preexisting Use-After-Free in generic bpf_link information retrieval and mprog attachment due to lockless access to link->prog.
> --
> 
> --- Patch [1]: [PATCH bpf v6 1/4] bpf: Fix potential UAF in bpf_netns_link_update_prog ---
> commit d5c566078955c1f4dfc1d9f1e23e9f6213c3dcfb
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf: Fix potential UAF in bpf_netns_link_update_prog
> 
> This commit fixes a potential use-after-free issue in
> bpf_netns_link_update_prog() by moving the old_prog and prog->type checks
> inside the netns_bpf_mutex critical section.
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
> This isn't a bug introduced by this patch, but while this change fixes the
> concurrent update race in bpf_netns_link_update_prog(), could the subsequent
> xchg() of link->prog cause a use-after-free regression in other functions
> that read it locklessly?
> 
> If a user-space application concurrently calls bpf_obj_get_info_by_fd() or
> reads fdinfo, the retrieval functions read link->prog locklessly without
> holding rcu_read_lock(). If the reader thread is preempted immediately after
> reading the pointer, and a concurrent link update replaces and frees the old
> program, will the reader dereference freed memory?
> 
> This can happen in bpf_link_get_info_by_fd():
> 
>      if (link->prog)
>          info.prog_id = link->prog->aux->id;
> 
> It also appears in bpf_link_show_fdinfo():
> 
>      const struct bpf_prog *prog = link->prog;
>      ...
>      bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> 
> And in bpf_mprog_link():
> 
>      if (type && link->prog->type != type) {

patch 2 and patch 3 will cover these issue.

> 
> Do these lockless accesses need rcu_read_lock() protection to safely read
> the program fields when updates can happen concurrently?
> 

