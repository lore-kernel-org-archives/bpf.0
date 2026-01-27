Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999122F5A32
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557933; cv=pass; b=bIEALm2MW0aarwHUga2ynOtU6d3IKwquAkxCOhXG0KmEdYjF3rAP0oqUXcFySIMX7GllayC9UkftN6BVOh4w9K1hWOV6x86quiWKsJTBgZtXDpfShDJ6V3rJAymHUfrd8wfBSq9hPWXTqHxikPSQRjGyIPPt1+e2Elkg94mG2tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557933; c=relaxed/simple;
	bh=NhnT/ji7+oQRyOV0mWwJFQwLdEov06y+2OWQovcxYj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esjYh2rIHT1u4O2jMO7VuF2JqC1+6l0PeXN2Te1wGZuIvz3gBNJ1X3WAWuzTlFUU/WvhJo587Mf7bEcdg40RtxL7HNvzANaTrL6Z9QEsFmrpkf6QkVa1RhXlSp/fDsRN+AoNCfALdXSeCLrAzpDW+QYd4tv4UODh0yB0I1LSgdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j64eVFsn; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j64eVFsn"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43596062728so164643f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:52:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769557930; cv=none;
        d=google.com; s=arc-20240605;
        b=MbfadVu/Ap/fIu9taxRZotBeoARtGfxjkwuq3QR2z4Jtd9BBcz89mV4+6Rf64wUeLB
         TXLF8V/eu9N3rmA4AA3yg14bl5jZSKHaOow41TmD5pFHRFztHkHgtt1qvKf3Di6vFbla
         sBu203a6TQ8GItFclxIvlA0xoJwQdgkg8YyHAHVwqx+nHeajmFUXWcUtQqN3brxAiv/D
         FGdNJiCGvxgTN4xRyjcCANv0f4Z3oZf2pSLYHPc2a9gXqBaNonYuyZpMDZP3padzvj8+
         def9PbNYUaHCyeYKsCRv6Arjwk9Gvnf8t6VVc4GK7TAvL7s2P9zHcQXWOUSTCRaQUi4C
         0jCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y7DOQSWvnqGAxWKVxaZOP89CHlW7MaJa/JJ8QRTqFLk=;
        fh=HCvnn86q0evGxzdkauvOFHK+jUDtefgOolHlalBAnjs=;
        b=RxQwpIhhySQ9prosE1Xxoa20KBf+OJfHHB1zb5WjDwHWSH6B9lBLoGX5d8+N7CAFCF
         vbF+06gNfnk4zclISV40HuMqBEeIsrTzE2oiTjO4GFUMuxWfkZUFJXg2sgqn3jNeHrHs
         b3LGvNkZqNAlmjhEBQKQJp6Cve//SIA8JDvWO/wuWdwImmYNAJbKWBboDp4gbXM0DwiG
         LqVqlF4AfcQa3rJZlc23dvN98JptJZrZXUGK7+jVLIelANOSZynsjPWLq4fFN643bVsz
         rIB6RVQqKwY3HuRH+4vgSrNgPiDMn3qHd++yIeMSTS/ZTjRS8GRrn//cqS9Ea7FrHNTe
         MfRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769557930; x=1770162730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7DOQSWvnqGAxWKVxaZOP89CHlW7MaJa/JJ8QRTqFLk=;
        b=j64eVFsnb8AYVL7GBHwms/lH39EoJ4Da09H08klr89UPzko/ER7sYuvfku1FkBw4j1
         MYHKsMAWtz7tw5VAPbk5eVSYLBGx0RuzHy9i7WIGsoy7zN8XFwKvI3Oz+cO7l8/XI+5w
         hsb6VohoKH3TRFaF4H9ptjEUs0Y6ijl+eY+X+Dsv1LN6pxfuSXfoPcEGBM4IMMP8XyOU
         WhDHGS0l1156pZqTosQ90VpuBhSqp8bp45xIIFApGlPQdBV24vbkPpEizkURBoG+qHHg
         h6VPkxZrbiLuXJoCzo90jxH9MQCwQDNKcvKQKexggWjcHcN68LqF2rkpdRnqQH3jlYuJ
         GVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769557930; x=1770162730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7DOQSWvnqGAxWKVxaZOP89CHlW7MaJa/JJ8QRTqFLk=;
        b=G+kuTi3ptM/gIpXdP0eUQKTIxVU9OBfCPXZxGtlEVKOWw18Ym45Aoe5StSlV+e+D1P
         0gRNebQDWAm0jKcvAAfpmdvjEnOCim5pXGssPqFlRYBpRLsAh+xmfJNerhYrOyDvw+zb
         IQvIVcH4Feb7D6qBV9mjDckQkGjNfG9RH6BdXrOJwUzT9uItSTdFOaFRdumGPo8DPllU
         U/hBUwFf3H7U7wHP9vW8MZqW1BAfdzSeJJfe+grj4dqW10mVx1as63urreqzz4q4UoUn
         dG6UzgjL2igZnQe3Q5X1TxAKGcRq3xGqC5uW6hPpj+Pt0oK3jIyQ5TFFb2je3NG2mpN0
         wf7g==
