Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572378;
	b=dQHaKrsKtxebTa2T4YRsI+zmAkRVQdrsobWNHNLpe811cvRdtgHY1E7f1g392GhNQBX9
	 V0pPAQUxwCt+4L8uQK25Dqm3Ga5GfNPabp88XaEgcRByn0Z1Z/AEYXWVhP4BPcV6BmON5
	 I7fxM4SzuuSmWaVNOXgT9s4gUk1H4bhknrvUwNed1yaUG/jtsC0qnF34DDCuAapNdWbfn
	 ptLOvevBD2A1iDvHHMMX73kseIFKvjplnZLn2yK6XItFfh2SpB4XrTsLOBh1eIpI79KUD
	 6V3vV9x31ab0LyaE64sfTOwlUMzhQv/p3/0FM6dYs/qLjyKHT4YVLDBXGULVLYdtsow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572378;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=/yF0JL6Rd6tCEdOsvrC8K9rzM4lbnQgAsaM0D1hAFzE=;
	b=jyQ7W9VaP+XXFQdmGf9n3VGhLp5igsZkeQWEp2iooC2b312bfxwJJtuqxol+4A8lcWXa
	 SPdAyytqEZb2p1d8izvVBlLJZ1raopOoEfmt++AJONHivWkq2i8yMrlntfEWNrGTwU5ss
	 cRzf4MXT/yDBpZ8351C2cl1a3ykC5146yuKs5uRQQei1Q+kkG5D9fgJKvifk9e5w85Up7
	 bGMSu33vFoU0hvx1K9ZZrR4pn5XBE7DEOpGlYUfzp9IgnvCyv9SxClf/cKydhbp/Aq9wX
	 Bn/XUdb9YTVXPGnGgxdJBW/zy1hVjJOP6qaMJU1617TuHmX/M/jGiD5HXW3B2ZtGGoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYuxZlXv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qvvuyH4D;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D8606A322
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C6D8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYuxZlXv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qvvuyH4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792572377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/yF0JL6Rd6tCEdOsvrC8K9rzM4lbnQgAsaM0D1hAFzE=;
	b=WYuxZlXvJ+rKt1yZ1R5jH89Cs6WSpZooooJKR3KMuju3Wvzr7DL6xYUcAXUSdVMLbhkavB
	CXXRYLIOj/K2PkAIfWHMtFzgN3F+q0p/VVEEMNz4VAcpYOSh/SsL93QplinPhW7DNokPjL
	kt+CsiaHPkdE3m0z4c2gGWk4bpm7eGA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ZmBrU9SbMHC_USA0txzi4A-1; Wed, 21 Oct 2026 08:46:15 +0000
X-MC-Unique: ZmBrU9SbMHC_USA0txzi4A-1
X-Mimecast-MFC-AGG-ID: ZmBrU9SbMHC_USA0txzi4A_1792572374
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so397048f8f.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792572374; x=1793177174; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/yF0JL6Rd6tCEdOsvrC8K9rzM4lbnQgAsaM0D1hAFzE=;
        b=qvvuyH4DPZ7mbqZw0+o84tLAY4eSfF2Pr/CMSCe+wX3HfFTPkjAfEsoikWc1gy3Qho
         nf+VEkwdNyZ+cO5kCiYgov7ERaZpwgjLxTKN7qHvwpIPFwYiLjdum/eeOxdnhOCfee/k
         bPXJlJHBLzGBzo0KGhxxmVB8XShaKfaJepnitPhm+0kKP53STmWFbIcEeDMpkth6SULS
         wehdWoCi/dGDR5450s764PZxBiGIQtkVulytIWsz/6kwmJ6VUkt94bRJi5/KexrgyhXN
         KtAKzoykAlxkOsNoqjgVXHYmjuu4zVERuqNpRxeROMBqZ9oxug5GxzBgtDI4sj+Q+gyU
         avsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572374; x=1793177174;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/yF0JL6Rd6tCEdOsvrC8K9rzM4lbnQgAsaM0D1hAFzE=;
        b=r5xn9vNgyic6T6oyIZ6Y3o1Agfq0K5gpaiv0gn3yTjUOSuvnNsvNu1ASQeReNnmv6Q
         z9APFguORCaQG61pb6wT3RjwgveO/RZd1NOcRcuqYcWD+6pIaSTTcPEky4W6qg505i9o
         yt0dTcstYT1wEgotGzZ8VJUNu9BREdK8vbN/1wERFdtMiIgbhQRDNY3j4MAWrYrSxDaI
         xbmUSHV/vbTyCvPDdTx7UTiRMIAHuwzHNWmBLaT8RAri6913nUy+8XDe5MgM9dmL2uUN
         Jiqje7DrQ9qy/VFn1P2mI1zC/IBvIoWHUTqb31teRWXajIIhrb2XDeTmCuAm7VSVAn/J
         vKrg==
