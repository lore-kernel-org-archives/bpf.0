Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596250;
	b=uO+WBh6bUIDyNRLlGseuVSMsx22OOq0LCZyFta7W5xd8QnZ/4wGa2IegDcDTRBT3skD8
	 SeakHzd8AIbwZCRDljCJKdIl4DvfLfvxU/faXBc7Q7LSUJtDh9QcOuD/zpMAM3K+WiNlc
	 mDC68x9xDPmmm7DBBk6RAP1lX47FgvbyYyxJfaLlVLa4gdFITavx4X/akz8ykOxOF0stm
	 mTVnCKqTNys1V4N39KKbriwdcLGaOkZVonnFmTfxhFvN+hCcYJFMtoDVUAyqJ0oLsXf0F
	 KDolgP5KR4qPmPV7NiJZKQes5EnnnQ2E3jhfDU6cgMoPUO/2r1rOJShrI2miWDRynWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596250;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=FOdC1U/zHYhK2Lt5MZ1OH2V/qvZIRZuOE3CFRr+zeO4=;
	b=RUcRN3mv2EblRYhKS9Gt5mDWzYskIwuUJExnDnwAwAgmMdH0gHW9vKdtlAuWBTjDU1vm
	 W8V89nOrn/tU1Y6yStUNfKfHy0AAWm7ymyfdkUY5fexQ3THGFCqcO+8CKuF5/i3GrWUBj
	 3dWI+xZlRqxFfdqj/4UkzKtNE4snwgNLg/Il7wcJd+EPh9u8usRQFIOvYct8+M76hHQ2I
	 CFkqRR//Ms6Vt9zSuN/PwHLa+8RaEvLT637UOusMDTYtwSg/aK/NtRqKPcrJUbiwWqD1f
	 REneq5oZ2/deBqQGYUg5sV/8uXtkgj5rMthmbqfT7ndrIgsv/ze30qDetTASkAr1dfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T85XaMUa;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BSOLag+6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E633606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E633606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T85XaMUa;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BSOLag+6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792596249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FOdC1U/zHYhK2Lt5MZ1OH2V/qvZIRZuOE3CFRr+zeO4=;
	b=T85XaMUam37kFzZ2M/IgIIhvB4AaDlLZ8PW/1DCIqM7iaCzEeuCMPi69wO/QR/WOLGgSKy
	XMfyJGEp5sf0o8u01ju47jxnrN6hog94832dv5mCERizIs3AnLHqMiLizC5r7BwRiBLo/U
	1r0OMVCtztMNgQq8TkyMDq8+C1X0+Hc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-bifhmjFUOvyV2W2w6BfN3w-1; Wed, 21 Oct 2026 11:24:07 -0400
X-MC-Unique: bifhmjFUOvyV2W2w6BfN3w-1
X-Mimecast-MFC-AGG-ID: bifhmjFUOvyV2W2w6BfN3w_1792596246
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a16faefac0so5158475e9.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792596246; x=1793201046; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FOdC1U/zHYhK2Lt5MZ1OH2V/qvZIRZuOE3CFRr+zeO4=;
        b=BSOLag+6jpFgEK9MhYfDdaXJ24Rqbo/miYOuwOT9gu9NL3PT1vrf5t9GQTZUS0OBZa
         4xbRTp33LH+rwHHWb6b3cWc/Ooputti3XsmQ4iBSxsrLqTn62p7vL1Qnoo3TUJxwaQfz
         bOqr+b5WposkyJA3iAwBXiR6Hxw1/3FadvXe1CxdavV3nLWuw7tbXCi2XOTcv4KTFpvV
         o3fqOqRyTlSpLvSknNKJbvCtLLBfud8vB6Fo0AMwlmpzDKMQP9+uBvUySC7vmrSV6qSR
         byv4TdA6YO6MseI/cYkWIgHZH7pfnwNwstzv4ycRMRGItUrJWIbEcVfoVSfpfkNsAwKW
         pOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596246; x=1793201046;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FOdC1U/zHYhK2Lt5MZ1OH2V/qvZIRZuOE3CFRr+zeO4=;
        b=yZ1V4RcpYWv7DngFwblggc4HT765ZZlYArbYDn1uHcofXhzJOgAjP3HhsFMmrO4xZ9
         EuFjYYQJlTe0BsfChKm2kl20CdSvIpJKHTGLiCGUpV9LQqYhHer5FG7kmTy5LBHvQn5U
         i8eLnLSSkkCf32M46EBLD8aRTR3EO0T7YsI7mBd3KY41d/yMVHr2dJRSCYvcGmpv9B2N
         XrYosFPgz9PYxGAmJCCCC8ns9Y2FoNaaHgUbKilvYTyzbmrbRxTk6hy/6FnYY4LtAwAg
         mZIpaq0yhgCltHql4s/o7g/ei+J2U1maXHV5BDcbHtQ0wZbvZ4RRv5Q1pQSPQ6vCFFDv
         OlUA==
