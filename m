Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54D4848AC
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407919; cv=pass; b=SMZiN6AJBVvMbj+d0mEPewYtKupladPGJBe9UfvImIlLcwdSSJiizsiFRQfYtvt9JnxLWttSx6kD1IvOeWA7lmvLy4QKdHgrY9f6OksxkYW7fDAFI6jXeA71NsV4X2o9oMzdUW+PcHdMeIjbs9Dhlmh7tWMKkOlAozwJLwwnh3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407919; c=relaxed/simple;
	bh=jUY85gSFYv44ajD0M92QfBXDWEtyEd1ElmdqhoNdS8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmVuDi1KPWz1FyxF/y0aCmjjD82xRvDFpv1LJJqiUAmSPr2XAUSngCRI+qaCk0isqPVznnTYDG2Q0g3MIsmEJSwg8g6JBGEtqaWczDoJiRpeURtHO6xzRRcpKyLAoLFh/cmB7Q+e55YGMBK7WRgii5FcT5hlYaKl0m1OOWG7E90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E192D2ld; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=icNIMQtO; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E192D2ld";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="icNIMQtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792407917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUY85gSFYv44ajD0M92QfBXDWEtyEd1ElmdqhoNdS8c=;
	b=E192D2ldzl0W9xYUUkIVJEgB+IeNx0vFhBNRLLLmquGiYuSTcq1muvXl2dqiHjD6P/dSRR
	T2MdDhJ/VAHhWd7WNYqywOETLtIdnx88p8cTrNJuxp/URXX6LWyntWE13xmN2nGzxhjkZ8
	za3dhnhGDMjatDIUod8R7QINSuA2FpA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-deG954ZuOzaAPKDOd7zz1A-1; Mon, 19 Oct 2026 11:05:16 +0000
X-MC-Unique: deG954ZuOzaAPKDOd7zz1A-1
X-Mimecast-MFC-AGG-ID: deG954ZuOzaAPKDOd7zz1A_1792407915
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c449a3223e9so28065566b.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 04:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792407915; cv=none;
        d=google.com; s=arc-20260327;
        b=S5u+ut5m8ozCbT33qQLFi9gJsmRU67Uxx0WOrLHvEYnJQyi+9elsMDA4DLY1llYQTY
         OSDwuRs+uABirAYpT14yhqRKNVxtEnSg+oEk5aRanFQR8JNaLW4bhuRufss3wKMnF1cg
         PEG9xiXsA5kUnlImmO49zhsAV3HGGyjVtbeFZrmAd3jE976ssWyaHAw5iEIlgVbA+Rh+
         k+zj2Ft5myF4hqVjwPuAKYQoMbviPadBdTJPOOO/MPZ6DL2eTAiWOljl6l2R05cgrnvi
         BFk+M4SWu+wHI6577DV5vm+eoTkuxhXA0gZLTj7YUsSRBPvRVBiYTzR1sMp0guD6OT2z
         zmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUY85gSFYv44ajD0M92QfBXDWEtyEd1ElmdqhoNdS8c=;
        fh=TyRY4cog+h+ca/d0LwEpvBmC+T4HerkIHm9f5WkJeWw=;
        b=K9YzXHa0W9PxCPOmr3USU+4FAIc4vyU4Ocaxm6Ph2ZkD76xIz9kwayOOdRRFloMiPC
         nO2JL4YOQ9vXoDMnxCNTZT6tT4LycEtanPsV3W1Plz6kuitQNXM37Ak4Q7AN/Uvhr6Z7
         W72xcPM3Fd4jigAS1pxS/a/1COjtQaQMrnmoCpfisF0X7S4hk4tHtknsbD/Qsn4Nf+HO
         2vq/YzeifLucp8gU95Eg2pnrg1NsRLA/EVpxZx9slZ4rZHH6Rw7ym5qUfyvho+g4Eh3d
         mx8bm9/EL7GLurT6rFJuvimJQIry3jxl4bzdMFO0USI2rna/x1QW98gRbIMVQ6iLAnnP
         NU+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792407915; x=1793012715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUY85gSFYv44ajD0M92QfBXDWEtyEd1ElmdqhoNdS8c=;
        b=icNIMQtOTWRwsbIE2Jozxktji330YytveY9+18HgV5oqeYExe2BHzu21KB5RzIV2P8
         Tn93qUFiJE7iBFyt92IYZ5KeRrNkk9g772Mm4Egn3ZLwUhvImDxfRztnkNB19YSqSA1p
         25EMZZZSfCTvsyXBB0iYQC8kTTSpqCZ6pHjCzt5iYrD2cAZIgcTC6YknTzUrV9gEH0dx
         JAsfwbp7in9HIs+ysKRRSx3TzEzVfXMtAtNi/oUhhB+ou5VdbWyY26IHAq9r+Q71TJ+/
         8fUXm9brEvcgfG1ch29SrsROU/qCS5M4UpMUe1YEte4tfcTUMelz6XBURrKAocdOMsFk
         ZWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407915; x=1793012715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUY85gSFYv44ajD0M92QfBXDWEtyEd1ElmdqhoNdS8c=;
        b=2IH2bPAqy/AYnTpxEei1RrokVcrIR8RH6IvNaLXPe5NJhrlPxuacHvfPFNRrZVQs5V
         EaOX3F8SBeKLtm740JoX9np2l1VL1EWupzP0Yb73bZYiYOf3XCNo8RWlGSVdnREiWlRo
         RhwDYRXpLgIzuPfHbf8Fp636Tvl9Z362cKKjs6KgYdrcjp491SLTO7IliBPjqRw5BDEO
         nGi1RefWDFQSEgm3/yiuhzQ5X9v/3x7wprcF18v0WeyHfHITyFf27QETo5qOBK0Wj6jb
         pBGeHZvZXWoDQt/ppuBNSpxJm7ksZlYxmIDml4KomVN6OLAtGVuMvb4hiVDBtmy9wfD0
         cf9A==
