Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB719D065;
	Wed,  4 Mar 2026 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629420; cv=none; b=IExjHWiKGsHEI/IcX09Q/RPagmkQU6+kTlA0zGwcPA1/ZsjJYgv3Nh/6gFAiQA8K2+srYjYao6VKAK7rf3Srq4jDjJVEnfmAcnQhjTYyyBBOtqeAijCDGEcc5/X3VVJzU1d0CD9JWwAU0tf4krtztnxr9V8wH6khEs4M47jepOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629420; c=relaxed/simple;
	bh=dWxuEN/62Abb7W5+VDF5zbFXE4np+ZuueLeBVjPjErc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2jPoblMGQ9bEJlkK4JpF18qODS0IoFNEt+9zo/r7JSnq8YoDlOIGmIwZZT86wXcr/4phUyWVtmEkImFmFUdcDON7AkzZ4kNCKL9aqo0s9pqCRQ/bLdrumI/VivWLk/pAm4clSlqRrmJ/NIK4GMOW4Fcu6dBXJf11veRW3GsFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fQtBz2KB4zKHMtx;
	Wed,  4 Mar 2026 21:03:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 482BF40539;
	Wed,  4 Mar 2026 21:03:29 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgCH9OmfLahp_4ueJQ--.35428S2;
	Wed, 04 Mar 2026 21:03:29 +0800 (CST)
Message-ID: <490207fb-55ff-4b2c-b0ed-d16d1f8a0282@huaweicloud.com>
Date: Wed, 4 Mar 2026 21:03:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/5] bpf, x86: Emit ENDBR for indirect jump
 targets
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Xu Kuohai
 <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
 <20260302102726.1126019-5-xukuohai@huaweicloud.com>
 <e50cb1e9f805d55a04cf0396aeb9fa3823a2f37b.camel@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <e50cb1e9f805d55a04cf0396aeb9fa3823a2f37b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCH9OmfLahp_4ueJQ--.35428S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtryktr18Zw4kAF1rKF17KFg_yoWfWwcE9a
	9YkrWDu345Wwn7X34jkrZ7XF9rWr18ZryrJa17KF92gF95Xa9YkF9akrZIyryftF4xGFW5
	ZrnrJF1ay343GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/4/2026 2:23 PM, Eduard Zingerman wrote:
> On Mon, 2026-03-02 at 18:27 +0800, Xu Kuohai wrote:
> 
> [...]
> 
>> @@ -2449,7 +2452,7 @@ st:			if (is_imm8(insn->off))
>>   
>>   			/* call */
>>   		case BPF_JMP | BPF_CALL: {
>> -			u8 *ip = image + addrs[i - 1];
>> +			u8 *ip = image + addrs[i - 1] + (prog - temp);
>                                                          ^^^^^^^^^^^^^
> 			Could you please comment a bit why this addend is needed?
>>

The temp buffer holds the JITed x86 instruction for each BPF instruction, and
prog variable points to the position in temp buffer where the next JITed x86
instruction will be written.

Since there may already be an ENDBR instruction in the temp buffer, which is
written when the current BPF instruction is an indirect jump target, we need to
add addend when computing the actual address of the JITed x86 instruction.

>>   			func = (u8 *) __bpf_call_base + imm32;
>>   			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
> 
> [...]
> 
> 

