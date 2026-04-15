Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A3E2FDC38
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231398; cv=none; b=jVswVzFoBO+o+rUiPN4kmLSPn3zco8MO9JznIPI8b5BPqT/3Ajmh2ZbRzVMbNhx+kvVHamx4CmMvcyu4tKhNK7jRUAfdA5aNpRlGs2di5WFbS+XQ5+n5LrBzyxj02RqmumSHYLYGfOReD2s5RnPopINQXt/E4D+22TR285Pd1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231398; c=relaxed/simple;
	bh=iORL1P7Z/n0caSdBPfUna1GZ1X7iXCUGb4fQqBqaAfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlPTdhad2sWwn3Z1MYqjXk3FOsOKnLxm/5xvgpSBWPQGRo0RQtuMjUWg/2QaJuNmVp227md0mJ5VDXakubuBPrV/nM3fX3uBO9O1KAdHGPY+KYp/jj3K25XbNOrroXqt0SnAJKymqC4pGXR5Ezk2d9dU6BqlxXAqIfqzQMDdJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FIPtJfYj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FIPtJfYj"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso919509066b.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776231395; x=1776836195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8KKJygtnDDN/5WGL8W/j/BIyO+yT9kmos17/QVWChJk=;
        b=FIPtJfYj6h4iBDASb8qCHOkTDIABH9DV4Ghh6n24YEU7IkZvA/r1DyXhLBHKB0Nm0v
         15vfoV2sAAD7I3uu8PPRcUXCh4qf/o7wxLU7/vj5l+sxhGkbFwR4rO3ukBHh204exKlH
         sVhiFdWIbpehg9HLH9XBQUAmKi6/JCMel5ZFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776231395; x=1776836195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KKJygtnDDN/5WGL8W/j/BIyO+yT9kmos17/QVWChJk=;
        b=F3KkKSPKsECSYIRs3Ly5x7trXqjP02wBuDOtMSCw+XXvkwT0K+GBOL0mfDJK13qNEK
         gQVtmFPTVvlNuyDooI2qQTa9AArHx1eMLJBsqJ5/WawoNvRDqdA38uSDfw279wBzvGLM
         TjnmM87I22UVCSnYjUajh93OUBB9B23KKKoEqbZXAtRULG9SX2ebRt4tK4Wc9ab8VsGO
         x7kvvnl7D+z2xVwSJCsjfSlLgZEanoEOXA+FeuQ+IwlRaid31QMUoR8Y4h6AEZQ1Co5p
         njYT7iOM+TqSS04Rmt3JBhgkcnoFo4LCk/05TuFP7iqxaPFscc6UtrDk70NIsz6lyS2n
         ufGw==
X-Forwarded-Encrypted: i=1; AFNElJ8dBNR7qBmS95TkvVzlPcQGGIpIm4RCHh3AZhEsGszFv03ict+I2cQNCwvBZAUtQFyPuTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSoDbcxMq6LrQPtcbGqP3L+nkq3jQfG4vbPphCbx/l5vi7FBE
	+9+V+IyMsGjtJ2uhkHmJYpcjLnnJPnkmF0hGotKA1WdVfc5/kFKIvlH9Cq+jtiMdt9EAVgiJsew
	0QQHpqgc=
X-Gm-Gg: AeBDievIR9MBKbFCFmit7GZGkq5V+wd7js1yReOfGf+IQMs5oeAMkevL72TUfW7rBSs
	MY9NOIRE42Fgtv0EjJ9D1COOhfWlfq+BegENfG/Av9gV3EzfIfqiZ5gP0ELVslRFdeaDNb6s95+
	ooK15tRVEIJ5YCIFT5fdJHC5hOLNMcMkZK7+VE3vbJrqwFbS5XMCY/Y6ZG5Pb1YpK6FeGFUJlpK
	Tu4KG7RphPRfxETtxsR0r36sShCjtTM0DSx8v8MuF8m44f5KrId8gnHyag446hpsGa443c68rHi
	6Iqd75CsE0BwbE+iVOUt1equenzXv/JVpbH4IZnpTn4oxpFCJR5Yc4RNP8SPFTe5KG28hEukXgo
	RcpvAwD2eCthzq2ObURavyFSkty6s9rmhKezlHVj4eSBB/yRU1shpH+Wqbw8Oup0eXt2TltpGIS
	SNXzKqe5y+IERDLro0DFgP0b97Tre7jCtc8n09ycwTOvfrkFlewm4w+A9ZB0DZvwlNjlR+map6O
	qoeiMVC/fA=
