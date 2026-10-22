Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668867;
	b=eg2uQ0mwCDJyW1xAjYT1UVsu/CK0+3ylGRcRgl7aRinBFRTpJXAuCHxpgHY2bCvcdxn5
	 06XNYAdGf1FbIWv1pbJsuyvD7sP1FKobaGmKLqdOIE1keVvUvd5xaWoPXWww1ie9aIkah
	 YqFvexFzv/PkmhsMLylhkcLSmcqfRD8Kd6DAkO+KieeLfBo8u4LGLw5UUOEMC0KB3IIlX
	 ZiuKxsakKNWalwBLm76+p6MJsTn9SfeZkIQrDw8xSMAq3dBWAyWEjSJQSeK44vofxQbsW
	 HLUM/QQeBRh7lNAhEvR0q5Bt5chuTyL86sYUeAVkgwiS1/ztNVYAdFsuH1AQul7vxNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668867;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=lMj2kvVg1lQ863+tJTpQ87BpPz8MFNV5FHGdt2SXwU0=;
	b=WZwq1ABaPeax2f5DPQiG/GlAjBnhB/RDMBxU/RAozzGxK7ZVVw/8XlCeNTqAtqTeRvrn
	 MpJhF+Em2NgRFY+c+tdi6q29pHL0XOce3c2iksKfpJkfLi5rzS8ZQR06fnUd8x0wXFTt5
	 sbUkOSvu9FZu0JgJrSpqd3C9a87wHFo8XNAglzKnTWe6QHcnyZ4WYOd1kQ3soejop3x9Y
	 J+JRmkV4Jt9it8JkmAA3WIL6GaxQ6sAJS63Q3V/AcU0pkBL1cCOTb4zTedIHtnFpC6Eak
	 GzP4vpjF7KgH/8hWZ6RfhkiYyeqCqSayTptsFxx/nnyaJ2r3xzDdNhekYsLD1oqIXzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MHzgJm8j;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VNCn1lRY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADD606A31F
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 11:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8ADD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MHzgJm8j;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VNCn1lRY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792668865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lMj2kvVg1lQ863+tJTpQ87BpPz8MFNV5FHGdt2SXwU0=;
	b=MHzgJm8j0rW4IXqwVTGj9d5GsXNjj3+tsfSdZZUx1asvx5fpKz6jurYby0075TmSzHR5zj
	XppaOzr9k888Z7P/3rRDWXpTI9WRaSJDLpr4iSzvHN/BRG15oEZKr6a91Mzn/ud6JIkQge
	HaapCW1L28r1eIk0IpYYQO/kmrWeVto=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-k8n8JzzDPmOUA_QoUua1pw-1; Thu, 22 Oct 2026 07:34:24 -0400
X-MC-Unique: k8n8JzzDPmOUA_QoUua1pw-1
X-Mimecast-MFC-AGG-ID: k8n8JzzDPmOUA_QoUua1pw_1792668862
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dfa054f26so1315608f8f.2
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792668862; x=1793273662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMj2kvVg1lQ863+tJTpQ87BpPz8MFNV5FHGdt2SXwU0=;
        b=VNCn1lRY7rpV/OiJouz+F2pkDLyV+PsgeLgGJMRTPGEI2a0N7zUtxz/mwWqJENDnMa
         ZE7bcaGtpZVs6n+swUKT7VguHdnmCNRVbUM6ico7YQuFuswg1u6Qg/XuzXuqwSXdrgK9
         mEthcSss0sqpMUDm0X+EWhHZythFQLHCOCFITGPYMUPYzzGVkBLj2XpG93gaez2KhEzV
         wYC+qimg3G43g4JbzFIexSMHbnd8xsQtWKR3WVPGBr3w2ySYNc5sz3a3pKcm5Cps6oIg
         C/0Y3I1qutrrq8iLkRWkHBu/DMizS7h7IBgbGax8lcaGElil4UBjG4DG/AulKdkGRnKv
         t71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792668862; x=1793273662;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lMj2kvVg1lQ863+tJTpQ87BpPz8MFNV5FHGdt2SXwU0=;
        b=FrZ+T+ZKlY4k/se9LUpETXU9nBiARiKxnQgb+FN1mkAGeKQfgz2bYauaUOzwVeS/dj
         4QVy9UcvbTWouV06sjcpqM631VnbMUUzt+unY9VKzweE1xnGtwxiCHkTWXztrwUeMh61
         Rgwb0hOBWkmmxgHWLSeCZRdrwYPMOgs0BTRcZ0y2G0c9jfrJBk1Oh1ZtNtqVXZKqdzmC
         Sg+6x50BGca1nNFj5DdZw8XMxEaDkaY+HlTGbM1h+71JQWKr1bQH7OClPydrfMTq309v
         hgTjjYLrPuHSwB4m2VqqC6rPXSqo3x+3AucFFt+S+ZhC6g2kgt3buBRyqVKtYwGyHyP3
         /7Fw==
