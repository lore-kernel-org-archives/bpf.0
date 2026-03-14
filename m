Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814136165B
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773495334; cv=none; b=uKBY8S4EyeXOjq+Sux/bozHLl2Kvo0j3XeZIhUTEkSWjEAFUMICjCVXJolR+yQAjxIbk8bbV3H7UrH6//eYQ3bOPAsGpR2oH2rcZvTe+F8eqjcaouMRrxLiGBQexSs2/JFVJVMcrGapGHaY7J9cD4TZ7o0Z1XlGHiQiAwu9W2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773495334; c=relaxed/simple;
	bh=AbzF/s5Ma0nc+4MMYzU3BmkmqQ4Q8NaSHT8hlrS8KXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTnNvMzA8wJAMyV+YIzhJe+w0TICEb2O/01JbR8ACuTZWlUO56rIDQ0n82sVIf4tIoz80o6EHeaA3aTRUTqKP41yJchcTe7yviasQHQSXrq6ZfgbU5VR7PsFDvZf9uMZFM7FIst+3elDlUsRX3Pj6wm0Vyx4gRxqfVx+oSwVOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ATcLf6pU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ATcLf6pU"
Message-ID: <9ddae3d2-173d-460d-b283-12c983164a69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773495330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCQypaxGFFgaS/osfKeG64nMyEQeNeo+f0gUaL2VzCQ=;
	b=ATcLf6pUL5PolIpynwkOemQNh/JOzJgYMTtGVocrmmsdcKE9lPzi9ndB0PzBgNNSSM0ICr
	wjFQQqPQVnbd6X4T9U0cuetJfLL/c4CIy5VLk81YnMRZS549AA5wpqCADTy63tsjdpB759
	OpD0gUF9wxLUxYQXXBGzc5UvPvV0Rpc=
Date: Sat, 14 Mar 2026 21:35:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 4/5] bpf, x86: Emit ENDBR for indirect jump
 targets
To: Xu Kuohai <xukuohai@huaweicloud.com>
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <f384599a-75b8-4387-80db-b20429a0bafd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/3/14 14:48, Xu Kuohai wrote:
> On 3/13/2026 6:15 PM, Leon Hwang wrote:
>>> +#ifdef CONFIG_X86_KERNEL_IBT
>>> +        if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
>>> +            EMIT_ENDBR();
>>> +#endif
>> NIT: is this CONFIG check necessary?
>>
>> EMIT_ENDBR already checks it.
>>
>> #ifdef CONFIG_X86_KERNEL_IBT
>> #define EMIT_ENDBR()        EMIT(gen_endbr(), 4)
>> #define EMIT_ENDBR_POISON()    EMIT(gen_endbr_poison(), 4)
>> #else
>> #define EMIT_ENDBR()
>> #define EMIT_ENDBR_POISON()
>> #endif
> 
> Well, the code was originally written exactly without the #ifdef, but it
> triggered
> -Wempty-body warning: https://lore.kernel.org/bpf/202603051414.AAMjmOHv-
> lkp@intel.com/.
> 

Let's update the macros instead, which can avoid the build warning and
get rid of the CONFIG check as well.

#define EMIT_ENDBR() do { } while (0)
#define EMIT_ENDBR_POISON() do { } while (0)

The way of "do { } while (0)" is commonly used in kernel.

Thanks,
Leon

