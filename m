Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0293FA5EC
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051339; cv=none; b=DFeuZeixhEb400Aj8OUSFIsKQIkNqTLXbyMdyRkf99E0bx1vowkSJ5U5SnZGm7GeZhLpiik/1nJTZM34GlXGQTZHeabTZOxiRspHDwH41e7sPIp4s+/aWu/PTb6GchAqoJsd5/1vnEW3S40qfikS85HW1prydjCVtuC/G9+lxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051339; c=relaxed/simple;
	bh=F0KQaD2SJ96PoPWAFtbuk4FQ+zq/X9hurv3U7WhL/ME=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RCCagHY/EjQdGWRCrVURtBL1HT6XR6+uMWmOHcEv5QL2TdQr0WLtXF+XHg3o27kxuOPmTKxVtZhJqgSl3P4A3mWxe+Vds0oPIzl3hb8Jm3pY4J65IkeaN59XOFo8xqNTJ3djN5rA1CbT1mn2MDS5k7ARFAkUbhEcoRex6Dd6yeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrFAF/WI; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrFAF/WI"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so8453715e9.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051336; x=1786656136; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G2AZfBGPYu4bSWsh6BLzCvcj+Dtyu07Us149BV13TVI=;
        b=PrFAF/WI/8yx/S/dpBGjAcm9xeFnl1NINdU8iuKtSrp5zWMFX5TLpl13rVXp0qxI7o
         U6ALIOz9c76GZ4FN450ek6SJscA0kFoUIRPPK3kwyp/hLbEBJFlbfOYwdhTa4cC4f1nt
         AJ9gjlMg+jRDG2Wiw3CDwm09VQYgFkk4LKh9QDp5dUp2R/mBKwarCcAOrDngFuQNekXi
         yL3nf2UFwBXKpsWY4pE1IAUatjndhxDrVE1wnktAm1UBW7zEAiCMb/PLdA5/d8qADkFK
         7lUpJ7aWw/dmE5thiIrBXdzhs6e30/NTnqCV647jonG56wH7RK4eezvJuwjqGmIBeO+I
         E8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051336; x=1786656136;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2AZfBGPYu4bSWsh6BLzCvcj+Dtyu07Us149BV13TVI=;
        b=leiSLq3/TTK7kHDtJgd1PMmlqjZ3xhPI3HDGJ+dZFy00JL4myAGGxqBaUxS7h2rJIU
         SJiGzVUZKWpGd2NB3QkYUW7Prxh7etgptWI3UcRIq8XHuhtornvEuuRAHOb1/OSduzt3
         laVPUTPXgl9PQqCPMg9OP67s7MPVBspMlp+zcqD3NkfjfPYZumPwiHUc0+fMi1BOYegL
         NwuY1GF49vK8PMNyUME0lvlspbmhLv6jl4a8LnPnU6cVHed3mIi4hg0huB30vHptTdHs
         Yy/SK/DKX+wHVDJLgr2yMeihlOYmKmbXSL/PlinZiJE12YNPBB296sRYfc04x2f+U9Qk
         kF4g==
X-Forwarded-Encrypted: i=1; AHgh+RrCnejCB/6U/0KZF1iY3yG5vN/WhrqyeADFknQEFg52LLs5ehFgY03fMwSnMLxN2yRJNTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQNBQWEGaEnc0nuGxfcmrPr5hZFR6w6cUjBW+n8m60r49Pw3o
	JdeX0dLubxCfkcweBtDgZO3JtXJCUQOcyL26PODF/wP4BetgXzySHos1
X-Gm-Gg: AR+sD12On+AmK83fxs9ZdpRAgKYa8V+XGlb1A3IAckAmvawq+RmImRJ7FAXWDnw6YcK
	O0UUY/3l9s1RdT6p5X0LjErNBUA4ZdDSrWWuaoQo6sTcn0k4APxGiqCvNr0E0yLEY1YFx11L3wA
	j694oCkvWV+ukTCcNsr2igklxFJPZiAlki6sbWew+bU9bEkX/ZE9zTFDBI7aA0dp+kbp1jTIk3t
	6fc/SpRMakJsxgtJf6hOM+WxKZCOZdV6aVG6QSyJvDzqfglxUyLkctiYkfFuhAsa3cIOoQy0/mu
	DkYzmv3uTHJyV4J5v2zrYdAdksRk2fYspGXI++aUl9b/fkfGgDIEVd4Y+sOTv2Uqj7UTuWrrUOn
	3iXFzzoKcmK32WJ4MLe1mpu9KrfJGwKLhgHHfChwiwObKiue8VQkJFH/Tn1CIsaeduT5lcowWqv
	4X3USeSYqHzFBqRP/Z1PtNXl7ECauVgS/xlL5576f1FWKyuSNxkJL32ws+phaGV6QY8Hl/MmqeI
	Zw4mWZfbJ+GhLABN9buqzDDpw1B06HW3khSE2aElSbNbkU5nz0qKIdgWbnggFPLDGnxASegGx/5
	91BNFYWfDWSMlrxwB0YzGmw4Rfo=
X-Received: by 2002:a05:600c:a21b:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-4994e7c5e49mr185058325e9.15.1786051335890;
        Thu, 06 Aug 2026 14:22:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b26809sm8987277f8f.25.2026.08.06.14.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 23:22:15 +0200
Message-Id: <DKI6CW88BSBH.10NB8NCS4Z92U@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks and
 remove in_sleepable helper
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260806164049.3158887-1-memxor@gmail.com>
 <20260806164049.3158887-2-memxor@gmail.com>
 <fef13656df34d6ccf0e820d99e8f5e87b9fa8d56.camel@gmail.com>
In-Reply-To: <fef13656df34d6ccf0e820d99e8f5e87b9fa8d56.camel@gmail.com>

On Thu Aug 6, 2026 at 10:31 PM CEST, Eduard Zingerman wrote:
> On Thu, 2026-08-06 at 18:40 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
>> @@ -10258,7 +10253,7 @@ static inline bool in_sleepable_context(struct b=
pf_verifier_env *env)
>> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_pree=
mpt_locks &&
>> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_lock=
s &&
>> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_irq_=
id &&
>> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in_sleepable(env);
>> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->cur_state->in_sleepable;
>> =C2=A0}
>
> The in_rcu_cs() and in_sleepable_context() are complementary:
>
>   env->cur_state->active_rcu_locks ||       !env->cur_state->active_rcu_l=
ocks &&
>   env->cur_state->active_preempt_locks ||   !env->cur_state->active_preem=
pt_locks &&
>   env->cur_state->active_locks ||           !env->cur_state->active_locks=
 &&
>   env->cur_state->active_irq_id ||          !env->cur_state->active_irq_i=
d &&
>   !env->cur_state->in_sleepable;            env->cur_state->in_sleepable;
>
> Should the one be expressed through the other?
>

I thought about this, and I really can't decide, so I'll let others shape t=
he
decision. On one hand, it is true, but I am just worried we have some other=
 way
of disabling sleepable context in the future, for which we modify
in_sleepable_context(), but that thing does not imply RCU CS. I don't know
whether we will have such a case though.

We can also add a comment to revisit in_rcu_cs() and keep it in sync everyt=
ime
in_sleepable_context() is changed though, and hopefully reviewers (human an=
d AI)
will be reminded to not break the relationship between both.

> ...

