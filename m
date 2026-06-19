Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0A3B47F7
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903993; cv=none; b=F7tYREVIMLUF/6ojmId7oXzgZKHC9NM7lQD42jfPalSRNu0z97uRgsQ75wf7kUxzND3mdCFq32pmI8cxk37I39yS5ExC8B2bIT1NhYH6NoibH1cVzIfuEWgfCf1VCD2CNfhcmGLjMT/NRWOsQ8FMi6v4InmNBZ+Nia7ym1VT48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903993; c=relaxed/simple;
	bh=Z1v7oK08s9cX9ai3rtGVy+hD16fiw/Yo5ZmR3yMmw6U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D5ZevaFtVT4Eo5jgJIpnKOvZ76Kw0Pv02xSc7Y6Q5FUDTHbVplkPQjraZIcictksXsRdLlOXRWniW3wPfav3W0TYj4FX7odfnu4BcxlL4SDhdx1l4xBOElkrCuMnZqVoOLcfartdeJ1kfSQOFooKIC/b7OLC5hsFl+y6CXkyFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjvXKwPb; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjvXKwPb"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso24953325e9.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781903990; x=1782508790; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPe7xhOch75yXx5Pu0qv+8+PGvLXn4ZjaQ2xwLoyw08=;
        b=QjvXKwPbU4nu/OPmYa2NOMoH7SpB/FxLIHdRfI+9+BzszJSm8f1ud7JKI0m/IS5fqc
         WrCocLFwy366YhG0k8VyKujHTU/CNyPYT2fnhkji5Ld0mnhPiHOO9JD55zFg443q8L9G
         YYAb+UjfDF4OrSi5PW3S2e2EPo6u32esJ1962nmKOF+aWq7gYLtQzJK0x8AUl8OO0M5C
         NNzJzR2FJEOzJ8AfTp3aYqXWZ65HYdy4fIy08oJlL13Ln8ddehxBxERF4u2xRGvRD8PA
         H0JWh94zejHUVOf+dtG2EbrBiF+Sco3AmVn9cz2whceGme02H3l7pOYTM/6iQN94Fplc
         k5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781903990; x=1782508790;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPe7xhOch75yXx5Pu0qv+8+PGvLXn4ZjaQ2xwLoyw08=;
        b=l+W/zFFAj10yUmMQKxZT7RyiJOkIKUzGufJwjLmYbnSF9a2hO3q6yejDVGlz82jDcp
         1cHYdVyqFX19rIz/dfTpPkgM4xFjuNXZ0aQz2asG6GMiV5QJal/2PHsFxwSLL1hhNSPE
         iimJ3jYnMREelcIZ6zPwVLG18dakX5xgBrC3StxvnLxnO0F4qt2ZhWCgVprUUc2Wa3rK
         nu3BEB8xay2PVeytcIP4AIxaU3iZxzxl8FY8p6uPdzvZnkDM0amu606F1D9V2SLWnlj6
         232cskW+9ckU0MHn8cURxK+phITln5cDx7VsZ4T8GlPqDY/H1/fbqYdT/yCViGmvy3r3
         R5CQ==
X-Gm-Message-State: AOJu0YxQLb0zV8Ly5l4tDyudgJr6FIzW5e2vtPZk1udvmCSdztLHIIlN
	tbSPcoi9+Tl9OZbC5QIb8bPEj49qer3Ii9LQkatAjloKQdAvW7UrGMtr
