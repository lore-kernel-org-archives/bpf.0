Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D53175A6B
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561271; cv=none; b=iK3C8I+JJxyTTYyLs5TFFvsLRPg0dcHTuj8pdjftSJUgbcxPHYWE78hvP+Ruk5M1C5oEp5jpntOWUryqz98qlWEMKUbqFAu3gi0cqT0V6g4AfB4xsh7EKi0Y3GJuXG9yZt/QbePOmYZZDPgf87sgAkeA5zZo8tVr4Dav40k/TVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561271; c=relaxed/simple;
	bh=DVRRpVgyk0j7Kbl+bDZp9dixPOjW8mbNtu6xJxBzTWQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rs+pVdTfMXKaHM05O9CPJV9mijWA6vSJY2ry1vobON4nBv3Hl167i5k/RpYYPXxwP3NUvPeqzEI4VQpjrPpEx4vZfeDct1jWgz7LKgTEOqutGNpSeFUm5oQHPy7r/rfVRP/ftgnIEBSdS9eQb2mw426cnk3Jfix/d6jV2CX9WpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.175.228])
	by mtasvr (Coremail) with SMTP id _____wCXkEejbvNpRuLrAA--.394S3;
	Thu, 30 Apr 2026 23:00:52 +0800 (CST)
Received: from [10.162.175.228] (unknown [10.162.175.228])
	by mail-app2 (Coremail) with SMTP id zC_KCgC3JcuibvNp4OrwAA--.34314S3;
	Thu, 30 Apr 2026 23:00:50 +0800 (CST)
Message-ID: <6fc310e8-f929-4b1a-b298-71f2445e3c6e@zju.edu.cn>
Date: Thu, 30 Apr 2026 23:00:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yazhou Tang <tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 ast@kernel.org, eddyz87@gmail.com, emil@etsalapatis.com, puranjay@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Quentin Monnet <qmo@kernel.org>
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-3-tangyazhou@zju.edu.cn>
 <518d74d6-7750-4950-a76f-3e67e480840e@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <518d74d6-7750-4950-a76f-3e67e480840e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgC3JcuibvNp4OrwAA--.34314S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhERCmnyXw44KQAAsX
X-CM-DELIVERINFO: =?B?+nc7xwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9EXiO7vSMDvI+s4Rm1K0tqVFvrWCSTXQaAB1Ib5M2i5P3ZwqZXT+30e4lsxQ05GAV5rY
	MjyX0i46UxyLObyBP0Gz5jTUJTtUuw9uu6vjZHP5/fBlITm2BKzaQlFSExa79g==
X-Coremail-Antispam: 1Uk129KBj93XoWxtw17GFWDJw1UtrWxZryDCFX_yoW7CF4kpF
	WkJryUJry5CF1rJr1UJr4UAFy5Jr4UJ3WDGr18JFW7Zr47ArnFgF48WF1FgF15Ar48tr18
	Jr4qvrW7urnxJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1rM
	a5UUUUU==

Hi Kuohai,

Thanks for your review and the Acked-by tag.

On 4/30/26 11:29, Xu Kuohai wrote:
> On 4/30/2026 1:19 AM, Yazhou Tang wrote:

[...]

