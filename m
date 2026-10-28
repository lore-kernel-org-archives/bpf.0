Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793149510;
	b=msz/81mGOopf6Z7PH92ZhADU85lcodqCbbbVdCVNnnbeLNH1gXG9W5N0AIyDjX4G2a0d
	 3KxXpBmP7/Dz0/tvCYfbt1B4Z7599XfS2sNdLMkewE3d+epV6EvBJ9de4+tVJREJP/Kny
	 DZXV7a18jSmc5q1VrSUKY8RgD+98a55dJWhxSlRPQaja/sn8wMqG7JuJshPVSIhhs4+M0
	 rDVesTYORrIUY4tuWLcIUv3Khdvj/4L+96+5huUADLuaIe/TMjDZvnHtaRgyXBStUV2dX
	 vYTDGbZpXSZdRUNROA+jIxGL0bzzinzieQpK9M2p603S9fFLFMxtPT0zTf1ei3mdd5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=f2rE3NDE9kGP6isczzJJL2zdizHNny9LG2ue9EGEuV0=;
	b=xgiE5Kc8oAcz3j7lKwtbJcnRSvI3h26wpWl3763FL4hmhu5KBs/nSwlZgH1uyHkvKNck
	 xjifrOtcmnQyNxsYjC+SGgcwSAylTP+nq0MseY7Q7jnX10aArxbn1+W6nw66NhH7ecu/r
	 Y1GVNCCeEcWuddOaEmwaBQB9mtVE0WLDeracFUEEc7AJux901M3fboHuaUFdTBEHLbJYg
	 uDYYK28mxaDQKXrlOEpQhFEQaAkMPu7oU73uTg9nUOdqMdoL2/q0zUIDni2emLeOim7K7
	 Yg3iGsZvVpMIrl5PFIcN4mHaxNPCnjZ4cXw4MhRdkSvv3AtYJMCwuqARC5gY608SP8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Es9PJrky;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C511606A327
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C511606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Es9PJrky
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so1612125e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793149509; cv=none;
        d=google.com; s=arc-20260327;
        b=TrPd/X2uhMtAUZHIPQgVfUzMrb7+yKq6gycv6UKzYJezSg8B5PMzIFhgWyaQo6qrbE
         uzjdqai8AFQmeCKnbNLFSw60UK7dqLnXy51C1G2xAc4ByYaLQrsYuNPzFW3KTsfbltIy
         qVvxzhfKFici4ii6TMqQ+IotBcHtsgfi42SpbStMDxXhbQ4WOWp2BUv6QzMfZstD+UEn
         vDm8M8pAI4ChiPyXAWlzDctLyZ8ve9oHbKIgCg3szI+kVm9ZvfeTsGM/syrjPXt+wm3j
         f4w8+5KQYluwEm3GYuVVU1XGnv0y9VZ2YP+0HdrxmrUM1hTgLY2GinkEnTs1zcvC7O+3
         BUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2rE3NDE9kGP6isczzJJL2zdizHNny9LG2ue9EGEuV0=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=dHlQkZovlhCFzAN+8tgqKrAkkGrVgvL04vAF4FVTc/q4LtCtrezlfZwg/85epbSlTV
         E9kTAKBHxD6Jd/nzvlQYqEQ1nBTXbfRfRhWgw7Tboonnuu8HWrOb79YCV5OowsXOl7YP
         nF6++DRZN2onhTpJtdOpYNTERE06dV9eh1xk30JEydQwlwMbBF0863zDV3JP5y9H170V
         G6gIN8a23pPR9QSxxgyxVmEeDSqZI0UBxx/sJPQBb+uBCKoaqm1BtteF6yx6E08MRVNT
         x4/ARDwhs6hHdE5eQHhhl3VOufgKFO214FazAlhQOE88RavUvGVnuZu8DkFa1MkfMFfx
         Qf7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793149509; x=1793754309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2rE3NDE9kGP6isczzJJL2zdizHNny9LG2ue9EGEuV0=;
        b=Es9PJrkyKHFZ5cY09DjdoOcqBCZY7hHy+RkttWYJoKa9e+h6nz+tizXymwm1iBN6eG
         Bg0cdhu6LnU2xgwXS7fFE2XbgECl6I2Vt7yPOdsENeXPdmhgIh6WAWpLqGbiBSw9gYjJ
         lP3mPr8f10YJ69UcrllGKWqa+X1XekPFQEEStiUdtQBLCHLZlAGKZmo81kptmiA+QbdM
         R6G/TLiCQiL0CHcWe3x8K+T1CA0saECuShQOI5XwwXOKkUs4gAu2L5q7WTjZ2aWnArCt
         QUR0V0hwXFQA3hAlIMZuir0fFpP2PyHFi8wCM2uCGElqn8d3xTWhQfFYyCUg8lMGcCa1
         Gp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793149509; x=1793754309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2rE3NDE9kGP6isczzJJL2zdizHNny9LG2ue9EGEuV0=;
        b=gSECbLvMo5IZWdvQB4f9kfxJh2I6UQCFfc39I+tjAh4yAPVwIv9wArsHSFazbvh7fk
         MIlDbFTCVI5VuPDkYf8Q/iQlkw4PtUFJZISz7csT/zGDXYzOY/JsUudq7+KoiWIH/iQm
         HfEKyd50pi4lrBNhOJR292twppZb0ttMH+Qt0WxsuRoSjbM/hN3QNJhbw6mhSoIrhMA9
         3a1TNzV9rU4aNH+xIInZiY8hTynp8wwdna04BFC7vR9xJOm+1yF2tQIKODKgnp9CmnOe
         HFWQb+UhIToDQoDnvdFUyJVC+75LmSZ3qvpWglmCon2Z2WA7AiF5LyE30Vhkiqwl3TCO
         UBtA==