X-Gm-Gg: AfdE7ckc4S598uTo1IFql2rLZ/2iynIcvtTYDwffxOkaCOtVDX4cX25QdlLXL3efkSY
	iq7FhEvAujGNG4vLmc8KJf+jCoI396PexEgylSno79kEE9R3AOsAhn7M8gftoXkzDa/r2Sij7YP
	kh6Rr80K6VbOqnG1CTDPVGu4gk8vpzvynOlyxJMdchvbMWwHl/8ywLhBU0tEiXyZ+ha9+IvCdpM
	Ua33MpCUlis6NLsn/vFnurNcDBTZ8YrPAD9CxT0A3lyzqB2likvDN2UCBeg1Gsj8IgKqJuHTp8v
	/iThEXyRrzvDqvnNAMxsMrLVKOk+m9Py5JRoyo3otsoJqp5MHjUVMvVrDNsvSbXhkkLojp6YW/0
	daVWIADs/nMr2TRFdFSEZ5rdCcM5T+pBDNVQsSZ3q05ubWzlxVfjPOuuJ/7KcUtMurV4jwCgc5+
	53IbDPzbGiHPi2cACK59HS4CwWmaGRHvk4qfZCxQnJds+aH4jPRfz2oOlGjTm5QexUn58hcB41l
	FXKk7TCwXm2yv9FoDMShejt3K+99eOZabkvrLw3t3uTMxyRzto7uSA=
X-Received: by 2002:a05:600c:5252:b0:490:bd1d:4732 with SMTP id 5b1f17b1804b1-4923f579333mr93310165e9.23.1781903990201;
        Fri, 19 Jun 2026 14:19:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff821aasm97351255e9.12.2026.06.19.14.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 14:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 23:19:49 +0200
Message-Id: <DJDC8VWEQND5.F1DEG4W53SB7@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 07/17] bpf: Track verifier context
 diagnostic events
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-8-memxor@gmail.com>
 <20260619211353.0B4201F000E9@smtp.kernel.org>
In-Reply-To: <20260619211353.0B4201F000E9@smtp.kernel.org>

On Fri Jun 19, 2026 at 11:13 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Hardcoded depth for IRQ contexts breaks nested diagnostic hist=
ory anchoring.
> --
>
> commit 86418a115dc1ef24cac1a623674bfd700c69c32e
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Track verifier context diagnostic events
>
> Record verifier context transitions in the diagnostic history to anchor
> causal paths for lock, IRQ, RCU, and preempt regions. The depth of the
> context is used to ensure nested regions correctly anchor at the outermos=
t
> active region.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 93941deb2cd8c..e584dec04b34d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -1473,6 +1475,7 @@ static int acquire_irq_state(struct bpf_verifier_e=
nv *env, int insn_idx)
>>  	s->id =3D ++env->id_gen;
>>
>>  	state->active_irq_id =3D s->id;
>> +	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true, 1);
>
> [Severity: Medium]
> The commit message mentions using context depth to anchor nested regions =
at
> the outer active region. Since BPF allows nested IRQ disables (for exampl=
e,
> via multiple bpf_local_irq_save calls), does hardcoding the depth to 1 he=
re
> break that behavior?
>
> If a program nests IRQ contexts, multiple enter events will be recorded w=
ith
> a depth of 1. When bpf_diag_history_context_start_idx() searches backward=
s
> for an event with a depth of 1, won't it stop at the innermost IRQ enter
> event rather than the outermost one?
>

Good catch in both replies; will fix in v3.

>>  	return s->id;
>>  }
>
> [ ... ]
>> @@ -1552,6 +1561,9 @@ static int release_irq_state(struct bpf_verifier_s=
tate *state, int id)
>>  		if (state->refs[i].id =3D=3D id) {
>>  			release_reference_state(state, i);
>>  			state->active_irq_id =3D prev_id;
>> +			bpf_diag_record_context(env, env->insn_idx,
>> +						BPF_DIAG_CONTEXT_IRQ, false,
>> +						state->active_irq_id ? 1 : 0);
>
> [Severity: Medium]
> Similarly, won't this hardcode the exit depth to 1 if there are still out=
er
> nested IRQ contexts active? Should this calculate the actual number of
> nested IRQ contexts instead?
>
>>  			return 0;
>>  		} else {
>>  			prev_id =3D state->refs[i].id;

