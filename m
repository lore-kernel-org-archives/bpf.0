Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.101.248.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653965;
	b=TVbj2rg9V433sYgNCsc0CcUqSWnYVacVbC5w8RD95DifhUJFSxZiQMxckKRDkKG6OXMI
	 AawTv8q6B91rgE88b3oEdswru2eWEslGnOnw94+lS0fMR1TRl2QzVVnFMJVTIfb0AR4hO
	 aLMNHluF0sHLfCMV9/cWpJcgmoCaPpkgU354WWMeDdUYqdnYDA7A5YZTTvvY2r0fN4Vxp
	 gCara9V0Ahbs7w4xQWV1VIU89KLNSpkrAGkMNl/UbRFv9grZu/CzwyhLMyr7jLIOBo8Rx
	 EOFDuRB2IKQ7dou1xUnghxUFMLQEo6RZQi2agd0MQq9W7Q30RN+Sn6yYi0G7Uigpwyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653965;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=hw+LeerHhGLkLKdlR9vRwcNoEaoRpAz0XKULpmdJ9jU=;
	b=zBkV601ZnBMNeGdC44khK/uk519gVF68EorJc4LbuUGDMJx4dZWW9H43PiexLoHOlllz
	 9d+lWpNsNyVjKxtMapiCBKyDrOPmeaez2ML0D6bvmnqFCB1GeIKZchFBIv+JcUQtOsLIq
	 SqjChZmpn0IX9yCZ8wzz1J0PZdjAEPAp+hSEVCSPagrLSTcH33kSBFrrFAWdAk3KS11ju
	 oKsVEifecm9iL1k3lQwQjna6dfwhDWwCb0jqSjj4d9KXY85ZRYyyimCIpQ/0GLpQBvhKW
	 wqNiPHzrosUgGfvPwv2VpDNUkewhl4fr2wpYr7dzfk2OsU/GIrLx7WKteuucmQxWdEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=46.101.248.176
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0074606A31B;
	Thu, 22 Oct 2026 07:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0074606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.192.73.73])
	by mtasvr (Coremail) with SMTP id _____wCXcX5hutlqP3CyAQ--.103S3;
	Thu, 22 Oct 2026 15:25:22 +0800 (CST)
Received: from [10.192.73.73] (unknown [10.192.73.73])
	by mail-app1 (Coremail) with UTF8SMTPSA id yy_KCgDX54RXutlqpMKHAA--.4549S3;
	Thu, 22 Oct 2026 15:25:12 +0800 (CST)
Message-ID: <3ce962ff-4f86-4505-a297-7c91284b2d7b@zju.edu.cn>
Date: Thu, 22 Oct 2026 15:25:11 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/8] bpf: Add UHMUL and SHMUL instructions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, tangyazhou@zju.edu.cn,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, David Vernet
 <void@manifault.com>, bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet <qmo@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Hari Bathini <hbathini@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Naveen N Rao <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Tianci Cao <ziye@zju.edu.cn>,
 Shenghao Yuan <shenghaoyuan0928@163.com>
References: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
 <20261021-bpf-hmul-v2-1-88e260099f7d@outlook.com>
 <DMAOMH0CLDLX.127F7BRYUOQEG@gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DMAOMH0CLDLX.127F7BRYUOQEG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:yy_KCgDX54RXutlqpMKHAA--.4549S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhILCmrXxB1u-AABsm
X-CM-DELIVERINFO: =?B?ePmKzQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Ks5WUqw3Z4rlIZd02nqEtelbHSyIVI30G0gETxgY5zXP40f6NR2sdDBVPYwWjuyAbfe
	dWi4wsWuWoAc8JhokIfXmYk5DjTqY3XvCxFmIAxXl7bSZvphwXOAs49D3R/y3A==
X-Coremail-Antispam: 1Uk129KBj93XoWxur1rAw4xury8tr1fGw4kuFX_yoWrZFyfpF
	WvqFyxCF4vgrWkZr97XwnrCF15JF4xG34UG34UWrWUA3ZFqFn5WrykKayaqrZ5Gr1rKa12
	yr4qvr9a9398GFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UA
	kuxUUUUU=



