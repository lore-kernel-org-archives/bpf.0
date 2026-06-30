Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE6E56A;
	Tue, 30 Jun 2026 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782377; cv=none; b=rzWNv8bPFbfg8Xu4WoFRoH0glZEg2jUnuDeoie9aLgFHGv73kz8y3ti8w7Bn3u7F0I3tyKYsDZ/TExc+dmjgAX7fuyxPHaohj/jv56mzsPud0Lror6d4Beg1DeERCFO1UfnbCCi6MIrko1HR3uZkRIM8qZ/MPYyPJ3VpOkE6oNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782377; c=relaxed/simple;
	bh=peWAbyqXpsv3LiV9QAIC1oXbRLP6lWXeCnCVHSXq+RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9/3U3gXw7QEpfdWPLaKREuwJMf36pTcfPt3uHHA8LoNh0KoF44rcthFWZe9Dj1EdOnykf25jxQwB2DeX0BYGdSDtj+3Q7hW7wMIkVuASYfD4jlmXciQwQLsOO/XxhR8I3jR1X64voMYfYLe+r3ZbuMcfscs1+WnY4+ALhKtXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gq50036YyzKHLw3;
	Tue, 30 Jun 2026 09:19:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id ADBC840590;
	Tue, 30 Jun 2026 09:19:19 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAXh_SWGUNqKGU7AQ--.354S2;
	Tue, 30 Jun 2026 09:19:19 +0800 (CST)
Message-ID: <8ea18b6a-932c-4eb0-a536-d52ce3e1f457@huaweicloud.com>
Date: Tue, 30 Jun 2026 09:19:18 +0800
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
 <678ec73d-06f1-4860-94be-be000ca462d4@huaweicloud.com>
 <b4b906cb-e7b2-4ba7-bbb9-e6c813238859@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <b4b906cb-e7b2-4ba7-bbb9-e6c813238859@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXh_SWGUNqKGU7AQ--.354S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4kZw1rAFW8tr1fGw1rWFg_yoW8urWrpF
	yktFyUKFyDJr92yr18tr1UJry5tr48Gw4DXr13XFWrX3saqrnYgr1UWF4Y9ry5Jw4rAFy0
	vrWUZrnxur1DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/29/2026 9:53 PM, Leon Hwang wrote:
> On 2026/6/29 19:32, Xu Kuohai wrote:
>> On 6/29/2026 6:55 PM, Leon Hwang wrote:
>>> On 29/6/26 15:51, Xu Kuohai wrote:
>>>>>
>>>>> With the elimination, the callsite of 'subprog' has been eliminated.
>>>>>
>>>>> However, as you mentioned above, the argument preparation insns are
>>>>> kept.
>>>>>
>>>>
>>>> I see, the CALL insntruction is removed, not patched to NOP.
>>>>
>>>> So the call site is either a call to subprog, or totally removed. The
>>>> fentry
>>>> tracing only works when the CALL instruction and the subprog are not
>>>> eliminated.
>>>> This is exactly what SDT tries to solve.
>>>>
>>> So, why not add a macro for the stub following the subprog+fentry idea?
>>>
>>> #define DEFINE_TRACING_STUB(__stub, ...)     \
>>> static __noinline void __stub(...)        \
>>> {                        \
>>>      ...                    \
>>> }
>>>
>>> DEFINE_TRACING_STUB(my_trace, int, len, int, ret);
>>>
>>> SEC("xdp")
>>> int xdp_prog(struct xdp_md *ctx)
>>> {
>>>      ...
>>>      my_trace(len, ret);
>>>      ...
>>> }
>>>
>>> Then, add a libbpf API bpf_program__remove_stub(prog, my_stub) to drop
>>> the stub by the way like my demo.
>>>
>>
>> Since the stub prog is dropped in libbpf, where is the fentry prog
>> attached?
>>
> 
> No. By default, the stub prog won't be dropped by libbpf. The
> bpf_program__remove_stub() API is provided so that users can
> intentionally remove the stub prog.
> 
> Maybe bpf_program__remove_subprog() would be a better name for the API,
> because it is to remove a subprog.
> 

So it is more of a user-space workaround than a formal solution. And even
for this workaround, there is no need to add a new libbpf API to remove the
stub. You can simply build two versions of bpf prog, one with subprog and
one without. When you need to trace fentry, load the first one; otherwise,
load the second one.

What SDT resolves is dynamic tracing after the prog is loaded, the hacking
before loading does not apply.

> Thanks,
> Leon

