Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECA233936
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191446; cv=pass; b=ZKnj6xKUcPhXF7IaZQjis5bDSI/K/n4vP/SG58PANrbFj2TRE7xV17BGS3DMRKFJeAPoBaWh+4NYGnNT3XU0pUOCBZSLLQAD1v2lDvWPoa6RRKsHjJe0UamOCZRU/bNeRI8B5xZCj1zZjKW7/fI981IvXF/KGfUmQvxOEGHs5gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191446; c=relaxed/simple;
	bh=QJzDa9BGAfImrSXnbL9DptnBQ0lviJmd7Y3LBBtzBjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sfw6SkD9rwMddYPr17QGO8CdbRq9asAwKCsn0rj3isVTCLXYxhG9LlUPOCyoD0gM06q4Ocbg1W+641oKo5KxAAjCV7+w/6k+VfxUJUd5UoyoweStdCDSUyL04RDe2217Kd6Mz8QLX2Rk6PRX9j3iDVQTXSVDtWY7p9pRJBLP6d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2C8LGS2; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2C8LGS2"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8704dc3a8so3803188e87.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 04:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779191443; cv=none;
        d=google.com; s=arc-20240605;
        b=FJ8P1rsKC8PADJOXnl9DO5+jKDlLhExbpcaHMRxX9jkpfhlvNh3IlNm38tjWMDgQWF
         Uo+T+ckAmJvyupLDGAPhkROXC9rlzCM69RXNIiMJ8mbbrCU/d6mT5xmZV86PPDJzcXrb
         5nR3NtMBZ403T8eLwwYLUjv2yqrsGsNP54b8Re76JRmgZtpHNf0t7pxCL3ioUSiWNQUi
         8cySYkTX37kVu6AoAb2nZ6rp36jPqAsoRaxat1a/L9gqjuurxO1xOu185G5lZ572CGoE
         M697V8Z7dWLBWOWPRlC4V4Po3BFqQOxc3bYmWjDEdS+ukekMJa8YUfsHktenVw0Zm6YX
         LKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fC4uhJe1yFAxqc/8/hROeQyQEZWu7EVe2jEzXlw3jZY=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=TYNSXBeHeHtf0i4F6Mxb3pSVWJpVwibQAmRSeb2dkMADfUOczRw15WqeOppQpB+c9o
         7hbp04sFPQ/xXcCNEuehNVvUVHZvvGGJXqL88hk4lHv/VcaZVqkdBubxticFm4IDyck9
         xU97gYzHPtt+hAlmCzqp4Mh8O3wZ0se1eYijqb20s0nFY4YSafcCrjvxD5WPprOG4xne
         FJ6NKsVvGAm+vwPd6hbTZSyxTLhBAaNE/c+wIDfZq76b1HtD6M1bxvEpTewSfMId230I
         x4tQBiKyNTH9taE9CdFkFWqEIY6hXfDT3UVHL+QIDejTAlnvj2BPf7ZHdod0tfHS4DWf
         qZng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191443; x=1779796243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC4uhJe1yFAxqc/8/hROeQyQEZWu7EVe2jEzXlw3jZY=;
        b=K2C8LGS2cKPTIPFNGRkuH/R/D9ilNr78FBX5CMWuQ1w7FHrMsbEBfvQg9wwkN9kLOo
         huKnuVlnlQdjTuQjotM5njh5/FoEEMdOwyI5vnGgyyJFuH95DWtIIN6g4LcJh00OCtNP
         XQwp37ogGWkqcmBKiILIqAQ7EeKMCnVoWECiA4X3k5LFSNeZxGQlOIvYU3kF7BrO/Nem
         ojiVSssVRHfkvR6D5kZPDOr6lSngGeSWxsRtgCWXtqP0idGyXhmYK+bDGu0H95lcxHaD
         OQM7AmuCgXD/od7ZxNm1zz88UteAebq3fIMqrFkN5faBSXapzgZWpcZ2eUo5Qkkg8PJq
         aIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191443; x=1779796243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fC4uhJe1yFAxqc/8/hROeQyQEZWu7EVe2jEzXlw3jZY=;
        b=mJ5d/82+rwygFs3/pfaXJbZkfQB0pOuJhfF5KwRZ8ILECg4A4qOfy2w+TL0Jnrfp58
         pITEja2gfEo8uZyi9tYqvJ8HnuZqug46uZvMBmXvnxosj7hH7GUfIH1+LrznLk8ykgAP
         5Yoeq0jCeiQEG4jAZznclhnHp6cfyTeNdqyPg1ZD//JAn1Vqt1zQUyyqV0EfXQLUKo2E
         qMYW77jtP8nhytc1X4W1fhbuZ9EJuP4Rk50hKzoFHaVjO87g1zIJNKHGHGtZRrJqlcZ0
         Su3LL9e784zzgNuJk8HewqaJ1ynRXvRjjEY4pTuNouhwrKVHUzsiOXHos0Zh8G9llRAA
         FFyg==
X-Gm-Message-State: AOJu0YxvmyXS7lNKJhIR363+vkvUK7CGVlMaqKrXazU4xVehspJn565g
	PkQotAoPO3jjUC8BOkhGtQNyHDraVZbmrZ9quOSL6iNSDzKza1tF2K7wKseTiN2vs78KZ/nWsvc
	WKLX/kEVCCB2g98Dk0oi8ReA74g/bYHetbJpCKXEwvw==
