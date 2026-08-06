Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3099421221
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048322; cv=none; b=DEGT9V3+UpLA2x5ZotBNaBpq2wu3ZvyJcVT7CgfS3vaNgUBPAVydlEp+7UL8RV/iqjxU+5Jy2zVB0199vTpTIn7F4EHsPZEyb8oStrjevdVqUC5iftzc0CahGNFIvUCFvTOQTA0HgcKpAjFd+kJWxAe0yPckJq2fMBmlVPntqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048322; c=relaxed/simple;
	bh=ORrGTYI1NgGtMC0u7empyfcjP5Yqn9LuqIVNG2I/7H0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auMJSx/nyvlhe+pnnT4+vMtc8fftEuxOwHYvt5UhPIk9Vkj7t9todSad7GW8fx2xmeSfeXE4brmc603fc1vsPi/+FGnIJTRvvAKccw2BWpOIMFmcAUFl6I5vwDyMi/pOd8BvOykdnaAfCePigYsVJ8YaMtqGsT2CdGxF0lTujOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLnn5sHn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLnn5sHn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2c90e383so1098537b3a.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786048320; x=1786653120; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5t+S0y3od/4HAViVUcsNsNmhUh9QuX+h0wFk/vY23F4=;
        b=aLnn5sHnrUssyYV5+oTg97CmoAVj+HCzO2b9wb21tSee7hd7QPvK85FLUAnzDqOEM3
         Vf+ZSmovy/Roq08awiiCM8xYuZ6QbaN+AS4hri1rp8P8g+8WxtcGcUXbk16+nzSdkvhb
         4c/uKTEXjJppoXa9LMSrHUvnGN1ymNNSwernGbSz6gXD76x0rdPZA+tzXoigwKhKDmr1
         Pzbz+85KWvd6jppJZLQmoi0glQafQSlATBDj4aGaZCk06h65jkwp5RwvWYAXz4SzlLS6
         4IbjwNmID15GAoCExdp0LFWW48Om0lxSZER756w442jjzo8aSl8cP3BXV9jryA8igkK9
         Wm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786048320; x=1786653120;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5t+S0y3od/4HAViVUcsNsNmhUh9QuX+h0wFk/vY23F4=;
        b=NT7rjgTCnw2BzJqBrLz+Xp0roOcqXi3v3uRMhTtPx6/9HxHZ1DKnhSHmzL1jAC1UzQ
         sZ6QaOKX8EXJ8eT233TeZIstTs/7N+8XmcDs1Nq3J9+Br7Z98dUESiLd1Oviv/Sx+GUQ
         mu7Iz3he/zH307ECJZTdfQ399Y4AVvnz5nL455z/yt+Azd72mNCfXa9clCuJ4NeE3nEC
         s1cJ7ocY5E0Frl9/8lwAuhnbMU2ZNSLGpkmCdWfVtiACFw+sXYrr8vTSldnfwUbzodcp
         0y3iFF3gK1anaoXrTQAEhtiM9941DloHc4obDLZFTLqsGA/IjmGYuzZta+q3kChZ94DM
         ktvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJ6bnKtmeo1aj99TA8r5ukJjq20wYvW9xN6MAd71UPu5bsJ0szwDdXM6bWrjQbSObMetQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwalfpGxnNVZzL4FPehUSEax9gGSKa+mkjhC9mGCDSYiVXAco
	8zp/ctGZbD23oA86npXate8MsP2MBWQo0O/QQy3OQnPGyXvOtYQXm4tayPy4j6O2
X-Gm-Gg: AR+sD10tsJZfoJ3Qg/2PltZRne7Hd0GxGiG0lnTyKkxTnf6U/gf9a6/vtpGGbUvjT12
	lqLJkTX3aP96aN8VjgwVmQlYoXzD33lmJMCal+gSxoigbXaiHF8Qx/wL2Gm3ZP2sX8xoO9Asjpf
	KuoogRazaKt02dhruhYfGI1kcTc0c34/xViCLGWajjdQuVNtG57pi47PHPtAQQdY1cZegc5y+zF
	Kx3n6Hz1OBhjgu2TDS1mh+9v3np793wEcJi/l3WTFnIgf486OYx3NiWEdaz0/pwzTzFu4q+x9DN
	NEKEf13V5fQ25nNTB36EVdQiDdb6Wo0qn3zBE8+MH4Wqdg2NL8nFfEI4MDdWWn23z9dqGfLNsCa
	3AST4HdCxvHCrG1+sCyb1fDWUGbd+K21Zg6Zy4ToZf0bXtm415Y7ARfRPMzDf08t3f3Y6evBfkd
	0Fqc9ILN0g7WH1S266RpqU8FlVXDcX+KmbjQvG82VUZsp1DCESKJN/aCnV3WULJxvsLm7PlziFK
	I9R2vliMpfqf/yk
X-Received: by 2002:a05:6a00:3686:b0:847:950b:b71a with SMTP id d2e1a72fcca58-84f47fe6caemr8644318b3a.16.1786048320216;
        Thu, 06 Aug 2026 13:32:00 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc98absm2024052b3a.57.2026.08.06.13.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 13:31:59 -0700 (PDT)
Message-ID: <fef13656df34d6ccf0e820d99e8f5e87b9fa8d56.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks and
 remove in_sleepable helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 13:31:56 -0700
In-Reply-To: <20260806164049.3158887-2-memxor@gmail.com>
References: <20260806164049.3158887-1-memxor@gmail.com>
	 <20260806164049.3158887-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 18:40 +0200, Kumar Kartikeya Dwivedi wrote:

...

> @@ -10258,7 +10253,7 @@ static inline bool in_sleepable_context(struct bp=
f_verifier_env *env)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_preem=
pt_locks &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_locks=
 &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_irq_i=
d &&
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in_sleepable(env);
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->cur_state->in_sleepable;
> =C2=A0}

The in_rcu_cs() and in_sleepable_context() are complementary:

  env->cur_state->active_rcu_locks ||       !env->cur_state->active_rcu_loc=
ks &&
  env->cur_state->active_preempt_locks ||   !env->cur_state->active_preempt=
_locks &&
  env->cur_state->active_locks ||           !env->cur_state->active_locks &=
&
  env->cur_state->active_irq_id ||          !env->cur_state->active_irq_id =
&&
  !env->cur_state->in_sleepable;            env->cur_state->in_sleepable;

Should the one be expressed through the other?

...
