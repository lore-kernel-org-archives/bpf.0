Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405B2609FD;
	Tue, 28 Jul 2026 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203669; cv=none; b=haCOc75e9aa4J7As2ulMs2sZ1rR9c275vOSAsK729fibNRVRjone4udTGyhVk8mE8jOU9/52i106300ErQYiZJLqLDAVX45irAfsPISzUJ0CW6Vqt6qhNkWCCL0PEwvvFBx5VIMwRdud/X1Uu0vUxBDeTQkoGjjbx21Arw3qwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203669; c=relaxed/simple;
	bh=AUKEwYCaqPQLQ2gdT5nx/ZElk+Gk4XoFRRkTulRW8Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZP6ZuytEnvW0u9EY7QBNEmbn/8XGw5RUuDMvbhBrfMljjElEWufeLVyFGKNZCrPiRuybxV81r4EA+rMSQfYZ5CT0WIHuCX8q0iT3qwcEsQpJMymzcAzNKrtdnlTvOFoyfr1azRi1HT2rXSDw9gLt2VBOmOUX/aBLg65M+KdpWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h8JQl4GD5zYQtpw;
	Tue, 28 Jul 2026 09:53:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 248E940BE8;
	Tue, 28 Jul 2026 09:54:14 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBHNtLEC2hqg+jPAA--.64503S2;
	Tue, 28 Jul 2026 09:54:14 +0800 (CST)
Message-ID: <f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com>
Date: Tue, 28 Jul 2026 09:54:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 0/4] Fixes for bpf link update
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <CAEf4BzYZ4JthZe_FZDVd8tHmVB6HDht7-FCL70M5ShFzOj=mQw@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAEf4BzYZ4JthZe_FZDVd8tHmVB6HDht7-FCL70M5ShFzOj=mQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHNtLEC2hqg+jPAA--.64503S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrJFyUCr1UWF17tw4Utwb_yoW5Ww48pF
	4fZ3W5Ww10grWIvrnI9w1UuFy5tw4rG3WUKrnxJw1rAF4Y9F109ryxWr1fZFZ7Zr93GayF
	vwnIgF90k348ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/28 7:17, Andrii Nakryiko wrote:
> On Wed, Jul 22, 2026 at 12:19 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> This patch series addresses a few concurrency UAF issues within bpf link update.
>>
> 
> each fix is independent from each other, can you please split patch
> set into individual patches, please? some of them are straightforward

Makes total sense, I'll do this.

> and can be applied soon, while others might require a bit more
> thorough review and some more iteration, so best to split and apply
> individually, IMO

Next time I hit unrelated sashiko issues, I’ll just send them separately 
from the start.

> 
>> v6:
>> - BPF_F_LINK flag set means the relative id_or_fd is a link, not the object being
>>    attached. We can not get the link while attach a bare prog with relative link.
>>    So passing expected link type from callers of bpf_mprog_attach/detach. (Sashiko)
>> - Add comment to explain that why ptype == UNSPEC in bpf_mprog_detach. (Emil)
>>
>> v5: https://lore.kernel.org/bpf/20260721041048.1394085-1-pulehui@huaweicloud.com
>> - Remove rcu_read_lock_trace as rcu_read_unlock is sufficient. (Mykyta)
>> - Improve commit msg for patch 2. (Amery)
>> - Add Reviewed-by tag by Amery.
>>
>> v4: https://lore.kernel.org/bpf/20260720134547.1289964-1-pulehui@huaweicloud.com
>> - Add new fix for UAF due to missing link type check in mprog. (Sashiko)
>> - Add new fix for UAF in bpf_netns_link_update_prog. (Sashiko)
>> - Include the storage and flags rollbacks to patch4 for sake of code rigor,
>>    as it's hard to make update_effective_progs fail in __cgroup_bpf_attach.
>>
>> v3: https://lore.kernel.org/bpf/20260720033055.1215477-1-pulehui@huaweicloud.com
>> - Add new fix for UAF issue when reading bpf link info. (Sashiko)
>> - Add new fix for storage not restored when update_effective_progs
>>    failed. (Sashiko)
>>
>> v2: https://lore.kernel.org/bpf/20260717073343.958862-1-pulehui@huaweicloud.com
>> - Fix invalid access for in-place update when storage changed. (Sashiko)
>>
>> v1: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweicloud.com
>>
>> Pu Lehui (4):
>>    bpf: Fix potential UAF in bpf_netns_link_update_prog
>>    bpf: Fix UAF due to missing link type check in mprog
>>    bpf: Fix potential UAF when reading bpf link info
>>    bpf, cgroup: Fix storage null-ptr-deref after replacing prog
>>
>>   drivers/net/netkit.c       | 13 ++++++-----
>>   include/linux/bpf_mprog.h  |  6 ++++--
>>   kernel/bpf/cgroup.c        | 44 +++++++++++++++++++++++++++++++++++++-
>>   kernel/bpf/mprog.c         | 23 ++++++++++++--------
>>   kernel/bpf/net_namespace.c | 14 +++++++-----
>>   kernel/bpf/syscall.c       | 21 ++++++++++++++----
>>   kernel/bpf/tcx.c           | 13 ++++++-----
>>   7 files changed, 99 insertions(+), 35 deletions(-)
>>
>> --
>> 2.34.1
>>