X-Forwarded-Encrypted: i=1; AJvYcCVhz+pHocZa7yQNleOIKlR682hA3MXYkOu9r5pexYma2gGunEdhEZmQv7S9SFDCkQ0E7D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkdjat2XXV3ebg9sdyL7t7MA+G17bwtd23SSYBozRXi6UQAF+
	hocdHBBhHHLfuvcoFQ1M+cZs0JOeGqVAzuEOs0SZe8E5FmNW/Ar1dZ0rN7z3uWNJx6Eppa2ioHQ
	uyXNQMYGpn/QrCF1WZVcl9c9hj03h6kA=
X-Gm-Gg: AZuq6aLSmpWvFISFjrUHUCD/AoNQpoHpkf42mee1fxpWk0N5EQe2SsiZMVJ0TqmW27R
	yjq+1f8OW/FltzlFpe3dZECaIrPCudLKAf1djQsdrqVMg2SZ17/rEsXKVzVv3MSiYZS8xoHDxPJ
	4fpGRk4vgo1ePbFS378P2RWD+xfj9Q3pmMRIWyK61sKxZ/Hvm1UnoL0Z5qB6weLtGG5300Ug49g
	WGNrLcorKHsOrLPb+Y1T7uQiEpjV00HXRbso7kK9taoraGTJWk5jhJzreB6jxZUmB1Gg4zQv6wL
	fqKFb2699BFDFZQVkkYYTaaCv3aKcxI6jelWeQc=
X-Received: by 2002:a05:6000:2906:b0:425:7e33:b4a9 with SMTP id
 ffacd0b85a97d-435dcfda96bmr5438530f8f.0.1769557929737; Tue, 27 Jan 2026
 15:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127231414.359283-1-emil@etsalapatis.com> <85a0ec6ff812bfcd7e648a36edb28517817fe05a0b5b164d4b3c269d365e1562@mail.kernel.org>
 <DFZRULJI9RA6.EAYA8GNER4RY@etsalapatis.com>
In-Reply-To: <DFZRULJI9RA6.EAYA8GNER4RY@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Jan 2026 00:51:33 +0100
X-Gm-Features: AZwV_QhylpVHC7zK5_c9eWd-Dr2s3RFBJOlYZbaWntI0O8wQ7cME3vE7G0atiOw
Message-ID: <CAP01T77qJOdOVkqDORHULzsaGZ4cdsqoJS06Bf7FOWze2G5fPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow void return type for global subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	martin.lau@kernel.org, song@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 00:48, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Tue Jan 27, 2026 at 6:45 PM EST, bot+bpf-ci wrote:
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index c2f2650db9..2cc7404954 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >
> > [ ... ]
> >
> >> @@ -10875,7 +10898,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >>              subprog_aux(env, subprog)->called = true;
> >>              clear_caller_saved_regs(env, caller->regs);
> >>
> >> -            /* All global functions return a 64-bit SCALAR_VALUE */
> >> +            /* All non-void global functions return a 64-bit SCALAR_VALUE. */
> >>              mark_reg_unknown(env, caller->regs, BPF_REG_0);
> >>              caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> >
> > The comment was updated to say "non-void" but mark_reg_unknown() is still
> > called unconditionally for all global functions.  Should this skip marking
> > R0 as SCALAR_VALUE when the callee is a void function?
> >
> > As written, after calling a void global function, R0 is marked as a valid
> > scalar that the caller can use, even though the callee never set it.
> >
> > The new subprog_is_void() helper is used in check_return_code() to bypass
> > the R0 validation at the callee's exit, but check_func_call() does not use
> > it to avoid marking R0 at the call site.
> >
> > Something like this might be needed here:
> >
> >     if (!subprog_is_void(env, subprog)) {

I would also change the name of this function to something like
"subprog_returns_void".

> >         mark_reg_unknown(env, caller->regs, BPF_REG_0);
> >         caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> >     }
> >
>
> The comment update is inaccurate, will undo the change.
>
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21418326339
> >
> > AI-authorship-score: low
> > AI-authorship-explanation: The code follows standard kernel conventions with appropriate use of existing patterns and helper functions, showing familiarity with the BPF verifier internals.
> > issues-found: 1
> > issue-severity-score: medium
> > issue-severity-explanation: The verifier incorrectly marks R0 as a valid scalar after calling a void global function, allowing programs to use an undefined value, though it does not directly cause crashes or security issues.
>
