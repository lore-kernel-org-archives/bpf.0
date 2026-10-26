Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039546;
	b=nux/LwGU+lGMfa5vdFQMcxJktpE4cmzKgjpaYUTddrO80Nl14TAuUmAudtD+t6UGIeyP
	 K7UZWKXv+jDY2ZSqXJOhBtFOabnwPZKdfD8skhm2oLIGLDQhTCbI/+TnSx7LzdKq/X4Xw
	 nMUJeOppl/0LX5oytN0JfgQQ1bP2nTNpqU1W7loB5JmdmHxgS8nPEe6zKB9uah4KDhAhw
	 wU25sVz9fzY4n9iqaxHXKkGvb2nJxPAzlUCbuoMXf9EG/hGXasHJmFEnrUqF3Z8vzRpSF
	 IAV5rGPC5XPYcCFDkBvXCh0qAGeKzzKz7BGH4/Ixv8FQg/XT44BDGeDFoNc+n0F3S6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=A2ceJOVrwLdd04NqlH5CyVHqGflEc7kitJHPPr/+CZg=;
	b=UMMdwiWLVErS49CN8X8vai+MD/p/XFZuuHzDwl9PhGZbeLVPKrTtU9pLSVCFifRZ2Gsq
	 JvITrGqefeMe8IGDma1SflD4SBlSNR19HwQv8LepKsW6YoydCR5DS9OmEqOrrUTpduc8A
	 T++fARO1/HEAeqNl2ldSVbueTDQTxZcpQJW6h/wrmfsYPrgVDLQeIcPRkBt0CpWzHPmug
	 I0QOMZR/IztN/QO8dDU0u3dILlZuhTrvFkMfWfyN97NJJ8HJOqm5pWNIfsPitnW93Nsch
	 vbLjoN3/eVs7ppS8RVBHqwHQIpgXf+R59S0+xE+CA6ermWSm+xbTicHA9I1X0phTcsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="sfWy/wUT";
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBE606A324
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 18:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90BBE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sfWy/wUT
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1587371a91.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793039546; x=1793644346; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A2ceJOVrwLdd04NqlH5CyVHqGflEc7kitJHPPr/+CZg=;
        b=sfWy/wUT4iIa7EzwWMS85fozkBR423AZtGP2lMC/KSH4O93w1UR9X4Q0+ad1bEF0v9
         JOYRQgMvYvx1GpTBS6yuqSyx4I6N79rhKV5QjOZqOXKe6+201+FNoGxY/DWy+KyUX+Ki
         BUyF5HZpQqUr84tO4JoVMdJGhX1nZyw74AnBnLzV/K/iN8LqTgiugvboZBXWevUJIfI9
         3DmZcguTPDCzOcTaG2AyQ0rDUntMHUpH4IkkKJ7zrndfRRIY7iFVFpVoVveS99SeyapB
         zpDrTp5X8Jx5tqNgbh8yTF0jy+m4dMub+mbjdP9qLmG8Ao7hto6jk+AKs7J8AwzM3nJn
         xLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039546; x=1793644346;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2ceJOVrwLdd04NqlH5CyVHqGflEc7kitJHPPr/+CZg=;
        b=09sKmCUyYlJv/FkUqMYopMQOP/+XF5EZs8NI58AfE6kStsIDn8biPBVmD2ImeLXbMF
         7taJNcCAWNA4dzeswe+1SU2HPHdj8qeokpMyUhMVjBoTYXSUPsY9Gv475DmAvC/tORfv
         W1Tk2n9XzYeTiZSQ6mbgglHFqAxn1pdu2nQliJ7VJEhvmdLtnENzhuQGNBGzDuWEQ3ux
         f7wRwhLAg7Cfd7Rf9Yp/YRcSu8JXJgFgFREn8uvZDS3h7KteehzjM7/NLNbwH89peLoV
         w9UUrFmNborz6H0SvGMswIgPRLPZKoTjhzfzV2zGNhD2UuO8lNZQIot3YfRROsPbEBLK
         BaEw==
