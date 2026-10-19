Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38228355819
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375543; cv=none; b=i7FdYIYWbsqoFR9G52iV31+nVGH5b3TzXNzTb3Jrm0OO+xzVRsS6zy2TtAa7b0N2BaX3/3g8QHIB+mWWoUem2gBp2q5+L2yRUHrGKJzCfvLO3YQHQaoezVcOKk1MgYkiVYxtvkIUDkRsvJfLDmBszL9Xu+cw6IV839fL+P6GcmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375543; c=relaxed/simple;
	bh=RgrBwz/atBtm5GKlvb8SYSh/gTYHrauUZ6tmvzn2SxE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=WDebC1E3/2jKg2eFM/Byb0Im03qi7N/maLRz9pbcknupMDeqof/FpmWzXkLAVj4m6Slsk3Ds4BNTUIe72+0oef/NuuRAFxs6yjFL9Y3blS4GfN6d4hPkuLBrygqojGIiTa5MEMUzHokHm4Necjo7NUWsO1VFeSuZApB+SrN8Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfLVzFpn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfLVzFpn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so1051405a91.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 19:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375541; x=1792980341; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yBkwXxAR4XChMex9psBdgVPkQwMxFwkldUrvZSVk47c=;
        b=hfLVzFpnqMLgFGg9Wc9xYeWcj+KaVQFCPuS9ELO2H1z6Zgn30V/TNxr3pg5yKn63pB
         f54yLTv4SERs0UVlkdKhuF/VFxlYRUZ+F+TyK+Pz/E0Qs/Zg5NNunWwz2zEDQZSnRdlk
         1Z1Ww+59aSSWObLvaE4KnKWk9k9vEEvAzcEhaS1TRc1OLSO84XLnJpCF4kQEWiMfUydN
         a66w16yVl2UWpFqgsA2as+nRSggcf5V9To5fFpg8NS71Vr6RCheWG2roYhnEIbmZhlPG
         bYCIPPBXRFBvgXwyJe8nHwu7p7WUsU3AVdfisP7gdvvZGwdTaH5FNof+Zk6/ONBQPU2b
         IJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375541; x=1792980341;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yBkwXxAR4XChMex9psBdgVPkQwMxFwkldUrvZSVk47c=;
        b=BwNenJ4zdQnFTIcr1Y1MIFpororP4C5dgq6XgGtvufaJcX+tvaqVj0jqvbzJ+BHPqF
         mdvDDQ7MJ3PgpElGahC08GKtTZkBW4XLMkDbrQz/2ToZrcOQN0UItX8n6jW7u8R4xl4Z
         VFpUGVQNXfHVHSfnpOu+NW0Ogsx7aySdFNGBQ2CafySZ8GdVLu6QIfSZ0jRBBhPoT/fx
         rfqFH1qROAglld/ZhWpXZIczSbljGu6mLZSOXmOdW8MmAGxPS7bOxO4lbRjmhhOiRA/W
         rONF14w5sygRFUcuuCgtht5eqEPARTbR5mPiqRkCenXHDxrIAFNO5xlk5CeKP7IbWSKi
         MhYw==
X-Forwarded-Encrypted: i=1; AKwUvByUqsBW6wBNcYAtJA3fWYu1obVNngJUbFwj5pLZhl784tfRub/jHuiIE2RAozW4QMKZA+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwhOGLdpXms4GOe3H0HhVKButtETgGyw5vM2Mlb+bwFlFCLj6u
	vXUMexML/oAoC1Heoc0rFHUpV644TcdL+11INHlxN0PtMttLeshgZJ2zKDr6Lg==
