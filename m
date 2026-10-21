Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598118;
	b=Qz73iLSFSp6qO5ioaRtFC+DQlrUCG30ymANuF4RRXcO+oFsbxD0It7o0iMgGkUvMuXCg
	 LbQVdJKqqmP1+sE3SK/EEDuZEDrNVTRYndyTfwTwkHvLBaVHVql5XZ4GjVvqHhmde02PP
	 W0uX1Hck0y+Ldv9E6oIBO5SR6hF0c+b6yexfyOMbwwDApxj04KzN5liatRS7YRH04BEFA
	 Y2Ca4WHIKmaXoBsqzU6CtHQrIM0XuGcyVscAQ4j7OZcbYn5V7964sUGbu172kYoI5ccF7
	 6N6/BJzFOr3x+mqIn2/cFserPXA7maWrBicOXdqHVF2vEjQ8o4gLGkyYGeDhNsu1lQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598118;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=pToU2/tKmBBuOKmQ3JkF1D52MBNbEUelNkDVhPvhZ2M=;
	b=PoCLBMdDuIfMS2ljBzDjq+CYXOMu7klEE7Y0w/jpAvuqgjT+trlN7SHgRm7NjXGsmFOb
	 Kh8w5cTnG4AwweDNvNUAn9L1qILUpiVQnYDPL3wKmOPubCXPvaUtjpB6Cq+Nake15wkZG
	 1fMzvx49xtyUzgX7uYPzUcmnamHanItD0PU4vfXGxnSrLOMOnzVEmDO8XkTSf0AQOogWX
	 ciq9S9QzGb3/TqrKrjDVjpVw8yFhKjtSByl+nVcmX5EWgj+Vi0AUJ41Fmt9xvwxhwilTa
	 +Y1lgIdGxdxGpriYkzO7KzIV8ef7V+ElE+qgxIhVl06l+FczYHbxfHLKSZMt7QeVlTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YmVW3J0p;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="aYBenH/U";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A0606A31F
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3A0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YmVW3J0p;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aYBenH/U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792598116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pToU2/tKmBBuOKmQ3JkF1D52MBNbEUelNkDVhPvhZ2M=;
	b=YmVW3J0px5iEumX4zec1lEEx9FZeNfK/B/IqeRXTuJ++AvcM/ImifO/zCLKgVrZSE2ECFD
	M9N+fcsAYZ95pejtficv0aRqVH3nMoOhsASoyKXQ77VESohZMXX4NSH/hZfkd37e1Sdg7d
	NUj5Rl6ZNdU3EJkpteaw9fer39ekpk4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-bIyq5V_vNgawuWUPS54vaA-1; Wed, 21 Oct 2026 15:55:08 +0000
X-MC-Unique: bIyq5V_vNgawuWUPS54vaA-1
X-Mimecast-MFC-AGG-ID: bIyq5V_vNgawuWUPS54vaA_1792598107
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df730c035so636605f8f.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792598107; x=1793202907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pToU2/tKmBBuOKmQ3JkF1D52MBNbEUelNkDVhPvhZ2M=;
        b=aYBenH/U4um/HozsCSp14szk5rY+kY92oxh/XSIY0PKDyjWt5WF25tPUbLIleCAw4t
         rQUnb6OHO8OWj3+3KmJUrOHQavsjuIJpHgeK3gGIGBRCskGt1PAnt83/4+PZsn2PteLw
         HUH+yPE+WgrRO1Kigj+q/lgZGNzrAy0Z/YjQtf9iyzkT3PmsYz+OQGuSxYMFVsLGrmXT
         9ULKsuD0n2dG3xx6ojaArC7DRfWn/C45njdXWrGBGeznwz1t0Dui37YNdT87YAa33xYW
         jg05maOTnsu2AgIEbxURBZV9Ee/daGmt6xsw3CGJTcePPNUBv6m2eNt+8mfvMHrvySbi
         cCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598107; x=1793202907;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pToU2/tKmBBuOKmQ3JkF1D52MBNbEUelNkDVhPvhZ2M=;
        b=utu2Q/81BK9JsWNIDFpa/oGum4WFo+lygvyoHu+3p6YKHuOFQWulajTHkv0Z/Wn5YR
         hFcZ9AOUJphzKUWCIxwL+mbQUeBRnbAWv14RnJ5hk5Gci3sh3lFJ9G8TTN+bNj1AkxUt
         7G5B14CXRYfTejwGFMnUQ78/gbt8IN4cXVDVFm4QY9kvvTWsUCJB3qwIs45Zy2nZ7Ix3
         y+DZaadSAL0YmVd2NRBGhIb/I/yfZbMDhEWuJ89PwHTnlQiV1uizllS0u2iAUh4pg+ae
         OF19xrqGNX7jQRCIrVTQHWgZIljqvI+PNyoGLQ5U+PG8QxraPV1PIp9QpO1Hm8qcyk4I
         iQvw==
