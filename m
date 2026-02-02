Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D73803DF
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053380; cv=pass; b=q4zObip0LaSyyYSkC4NNUqvdWhxFzbYDLqsNsR4OsMtRaM6zvoQjP/wvDgcumaPfrtqvVjk+A1aCi3PHOaPrJbZSqTy3oqFiyUBCR4mM1K/PImci5cAs854CTVIjVdJAyDwqcN8tyfrjfXqGtJQWS2xiRajmRHA6LicLEvKk+T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053380; c=relaxed/simple;
	bh=LFCqQfvmvd4Ln3kewco8FFMOLTJLP0H1BHws6JigvXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icN/QMbkjqZlmgeQ+V/vl+LfHPlZkpAjqF/G3Yh9byxWcAeNbGMJef2YXsacGFlt9/1FhjUuF1zeICS2/mkgcf3o5YsBP/XuRS6R360eXuwAk9TCwnyaaag6uuVCH8kJj18WfRuVYnlXxNOYJec/lDBdmEAv1Z7jS+mEkXaswg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax9M4q/m; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax9M4q/m"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so47868865e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 09:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770053377; cv=none;
        d=google.com; s=arc-20240605;
        b=BMsEKo1Vvh6BRKugptk5yY2Z85j4W8i2RMpWltCxaqRwA1l1JYZeKr+YYPsbU8TIMV
         4cAkHXy4TKIQn1R+10/ZjgMFW0qOdJlpPyczaSk0QSRHxoW76nJHhojE/DvDUuJtZEaB
         zT78ksTBmKqjmE66hKmkUYhvkllrMz08RCtX68BEH3frx0UPgxgLEF/5Cb1mF/1IdDl2
         O//aaoGpXeixdcJzQ3on+S6Hi855+HHmsNZSz1lEOBBAVoYgqei2xmhqGeoSF2wOOUHv
         PyP6aKk+2RwW1wxgd+bmbzPPqhIqH8A13GX0EKh7csdKedOGeVXKfybcVc4SIylXc9t/
         QJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5A2ykvQTzh5HkYRUSLbzgAmwj6OarFtJXyYctuqsWHg=;
        fh=ZE4vi3XZ4lqP/yMlCseGvYhAcrtRgGNfj6mv+nSbgBk=;
        b=VmOTLR9eLFRLYf/WowkVXCL1iIFUlxHY4aW+ZHdObA7INs76lnSCikXI1o4O4nzrNE
         UkOrsje8FXQm3H3HYHxpnj6YftfqKGO6esmBzjI+rjrPkuhNWN3AdOI3ADcymBgThObS
         /34yf4Ec0ieAWCc7+x6iLZPDOpC/mhQFQsDYzOjXciz7lC1CJcXBA07FMBMcYt6gNuHo
         uFXqd9jN5JWwvCiMj3MG3R7RbJaYqpvIJmT7Y/D4naM4Hiie+SjDPwcPIQcodwODonAY
         lXZ/YYTRoUwkLlSsn2gpbpHjI5+W907QMmyB4MLZH/xD9PuxOiVAY0qwSTK6cYhM4EoU
         teeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770053377; x=1770658177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A2ykvQTzh5HkYRUSLbzgAmwj6OarFtJXyYctuqsWHg=;
        b=ax9M4q/m8SvinpydL1XRwxwXsmCFptHGc8pGmaNfu/ncXGX2W4KRf+S5jSMurOlLNf
         BnSZktR8FhKiUhJzzFwkoXmhjNGaHMzBo4YDtkPDXrcACTUPMyDzbKsozufxdK7v7aKk
         plNgZYrICj6kr80mBDOpWEhc6aGF7La21xBPmeFRtNF6/+gqvTBb0fsZSuUrNtDcSEVP
         Eg59G34d8cvHlwUuT9I2RApz2n64Ft2I8+jSHRp0SBL195YRTFU9ZblSPfBI2189WGm3
         tz+UXDeZurxpErlRqWIJTNiAUobqMLa8b99m10UrOjSqgJL43GorNOvXOHAjyQnH80/I
         KhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053377; x=1770658177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5A2ykvQTzh5HkYRUSLbzgAmwj6OarFtJXyYctuqsWHg=;
        b=dVGlikiZJMOJyVLDTFWZqAOursz8IeGa61JvHEJMWYVsd7eAWgxyfrGm+EMgWT2Ltw
         Do91Vu+BChajE8q7Js4y1caap+hlaftl4CCwsyb0DRdAmNnRkvyBsGA157UhFoLlV2yl
         Ad0K6lhfm61UWJQ5m1lmVeTrNvJc3lKJgwPWpqTMrSzsywiR4TLHje+p2yMbeyYqAu8O
         JX4aIHMMrHkTMcQKbu8KWWA4WJQMdshDI4JXz51uNauOzEBYtbqOoR0py5YcRdeTSsfM
         QR0mfgi7FtoFIpe3HqgJzO6n06NTd/MUf5ExKqrViq55B6ibdAcx7LIHswLFB7U6t4og
         tdig==
