Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CDD3B05AD
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786078300; cv=none; b=FNhj2RPDgYKAxnk9AjtaAI8RocY4vDSJICVC1M7lO2IDFeYHTSowAP4QyCOro9rhyXdUcfzx5Wx3AA47XTi0WdTfI1j3pg7TLOE5nO6s7welGAtFPmaKeKsXpzCrWWE46i+7RBfdLk3HNlBdJX1sGyOYWoOyew+X6P/1sVmc3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786078300; c=relaxed/simple;
	bh=TZhoVWxcol62MS4l3p5HSe8nuCS7V3UP4zZIBfuot7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbLVbiwEDa93sVM9oeS9YDGwObDv+kAu9g6V9bsmoMg+pTWEfOPU9nVygE/qTbRe5a8DnEPgaskwSqgTUniLMx/73+1uEQa/mvfXMJhq5RH98SkeK2tGWsS+r1ksAY1BEwl4E6ysQTx8k7nImwokc2/s/ivSO8dUDg6KlajDHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqC2S5uB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqC2S5uB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad8076b01so36128755ad.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786078281; x=1786683081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LvuxmriGrtP71Bqo8N3YyYAMdo4xg/XUEuxaNO4fBco=;
        b=lqC2S5uBfhRGusFiWd8puihh8U7d4EWpw/Vgq3GOhSIlHHBHTxu6ll3b5fxTJx0vav
         caJoAwQnejwk91nE/Nxo8T1KujP3rx0YaHItYjMrqvQt0Tagx7l0IhdWDqFLD5sdoY/F
         v1P1/oZFJL/jELlZ1mwp5/bkMVQg0dV6UM8VzruAoLjYQOgnMm/IcwEaadBTvTNH7P2l
         6UGba19tLGQPW2TRCyv8BUKrYHHDIQSBW8KSZuh7prjX4rB1/NEP6oEDCeXqyB1dGZpI
         PY5IJ4pqpTOrdLWIDXjL1+Czw1B179QCgwPu7we28RS+r2chILH6TOW/g08iqVOcrKUP
         6hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786078281; x=1786683081;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvuxmriGrtP71Bqo8N3YyYAMdo4xg/XUEuxaNO4fBco=;
        b=CHph5WXIyE0FtKnJRfvQUdmKYagqpnbgaIP103vAO3x9FejpHmnHtz+PiGuMQeYWv8
         Jtaik5ik5EA7+LWDg/VD+FjH2K7y6OtR5J0E2QgvirW8TwDqQqzz42qsN8An5RecUHG2
         SP4Ar3pVT2VtcTdzYZfi6MrBSOlnDAxWiH8VQc3FjcLwm/bgvKJpws2gp4h+K8/cB6bX
         173H7frUX2/ttqTrl5ncAyscxMFN5/Jeuabh+4G89BO1M9nGGhIlhUN+TM6A7qih/odp
         RuYOYEL7cxVEYoJ6YF54dlwBTjYSFOzU5aFvi4av5NEeQXF87XRWIA8kuwYEUhurd3AR
         8sPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpp1F35Vbj7jxqXWMe54Wlj8hCgW+CnkDNuJNM1lwvwgM9OFtT4JGN54OAyczuW2FY+Y0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3Lc9BNODlRLbKKw8VPxI+8axLa704BxLFuvX+P6nY4Md2P06
	ilcEywD7pmNEF64Mbb1HQbxC8C7+9yK8GAoKF730H3MzObQiyd9ES6beN3ytLA==
X-Gm-Gg: AR+sD135ohkdygZ9Gl7NZt3AWnyBkzhU75ZNrSU51d8LBE5QSTrI9eRLVAjhfzDSDbE
	nyV/3tIDbKh4+oWTgqMnH08aaZqJDU7avx3aLRQPWzEl4lxIUvCYvZlTr7fKMF7zhum0iK2cJxc
	KB9Pi0Z01PE1jR498kDi0jSVLo71ZiXOXRa5HVkHuUeF4ZA9J4K1iPOzJoyU2cpSyo1RjUeBYt4
	JGxdJotqoO9UngC2T1tjjJbQR7iGF6merq2UuZgjCt7YuwL6bbJy66aKH2DowPBlKMoq8DMZDHP
	cAjDcVPVSthFoE6ZhUIJsYrPBtq/ktW9ixLUAq2KHTghJWa7X20JqkTG8yeps3clbDfYHKzmjMM
	+G/8sGkYMlcu7BIXIh5JnC3ld0534m52qLh8xXDqYqhh7is3PpMvlVju+tfJoHwf41TOtLeTiLG
	QUSHG00FkWFoCIzZt24dYfHxq2/Qerx2QE8aGw1NM0UC/3H/2g43+Kfx1mcm57bnsYz/YbC/+os
	4FHaulVwXTdPNwu
X-Received: by 2002:a17:902:ef47:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2d0caa03d40mr247825525ad.20.1786078281377;
        Thu, 06 Aug 2026 21:51:21 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4e1182sm2802625ad.72.2026.08.06.21.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:51:20 -0700 (PDT)
Message-ID: <dc868ce686d00e50f4a5949968f1c88462e04080.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 13/13] bpf: Reject tracing progs for
 struct_ops with arena args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, 
	kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 21:51:17 -0700
In-Reply-To: <20260805210427.3218326-14-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
	 <20260805210427.3218326-14-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 23:04 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index b349e0817184..e07af35ed040 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -529,16 +529,6 @@ bpf_trampoline_get_progs(const struct bpf_trampoline=
 *tr, int *total, bool *ip_a
> =C2=A0	return tnodes;
> =C2=A0}
> =C2=A0
> -static bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < prog->aux->ctx_arg_info_size; i++)
> -		if (base_type(prog->aux->ctx_arg_info[i].reg_type) =3D=3D PTR_TO_ARENA=
)
> -			return true;
> -	return false;
> -}

Let's pick one place for this function throughout the series and don't
move it.

Also, a selftest?

...