X-Forwarded-Encrypted: i=1; AKwUvBzfFxqPRiD6eP01t2p3bI9Ogv1WnGlhL8Ty9vjKScGW7Hy1ZCqNr/1y4UF0GHWInR0E7Ck=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHMvK1hVfyQDA+TaDqnjaK1Tj1U4Gzlpe+35/Tluk5ymR3JPsU
	oT6wJzdsjpvNwaDOTmecD8QzAHnpMRlXUsbFPS/rUyNqSn3BdjKq+urn
X-Gm-Gg: AYBFou1K/HTmwMg51VtV+tIhSpowLBRwd+vzgjZB8d8+5TNrm3Y932O6VkxOCtz6h4Q
	bxDtugt6V4wRHaGWuEtfnTWiAdOimUeUjJvb8YIZF9k0p3NhfqsCIURRLNZiRThbKA1gNLdEyYY
	N0XDxsaTGkg8qtccygmlR43EnQWgWZPpv8YCKJw+qounPlfzF/TXh4JsV90cBu0w9tlJORWjdBs
	opABdj5TrFaCLJQHOG+FRXpFEk1HZUTbeUQPGAMzQd67Tru48wWsWlI3Bs7yXxg3sFkMQSaYEgO
	MR7KfBuxQVAdx7V4x7Zdz969ED1kiZNbC60e8VuEN6PtBrF2QpD59hm0lPPPRmDV/7BEsPxaJRj
	j3F5wjFIR1nYqodHyoy9a0+shKmiWUXBgJMR+FQwC7o8ksmCPIh/uHPdaFNPF0eHUx7dXvG45Hq
	tkg/JDRUjlzqdE6qXlBSfVBMY8UbrZIZG+omeawikBryFUnvwFzFXEetTZoaupq2D7Hqv/35BYj
	wrzb3etPyaSvi3lcWyCg3hebG8jHSRAOUU6oJF1blSyAovDOsC+U8grLD1t02J1tXaqKNZPuiJY
	pfnPivYf
X-Received: by 2002:a17:90b:180d:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3adead2fe65mr7438461a91.22.1793039545700;
        Mon, 26 Oct 2026 11:32:25 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40451f4bsm500596a91.10.2026.10.26.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:32:24 -0700 (PDT)
Message-ID: <dc27fabc3f3c7d862c3f2ae583a3650a4d48804d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/11] bpf: do not intersect with current
 register range on clamp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bot+bpf-ci@kernel.org,  bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>, Martin KaFai Lau	 <martin.lau@kernel.org>, Chris
 Mason <mason@kernel.org>, Ihor Solodrai	 <ihor.solodrai@linux.dev>
Date: Mon, 26 Oct 2026 11:32:20 -0700
In-Reply-To: <CAADnVQLgRWzEnAPJQ7FWZOYWEqYeGaWqQXEvitNaVw8w6oq_3w@mail.gmail.com>
References: <20261023-scev-simpler-clamp-v1-2-d43a07eda7af@gmail.com>
	 <8443794e24eae423d0f499a1d2f24576aa5bb70f6e5f6e015914cb0d1a72210a@mail.kernel.org>
	 <4656dc2d7b8749adb9c9b26490a3ef37aea58715.camel@gmail.com>
	 <DMDIJ0LUPMZX.3B6KY51D9ZRB1@gmail.com>
	 <CAADnVQLgRWzEnAPJQ7FWZOYWEqYeGaWqQXEvitNaVw8w6oq_3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-10-24 at 22:10 -0700, Alexei Starovoitov wrote:
> On Sat, Oct 24, 2026 at 6:03=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat Oct 24, 2026 at 6:57 AM UTC, Eduard Zingerman wrote:
> > > On Sat, 2026-10-24 at 00:41 +0000, bot+bpf-ci@kernel.org wrote:
> > >
> > > ...
> > >
> > > > Since bisection can land on this commit, could that change be folde=
d into
> > > > this patch or ordered before it?
> > >
> > > Commits should remain separate for documentation purposes.
> > > Full test suite passes on both.
> > >
> > > > A related question about the end of the series.  cf18840bc068 only =
helps
> > > > when the current frame has no active loop.  Consider states inside =
an inner
> > > > loop that is entered again on the second iteration of a terminating=
 outer