X-Gm-Message-State: AFq9FYJMWgl3aDKS03d2mpwn9djQG0d1W34rdCaADjFLDRiUCyZ99Uwn
	EsBU/ghOQWbvKZy7LAXsV5L/hy8cmbXYTjfAmO9kWUoOCOASllTKRXxWSigDVvDv+RfL2d1r7lG
	Pd4jIIyueO2YMLb+8oHPgIF7sFM40Jv6jKaip
X-Gm-Gg: AYBFou0LVNRQ8WsTDwv2uErJX7U6TA1yndMVN+vLhER+R9oqT8a35jow+sXbboBZ+C1
	nVztiIxBrX/aTMCbXJtmtW9Ja1kR3yGZzzkDAcWbqBjZIubwZQcQR2WOGLcGlQTzh9weX4ppjhA
	Z6MUZZhegZSVb0ouUTwCvBJs7jdHmgE2LlGo7mxOy8drCRILt7rJY+LuLjvqFwuDRlcycRZJZYn
	d2xfHIQD66VPDqG+TuFdcHSLvRcG56jcF9NjM8iajtPX01hYOZPMBNPJoKM6Ss3GenxE7u83G1H
	RFo9cYH9+A1mtkxJOId1H1ZxX9y5bWFQxe8o+QNN/DvE1DP23zP0INvUJD0RU21/+3jEX4Bqqhu
	Iuezh+PhkBPDTpO15m1Uo7wsP9zDvrG/NPqFg3JXIk8YvTzlgbqixrXK4C1NO5urDa+YjMxj50B
	sIi5WaGtqmHugmSJhdm88BRTLv+dlWR+WkezF3j4BRvJM1x8MU1fmTh6GVFQIxMZbv9TGWJS8Iv
	8GnRcg2mSR7Q8gNmA==
X-Received: by 2002:a05:600c:3516:b0:4a8:cb23:f71b with SMTP id
 5b1f17b1804b1-4a966c4175cmr14124645e9.18.1793149508615; Tue, 27 Oct 2026
 18:05:08 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793147364.git.memxor@gmail.com> <98e3a499d89e01ddfb83fcf91e34b2a0e36e1007.1793147364.git.memxor@gmail.com>
 <sashiko-outbox-187297@kernel.org>
