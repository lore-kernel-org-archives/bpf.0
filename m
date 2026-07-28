Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBF135A53;
	Tue, 28 Jul 2026 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203092; cv=none; b=CDgbHhaJIsxqviL/1q6rFZOZnYfKWcNiaaAV+vJuoW7Aqx9T0EdIaGNYQx78Z3UQxYmLXsd4rIPAx9VTpj+I9kjFXKvElrGuRB3qD1CnQ2tOmBgJjF9ZRX3MUJEZa1XMijUNbvDTxRBuZ1aeX04FwtgTTl8Z/tY9ZrgR92TLucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203092; c=relaxed/simple;
	bh=BsucLhtGvbNktaGDVrAj5KHyGobTxYeSjWdeATV9SsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q0q5Bnz9JJf71TLtBfWt8ZsPOXNiEdV72g3WmG+q9N3QiMQbkqp/9bOYpArXwcoDCmd7PBCbAaY2CDLU+FsAYK5t3B+vShlBUjSgUZ+8lqWsAuboBJOTuKJea8Ei79fqbGbb9kpmro+HzNG7Jl2iurSpgkvmthiNq8P2rfw09Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jbjnK2Cv; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jbjnK2Cv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vGOqOysYO2OeRYCP7bPSQKlpvEp6r3X7mb7RkB0h/Fs=;
	b=jbjnK2CvFIsicm2sJ6JOwdrf2PFibJpyruobNFgYCylMoWzwfqONblSh7iak4C33fqM/jVVlk
	QfqhMlaj9bgHpo9wGRQL+ZRZEnR2xpdSgUwOzj/2kztmt1diClTivee6lry9pEBZllL+IDZoEdN
	IQ2F5PEx/3gopbe7oU7ddNc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h8J1Q2WjczKm9T;
	Tue, 28 Jul 2026 09:35:06 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CB324055B;
	Tue, 28 Jul 2026 09:44:35 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 28 Jul
 2026 09:44:34 +0800
Message-ID: <0646cb86-45dc-42bc-a381-07688b822acc@huawei.com>
Date: Tue, 28 Jul 2026 09:44:33 +0800
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
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Pu Lehui
	<pulehui@huaweicloud.com>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amery Hung
	<ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Mykyta
 Yatsenko <mykyta.yatsenko5@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
	<yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa
	<jolsa@kernel.org>
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-2-pulehui@huaweicloud.com>
 <CAEf4BzZQo9vidTkr9kORbft9Lhx56JJujWQit40xem40TjSS1A@mail.gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <CAEf4BzZQo9vidTkr9kORbft9Lhx56JJujWQit40xem40TjSS1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/7/28 7:01, Andrii Nakryiko wrote:
> On Wed, Jul 22, 2026 at 12:19 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In bpf_netns_link_update_prog, the checks for old_prog and prog type
>> are currently performed locklessly before acquiring netns_bpf_mutex.
>> This creates a race condition that can lead to a UAF issue.
>>
>> If two threads concurrently execute BPF_LINK_UPDATE on the same netns
>> link, the following execution path can trigger a UAF:
>>
>> CPU0                                          CPU1
>> bpf_netns_link_update_prog
>>    if (old_prog && old_prog != link->prog)
>>      return -EPERM;
>>                                                bpf_netns_link_update_prog
>>                                                  if (old_prog && old_prog != link->prog)
>>                                                  ...
>>                                                  old_prog = xchg(&link->prog, new_prog);
>>                                                  bpf_prog_put(old_prog);
>>    if (new_prog->type != link->prog->type) <-- trigger UAF
>>
>> Fix this by moving the old_prog and prog->type checks inside the
>> netns_bpf_mutex critical section.
>>
>> Fixes: 7f045a49fee0 ("bpf: Add link-based BPF program attachment to network namespace")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   kernel/bpf/net_namespace.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
> 
> the change is good, all other link types do take lock first and then
> do all the checking, netns is the only oddball, but see implementation
> nit below
> 
>> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
>> index 25f30f9edaef..9fc62db1441c 100644
>> --- a/kernel/bpf/net_namespace.c
>> +++ b/kernel/bpf/net_namespace.c
>> @@ -171,13 +171,17 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
>>          struct net *net;
>>          int idx, ret;
>>
>> -       if (old_prog && old_prog != link->prog)
>> -               return -EPERM;
>> -       if (new_prog->type != link->prog->type)
>> -               return -EINVAL;
>> -
>>          mutex_lock(&netns_bpf_mutex);
>>
>> +       if (old_prog && old_prog != link->prog) {
>> +               ret = -EPERM;
>> +               goto out_unlock;
>> +       }
>> +       if (new_prog->type != link->prog->type) {
>> +               ret = -EINVAL;
>> +               goto out_unlock;
> 
> can we use guard() and avoid all the goto jumping?

ok, will update next

> 
> pw-bot: cr
> 
> 
>> +       }
>> +
>>          net = net_link->net;
>>          if (!net || !check_net(net)) {
>>                  /* Link auto-detached or netns dying */
>> --
>> 2.34.1
>>
