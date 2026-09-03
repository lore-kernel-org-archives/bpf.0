Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686ED4E2348
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449818; cv=none; b=pu/D9NiLf47yQjcVgMAuzOQH9nu9CsQLJKM0Hjq21ZEON/otBGU/g38ninpjnqLUuOzcQP2E4s7TOusVsCCviGvnLnlNxK/6SeWJqrYlNUG9Ljc690QLoQmG0S6lvgZ1TLXcAfUZEMltxN4FR1TV2LKNmqcJffRFzyte1zKctiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449818; c=relaxed/simple;
	bh=ocBgaR/p4mDc95EBHb/KEM0O7kuD3J+8uI2l8jWDVnk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eJ+BDyuJR8SEQM2AOa33ZVYQozfeE8Fw7taPkDVaEJuvic3hXghMEQ0ysY1uJo5e4YZ38lnyoLVjaGvpL/zWihda+3whUDD6+HLTq7h5zpvWDaBAh8BhGNj3gfPXkmKhc3fUruJM0jlpwLX2Wkj38vRM4Qcv1KoGpUVqOlQ1S3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkSz5nnk; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkSz5nnk"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so4776385e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788449815; x=1789054615; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=twZrxZ5m5jBOiPqNd4DyLEyatwFqOt/iSKjel+SkYfo=;
        b=RkSz5nnkEQNJySQBYoPQSx82Uga4dhCf7kmP08jIOPBXXGGUFB1owRhRFAI23Y8O+m
         f61cTob1dul1nX0ZVJJZBYp6Yx02QTiwPL86YeRvsR5LuLeLf75BSSgsk4GlbEQIfMv6
         na7fZT/Kv+Z756EZawaA3Ej/LdR3pkmY7coljAlUFoavwypu42VOLDHGeU15g04wvUaF
         Kso0VWeicsOwuvko0eGEaRJNcxSV4k9auHRErJ4DnSMCJl2D+J5A8aEzXY0aS2NpViVj
         skI8qR5R5vndZeKI+ilfAMzx+qhh3S5PgCyb8RCVgHMnQzMnPy2W6Wsp60VdiTaEANKx
         Twdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788449815; x=1789054615;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twZrxZ5m5jBOiPqNd4DyLEyatwFqOt/iSKjel+SkYfo=;
        b=laqYsQ8YLS+zICpFS9Dmq6/fP7JE4wkSxcFsnYVfkN9acJxH3WTdV/43xuVS85L/Kh
         pfDi5pupJDCt2XOo1cif8juC+wbuPnnBh4Z/2uGt3Ff7DYuwBol5jt0odzz2Nw2oKuhe
         BPphVSVsLzL4VeKKAGISnCXIoDS/Cyhz2+uM52IDM9HzookLRBfOMvwysclpgFj5Y95v
         hOgU7vT2M3dnROpxMYHawt+9aZIE3anlvaiq70ecoCCcjqWdZC2MzHcAKSXTV+LT+tXi
         NBWxx+nHvMF1qnRrYdxRsc9HUe/6RKckJLlozVR1Fy8PyLDaiZ9KZ2giF17pV2Pofnpn
         PClA==
X-Gm-Message-State: AFuF++khs1lxYTH9Bwuhjq4DK/0d6T6VLGJ6XWwUDyC9y2JluDiJrLLd
	eI7YK9CF/vH/hlnwd3WZBtnkOrxLJI2Zl1wX7PgmtnZQPhLRVFxVIpz7
X-Gm-Gg: AYBFou0mV9Brm7b97qGZ0KfcLYFDng+Vt89AgfLyWV1FpKTAnC0/lqZxGUwK9avSDAk
	HqyWLz5NTq3xIchycKYD5unWxtCX1k4hJz3NMNMyhWTo3PaIZjLHPDNvskgOnkQvlgLrEpBupyW
	ojyU24qYZy58fQgzdeCrlLJckf+yucgTLe00/hMSiG47U4DI+6I5e1qfd4dCrLL9HKOz43DEezn
	qkWKxu5GkLm+jwdrvV2Z40/hQL/qyWME9j2EnZmQoPt9LlEiF2cIhBywnQ8quWGX5pHLD70G5E1
	AJ9K5wPY0D2Nv7EdadPL4vo6bfSivnGqh8G06tVn6mJYWQ2L9xYDpd8exXg2BxKRPhfA9BZN/lU
	xZK05RMPkGoNWwVzCa3qbEdhf7qm6GOmrSOBXITZ1StDB6LMZ6NdEiTW7x7AGxqr3MjNbfyCBsY
	7PKrXvljeP89tMTrJouOWOZ1Jb8nDCDh8IbHNOTAHZR/t/mAv0PZSFc15AcdXpjuf2Hm23duBcm
	58aZofknaKkyyyQRNxhbezbby8X9z4cn9gTR/CTvUjXUYbbXi6K9WLifflMJrvI5koAMucMtP+E
	xGsJcciH6f4HQMaHXfRuMllMdqg=
