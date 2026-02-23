Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92424376463
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878460; cv=none; b=cL2xXSy9zKDFIIm52ctAGjoM82gUxuIyNHrepEKbAofP2TQZ51yj898/KSXt/2c0iD5zGMrccLpp86SlhgIot2Vsxe/CaHcI53al1OogeaC7eF0PH8qBTkK5eB8UQjO6SiDP6/fKWW0WOzE2aWijDva0VlXFlhLr1mwt9JqT5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878460; c=relaxed/simple;
	bh=hMP4zoSooD7zZCiqz6OYN1igW/hkL0z2GlWYnnnSo2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wu1U+Zoj3Uc6T3GWQj09fSs8zLcUaz/DJo1AcBKTK5AT6BGjvvDUCCqVXEThwHx5PwGSWSA1pzBJlFDfgyoNtNf60MNpH1LQTbKhSN43bImo7BS/D9YIz4M1HufKFx1D8XTl0gGPpk1XOpZ0FAUGnjBh88XenbvOIM9ant3yhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUGEpSFp; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUGEpSFp"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-124afd03fd1so6500722c88.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771878459; x=1772483259; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4v22E87jZ06TiiO5WU5zecdS/uKhWt5aV+zHyokw3aU=;
        b=ZUGEpSFp7geycjJObC23LdQyyq34wWl2GIJhlsg69XcNmtNYm2V0s4DuXOlIM8oLLw
         5B1u7gYhLu0xYnhowQWj0ae5yWuiw6Z904gkrqd+YSdXFwr9YThkNoCssON0RtS3QzdT
         h/T7g16n3WeKO4keaMXEoBz+E0Z7TaYupUGCxZxQtvQTKTPYYMsNrfVgUry+ed9ZB0yw
         VECaKDiOupVWWixhcanEHRTxvw0KPfx54LYERM4A823ZQhplxSgqMKHyJOxjifAWpPwK
         QLjAWTrgrr73N2ATRK/kjphzHLVaZSsnUZot97N+5qn+Ke7z6+cN7GPYXUTGRvg+mXpu
         80hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771878459; x=1772483259;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4v22E87jZ06TiiO5WU5zecdS/uKhWt5aV+zHyokw3aU=;
        b=HtFKLUe8yXpwEkvrniHVFwdwO1lQAi2CuuaYW0SCHHSmZ800V6wBAY+DxafHBt4FYC
         HqnwlgHQjCipH3mMHDnbeN7IlZgqkq5WTtJtS8+ID0T8xTHxxvOmj3BNeEHGvn1YEt3t
         T9sa9MafvKI737h6bmBNiiE/3AdUSvh2OmWwOXIyE5LQtanSbLulrBAIvYmrBs0vlh8A
         fscgDAh0tq4ZYBtRn1iYpmxQqypo+BUsbENPNDymTuqr+N6KckA1S1/CcKfLSmc6ibS0
         vimTecQXCde47fUB7bWG2tMhsMXcFycywvljd1AR8SEmyuaUbXSoLZ3O0oJn0gcBM7DY
         OGQw==
X-Forwarded-Encrypted: i=1; AJvYcCW44FNYNfEDEHAKeL5FpkWGW6BHg6rW9KtTdyT7XbB7C/ODHgdb4vGRfUQJ3BNZYrNEiTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8NPmbDO2IgU91ZXR6wgpcExVGIoG6O9WnefwjCpE4ejX/H/sb
	IOXC4E6pMdKnYKwJ4e92RudkzB+LRtOVrLcCiJUnoJZl1iNWycOxwLyk
X-Gm-Gg: AZuq6aJBJa1Lirgddb3HUR3xYGe6E1zas9vHVWugWEhNYz75zAiNZsfHDWcGltnR+A2
	4EFo7f4sHRBcOS36EErZHCB2e+xS6v8AIe4rLvMyIgxhpcdh+5AT5i/Q/84ARYQwd2UmCJD9YSS
	7pzoZw+HGcxYli4ElDETR/LNaaz//7VT8HEzMkFWhMVuLefOTTm+krqB0mHrhaVFnCN6t622RT7
	Mbg12PkTm/pWLpnalUORGkgQgY3uJ4bW4JnsIXVfSQfdNsoEy4VbZmCwL/y89MyZX3xx0BrWK/K
	DJG7+TtubhJ0HkDbuc4JLv5sZew1lMBr+0bVnFJpBOP9B9Cjhn2dfnNHQkq7B/f7ZkpwNa4aeju
	thNoop2DKQxtDusjraJmdcYA+YLGYcucKijVMwEwnqrLBSY4XDzWFzDNDRXDOQ55bK9Jg2ymLZP
	zQOH+UJlADMPwtxY5/8+dgIK02e+wXiLi1sL64fw5X35XCgEr2mExRW758zwzk0l5nArE0hqOKD
	jnLyESGR0De9lkkQho=
X-Received: by 2002:a05:7022:41aa:b0:127:3b1e:7e0e with SMTP id a92af1059eb24-1276acd8313mr4517007c88.20.1771878458516;
        Mon, 23 Feb 2026 12:27:38 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:7bec:d612:85a2:37de? ([2620:10d:c090:500::1:3a66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8a657sm8970243c88.12.2026.02.23.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 12:27:38 -0800 (PST)
Message-ID: <c3ada08c5f362b0a378ea7bde84b20f920af6b1a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: consolidate sleepable context
 error message printing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Puranjay Mohan
	 <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Mon, 23 Feb 2026 12:27:36 -0800
In-Reply-To: <87y0kjb4yf.fsf@gmail.com>
References: <20260223174659.2749964-1-puranjay@kernel.org>
	 <20260223174659.2749964-3-puranjay@kernel.org> <87y0kjb4yf.fsf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 20:06 +0000, Mykyta Yatsenko wrote:
> Puranjay Mohan <puranjay@kernel.org> writes:
>
> > check_helper_call() prints the error message for every
> > env->cur_state->active* element when calling a sleepable helper.
> > Consolidate all of them into a single print statement.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 40 ++++++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c693dd663cab..c2a63f8c8984 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11574,6 +11574,19 @@ static inline bool in_sleepable_context(struct=
 bpf_verifier_env *env)
> >  	       in_sleepable(env);
> >  }
> >
> > +static const char *non_sleepable_context_description(struct bpf_verifi=
er_env *env)
> > +{
> > +	if (env->cur_state->active_rcu_locks)
> > +		return "rcu_read_lock region";
> > +	if (env->cur_state->active_preempt_locks)
> > +		return "non-preemptible region";
> > +	if (env->cur_state->active_irq_id)
> > +		return "IRQ-disabled region";
> > +	if (env->cur_state->active_locks)
> > +		return "lock region";
> This check didn't exist before, did it? It looks right, but adding
> something into the commit message to explain this would be nice.
> Does it mean we can currently call a sleepable helper in the lock
> region?

This triggered me as well. Claude pointed here:

  >   The restriction is at verifier.c:20999=E2=80=9321007, in do_check() =
=E2=80=94 before check_helper_call() is even reached:
  >   if (env->cur_state->active_locks) {
  >       if ((insn->src_reg =3D=3D BPF_REG_0 &&
  >            insn->imm !=3D BPF_FUNC_spin_unlock) ||
  >           (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
  >            (insn->off !=3D 0 || !kfunc_spin_allowed(insn->imm)))) {
  >           verbose(env,
  >               "function calls are not allowed while holding a lock\n");
  >           return -EINVAL;
  >       }
  >   }

Commenting about it in the commit message would be helpful 100%.

> > +	return "non-sleepable context";
> > +}
> > +

[...]
