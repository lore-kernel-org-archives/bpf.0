Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766639;
	b=eD3g1xNUoDbALEQM8qpatLWuHCbc+JeA17DcFxKHjCASrIwBkdn5ywJC4HPdqetx613X
	 vBEjDnxrfxfws3TG1yVeqVEsAbqMXcF+xoeIOkvr0VOm6sP4oVEq59Klydq3Mo2M0Cf3V
	 C3FIxVBiuO2jAdmvPMMDlgijy5i+9FTtpt31b6KjodFuUUGr9Mutm0Jc8+DMuQMolGYNJ
	 NYJsdNHUjyxWMhXmXJOEffAGNj+bMY3bTHVfye+ptxrAbZnl15RTY0k8gqCaFS2neCNUe
	 ydW7kbWMQCxIEmMd95uJ3XqPabxeJZbgq9r9eDzFDPU68+JsIZBFhGQckpEADofuOrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766639;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=erFZ2N8drsgFVvCe7mPMYkub3HB7wc9GLfWe++98/JY=;
	b=mqoh+QnG87P2TV8z8bEjKPiRltI4Tsub2K0o6RNPnQQ8rd/Qxd+XCXqSawVCtyPthNTL
	 7QhZyalxWDXaxFUp1AiGveusi7pzSZgxLokm3tRdY5Ni6BzgUbTnHO+ibFRuuZPxcpWFi
	 rVqmIc1WO2Dj8a0X/r4PnaY5lxHeN+z54dzJbMc8ynaGBGLxbZVmp/jpnOCYrZ00fgvu9
	 r3M1I9+cyXLYyB8nOsgkddkZ/uttuQOWcwqGsYxvrxbm8GKgna0LUb3G4wbiiMwuU5v4c
	 wBOSjUT4ermOeBZpxKnzmQgx3Xd7KMRCtjQWx50Elxiz/aYBwQTCbAhCs6rr0yUe6Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QWNaLk1D;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k++OMqo6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED7606A31D
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFED7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QWNaLk1D;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k++OMqo6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792766638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=erFZ2N8drsgFVvCe7mPMYkub3HB7wc9GLfWe++98/JY=;
	b=QWNaLk1DujFATMxy7tWQqkFvSd8ayg6s1pAJ/vQpy9kFUSNJGZ9P0mQR4083+Fn+qY3C+G
	Wxh8Y4XhlcR+n2sUU7DjBb4uz7A0/uga40+YmnSVamu/ZG0Ea82fUk8OO8f0dwMswVFpjk
	tNZkaTmwKYvZu9gbjp/HAWRo3xJ5JeA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-zMlBWsz0NPyLBDSSzyLjZQ-1; Fri, 23 Oct 2026 10:43:56 -0400
X-MC-Unique: zMlBWsz0NPyLBDSSzyLjZQ-1
X-Mimecast-MFC-AGG-ID: zMlBWsz0NPyLBDSSzyLjZQ_1792766635
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4069f03949so227529466b.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792766635; x=1793371435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=erFZ2N8drsgFVvCe7mPMYkub3HB7wc9GLfWe++98/JY=;
        b=k++OMqo6eK2SFFh/4BC6jQJV9b97HcJMy38WfOWbVbM6NAAzbKTyO0wrxe9JCvAvMy
         SPquAk88nq6vwzKfOeUNttULQ5kVqMIyhSc56WEMKX1QMP9SrXgGz34108UJDocekKDx
         +XbR+JqHyqtuKxdzaRhpk3oyivxfdKWjEBwYhkaf5RES6vXmh03AYtyE7nBqB9hNHEFO
         v82rg+J9pcFnwe26xl2N7EXCiuzFESw83JfK0J2/ZMDvBkMHZ4ecQxXP5JH7wDyW6CZe
         5f04z6iERiMKiYAWo7mQ4cqNlx6GIIk+Pl9l0KoK1D7j3FZNviaYM9tQ7ryFDxC7RMke
         gyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792766635; x=1793371435;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=erFZ2N8drsgFVvCe7mPMYkub3HB7wc9GLfWe++98/JY=;
        b=D7747+2MMMmAo0OO6V4xTrAIAOaCPNkWCTcnGfiU7c0ExBwIgN1Xr8mdy0ZzPlmhF3
         ibRvoE0pFcEKSSt4mKid5bsGHoFLEKtqjwHczdxJiRSdmpE3ZDIJZif1hOaIuWxbrhxF
         QYGFvbb4xf3LdcSsS4268TmU8Rvp2Pkn8jEZOPwvAijTrxXjr0yAftCzqNy2JAQpeoS9
         r1hSIQ1d5Ac5taWlI3v89N09+xJZz0jddQsFsUOAhh4tDUDeE+BfQ7oPu/PoNYhoN7xO
         8iHw0OKzGIEc/qeSl6FX/McmuLVVPhwRhG3gc4WPLiB7H6o9gYHXLMgHHZsNSZMC5PQT
         0dGw==
