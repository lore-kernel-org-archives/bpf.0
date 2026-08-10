Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114793DA5AE
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365976; cv=pass; b=luSlBcPE2JgP3aNI77TJ2Uhjj1YlHS1iXKHDDi86yudP6U/Q937/tSR7qvFF9LT+82iO7Ucr20cF850FUx6Re1vbpHi46NELllqV0h6s2P3wW4SHIAvsCuXSPphQWZGVpsq1Gpx8xNRe/TkbgsJfRHZtQwa0SYD1OlHu312B7UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365976; c=relaxed/simple;
	bh=fC5scpO7qB1WJtBVuvM5ZMx/R6ROE9ZcFEteFfw1clQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkQjN1YzC9QqviWytRgb4IJVVaf6NfsDHk6gT9YEHhcMdjfQX1X6E87oibi4GUJ9j6jExp9pE8LJDQssjDclMQMB+8OsbneQFpKcv+0yeQK5mdRI31UpNVOGLEg8UdGLU2wd8QQwiNVk2hZkvxdHELL1YiCzf5xJdMZKPHtFvfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGv5nT7M; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGv5nT7M"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1712a04ddaso281802366b.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 05:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786365973; cv=none;
        d=google.com; s=arc-20260327;
        b=daLgvlJWzrlYZdB/0D+zkzBVGKsmiBye6qt18Fs8zhnncaaCUTZW5jdxlOJ4Iz8+P9
         OkmjBeH32piL6Ix0TZZeiyglMrSYzocWTaUhlGVqYUbFk+7zf5Vlk3UevX8vSuJzBXNK
         YeTVcMSKocadzX0TLsABjC4wV0gr8jw3cM+opDip1Rw6bLILev9DmDj86AZbDI24nqEM
         7e6wfgVVW0Ll+xCrepZ3p04+cgEsRMz6+hcG2JNqiZRfodHnPqws3ANPeqog9pL7c3ko
         bSMdqeycSs0RWIRq2ok3w68dwg51HvryYI4yXL5hkhyqx2JSEsCD/r0RPFUWfEEt4tG0
         mcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fsow79yVgjfnSj31xvsO1YjaEkdqg7wriMmgcGrZl6Q=;
        fh=WVST+X58PRUdz6qhsEKs0B0AH+vcx2elS1eF8f6wyWc=;
        b=bE0PLeMwbNYUE4bgyrz/14jp+ep/ogJ/bHux5wd+jSuTSLZlsXb8dcscURYlkpFdVK
         8pB5LV1fwsgChOOv91QwfQWArkZ7XZqvRysj0GXBvSps8lC6S4GoiCnAXJLuxREFxoxj
         VeRoEgC0CyhjmjsoFr1ONwcHM/AY4TgqoJFYOhT2J5tMHsUPfT5m9lYzF2gCuqS0dc6m
         r3eygJhBR9xobKsw3LNoLcrmRnh5bxG1d58ojRd56LJLPq2swMfvDwfEcLevKTrORwwP
         S+fh6u1Bxwa/rSBOy0i2vW2pDg6MgfT87LwOHNjEpMCEH7WASzheTm4CtVbmaXLPNe8o
         yrCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786365973; x=1786970773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fsow79yVgjfnSj31xvsO1YjaEkdqg7wriMmgcGrZl6Q=;
        b=VGv5nT7MnZytNUZLrTBOIwLld37XSw4jsr8wwqi/+3aBweXgWr4tppy3zxzDM6wUMV
         iNMig/nCkcaBeK2oid762oYoyzyIbL39CTQuHgNgwZ7FOdaH5m7N9wugrTRdy/ChXAz5
         8Eeo7RdI/Xr6A5SAYUB4IFpGJEubW5BlAAkfGqCBpAVA4YaRwHSXnUtZi0oqDkxkIY12
         rwNKpzXPeC9DkUUHD/1LL2fcHHLs8xr3qwExx/hdhk74TQGVIXLfnmN235JCDJLagyUc
         fMpGTotMJ6pmNt7mi+NMiTkkP1CLN0Hen15ieEEYftJhZqhbjOhMj54IGNk1uEV2grSr
         t+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786365973; x=1786970773;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsow79yVgjfnSj31xvsO1YjaEkdqg7wriMmgcGrZl6Q=;
        b=QDKsTtKe7Q2hMi8Fj5MjBux/RO4euweYSZkJvN+UfPdog+6hD1KnlA6WeuIZNX1t1Q
         ky3ZzvGoparTcaGzU55nwWGd+k6V3yRn47QSpiyHpPzT8/OdyydKfrj+B8ZxcfKfHuo/
         D0iN0qmWW4/aCRJWasRR4PoSuw1wAwJw9fym93dpZ60GFlErfctLr37zd8zrjwdajCk5
         JSXrrYqfJLLs26CnXyzhajbbETZkq36p46cU5ix3qI4iRvXuqWzoNA08gFS6QJqevYpP
         1dpxZdqdV8nxvNaLjOBZRd4HamV3b9TEg81EFFebiRGGGBn7a54+ye6r2XBGUbc+NwT8
         9Q5A==