In-Reply-To: <sashiko-outbox-187297@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Oct 2026 02:04:30 +0100
X-Gm-Features: AclHuK95I9JL3fStnIQS-CsCNB98uLDQyIp3GOawxHVoMRxm7qYeaDFYr7zdMS8
Message-ID: <CAP01T74tsmsPD=PKVKZkvWVfV=mnKw5SbcPJ9-Npu+NK3J2mzA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 08/11] bpf: Let the callback of
 bpf_user_ringbuf_drain unwind
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026 at 02:01, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] bpf: missing callback dynptr invalidation on bpf_user_ringbu=
f_drain() unwind
> --
>
> commit 5e41f31a219e475ec387e971ce587d69bc948017
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Let the callback of bpf_user_ringbuf_drain unwind
>
> This commit adds an unwind pad to bpf_user_ringbuf_drain() so that its
> callback can exit via unwind_exit while releasing the sample, clearing th=
e
> busy bit, and queuing any pending wakeup. It also adds
> BPF_FUNC_user_ringbuf_drain to helper_has_cb_pad() in the verifier.
>
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index 447863ece26a3..fdd997f36f73d 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> [ ... ]
> > @@ -852,8 +854,23 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map =
*, map,
> >               }
> >
> >               bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0=
, size);
> > -             ret =3D callback((uintptr_t)&dynptr, (uintptr_t)callback_=
ctx, 0, 0, 0);
> > +             bpf_call_cb(callback, &dynptr, callback_ctx, 0, 0, 0, ret=
, unwound_at);
> > +             if (0) {
> > +unwound_at:
> > +                     /*
> > +                      * The callback left with unwind_exit. The sample=
 is
> > +                      * consumed and counted like after a return, so t=
hat
> > +                      * the wakeup below is sent for it, and the helpe=
r
> > +                      * leaves through the door below, as the error pa=
ths
> > +                      * do, with the r0 of the callback.
> > +                      */
> > +                     unwound =3D true;
> > +             }
> >               __bpf_user_ringbuf_sample_release(rb, size, flags);
> > +             if (unwound) {
> > +                     samples++;
> > +                     goto schedule_work_return;
> > +             }
> >       }
> >       ret =3D samples - discarded_samples;
> >
> > @@ -867,6 +884,8 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *=
, map,
> >               irq_work_queue(&rb->work);
> >       else if (!(flags & BPF_RB_NO_WAKEUP) && samples > 0)
> >               irq_work_queue(&rb->work);
> > +     if (unwound)
> > +             bpf_unwind_leave();
> >       return ret;
> >  }
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3c39cc0f358a1..fd63ff36eb909 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11409,6 +11409,7 @@ static bool helper_has_cb_pad(enum bpf_func_id =
func_id)
> >       case BPF_FUNC_loop:
> >       case BPF_FUNC_for_each_map_elem:
> >       case BPF_FUNC_find_vma:
> > +     case BPF_FUNC_user_ringbuf_drain:
> >               return true;
>
> [Severity: Critical]
> Can a callback for bpf_user_ringbuf_drain() smuggle its R1 dynptr (or a
> slice derived from it via bpf_dynptr_data() or bpf_dynptr_slice()) out to
> the caller's unwind pad in R0 when exiting via unwind_exit?
>
> In bpf_user_ringbuf_drain(), struct bpf_dynptr_kern dynptr lives on the
> C stack frame of bpf_user_ringbuf_drain(). When the callback exits via
> unwind_exit and jumps to unwound_at, bpf_user_ringbuf_drain() releases th=
e
> sample with __bpf_user_ringbuf_sample_release(), clears rb->busy, and
> returns ret (the callback's R0) to the caller's unwind pad after its stac=
k
> frame is popped.
>
> In the verifier, set_user_ringbuf_callback_state() initializes the
> callback's R1 using mark_dynptr_cb_reg(), which sets R1 to
> CONST_PTR_TO_DYNPTR with a fresh id that is not backed by a STACK_DYNPTR
> slot in the callee's BPF stack:
>
> kernel/bpf/verifier.c:set_user_ringbuf_callback_state() {
>         ...
>         bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
>         mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE=
_LOCAL);
>         callee->regs[BPF_REG_2] =3D caller->regs[BPF_REG_3];
>         ...
> }
>
> When the callback executes unwind_exit, prepare_func_exit() only rejects
> PTR_TO_STACK in R0, copies callee->regs[BPF_REG_0] into
> caller->regs[BPF_REG_0], and calls destroy_dynptrs_in_stack_slots(), whic=
h
> only invalidates STACK_DYNPTR slots in the callee's stack frame:
>
> kernel/bpf/verifier.c:prepare_func_exit() {
>         ...
>                         caller->regs[regno] =3D callee->regs[regno];
>                         bpf_diag_mod_end(env);
>                 }
>         }
>
>         /* Invalidate callee-local dynptrs and their slices before the fr=
ame goes away. */
>         err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
>                                              callee->allocated_stack / BP=
F_REG_SIZE - 1);
>         ...
> }
>
> On the revisit of BPF_FUNC_user_ringbuf_drain in check_helper_call(),
> unwound_r0 is preserved across caller-saved register scrubbing without
> invalidating the callback's dynptr id:
>
> kernel/bpf/verifier.c:check_helper_call() {
>         ...
>         if (env->cur_state->unwound) {
>                 regs[BPF_REG_0] =3D unwound_r0;
>                 goto unwound;
>         }
>         ...
> }
>
> Wouldn't this leave the caller's unwind pad with a live CONST_PTR_TO_DYNP=
TR
> pointing to the popped C stack frame of bpf_user_ringbuf_drain(), or a li=
ve
> PTR_TO_MEM slice pointing to the already-released user ringbuf sample?

Known bug which Ihor is already fixing.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.=
git.memxor@gmail.com?part=3D8