> > > > loop.  current_loop() finds the inner loop in both states, but its
> > > > entry_state differs, because handle_loop_entry_exit() splits a new =
one on
> > > > each entry.  So the EXACT check runs, and loop_stack_safe() does no=
t
> > > > compare entry_state.
> > > >
> > > > With the outer induction variable now the same on every outer itera=
tion, a
> > > > program like the one below looks like it would still hit "infinite =
loop
> > > > detected" after cf18840bc068 (with the old code the outer induction
> > > > variable was [1..9] on the second outer iteration and the EXACT com=
pare
> > > > failed):
> > > >
> > > >     w1 =3D 1;
> > > >     *(u32 *)(r10 - 8) =3D r1;
> > > >     r6 =3D 0;
> > > > 1:  r7 =3D 0;
> > > > 2:  *(u32 *)(r10 - 4) =3D 1;   /* fp-8 spill -> STACK_MISC */
> > > >     r7 +=3D 1;
> > > >     if r7 < 3 goto 2b;
> > > >     r6 +=3D 1;
> > > >     if r6 < 10 goto 1b;
> > > >     r0 =3D *(u32 *)(r10 - 8);
> > > >     exit;
> > > >
> > > > Is that case covered somewhere I missed?
> > >
> > > This example is valid. Need to relax the condition in the
> > > current_loop() or bpf_is_state_visited().
> >
> > so you're going to respin it or follow up?
> >
> > It's fine to ignore CI in patch 3.
> > We'll be removing states.c soon.
>
> respin. The better fix is probably:
> -               bounds.r64 =3D cnum64_intersect(reg->r64, bounds.r64);
> -               bounds.r32 =3D cnum32_intersect(reg->r32, bounds.r32);
> -               if (cnum64_is_empty(bounds.r64)) {
> -                       verifier_bug(env, "scev clamp produced empty
> range for r%d", r);
> -                       return -EFAULT;
> +               r64 =3D cnum64_intersect(reg->r64, bounds.r64);
> +               r32 =3D cnum32_intersect(reg->r32, bounds.r32);
> +               /*
> +                * The state at the head doesn't know how the
> variables depend on each other.
> +                * It lets r6 =3D 0, r7 =3D 9 into the loop when both
> count from 0, and r7 =3D 10
> +                * comes back. No run gets here like that, so any
> range is right for r7.
> +                * Take the one it has at the head: the rest of the
> state is still compared
> +                * with the head, and what was pruned on the way here
> relies on that.
> +                */
> +               if (!cnum64_is_empty(r64) && !cnum32_is_empty(r32)) {
> +                       bounds.r64 =3D r64;
> +                       bounds.r32 =3D r32;

Well, it's a minimal change, but I think it is still prone to
counter-examples. I'd still like to remove the clamping logic
altogether and adjust the bpf_is_state_visited() as follows:

--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1532,10 +1532,10 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
                         */
                        old_loop =3D current_loop(&sl->state);
                        cur_loop =3D current_loop(cur);
-                       if (old_loop && cur_loop &&
-                           old_loop->terminates && cur_loop->terminates &&
-                           old_loop->entry_state =3D=3D cur_loop->entry_st=
ate) {
-                               if (states_equal(env, &sl->state, cur, RANG=
E_WITHIN)) {
+                       if (old_loop && cur_loop) {
+                               if (old_loop->terminates && cur_loop->termi=
nates &&
+                                   old_loop->entry_state =3D=3D cur_loop->=
entry_state &&
+                                   states_equal(env, &sl->state, cur, RANG=
E_WITHIN)) {
                                        loop =3D true;
                                        goto hit;
                                }

Because of the `goto skip_inf_loop_check` check immediately after that
it would avoid the whole set of such problems. (And will be in the
same line as iterators).

An alternative, if we want to preserve clamping (but I see no reason to),
would be an additional check in check_cond_jmp_op(),
when jump prediction is done. There, for a latch condition,
a call to scev.c can be made, checking if induction variables would
have an empty range.
