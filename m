Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73130301486
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865526; cv=none; b=MDKjmtvJoyfaJ0DA7Rl5JTSwYJzDYc9Lrhp9P4lO+74VT19iTa0alxO2NJPFTHBy30EoPA2W9gsogtIhfyLrpomFcmJ8WbAmAl22vH6R4u0VYME5X6VLXYfA+m0jXDD4AjYsa+MRxZ6JCwr6+t08oKoKydmzaBs9oPJjhrVLOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865526; c=relaxed/simple;
	bh=jSf4RHf3qB5ocmsp/tVjN13W+G4+S1ZBH76/Wmyizpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKrKruqRT6ddqzvwEAMuMXcKn6C4+Z2EoMLF/oLa0oBe12A/uI++VSgCYVsRbqz7gAO994hw00ExgtMfjPddmurRbAb8pPWUNw5LUSlO8ePd9sEIPsFPK6ahA5PNamwvxWfYoUvRO7VJmdGzWBSNyjxKavJxk7BpBjA/QefgAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIVR3NO5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIVR3NO5"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2420285a91.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786865525; x=1787470325; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ow4i57g8nwF8ZS5Q/914j1Zhzni6MXQadYDRuRE5YHA=;
        b=pIVR3NO54rTEBkMTcLCi2WqquMYYQ+Xl3tBgi4n5YPgVTF0YEphrXveCDSli5Im2pO
         1JD9+3nOv6Sx3BFmBokuY0Y4sHya5QnUEWSSlGa/N0VRBN+bacV8nDsqAFGtrmng3kat
         Q8hFACGg07QWtwjw6FHzkPVNHwcuNNMzxvS7K3vqGZqKq20Q53TV/Fs5FZdyeHOJ1ASv
         Y6+EXGWdFZzYCGo+J8nfcz7rxj4I7una/LCy/PGzkitlkMyEvOgI3Cdl3vMZ2dQ+8l+f
         ezAzta3QleEp7pRYk3zW7SN/Q2+unm7mTX8U4N94wKxw/YUw0UWG6Qe7uozh61Btg8aU
         Gzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865525; x=1787470325;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ow4i57g8nwF8ZS5Q/914j1Zhzni6MXQadYDRuRE5YHA=;
        b=RCAGIafwOpMhnoCP33SmpQywhegQtpDeTf5QC82SiHLBiP04hw5j2PiKjyrPoXCN+a
         wH9swUDwmlHJ+xKpHqgABzKJSwpSQjraNnw8SYkkHsIiW0KBm3YJw4vSgtmZgiIlSEMn
         hhoybjjDtywp07T59P49uwlTwtGqWEUp8tLrqyptZnZl8qSUlGxq89p6eFfYS3M9h5Ho
         WA2w6gDsCVI+31fLEahsR2mr8mfMfhnSENohkgM1lVt4GcAmc0L9qN/waOZ/toi0KSJq
         ZSXfKH+Mc2Z0xA5M4Ddocg0XHLePHxmsuJvlACKkSlPkKo8mdMHqB8piMFEFuDFIFuKR
         z8eg==
X-Forwarded-Encrypted: i=1; AHgh+Rpk61DEJfpyTv+sk/PJX83bkglA7KOTshidRxmoCPcrAmSNXgAETC/G+c94ulg+wYp5YZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0qavimy6n9zCjn+SDck71uMaQsg67W77M1ID48b4RhggTfpMK
	X9ypFfPv0h3tDKV5jgCTH9zvn8ToSjwfkBlxnPZb2G5xici1MEp+dezO