X-Received: by 2002:a05:600c:4e8f:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49ce57f5647mr199325655e9.1.1788449815170;
        Thu, 03 Sep 2026 08:36:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm84653935e9.14.2026.09.03.08.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 17:36:54 +0200
Message-Id: <DL5SJQEFQ56S.26JAOHTQ8JXPY@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v1 03/10] bpf: Reject tail calls directly from
 callback frames
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260903144433.1716731-1-memxor@gmail.com>
 <20260903144433.1716731-4-memxor@gmail.com>
 <20260903152147.C0E241F00A3A@smtp.kernel.org>
In-Reply-To: <20260903152147.C0E241F00A3A@smtp.kernel.org>

On Thu Sep 3, 2026 at 5:21 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The patch prevents bpf_tail_call within a callback to fix the 'c=
allback unexpected regs' verifier bug, but misses that BPF_LD_ABS and BPF_L=
D_IND trigger the exact same bug via the same prepare_func_exit() path.
> --
>
> commit a25ccc5cdb72d9330414949c17ecac5156595510
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
>     bpf: Reject tail calls directly from callback frames
>
>     A tail call from a non-zero frame is modeled as a return from that fr=
ame,
>     synthesizing R0 and calling prepare_func_exit() for the taken branch.
>     When the current frame is a synchronous callback, prepare_func_exit()
>     enforces the callback return-value contract and marks R0 precise, tri=
ggering
>     the "callback unexpected regs" verifier warning during precision back=
tracking.
>     This patch rejects a tail call made directly by a callback before
>     constructing the inconsistent return state.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 7d8ddb1bee00c..f540279ff4abb 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11228,6 +11228,17 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>>  		if (env->cur_state->curframe) {
>>  			struct bpf_verifier_state *branch;
>>
>> +			/*
>> +			 * A taken tail call is modeled as a return from the current
>> +			 * frame. A callback frame cannot be left that way because
>> +			 * prepare_func_exit() would apply its return contract to the
>> +			 * unknown R0 synthesized below. Stack-depth validation rejects
>> +			 * this construct anyway.
>> +			 */
>> +			if (cur_func(env)->in_callback_fn) {
>> +				verbose(env, "cannot tail call within callback\n");
>> +				return -EINVAL;
>> +			}
>
> [Severity: High]
> This isn't a bug introduced by this patch, but doesn't BPF_LD_ABS inside =
a
> subprog trigger the exact same bug via the same prepare_func_exit() path?
>
> Looking at check_ld_abs() in kernel/bpf/verifier.c:
>
>     if (env->cur_state->curframe) {
>         struct bpf_verifier_state *branch;
>
>         mark_reg_scratched(env, BPF_REG_0);
>         branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, fals=
e);
>         if (IS_ERR(branch))
>             return PTR_ERR(branch);
>         mark_reg_known_zero(env, regs, BPF_REG_0);
>         err =3D prepare_func_exit(env, &env->insn_idx);
>         if (err)
>             return err;
>         env->insn_idx--;
>     }
>
> If a CAP_BPF user loads a SCHED_CLS program (where BPF_LD_ABS is allowed)=
,
> invokes bpf_loop(), passes PTR_TO_CTX through the stack to the callback_c=
tx
> argument, loads the context into R6 inside the callback, and executes
> BPF_LD_ABS, it appears check_ld_abs() will synthesize R0 and call
> prepare_func_exit().
>
> Since the callback frame lacks instruction history for R0, won't precisio=
n
> backtracking fail and hit the exact same "callback unexpected regs" verif=
ier
> warning? Does check_ld_abs() need a similar rejection for callbacks?
>

Has to be fixed separately.

>>  			mark_reg_scratched(env, BPF_REG_0);
>>  			branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false);
>>  			if (IS_ERR(branch))

