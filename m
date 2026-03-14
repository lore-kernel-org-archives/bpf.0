Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A718EB0;
	Sat, 14 Mar 2026 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773470919; cv=none; b=rNd7pjhifz3Z9jMZ2q88Ai1jCwbjsnXM2nXf2NwO2GqanUCqZ2+kuEWIdYlZJ8sPIU6lC2K0Z5AT0T6/rxwjhjBf8LdNq8nLEzwECcWRFQV2u1khYEWEMN1BhggmIJsy+PpzS8ox9WDao/+uQJeUa+DiFORmXyDdqHtP0wAMDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773470919; c=relaxed/simple;
	bh=GOJsqjJz8DHUihozGv9lB3YYbiUOZcWJow/w2TqbaW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUfYwCpm1GgUcNiA8zYfeUjEGtD5VBrRhBzKBOEestC+ZKfDPrhonAgFrcMxIK4P/yFSzyuWmpx0mTHGL+zV5AC3+bOOcAr+Nexf8XTcJ6lXCxM1FQC4iQlbT9HXUVvbiBPKmoxxWVm9By1JwBn/YKNOs0bXWSUfkEqteYYhgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fXsPS1rVzzKHMdW;
	Sat, 14 Mar 2026 14:48:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5CC8940575;
	Sat, 14 Mar 2026 14:48:33 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgA3EEu9BLVp9wZqAw--.757S2;
	Sat, 14 Mar 2026 14:48:30 +0800 (CST)
Message-ID: <f384599a-75b8-4387-80db-b20429a0bafd@huaweicloud.com>
Date: Sat, 14 Mar 2026 14:48:29 +0800
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
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260313101505.104686-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3EEu9BLVp9wZqAw--.757S2
X-Coremail-Antispam: 1UD129KBjvdXoWrAr4kuryrAw18uFy7XF1fJFb_yoWxWFg_ZF
	sY9r97urWkua4qgrWDA348uwn2q3WDGF98Gr15Kw17K340yr4Sqr1rCaykZws5Ca4vqrs3
	A3W8Xa90yas09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxCz
	tUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/13/2026 6:15 PM, Leon Hwang wrote:
>> +#ifdef CONFIG_X86_KERNEL_IBT
>> +		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
>> +			EMIT_ENDBR();
>> +#endif
> NIT: is this CONFIG check necessary?
> 
> EMIT_ENDBR already checks it.
> 
> #ifdef CONFIG_X86_KERNEL_IBT
> #define EMIT_ENDBR()		EMIT(gen_endbr(), 4)
> #define EMIT_ENDBR_POISON()	EMIT(gen_endbr_poison(), 4)
> #else
> #define EMIT_ENDBR()
> #define EMIT_ENDBR_POISON()
> #endif

Well, the code was originally written exactly without the #ifdef, but it triggered
-Wempty-body warning: https://lore.kernel.org/bpf/202603051414.AAMjmOHv-lkp@intel.com/.

