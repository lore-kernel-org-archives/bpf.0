Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60939B96F
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322808; cv=none; b=hrpMQxz4aqFg1/AN5YNeiB+BqjIj7cA4+yN+DRG8hhWVZ6QiyxA3YqoaoHI552eVETncpxKwC3Dl7HfZvG6/OLUK8C7T+v5kxJjOiJ0B9nx4bVm0pZVpwJlp3Y5AcC1w0pVbP57pCNJx3j7N2FcXxDZ4lPBI5PH5k3KUnmqF4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322808; c=relaxed/simple;
	bh=q4MaonmwIjRlJRf+o2DT8bA/i1vVInbGkcBBX5LlBSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJUAXER00Cr9ufi95HJgvzTe+y/ONpnQn3n+NujegMhFDHSn7j9+4sB3ag7EB7HLYFdbzat+MvvCWKfEfbHpOYGihoE4IVosLvewqUocaKJKSS81TBmvq7D8sRLc5HXCI42oXTxid0Fg1UcbXqUCPHjY7BVHQt/rlYwUAOH6osY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [183.157.161.208])
	by mtasvr (Coremail) with SMTP id _____wC3Y6VUBMJpP9RLAA--.10620S3;
	Tue, 24 Mar 2026 11:26:12 +0800 (CST)
Received: from [0.0.0.0] (unknown [183.157.161.208])
	by mail-app2 (Coremail) with SMTP id zC_KCgBH2tBKBMJpA6caAA--.12689S3;
	Tue, 24 Mar 2026 11:26:02 +0800 (CST)
Message-ID: <db2474d6-d61d-49a4-92ae-1b1dc50edc05@zju.edu.cn>
Date: Tue, 24 Mar 2026 11:26:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
 <20260323122254.98540-4-tangyazhou@zju.edu.cn>
 <DHA941F6HVW3.RNGBXB3DVTC6@etsalapatis.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DHA941F6HVW3.RNGBXB3DVTC6@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zC_KCgBH2tBKBMJpA6caAA--.12689S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBg8ACmnBl4sQsAAAsX
X-CM-DELIVERINFO: =?B?NOBgmAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9DbWWsqOl+/U1tRr0n6/5vnIVJOwrBkxeHHin0zPkvIQ4rntyzu6seaOZy5RSnBr0erw
	DKObZXFOYNdCJhmZ4E/LWSfXWsPrHvI9TBnq1GS5oTTQzTDzfVZ3YDyUMgG9Dg==
X-Coremail-Antispam: 1Uk129KBj93XoWxXF1Uur18Zw4ktw1rZF18WFX_yoWrJw4kpF
	WkWFyfKF1DJFW7CFsrZanxuay5Ka97X347Wr15u343C3WUWFn7Gr4UKr1ruFZ0krn7Cr1I
	vr4qva9I9w15JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2
	NtUUUUU==

Hi Emil,

Thanks for your review and the tag.

Since you're looking at this patch, I'd also like to get your thoughts 
on the question I left for Puranjay below the "---" line:

Do you think it's worth adding a verifier warning log when the 
truncation actually occurs in jit_subprogs(), or is the inline code 
comment sufficient?

Thanks,

Yazhou

On 3/23/26 23:02, Emil Tsalapatis wrote:
> On Mon Mar 23, 2026 at 8:22 AM EDT, Yazhou Tang wrote:
>> From: Yazhou Tang <tangyazhou518@outlook.com>
>>
>> In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
>> the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
>> (e.g., offsets > 32767), this silent truncation causes find_subprog()
>> to return an incorrect subprog ID, which is then stored in insn->imm.
>>
>> Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
>> fails to resolve the subprogram name, and incorrectly displays a raw
>> kernel pointer.
>>
>> For example, dumping the xlated bytecode of the JIT-loaded selftest
>> introduced in patch 2/3 shows:
>>
>> Before this patch (with call_imm > 32767):
>>    4: (85) call pc+2#bpf_prog_115951674716e036_padding_subprog
>>    5: (85) call pc+3395#0xffffffff814aed4e
>>
>> After this patch:
>>    4: (85) call pc+2#bpf_prog_115951674716e036_padding_subprog
>>    5: (85) call pc+3395#bpf_prog_5dccd3f669bbe4e4_target_subprog
>>
>> This patch fixes the issue by passing the un-truncated 32-bit
>> env->insn_aux_data[i].call_imm directly to find_subprog().
>>
>> Note that the assignment to insn->off is retained. Although it still
>> truncates for large jumps, it remains correct for the vast majority
>> of BPF programs where the offset fits within s16 bounds. Keeping it
>> ensures backward compatibility for existing user-space tools that rely
>> on insn->off to display the relative offset. A comment is added to
>> explicitly clarify this truncation behavior.
>>
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
>> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
>> Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in dump")
>> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
>> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
>> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
>> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
>> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
>> ---
>> Hi Puranjay,
>>
>> As you mentioned in the last iteration, this still leaves insn->off wrong
>> but is generally fine. To clarify this for future readers, I have added
>> an inline comment explaining the truncation.
>>
>> I also debated whether to add a warning log when the truncation actually occurs.
>> However, since the program will load and run perfectly fine after this fix,
>> I held off on adding it to avoid unnecessary log spam.
>>
>> Do you think a warning log is worth adding here, or is the code comment sufficient?
>>
>>   kernel/bpf/verifier.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 809ac2325dcb..a45a393365b4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -23027,8 +23027,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   		}
>>   		if (!bpf_pseudo_call(insn))
>>   			continue;
>> +		/*
>> +		 * Note: If the original insn->imm is out of s16 bounds,
>> +		 * insn->off here will be a truncated value.
>> +		 */
>>   		insn->off = env->insn_aux_data[i].call_imm;
>> -		subprog = find_subprog(env, i + insn->off + 1);
>> +		subprog = find_subprog(env, i + env->insn_aux_data[i].call_imm + 1);
>>   		insn->imm = subprog;
>>   	}
>>   

