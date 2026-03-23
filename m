Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B593AC0E6;
	Mon, 23 Mar 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273162; cv=none; b=FvIjFdBiItcaqnSTEJSGpI14RPj6ArZ+8UR6RnyTCIifXzeE1TthAA6EiO971XvotYjTQu9GXsusUulFokmUX11gvbLWLvK0olMcMAeApP3DtWOH/o4OWaLtpvrcm+mFGma17+Z+X4sd/buAe20+DzAnSCr5WfrAQs6m4Rvblg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273162; c=relaxed/simple;
	bh=18qlEzJSCR/J43+q2kbQxEU183F+Aik3etyCBZt0rLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DObfY83nT1z+JaszXLyPEmbu1uc9Gvh8Vvvr/FuR3SI3rKh0ur6EwXH9pdZVHpA1fmfD4Vz0AKjZyyvpN1xo/0dihpNszF+2kKmsiegjmPzJSRB5+uzSq39SjLGtJUtuVQ5KBpxQyAn9jbdgcDB/nNheilouAL/Fz+cHE5R2OLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ffZ5S1ldhzYQv3W;
	Mon, 23 Mar 2026 21:39:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4434240591;
	Mon, 23 Mar 2026 21:39:15 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgAnKtp+QsFpxAzJBw--.59330S2;
	Mon, 23 Mar 2026 21:39:11 +0800 (CST)
Message-ID: <36162ee3-c05e-4bb1-b673-dc672139e925@huaweicloud.com>
Date: Mon, 23 Mar 2026 21:39:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 4/5] bpf, x86: Emit ENDBR for indirect jump
 targets
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>
Cc: a.s.protopopov@gmail.com, alexis.lothore@bootlin.com, andrii@kernel.org,
 ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, chleroy@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 gor@linux.ibm.com, hbathini@linux.ibm.com, hca@linux.ibm.com,
 hengqi.chen@gmail.com, iii@linux.ibm.com, johan.almbladh@anyfinetworks.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, list+bpf@vahedi.org, luke.r.nels@gmail.com,
 martin.lau@linux.dev, naveen@kernel.org, paulburton@kernel.org,
 pulehui@huawei.com, puranjay@kernel.org, udknight@gmail.com,
 xi.wang@gmail.com, yangtiezhu@loongson.cn, yonghong.song@linux.dev
References: <20260312170255.3427799-5-xukuohai@huaweicloud.com>
 <20260313101505.104686-1-leon.hwang@linux.dev>
 <f384599a-75b8-4387-80db-b20429a0bafd@huaweicloud.com>
 <9ddae3d2-173d-460d-b283-12c983164a69@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <9ddae3d2-173d-460d-b283-12c983164a69@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnKtp+QsFpxAzJBw--.59330S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JF4DWr4rCw1fZr18tr1kKrg_yoW8Jr1DpF
	y8WayYyay8KFZ3G34Fqrn8KF9Fyr1Dtw13Xr18XF4DAr98Kr10gryjgFsagFyFvr48G34I
	gFs8Xr93Zr15J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	4xRDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/14/2026 9:35 PM, Leon Hwang wrote:
> On 2026/3/14 14:48, Xu Kuohai wrote:
>> On 3/13/2026 6:15 PM, Leon Hwang wrote:
>>>> +#ifdef CONFIG_X86_KERNEL_IBT
>>>> +        if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
>>>> +            EMIT_ENDBR();
>>>> +#endif
>>> NIT: is this CONFIG check necessary?
>>>
>>> EMIT_ENDBR already checks it.
>>>
>>> #ifdef CONFIG_X86_KERNEL_IBT
>>> #define EMIT_ENDBR()        EMIT(gen_endbr(), 4)
>>> #define EMIT_ENDBR_POISON()    EMIT(gen_endbr_poison(), 4)
>>> #else
>>> #define EMIT_ENDBR()
>>> #define EMIT_ENDBR_POISON()
>>> #endif
>>
>> Well, the code was originally written exactly without the #ifdef, but it
>> triggered
>> -Wempty-body warning: https://lore.kernel.org/bpf/202603051414.AAMjmOHv-
>> lkp@intel.com/.
>>
> 
> Let's update the macros instead, which can avoid the build warning and
> get rid of the CONFIG check as well.
> 
> #define EMIT_ENDBR() do { } while (0)
> #define EMIT_ENDBR_POISON() do { } while (0)
> 
> The way of "do { } while (0)" is commonly used in kernel.
>

Sorry for the delay. This makes sense to me. The code looks much cleaner
without the #ifdef, thanks!

> Thanks,
> Leon