X-Forwarded-Encrypted: i=1; AKwUvByMbaY8sDXH/Jpy/5qsWOrhrkvnGAHth3ghRaNwkY6EQfQbN/ObRumlkqya52yGuVxuVEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhJHuvvEgaAFtm+dHbiaDIujNtORLAN8fKJKJ+5Xor5w6LZ4EA
	vJ8FOC4/MYBfDAnUfcRE/COFw2K1mSobgl0atdOUKjtkFSGe8AS55gDuHw82Wo9Wp4RcN66S3S4
	QhiF95kQd64/F16eb+yvtPkpR1AL/Z6wHfBo1LSHYYZv+ZVcGYTgQvw==
X-Gm-Gg: AYBFou0TUoc7n7N38MnziyZ6TfTB+jTwCZrAGZEWhv9yKGyxivNhry+3O4Mm3/lc4Hv
	/4bJ0b+XKAC7Sr7uqlZ2b8hoFdyEQ5B+nyhFXME50aBItgLjspfQKL9VBC8QsRddFDvaMm/GwRw
	XXxZbFjFs6u3dRW/LvgVS1Uhv2tO+HHOYOxFkfQSvX7MZjSxmuwvyufttpp2y+R2jRzsC/QuMD+
	TryDzt7luYgVFDslCjYMd5HiU2mborVJO+wIXcZq2fmazeKx13kZgA+ghKQUNcKGtgJatRgBtV/
	VRGFViez8t4umTsjJql0J2EA2dpTzfLK5g/eqpyvauORoENJQ0Wt1i6y0OSYlCWfX50bekgFu5K
	ybK6jX+3W/KK1sfP/44CAw1w1o9w=
X-Received: by 2002:a05:600d:8051:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a1fdd6b9b4mr47597885e9.34.1792598107007;
        Wed, 21 Oct 2026 08:55:07 -0700 (PDT)
X-Received: by 2002:a05:600d:8051:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a1fdd6b9b4mr47597365e9.34.1792598106628;
        Wed, 21 Oct 2026 08:55:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.34.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a20398f37csm1981285e9.8.2026.10.21.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:55:05 -0700 (PDT)
Message-ID: <ffbb1908cb2a45afbd97814f09f11401a38c179b.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Wed, 21 Oct 2026 17:55:03 +0200
In-Reply-To: <878q3rqpcy.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <b76dfd3e5a118e30ab25910f243db1cbcedc1c00.camel@redhat.com>
	 <871p9mqcn2.fsf@jogness.linutronix.de> <87ld7trgzg.fsf@yellow.woof>
	 <87mrs9q1d3.fsf@jogness.linutronix.de> <87ecdjqxnr.fsf@yellow.woof>
	 <631896ae8e44ed6356c3b79598a2facee8af9770.camel@redhat.com>
	 <878q3rqpcy.fsf@yellow.woof>
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

On Wed, 2026-10-21 at 13:12 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > On Wed, 2026-10-21 at 10:13 +0200, Nam Cao wrote:
> > > I wouldn't enable those by default though, it's way too much noises. =
As
> > > it's for debugging the model, we can have some sort of compile-time
> > > switch to turn it on.
> >=20
> > That's almost what's happening already, in-kernel use tracepoints, gate=
d by
> > static branches. Those are the closest thing you can get to a dynamic
> > compile-
> > time switch (assuming such a thing can exist), it's patching the code.
>=20
> I was talking about how people are going to enable transition events,
> not how kernel enables them. Do we expose some user API for people to
> enable at run-time (and kernel can use run-time patching or whatever),
> or people enable them while compiling their BPF programs. I think the
> latter should suffice.

Everything BPF-related will need to go through the userspace tool. From loa=
ding
monitors to enabling things, but it shouldn't require any recompilation.

Right now I use only the -t flag (enable tracing and print to stdout), we'd=
 need
some flag to only enable tracing.
After that you should be able to use ftrace as normal.

Gabriele

