Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD42EC0B0
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456547; cv=none; b=vGicR/g586JVOVy7EkpB2hc8t/yaejYgrd3Bw9VTJxCovBg5qJu4HGPf6MJJvnuKUDUCOS+gn4bnnI76gF245xSVYeTYOWBC8zA+epz9/maPh3U8TdSNC7lSKXG54R1PqANDLkTH1acZykcv80K+RAHKEoei7HF7r7ZCqQkr608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456547; c=relaxed/simple;
	bh=XUdHHqHkpBDhjFo9exdJCuBeB0efNh+zdzWSlsOayRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tu58GwrnC4n3DCe9pUep5puLQ3sXWHBE0dS8guAvHWHg24RXu2aHeE1MEFNiwf+xqLlxacXKGFsPeOn/aBJNoC0H9sGqxkE0wZEqmBoeV7j7GClSMbO6yv47rDApenTYmy6abymOuCk2d6t7drW+yN7LVmYf1BSLEXlh1KCjAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iimwb2lv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6w5KjRS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iimwb2lv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6w5KjRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789456544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XUdHHqHkpBDhjFo9exdJCuBeB0efNh+zdzWSlsOayRU=;
	b=iimwb2lvzANVgVPG7d53OtAAcQelkF4m8748nUraVOdem9Aul1TVrV6e64ignur6sMwYga
	Ui8ymaLeGPQg5fhkg8ZUt1SXjYLmbb/nh3YO8upSWltIDG/MdF5vep4cDwphjYE1rXurxm
	QieJqO2OKZz1VX+0KxWq+Qg6/V1GlQ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-NfC-mKjWPDiZjPRnJV5xjA-1; Tue, 15 Sep 2026 03:15:43 -0400
X-MC-Unique: NfC-mKjWPDiZjPRnJV5xjA-1
X-Mimecast-MFC-AGG-ID: NfC-mKjWPDiZjPRnJV5xjA_1789456542
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4843e59c32dso2701076f8f.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789456542; x=1790061342; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XUdHHqHkpBDhjFo9exdJCuBeB0efNh+zdzWSlsOayRU=;
        b=Y6w5KjRS1R4udpXS4aStPIPF6U8eu+HhTOhdTYIJKiwAi3R+RSDd1Ti2OjN2n1pgkC
         7yftWqJ2ilNYGuSBeEQ+ogFUHaCUcQTx2pIw+y2q0FZej95JeXv5rMVqoxM2D1o8dcG1
         s7y/EwjnRsgIT+AYC1haFJEq3laIc0fy9+ivo2als0NwQPg0SytcwC4oYL0peGKstpNn
         eIYbUjGocKOCCUbU6PCFIoSASfLGvLLIexPJ1iUaEWZ6hFYz5Zu1sk8ylStwBCprWMBP
         YlCtjkhBNCzzSxOMj+S66Bq9bdnWWdG4lr56NuNax6oHdTrTetkhNGXg324PAqGUZnoU
         U8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789456542; x=1790061342;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XUdHHqHkpBDhjFo9exdJCuBeB0efNh+zdzWSlsOayRU=;
        b=xMYAmXx4TTKq9avNLDlEXSSQ5XWjN8b5kkeISK/Mhdnhe2IDDzxrvzitUcnt6tcI1u
         7r41d/x0X7cIzXgPvrS8FAS1xH7YauYODbAhlrXN0WSmBS3szkjMw/770Y/y+O4vGr9T
         yCXiimY3oR+RKz97eltRF14MRRP/vcR/yKsUY6avgkIMctqHYtC0vB2VCAPMSHc9rIt9
         ggfiVD/y3eKhKHgvy37XP71VS7kwv7GnyQ8Jo4IFkXDvdwRSC+zpS01DojN4ss/mT968
         KkkHgPAObRkOTFLyCEIZ1XcJDkNDgX4F4ZljCEZM1QZI7fv9ELmpOufvylwMS+TCHJRj
         BtTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeILU5ARqiR46IHu+B79zTzg+EqzxnM8BW7f1x03VfA9jMLQaDKMFJyZExxiMTPDRPetE=@vger.kernel.org
X-Gm-Message-State: AFuF++m+TP1ILRMIzVacBAc0i76WxAWP3h6UPlNqZmV9aVPkN0LZ5KcM
	Dx7fdkq4GNbyc7vAkgOAxq8MOkRgK2TjeXNwAkTMyJcsY9FzUzJla/2T9aNp1qjgkF61oQtMnZI
	wKy+kCxfMLYMOWfDLshf5bI6BjLNncN7Ohu5XH9GjT3OLg5HpFazwfQ==