X-Forwarded-Encrypted: i=1; AKwUvBxvAttyzOtjZ/rlx1saPReGOzULCSTiJpvz85sVNXKwdbnK5289I5jvFJZ9erm+TOaZUZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO7JB9gA7xA0monQCIAjxPA3BKI59lrJufXEiKdkkysIgqA71x
	cQH+Hz5VuEilrcPVbOp+OfjoByFaOWJIHqYOBQhqUHu7VG5hGxYmNGgRxs1WTNPwkiMv8vCh77i
	Xbgp0rT8bIsVIVxUTrDXY0LIyp5aoFfUo9rtFcfl/AoEMTKeHAnZRap70XSbAJg==
X-Gm-Gg: AYBFou0rYyMp1yPXfDouVGW9FY/5jC8ULt+fnKkigi9uzZENjlzXbRACuIwehBO5A2i
	GmvogmF7FSrQvNI6kbIGHyPc046TUJ81wDQ/5K0sB9QmqbjkNYKYXdh907VCRcAhUKjt/PiPZOO
	Q2NhYkP6ry0yT+UbCafubh87FzK55md4e1sYqGGhTO4mT3lQGPaQhU9t8mqSwriPhVDRaTU4RtH
	zEHHWeVdXvT7y7obKdXRhSyBRQGDGIYDe28zNit+wqMxJ6MRl2jbjj3UJ4UQ3CBo1rKDDd7+LPg
	Oz2tDg3CvhEr+0jPvvX1+Dozp9VLgbnELQmugaLrhxF8kqzqEg8AfrqjaMOiXGbkNAIAk5jdaie
	sCgxE8OYRScEq6m71bGv8UBHjLJk=
X-Received: by 2002:a05:6000:2001:b0:48b:1c:d6e1 with SMTP id ffacd0b85a97d-48e264dd0e4mr2661910f8f.43.1792572374330;
        Wed, 21 Oct 2026 01:46:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2001:b0:48b:1c:d6e1 with SMTP id ffacd0b85a97d-48e264dd0e4mr2661878f8f.43.1792572374010;
        Wed, 21 Oct 2026 01:46:14 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.34.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583ffa8sm4205103f8f.51.2026.10.21.01.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:46:13 -0700 (PDT)
Message-ID: <631896ae8e44ed6356c3b79598a2facee8af9770.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Wed, 21 Oct 2026 10:46:11 +0200
In-Reply-To: <87ecdjqxnr.fsf@yellow.woof>
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

On Wed, 2026-10-21 at 10:13 +0200, Nam Cao wrote:
> John Ogness <john.ogness@linutronix.de> writes:
> > On 2026-10-19, Nam Cao <namcao@linutronix.de> wrote:
> > > John Ogness <john.ogness@linutronix.de> writes:
> > > > @namcao: Maybe you could chime in if you want the transitions as ev=
ents.
> > >=20
> > > No. Those are only useful for debugging RV itself and do not need to =
be
> > > upstream.
> >=20
> > Sure, but debugging RV itself _is_ a use case. Especially when RV moves
> > to eBPF and lots of people will start writing their own RV monitors.
>=20
> Right.
>=20
> I wouldn't enable those by default though, it's way too much noises. As
> it's for debugging the model, we can have some sort of compile-time
> switch to turn it on.

That's almost what's happening already, in-kernel use tracepoints, gated by
static branches. Those are the closest thing you can get to a dynamic compi=
le-
time switch (assuming such a thing can exist), it's patching the code.

BPF gets even closer to the concept, we use a volatile const flag, which is
constant for the JIT runtime but volatile for the compiler (not compiled ou=
t
when generating byte code). Before loading we set the value we want in the
object and the JIT compiler wipes away the unused branches.

But technicalities aside, we probably want tracepoints for events too, so
bpf_printk or whatever else.

Gabriele