X-Gm-Gg: Acq92OEP8eyNGo8rZx8/rJJ/qjGW6mtLc8pHl4H6imtTszV8ysimgTKB+uRRKQ81a81
	QvdRPumMVpa8tJoOnv5S3K+eNTFm43kwDHyGgI65BZ8KPRk9uHgDUC6z+v6/yLusCaTY0to54Fy
	+F0wPZeAw61pFtchDeXpvj7rmEdmEPF86N4aCgxIodNhAw8zQpfWgdkZ5t5Wqh4NId5BMlUZ7el
	BKjD4BGt+hiT87RuKVkBfjgm0NFPkTWyk0yLKg4SUlUL6NIMnA3Q0EBqyMcTbBZTbhB/AZaPbNM
	KyDcOUAWkUiRZyQ8utFWzNkeOpzEhjS3Jgjwr24q
X-Received: by 2002:a05:6512:39cb:b0:5a8:d1ef:caad with SMTP id
 2adb3069b0e04-5aa0e733fb7mr5371601e87.4.1779191442645; Tue, 19 May 2026
 04:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-3-kerneljasonxing@gmail.com> <20260519082513.D38EFC2BCC6@smtp.kernel.org>
In-Reply-To: <20260519082513.D38EFC2BCC6@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 19:50:03 +0800
X-Gm-Features: AVHnY4IeBHzVPRu7LSGThA5UlHE4ZYixCeJRIL6bfCGxUd-Kyii8UdDT0FIGGPc
Message-ID: <CAL+tcoDpJZjsh_3-=YDJi=2CMDNhDJ=RgNr2yKkV+8mU08wL0A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: export sock_disable_timestamp() declaration
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Calling `bpf_setsockopt` to enable or disable `SK_BPF_CB_RX_TIME=
STAMPING` from BPF hooks executing in softirq will trigger a kernel panic (=
sleep in atomic context) if `CONFIG_JUMP_LABEL` is not enabled.
> - [Low] API asymmetry between `sock_enable_timestamp` and `sock_disable_t=
imestamp` creates a dangerous bitmask trap.
> --
>
> commit ae551b79a5c9f8c77421dc360627b1e40e3ceaec
> Author: Jason Xing <kerneljasonxing@gmail.com>
> Subject: net: export sock_disable_timestamp() declaration
>
> This patch removes the static modifier from sock_disable_timestamp() and =
adds
> its declaration to include/net/sock.h. This change exposes the function t=
o the
> rest of the kernel, specifically allowing the BPF subsystem to dynamicall=
y turn
> off the global time record function.
>
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index dccd3738c3687..8a49312ee0976 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -3038,6 +3038,7 @@ static inline bool sk_listener_or_tw(const struct=
 sock *sk)
> >  }
> >
> >  void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
> > +void sock_disable_timestamp(struct sock *sk, unsigned long flags);
>
> This isn't a bug, but does exporting these two functions with asymmetrica=
l
> signatures create a bitmask trap?
>
> The newly exported sock_disable_timestamp() expects a bitmask (unsigned l=
ong
> flags), while sock_enable_timestamp() expects an enum index (enum sock_fl=
ags
> flag).
>
> If a future developer mistakenly passes an enum index (like SOCK_TIMESTAM=
P
> which has value 7) to sock_disable_timestamp(), wouldn't it silently clea=
r
> multiple unrelated socket flags (bits 0, 1, and 2) instead of the intende=
d
> flag?

You said what if someone makes a mistake... At least so far we're able
to handle this.

The existing impl was deliberately designed. See how __sk_destruct()
works with the function.

>
> >  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, i=
nt level,
> >                      int type);
>
> [ ... ]
>
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index b37b664b6eb92..2d552ae5edd42 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -474,7 +474,7 @@ static bool sock_needs_netstamp(const struct sock *=
sk)
> >       }
> >  }
> >
> > -static void sock_disable_timestamp(struct sock *sk, unsigned long flag=
s)
> > +void sock_disable_timestamp(struct sock *sk, unsigned long flags)
> >  {
> >       if (sk->sk_flags & flags) {
> >               sk->sk_flags &=3D ~flags;
>
> If BPF programs running in an atomic softirq context call bpf_setsockopt(=
) to
> disable SK_BPF_CB_RX_TIMESTAMPING, could this trigger a panic?
>
> Looking at net_disable_timestamp() which is called immediately after this
> bitmask update, if CONFIG_JUMP_LABEL is not enabled, the code falls back =
to
> calling static_branch_dec() on netstamp_needed_key.
>
> This expands to static_key_slow_dec(), which unconditionally acquires
> jump_label_mutex and cpus_read_lock().

No. When !CONFIG_JUMP_LABEL is met, the following code is the right
place that you need to look into:
static inline void static_key_slow_dec(struct static_key *key)
{
        STATIC_KEY_CHECK_USE(key);
        atomic_dec(&key->enabled);
}

So in this circumstance, no sleep at all. You were analyzing another one :(

>
> Since acquiring a sleeping mutex inside a softirq context triggers a
> sleep-in-atomic panic, will this cause a deterministic crash when users
> dynamically attach these BPF programs?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518082344.96=
647-1-kerneljasonxing@gmail.com?part=3D2