X-Gm-Gg: AYBFou0bq+scY1wCnKvZII76w0xQKr5dtRrXOUwh/Em2yYH8jht+TJJkkAulT/9RvYj
	dA2qYWFWbGNfV0tvvg4Vqr/ihOPSwNR3Ja7HmLjnamZi7JgNE2tTrtRsaFG09XFFeSjkYk3RTB2
	jU060UIJdeh5TR2d2a/0GL1Nv39NA6ZVjekgGEj6tsJAAE38va7lj0REjHFLSL+0Xx3UrU/mxOh
	geBH8t5p8eDhFzNeOAYrhUZk2XWh1PxPyBEqvoxNXDKQjaczTZTgWKTS+AroN2Ptw48uQLK69xn
	l1CTKYDkdWl3Cp3PIUTsyvio7mCXzNTE/V3zYcK9yj7p6+towZQMIFL+1Y+rbPrtg1EEb2pPrrw
	0DcC5w4TgqtPd/4ZDxILKxT/6wwuQXQ==
X-Received: by 2002:a05:6000:2685:b0:484:4880:449d with SMTP id ffacd0b85a97d-48702aceed7mr9043995f8f.3.1789456541886;
        Tue, 15 Sep 2026 00:15:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2685:b0:484:4880:449d with SMTP id ffacd0b85a97d-48702aceed7mr9043948f8f.3.1789456541483;
        Tue, 15 Sep 2026 00:15:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48707e00133sm2607417f8f.11.2026.09.15.00.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:15:41 -0700 (PDT)
Message-ID: <1f8caa71b79e70f554245bccaa29b66268452dbe.camel@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Wen Yang <wen.yang@linux.dev>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>, Linus
 Torvalds	 <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:15:39 +0200
In-Reply-To: <DLDSQDSVXFHF.18X2UQUL5Y42D@gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	 <87se3sakgi.fsf@yellow.woof>
	 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
	 <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
	 <20260903090211.50d15220@gandalf.local.home>
	 <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
	 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
	 <20260904123108.1fa1d815@gandalf.local.home>
	 <20260904132421.111c0279@gandalf.local.home>
	 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
	 <20260904194620.0c7a8363@gandalf.local.home>
	 <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
	 <20260904201741.2986efca@gandalf.local.home>
	 <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
	 <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>
	 <DLDSQDSVXFHF.18X2UQUL5Y42D@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-12 at 18:26 -0700, Alexei Starovoitov wrote:
> On Fri Sep 4, 2026 at 9:53 PM PDT, Gabriele Monaco wrote:
>=20
> > Alexei, what I read from your opinion is: if you really want to do this=
 RV
> > thing, then you should just implement it all in BPF.
>=20
> yes.
>=20
> > like the panic() one. Something BPF just shouldn't do, as I get it.
>=20
> There is a disconnect here.
> we have one KF_DESTRUCTIVE kfunc already. bpf_panic() can be another one.
> It will require CAP_SYS_BOOT.

Great, I have also been pointed to crash_kexec() [1] which seems to be doin=
g
already the same thing.
Anyway this doesn't seem a blocker.

> > I'd rather discuss on what is the best approach /today/. And that's
> > precisely why I submitted the talk for LPC.
>=20
> Excellent. We can start this discussion over email and continue at LPC.
> My understanding of RV is primitive, but from reading kernel/trace/rv/*.c
> it seems to me that it's a thin glue between tracepoints and monitors,
> a bit of boiler plate code via tracefs to enable monitors and seq file fo=
r
> visibility.
> What you're proposing is "yet another monitor" that is reusing this glue =
code,
> and that's my main objection. I don't see the value in kernel/trace/rv/*.=
c.
> (kernel/trace/rv/monitors/* are useful, of course)

I get it, essentially the point of contention here is that, besides loading
tracing BPF programs (the event handlers), I'm /also/ loading a BPF struct_=
ops
program to register the monitor to the existing in-kernel infrastructure.

It is indeed not fully necessary to have BPF monitors share the same sysfs =
API,
as they still need the userspace component to do useful monitoring.

> What stops you from attaching tracing bpf progs to all tracepoints that y=
ou
> need, pinning few "bpf iterator" progs in bpffs that will provide text or
> binary output via seq files, run a state machine inside the prog,
> and do whatever "verification" logic inside them ?
> You don't need the rv/*.c glue. I see no need to introduce new bpf struct=
-ops
> api just to look-like-a-monitor from RV glue perspective.
> "runtime verification" as a concept makes sense, so focus on that.

I actually started my POC without struct_ops, activation happened by just
triggering a dummy BPF program from userspace, but I'll look into these bpf
iterators.

Essentially sharing the API simplified how the userspace component handles =
some
things and allowed to share reactors.
But again, that's not necessarily the way.

Thanks,
Gabriele

[1] - https://docs.ebpf.io/linux/kfuncs/crash_kexec

