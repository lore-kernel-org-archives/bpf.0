Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796336BCC4
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216726; cv=pass; b=X4iWv5hD95IDvuV7JeWZqhEj2oR1GvNV0WmpmXNBOvqAZ+FnKSWqevmV7k4FHRdQT7cKIj2y4oG8rH8Ni8pKyQsRtUGMfwZ7rc9LMmrWIM/Nnzq7UC5QcMFjl0K24Ez0HGv4IfeA0EhKw2UAR72pHT1SIUGnPXzWmf46Aqs5qag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216726; c=relaxed/simple;
	bh=J1DOYXoQ50Kqq50Ha0/7M1Dv6M3XMd7yir8gTRFgKNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyfxWdo9kyV4pkMlT0wQR12mYle3LrFhgl5f8v+OZU63AcJPE2KnL+6KKFrLT6Nsi90duKv2VwvYAQmWB5pdgG9IBgcKBrlGirMhw1RXiYuMl9TO1xBiuMoPh704SzXi/A0MRhuoRnkCMxCJNfGLh3WOUFaqGk45P2B+gsXZjBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZKH10Rt; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZKH10Rt"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bf14e33f5bso34683437b3.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216724; cv=none;
        d=google.com; s=arc-20240605;
        b=KuuWvVpZ0W8kenGTQ+6xtYLxj8Q4aWRQ5PIZQPxlSve7L8rm+8PF2pttDj6yzj1ER5
         BPkK3wELZUm8ch3zDmpQLoTi1IC6+tJzuy1VRsrVmwbgJlQaQ7GZQYkOqIX2SZTXa25p
         if1zt+OvRkpY21rcvZ4tYJcPZQ2R/6xXR446m0l1ws/g8lXqqfmOn03dkCPPq7l9iWGh
         FIMeJ9ODPfKZqxmlXVmqYYGejg/xuppTTlp1McLSSh00edN0mAczJR8BrLR680DavvX7
         AWFxhK7rFmwRkMr1RA1yYvtyu+BlZg80+SyUrufNRvm2t/2PRnI5Nunw8XIdSC7e14DK
         hyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y0v4eEHup7uWRxuJ488zQzWFOVLc6XJagBWSyDGtp2A=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=UbFfHYbTlv8PAmDZ+gcV+bhYcHSbPqgBReyw555ALOv020FDkm5dTaukHEKhmNhezl
         DCz3AFmJPqTKUZLBuate9QnOC1tKokclwz5YgUvBd9EpMNfLRbqJkb+KqzbmeWAYJs8C
         ZXs5vsROnciro5mZf/TwI787/hZdftSP9MGQr73MAwyyGIaAb5/I0qMuoQ9JqTD9FE6m
         d7zuyYj9SghoXKOJmMIFre9+h47ylM991K0hIumqcQ+L6toT1gBAq9TSq87IoYtX7Ar8
         PccHmEMRMWGJ2Qut9BLQbQOxzs0EJ5ogYoTDUL4eTiLWwb01VOTfL/4nkl24HSJRKBUg
         tGpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216724; x=1779821524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0v4eEHup7uWRxuJ488zQzWFOVLc6XJagBWSyDGtp2A=;
        b=PZKH10Rta1Nxk6VZOfXryByHGePzcMCUCmqh9PK3sjGp3Cmx3VJZGV8sv4sBa4BgWB
         4DuQA5ewLHDn33CslDe5S7QoBib33Io3vL1PAq10MpOU47aOJ33hGx/VEws531anQv1R
         xFL2G5I9OEA0a0nwxqQmN9r21bjnQu8LIzs5oGbg6C7AjD43dDrQhXGJf1/7MVLv06LG
         ROCaYfiUSz8UjM18hKE0sV/Ul5kmMFQGcOARTRpgvMPI8Lrp1F2Txjs78Gn8CPA+J0ou
         TjuVYSd7FQYXAedzw4yZr6WDcDFRrNui+fx634MUCX54Euz2zNqgFPXeLcgWcRjcOlha
         qSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216724; x=1779821524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0v4eEHup7uWRxuJ488zQzWFOVLc6XJagBWSyDGtp2A=;
        b=myjjfdlYjHDLt9VlG6QfUbrf1KnLoB00H2vjmRNb9fFpcdSO/M724K/3SStAonIRac
         +IQSqQm0GTIJeiA9CWwIm5D/Zb5sHGzSb3pSkS+4TVRmQ+VkeVLq/PmI8gsnAB/YbTE8
         1a6l5CXg2MKmMbChxHZ0zKI44BGz7Be5LvkaG+ZykIW/HU4kDTbPKaN+bS32vVJ6na0f
         tLPqXXmTtssjk2b5DeyYUC3zSQ2fu1LFe5LKEm/kjbVcx1Ipg2nMx7f2hPbEMykSNtPF
         GYOyrnYriV2QUP5Euhj7aQ55z9luDiZbtkOZExJA36pLJZdBJoj7UJjndEGrWRySs7/o
         MRyQ==
