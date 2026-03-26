Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264CA2DB789
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533298; cv=none; b=tutuKGi7UQEenK2FSpzAItQF9bX21Kvn5HtZjx8JmXZFF1cnj78Qt2abQwOEod7B0ov7Q8c+O4vKeD0QAY8zcPO8VdlWvoIhzk1L+wlOQeQUfz+jHsqoQD2Kv6rcRTqkV/+v49jpyhIgvJCw04XebxpWRYykW0pbf/E9p35I0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533298; c=relaxed/simple;
	bh=A6zApQBk2RcPoI4mK32ZpcSPVLgShH/Op6DIOFkWZd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4TBQhBfWfJlfL0Z0hN2N64gn1PhwZl46Ir/kWmXTsxZSEW2UXkoAXiKq/so4bIw0BEGTCuNroHxlIdnLn1pPqBxUuMqBjESZ0ANCCcTpnCUJ8dxHv+OKVBETR6gO7qUMDKUvNdXh+VVAAWyRksoTCly6lWA1HsdzWQ7u8/l4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fhQJ14fQlzYQts8
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 21:54:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C29C340575
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 21:54:53 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgBXp9etOsVprWI0CQ--.12861S2;
	Thu, 26 Mar 2026 21:54:53 +0800 (CST)
Message-ID: <e6b07a39-c2d6-4adc-bc6e-0d31472f9550@huaweicloud.com>
Date: Thu, 26 Mar 2026 21:54:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
Content-Language: en-US
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Puranjay Mohan <puranjay@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-4-tangyazhou@zju.edu.cn>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260326090133.221957-4-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXp9etOsVprWI0CQ--.12861S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWrKry5GF4kCw1DXry7Jrb_yoW5Ww48pF
	4vgFWfGF95JrW29w47AF4DCw45Ga1kZ347WryrZ34fJw47WFyDCr4UKr4FqFZIkr1xGr4I
	vFsFvasI9w4UGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/26/2026 5:01 PM, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
> the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
> (e.g., call_imm > 32767), this silent truncation causes find_subprog()
> to return an incorrect subprog ID, which is then stored in insn->imm.
> 
> Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
> fails to resolve the subprogram name, and incorrectly displays a raw
> kernel pointer.
> 
> For example, dumping the xlated bytecode of the JIT-loaded selftest
> introduced in patch 2/3 (call_imm == 32768, i.e., 0x00008000) shows
> that it is truncated to 0x8000 and reinterpreted as -32768 in s16:
> 
> Before this patch (with call_imm > 32767):
>     4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
>     5: (85) call pc-32768#0xffffffff814aed4e
> 
> After this patch:
>     4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
>     5: (85) call pc-32768#bpf_prog_5dccd3f669bbe4e4_target_subprog
> 
> This patch fixes the issue by passing the un-truncated 32-bit
> env->insn_aux_data[i].call_imm directly to find_subprog().
> 
> Note that the assignment to insn->off is retained. Although it still
> truncates for large jumps, it remains correct for the vast majority
> of BPF programs where the offset fits within s16 bounds. Keeping it
> ensures backward compatibility for existing user-space tools that rely
> on insn->off to display the relative offset. A comment is added to
> explicitly clarify this truncation behavior.
> 
> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in dump")
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>   kernel/bpf/verifier.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 702579f56f7d..e87fedb09e1b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23017,8 +23017,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>   		}
>   		if (!bpf_pseudo_call(insn))
>   			continue;
> +		/*
> +		 * Note: If the original insn->imm is out of s16 bounds,
> +		 * insn->off here will be a truncated value.
> +		 */
>   		insn->off = env->insn_aux_data[i].call_imm;

seems we can just set insn->off to 0, right?

> -		subprog = find_subprog(env, i + insn->off + 1);
> +		subprog = find_subprog(env, i + env->insn_aux_data[i].call_imm + 1);
>   		insn->imm = subprog;
>   	}
>   

