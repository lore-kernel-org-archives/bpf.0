Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED734E766
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054666; cv=none; b=kDRENG/iwKQ3Qj6x4bxF9/zfLBSHBzVMijdPxS/pjTjRlS4QdR8/ChQuNGWG2vYFhOcJyzXAIqD+p8HqTrd2T/HiQIDhDe9B3YwEZ8tdg5YhczY+N8/6gewVjtvQq89LLEEwRR9RKyM3BGYmJgswS6O4J+s+7nfmtVZL35Qi6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054666; c=relaxed/simple;
	bh=SS4QKRE4m+IO5cBiptBoS9Y3sL23IlhrLzjS1NdsMc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eg6mpc/oOVPcTVNsa8IiqjRc1mR/R7RIKTmfvsMHdt1xSCicy4y8Z27uWV0USbS/pWSSr0czGaVzg130YP89xj+qrDpy/MU70U5iyDm6mz9maYLag0KIy4N6ImV1Dr0Lo2QNmvO4DKIIlE7x6AwxwGekLDsZ8qLjfv4Y/es5SyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYiNuPzX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYiNuPzX"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1882946a12.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 15:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786054664; x=1786659464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sh0/sciejwZ51aJtQDuF3TY/Xx+Z5cvHScJrFQWygtQ=;
        b=AYiNuPzXjSH7rvEwA2x5G1TE306XwjBxVQHV+dARB3pjrRsUIehUGUHPvKvBUw7uvO
         lzqxpKqfOcSzLuWpfXxnrbvXCfvabqsq/c4yKd1RPGIgS0RsfXeo4ohxPL7ofZaaTkj/
         X3Mzokku6AiZhb+OoyB9wrN5rImHS63oGt3VJkL3v5LNocIiL1yrYUhBAhDNHghOZjBf
         w9djHTtPXGDbUas8BnTs5bEx73BAs0elnog30w058wyd51sBf73OjCcORoPxo+ipNifm
         W6TY99warT14O9gU8t82raNS3TXCMXBD7p6g1TLojMyc4j7CglO7URVSvg/W4OERrOvD
         UHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786054664; x=1786659464;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sh0/sciejwZ51aJtQDuF3TY/Xx+Z5cvHScJrFQWygtQ=;
        b=fpPzXUDDoOxK1Tq8gZnRyUzFGhVuqrVXikL2O03Il2upCwq6idRZNV0C3xBlXWsJab
         0EdhZ1sK1zzUQ0nuDNxAl0wFuy0xEyBwcfxJs/qSwBldlA+qYjiKdXacDIFnBzffG8Gv
         9ZU5BF6QRkZXsMzWpt4m1yhWPg+xI3M8zXb5QgpZW68v49zO9kZiC2a9btWNoWseO5VU
         2pLmb8i9KFGFuGGiAnf7X6ZZOyg4/JnGT1nthOIDpESFqF4YCpIOUwPzMk8w+JAGY+P1
         wzNJNUKB7IT1CXDVGSVhBYiqQTqo72QzoRT+8ePCLGW0WmYKJ067YM5hroBC/8sMlpGG
         3BWw==
X-Forwarded-Encrypted: i=1; AHgh+RoOWshW9RY05czz5PCqrytw3KBtk2rcG5evd4dfSF00uoN+mO4c3nGAut2VfLGjznbrTAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVNQAWO4L9FICvM0U//JOLsVqDzeHp/RK1uiLQ44km3X6kWvW
	3G5yK1gaxHGUKgCPirkEVYbxRo4ZXwfKu12LWyea39kWf4QU3VJCrGvz
