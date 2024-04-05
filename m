Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C601C6A8
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349213; cv=none; b=NoX1iDMu6MVeQXIbk96UFmOp1jNMVOnWJSxu0WugathEPHa0KxRhlO37qZS+yyjGaK7/n3rvDvSaVmtu0wt+KsOcXl5kBzuw1wQUmn9laX2aHIeYZ2ilOCVGvkQwdPqLWkT4Hk8nKeneARKUhYvInDIvEVftEr45P6/0WyEFOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349213; c=relaxed/simple;
	bh=JjhswvoS7BbGVkEFbjVkBBx6FkVvZ51PTWoTGrsAj2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6tmPsHnX6x2mRN4uz7m28QEKMhokdKz2XbdGyGeLYD6xNROBiqXSVt3wdesOoEY8nN7jgz848ZaQ5YJHJyHisj6538jPRi2TTvzL1so1JyLjcrOLFNj8EAgOA8axPctYAQX2GQ/N4bbD1ef2WbDgJkYcZoh1U5fUEtx4DuiGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVrWpbzJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVrWpbzJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1def3340682so24306795ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712349211; x=1712954011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6B61f3BhKqqA7cg6YojqpBZcxM4BZSOH+BKXMx7TkA=;
        b=IVrWpbzJQmf+X9LsUvxEscFPtJio+/SA7PUhW3IhsroiDN4mjcri87xjJsSrHLLFp3
         1DNsspXUrR00YkFJaluYJfdu6VObUuF39ehLXzffv1Yj9YkIBfoSg+1eQBuJeuroiI1S
         PuoKnHRyYuiF87ai8LHm6fDL7JrEK1qbEofwMobT1yj1E/8vhlwrqEp/hhVRTcuRd4TJ
         V5YnIngQSKGeSlOXRpPDQadfb/98hcDz5X+IGqICtuhosm/5sqcZDlSc/2MVi0DUeLnW
         p+O293i5E2XgG6w8xW1UtL+lE1tlQI8B9Jxb5XeYD1pfDysdz0EXYAxzdcOT1lWqiYmG
         qvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349211; x=1712954011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6B61f3BhKqqA7cg6YojqpBZcxM4BZSOH+BKXMx7TkA=;
        b=B0ZDMilyAl36iqoWCFwjbbzN8uys5Z0rypJax0H9S3csK2pGg/1v08K6q3VyRK+zsY
         gsgnIKkzPcGeBDvILtiA5ZMgGCIbZ6WuTPvz3aTs9GZjs5LLYkUU5uIXIX88JoquRyUh
         BWEWFuXbkAuqP1L0npXpxrcKmnP1mDm2kD26G4WYfPKvslAwTTvwZMKrLxioGvOK8uWQ
         /Oytokddz1CEnamUePjzCenoyYUbK+7k5g+AN1XLp3ovXJTG6BE+PsnUDe76r2cpnZer
         bBSWFIzxGmq8LOpn/FP/ww+QSuN+xRlcZMVKnZCjqNJdZUA+yP48ZX9PiaHRMomSyIQR
         9j0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyJTpMr1xRXpYTQqvjDXqHO1EzkmL2UQiMjIEGBFnPP5fXmZiISWuB50ykok45qjCpqHLYvyd+h3rWkQbgOKrZhCyV
X-Gm-Message-State: AOJu0YzTwAV+Iqm8+lxOyyCTDf6GVNge1/4yxVS74xzETnyhFnPE06JW
	DfeBIg3NMOA1QK4AduP2cxRYhujJjAYqTozMpn8Ntu2F6zs+C8HWMuT7W3jAoaNrl74ui89ziwx
	nk3o9ky2ilA4S68b0h4VBa4MbFiE=
X-Google-Smtp-Source: AGHT+IED5HGJwMCJFsee5azjWjqM0TaNJr9SFYyUEmrOjYMpS8vaRBsMg74pmO37kOHtmHV72iwBjFPfgIdBJaupJTY=
X-Received: by 2002:a17:902:d2ca:b0:1e2:a414:fe94 with SMTP id
 n10-20020a170902d2ca00b001e2a414fe94mr3136364plc.15.1712349211299; Fri, 05
 Apr 2024 13:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZL6dCZx8Mve1RYXRJ1JeA6xqZeYN0V4Jfr9Xg04vAZrg@mail.gmail.com>
 <20240405202607.4146642-1-tao.lyu@epfl.ch>
In-Reply-To: <20240405202607.4146642-1-tao.lyu@epfl.ch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 13:33:19 -0700
Message-ID: <CAEf4BzbpZQtiM-ruX-oO-6jth9ZhX5Sr5bTvRx8pNj+VEH3NfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix verifier error due to narrower scalar
 spill onto 64-bit spilled scalar slots
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	john.fastabend@gmail.com, mathias.payer@nebelwelt.net, 
	meng.xu.cs@uwaterloo.ca, sanidhya.kashyap@epfl.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:26=E2=80=AFPM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> When CAP_PERFMON and CAP_SYS_ADMIN (allow_ptr_leaks) are disabled,
> the verifier previously aimed to reject partial overwrite on an 8-byte st=
ack slot
> that contains a spilled pointer.
>
> However, it rejects all partial stack overwrites
> as long as the targeted stack slot is a spilled register in that cap sett=
ing,
> because it does not check if the stack slot is a spilled pointer.
>
> Finally, incomplete checks will result in the rejection of valid programs=
,
> which spill narrower scalar values onto scalar slots, as shown below.
>
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ( @ repro.bpf.c:679
> 0: (7a) *(u64 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8_w=3D1
> 1: (62) *(u32 *)(r10 -8) =3D 1
> attempt to corrupt spilled pointer on stack
> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0.
>
> Note that only when CAP_BPF or CAP_SYS_ADMIN are enabled,
> are 64-bit scalars stored onto stacks marked as spilled scalars.
>
> Thus, to reproduce this issue,
> we can only assign CAP_BPF capability to the test.
>
> However, the existing bpf selftest doesn't support setting specific caps.
>
> So, I modified the test_loader.c and some related header files to
> enabled set specific capabilities on a test with the following attributes=
:
>
> __msg_caps(msg)
> __failure_caps(caps)
> __success_caps(caps)
> __retval_caps(val)
>
> Here, caps can be any combination of capabilities, like "CAP_BPF | CAP_PE=
RFMON".
>
> Finally, the issue is fixed by checking the spilled register type of targ=
eted slots.
>
> Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled point=
er")
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>  kernel/bpf/verifier.c                         |   1 +
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |  13 ++
>  .../selftests/bpf/progs/verifier_spill_fill.c |  18 ++
>  tools/testing/selftests/bpf/test_loader.c     | 154 ++++++++++++++++--
>  4 files changed, 169 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 63749ad5ac6b..da575e295d53 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>          */
>         if (!env->allow_ptr_leaks &&
>             is_spilled_reg(&state->stack[spi]) &&
> +           !is_spilled_scalar_reg(&state->stack[spi]) &&
>             size !=3D BPF_REG_SIZE) {
>                 verbose(env, "attempt to corrupt spilled pointer on stack=
\n");
>                 return -EACCES;

ack for this part:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

but I'm not sure if we need all the *_caps logic for selftests just to
test this, tbh. I'll let other decide, though.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index fb2f5513e29e..b8dc0d73932f 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -2,6 +2,10 @@
>  #ifndef __BPF_MISC_H__
>  #define __BPF_MISC_H__
>

[...]
