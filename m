Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41933D6CC9
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878847; cv=pass; b=Nvf6cfp7i/gt+rtQcLI9Xin8ldOo4p+aEAdoBKlNEDDUyKel9f9IqY40ocscC1ayAIsS7t07qsmxer64CxNnPpDDNSPj7qYNn5DdNirmHtoycyukDFavtu+/iJAH1hnOjsfaI3HE6+mtOYpuWB5KUJkUY4nHuLwYzOshpaUTNH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878847; c=relaxed/simple;
	bh=sT8OyZboSOvw/nwILC9p+tnLW7x6pWheOj2nbmmh/Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8Vih9V9515Zdt55eTMUnIfDkYlT61NrhZoQvX7hqICwPDQAWQMUKAUtqtbeXZ/2WPAAv+6qd9j/W3O+Y1elsrC4FoFDthLYyBL4L9G47mTHeBGn/FSqH91nio7ggrYTGM8vBxoZOSyi4N02UNNsQzK7KDk3hpA0YLNvKIaKwZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDv/MhD7; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDv/MhD7"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d751ef36ccso2406727a34.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 06:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774878835; cv=none;
        d=google.com; s=arc-20240605;
        b=h79AjqEMm4kaqODiNy94HOjfH3FQqplBWoJhrNFlz5VonbyV20buTusVFe0NChvL3G
         KqkJYr/tvEZv+JtzMUEJ6/zvGr1McYeNOI9RwsDFl0q9AhZ5Hx+/0yGgpjrLUmrgG5pw
         7e0MSaIBbR62XS+fB0mAuaNmL/J4Mbwf9C9bQewsVRH3GnTcuAyOAU1ZlsnSss64TwIl
         zszXCC8R6rFs4EfvyC4+2Z7GuedTRyRj+QrndnDwDx5rC5Sh0uaTrq1zPeF0+NhTgjfb
         cKEwHXv6nnxbjko4IYeFSUrxDCpO0owgfvjwb0qPF1tMcyP5IaenJkVWXCTqGniJtM/l
         TziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=THjoepAmLmopDWfJ71Tl+zdjElTp1DDg0peckUx3b9E=;
        fh=gkrIYST2zHvDg9wZkFmdaPflIvRqibmGCpINTtiTiLE=;
        b=eS/47oCGdazO8jMu2Fr1/lywnEp8kHDdyZwcHGA2UrKMa44jndfzR7IiKwaCgpyosa
         JGHO8wW5p3VFoS4l5a5CerIvSeiJZZnCi/d/s6hRyowqpUdnIyXx2vpBS5WpEX6ocHS9
         1XhgySmm7S3hblmMojhlwWqmG2tebkatXJ18+HRJDyc/g9cNisshZR8xPm45uWnroC2V
         oNWx/eyO6vimGvxgIgbxXqDnhO8ZZEU17o8YaiWjydXeCLbYVLDvorgHUy0pQwKlMCCw
         4UR5cdDQtiBRyF63+JN4fJ6Yvf87A3JLxZICt8gGY03HH3PTA4enOkrLWAfGmSMMsbks
         2tSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774878835; x=1775483635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THjoepAmLmopDWfJ71Tl+zdjElTp1DDg0peckUx3b9E=;
        b=WDv/MhD7y9Qk5oVdzUxEGlfK1qYUTyHqp5C+lAUD9n4xcTLZD1tUt4HBbe7SB8UFZg
         oXg20v9l89I0lx0+28KPMVG06+n1h3BZ8WbQ6AjKpdFPUQhpn2/38RqOlcrcxmK8nebf
         nD/9P330nNmHEoYKDDUnXMjxoOTXFpn+zlhftiCRcpoTKV8EbZkzAxST8cwqQEO8Vror
         Fc2wM5iRtwyAxjpxUvUhK+HxmWBXqKX5FpXVLCzERa0QMPaA8kJA4ukMCz4CUcj6fn2/
         XV2z7K4HyOdV1ybUDwwEoAge6JCJdrA7jpbKGxrVsE5egESEgENgLZENQDSW9Y892VKm
         YAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774878835; x=1775483635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THjoepAmLmopDWfJ71Tl+zdjElTp1DDg0peckUx3b9E=;
        b=K6Sv2GxAYgxunSoEXz+wAUM0j0Z4hAHSxbrlyCcmWU4RedDnYxjiWcXtX+Hq46pd+r
         T4+UzktwkI3LzgUjLuJSnSqVVe+CDtFpeuMRMis34g9oDirKxqjhMmuj505ysLnZ6lXa
         eIV1NxpqnQPsAwfDqPEn4AvvJzHCAv0tE1Yd5aWcqcLR7lF5V2Pu/edT0uOjXiJMlwXf
         40qwuBghilY/OkRHouvDQZf1UZ38kIuJeb4gJDmhspad79RDYyVb0aFeE9c/89VpCuNW
         bd8oK68nIJ8qdEnZkrbVtsP9WtJnjJZncxPo6WUZqLSMVyrWIklhzDdz7ZkEcfd/Ehjy
         pm+w==
X-Forwarded-Encrypted: i=1; AJvYcCVH0iz6LJN1iXM+6QNDblvxj18bUQKo+0NKovVtfgfIV/VB1osGMz9eSYt+hPDxbpv4KvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9E7Hid4FvO9BVxlqUhR65Uo6Jz/8DylF/rhIa5bZSCnPm1ml
	5qrR/AzuLpfnoE08YM1R4u5x6cwuoAm7pi22r31G4OJAVFeoy2BvQkjGOqooeVAPGiCEvRWSzuN
	H9VZM35B7/TxylfA7NGRhcA4+8022HGs=