X-Forwarded-Encrypted: i=1; AKwUvBzppOl3E6R1o5Qaysao/x9GhSObruvtnOvHyD6xMJsoplpTu5Vbaf/Uw/0e28CI26bHp90=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnVD12XErWAS5qZ1aS0MLrN+ZWnZxCTED1RgdbKLO8ilwyiJ/a
	17tYQY1k615CxFbX+h8fd6f0pvvI1tx6b4p+mMvalgKrZNTCczQCbLRWFhLwHkxogJN0ZPqYU+x
	Hmyc6NZLIosNmdZZRsK6kkEP1tMhnJGrUyM6qT242T04wgkkphkeUJQ==
X-Gm-Gg: AYBFou1HMaX8ii4ONdxXp5Krq3/i9qr9+6guf0vyVMTHwTOWclZvVFKz3L2IcEsPBS+
	cDsrX//4wRQtYHNNfePhrq7I7+BHYUA09//p7nFxPYsunT3m6593wyywOCe4faUUTVLyq0rgxWM
	Lr76eyjgNvu8L13swcOZLODvDbgZyexWLqLWZJSH5WSpYiMSQBDM7Mh12Ivj+Kxx5Skx3XMQEIF
	4nh15mgm/gXRVjzWeZgO8Q58qpV6KAnZOOvt/27uOv9I9TDVazNefpsjjj4gFWE28mZnsyYL0oF
	xhskhHbRQSCguRe+paYv3pDge7owD4TOuqzW8FaHpB9fvWsXtTz/NO/x46DWDWkF/U3KM+PU13t
	vBdin0EcZ+UMiqGEHnYVTk4hyeFLD
X-Received: by 2002:a05:6000:1606:b0:48a:f404:6960 with SMTP id ffacd0b85a97d-48e264a38a1mr7689380f8f.9.1792668861981;
        Thu, 22 Oct 2026 04:34:21 -0700 (PDT)
X-Received: by 2002:a05:6000:1606:b0:48a:f404:6960 with SMTP id ffacd0b85a97d-48e264a38a1mr7689341f8f.9.1792668861445;
        Thu, 22 Oct 2026 04:34:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584afe1sm13501902f8f.56.2026.10.22.04.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:34:20 -0700 (PDT)
Message-ID: <382ed6c3bf6ab5f2c31ab9c9becae1b4f53c15de.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner	
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Thu, 22 Oct 2026 13:34:18 +0200
In-Reply-To: <e778bbd7d5e2d2fc07ee365f37db59af04d9a36f.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
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
		 <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
		 <87h5ifvw3p.fsf@jogness.linutronix.de>
		 <f147fa9dfc553767ce92802b66723a85cf804e46.camel@redhat.com>
		 <874ieetakx.fsf@jogness.linutronix.de>
	 <e778bbd7d5e2d2fc07ee365f37db59af04d9a36f.camel@redhat.com>
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

On Thu, 2026-10-22 at 12:09 +0200, Gabriele Monaco wrote:
> Exporting all handlers functions is probably going to require a significa=
nt
> redesign of the current RV internals.
> Handlers have access to the monitor headers (everything is static/inlined=
),
> kfuncs wouldn't.

I gave it some more thought, while you could generalise the DA monitor
definition structure (imposing size limits and taking up that space anyway =
or
doing some /smart/ things the BPF verifier probably wouldn't enjoy) then pa=
ss
that to the handlers, I cannot think how to have a kfunc call the LTL funct=
ions
defined in BPF. You'd probably need a helper macro that is essentially doin=
g
what the "shared" functions do now.

I could fire up an LLM and get some /original/ ways to work around that, bu=
t all
I can think of is essentially rewriting RV from scratch.

Again, the easiest thing to do is kfunc only what goes out (tracepoints and
eventually reactors) and keep the rest in BPF.

Gabriele

