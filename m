Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E434EF0C
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420087; cv=none; b=OkLIxZmVJ6+n/TvGH5Phaw+bcfc7EBR1TgTAIf6mns5KyWA0IN+BZAb+7MZufHTkjZ6ehcCzEvfp+Qi9tVfXGDY7JHfXMki75x6kOjtY38LSUoZxieCDkxACyjUpLnMy4/8Wohy+zTw2FFL5D8QWQU5RhfsUvYgnUSrILWyxZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420087; c=relaxed/simple;
	bh=ybHCFlCHnPihYn5m+eFTCajuqHWBe7MyBmieJjWE1J8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wj6xhOh127LbWP0eS/hWZR+Hlh6rORoe8vnMgJSndEa+vWtmqYNw08QH6XuUtOazTWuDXkwdpTVHWPk/YrWuo2c82EzIB1ld9WTn0XfI/IkIFWOy3c/C4JWAB6jC6xUhmEevDRQG6OYvBe34mdCV+dENqfG4cV+cI2RAhNGWdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VX7Dwdhs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mv7UfgZ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX7Dwdhs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv7UfgZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788420085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ybHCFlCHnPihYn5m+eFTCajuqHWBe7MyBmieJjWE1J8=;
	b=VX7DwdhsVNh9+ONPDGPiK2sC3K1gP36fQzbNGiEs7bxFZyMt+KnRJ6B1jF7WunTTpkct5C
	cLh8owNgFy8rRoppGAoTLDSBkjZcKt/mipnBydiL98mzYdUex33uG3HVdjHfuMr0ABPYph
	NtV+eF3j4stzGa1+4FZEdGY9SdmmKag=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-7oFzRij5NQGcJzwuMBI1qw-1; Thu, 03 Sep 2026 03:21:23 -0400
X-MC-Unique: 7oFzRij5NQGcJzwuMBI1qw-1
X-Mimecast-MFC-AGG-ID: 7oFzRij5NQGcJzwuMBI1qw_1788420082
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48439ef42d8so1748741f8f.2
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788420082; x=1789024882; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ybHCFlCHnPihYn5m+eFTCajuqHWBe7MyBmieJjWE1J8=;
        b=Mv7UfgZ0YCIStS1ldJeulAgHjM/mCtnOVrCsQTNz2bmmBDs8Zxw8AKd9iGXjjYq+fd
         HAEyynraZwFiHpPj0/4MoBdeSufy300phzF5ANPPuWuIdpqZeJUTUIW6A/XT8rUeF/f4
         gb5rnboU4048PpNxFW9dpAA2o/NU3hsJUB+HBk8OMLAmjzuGLAuV+EgrLdvEgjOXnymB
         dy5FN+HPXq746GnUb+4Y6gywuBJQFjfTqQtB7fDiN4N4w57ahbRrJ5uqMbZKfXlN4sli
         +v2e7dYQS0L8ooE/mI12FuAu5RFXI38Th2dIsTt/vVTzy5YgHSWX12JZcOIsGcCJ7V9k
         Rv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420082; x=1789024882;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ybHCFlCHnPihYn5m+eFTCajuqHWBe7MyBmieJjWE1J8=;
        b=ZmrZd8yfOsofsTWGYOCjkrdUP3V3wpGTBZqYrhA1QNjDFwPZjztzFUfKW1wawMNAqs
         WUVXiwkbiEg5a6OxPzFk9ax919X0W1E2s3/cl3ylkpMO2bPCsRUtYSMQ3Hp5APFczl87
         FyXFI6+Fp2Cpcw8TOLiX6B1j2QaIO5br5dHreAeZjI0LOZyMuIlS6jm2xDVua8hymsvP
         ZZvqovXRs7BYQB1nQG/mqgqf1rjmQw4/Q5MSf9eBgZDDtRKG6NiXm8AwT3Plq1pUKx2n
         4uGPr7k7+NJI+vDPPQym3ST05ZK3yTW3PUsNDj3az5vfi94ptJKCo8Mz02lNbO7FXuW1
         XDfA==