X-Gm-Message-State: AOJu0Yz8egapkN5bA1ZJ6l/93OEDBbbbBuHHQihD2eWTFLZ2IQzAhuDO
	doZJt2nVZyMOaffVFX/PokE8voVPUJCssRRWWhc/10ijZRYMCrlbu8jEBHaH7cNUULsAURoVRzY
	J2C5Tm0pcYf851LZoKQmPsVnEGLVCKHL4nw==
X-Gm-Gg: AZuq6aL5ytgBgV63KnA/WsUoLnxdeMTQOhRg05A5euR0kDLruBtpai/8jD5U7JHM50j
	o1oIikYJ7k+k8RodKcVyYwcOkBPt/Xa3i8XRz8Pdex4viEDAeLNshaO4ivzL3ELoY2zrhnEPdef
	YouNLhGgLG+42drz0ilo+1dGMw+APHjl9jxVoNFJJjgMEnaQkGW02HQQDLu5PQleC/4pQCDioD2
	k/wEPmPp70aYKatpcUKz8lAOFqBodjyZdobZfJb2fRQa0J0OkohkqbmIMTJdDB/wiEpZAgm6Gja
	ksQGi9yy1O6SmvPl3d4EL5SY8SvbvtUnOqwvLvlR8qOdnxaS0gFVrtPHGHCQDFsRi5C8mC2i
X-Received: by 2002:a05:600c:82cd:b0:482:ef72:5781 with SMTP id
 5b1f17b1804b1-482ef725c13mr75825545e9.25.1770053377394; Mon, 02 Feb 2026
 09:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
 <20260201025403.66625-2-alexei.starovoitov@gmail.com> <f7e4d8d0-c8f6-480e-84f4-74ec52e1e0dd@gmail.com>
In-Reply-To: <f7e4d8d0-c8f6-480e-84f4-74ec52e1e0dd@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Feb 2026 09:29:26 -0800
X-Gm-Features: AZwV_Qg2xSi8qbawUBOJn3AupfN-o2AhXalQM5gNZgjqzEVG-iPOPJOxXSDQSxU
Message-ID: <CAADnVQK9zpHEGTt4Oq4MEg=QtRy2dMbDDfOo1oeWEEyOAbA+tA@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 1/9] bpf: Enable bpf_timer and bpf_wq in any context
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 5:36=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> > +     switch (cb->type) {
> > +     case BPF_ASYNC_TYPE_TIMER:
> > +             if (hrtimer_try_to_cancel(&t->timer) < 0)
> > +                     retry =3D true;
> > +             break;
> > +     case BPF_ASYNC_TYPE_WQ:
> > +             if (!cancel_work(&w->work))
> > +                     retry =3D true;
> > +             break;
> > +     }
> > +     if (retry) {
> Isn't it the case that both timer and workqueue callbacks imply rcu locks=
?
> What scenario I'm not accounting for, thinking we can't get here?

The callbacks will call rcu_read_lock, but wq/timer infra won't enter
rcu CS before that. So callback may start executing after rcu task trace GP
and needs to be cancelled before we free sync_cb.

> > +     if (!in_hardirq()) {
> > +             bpf_async_process_op(cb, BPF_ASYNC_CANCEL, 0, 0);
> >       } else {
> > -             bpf_timer_delete_work(&t->cb.delete_work);
> > +             (void)bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
> > +             /*
> > +              * bpf_async_schedule_op() either enqueues allocated cmd =
into llist
> > +              * or fails with ENOMEM and drop the last refcnt.
> > +              * This is unlikely, but safe, since bpf_async_cb_rcu_tas=
ks_trace_free()
> > +              * callback will do additional timer/wq_cancel due to rac=
es anyway.
> > +              */
> What if we simplify this further and remove cancellation here at all,
> instead rely on last cancel in rcu callback? Is it just to run cancel
> as early as possible to optimize the common case?

Yes. callbacks scheduled in the future will be cancelled here
and most likely single rcu task trace GP will be enough.
If we don't cancel here there will be two task trace GPs which is
an unnecessary delay.