X-Gm-Message-State: AOJu0Yxnx2A9qS+P7UfGQtqucn3qCfFtYhVrDmrMk3VMjnnBqlvytHAz
	HaxklMk7oIoRHCic24krp4/lrQ0Zx7PTWzC4GaRQTw7aFVnz42IqGT4E7Fc4Mr3i+/RoM79OQO7
	HfpUcS048ZKpmnTbB3/uSti5pz4ZZhUqjjt4h
X-Gm-Gg: Acq92OFk5TwpZmHYjXOKhIWyjNqfAWzPVPJnWE9vVVbvtdXaKPuEmGn/5U6W+jvSfE1
	l2yZUwmSJrA1EfhU00/7IrYf9twoISIHRZag4y+p+jfP6aWTVBFW2U7sW7nFwvkyCJyWphjyX6F
	isp/Kp+nqUrNQnpOjquXkK5gFihfjoTt7UDS5HprqEByeKKnCWvf3AfOKMVPWC1WY3pIMGhMkjD
	77m4mQ1wGaC2s4fwLHqgE4Ndg573os/Z+b8sGmHWec/YyHiq305e30azHIDLa4oQvgoK6YSx5z7
	lc3+4D/o2ezJiaQYeuWl
X-Received: by 2002:a05:690c:3489:b0:7b2:aabd:535b with SMTP id
 00721157ae682-7c95b8275bemr231881707b3.27.1779216723881; Tue, 19 May 2026
 11:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-6-ameryhung@gmail.com> <20260519184538.7A705C2BCB3@smtp.kernel.org>
In-Reply-To: <20260519184538.7A705C2BCB3@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 19 May 2026 11:51:50 -0700
X-Gm-Features: AVHnY4LJJTANE2G-zMmaNS4BPCZbX4vvoaum5PSGvKO3Cw88Pb5PYzIt-gsbh4E
Message-ID: <CAMB2axNDfA_M4bss4obQOMi0y6a99kFVUECeWhs_uyaWm7Yeug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 05/14] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:45=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Incorrect indexing of `__state->stack` for outgoing stack ar=
guments in the `bpf_for_each_reg_in_vstate_mask` macro leads to out-of-boun=
ds heap access and potential memory corruption.
> --
>
> commit 936dee8aae85e40857f1379da85e7a73536e2261
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Refactor object relationship tracking and fix dynptr UAF bug
>
> This commit refactors object relationship tracking in the verifier and fi=
xes
> a dynptr use-after-free bug where file/skb dynptrs are not invalidated wh=
en
> the parent referenced object is freed.
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 2cb4c7b0eab68..d83b9fbfef7f0 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>
> [ ... ]
>
> > @@ -585,7 +591,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func=
_state *frame)
> >            iter < frame->out_stack_arg_cnt;                          \
> >            iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame))
> >
> > -#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask,=
 __expr)   \
> > +#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __stack=
, __mask, __expr)   \
> >       ({                                                               =
\
> >               struct bpf_verifier_state *___vstate =3D __vst;          =
  \
> >               int ___i, ___j;                                          =
\
>
> [ ... ]
>
> > @@ -600,19 +607,26 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_fu=
nc_state *frame)
> >                       bpf_for_each_spilled_reg(___j, __state, __reg, __=
mask) { \
> >                               if (!__reg)                              =
\
> >                                       continue;                        =
\
> > +                             __stack =3D &__state->stack[___j];       =
  \
> >                               (void)(__expr);                          =
\
> >                       }                                                =
\
> >                       bpf_for_each_spilled_stack_arg(___j, __state, __r=
eg) { \
> >                               if (!__reg)                              =
\
> >                                       continue;                        =
\
> > +                             __stack =3D &__state->stack[___j];       =
  \
>
> [Severity: Critical]
> Is it safe to index the stack array using the out_stack_arg_cnt index her=
e?
>
> In the bpf_for_each_spilled_stack_arg loop, ___j represents the index int=
o
> the stack_arg_regs array, which is bounded by out_stack_arg_cnt. However,
> this line sets __stack =3D &__state->stack[___j], which indexes the local
> function stack array (bounded by allocated_stack / BPF_REG_SIZE).
>
> Since a BPF program can push stack arguments without allocating a local
> stack, ___j might exceed the local stack size, computing an out-of-bounds
> pointer.
>
> When release_reference() iterates over these registers, it evaluates
> stack->slot_type[BPF_REG_SIZE - 1], which reads out-of-bounds memory.
> If this memory coincidentally contains the value for STACK_DYNPTR (2),
> could this result in invalidate_dynptr() being called erroneously,
> writing STACK_INVALID across multiple slots and corrupting adjacent
> kernel memory?

Right. I should set __stack to NULL in for stack args.

>
> >                               (void)(__expr);                          =
\
> >                       }                                                =
\
> >               }                                                        =
\
> >       })
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519181314.27=
31658-1-ameryhung@gmail.com?part=3D5
