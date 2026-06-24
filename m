Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CF3C660C
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311423; cv=none; b=T9o3lSW1ZuDyaSjmI/jWvsrSG84mYL8DY2XjXGs9x22xFS2Ft1ZBMnhr+aU1dolSaqSeCfF44GTe6daSmSNcXZ4UjoH83UMj4dAsWYHJXVUXn9/J0oQqH6Ane5+MAchMfn4QIro1GM9qMxzT8BfOxbLgSv4q5AqbNM4q2l9LtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311423; c=relaxed/simple;
	bh=KoWe6UXQcGkc7eC1e9eX8LnRAnByM41+YqqVWINHa4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKZFDT/sLITTCwefbrcRE436iqH+LtctxiFF+sa1KUoxKKTaMXWYQSzVIUQsCbS2DPDUwtKzQCw/nswOCOUVSrfgmpqYFrc0iyg5r1nWxcH1yyxVCX/l7lyiBJwELNCCcopFuJdUsLWipzzLLMBNgTbkutJ5JD3tkm3tcMyrqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z73v+dbV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z73v+dbV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso8255295e9.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311421; x=1782916221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjZV9Qb2AkMoZfJai0fOLUEBrkdApMQQXM97idv5pdw=;
        b=Z73v+dbVyeSDJO54YbXrOS3LWFslCZbKbgrYxDKqRUBNC5MFYBOd2aRrxyy3wRBdeR
         vbCOw28ANZWUWWoMt+VOwHqqxwZNjRshmJQgtwYtYDXeHG3glZ//Zqr38F5H3EpCYUgb
         tyvezYeo2UQBFdM7UYVSJn756ovVGaVUMX/VKqs+FKZeZxvGpYVlviBH6r6Wd7AUJmxn
         6HvOLNncu9uCy/y7rm0vbYy+QKzkR2w/XagdV0zKYJioiIT7aaJfuSTdq2pTB2uV41SY
         FA9DhR4+j47psyUMSHTEJKKrSmwP1xa5fm5q87rKYosoQRsyUh7gAp/Tlhm8Uy6ekgFx
         QmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311421; x=1782916221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjZV9Qb2AkMoZfJai0fOLUEBrkdApMQQXM97idv5pdw=;
        b=EWkbZmK4mJdemSYyR7b+fMHLTn74dHtLxY527VlvPpqGr32x4UhQJ2Hr7h+tK8dhyE
         yeNQh7RQRsqieETzllimMFvSS/cfjOWJJkU9wv9Fs9t0mjHkZrXLzCxXSYrmUARzw3e+
         sihfxOxszHL3rsI40Hr1X94A4KxEv9u5AgmViRGw5oVAwiCVHLOZHPDlkbUMJ66EVbDg
         rLs+//YPPYFZBPqbBq9jpVfUJp/2EyDjmdDTbg0bXaj1ljM6zb/aYz0oW/cNyhLlO7WS
         7LrJmYRSbUwqn/HZSdLzrSxgM5hGsWoSRlzBq31rzxNdPeDridJwHa8nArXvtqyMLdqQ
         Efpg==
X-Forwarded-Encrypted: i=1; AFNElJ8YxYgfRMc11XzXpApJaxzni4JV5MAY8rHsA95GrGvMANvCK/2qH0dhF3i2ORDnjWNh2XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoM+dZ13hWzBlyIDOcwh9KdtpniN/B8GOcvQcFjsv8y4Q94EcW
	idrmPkMDyDlItfxqzMNTLYPGcnV+Zk9sCNiUmy//SdstkBMuDCfm73kY
X-Gm-Gg: AfdE7cmxH0+gupOW/0Vqsot0omlirXwkjMDzCR84i0rDx+ApP/RJtPY+FOir+Xifu4s
	uUG/5myz5iO+i+w2FQTRxlva76ZXtNLZzpgIJ6ehTESloofU+lF4iaASQWUzmAt+lJ9THCXwYFO
	cXTAzwpOQNIZZBnL92cSJn686LaWojhjJQ+yyo/6jss/uZWsroIErizuXUg4znwMbwh0SEsaWY1
	ua/HCY4A3oWxRzaCWSkwt0dzo3z11hAcQOWKrLwJqqdW6Z2CmDBQEeOvDXlpTUbjIM7anlfv2L6
	4gkgs2PkRM4F0u95SdMrYiDArgBWu5hZ5+oEIRCnPB7GBlsfesak13Xx8+v1WzZZK8Brn6p6rZV
	PC5ydO+Qc03wWa2Z+8hA1osNUKfgB9nqFGNN7wqggWWbDjViOn4LfSsr4GUF1QdQzHx+PPMAuu+
	nvznXZN2FA7GNirc7ozxy2kA==
X-Received: by 2002:a05:600c:a010:b0:492:3754:15f2 with SMTP id 5b1f17b1804b1-492608794b0mr46291025e9.32.1782311420284;
        Wed, 24 Jun 2026 07:30:20 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93cdsm8310445f8f.18.2026.06.24.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:30:19 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:40:19 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 1/1] bpf: Fix insn_aux_data leak on verifier
 err_free_env path
Message-ID: <ajvsUyhJlIeiHudw@mail.gmail.com>
References: <20260624123536.114757-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624123536.114757-1-kafai.wan@linux.dev>

On 26/06/24 08:35PM, KaFai Wan wrote:
> When bpf_check() allocates env->insn_aux_data successfully but later
> fails to allocate env->succ, it jumps directly to err_free_env.
> 
> The existing vfree(env->insn_aux_data) sits before the err_free_env
> label, so that direct jump bypasses it and leaks insn_aux_data.
> 
> Move vfree(env->insn_aux_data) into err_free_env so all early and late
> exit paths release it consistently.
> 
> Fixes: 2f69c5685427 ("bpf: make bpf_insn_successors to return a pointer")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 21a365d436a5..3ccea8985946 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19994,13 +19994,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (!is_priv)
>  		mutex_unlock(&bpf_verifier_lock);
>  	bpf_clear_insn_aux_data(env, 0, env->prog->len);
> -	vfree(env->insn_aux_data);
>  err_free_env:
>  	bpf_stack_liveness_free(env);
>  	kvfree(env->cfg.insn_postorder);
>  	kvfree(env->scc_info);
>  	kvfree(env->succ);
>  	kvfree(env->gotox_tmp_buf);
> +	vfree(env->insn_aux_data);

Thanks!

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

>  	kvfree(env);
>  	return ret;
>  }
> -- 
> 2.43.0
> 