X-Forwarded-Encrypted: i=1; AKwUvBysqbJ7gqQTl8IO/W8gyt/EwrHFfbFPUzf9Ko3Arc2Ufj1hxjwYQOBLttztN7tOHK6tSsE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaQMGh/AS7vue9jvhOa30EW3WEUXg4bGV5X92gzWj/wsLo/WUs
	0tmfjDOHk1KwVuRmEVG1Mntnr9EmfZeJe3S5JGeLcXvFORvQqDCs6yMDq+4BwcEFiu2ogAdgBZY
	OURRJ7aTecTE686zqEoGx+lKXiGMkR+sh508lwGIQMz68Bqv3jgIEWQ==
X-Gm-Gg: AYBFou3ktAi3kLORdfONfOYnewu+FgqY23X/HoxXoc+1fXMvJbLGZKLvZ7WKpLq3M1t
	B1lt4URIfVFSpkThymazg+MmDPLtoq+Zw5/pfrXNIhNKXD4CgW5FvDVsh80VMBbZBxfo3jwIy2+
	Wl+B2gCoSHiFWF/Q5lfTz45m5AXrwF/d43DKFpL2fB9ud/cBYRCJT80HI3aro7+nc+SRgekRW/g
	G9Ahw7BQiJbhuXYTulLo9tF0HQPC+BT8TFTGmSURVeET++y/J8kGe2FpO+w49BYb5SrKplUDALo
	Ux5TBQV4ndsrQK/wtefdiVLPvNfX++TH7YdtsGOGglM+soPKSU6Wnw/UwFrcwwe6Cdmz2HXSgaD
	T2bvdAOPug2hBYRrewnsz1vLzDUU=
X-Received: by 2002:a05:600c:46d3:b0:4a1:97c6:d2e8 with SMTP id 5b1f17b1804b1-4a1fdd234a6mr52767795e9.32.1792596246446;
        Wed, 21 Oct 2026 08:24:06 -0700 (PDT)
X-Received: by 2002:a05:600c:46d3:b0:4a1:97c6:d2e8 with SMTP id 5b1f17b1804b1-4a1fdd234a6mr52767205e9.32.1792596246041;
        Wed, 21 Oct 2026 08:24:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.34.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcdd3856sm7018605e9.1.2026.10.21.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:24:05 -0700 (PDT)
Message-ID: <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, 	linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	bpf@vger.kernel.org, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner	 <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Date: Wed, 21 Oct 2026 17:24:03 +0200
In-Reply-To: <20261021094853.29b9f7be@gandalf.local.home>
References: <20261001152042.124445-1-gmonaco@redhat.com>
		<20261001152042.124445-11-gmonaco@redhat.com>
		<DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
		<b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
		<DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
		<878q3xtptq.fsf@jogness.linutronix.de>
		<8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
		<87bj8s8ih9.fsf@jogness.linutronix.de>
		<DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
		<87v770uuyr.fsf@jogness.linutronix.de>
		<DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
		<87ik2zryzo.fsf@jogness.linutronix.de>
		<0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
		<CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
		<8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
		<CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
		<87pkx5q1w4.fsf@jogness.linutronix.de>
		<0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
		<87h5ifqy6w.fsf@yellow.woof>
		<a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
	 <20261021094853.29b9f7be@gandalf.local.home>
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

On Wed, 2026-10-21 at 09:48 -0400, Steven Rostedt wrote:
> BTW, I'm curious if it isn't possible to keep both in-kernel and BPF
> monitors? That is, for those cases that do not change often and has a wel=
l
> known model, to simply keep those as modules and hard coded.

In my opinion it is possible and I'm designing every change with that
coexistence in mind.

I would say we could only drop in-kernel if BPF does such a great job to co=
ver
every single technical and non-technical requirement or use-case, AND if it
makes maintaining the whole thing easier.

But I'd like both to be fully ready upstream before taking that decision, t=
hough
I'm getting more and more sceptical.

> But this entire thread started with people that wanted BPF type of
> monitors for more flexibility. I would argue that is an entirely separate
> use case. For them, it should be a fully BPF solution, with a few hooks
> into the RV infrastructure.
>=20
> It currently is a big unknown if the BPF solution can handle all the use
> cases of the current module method. My suggestion is to not try to do so.
> Keep the module method for the more static use cases that do not need
> dynamic changes. And create a purely BPF method for those that need BPF.
>=20
> This thread is sounding like there's different requirements between the B=
PF
> and module methods. If that's the case, let's keep them separate.
>=20
> I agree with Alexei's first comment about not adding BPF to the module
> method. But that doesn't mean we need to eliminate the module method
> completely in order to use BPF. Instead, just create a new BPF pure metho=
d.
>=20
> Perhaps in the future the BPF method may make the module method obsolete,
> but I don't want users of the module method having to do all these
> workarounds just to satisfy the BPF method while it is in development.

Agree, from the initial survey I had it seems some folks still prefer in-ke=
rnel
monitors with current infrastructure and cannot migrate (e.g. cannot build =
BPF
in their kernels).

Right now we're trying to understand what are the non-negotiables also BPF =
must
have and it seems we need some sort of tracepoints (via bpf_printk or somet=
hing
more convoluted).
That makes it converge even closer to the in-kernel monitors usage, althoug=
h it
still isn't a drop in replacement.

Reactors will stay, just probably not in BPF for now.

But thanks for chipping in, I fully agree.

Gabriele

