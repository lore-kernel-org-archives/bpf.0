Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE08312807
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788586829; cv=none; b=As0w9ywxf1g+tzP6rapDeax1e7bOnypNhwjdEVMZBSNYihQgVdXfcHb6Usg9H06BH3Tr9gc5WRgKkZrCL/OLEFwkNY1ZRu1idy8NUODCZlsSL0H7NxwFFO90vOeaJrukWPkmYFmO9UIJAw/5ReLkCRAj8PHYzuhHQwUiJCrWAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788586829; c=relaxed/simple;
	bh=9El7wg6ZSMznEsNj+n/3mNmQc0Bv6NuSQNospm5QSvQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kQhdmBQ05nrdwZn+SmdegCIiC8PA/kEFrLj5eF1QCWqa6KPc/4dlH6bY1ETQT1uBp+ihRFBAq8OPYT5oi/2H5YV0li7fcXzp4gDhW2yodNeNhEE/iGZZLpPxCLgt1I4owrxA9uA3Wf/6mCw1yxC7hCNldFFZo1bhKHFT0jazvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8xWcSs1; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8xWcSs1"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso7604855e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 22:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788586826; x=1789191626; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pUcTum96Lc5QOUMZUXnpZvdog3vwS0ETpO6yRdQHjd0=;
        b=R8xWcSs1JhIVuG6fX7apuGmTVpRCvzgrmJ3KOATmpQ14wGhDaJzCFH6tDhI5BI1ZMu
         +4MU4gmrcBtF4YQVhi/wFDwJRrL0N8pcNzjzlJLJo5eXsHIHEPblHmY+2Vo50oirMDbT
         ilEpOKHaXqzHAX7mpIFwCewr7pApiCdvWELPJjnVozH+6AgtxKopBnu6UvhjNUNL7gGy
         Pu0C38+BR59x+ofIGyjeP+YdwqKCnb3Sm5H6omGIqjpniodsbeP8IWY5H1mRcse9w0gd
         2PI5ekDo+nLI9knmTe7AcAKiSfkPKkLz77RI5E6veNNoJSz0dUHUNwqWnn3uGwOBHedk
         90zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788586826; x=1789191626;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUcTum96Lc5QOUMZUXnpZvdog3vwS0ETpO6yRdQHjd0=;
        b=WDbBhgJ3lxxFZoIiNux6B9aLis8ocPwKLMXBVVpGt07LXw+zQya/5MDNLvaAmWmnXk
         bNdh/52ym6sjn6zQBAYkus2/+XFrrgvzfH8dBSk2jZ5nJhVf8I6ineWdkHtcUm6FhYK4
         iIKt/7YVRCRfF1pT/THHWHRNYebFc35sW+NPb3tMoBMgWqx62X6XnLKrI912Jo/vESL0
         7UCbl55EPeX8cmrDLIbdY1qpC/O7987FoeCChZMynxkc+JXtJmNeqvCNzMBktNQOOk0F
         qNbkszKf9fW52YFbCy1sAU4huN4DqwumeQCkFUsA3bGRPDdongc13aQHWi5/G86pcxZB
         wNeA==
X-Gm-Message-State: AFuF++kWAhxyJHApDg21MgPWLofcgG4k55J2QszCohEJJnSsrecM4WF+
	HrOOIeirK2+etQiGRsl3kHZoT9JoAL+0Qc29UgAw1W+cvGGx6MDSGNlkPX1Jzvtv