X-Received: by 2002:a17:907:940a:b0:b9c:bf69:8b54 with SMTP id a640c23a62f3a-b9d76d6d812mr1167966566b.18.1776231394533;
        Tue, 14 Apr 2026 22:36:34 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba177dd36a5sm18697566b.54.2026.04.14.22.36.33
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:36:34 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso919505666b.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9a1c0d0kSUco2DAXBs7SfJ9n7JIIpZx+wFq4sl+UN89dc4SksLNSW4w17lQMM/fRG/Tw8=@vger.kernel.org
X-Received: by 2002:a17:907:7624:b0:b9d:4652:f7a9 with SMTP id
 a640c23a62f3a-b9d4652f9abmr915664066b.5.1776231393210; Tue, 14 Apr 2026
 22:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13> <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
 <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
 <CAADnVQK4MOCe=oJPgUXwZdwTu7ZK_WjmpO0jk87A+j0zJeaCTg@mail.gmail.com> <CAADnVQJ=MoiX4=guPWhL9vtnAELkpNx=GNm8RA1-aV424UFz2A@mail.gmail.com>
In-Reply-To: <CAADnVQJ=MoiX4=guPWhL9vtnAELkpNx=GNm8RA1-aV424UFz2A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Apr 2026 22:36:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-bwQkr9To3Z_fRTYF8tZK+WMVWJ8k=ACZVenZbQfUuw@mail.gmail.com>
X-Gm-Features: AQROBzCIyFqQPoYaZGcAJbVqXZjHkqJ9P3PQ6q-WHRg_Gl28uolFaAAZ5tvEv_I
Message-ID: <CAHk-=wj-bwQkr9To3Z_fRTYF8tZK+WMVWJ8k=ACZVenZbQfUuw@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v7.1-rc1
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003bc01a064f79192f"

--0000000000003bc01a064f79192f
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 22:01, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> and here is a fix mainly by claude with a lot of nudging
> from my side.
>
> Fixes the boot for me and looks correct.

So I think Claude isn't quite right in the explanation. Your patch
works, but I think it causes the double arming when preempting that
PeterZ tried to avoid.

Here's what I think I'll actually apply, generated literally as the
difference between my original merge and the final one that was
influenced by the state of linux-next.

And it's not the "irqs disabled" test that I think causes problems,
it's the "state.exit_rcu" one.

We should indeed only re-arm the deferred hrtimer if interrupts are
enabled, and that's what the code did when it was in
kernel/entry/common.c irqentry_exit().

But it should be re-armed regardless of that state.exit_rcu thing.

It would be lovely if you can still verify that yes, this version also
fixes things for you?

               Linus

--0000000000003bc01a064f79192f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mnzm2ual0>
X-Attachment-Id: f_mnzm2ual0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oIGIvaW5jbHVkZS9s
aW51eC9pcnEtZW50cnktY29tbW9uLmgKaW5kZXggN2FiNDFlZWM1NDlmLi4xNjdmYmE3ZGJmMDQg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oCisrKyBiL2luY2x1
ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oCkBAIC00NzQsOCArNDc0LDYgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGlycWVudHJ5X2V4aXRfdG9fa2VybmVsX21vZGVfcHJlZW1wdChzdHJ1Y3QgcHRf
cmVncyAqcmVncywKIAogCWlmIChJU19FTkFCTEVEKENPTkZJR19QUkVFTVBUSU9OKSkKIAkJaXJx
ZW50cnlfZXhpdF9jb25kX3Jlc2NoZWQoKTsKLQotCWhydGltZXJfcmVhcm1fZGVmZXJyZWQoKTsK
IH0KIAogLyoqCkBAIC01MDEsNiArNDk5LDcgQEAgaXJxZW50cnlfZXhpdF90b19rZXJuZWxfbW9k
ZV9hZnRlcl9wcmVlbXB0KHN0cnVjdCBwdF9yZWdzICpyZWdzLCBpcnFlbnRyeV9zdGF0ZV8KIAkJ
ICovCiAJCWlmIChzdGF0ZS5leGl0X3JjdSkgewogCQkJaW5zdHJ1bWVudGF0aW9uX2JlZ2luKCk7
CisJCQlocnRpbWVyX3JlYXJtX2RlZmVycmVkKCk7CiAJCQkvKiBUZWxsIHRoZSB0cmFjZXIgdGhh
dCBJUkVUIHdpbGwgZW5hYmxlIGludGVycnVwdHMgKi8KIAkJCXRyYWNlX2hhcmRpcnFzX29uX3By
ZXBhcmUoKTsKIAkJCWxvY2tkZXBfaGFyZGlycXNfb25fcHJlcGFyZSgpOwpAQCAtNTExLDYgKzUx
MCw3IEBAIGlycWVudHJ5X2V4aXRfdG9fa2VybmVsX21vZGVfYWZ0ZXJfcHJlZW1wdChzdHJ1Y3Qg
cHRfcmVncyAqcmVncywgaXJxZW50cnlfc3RhdGVfCiAJCX0KIAogCQlpbnN0cnVtZW50YXRpb25f
YmVnaW4oKTsKKwkJaHJ0aW1lcl9yZWFybV9kZWZlcnJlZCgpOwogCQkvKiBDb3ZlcnMgYm90aCB0
cmFjaW5nIGFuZCBsb2NrZGVwICovCiAJCXRyYWNlX2hhcmRpcnFzX29uKCk7CiAJCWluc3RydW1l
bnRhdGlvbl9lbmQoKTsK
--0000000000003bc01a064f79192f--