X-Forwarded-Encrypted: i=1; AHgh+RqscHvVQvOZIX1ptqMTosjO7m4FWXBpUe/xPtt391G+FB2Nd0xpm3bPYXDTvsI4j1293Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1PheDNwkowRalGl2EIG2M7ep87SS9IRwGrqYGYPra+16udrRe
	1KniH7qM86ACyoK2Q50Ep4mU6izhYm9Hr5lIe6oJGEB0hVZLfpNPJwhRoMIz3Fpb1ggcAI+Nwlw
	BNiXO01+ZdcfUeRXBVxxpNJMB6xoDYdA=
X-Gm-Gg: AR+sD13+y3sxOd/EO3/XjYnw5FwrRV7xOTjdkl53GO6YuUdSExzMu1ItUgf9vOTrNE2
	Vbreyf85neXDXw1pxS1lVCxT14KgfbLt8THtNPG6nJspF8mguUp4dwUJ2LBiyHWwXaG4N0loe5J
	I309LehElth9sWgWtl6zQSLsg4MUszuGmPa+wwL/wSZGsceiPod6NII8Z0VbQXHV9n5KQyz+4IL
	zzB4uSUwcz0la6hPfSzlY6lPMSFiVwUMdQrISYh0GPFSAJjIC/SA680CHiQLT/fuw0xmyS9EQKQ
	Bk7u4ciBJcdLnNKzWomQ2cbffUE+CwzgNokPzhwzC3ljpy991wC6VCwFw4Gh
X-Received: by 2002:a17:906:fe46:b0:c20:1ec5:feb8 with SMTP id
 a640c23a62f3a-c20c6a09bccmr70511066b.29.1786365973030; Mon, 10 Aug 2026
 05:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-3-puranjay@kernel.org>
 <20260810124300.6F6F61F000E9@smtp.kernel.org>
In-Reply-To: <20260810124300.6F6F61F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 10 Aug 2026 13:45:58 +0100
X-Gm-Features: AUfX_my7sbKVXUQi_BH5L2H9-539lpsxcbJXElUuAGQoqY3CI2Fhbga_HcDN4KA
Message-ID: <CANk7y0gXovcHspdT9T3SRdnW5_R5z3-25G+CJnHTD3UPPFSLRw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] rcu: Make Tiny call_rcu() safe to call from any context
To: sashiko-reviews@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:43=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Moving `debug_rcu_head_queue()` into `rcu_do_enqueue()` bypasses=
 debugobjects tracking for deferred RCU callbacks, masking use-after-free b=
ugs and causing list corruption on double frees.
> --
>
> --- Patch [2]: [PATCH v4 2/6] rcu: Make Tiny call_rcu() safe to call from=
 any context ---
> commit b9d1d9e1aa870c19c3d9b30019cdb1bc509b6703
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> rcu: Make Tiny call_rcu() safe to call from any context
>
> This commit updates Tiny call_rcu() to handle interrupts-disabled context=
s
> when the scheduler is active. It defers the callback on a lockless list
> which is re-issued later via an irq_work, similar to Tree RCU.
>
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index dccccd6be9411..656b6a682e31a 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> [ ... ]
> > @@ -157,29 +251,19 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > -     static atomic_t doublefrees;
> > -     unsigned long flags;
> > -
> > -     if (debug_rcu_head_queue(head)) {
> > -             if (atomic_inc_return(&doublefrees) < 4) {
> > -                     pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __=
func__, head, head->func);
> > -                     mem_dump_obj(head);
> > -             }
> > +     if (should_rcu_defer()) {
> > +             call_rcu_defer(head, func);
> >               return;
> >       }
>
> [Severity: High]
> Does moving debug_rcu_head_queue() into rcu_do_enqueue() bypass debugobje=
cts
> tracking for deferred RCU callbacks?
>
> Execution is routed to call_rcu_defer() before debug_rcu_head_queue() can
> activate the object in the debugobjects tracker. Adding to the lockless l=
ist
> in call_rcu_defer() overwrites head->next without verifying if the RCU he=
ad
> is already enqueued.
>
> If a caller erroneously frees the object or double-queues it during the
> deferral window before the timer tick issues the irq_work drain, could th=
is
> mask use-after-free bugs or create cyclic structures on double frees?

double calling call_rcu() is already a BUG and doing it from NMI is
one level more. debug_rcu_head_queue() can't be called from NMI, until
we have something that can work from NMI we have to go with the
current implementation.