X-Forwarded-Encrypted: i=1; AKwUvBwSqnX0t5JeGlywFKJyKkiCtuWwNc5p+MbTh9FLWMr67o0NAT9wugH9M4nT31HmTDyu2Ak=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSJan3+L0ZoURW/uCMefTKBnj7DTRi+Wr1JlFE0RsQnuLg7cnI
	S2QHWLKfXPNcXRg3OugS/975ERARPVqpz0nQlpMrhtN5+iGX9cLbIA5EXX403nco+RGhewf0lkk
	N409y53sUTeGaD+LlLl5gfK7QP9JCLbmSiHJ6N9dkMKW9skxj6sgh/laPUgSRcw==
X-Gm-Gg: AYBFou09ZaErFmvegJZhzeREh0XRJl9B7MqC0tNucbxp6NmIov3zBf78PfzAd5EswZg
	46c/dONbWTuIbHnr/Cr0qRx6Qcxr978uwLBpEJFVI7NukhkvaotdqE3++mMWjnfzgoE3F0lge5J
	V6YLF125vYnyCFClCBqGL6hgsKDmJfwwU+RDBc2lVSf0/0G5cUTkIuqhmCH5Gbb2Y2PJ581WD7b
	3PBquLpjfPvzGSGlfLrhhkJ0UQVcF62LaamL1UHhPaZHUFfNBrdGkU+0w8GxH8s8qVyB/MswaMp
	qFhKCnvaP+jyy3T3r1ioPia1S3+4Eq2ln3glSuR4VvZSERXozMW7HsvJzsXpzayFwBwoSCLdguh
	IdQgPXaB5dUmLT9xk7nUD9oiprdLb
X-Received: by 2002:a17:907:d22:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c468d794de5mr821386366b.11.1792766634933;
        Fri, 23 Oct 2026 07:43:54 -0700 (PDT)
X-Received: by 2002:a17:907:d22:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c468d794de5mr821383666b.11.1792766634546;
        Fri, 23 Oct 2026 07:43:54 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432b4eeb2sm1233445a12.0.2026.10.23.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:43:54 -0700 (PDT)
Message-ID: <19beabe52e6d6c6c98e3ce6ae89867356e18b2fb.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Fri, 23 Oct 2026 16:43:51 +0200
In-Reply-To: <871p9ita52.fsf@yellow.woof>
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
	 <871p9ita52.fsf@yellow.woof>
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

On Thu, 2026-10-22 at 10:25 +0200, Nam Cao wrote:
> What about we refactor the in-kernel monitors' trace events into a
> single one. I am picturing two functions for ALL classes and ALL
> monitors:
>=20
> =C2=A0=C2=A0=C2=A0 void rv_error(const char *monitor_name, const char *me=
ssage);
> =C2=A0=C2=A0=C2=A0 void rv_event(const char *monitor_name, const char *me=
ssage);
>=20
> which trigger the tracepoints. And we make those kfuncs. This allows
> sharing trace events between in-kernel monitors and BPF monitors.
>=20
> Then everything else (kernel reactors, users, perhaps even eBPF reactors
> in the future) hook into those tracepoints.

That could work, though we'd lose some ergonomics around filtering events, =
not
so much in the unified tracepoint thing but in what fields events have. We =
would
need to parse a string (so I wonder if globs can express constraints like
matching whole words or we'd need to arrange the format to accommodate glob
limitations).

On the other hand if we still want to keep fields, we are going to need
event/error pairs for both DA and LTL and a way to match monitors with thei=
r
class (needed if you want to surgically enable the right events for your
monitors).

Both can work and what you propose is clearly simpler to implement, I can h=
ave a
look.

Thanks,
Gabriele

