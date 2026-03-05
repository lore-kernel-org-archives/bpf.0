Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C6219FC;
	Thu,  5 Mar 2026 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682449; cv=none; b=MLzt1UK0eQamFt/HoykN/eFw64ERpIObDWpNM7c5bUOQVaojimp2jXdyr4X9jxl1sEePlwR/f/wbSxZDlD2qxZZYFs0ubFu1Lwq9tIEXIwUxN1Znd1EW79VGaQ3XSd6bcSJwepYIEYljiuJrXlhEYYYfElUXoVE8n06kjlJcssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682449; c=relaxed/simple;
	bh=1X6v5AS2FiuqTCoMMl4WBP+vfzJqYQZ4x93BWjvSru4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qsx2pcuZy1LtHFq1v2XSyu35K1qBjQaqYPrPk/slKAXsUjc1z5+JstlWzdUFbtUom17nUnzsBEnTYr9mCfX2fuZv9mu2LNCAb0mqfiwZVqOK9Q3F7CUj3rgLgeT/L3EI8JcmVRxGc4BLEFcE6jG6cU0uZ6GD+OuAIrrAPP6U910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fRFp91GBZzYQtkt;
	Thu,  5 Mar 2026 11:46:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CAAC34056E;
	Thu,  5 Mar 2026 11:47:17 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgDHFRTE_KhpEeyxJQ--.41212S2;
	Thu, 05 Mar 2026 11:47:17 +0800 (CST)
Message-ID: <0f18b3b1-9bd1-4ce8-a7df-c1149cf6e14d@huaweicloud.com>
Date: Thu, 5 Mar 2026 11:47:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Add helper to detect indirect jump
 targets
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
 <20260302102726.1126019-4-xukuohai@huaweicloud.com>
 <CAADnVQLoWzz8ioVg3MFjn08fBLfNq6HdvqLtqXV0zUb=SR_HGA@mail.gmail.com>
 <1ea52c33-ae27-45fb-b4ff-0c4637a4312a@huaweicloud.com>
 <CAADnVQ+HvsZ0zr6AGLBhMOVX1uRKwRqV28ywcvpVkrsDTyaXmw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQ+HvsZ0zr6AGLBhMOVX1uRKwRqV28ywcvpVkrsDTyaXmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHFRTE_KhpEeyxJQ--.41212S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17Cw45Xry3Kr48CF4kZwb_yoW8CF1rpa
	4DXayUAF4Uta1Yvw12gr40yrWagr47Xwn0ya45WrWUAr9FgFn3JF4UKr4Fkas8trW5AF1I
	qr42vrZxuFy3GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/4/2026 11:37 PM, Alexei Starovoitov wrote:
> On Wed, Mar 4, 2026 at 4:46 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 3/4/2026 1:19 AM, Alexei Starovoitov wrote:
>>
>> [...]
>>
>>>> -       for (i = 0; i < insn_cnt; i++, insn++) {
>>>> +       for (i = 0, j = 0; i < insn_cnt; i++, j++, insn++) {
>>>> +               env->insn_aux_data[subprog_start + j].final_idx = i;
>>>>                   if (bpf_pseudo_func(insn)) {
>>>>                           /* ld_imm64 with an address of bpf subprog is not
>>>>                            * a user controlled constant. Don't randomize it,
>>>> @@ -1512,6 +1542,8 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
>>>>                            */
>>>>                           insn++;
>>>>                           i++;
>>>> +                       j++;
>>>> +                       env->insn_aux_data[subprog_start + j].final_idx = i;
>>>
>>> You're adding final_idx because bpf_jit_blind_constants()
>>> doesn't call adjust_insn_aux_data() ?
>>>
>>
>> Yes, I added final_idx because insn_aux is not updated here.
>>
>>> imo that's an ugly workaround. Just call adjust_insn_aux_data().
>>>
>>
>> If we adjust the env->insn_aux_data here, should we also adjust the global
>> env->prog->insnsi array? I think env->insn_aux_data should remain consistent
>> with the global env->prog->insnsi array. Since constant blinding only rewrites
>> the subprog's private instruction array, updating the env->insn_aux_data
>> causes a mismatch with the global state.
> 
> yes, and subprog starts, and pokes that bpf_patch_insn_data() do.
> 
> blinding was implemented long before that, so it was never updated.

I see. Since env->prog->insnsi is rewritten by blind_constants now, would it
make sense to move constant blinding to the beginning of jit_subprogs, just
before the global instruction array is split into subprog copies?

This would eliminate the need to invoke constant blinding per subprog from
the arch-specific JIT, simplifying the overall flow.

