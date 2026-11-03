Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710736;
	b=VRQFVw3cAlBirMeQkeHYo3LMYxTUJ04uhuEHdbfL2jljn+VObZOB8Ds8LDhGeLMRcysB
	 ovty6j1obQiG7EcPvxWQwz09c2CPIbtwL6JqCxG55+jFRnhN2TKNN4TEWZ284+dEKwUql
	 r4m31eJioDvrVwzjoGHRHBza8J++ICkmg5IiRiH7HJPe+ExWL0vmRHvjd3OKKm+zEtSDT
	 kjut5CSfjPrEUnfVAcTSh1G3jy6RH4ONDxCMrDtKxgFs1vUUPtaRJd9E3xPev7/urnktJ
	 +qQ+rLdv3umrv0x185o/rlCS9WLKXlmbDlbKPN17FFIAhB5banxu45W20ffroByHEcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710736;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=vKGX0/i3wC0V58dab4rJAfdJ/0V3Q5QkyS4WjlOpXCU=;
	b=NbDSSxaqRS6yXeMwJux4k2me169d1W5KQOjLkDxz55gV6FNi4xSNnIBZFKEaxKll4F4A
	 qUqcPh9XHGS3j9bPC+d0/bZ83F3+VOKPu9l8rE//JQ+jwyKY8S3lCsLrvSHVRsaIk1ctj
	 yheXzS7ncWHMHB3SUbVbXJSAY8Pvvj41rcFnz759Osvv+9MAa3eYmg636q9y0yMxPmNT7
	 8xjjZYkg9zuU5NjdGqMzBF5hPB7gwCMg424tYJwepvGRg742cyH5jZFfE/yr0PIdPFpNy
	 DvQC/gCemmuBm3VYce5mYsr2yqPrRtU5f11RdABzAiU2X53HVuqjTsbaFYQzMmb7Dlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A789606A327;
	Tue,  3 Nov 2026 12:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A789606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jJpXd4bjhz1yFm;
	Tue,  3 Nov 2026 20:58:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0867E4056E;
	Tue,  3 Nov 2026 20:58:50 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBHfu2I2ulqezG5Cw--.9002S2;
	Tue, 03 Nov 2026 20:58:49 +0800 (CST)
Message-ID: <25a29a41-b14b-4a9c-9876-da1537be176b@huaweicloud.com>
Date: Tue, 3 Nov 2026 20:58:48 +0800
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
Subject: Re: [PATCH bpf-next 3/5] bpf: Finalize the verifier log after the
 runtime is selected
Content-Language: en-US
To: Qiliang Yuan <odys.yuan@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Luis Gerhorst
 <luis.gerhorst@fau.de>, Henriette Herzog <henriette.herzog@rub.de>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
 <20261102-bpf-blind-nops-fixes-v1-3-844300e42cdb@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20261102-bpf-blind-nops-fixes-v1-3-844300e42cdb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHfu2I2ulqezG5Cw--.9002S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4UAr1fCFyxJw15WFyUWrg_yoW8uw1rpa
	yIganrtryvqw42kw12vF40yay5X3WFq3W3Ga9Yy34xur4IqrnIgrWUKa1agFy5tF9Ykw10
	vF1293s7K34UurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 11/2/2026 8:37 PM, Qiliang Yuan wrote:
> bpf_check() finalizes the log, which reports its size in log_true_size,
> and selects the runtime of the prog after that. For a prog of one
> function, selecting the runtime blinds the constants.
> 
> Blinding can log "insn %d cannot be patched due to 16-bit range". The
> message lands in the buffer, but log_true_size doesn't count it: with a
> stats-only log, log_true_size is 219 while the log takes 264 bytes. A
> caller that sizes the buffer from log_true_size loses the message.
> 
> Finalize the log after __bpf_prog_select_runtime().
> 
> Fixes: d9ef13f72711 ("bpf: Pass bpf_verifier_env to JIT")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>   kernel/bpf/verifier.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 935b163f81e4b..974dc571eff05 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24112,11 +24112,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>   	print_verification_stats(env);
>   	env->prog->aux->verified_insns = env->insn_processed;
>   
> -	/* preserve original error even if log finalization is successful */
> -	err = bpf_log_attr_finalize(attr_log, &env->log);
> -	if (err)
> -		ret = err;
> -
>   	if (ret)
>   		goto err_release_maps;
>   
> @@ -24167,6 +24162,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>   	env->prog = __bpf_prog_select_runtime(env, env->prog, &ret);
>   
>   err_release_maps:
> +	/*
> +	 * Finalize the log after the runtime is selected, which blinds the
> +	 * constants of a prog of one function and can log an error. Preserve
> +	 * the original error even if log finalization is successful.
> +	 */
> +	err = bpf_log_attr_finalize(attr_log, &env->log);
> +	if (err)
> +		ret = err;
>   	if (ret)
>   		release_insn_arrays(env);
>   	if (!env->prog->aux->used_maps)
>
Acked-by: Xu Kuohai <xukuohai@huawei.com>

