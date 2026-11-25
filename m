Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613199;
	b=sMI5z1mobACOJBNUXNyjDXFsGf+AzT3nb6q4Z1i0r/oWBBh98qbxGpH4ofRriQJvpz/F
	 vdJzT2x1ufoi0UTzwu7KF4paldN+lDZMl2KGZAYg5/MH6//JQnC/7khbMjJ674L1dvdLy
	 Ncw323l0LH3n4e5S/OPw4JwHRj705MoLCqtPYk4ZW92OHE3NESHfSgSwN4pvCUx0SPnEv
	 XnT5JOYBGQfnRL4rM447925cJtbIFGHfAvzRf3qyBD3CCMn2Y5foejaQTp1aldFNBew9i
	 kgi3VcIoHzDxF3KfTiwAkEp8yc87RoGSHShO58mX31tv5X6MinBLRE5HUW/GNEzf9wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PRdNy+zmBulrQynRRiYp/5uLV3PL5Bl3O/SIKuMhv2s=;
	b=jsJhW4ITJp6lJnzB1tclMrWHerhTgBw6PyJpDs1/Lm9QiJ8vx1wz7LqcDjp3S21AnGdT
	 smAoWs8ejBySE0dXvLpAi+lkBtBw2o3JonNWbPPvmTJ23RzsgrVk3LnzCRbbMd+Ci174h
	 WyIk8zdbHMOhvlD/+kZa4zSlkLMqA3Wbo4rV8VhgcCnblSNfJb2aiGn617UU73yLUyz5D
	 Fk8WYKb8OyvmuSH0zKr+wLYyCbPROf/Fq9xUQsrzqzvHzol6ni0AcXQb+Mqqc3qdMJSip
	 vTLwU5v5+VjuXJcUTBCTAxVVQcbHj/ETRoFLJyTx+pkZmEuvmQ8bYVP4KKkeO4zUa9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQCao5y+;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09B606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D09B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQCao5y+
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-497614c95f0so3285663f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795613197; x=1796217997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRdNy+zmBulrQynRRiYp/5uLV3PL5Bl3O/SIKuMhv2s=;
        b=TQCao5y+5pOkC4Fz9cqTwiEtDEsBCllAX2AJxayt82OXjqNilyFJZP+M4JXRzbTV7w
         FdBo32R7xZHFgXAeFpcljRsrpT6vXev2WOks6nlPb+HuOkqiQiX+VMPP0XbcDPavKUZn
         71llLYq0z6Pn2nj2037yhgVZ7J7p7c4o42YyfKkhnU3Is2JevBkWWaIfZxdioWAGUkwU
         /9/fML+IwAJQdU/8H9M2lIi+dr+Biqv7i5TwBKLsVdOVF61jucC/Av96SN2wJUdt2HFD
         M/wlYBwJyZwtSvluWD8mX4PRKdGkuIs7rx66f8ikZCu1NYC6al8o0sEOGfpmY1LyN6Ff
         pfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795613197; x=1796217997;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRdNy+zmBulrQynRRiYp/5uLV3PL5Bl3O/SIKuMhv2s=;
        b=WsQYzron/HKD2O6KNrD9KslmMBcoxXW5up7B/LgIW235bqGTBU46+7+n9Te81dc3DA
         mOk3D7OJT/rD9zo/UT14iEunsX95wKtUVfOVLXpBxmjwJhMTv4Jh9jSsse4S/l+1Vrt1
         f01yrw9HRKtnuZDOSRipxJPrRHfFxVLdwimX+1+jYmDK6HSGu2aB85b90wI2NQIz/Sbc
         +cq6h1g3tbSq16XilnaBIegZsgScNvB64v6Pi6vAE/4thGkFiCeThsPv82naSc6jmlhV
         aew7H/dmgjZUIGTGduhCmuWwp4UNP/iF9AONR3/u0DA9+/4Dw37J929mOlU3ZJxeWK++
         BAbQ==
