Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B9175A97;
	Fri,  5 Jun 2026 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627897; cv=none; b=oIJW5BD/1x6Ro++kFrSxbh2EElJqzt2hViylcDkiOby0LdaJv6PuDWt1GcyNZSq0nnzsCN2GdphkLArsUO+plXJDe3/mzJwD/TFz4i1gpbDItUWX5fFXkFplnJ4Mx4qvWbfmG7uNJ8AyNwEw1Tvo/mAizglNVsj5UoOrj5zDBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627897; c=relaxed/simple;
	bh=yBXq7OzVI8JwTtGbQYYGf3hZwJpBmsCrfFbuGxztHOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcuzM42yJ//p7l1Pe06qBTUA5ajPEj0zrAc66G+VOGqUZN0DEoq1sYZXOsbMGCnoVUqU8MwJL4+Xec+HUKmfHaMYn0h/N6m1fOAOii41vz1tJLzO7vODeo6X4BER38G0GlB2BGb2tom5ROPIlSNt6C6Q9GXrmIEsWawvbYpnmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gWmCP21tSzKHMNx;
	Fri,  5 Jun 2026 10:50:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AD7684058C;
	Fri,  5 Jun 2026 10:51:25 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgDXToSrOSJq9WqpAg--.43050S2;
	Fri, 05 Jun 2026 10:51:23 +0800 (CST)
Message-ID: <2f37de11-c456-4e36-917b-a962063803d8@huaweicloud.com>
Date: Fri, 5 Jun 2026 10:51:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 2/3] bpf: Add validation for bpf_set_retval
 argument
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, YiFei Zhu <zhuyifei@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Quan Sun <2022090917019@std.uestc.edu.cn>
References: <20260604130458.617765-1-xukuohai@huaweicloud.com>
 <20260604130458.617765-3-xukuohai@huaweicloud.com>
 <c7d73755-cc38-4dc0-9d8a-058fc6243d2e@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <c7d73755-cc38-4dc0-9d8a-058fc6243d2e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDXToSrOSJq9WqpAg--.43050S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxKrW5KF1ftw15WFWrGrg_yoW8KF4Upr
	Z0yFyjkrn8Crn2qrZaqa4vvFy0vw4YgrnY9rykXryxAFsIkrWfCr4Y93yj9rWSyF4kGw1j
	vF45ZrZxZFy2q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/5/2026 3:19 AM, Yonghong Song wrote:
> 
> 
> On 6/4/26 6:04 AM, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> The bpf_set_retval() helper is used by cgroup BPF programs to set the
>> return value of the target hook. The argument type for this helper is
>> ARG_ANYTHING. This allows setting a positive value, which no cgroup
>> hook expects and can cause issues, such as:
>>
>> - BPF_LSM_CGROUP: a positive value from bpf_lsm_socket_create bypasses
>>    the err < 0 check in __sock_create(), leaving the socket object
>>    unallocated. The positive return value is then propagated to the
>>    syscall entry __sys_socket(), which also bypasses the IS_ERR() guard
>>    and ultimately causes a NULL pointer dereference.
>>
>> - BPF_CGROUP_DEVICE: a positive value can be returned through cgroup
>>    device bpf prog -> devcgroup_check_permission() -> bdev_permission()
>>    -> bdev_file_open_by_dev(), where ERR_PTR(positive) produces a pointer
>>    that IS_ERR() does not catch, leading to a wild pointer dereference.
>>
>> - BPF_CGROUP_SOCK: a positive value can be returned through cgroup sock
>>    bpf prog -> __cgroup_bpf_run_filter_sk() -> inet_create() ->
>>    __sock_create(), where inet_create() frees the newly allocated sk
>>    via sk_common_release() and sets sock->sk = NULL on the non-zero
>>    return, but __sock_create() only checks err < 0 for cleanup, so a
>>    positive retval bypasses cleanup and returns a socket with NULL sk
>>    to userspace, triggering a NULL pointer dereference on subsequent
>>    socket operations.
>>
>> - BPF_CGROUP_SYSCTL: a positive value can be returned through the cgroup
>>    bpf prog -> __cgroup_bpf_run_filter_sysctl() -> proc_sys_call_handler(),
>>    where a non-zero return bypasses the normal sysctl proc_handler and is
>>    returned directly to userspace as return value of read() or write()
>>    syscall.
> 
> FYI, the following patch:
>      https://lore.kernel.org/bpf/20260603105317.944304-4-dawei.feng@seu.edu.cn/
> will change return value for BPF_CGROUP_SYSCTL from 1 to 0.
> 

Hmm, it is a complementary fix. It updates the BPF_CGROUP_SYSCTL to use 0
as the success return value, while my patch restricts the bpf prog to only
return 0 for success or -errno for failure.

> [...]