X-Gm-Gg: AR+sD12hqoJIcSCRfCWbUMtBLKrIFmaUBhqs66nk95GAVMTDFMAOd+lS7Qez3hsuLlS
	RCkSkobezsex74N3klwGzSVq2KFcccFmbSOynxn8hA44NewbdawtAGxN3yfuiG0xcX7osUHExXF
	GCX8Ep+VEKOwbbGEwdlQVxgMEnnrq12KN/8bYVqRxCetqYUuaHYy3/HLPWGoya6yLDOk8FOS4q3
	FzKVRavmX/FyGpJSaDPtFFgaxBHJhPEhQuNF+ibklVj7DOWH7+T1q4wSTdzXLSS2WfVCtJ4MRYS
	mFHek0UGRzmbB9r+Mw1XA1tRMa7ehn1YbX5jCehw6oW2xODwP3Z3l7sDQeU2oKkgApAzRlnx3fF
	LQO3nYxeOVvLMYhx9DbI1nOlVhpRAOJ50GG+ulzvTudtQKOqPdNMjYnICRXunRFa/gyc7cmBj/K
	tb+mN2o/GeX4e2jd+Kw/8Fyet4AhjndUS4TmaZCAV0wkWPN+s4PmAbW4yhb/EGgJwXZQCQkdtut
	+J4LaXjWxNGwI1w
X-Received: by 2002:a05:6a00:22cc:b0:848:2c6c:dfc0 with SMTP id d2e1a72fcca58-84f2e04ea1amr19241196b3a.24.1786054664633;
        Thu, 06 Aug 2026 15:17:44 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a58bd4bsm45642b3a.56.2026.08.06.15.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 15:17:43 -0700 (PDT)
Message-ID: <db75ab0bb5d1d03c3062ffc6b5c0c0fe6a3a41c6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks and
 remove in_sleepable helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 15:17:40 -0700
In-Reply-To: <DKI6CW88BSBH.10NB8NCS4Z92U@gmail.com>
References: <20260806164049.3158887-1-memxor@gmail.com>
	 <20260806164049.3158887-2-memxor@gmail.com>
	 <fef13656df34d6ccf0e820d99e8f5e87b9fa8d56.camel@gmail.com>
	 <DKI6CW88BSBH.10NB8NCS4Z92U@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 23:22 +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu Aug 6, 2026 at 10:31 PM CEST, Eduard Zingerman wrote:
> > On Thu, 2026-08-06 at 18:40 +0200, Kumar Kartikeya Dwivedi wrote:
> >=20
> > ...
> >=20
> > > @@ -10258,7 +10253,7 @@ static inline bool in_sleepable_context(struc=
t bpf_verifier_env *env)
> > > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_p=
reempt_locks &&
> > > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_l=
ocks &&
> > > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_i=
rq_id &&
> > > -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in_sleepable(env);
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->cur_state->in_sleepable;
> > > =C2=A0}
> >=20
> > The in_rcu_cs() and in_sleepable_context() are complementary:
> >=20
> > =C2=A0 env->cur_state->active_rcu_locks ||=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 !env->cur_state->active_rcu_locks &&
> > =C2=A0 env->cur_state->active_preempt_locks ||=C2=A0=C2=A0 !env->cur_st=
ate->active_preempt_locks &&
> > =C2=A0 env->cur_state->active_locks ||=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_locks &&
> > =C2=A0 env->cur_state->active_irq_id ||=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->active_irq_id &&
> > =C2=A0 !env->cur_state->in_sleepable;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->cur_state->in_sleepable;
> >=20
> > Should the one be expressed through the other?
> >=20
>=20
> I thought about this, and I really can't decide, so I'll let others shape=
 the
> decision. On one hand, it is true, but I am just worried we have some oth=
er way
> of disabling sleepable context in the future, for which we modify
> in_sleepable_context(), but that thing does not imply RCU CS. I don't kno=
w
> whether we will have such a case though.
>=20
> We can also add a comment to revisit in_rcu_cs() and keep it in sync ever=
ytime
> in_sleepable_context() is changed though, and hopefully reviewers (human =
and AI)
> will be reminded to not break the relationship between both.

I'd declare in_rcu_cs() as !in_sleepable_context() and put both
functions side-by-side in the verifier.c.
