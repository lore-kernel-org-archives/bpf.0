Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F9376489;
	Mon,  9 Mar 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048093; cv=none; b=islOn8Ompiwh3l42fAZ4BDKdXV+W8y6+ciGoX4W2JEA3kzGdE1zqWi4yv+2zMT0TgLH7yD6Ca/BOgr7wzJ4n6+BfPv9voMH8RgTFTr1utDyb0bZ1eR4CwcfTUMAFdbkGXrsqDLfkBJ3bvouP/4ljkJeBu8X5niz9rLy/0kuBSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048093; c=relaxed/simple;
	bh=/n48IteFM9Uvn1hHkPEG10SUV5w2fI61H77Ai/9kek0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8T0jrBnQYVE/Rzb5P9ri52xH5kRVNfi7LJJSewu58PrHFZ0BD01XhQ9CyjTD+DKPSR3Sm+WEx/MeLHE/1KFwekD5epvK9kZt+48E78fghB+5ehIiyIX3+Q2vKLvL8nE/wvFlN3eCJ7/YnuxUTvaN4annXX6VGXMDrTcu5fc8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fTs2C0qqNzKHMf3;
	Mon,  9 Mar 2026 17:21:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 968AC4056E;
	Mon,  9 Mar 2026 17:21:20 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgDXr0oOka5pHwUTAQ--.64074S2;
	Mon, 09 Mar 2026 17:21:19 +0800 (CST)
Message-ID: <b3b56b5c-7d42-4943-a81a-ed3f942e4ffd@huaweicloud.com>
Date: Mon, 9 Mar 2026 17:21:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v7 3/5] bpf: Add helper to detect indirect jump targets
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 puranjay@kernel.org, a.s.protopopov@gmail.com, list+bpf@vahedi.org,
 linux@armlinux.org.uk, yangtiezhu@loongson.cn, hengqi.chen@gmail.com,
 johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
 hbathini@linux.ibm.com, chleroy@kernel.org, naveen@kernel.org,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org,
 pulehui@huawei.com, iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 davem@davemloft.net, udknight@gmail.com, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260307103949.2340104-4-xukuohai@huaweicloud.com>
 <ca484ba53c9ce4dac51c7ae3e8888cfe561b31c3826880c6fc89d5581c6de2fa@mail.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <ca484ba53c9ce4dac51c7ae3e8888cfe561b31c3826880c6fc89d5581c6de2fa@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXr0oOka5pHwUTAQ--.64074S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW8GF47Xry8uFW8tw43Wrg_yoW5Jw1xpF
	W7Wr47CF4qyFWktr17CFyqkr1agws8Wr90yFWDW3yxAw1YgFn5XFWagw4IyFy5tryYk3W3
	JF4j9ry7uanxArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j6a0PUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/8/2026 1:14 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1475,11 +1475,30 @@ int bpf_jit_blind_constants(struct bpf_verifier_env *env)
>>   		insn = prog->insnsi + i + insn_delta;
>>   		insn_cnt += insn_delta;
>>   		i        += insn_delta;
>> +
>> +		/* bpf_patch_insn_data() calls adjust_insn_aux_data() to adjust insn_aux_data. The
>> +		 * indirect_target flag for the original instruction is moved to the last of the new
>> +		 * instructions, but the indirect jump target is actually the first one, so move
>> +		 * it back.
>> +		 */
>> +		if (env->insn_aux_data[i].indirect_target) {
>> +			env->insn_aux_data[i].indirect_target = 0;
>> +			env->insn_aux_data[i - insn_delta].indirect_target = 1;
>> +		}
> 
> This fixup handles the displacement caused by
> bpf_jit_blind_constants() itself, but adjust_insn_aux_data() has
> the same displacement behavior in every caller of
> bpf_patch_insn_data(). Several patching passes run before
> bpf_jit_blind_constants() in bpf_check():
> 
>    convert_ctx_accesses()      ->  bpf_patch_insn_data()
>    do_misc_fixups()            ->  bpf_patch_insn_data()
>    opt_subreg_zext_lo32_rnd_hi32() -> bpf_patch_insn_data()
>    fixup_call_args()           ->  bpf_jit_blind_constants()  <-- only fixup here
> 
> All of these call adjust_insn_aux_data() which does:
> 
>    memmove(data + off + cnt - 1, data + off, ...)
>    memset(data + off, 0, ...)
> 
> This moves indirect_target from data[off] to data[off + cnt - 1].
> Meanwhile, bpf_insn_array_adjust() preserves xlated_off == off:
> 
>    if (insn_array->values[i].xlated_off <= off)
>        continue;
> 
> So after an earlier pass patches an indirect target instruction,
> the insn_array still says the target is at off, but
> insn_aux_data has indirect_target set at off + cnt - 1.
> 
> If an indirect jump target is also, say, a helper call that
> do_misc_fixups() replaces with multiple instructions, would
> bpf_insn_is_indirect_target() return the wrong result for that
> instruction? It seems like the fixup might need to be in
> adjust_insn_aux_data() itself rather than only in
> bpf_jit_blind_constants().
> 

OK, will move the fixup to adjust_insn_aux_data()

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22803043949

