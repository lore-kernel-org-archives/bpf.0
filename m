Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123493D2FE6;
	Tue, 10 Mar 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125577; cv=none; b=QDNwylL2LZ9jp5gmqn40qKJa4RLFfXuW3jSo2xQxM66umZmNCl/IDgohtr3wledD3lRnjiwRUmJrJCLISYsrfUmQiqKJNJe5qbzk+CZVdkkBDbsPNCXnDc9rzHmZX7CHPwUH7kdnHqjwtrHccTvBiAprIXYc258fOPicELUEk5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125577; c=relaxed/simple;
	bh=yIuBqtSvCnpw+/JYyZxc+lddC/2WuN+ViGmYB0qeyE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmZNosn909h+QHr06b+RDPgeJQksfNl8AagwO+pkivqd0lwIfwNy2e6g7ySil6EChfGxFEbI2NBDkE1krgP/BMY/odXaHlpUd8Jp5JSS7TnxZa4k7oISiIRqByKzK9P8Qcu4pKRTkjMLoW+Ln6UatD2J/letavaYIjDk9//z78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fVPhP140jzKHMfY;
	Tue, 10 Mar 2026 14:52:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0D4534056E;
	Tue, 10 Mar 2026 14:52:52 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAH51PDv69ps+J6AQ--.54069S2;
	Tue, 10 Mar 2026 14:52:51 +0800 (CST)
Message-ID: <7466ab50-da7f-458e-b408-c98e07c0cc7a@huaweicloud.com>
Date: Tue, 10 Mar 2026 14:52:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v8 1/5] bpf: Move constants blinding from JIT to
 verifier
Content-Language: en-US
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Shahab Vahedi <list+bpf@vahedi.org>,
 Russell King <linux@armlinux.org.uk>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Hengqi Chen <hengqi.chen@gmail.com>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Christophe Leroy <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
 <20260309140044.2652538-2-xukuohai@huaweicloud.com>
 <aa8Bd0GQdEj960iP@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <aa8Bd0GQdEj960iP@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAH51PDv69ps+J6AQ--.54069S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUAFyDKw15urW7Xw4xJFb_yoW5JFyxpa
	sYqF17Aryrt3y8Kr1UGF1qyFyUJr4IgF1rKFW8Wa429rnFgrykWa4UKFZ7Kay3CFy5Ww4f
	X34Fgr9rZay0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jzE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/10/2026 1:20 AM, Anton Protopopov wrote:

[...]

>>   	if (!jit_data) {
>>   		jit_data = kzalloc_obj(*jit_data);
>> -		if (!jit_data) {
>> -			prog = orig_prog;
>> +		if (!jit_data)
>>   			goto out;
>> -		}
>>   		prog->aux->jit_data = jit_data;
>>   	}
>>   	priv_stack_ptr = prog->aux->priv_stack_ptr;
>> @@ -3765,10 +3749,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 8) +
>>   				      2 * PRIV_STACK_GUARD_SZ;
>>   		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 8, GFP_KERNEL);
>> -		if (!priv_stack_ptr) {
>> -			prog = orig_prog;
>> +		if (!priv_stack_ptr)
>>   			goto out_priv_stack;
>> -		}
>>   
>>   		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
>>   		prog->aux->priv_stack_ptr = priv_stack_ptr;
>> @@ -3786,10 +3768,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   		goto skip_init_addrs;
>>   	}
>>   	addrs = kvmalloc_objs(*addrs, prog->len + 1);
>> -	if (!addrs) {
>> -		prog = orig_prog;
>> +	if (!addrs)
>>   		goto out_addrs;
>> -	}
>>   
>>   	/*
>>   	 * Before first pass, make a rough estimation of addrs[]
>> @@ -3820,8 +3800,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   						   sizeof(rw_header->size));
>>   				bpf_jit_binary_pack_free(header, rw_header);
>>   			}
>> -			/* Fall back to interpreter mode */
>> -			prog = orig_prog;
>>   			if (extra_pass) {
>>   				prog->bpf_func = NULL;
>>   				prog->jited = 0;
>> @@ -3852,10 +3830,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   			header = bpf_jit_binary_pack_alloc(roundup(proglen, align) + extable_size,
>>   							   &image, align, &rw_header, &rw_image,
>>   							   jit_fill_hole);
>> -			if (!header) {
>> -				prog = orig_prog;
>> +			if (!header)
>>   				goto out_addrs;
>> -			}
>>   			prog->aux->extable = (void *) image + roundup(proglen, align);
>>   		}
>>   		oldproglen = proglen;
>> @@ -3908,8 +3884,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   		prog->bpf_func = (void *)image + cfi_get_offset();
>>   		prog->jited = 1;
>>   		prog->jited_len = proglen - cfi_get_offset();
>> -	} else {
>> -		prog = orig_prog;
>>   	}
>>   
>>   	if (!image || !prog->is_func || extra_pass) {
>> @@ -3925,10 +3899,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>   		kfree(jit_data);
>>   		prog->aux->jit_data = NULL;
>>   	}
>> +
>>   out:
> 
> small nit: is the label 'out' necessary now?
> 

There is a "goto out" in the "if (!jit_data)" body, but it is the
only one, I'll replace it with a direct "return prog" and remove
the out label.

