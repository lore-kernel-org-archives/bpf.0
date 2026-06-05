Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A213B775E;
	Fri,  5 Jun 2026 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627800; cv=none; b=qOy2+LJI+7nSL57mhGodIu4EQzDFZB6Ho6gVRV3DnoUfMMjBs6lrorkI9LuGvgyod0957p6OPoVe9BRmiP2V6KTaxu43OvOQQt45IklIJZfSoP7iqcF7zQ23+LF7rTrousnkOUlOdCJugz8EQ/OSxOOUv8YtYrZPTxRK2qYI2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627800; c=relaxed/simple;
	bh=78P1CHW+Cw4i+zZad+Ffeict/B4Lo/bXmG1WyB0RA0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLhiH7jL4xT7nDJjFQpy+vL2vvHkiyE1qqK7JRZ++DjUBmXtYQxOszJvxGoDvl5nXeYajq/0hVDih25Pt5R1jchzz1u6E/sZygC99oMLBydMgpnDvTwcgR899uVIqxMCjtHL9VKne7y36m3GuLjPfwsyafSuSrJm4Bn+LqsmC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gWm9W14WXzKHLyd;
	Fri,  5 Jun 2026 10:49:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9207540562;
	Fri,  5 Jun 2026 10:49:47 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgCHLgpKOSJqakSjAg--.37652S2;
	Fri, 05 Jun 2026 10:49:47 +0800 (CST)
Message-ID: <56d0a094-041f-467b-a23d-7d794d377d60@huaweicloud.com>
Date: Fri, 5 Jun 2026 10:49:46 +0800
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, YiFei Zhu <zhuyifei@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Quan Sun <2022090917019@std.uestc.edu.cn>,
 Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260604130458.617765-3-xukuohai@huaweicloud.com>
 <a91c8225b90fc2330bdca6af51f72c7cb872c1127deb54ca6d89f6f3f34b9657@mail.kernel.org>
 <CAADnVQ+Bgs-jSEFPx6wuQY=YBbrfsnn4w_ceedRmK1=MHsziJw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQ+Bgs-jSEFPx6wuQY=YBbrfsnn4w_ceedRmK1=MHsziJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHLgpKOSJqakSjAg--.37652S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy8Zw4xGr45Jw45KrWrGrg_yoW8Zw45pF
	4kGF4DJr1UXrWa9w1Iq3WkZrW0q3WjqryfuFykJ3sIya9a9wn3tFyUWr43GryYyrW8Gr4I
	kF1j939Yva90va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/5/2026 12:29 AM, Alexei Starovoitov wrote:
> On Thu, Jun 4, 2026 at 6:52 AM <bot+bpf-ci@kernel.org> wrote:
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 7fb88e1cd7c4..1bf58685b655 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -9952,6 +9952,7 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
>>>                                  int func_id,
>>>                                  struct bpf_call_arg_meta *meta)
>>>   {
>>> +     struct bpf_retval_range range;
>>>        struct bpf_reg_state *ret_reg = &regs[BPF_REG_0];
>>>
>>>        if (ret_type != RET_INTEGER)
>>> @@ -9980,6 +9981,29 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
>>>                ret_reg->s32_min_value = 0;
>>>                reg_bounds_sync(ret_reg);
>>>                break;
>>> +     case BPF_FUNC_get_retval:
>>> +             /*
>>> +              * bpf_get_reval may see arbitrary value passed by bpf_prog_run_array_cg for
>>> +              * CGROUP_GETSOCKOPT type.
>>> +              */
>>> +             if (env->prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT &&
>>> +                 env->prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT)
>>> +                     break;
>>> +
>>> +             if (env->prog->type == BPF_PROG_TYPE_LSM &&
>>> +                 env->prog->expected_attach_type == BPF_LSM_CGROUP) {
>>> +                     if (!env->prog->aux->attach_func_proto->type)
>>> +                             break;
>>> +                     bpf_lsm_get_retval_range(env->prog, &range);
>>> +             } else {
>>> +                     range.minval = -MAX_ERRNO;
>>> +                     range.maxval = 0;
>>> +             }
>>> +
>>> +             reg_set_srange64(ret_reg, range.minval, range.maxval);
>>> +             reg_set_srange32(ret_reg, range.minval, range.maxval);
>>                      ^^^^^^^^^^^^^^^
>>
>> Are reg_set_srange64() and reg_set_srange32() defined in this kernel? A
>> search across the entire tree finds only these two call sites and no
>> definition. The struct bpf_retval_range has minval/maxval fields but no
>> associated reg_set_srange* helper exists in this codebase.
> 
> AI is correct, because patch subject is wrong.
> It should have been [PATCH bpf-next v4].
> Pls resubmit targeting correct tree.
>

OK, will target bpf-next in v5.

> pw-bot: cr

