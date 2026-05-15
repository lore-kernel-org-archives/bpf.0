Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CE35E1D5
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885321; cv=pass; b=IFbnzuvasH6BV+bKQmnGVrfxAa2NRDrUPFSfKCghL+JkTjug23SVmyiGxBPZTEBXfgFyJOoHWMtV2ui9ilbjJ2Gxg842UJ9vEaEhjJHw3aJOdR2jzg5Ih8KQX7ipAUjAovfh5ctsj5BGyIlwbGK4cXR4l/G24yk1LYq2OYAlaK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885321; c=relaxed/simple;
	bh=emgqSdrgaH7tKJdLuU+Uw02nxDHreg2z8f1DQNj3AJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=km1iKqJ9oBhWH8M1sgmpS1eePfvQMtAyEtHB1OJfRsDG098saI0xZtJwcMlO8cn+Nf+co2mJ/OCAquWdDmO4twY/4WiLARB22mii+4BYiYSe2TiftWEZUYdpCzJgbqmGscb2vf54t5qAYh4m8TXh+DTXPESjOnGRQMhXygfBjm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjDv3jri; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjDv3jri"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c801d732058so106616a12.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778885318; cv=none;
        d=google.com; s=arc-20240605;
        b=B3tr2nxfc1leZr2zkAlwWiZ2QxP/ypYEeqZpvh9iAMrFKHHTYLv3dk4imb4z8/ByFZ
         UaFXGJjg3QFXofXOuT9Xzcj43HaiZfN6GS3gDDLJIsMyCd4aPZ7Yz+EyYndgQPLCDRc0
         R+VhYOw/x2y91kQaGGW+8+PAGCZ4WxM0eDQp4xGGV9s+ZYh5JwF39KP1a8kZjlV6wAxN
         tyHR3bfxOfYuDziruLKI5MQnRCSqNx3750ExwG21U9qrOR8x54lycU1/jzcOqNDymy7N
         IRrBzb/ZIx/rB5gbRsjUM+2sDpnMfDgjjdn5M/Jl9mKkQHhKfYNxv9dTPQ9XQNL40mid
         vdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ddJL9/JvVKOl4QVfhOJ331vWWsYvSvnzUzhysZJR6k=;
        fh=02jN/kd+cSBW5VXbMtRePKsZZhwMuCubLBfeFH5hQIg=;
        b=WbzDIFnQbZCSIO9awrWB2oQJWR8fVsS1gkS/BhTZ2gJnnmcM6ZwSqvKmb/qow1mcF5
         SKSfwdmkNyAPPu7GcLljV8HdknSeQWDvlIvS+menAeFjqgs1oaCY42Jrloj9vFTLhdv0
         TeJk7fKqq+GyuiDdiO408ejWRsouvsWcA4MOWMfkMF45T+7UX4QyaKUzh8nr5q/aC5eo
         e2ISg8kuaD4Tj3bx1Xos7MM6VOOZEc7im2dDdu6AZdmi6H+WG1GTjcitSRjuMYhQ6vrn
         ItyDv1hGIxb1CERhOaBu7zZbjmtG/phPenpW0hIpO9+CyKLbb4wURNjHcQ992xKjlCz5
         onkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778885318; x=1779490118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ddJL9/JvVKOl4QVfhOJ331vWWsYvSvnzUzhysZJR6k=;
        b=hjDv3jriTreslwP4O1uORrF9BcH4f7gSvaFopm8vetDgL8vQT30HakoQu7V91Z3IFh
         ugUAErxHzdLdKyDql+0lKhtO0YdHBx6cQ4w3trO4TrwKjVj3V/U4yqRiURDBGUW3afUD
         urr5oKZ3lOmAX2k/YpLv3KxvOiqM26TLvqEq9h5QFFsFxmPh02yXgQrEdTepxnCYLFHE
         UKBwt0XZ/iWSf/2AkpDjtdstzQCMsbsXlI50L3aHbiGSbPA5cWwGh2X1c60DGVOppmfh
         tCZVMjJKTyuyfUiQdrXnnnxBQneir4VLTNgQpb1HV3RsS+yEkjQd1kBZxzp2C0OCenad
         xymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885318; x=1779490118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ddJL9/JvVKOl4QVfhOJ331vWWsYvSvnzUzhysZJR6k=;
        b=R/ymvPMXxdNjck3U/x2P1auipw9jhA63aJsWIP6CmoWRg+m2buR+kQxDiMX8rjDurI
         +86wMYmLiBnA3o9UuxgdeYhtWx5nThQCTOZ3ZSAnRwFHTotVQpsQO0DYlLcXm8GQV77b
         ILDcL70RflSnKPvqesSjiVle2xniD0RUSZCOTt930ZET0VkiXEzX0gGsIGGKywH6IHi4
         rSuYmgeqoi3SwvH5Zk/XSBbjgYhQglw/c3CBgxWj85wvhOWb/s6+9OYKOlSW3scRKNFX
         xikIBeOEUDXMaoSl4i6k7+gRXOSclFwctZtdaeInqlfyKnEJ74kZsWcncdn6n5xyezzt
         qf/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+unVGeswEvxXJ7Qrkg6L2DHNn9miro8//syKat3Rd9tYKRMAR10KiToSdLHxiozJT5504=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1KfwfRWVBskDFI0oLhzZvQanydV0K8VhihSDSb4LaNaJKiVb
	1SMZxOfDrJWkLMjS9mVKOmE7BtNFAcv2FMeGW40IWdP+NR0c0DzT+S8OGIWOnR1Atq/jvSBB+Bl
	8zQ2ruRyd107SltwxCtrSqs9uvkNbd0UqCbGH
