Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017996;
	b=oxuZFyj+Sgl9F7P4oJ+JMTgKcyRagx1TanfOUcLhuN0GpIx1NPFku3l/gqXgBTkUUF0Z
	 dViM4jef+qA5NxgBGu9e/2ETh+C/8Yu1Zm/WhTCqpMl6JwZROl2JhgwvJs4EweREQQVkZ
	 jFIP12Qz271FRJms/9ruCN/pfo9ehbrTHBv6lUuo9fWF+cxq7bd1vJBGUejD1paIjPAy0
	 SzF8OlBBIWxy+2f+/CDWfrAqvo9wUj2psj//BfPpm3KZs1Jt26/zRi3btibhReGeo9XuV
	 CiAGRZkb6j3CMqZpJaYi+8CaGlwL6jy1iajrCG3ddfxI/Wh8o/0LJVYcl1OBa8/VopA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rkisdwNIn8uTnkECMBdY4BzVA5wTAqs0WDJeDG4YWNY=;
	b=Kzw0S3/0n6ntN76SO+XLs7XOF7s2Q1R4EZPnlgFC60gPFIvkj5KfDS8Kj52y9v2GAdJX
	 uoCidLhJAFEnMQtySHhQM6mBeGDw6pQ/NN1X55L1HeM+EreC4kCBBUt5NgKiVqo7LN+eo
	 14rcl5M2l0V6ziwDbXuA/mAtFDu+sqmwkiHwr/O5TzwQath7GhfHJnLlCXYHlimJ+kARo
	 FjXgnK9Y9H+xBqOJ3gtaJnPN3aM8taLrTnyBK1v6h5L6hR3nrOUxi70R/drpplr36E/J7
	 ima5hqjzo+lnG2xmJIb7Y7091nfzdQ6mi9dWMqsZSQNIEp4WE12VdjPOcDT0O3M0A+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="C53h5S/J";
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B14606A31E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 12:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B14606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=C53h5S/J
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so4386651a12.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793017994; x=1793622794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rkisdwNIn8uTnkECMBdY4BzVA5wTAqs0WDJeDG4YWNY=;
        b=C53h5S/JyOfMGXKUYSZbrQurHCkZF/KaUJ/Vi4gQHfeVL8tXR6k17Cb77keeaBMbQQ
         0VIfl38twCtNPUOKC65JivlvzsY59r7zFpE4sv8kka7+ywPIszBnGeFrcHZWzH3xyHyR
         7P8hyNLyMVCSg2zyOA7AJNjjTpKlb5W2MyhHZFNuxPG29QHxbdGQQFwvMjd7DKYz7LIo
         Qskhvi18uEJiMijRXcYBzmTrWhGu+goPCUh0zE1TeXaSb+olwbuq3iDE8w4755cc6xh1
         pLLksE+z7I7yVEKnmnW5xIetEevSD7ajKxtUsX+1aHJK9UDf0S0owIjELZcCxVaDPjsK
         Xl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017994; x=1793622794;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rkisdwNIn8uTnkECMBdY4BzVA5wTAqs0WDJeDG4YWNY=;
        b=IYTNEKNVuWfhTIJllhnzEL324DVAGvnJahmjvXuAJrhuY1p03/mn4tZYYz8nNVUKhH
         kfmjb7qUUOIjFUJeQnSsK3tDuxjwgPjWZ5pOjyLNxxYIsAqMt1+EISluGcxnHnkSXNml
         7q63nYCuuoGr/GqJxz8Cms/WCL1T+yho9kleCmPxq5XSeeZbY0Ee7VYI8nkqKL7k1CHq
         vbVFMi4GaON1jeYKkYI2EvW9f1EELAtggdwNHzS0opD/AyIeymZ86DnjYbKzWMHVd/9q
         CahZhkC3JlGU5nMjRScnPpzeQps0pp/RmPNZ12SH6MJQJb+zwVxUylHNCjWoV5XeJAX2
         3Uyw==
X-Forwarded-Encrypted: i=1; AKwUvBy5B9czqOP6LDNs8A9bLdeWpODe/SnZkJDeCvKJqQ/Fo5Kd+2KKsnrjNx2FMh81+zFMhpY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK3rzjGw3wudUlYcB+cQZKSG23GwWIoaAC8ZalTw/pzK2Noc7E
	pkky8X5Ln55Otvbnxkb7OKaC2N8KeqzTtJE8gIlYy3K3nG6CMjCnY1CyzvyLuS03wk8=
X-Gm-Gg: AYBFou3I4WFUlv17JS6vCGHG1SYdAagqlcMkGgRXP3BUzoqeZ5BXAF7gUD6yA2C4Ebq
	7+jTzZP3wDIIhkVBNGDNlunEE84RY/5s0AJ4thZ//RhX8VJNaqTgC1MoAB2ztpizVNUnHpEKm8Y
	xPybufoncD8mFUDNTp4s/kJgR4dbmvO/g9jdbENgisSXUSQUXYAaJ7s5ivbwK0vmsZNVojWjdLN
	qqJnu9Uu51tQS2lwXTAZR9xKoY2Y6gbVfXfM3muF4q3XhUwOzTOuKoO+JrgX94C/VJz6ioSGB+h
	FzBg7BffrE8ICRUrBR31hEd+XlyImiqKpKrXZFwibhDjp1Dnle6uwpvC+ngeCf3nYdBmoQ9RMqK
	cx69d0BvlFhb4PUL+h2viUV270vxmj+FZX+TmPNP/j6hE2wFFzVY9zbtv5ZFiwehdDlVEeCANfw
	KVN4Vqod7ycM0ttdo3YXn1FS/eYJ3uJy+Y+TE20u1LTV6TIfb88xEqWwe46+qFwVVbLUg1hyl/L
	Gpv4jZRAPCKhD/iiPJxqgV7O3puk5DBIjYnHCZTE01CBA==
X-Received: by 2002:a17:907:72c7:b0:c46:7643:ae91 with SMTP id a640c23a62f3a-c46bdbeff8emr745672166b.8.1793017994409;
        Mon, 26 Oct 2026 05:33:14 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:17d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7975b2sm320027566b.73.2026.10.26.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:33:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dudu Lu <phx0fer@gmail.com>,  John Fastabend <john.fastabend@gmail.com>,
  Jiayuan Chen <jiayuan.chen@linux.dev>,  Network Development
 <netdev@vger.kernel.org>,  bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 23 Oct 2026 11:53:59 -0700")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
	<CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 26 Oct 2026 13:33:12 +0100
Message-ID: <87v76o63qv.fsf@cloudflare.com>
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

On Fri, Oct 23, 2026 at 11:53 AM -07, Alexei Starovoitov wrote:
> On Fri, Oct 23, 2026 at 11:49=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
>>
>> >
>> >  static bool sock_map_sk_state_allowed(const struct sock *sk)
>>
>> Code LGTM
>
> Jakub,
> Could you commandeer it ?
> Dudu is clearly a bot and doesn't care.

Ack. Will drive this.
