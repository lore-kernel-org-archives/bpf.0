Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118799;
	b=H2UDp03kH1R0Koy9z0lOn+ya1U60pKuJRrwdLDsl5AkJgMtHjX3qcllX2ZHzH+9sUQJP
	 JqccgazevdFjR/Htn1B0frgoFxo1MshKHDW8LI3tnRJwNrOOAqrrCCVrItcXAoyLrlYoJ
	 ySH6JNKpKHmDTZYZJvjwo942D23/OKh94GyurqRj31Q5c6tFx11bLyqSWXZzfHLSyE5Ch
	 v9c0g1w9oPU1zjvr0fabcmFXmSqcaCPtosCxxNXNsPBKivIviX1dFZywJS6pNdTYRwU4m
	 4EeD4h9kO6LP1mrWIZBMeTCwUwnV1rpIM0VON2fEiY0aEP1nnYJ9+0QWpkkJnfo3PWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I0iNj3mQ8BtY35+vPtf2TGLh4aOWNpD/xEhhJMSPSv4=;
	b=abKiJusFlX8+YDz3o1l/edXl35iW7GIHGQO0JHmQLMw8JEW/0sF7dbcMT1j6KV30T83S
	 37jhiuqrLWROgpRj/s7bD3QlhnGLB0eCRte63Jn3X5Mg49QIrjt/31BxQxNJzxbi98KSe
	 JPTE0/FSUU0i+pPydUG98EO2Gznn2P8Ic0i4fn0P5rwTVSj3/ldi+MIGxK+7yeJOG3aAt
	 7UzbqpHB0mhLbVlS7Vj5x7YMqAEIUszATLgfaGaxQepLc6A00OsFhfdQnDq2oJFYWUWUp
	 H4kJpsPO5B8//lZB6PYN2TE9HSXavi/BB2MMi9WCxSc1b+OKOVIn0zOMnFoGxbj1OgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XEdAllwd;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F84606A320
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1F84606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XEdAllwd
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so160935a12.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793118797; x=1793723597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I0iNj3mQ8BtY35+vPtf2TGLh4aOWNpD/xEhhJMSPSv4=;
        b=XEdAllwdCkqIgxXu+9bXEkBIi36DzRQwxWRhKQlVdC1xvJN70dwZhU5b18swGOpJj2
         u9raY4q6DL49OdQYfYyO6HehetZT8xrXylxcIQMVXsrGgalnp5RQkHWtq2y/RKPZ1gCT
         GLWye7RpdC5QoTtoU3/XYkaAfnOB3Bbn8RlTN7RhqYoCHB+4ZSSumkvf3bXfb5vkYTvK
         bzCmgsBHCvG9Ghj1JTeuxRpqeRdi0E4AHgiPk7UeyBA4D8Wr01cozDHBPVIzr1epXCI4
         IVEscegJO1EAvD0GX6MvChjumpmJCw6fH4pIQ6iTdu+iWVpXZLyTKoYey+dzynAYI6xe
         EJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118797; x=1793723597;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0iNj3mQ8BtY35+vPtf2TGLh4aOWNpD/xEhhJMSPSv4=;
        b=NPTDib4HVPn1BHjG2mvYLxJDYw8TpZnzYCuPoVJRsDTEMiX1ZqAfWvkfW/sxnZFzLp
         Bly1ghLYjNvLBDV2F89HNnoPOt9Xx30VlT11T4s7KECgp0eAo1tUlF5NuNOL2TupzCfQ
         5ukeSJG/ge1qpAr1f/D45CoECzB2AKuiNXLJB/a2BODEvNVmOkbUE7rqKgNkA3hSZ6qV
         kGmx/3JsP078YlXDeXqbswZijsAUa+gUcMs5wQ9TMUSVwIJS39yFysedwUuFhK2vOVFA
         vfCuQYUrt1v1Vt5LnLuDAV0gm0Hb/EdH9PYzA167SuAaqkzgIgyy9Wn5y8xKTPVnKQuj
         5g5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzdrTOCoUhWX/oJeWVHZpqJuIL4QFZrJ+28UKw107Exahq/yx67T2vuRtwOJoQQSUtuZH0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnT1vU7eQl/Zhds+muKfng+lixnaIEnKkblFo5Ac/FrOPBaO3C
	JvjhtDqZ9/VNRUcTPW3VT2HOcKOVTQPP+bP9uKusoZCLFssfvldFIVbhEFsvDV3DjUM=
X-Gm-Gg: AYBFou3sLgKZBeKB4T2h+EKJLTkA2SzU6PU4NQp8T5wKpK9gNzFBJkdUcdcvuqgmhS0
	ZRTVw5dnW7KoRFU9gKvWXVz9N7jIwcG7eQYm8HZr6aAMdzS4oRI56A0LAWTDB9COEseYYf81dBz
	lHh/xpUFCffYy+DbUd47OamoCnlYcCMPeOd0G5QuNA1JsWcsO0zaZ3E7h+TViTqPPGlhPxTRuO/
	/LBcOgZl88iV949EHI2QQaFM9egedkh1rKhwnF21DemrPDsFniCLPIDp5N560s6bzRGM3DGP+Sb
	EjDvNISBJUnwzHjY8d44K4xXXWmhH8bLYYjlALO657UgwDnsHMtQPLiz0zQzZsN+KZ5NgIPGSuy
	f9MP4+TJg+3TB5lOjOObod4pcjnG5dU71mznkj6kQe/36s39O+zSUHP+YC1Ap4bXbh53nd1IMZq
	A1O7Nja3KC2ExO3q7SJQ0qGXQVmOhehYk0+eVfpxyq4G1dynThRRCjJpu22/TN4ksYwA0egsOJo
	ZpV+yhX8SeMPdN055vvYDXG12bxMb6fYipUPShhyFsLXD1ea0NRn+2vujHLa3hCWdvYOhG24eO3
	XNCRd/vuo0BB6oF4Ydhak3AVf1xdhegfj+3lEn+6
X-Received: by 2002:a17:906:7314:b0:c42:102f:15e8 with SMTP id a640c23a62f3a-c46bdd68f4emr1061585666b.14.1793118797178;
        Tue, 27 Oct 2026 09:33:17 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:1e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd79b884sm481105066b.75.2026.10.27.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:33:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: phx <phx0fer@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  John Fastabend
 <john.fastabend@gmail.com>,  Jiayuan Chen <jiayuan.chen@linux.dev>,
  Network Development <netdev@vger.kernel.org>,  bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
	(phx's message of "Tue, 27 Oct 2026 13:10:52 +0800")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
	<CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
	<87v76o63qv.fsf@cloudflare.com>
	<CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 27 Oct 2026 17:33:15 +0100
Message-ID: <87pkwv5cj8.fsf@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 01:10 PM +08, phx wrote:
> Sorry for the long silence =E2=80=94 my laptop died right after v2 and to=
ok the
> local mail and the working tree with it. Agreed that the ordering fix is
> the right one; please go ahead with the commandeer, Jakub.
>
> I do still have the reproducer (a KCSAN selftest for this race, verified
> in QEMU). Say the word and I will post it, or send it to you to fold into
> your respin.

Feel free to iterate on the patch once you get your dev env restored.

We would also need selftest coverage for the race, if it reproduces
relatively fast. You can take a look at test_race_insert_listen for an
example.