X-Forwarded-Encrypted: i=1; AL+hErFhj/3EsGfJJ2ttbZFcOijz14cfDjLnzK7G7gWCDoQ6SHUyXZll+gA1DQbiVjz0iQJ5C6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vPg+12/u49tpRTz6fE/vIJao7Zml/V6qZaXAntMt+NPEzN+tq
	iS9aQsZF7Dk3mA/cITmPPod0THoFAxZJzTgvxeTAZIwSy2A+hwL3eDoA
X-Gm-Gg: AZFdTZfDtp45UydI7A79uCkXi/zkj1cfBB+KXBWgFQyPUg5Qfbl42r7VMLUHEtiLQsG
	arVLgaXP2MfP2/3n9r77ee326lLqti7BpdwnGZ9XId03SLi9cYIaGeJQ1RpG7CDDjSIu7gFaKgO
	NzA6uLt7jVc0yHsYYAraqmdj0kxXKb7PXEjglZQd5wePdPQsz+mW+ECSXeSxHvUNnaWlO/N6pHM
	pgm7GJrZCpIdWEY5iyyZQRweKVwgxz4vwg22PqG5jerGQi0hCDKAIUKcokrnjNb5CBR0FZ1G/CE
	484GrcYY3grb1/g+Purhg4OySX69l8HcVUpEJ5NAsp+mQcP9AJXOlXZbjam0Q/6Co3eAftwn6YT
	AX1JZqj1MP/8MWZGHVk+ADXAtB0RE6NTT+C3oL5VpEGdU7s/CBhF/av17FqoeSnCLeYxqtc/SEy
	k8oLMrU3ryPCDFl/AiXWUfNNjMFRf2ml+ofKoKoacRGT798zI4dXCc+B25zAF1xCMnefuw32ZHr
	vmgxG6VULd3jeF3AlSJx3XEfLL9ZyTqdMgm0zfg+YeQ/A3+VOmLoFnvS6qGze5XQX1FggOkZcIh
	r7VWQj0OPvxabDJWeNqGmjVDDoJ0n+v8kwIu4g==
X-Received: by 2002:a05:600c:b8a:b0:4bb:7007:4a5a with SMTP id 5b1f17b1804b1-4bb88817772mr372590635e9.23.1795613196970;
        Wed, 25 Nov 2026 05:26:36 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm32641756f8f.18.2026.11.25.05.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:26:36 -0800 (PST)
Date: Wed, 25 Nov 2026 13:38:15 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 3/7] bpf: Allow only NULL or ERR_PTR() from
 fmod_ret on pointer functions
Message-ID: <awbkx6SJaw2Q-_dQ@mail.gmail.com>
References: <20261125102810.699464-1-a.s.protopopov@gmail.com>
 <20261125102810.699464-4-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125102810.699464-4-a.s.protopopov@gmail.com>

On 26/11/25 10:28AM, Anton Protopopov wrote:
> The caller of such a function dereferences what an fmod_ret program
> returns. Functions on the error injection list like xe_device_create()
> return a pointer. Let the program return only NULL or an error pointer.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  kernel/bpf/verifier.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 18c7b9a6f456..d2475edeecd9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19710,6 +19710,8 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> +	const struct bpf_prog_aux *aux = env->prog->aux;
> +	const struct btf_type *t;
>  
>  	/* Default return value range. */
>  	*range = retval_range(0, 1);
> @@ -19762,8 +19764,19 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
>  			*range = retval_range(0, 0);
>  			break;
>  		case BPF_TRACE_RAW_TP:
> -		case BPF_MODIFY_RETURN:
>  			return false;
> +		case BPF_MODIFY_RETURN:
> +			/* An extension replaces a global function of the program */
> +			if (!aux->attach_btf)
> +				return false;

This ^ check will also go away after Alexei's series
https://lore.kernel.org/bpf/20261125032938.670542-1-alexei.starovoitov@gmail.com/
lands.

> +			/* Allow only NULL or an error pointer for functions returning pointers */
> +			t = btf_type_skip_modifiers(aux->attach_btf,
> +						    aux->attach_func_proto->type, NULL);
> +			if (!btf_type_is_ptr(t))
> +				return false;
> +			*range = retval_range(-MAX_ERRNO, 0);
> +			break;
>  		case BPF_TRACE_ITER:
>  		default:
>  			break;
> -- 
> 2.43.0
> 
