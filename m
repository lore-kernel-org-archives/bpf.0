Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390123EABA
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517257; cv=none; b=PGyP+8FYKTfp3cItvZZS9vOYXS6KrnvwFNvXf8POdcVyBxNo+nDwRkCGS2XD2QMzodsU3dwSYAPyif6TzVEB74nZk9sV+7el0Uw51HFytaDJDsZM+1gUDKtmqytHMmIQsccxxje8QL1zeU5w/v+8V3kRhW43Zu+eGM88BjA8dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517257; c=relaxed/simple;
	bh=wKhaujzVu/dp/SeqbU5zTsUke0Md4zUkPyURYzVwaqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzOl+2uvCDiQ3+m+v848aVO13F4M73Q7+Jp01UuEbRD5RWYTH6S8xD1G9PUdFo1sC2BfbLEIqilQjt9SxW19+4WBvOgL/u5Y6ET6KoTKng0Dp/qRnmKnLtOliJhVaROndibkhxiUWi2U3BPd1hZtkSJqKKh20JhY8wYJdwedTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.236.2.94])
	by mtasvr (Coremail) with SMTP id _____wA3cgjl+8RpYxsGAA--.1637S3;
	Thu, 26 Mar 2026 17:27:02 +0800 (CST)
Received: from [0.0.0.0] (unknown [115.236.2.94])
	by mail-app4 (Coremail) with SMTP id zi_KCgCHazTc+8Rpy50cAA--.11725S3;
	Thu, 26 Mar 2026 17:26:53 +0800 (CST)
Message-ID: <afaa5cb2-57d4-4fc8-849e-34db300f34a3@zju.edu.cn>
Date: Thu, 26 Mar 2026 17:26:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-4-tangyazhou@zju.edu.cn>
 <CANk7y0iuC=4aD+zzJujWrwdref0zA+ZOt4Uqst_bOM+7Kqweug@mail.gmail.com>
 <CANk7y0gKbC22yrsBec_6JmyLSN76eTshcX2_W_zhSYSgXkenxQ@mail.gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <CANk7y0gKbC22yrsBec_6JmyLSN76eTshcX2_W_zhSYSgXkenxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCHazTc+8Rpy50cAA--.11725S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAggCCmnEOosmYAADsb
X-CM-DELIVERINFO: =?B?nktsIAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9LOcIldiP1c5d5Kcb9i58uUFoFZDwRPuX4HuEqP+AQvb/2Ny4Dq2FOYOPaA8OwfRKIPy
	3gM1VK5My3YFYsHDFm6kLtAIFJVFxh2HBK3zmpFUEqIYt8LAyQ1hdHGAIpxIew==
X-Coremail-Antispam: 1Uk129KBj93XoWxGFyUXry5Zw1DWFW3Ar4xuFX_yoW5KF4DpF
	WDGa43KFykGrW7Ar4Iva17Ww4rKFs7J347WryrJry3Cw4q9F1furW8Kr4F9a4DCr1xur40
	qF4qvasagw45JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ
	18PUUUUU=

Hi Puranjay,

Thanks for the review and the tags!

Sorry for missing you on the CC list for the rest of the series—I 
thought git send-email would do it automatically. I will double-check 
the CC list and wait 3-4 days between versions next time.

By the way, I left a question for you in v3 about the insn->off 
truncation warning.
If you have a moment, you can find it here:
https://lore.kernel.org/bpf/20260323122254.98540-4-tangyazhou@zju.edu.cn/

Thanks again for your time and guidance.

Best,
Yazhou

On 3/26/26 17:13, Puranjay Mohan wrote:
> On Thu, Mar 26, 2026 at 9:08 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>>
>> On Thu, Mar 26, 2026 at 9:02 AM Yazhou Tang <tangyazhou@zju.edu.cn> wrote:
>>>
>>> From: Yazhou Tang <tangyazhou518@outlook.com>
>>>
>>> In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
>>> the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
>>> (e.g., call_imm > 32767), this silent truncation causes find_subprog()
>>> to return an incorrect subprog ID, which is then stored in insn->imm.
>>>
>>> Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
>>> fails to resolve the subprogram name, and incorrectly displays a raw
>>> kernel pointer.
>>>
>>> For example, dumping the xlated bytecode of the JIT-loaded selftest
>>> introduced in patch 2/3 (call_imm == 32768, i.e., 0x00008000) shows
>>> that it is truncated to 0x8000 and reinterpreted as -32768 in s16:
>>>
>>> Before this patch (with call_imm > 32767):
>>>     4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
>>>     5: (85) call pc-32768#0xffffffff814aed4e
>>>
>>> After this patch:
>>>     4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
>>>     5: (85) call pc-32768#bpf_prog_5dccd3f669bbe4e4_target_subprog
>>>
>>> This patch fixes the issue by passing the un-truncated 32-bit
>>> env->insn_aux_data[i].call_imm directly to find_subprog().
>>>
>>> Note that the assignment to insn->off is retained. Although it still
>>> truncates for large jumps, it remains correct for the vast majority
>>> of BPF programs where the offset fits within s16 bounds. Keeping it
>>> ensures backward compatibility for existing user-space tools that rely
>>> on insn->off to display the relative offset. A comment is added to
>>> explicitly clarify this truncation behavior.
>>>
>>> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
>>> Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in dump")
>>> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
>>> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
>>> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
>>> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
>>> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
>>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>
>> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
>>
>> Yazhou, you should wait 3-4 days before sending the next version of a
>> patch(set) and add a changelog so it is easy to see what changed
>> between versions. For single patches you can add changelog below the
>> "---" and for multi patch sets, you do it in the cover letter.
>>
>> Thanks
> 
> I realized you do have a changelog in the cover letter, but you only
> cc-ed me in this patch and not the cover letter and other two patches.
> Anyways, I have seen those two patches from the list and they look
> good to me so you can add Reviewed-by: Puranjay Mohan
> <puranjay@kernel.org> to them as well.
> 
> Thanks