X-Gm-Gg: Acq92OE8aBVqAr2w/eHROYS5foAJNiKktk1jAO4G8dJVWAiCt9Nx/VVYqGOhMDrrfQ6
	tbLzRYx5hBI65aO4/gBTBhNInG9JDSOe8Pz8YUslu/3YUnNpvTX9nIhN/dxubqCQwzjfv7WAgFc
	AjgOVxbMth+egNLg1R6sewirc9iSYeB5cXWMne/lB4mKCzBb4TBwRNeQifEmuJ4F12TmcS0+o49
	bi15wR6sTohyU+tAHX6OlX21toYPvDGiYl9xTZIijvfUVh8VrjkaUIsbgjJ5Pz68oWqjuerpF3H
	BG0z6QlpUR13lFI1eNmvCvo=
X-Received: by 2002:a05:6a21:99a6:b0:3a2:d5b8:bfaf with SMTP id
 adf61e73a8af0-3b22d0c8e5bmr5941072637.2.1778885318138; Fri, 15 May 2026
 15:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-generic_tracepoint-v1-2-aa619fa94132@meta.com>
 <20260515182509.A08E7C2BCC7@smtp.kernel.org> <24e10e8f-56b3-46fc-8537-fa677b2d2ddf@gmail.com>
In-Reply-To: <24e10e8f-56b3-46fc-8537-fa677b2d2ddf@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 May 2026 15:48:23 -0700
X-Gm-Features: AVHnY4JuVz5f1z8-5S0OkpN4BAbd_lg6epNLlbMlBhTDSjuOSwaVcIG5cFtgSBk
Message-ID: <CAEf4BzYLpEWXSnO=d5J-5-A7CUFd1oFB2XjxWrLCor4gJWWcTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] tracing: Expose tracepoint BTF ids via tracefs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 1:08=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 5/15/26 7:25 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] The global `event_mutex` is held across a `copy_to_user()` ope=
ration, creating a denial-of-service vulnerability and latency spikes.
> > --
> >
> > commit 5bcf593e0ef00b79b0e87af32e5fdb4e5481d768
> > Author: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > tracing: Expose tracepoint BTF ids via tracefs
> >
> > This commit introduces a new tracefs file btf_ids for each event. It ex=
poses
> > the BTF object ID and tracepoint/raw BTF IDs populated by resolve_btfid=
s at
> > link time to allow raw_tp and tp_btf BPF programs to properly attach.
> >
> >> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> >> index c46e623e7e0de..d463fb44c790a 100644
> >> --- a/kernel/trace/trace_events.c
> >> +++ b/kernel/trace/trace_events.c
> >
> > [ ... ]
> >
> >> @@ -2200,6 +2201,62 @@ event_id_read(struct file *filp, char __user *u=
buf, size_t cnt, loff_t *ppos)
> >>  }
> >>  #endif
> >>
> >> +#ifdef CONFIG_BPF_EVENTS
> >> +static ssize_t
> >> +event_btf_ids_read(struct file *filp, char __user *ubuf, size_t cnt, =
loff_t *ppos)
> >> +{
> >> +    struct trace_event_file *file;
> >> +    struct trace_event_call *call;
> >> +    const struct btf_type *t;
> >> +    struct module *mod =3D NULL;
> >> +    u32 raw_id, tp_id;
> >> +    const u32 *ids;
> >> +    struct btf *btf;
> >> +    char buf[128];
> >> +    int len;
> >> +
> >> +    /* Module unload could free call->class and ids[] mid-read. */
> >> +    guard(mutex)(&event_mutex);
> >> +
> >> +    file =3D event_file_file(filp);
> >> +    if (!file)
> >> +            return -ENODEV;
> >
> > [ ... ]
> >
> >> +    len =3D scnprintf(buf, sizeof(buf),
> >> +                    "btf_obj_id: %u\nraw_btf_id: %u\ntp_btf_id: %u\n"=
,
> >> +                    btf_obj_id(btf), raw_id, tp_id);
> >> +    btf_put(btf);
> >> +
> >> +    return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
> >
> > Does this hold the global event_mutex during copy_to_user()?
> >
>
> Right, I don't need to hold mutext for that long, should drop it before
> scnprintf() call
>

please cc linux-trace-kernel@vger.kernel.org mailing list for v2

> > Because guard(mutex)(&event_mutex) holds the lock until the function re=
turns,
> > the mutex remains locked during simple_read_from_buffer(), which intern=
ally
> > calls copy_to_user().
> >
> > Could this allow a user to intentionally stall the global tracing subsy=
stem?
> >
> > If the user-space buffer is backed by userfaultfd or a slow FUSE mount,=
 the
> > page fault could block indefinitely while holding event_mutex, which pr=
otects
> > system-wide tracing operations (including module loading and unloading)=
.
> >
> > Looking at event_filter_read() nearby, it explicitly releases event_mut=
ex
> > before calling simple_read_from_buffer(). Would it be safer to use a si=
milar
> > pattern here by dropping the lock once the buffer string is populated?
> >
> >> +}
> >> +#endif
> >
>
>
