Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9413368B5;
	Wed,  4 Mar 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628363; cv=none; b=Hb9GJF8F6GT/4JkgiEZ7b2Cbg5cI7UpR0qx2KTa10NnpLupcwQoVzsYyL/fEmCdzDOg3nayAx6VrZ4Gl1rYzmdLE3lk1Xw9Up/8w0iwTnCAN9xQ/sPM/1OnV7yqhpcHJwpFJaHaILjnT++FwsjqWRknSC5Zg8VBYr6f9ulJrxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628363; c=relaxed/simple;
	bh=KRGTHnHwChWv7eq2C4qOoxk0A1MfWNS3pYtwRp/SGXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOPUuJ6EZOa3Nbl3LKlKSdmSooOoMFiFCqzVcZO+Ez8gYWVoOhsCKPUgZdPnUzXn+Q3K+J5xDkkVPOi1X0ikiJz7G20zKAg40jhNTfvCxePfu/IUSjTB8EIzlwg7Zpp16SSMIwsMv5Rcx4coRr6F/sjHn77S+g3mYzVi/edxJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fQspB1C8TzYQvQg;
	Wed,  4 Mar 2026 20:45:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B98444056E;
	Wed,  4 Mar 2026 20:45:57 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgBXEOaEKahpJ_6cJQ--.63728S2;
	Wed, 04 Mar 2026 20:45:57 +0800 (CST)
Message-ID: <1ea52c33-ae27-45fb-b4ff-0c4637a4312a@huaweicloud.com>
Date: Wed, 4 Mar 2026 20:45:56 +0800
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>
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
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQLoWzz8ioVg3MFjn08fBLfNq6HdvqLtqXV0zUb=SR_HGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXEOaEKahpJ_6cJQ--.63728S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7GF45Kr48Gr48ArW8Zwb_yoW8GFWxpa
	9rX3y5CF47ta1Y9r17WFy0yrWa9F4UJ3ZIkay5WrW8urW2grn5ZF4UKF4vy3s8trWft3Wx
	ur4j9rZ7CFsxCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/4/2026 1:19 AM, Alexei Starovoitov wrote:

[...]

>> -       for (i = 0; i < insn_cnt; i++, insn++) {
>> +       for (i = 0, j = 0; i < insn_cnt; i++, j++, insn++) {
>> +               env->insn_aux_data[subprog_start + j].final_idx = i;
>>                  if (bpf_pseudo_func(insn)) {
>>                          /* ld_imm64 with an address of bpf subprog is not
>>                           * a user controlled constant. Don't randomize it,
>> @@ -1512,6 +1542,8 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
>>                           */
>>                          insn++;
>>                          i++;
>> +                       j++;
>> +                       env->insn_aux_data[subprog_start + j].final_idx = i;
> 
> You're adding final_idx because bpf_jit_blind_constants()
> doesn't call adjust_insn_aux_data() ?
>

Yes, I added final_idx because insn_aux is not updated here.

> imo that's an ugly workaround. Just call adjust_insn_aux_data().
>

If we adjust the env->insn_aux_data here, should we also adjust the global
env->prog->insnsi array? I think env->insn_aux_data should remain consistent
with the global env->prog->insnsi array. Since constant blinding only rewrites
the subprog's private instruction array, updating the env->insn_aux_data
causes a mismatch with the global state.

> And in the future please mention such design decisions in the commit log,
> so that reviewers don't need to reverse engineer your thought process.
>

Sorry for the lack of clarity. I’ll make an effort to clarify things more
clearly in the future.

> pw-bot: cr
> 
> 

