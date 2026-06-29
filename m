Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9736402D;
	Mon, 29 Jun 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732789; cv=none; b=k84q9PjZ4L0w3dsRjxaET/sauDyqxaX0XRKch6+L+N/08sRsg2s5KTYTQfIYrZ5ylvklFkAdKV1hV5S75L7m/2yeZPAXVv5yqMLJPSu5eTYcnZM0YiiwylS3cQs1XknZhwyXxJoNpiuZxagkdKR40/1nh7z4+/HlOfyFlbHvwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732789; c=relaxed/simple;
	bh=mfnEHJGxHjikUe7Pl8fEINnkrRV031++mqKqtGKkK7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juMPNP6W4YgosnqXpuL78woVKQksHYU8MYPa97AN51btX9DfVnnTnFi3AbSLj3BbBaCqWphISgew36QUdgiQIgGaruaB7jwXwt9ydoRp+/+XPc+yAcL8wtzB6014SONlOMytNR0UddUCpQnxSRHown8oTnQR98M65m97Pxhf848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gpkdc3kXCzYQtwf;
	Mon, 29 Jun 2026 19:32:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7F4F04056D;
	Mon, 29 Jun 2026 19:32:55 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCXaofmV0JqNUb1AA--.57083S2;
	Mon, 29 Jun 2026 19:32:55 +0800 (CST)
Message-ID: <678ec73d-06f1-4860-94be-be000ca462d4@huaweicloud.com>
Date: Mon, 29 Jun 2026 19:32:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <855e44f3-d22c-47e5-8bd1-c5d9f7014a75@linux.dev>
 <ec28f0f9-0693-4c9b-88fa-bffca446a63c@huaweicloud.com>
 <b8d8ab5e-bef1-4c95-8e5b-ea9768041b2e@linux.dev>
 <55499fcf-d552-4366-9016-21ede7f687ac@huaweicloud.com>
 <4f30012f-778b-4c7d-b610-2e18cf01abdd@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <4f30012f-778b-4c7d-b610-2e18cf01abdd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXaofmV0JqNUb1AA--.57083S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1DJFWkXrW8Cr1UGr43Awb_yoWDZFb_Z3
	9Ivw1kCw18uanrtF4DGr43ur9xCan5Ga4UJayrWFW3ta9xJaykAF1ru3srury5KrZFvFZx
	CrsrZa4rJw1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/29/2026 6:55 PM, Leon Hwang wrote:
> On 29/6/26 15:51, Xu Kuohai wrote:
>>>
>>> With the elimination, the callsite of 'subprog' has been eliminated.
>>>
>>> However, as you mentioned above, the argument preparation insns are kept.
>>>
>>
>> I see, the CALL insntruction is removed, not patched to NOP.
>>
>> So the call site is either a call to subprog, or totally removed. The
>> fentry
>> tracing only works when the CALL instruction and the subprog are not
>> eliminated.
>> This is exactly what SDT tries to solve.
>>
> So, why not add a macro for the stub following the subprog+fentry idea?
> 
> #define DEFINE_TRACING_STUB(__stub, ...) 	\
> static __noinline void __stub(...)		\
> {						\
> 	...					\
> }
> 
> DEFINE_TRACING_STUB(my_trace, int, len, int, ret);
> 
> SEC("xdp")
> int xdp_prog(struct xdp_md *ctx)
> {
> 	...
> 	my_trace(len, ret);
> 	...
> }
> 
> Then, add a libbpf API bpf_program__remove_stub(prog, my_stub) to drop
> the stub by the way like my demo.
>

Since the stub prog is dropped in libbpf, where is the fentry prog attached?

> Thanks,
> Leon