>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 300e4e251931..8947ef74f6a8 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1250,9 +1250,9 @@ static int jit_subprogs(struct bpf_verifier_env 
>> *env)
>>           }
>>           if (!bpf_pseudo_call(insn))
>>               continue;
>> -        insn->off = env->insn_aux_data[i].call_imm;
>> -        subprog = bpf_find_subprog(env, i + insn->off + 1);
>> -        insn->imm = subprog;
>> +        insn->imm = env->insn_aux_data[i].call_imm;
>> +        subprog = bpf_find_subprog(env, i + insn->imm + 1);
>> +        insn->off = subprog;
>>       }
>>       prog->jited = 1;
>> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
>> index e3785f9a697d..df43a0e0023f 100644
>> --- a/tools/bpf/bpftool/cfg.c
>> +++ b/tools/bpf/bpftool/cfg.c
>> @@ -142,7 +142,7 @@ static bool cfg_partition_funcs(struct cfg *cfg, 
>> struct bpf_insn *cur,
>>               continue;
>>           if (cur->src_reg != BPF_PSEUDO_CALL)
>>               continue;
>> -        func = cfg_append_func(cfg, cur + cur->off + 1);
>> +        func = cfg_append_func(cfg, cur + cur->imm + 1);
> 
> Do we need to matain backward compatibility with the old bpftool here?
> I suspect not, but I'm not entirely sure.

I agree. Since bpftool is maintained in-tree, it should be enough to just
keep it in sync with the current kernel tree.

> 
>>           if (!func)
>>               return true;
>>       }
>> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/ 
>> xlated_dumper.c
>> index 5e7cb8b36fef..6ccda6787245 100644
>> --- a/tools/bpf/bpftool/xlated_dumper.c
>> +++ b/tools/bpf/bpftool/xlated_dumper.c
>> @@ -150,13 +150,13 @@ static const char *print_call_pcrel(struct 
>> dump_data *dd,
>>       if (!dd->nr_jited_ksyms)
>>           /* Do not show address for interpreted programs */
>>           snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> -            "%+d", insn->off);
>> +            "%+d", insn->imm);
>>       else if (sym)
>>           snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> -             "%+d#%s", insn->off, sym->name);
>> +             "%+d#%s", insn->imm, sym->name);
>>       else
>>           snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> -             "%+d#0x%lx", insn->off, address);
>> +             "%+d#0x%lx", insn->imm, address);
>>       return dd->scratch_buff;
>>   }
>> @@ -181,8 +181,8 @@ static const char *print_call(void *private_data,
>>       struct kernel_sym *sym;
>>       if (insn->src_reg == BPF_PSEUDO_CALL &&
>> -        (__u32) insn->imm < dd->nr_jited_ksyms && dd->jited_ksyms)
>> -        address = dd->jited_ksyms[insn->imm];
>> +        (__u32) insn->off < dd->nr_jited_ksyms && dd->jited_ksyms)
>> +        address = dd->jited_ksyms[insn->off];
>>       sym = kernel_syms_search(dd, address);
>>       if (insn->src_reg == BPF_PSEUDO_CALL)
>> diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/ 
>> testing/selftests/bpf/disasm_helpers.c
>> index f529f1c8c171..96b1f2ffe438 100644
>> --- a/tools/testing/selftests/bpf/disasm_helpers.c
>> +++ b/tools/testing/selftests/bpf/disasm_helpers.c
>> @@ -4,7 +4,6 @@
>>   #include "disasm.h"
>>   struct print_insn_context {
>> -    char scratch[16];
>>       char *buf;
>>       size_t sz;
>>   };
>> @@ -19,22 +18,6 @@ static void print_insn_cb(void *private_data, const 
>> char *fmt, ...)
>>       va_end(args);
>>   }
>> -static const char *print_call_cb(void *private_data, const struct 
>> bpf_insn *insn)
>> -{
>> -    struct print_insn_context *ctx = private_data;
>> -
>> -    /* For pseudo calls verifier.c:jit_subprogs() hides original
>> -     * imm to insn->off and changes insn->imm to be an index of
>> -     * the subprog instead.
>> -     */
>> -    if (insn->src_reg == BPF_PSEUDO_CALL) {
>> -        snprintf(ctx->scratch, sizeof(ctx->scratch), "%+d", insn->off);
>> -        return ctx->scratch;
>> -    }
>> -
>> -    return NULL;
>> -}
>> -
>>   struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, 
>> size_t buf_sz)
>>   {
>>       struct print_insn_context ctx = {
>> @@ -43,7 +26,6 @@ struct bpf_insn *disasm_insn(struct bpf_insn *insn, 
>> char *buf, size_t buf_sz)
>>       };
>>       struct bpf_insn_cbs cbs = {
>>           .cb_print    = print_insn_cb,
>> -        .cb_call    = print_call_cb,
>>           .private_data    = &ctx,
>>       };
>>       char *tmp, *pfx_end, *sfx_start;
> 
> Aside from the potential bpftool compatibility issue, it looks good to me.
> 
> Acked-by: Xu Kuohai <xukuohai@huawei.com>

