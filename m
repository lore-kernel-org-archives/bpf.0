Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE02931D2
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673415; cv=none; b=UK2t6PPnJAWJbbjrmyWfgatNJGTpq2bVvcH3fUhWv5Wuea7l1/mM65v6Oc7mnEL0/BXoPpvRJUjV5WXaeqDMpL7Pd3T0elA3M6kVZ6KUSDtWyf1/ttxFz5Nsldu6Wyo0kuO6DQCoIT32AXHqg4U/XDRjOxIqLSMG1UVQ/t1wy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673415; c=relaxed/simple;
	bh=KVIuP4sYpZFQuWVPprBjBfU3P9oGQG1hwjfBc++WHRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOm4nsmxPevfpkUY8g6Ig73QW5sCCgTx9Er29FIXfeo88dbjwmQXlrJMss4aAdjzyGZ1IV1wxuTP/nxgUFcIUYvDvRNmCShKXJ+NfOkx+0dbxvToiV9Oj8J/DMnmFFPPMcy0aKqn1/53kA4DyRD3wE716GdcyuvMRNrP8vNGCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hLlzp4HYhzYQtpc
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 10:09:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4CC0F4058C
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 10:10:06 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAXzYT8eH5qFtz9CA--.65528S2;
	Fri, 14 Aug 2026 10:10:06 +0800 (CST)
Message-ID: <a6dde22e-47d1-4f5d-9ab9-284e9beefd56@huaweicloud.com>
Date: Fri, 14 Aug 2026 10:10:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/7] bpf, arm64: Convert struct_ops arena
 arguments in the trampoline
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Puranjay Mohan <puranjay12@gmail.com>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-5-puranjay@kernel.org>
 <2ce67108-4b79-4635-a46e-dbac21ef46cb@huaweicloud.com>
 <m2mrupzv2q.fsf@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <m2mrupzv2q.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXzYT8eH5qFtz9CA--.65528S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKryDGFyrWFWUKw1fXr4UXFb_yoW3trX_Wa
	40krWqga1UXF1kCw15GF18KrWvvas8CF13Jryj9FZrA3s8Aan7GFZ7CryIvF97GrWFgr1f
	XrnrGa4SgrZFqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/14/2026 3:20 AM, Puranjay Mohan wrote:

[...]

>>> +static void emit_arena_arg_conv(struct jit_ctx *ctx, u8 dst, u8 src, bool nullable, u8 base_lo)
>>> +{
>>> +	if (nullable) {
>>> +		if (dst != src)
>>> +			emit(A64_MOV(1, dst, src), ctx);
>>> +		/* skip the subtraction so that NULL stays NULL */
>>> +		emit(A64_CBZ(1, dst, 2), ctx);
>>> +		src = dst;
>>> +	}
>>> +	emit(A64_SUB(0, dst, src, base_lo), ctx);
>> Maybe I'm missing something, do we need to validate whether the
>> address in the src register is really inside the current bpf
>> prog's arena?
> The JIT can assume that it is a kernel address into the arena as it
> comes from struct ops.

Thanks for the clarification, but I'm still confused. What makes the
assumption hold? How does struct_ops ensure the address passed is
inside the arena used by the current prog?

[...]