X-Gm-Gg: AYBFou1nujKtyLwyLo8bf3vLgIOZHn4Y7QHkH1kg/2CfaSicEDsPo1fzocN5WqbjHx8
	weqN73jMI6ixGLBm8BfoQ8TXE9vkefprq8osGcl+e1hkwDHnXCImsugnTP2J0tVAqcDFNXQlDhf
	Jl5CQAZORx3Xik0NZf1YRq1yWnoosl4Ue/GnAoih6HpGFAnYR9aCFjoVRqwHRXiOwk/C0wCg5b6
	6YrzTYJ7o6NN5ITuPwrk7c7KYSQrtGhNC/fQwfQ/wQ5ZCCnIHFWC0KVauoHVTC6c2wbMEi+bvlH
	IKfE9iA7RUh9QeGnpFXPyaeXdIhxxENJ+ea7spoFStyG/889JHZyO/OT8VKt3m/LzfS/UPvoaty
	N4l0m/dpaE8mknTqX0jUReVZuPmLQz5f9eUPywQ5Fu9MNTx71CWQmi+6BqJEDyOCpjfRUJBZAMM
	66rDR+IVUQnLZoDiYh+hxppCHLbR84TgxltbFNZZQ9Ee1R1jnxBudUj0Yn6Z93vdum31C9pMwIR
	L7aIGE+tVo44Wq7laBRnhZtWz0XaD2bDu7kagIRkVyeaDKOwQONDMoX1sHWwO8GAebpd9o80zMj
	xQKr
X-Received: by 2002:a17:90b:1c08:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3aceefbd8bbmr3505864a91.8.1792375541219;
        Sun, 18 Oct 2026 19:05:41 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e7311sm18601658a91.4.2026.10.18.19.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 19:05:40 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 02:05:40 +0000
Message-Id: <DM8G3O0ZTUM9.MMBWXXQ7OP98@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Unwinding via r3
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <DM7KR7J8VY2T.1CZIRUF6QRCWG@gmail.com>
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com> <DM7KR7J8VY2T.1CZIRUF6QRCWG@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 06:31 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> Overall this makes sense, I guess my one small nit is that since we've
> crossed the bridge on changing the compiler, we could just use a
> cleaner encoding of some new instruction

After a bit of back and forth... I think that's indeed a better path forward.
Especially, since three bugs that the bots found in patches 1-3 were there because r3 is
an ordinary register and JITs guess the meaning from the shape of the code.

>  - The verifier treats it exactly as JNE r3, 0, so no new verifier
>    semantics.

I suspect your bot was confused.
New jcond insn means that r3 is no longer used.
but we need new flavors of exit insn:

  exit          plain return
  unwind_exit   r0 = 0 and return to the pad of my return address

Otherwise plain 'exit' has to say something in some register for
the branch to look at, and a nounwind subprog called via callx has to
know about it.
The verifier needs one bit between exit of the callee and the next insn:

  cfg:
	unwind_goto has to follow a call or callx of a subprog
	and cannot be a jump target
  exit:
	unwound = false
  unwind_exit:
	reject in a callback and when insn after the call isn't unwind_goto
	unwound = true, r0 = 0
  call of a global subprog that has unwind_exit:
	explore the pad too
  unwind_goto: (probably most complex one...)
	goto unwound ? pad : next

JITs:

  unwind_goto:
	extable[n++] = { ret_addr -> pad }
  unwind_exit:
	my_ret_addr = bpf_unwind_target(my_ret_addr)
	epilogue

So patches 2 and 3 are no longer an optimization, but they are probably simpler (crunching...)
private stack has to be solved too... oh well.

> If we encode unwind exit as another jcond variant

hmm. cfg and liveness know JCOND as 'can jump, can fallthrough'.
unwind_exit is neither. BPF_EXIT with src_reg = 1 fits better
(more new insns... hmm)
unwind_goto is BPF_JCOND with src_reg = BPF_UNWIND_GOTO next to
BPF_MAY_GOTO.
3-ish new insns in total... progress?

> then you can get rid of the decl tag as well

Yes.

going to reject unwind_exit in async and exception callbacks.

patches tomorrow... bots are tired today ;)