X-Forwarded-Encrypted: i=1; AKwUvBzD6oT0hEGnGQ4RsEZEhyNDj+V6Vd19piPa/tolwTs22YhRvzOgxMlLLBk6Au7hQcDzxBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEuq9lDKJEnTOF+kwrQETtha3Tmc3a3sR/e1rCuqkUtNpvLU9A
	fPb8Wy1FPU5Hwg5xfKsdCO+XYRlwL6bDnJKLbdkPOji4GZuZiwFIBEd1Jl4mmTqhAV5GdseE1bI
	2uslZRo2F1Y4dQ6aBgwNe/AvP/0XmLUa6ekH5H3/cYCFs1OzYUaAE9xXOZrbmtTSktwpVyoLdEv
	EBF5Ff5bvyFe4xvNKQOR2lMiBY5zhX
X-Gm-Gg: AYBFou3XlOtKPUjUvAWklOmaMv2X0ND/TmsTN9cuHh+gsNWPMgk5P8RUL/W95y5I6Bi
	KJYMIL1YCfn0ot0egkOJ3a6eWgZG09XGjbX7oYIQsme8+wPYMQGUF8yqAf7eH5xjAX7MxJiaf3l
	1BtouPDq2EzbzoNYYSq/mpDcndb/Fxck6kwFfWKH8LH8qitDfE7SdLHSjLA/WKG4vpnK5S4OQdy
	OtmRuqFBDEtOPI=
X-Received: by 2002:a17:906:9f86:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c419d83af46mr514039966b.9.1792407915044;
        Mon, 19 Oct 2026 04:05:15 -0700 (PDT)
X-Received: by 2002:a17:906:9f86:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c419d83af46mr514028266b.9.1792407913081; Mon, 19 Oct 2026
 04:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com> <87ik2zryzo.fsf@jogness.linutronix.de>
 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com> <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
In-Reply-To: <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 Oct 2026 13:05:01 +0200
X-Gm-Features: AclHuK-0PstQ9qMVKUz4cfYOyqNQzLRuAx_unL8aytY_f_PVK-zyS2FFzXAzARk
Message-ID: <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:43=E2=80=AFPM Gabriele Monaco <gmonaco@redhat.co=
m> wrote:
>
> > One disadvantage of using bpf_trace_printk() for RV violation
> > reporting is that the event will be caught by every instance that
> > enables bpf_trace_printk() and does not explicitly filter rv out.
>
> Yes, that should somewhat be mitigated by the glob filter, though events =
are
> still generated.
>

Do I understand it correctly that the idea is to modify existing
tracefs instances when enabling an RV monitor to filter our RV-related
bpf_trace_printk events?

> > I can imagine an RV-specific trace event for that, however, it would
> > require a separate kfunc to generate it, and ideally also distinct
> > labeling of a BPF program eligible to call that kfunc. The "rv"
> > userspace tool could then iterate over these labels so the user knows
> > which violation events can be expected to occur on the system.
>
> That'd work too. It's what I initially envisioned but I'm not sure a kfun=
c
> producing a tracepoint is something BPF folks would really like (and tech=
nically
> any other unrelated BPF program could call that, unless there's some acce=
ss
> control mechanism I'm not aware of).
>
> Not sure how much it matters in practice against the glob filter, it prob=
ably
> really depends on the other bpf_printk users (and a mildly better usabili=
ty).
>

bpf_trace_printk is already a BPF helper producing a tracepoint, this
would be equivalent. Of course, that does not mean we want it, but it
is something we already have in at least one instance. I know of at
least one quirk: you can have a BPF program attached to a tracepoint
that will call bpf_trace_printk(), and a tracefs instance tracing both
bpf_trace_printk() and the original tracepoint. That leads to a new
tracepoint triggering while another tracepoint is already in progress.
I don't know how it is currently handled; from what I recall when
testing RTLA's BPF actions, the bpf_trace_printk() event might get
dropped by the tracefs instance, so I had to use a different way to
signal to userspace in BPF actions test.

As I said, to prevent unrelated BPF programs from calling the new
tracepoint, you'd need to recognize and track RV BPF programs as a
special type of program, similarly to what your original RFC did. I'm
not sure if that's what we want, but I see some advantages. In
addition to better filtering of reactor events, you could separate
reactors from the monitors entirely: you could trigger the tracepoint
unconditionally, and attach reactors as tracepoint triggers to the new
tracepoint.

All of that adds complexity, though, and requires separate discussion,
so it's probably not something relevant for the initial
implementation. I just wanted to mention it so that it doesn't get
lost.

Tomas