X-Gm-Gg: AYBFou0H4X30RPkUIiIDJChxzU6G7fNPwM+/eP+RMm4BCPGXzdlOPoThpXReyYzXszV
	6PCZg8ldG8AnGsrNeVDX8gRU2UcThWAkO3X+vAqr6J/ETZ1W50UlMfYCBavCvHC/Zfv/Bnfk8o1
	ChDPazgMkH39I4YnDJive0VTB2y8Wke5Cr+rjd1tPi8fvsmLLqN31IygN1erwvnHp+LPWnoOOhq
	e3ULJTAbKqOPyoZjGYpjJjOLlkwzwYXiX93EU4EG1r0SpITqCFazmTnXLSeoo8bGKZ1a4gTLOPe
	VoYQPd1wi8h+TlQlqlcS+f5uwRvgXdQ6OxWUf5CCkOLBQNQGGS9xW0fdiNWV5GOzys/mJ81n5RP
	s57oARMku8Ygx6sb44B74vh6okX01RCwJ2oOH7v3V4bIqd8/75UjU66zMjO6duEZ6dH5wQ18Nx7
	cbBO7d3apnyJiw0MHSgYEfEd1aqT77/2vR+Cpes/m2F3lxJgFs6D8o/xeu1vrggiDcfNdNLQaFf
	VT6ruKjjkw6Gey6laJYOQpi+AB9b8kRBQVAopUGkeKQ0qKPlYePoESpYaXtzes1sCL+Jokrmtvv
	qxW3SsbspizGvZ/UdmR0bzFbt6o=
X-Received: by 2002:a05:6000:40cc:b0:485:8393:215a with SMTP id ffacd0b85a97d-4858703f4bamr12185937f8f.5.1788586825891;
        Fri, 04 Sep 2026 22:40:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm11195211f8f.8.2026.09.04.22.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 22:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 07:40:25 +0200
Message-Id: <DL75449ZEZAS.1S6DO4MNH0ITV@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Verify global subprogs in each
 sleepability context
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260905051224.2325381-1-memxor@gmail.com>
 <20260905051224.2325381-2-memxor@gmail.com>
 <20260905053206.87C6E1F00A3D@smtp.kernel.org>
In-Reply-To: <20260905053206.87C6E1F00A3D@smtp.kernel.org>

On Sat Sep 5, 2026 at 7:32 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Global subprograms can bypass caller lock and reference balancin=
g by using bpf_tail_call(), leading to permanent resource leaks.
> --
>
> commit abbef478df8567a76eb64989bbf7f08c717afd13
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Verify global subprogs in each sleepability context
>
> This commit updates global subprogram verification to independently verif=
y
> each context (sleepable and non-sleepable) that calls it. This prevents
> non-sleepable callbacks from incorrectly treating the context as sleepabl=
e
> and allowing RCU-protected pointer misuse.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 5b51e7ee1a3f9..f759a020c8a5a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -9988,11 +9989,10 @@ static int check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>>  		if (env->log.level & BPF_LOG_LEVEL)
>>  			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
>>  				subprog, sub_name);
>> +		sub_aux->called[in_sleepable_context(env)] =3D true;
>
> [Severity: High]
> This is a pre-existing issue, but while reviewing the global subprogram
> execution context changes here, I noticed a potential resource leak
> related to tail calls.
>
> When a global subprogram is verified independently with a fresh verifier
> root in do_check_common():
>
> kernel/bpf/verifier.c:do_check_common() {
>         ...
>         state =3D kzalloc_obj(struct bpf_verifier_state, GFP_KERNEL_ACCOU=
NT);
>         ...
> }
>
> The new state starts with zero locks and references. If the global
> subprogram executes a bpf_tail_call(), check_resource_leak() inside the
> subprogram's verification will succeed.
>
> However, back in the caller's context in check_func_call(), the verifier
> seems to evaluate the call assuming it will return normally:
>
> kernel/bpf/verifier.c:check_func_call() {
>         if (bpf_subprog_is_global(env, subprog)) {
>                 ...
>                 if (env->subprog_info[subprog].might_throw) {
>                         branch =3D push_stack(...);
>                         return process_bpf_exit_full(env, NULL, true);
>                 }
>                 /* continue with next insn after call */
>                 return 0;
>         }
> }
>
> The caller check correctly handles divergence for might_throw, but
> appears to silently ignore has_tail_call for global subprograms. If a
> user program acquires a resource (e.g. bpf_rcu_read_lock) and then
> calls a global subprogram that performs a tail call, does this bypass
> the caller's resource cleanup and validations, permanently leaking the
> resource?

I don't think this report is valid. Even if a tail call happens in a global
subprog, it should still appear to return like a normal global subprog, and
the existing checks should ensure resource leak safety. More specifically,
the tail call will replace the global subprog frame, but not the one for th=
e
caller, so it should be fine. Throwing exceptions is different.