X-Forwarded-Encrypted: i=1; AKwUvBzAfXvM7v3Tv2Sma5zDZDPf9tSoC7dE6IpmexS93vetTqMbYDR6/xYmZDR0MNy0/wHOD9Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lZg9Gwn+ffHGXhNVnK2tUuEMlIVEYWa5riW+P0ky9cOXnTB7mw
	3GViR+XaPiojhugE18JMLTB6kJMPfS1rQwkAxIL0pSMivrNxErK2gnsYKH6GPSV0ccf//+ZwPYE
	/4JVBGFD+G4qGAHMaNITlgBhfd9ueV7bl9IVgp8SGqi8ug2zsV1Pt9w==
X-Gm-Gg: AYBFou0zCt9CGTL/zMedyMS26JN0kk93cx60s3PZT3wpZ0UlI1cQX3OZravVx9bNz4m
	r/Ym4JNcLL3fJ0dJ7vjjNYZdQUEwC0uRkFzZ/tNzDCqPmUK1oxXZ0c/ghbfQ0Fp/3+G/i7mhAuy
	BK6Jy3skXchG03wrZ+jrlWIaxg15Z3HwQozRGUe07ddhx6Idql4qD1ELZZ0Yh3q79RGJm53kIoA
	D10BUg+ALqZqIpxXp6+5x7U1JQgNngzMECbOnYAi54MiCy6HyGfPZIeY0SYayswMLF1/W8d+SNd
	G0U6MDEeb8vOkjo+QvMZP68rM4zkhM2rWgxhaM05G9+vcWmDZxgpqRib8ScIfmeuzB/MYrsBj25
	NufG9J61lFTrYlLjF/qjrliHKRI3NFA==
X-Received: by 2002:a05:600c:6296:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-49ce581635bmr196789675e9.3.1788420081324;
        Thu, 03 Sep 2026 00:21:21 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-49ce581635bmr196788945e9.3.1788420080986;
        Thu, 03 Sep 2026 00:21:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d9c6sm49952545e9.11.2026.09.03.00.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:21:20 -0700 (PDT)
Message-ID: <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Nam Cao
	 <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Date: Thu, 03 Sep 2026 09:21:18 +0200
In-Reply-To: <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	 <87se3sakgi.fsf@yellow.woof>
	 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
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

On Wed, 2026-09-02 at 18:57 -0700, Alexei Starovoitov wrote:
> I don't think bpf fits here. I haven't seen active use of RV and even les=
s
> so of any request from people who want this kind of programmability.
>=20
> So Nack for now. Sorry.

Thanks for your opinion, however it sounds a bit harsh to me.

RV is clearly not a popular tool, but I wouldn't say it doesn't have active=
 use:
we're actively using it to validate the deadline scheduler/server changes a=
nd it
already found a number of issues (e.g. [1], [2]).
The RTapp monitors are used to validate if userspace real-time applications
interact with the kernel in the best way for predictability, as far as I'm =
aware
that's regularly used [3].

In my eyes, the missing piece of RV is in fact this programmability. Adding=
 a
monitor now requires to write in-tree built-in kernel code.

There are strong use cases for domain-specific rules that aren't general en=
ough
to belong in the kernel tree:
* stricter RTapp rules that may not apply to all use-cases
* verify some exotic system within Linux (e.g. a co-kernel [4])
* modelling for functional safety certification process (used for in-vehicl=
e
OSes like RHIVOS)

BPF seems the natural tool for the job to me. Mind that RV monitors would b=
e
simple users of BPF, requiring only modifications in the RV subsystem but u=
sing
standard BPF facilities.

I'm totally open to discuss on this though.

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20260522125833.264145-1-gmonaco@redhat.c=
om
[2] - https://lore.kernel.org/lkml/20260113085159.114226-3-gmonaco@redhat.c=
om
[3] -
https://lore.kernel.org/linux-rt-users/20260826132153.2476006-1-bigeasy@lin=
utronix.de/T/#t
[4] -
https://lore.kernel.org/lkml/20260827072400.45734-1-tobias.schaffner@siemen=
s.com

