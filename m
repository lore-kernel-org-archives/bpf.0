Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7A40D58A;
	Mon, 29 Jun 2026 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782701634; cv=none; b=YDJcDx90O1WbBfoucys+0iO3Zqry58M4v7ZBdJqHk/V2qUOyK6oEhukb/tyBZkJ+vwHYG2utXf/P5Vi8E4rP/5bMcitqHoeXIzNZbkn6zn2Plmz/1f/9fznmSWFc/K27BVqehDIK7pZp26NEpwkWSHI1EbneVLvuTVHgmqr2Ufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782701634; c=relaxed/simple;
	bh=Y3jI8fnbIM6jOH5gOc5i78UR4mnPRQXqn1JxwQs2gJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JOHCZezn1HFPNTkw0ZAwCziEnXQeCJAD60wGyCDVrsgEUn2usa1vVY74LfJClyJbwiAVUL8caMT5MkH0tA9fNqhxjRX0SPicu6E/qeph9vdtokKQIZmF2ripGIAv4q/QEyl42Vr1VqSt2hcXR03HKam+ykdziAxuQ4oNFCmmUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pYcownOW; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pYcownOW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=W3FqOxsqdQ6iwoUKRoTUgDxVPiV8Voe0fgSNJHznDw8=;
	b=pYcownOWqGaXEePpDpYbUTSVTuffdVuH/4YGcEIz54CPk4yHi1wupiDjhIMmCaBAQLZZKZILI
	rE0KHW3FO+xSukROjHlVMlygXYuZoXTem+xj0RtQhjxcPy8+v4oI75my3Eh3JKXUL2oOfg2w+VK
	TA0O2rrs3bR3cJrihPd8ErU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gpVwg2TGvzLlZH;
	Mon, 29 Jun 2026 10:44:19 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 99AF540588;
	Mon, 29 Jun 2026 10:53:27 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 29 Jun
 2026 10:53:26 +0800
Message-ID: <d5810b66-a2f9-4449-a808-c588e4a2ff1c@huawei.com>
Date: Mon, 29 Jun 2026 10:53:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] riscv, bpf: Add support for BPF exceptions
Content-Language: en-US
To: Varun R Mallya <varunrmallya@gmail.com>
CC: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<eddyz87@gmail.com>, <memxor@gmail.com>, <bjorn@kernel.org>, <alex@ghiti.fr>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <emil@etsalapatis.com>, <puranjay@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
 <20260621144259.288135-3-varunrmallya@gmail.com>
 <b6e8c677-5fff-4de1-8483-fc23361898dc@huawei.com> <akDOkptnqJt9LDtj@computer>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <akDOkptnqJt9LDtj@computer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/6/28 15:34, Varun R Mallya wrote:
> On Tue, Jun 23, 2026 at 10:11:57AM +0800, Pu Lehui wrote:
>>
>> We don't need to duplicate code. Please merge it.
> 
> Making this change in the next version!
> 
>>> +
>>> +		if (!aux->exception_cb && aux->exception_boundary) {
>>> +			/*
>>> +			 * Boundary program: allocate the frame and save the
>>> +			 * full callee-saved set, capturing the caller's values.
>>> +			 */
>>> +			emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
>>> +			for (i = 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
>>> +				emit_sd(RV_REG_SP, store_offset,
>>> +					rv_exception_csave_regs[i], ctx);
>>> +				store_offset -= 8;
>>> +			}
>>> +			emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
>>> +		} else {
>>> +			/*
>>> +			 * Exception callback, reuse the boundary program's
>>> +			 * frame, whose frame pointer is passed in a2. Setting
>>
>> something confused—why is it A2? I feel like I missed something.
> 
> bpf_throw() invokes the exception callback as
> bpf_exception_cb(cookie, sp, bp, 0, 0) , whose 3rd argument (which,
> according to RISC-V's calling convention resides in A2) is the boundary
> prog's frame pointer. Since this else branch handles
> the callback, it expects A2 to have the frame pointer. The arm
> implementation does something very similar with emit(A64_MOV(1, A64_FP, A64_R(2)), ctx)
> where A64_R(2) is the third arg.

ok, so it would be better to clear in the comments that it is the third 
parameter.

> 
>>> +			 * SP = FP - stack_adjust lines the epilogue's loads up
>>> +			 * with the registers the boundary saved.
>>> +			 */
>>> +			emit_mv(RV_REG_FP, RV_REG_A2, ctx);
>>> +			emit_addi(RV_REG_SP, RV_REG_FP, -stack_adjust, ctx);
>>> +		}
>>> +
>>> +		goto tail_setup;
>>> +	}
>>> +
>>>    	if (seen_reg(RV_REG_RA, ctx))
>>>    		stack_adjust += 8;
>>>    	stack_adjust += 8; /* RV_REG_FP */
>>> @@ -2082,6 +2173,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>>>    	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
>>> +tail_setup:
>>>    	if (bpf_stack_adjust)
>>>    		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
>>> @@ -2157,3 +2249,13 @@ bool bpf_jit_supports_fsession(void)
>>>    {
>>>    	return true;
>>>    }
>>> +
>>> +bool bpf_jit_supports_exceptions(void)
>>> +{
>>> +	/*
>>> +	 * bpf_throw() unwinds by walking the frame-pointer chain from inside
>>> +	 * the kernel back into the BPF frames (see arch_bpf_stack_walk()), so
>>> +	 * exceptions require the frame-pointer unwinder to be enabled.
>>> +	 */
>>> +	return IS_ENABLED(CONFIG_FRAME_POINTER);
>>
>> riscv select ARCH_WANT_FRAME_POINTERS, so this will always true
> 
> I checked that the kernel compiled even when I turned
> CONFIG_FRAME_POINTER explicitly off, so not gating this
> would be a mistake, right ? ARCH_WANT_FRAME_POINTERS makes
> CONFIG_FRAME_POINTER user selectable and makes it default to
> true, but it's not always true. What does force it is PERF_EVENTS=y but if
> that too is turned off, then CONFIG_FRAME_POINTER can also be turned
> off.

alright, lgtm
> 
> Thanks for the review!!
> - Varun
>>> +}