X-Gm-Gg: ATEYQzwIT3UooeLoymjWKkaX4plN4TnCqsLiaRUoVVb1ZlAb1VarHdt07pr+XNfdMSW
	X2/Q+Zb0iQjzXL+EdHb34uLamcrBD/qb4FN/BIKw5U0xFxeZzwzjJQbmdkWm1LclF7NmrEjuYWu
	lsnSHNBy00ufMdpcPOYPG0PZVpnYlytSmeX2RI0IzdkVRcV6IZZtmA2WEBFf93ljSDGCwe7YW5m
	WS7Ikk4mrf3DNr5VMZ/MxgHcTYcLYkqe7Ivx/ujXarTaMqRSjDY6p4zQEQuct9S0bDcsEu5oW14
	if4D9xk=
X-Received: by 2002:a05:6820:4702:b0:67e:1ded:bf5a with SMTP id
 006d021491bc7-67e1dedc351mr4046053eaf.32.1774878834869; Mon, 30 Mar 2026
 06:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330121732.1601352-1-eyal.birger@gmail.com> <m2qzp1zbas.fsf@kernel.org>
In-Reply-To: <m2qzp1zbas.fsf@kernel.org>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Mon, 30 Mar 2026 06:53:34 -0700
X-Gm-Features: AQROBzA3fpy4SdJSPbgy9UzzSA2hs0FDWdZGBrNgqzmBk8ZWv0yir4Dan1ti7lg
Message-ID: <CAHsH6Guee-USB=6daNp19zN=u6Vv-wtcfAtiMRECkgsv=7Rn8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: warn against BPF_RB_NO_WAKEUP in bpf_ringbuf_discard()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, paul.chaignon@gmail.com, 
	chen.dylane@linux.dev, kpsingh@kernel.org, a.s.protopopov@gmail.com, 
	yatsenko@meta.com, ameryhung@gmail.com, tklauser@distanz.ch, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 30, 2026 at 6:39=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Eyal Birger <eyal.birger@gmail.com> writes:
>
> > Document that BPF_RB_NO_WAKEUP is not recommended for
> > bpf_ringbuf_discard().
> >
> > A discard done with BPF_RB_NO_WAKEUP can suppress a later adaptive
> > wakeup from a valid record, leaving an epoll-based userspace consumer
> > asleep even though data is available in the ring buffer.
> >
> > Scenario:
> >
> > epoll_wait(rb_fd);                     // blocks
> >
> > rec =3D bpf_ringbuf_reserve(&rb, ...);
> > bpf_ringbuf_discard(rec, BPF_RB_NO_WAKEUP);
> >
> > rec =3D bpf_ringbuf_reserve(&rb, ...);
> > bpf_ringbuf_submit(rec, 0);           // valid record, but no wakeup
> >
> > This behavior is surprising in the context of bpf_ringbuf_discard()
> > as it seems natural not to want to wake userspace.
>
> It appears that once you do a submit or discard with NO_WAKEUP, you can
> never go back to adaptive mode. You will need to do an explicit
> BPF_RB_FORCE_WAKEUP to do a wakeup.
>
> This looks like expected behaviour (by design) but for discard the
> programmer might think: "I'm discarding and there's no data, why would I
> wake anyone?  Let me pass BPF_RB_NO_WAKEUP to be a good citizen."

This is exactly what I've seen and it created real bugs.

>
> I am not sure if we just want to change the description of the helper or
> also fix the code to ignore the BPF_RB_NO_WAKEUP for discard?

I wanted to avoid breaking something that might be in use by advanced use-c=
ases.

>
> Or a better approach would be to add a wakeup_needed flag to struct
> bpf_ringbuf. When NO_WAKEUP suppresses a wakeup that would have fired
> (cons_pos =3D=3D rec_pos), it sets the flag. Any subsequent adaptive comm=
it
> sees the flag and sends the wakeup, clearing it. FORCE_WAKEUP also
> clears it. But this could change how the ringbuf behaves for existing
> programs.

Considered this, but wanted to avoid a runtime penalty for this edge case.

>
> I will let others comment on this.

Thanks for your input!

Eyal.
>
> > Reported-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> > Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       | 3 ++-
> >  tools/include/uapi/linux/bpf.h | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c8d400b7680a..c46b06d45904 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -4645,7 +4645,8 @@ union bpf_attr {
> >   *   Description
> >   *           Discard reserved ring buffer sample, pointed to by *data*=
.
> >   *           If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notif=
ication
> > - *           of new data availability is sent.
> > + *           of new data availability is sent, which is not recommende=
d as
> > + *           it can suppress a later adaptive wakeup from a subsequent=
 submit.
> >   *           If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notif=
ication
> >   *           of new data availability is sent unconditionally.
> >   *           If **0** is specified in *flags*, an adaptive notificatio=
n
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 5e38b4887de6..96de37c3b896 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -4645,7 +4645,8 @@ union bpf_attr {
> >   *   Description
> >   *           Discard reserved ring buffer sample, pointed to by *data*=
.
> >   *           If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notif=
ication
> > - *           of new data availability is sent.
> > + *           of new data availability is sent, which is not recommende=
d as
> > + *           it can suppress a later adaptive wakeup from a subsequent=
 submit.
> >   *           If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notif=
ication
> >   *           of new data availability is sent unconditionally.
> >   *           If **0** is specified in *flags*, an adaptive notificatio=
n