X-Gm-Gg: AR+sD12e+UB4hKD/V0BnMk+s7i0ybE0s+jBMVClMdEBHQr+3h59knvGh6bbbxEZU0hS
	TEq2WpmimZ+sq3hhgx4CKzxlCBuBQegX/NxSYbITcbd0WtOE0OOMiW7wj3dL6BPl6Ca2QLRhXI9
	QaLU9+xDQ5V8irT15cFA6yignzgQbIx3F4R8K50CpyH7Kh6jC6z97nggSIyQI/CgsDgXuQpLCY8
	KiHBakA9juLFjFrolXgfcL0njqRUBLZpI2u+1i28ZoZUv/7IhC7l+2TaY7SZpwwoxL9kpwQZ8r7
	LJveHu7Y9yA6pQMkDubNqMkG4iXs4c1qllSURB5y9Se8Y0Ix9HirZvArZr5kOuT3XLQkYtiB2IU
	aleYxA700mHz//lkXbjKpzoACjz/JTNKvlpMhJKezB5YhmMA4DOeeRd0pW1xDuPljEjIuvUuP6n
	y4uigKxf2XBSyITFwKm139Sl3z71w1gA2puJCfMY1k2LRVQHrgPqiYUuTogPqBgbocWiC0vkxFL
	Q0mLkdyLD0OSjU4
X-Received: by 2002:a17:90b:5707:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-3933e61bee2mr18964721a91.15.1786865524763;
        Sun, 16 Aug 2026 00:32:04 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e84118sm893780a91.5.2026.08.16.00.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:32:04 -0700 (PDT)
Message-ID: <9f61aa81bd773115060bbd725f4d942e3a340ef7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/14] bpf: Report non-sleepable kfunc
 programs accurately
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 16 Aug 2026 00:32:01 -0700
In-Reply-To: <20260816015746.2632990-9-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-9-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 2c475174a640..df9259fa0ea7 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -1083,7 +1083,9 @@ void bpf_diag_ctx_forbidden(struct bpf_verifier_env=
 *env, u32 insn_idx,
> =C2=A0	const char *constraint, *context;
> =C2=A0	u32 depth;
> =C2=A0
> -	if (env->cur_state->active_rcu_locks)
> +	if (!env->cur_state->in_sleepable)
> +		ctx_kind =3D BPF_DIAG_CONTEXT_NONE;

Let's do what bot suggests and rely on the final 'else' instead of
adding this branch.

> +	else if (env->cur_state->active_rcu_locks)
> =C2=A0		ctx_kind =3D BPF_DIAG_CONTEXT_RCU;
> =C2=A0	else if (env->cur_state->active_preempt_locks)
> =C2=A0		ctx_kind =3D BPF_DIAG_CONTEXT_PREEMPT;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index da2ec0655b17..3de9e4f617b6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9912,7 +9912,7 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
> =C2=A0				sub_name, non_sleepable_context_description(env));
> =C2=A0			operation =3D bpf_diag_fmt(env, "sleepable global function %s()"=
, sub_name);
> =C2=A0			bpf_diag_ctx_forbidden(env, *insn_idx, operation,
> -				"Move the call outside the critical section, or use a non-sleepable =
function.");
> +				"Call the function from a sleepable program outside any critical sec=
tion, or use a non-sleepable function.");
> =C2=A0			return -EINVAL;
> =C2=A0		}
> =C2=A0
> @@ -10731,6 +10731,8 @@ static inline bool in_sleepable_context(struct bp=
f_verifier_env *env)
> =C2=A0
> =C2=A0static const char *non_sleepable_context_description(struct bpf_ver=
ifier_env *env)
> =C2=A0{
> +	if (!in_sleepable(env))
> +		return "non-sleepable prog";

Let's drop this hunk and rely on the `return "non-sleepable context"`.
Not sure if we need to change 'prog' to 'context', tbh.

> =C2=A0	if (env->cur_state->active_rcu_locks)
> =C2=A0		return "rcu_read_lock region";
> =C2=A0	if (env->cur_state->active_preempt_locks)
> @@ -10739,7 +10741,7 @@ static const char *non_sleepable_context_descript=
ion(struct bpf_verifier_env *en
> =C2=A0		return "IRQ-disabled region";
> =C2=A0	if (env->cur_state->active_locks)
> =C2=A0		return "lock region";
> -	return "non-sleepable prog";
> +	return "non-sleepable context";
> =C2=A0}
> =C2=A0
> =C2=A0static int release_reg(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg,

...