On 10/22/26 01:11, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 10:40 PM tangyazhou@zju.edu.cn <tangyazhou@zju.edu.cn> wrote:
> 
>> +static inline bool bpf_insn_is_hmul(const struct bpf_insn *insn)
>> +{
>> +	return BPF_CLASS(insn->code) == BPF_ALU64 &&
>> +	       BPF_OP(insn->code) == BPF_MUL &&
>> +	       bpf_is_hmul_variant(insn->off);
>> +}
> 
> Patch 5 adds this check to 13 JITs and nfp to opt them out.
> Lets make JITs opt in instead, like bpf_jit_supports_callx().
> The verifier checks it once. x86, arm64 and riscv patches add
> bpf_jit_supports_hmul() that returns true. bpf_prog_is_offloaded()
> covers nfp.
> When JIT is on and it doesn't support them the prog is rejected with
> a message in the log instead of silent fallback to the interpreter.
> Then patch 5 goes away and only arm64 and riscv acks are needed.

Thanks, Alexei. This is a cleaner approach. I'll add
bpf_jit_supports_hmul() as you suggested and remove
the opt-out checks from unsupported JITs in v3.

Apologies for the noise to the other JIT maintainers.

> 
> Like:
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index e0218e6..6ee8d1a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -152,6 +152,13 @@ struct ctl_table_header;
>   #define BPF_ALU32_IMM(OP, DST, IMM)				\
>   	BPF_ALU32_IMM_OFF(OP, DST, IMM, 0)
> 
> +static inline bool bpf_insn_is_hmul(const struct bpf_insn *insn)
> +{
> +	return BPF_CLASS(insn->code) == BPF_ALU64 &&
> +	       BPF_OP(insn->code) == BPF_MUL &&
> +	       (insn->off == BPF_UHMUL || insn->off == BPF_SHMUL);
> +}
> +
>   /* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
> 
>   #define BPF_ENDIAN(TYPE, DST, LEN)				\
> @@ -1281,6 +1288,7 @@ bool bpf_jit_supports_kfunc_call(void);
>   bool bpf_jit_supports_callx(void);
>   bool bpf_jit_supports_kfunc_ret_reg_pair(void);
>   bool bpf_jit_supports_unwind(void);
> +bool bpf_jit_supports_hmul(void);
>   bool bpf_jit_supports_stack_args(void);
>   bool bpf_jit_supports_arena_args(void);
>   bool bpf_jit_supports_far_kfunc_call(void);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f29b0aa..90c30e5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -34,6 +34,12 @@
>   #define BPF_FROM_LE	BPF_TO_LE
>   #define BPF_FROM_BE	BPF_TO_BE
> 
> +/* BPF_MUL off values for high-half multiplication; BPF_ALU64 only. */
> +enum bpf_mul_variant {
> +	BPF_UHMUL = 1,
> +	BPF_SHMUL = 2,
> +};
> +
>   /* jmp encodings */
>   #define BPF_JNE		0x50	/* jump != */
>   #define BPF_JLT		0xa0	/* LT is unsigned, '<' */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3030beb..e17704a 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3405,6 +3405,12 @@ bool __weak bpf_jit_supports_unwind(void)
>   	return false;
>   }
> 
> +/* uhmul and shmul */
> +bool __weak bpf_jit_supports_hmul(void)
> +{
> +	return false;
> +}
> +
>   /*
>    * How this arch places a by-value kfunc argument, or NULL for one that has
>    * not opted in and so only takes an argument of a single eightbyte, which
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d20..9a3c97d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21194,6 +21194,17 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
>   	return -EPROTO;
>   }
> 
> +/* The interpreter supports uhmul and shmul. JITs opt in. */
> +static int check_hmul_jit(struct bpf_verifier_env *env)
> +{
> +	if (bpf_prog_is_offloaded(env->prog->aux) ||
> +	    (env->prog->jit_requested && !bpf_jit_supports_hmul())) {
> +		verbose(env, "JIT doesn't support uhmul and shmul\n");
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
>   static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   {
>   	u8 class = BPF_CLASS(insn->code);
> @@ -21249,6 +21260,13 @@ static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   	case BPF_MUL:
>   	case BPF_DIV:
>   	case BPF_MOD:
> +		if (bpf_insn_is_hmul(insn)) {
> +			if (BPF_SRC(insn->code) == BPF_X ? insn->imm : insn->src_reg) {
> +				verbose(env, "BPF_ALU uses reserved fields\n");
> +				return -EINVAL;
> +			}
> +			return check_hmul_jit(env);
> +		}
>   		if (BPF_SRC(insn->code) == BPF_X) {
>   			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
>   			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
> 
> pw-bot: cr

