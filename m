Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A430C37C
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573240; cv=pass; b=GFKySqViVsD/hw028ouxrzLdNZEFDpzc2EXoerhbgzJIuX2Y9ZVlIFZ82ShzxNIxjufehHq3Whu/8LCxAWtVCMWt9te+EfxsFYwBxZ96g6GEQy0J79naszPBaXsxTx6p9Lxv+eBp+8jAJPr1VyLLK3/tl1T6S8V9VEV1iw4iYVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573240; c=relaxed/simple;
	bh=OeEj/HXgik+5b8Gkgy3jnJFzvK2dtmMqmb+r6b1XYqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMf7hS18WnyYYVczAdOPh9yphgjQJQTFbwp3kwTedBI2ntfDHRzi840h8YnevQhR8WoBmPo6LPmrJuE4RHvFeymjc1nK9c5bl8rtQRsIoH/uaJGVjmSQGDndSIhAVrFxTPheX+XzyRKlrdt2j7InWR57Rgms5XO9hhjoUI2YQ/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8sRoLdb; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8sRoLdb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so4959172f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 07:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775573235; cv=none;
        d=google.com; s=arc-20240605;
        b=ctd/L4d/JaJjAk67iA5jHlJjQ8QdDvFTyD2/I2cg5VzACux81Hp1xpIq88eVRsp8Hy
         Wv/m+601zXIox+wkTPWVPGCvozZJvq7bhvbQb6udPz1INRu3m0el2txgIUo+XtA9OGKo
         PNd54uTEamttJD3umUKeo7W3P0Mtk3mTazRdB8m2ZxxeA7aUdxQ4WTLlsoSzY2vfl796
         0HXY875lkZHtAjqpr3ArHUDdwF/gl1EPTHhUOfq5OyjOgX2q2/0He1x+zLrcMfXbXdc1
         0MYIBSaIasjECGTCwWCmefE3m+aZCgv/a0kzHaVJXq5VVQHvSNM6f4XJFx3kjuWfV9zg
         +orQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OeEj/HXgik+5b8Gkgy3jnJFzvK2dtmMqmb+r6b1XYqI=;
        fh=DvfpQAslPAnWxc1IDBOleEEWAijd6ktW9U7o29Pf7Cg=;
        b=TGr/PN+ZYXy6ExN+I9mhO/oXN5aVxJGrWr1mP1kTUep+bx5Tj8EcSBbKK50vFqavHf
         Lv35INqhgAytxi4HkdZTlmoHsIM527cHhjqBpsZNPsTswNSguynjCXveelTxqcbI/nzg
         /4QZ7MvMZ5RH4ZntplJaWfhJM+9kqFtNb7Um7x6i2o2CCK8znsNvPXa10KMZr/ql+rm3
         2Q2nL743av9n1jLasrIwjG0ce6hCH3Vxg9rceyHek2hYGdLuYMMGkUsAS5157HGenz4a
         pyYZByQt0oQ0H2yNqKzJKrExSJ69I5s62Th/cQM6d1aBd1Eb5Bo1T1iWtuXh0eKywXI7
         ZFHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573235; x=1776178035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeEj/HXgik+5b8Gkgy3jnJFzvK2dtmMqmb+r6b1XYqI=;
        b=n8sRoLdbGYa2E6FSeh4l88AhfVwsCr+GqAFcl17NRsyxrYGWHg7oGJGl4JonMKEYAM
         Q1GCLsTeYCVZ/9tiRbp+OuJHEq52aDGGZivtBQCXFGm2+ZRslM4ods4mB0cwZZadrzCw
         kSLg0QFY7e7gQGuwJ5FhXQIq7aUFy8nTlx/SDs7/sdznNmB+2hFknDfMq3FWEUrla71C
         55FBPCryNoaQ47QH+LgW0cQFmC7D5e8KiZ6APEgHxg9S8+nNb4auHG0wKIRJ7MzWvTVI
         K7XHMaVJv0JuDXXS/7RseT9Z3spfEU+16cx1m30DWtp3KjGNftSvrbygn9u1Oz+TL1kU
         HfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573235; x=1776178035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OeEj/HXgik+5b8Gkgy3jnJFzvK2dtmMqmb+r6b1XYqI=;
        b=puxXiATymTdzmc+7lzDcJmM2V8DzRJOa2qDS6PPSJRYvzRZHCKRl7eBKGDGOlS7t25
         +fS3zsy5R3rYrDZyexjOEeQ3lfnIrLOJdqVjpk3Iwt/eVZVyLagNC7hcRTx1ERgjNklM
         MWDToyf7vTaDYjyzZNJ+TjjzJ7bPyRrxgN8+TOXy39CTkCWvKknJ+WgLHk5F+89Ueo+o
         5So1WtbPNffkBDmY4Z9465H8QJmXJo3s2P74mDUT0aEI1TIzpFdyYdpEIRNaX7Ps3ZQo
         xKRsPtuwy3OLhOXrIsi+5TiUHR37Ze6SuQ6WpsSdf30+i0pO3mKQTccRXJNO6L7wLLlV
         vvxQ==
X-Gm-Message-State: AOJu0YwqJa+F5zkUCQStVwINCXX0wmmeZh742fxL5nW7XmIJj6QtkpzZ
	h+nB+glklKHSq1iyOdD/zel+z/xYGMxxf78/mzFE6HLi8FJfkSxvuBv0r4UiEhSfjojRtc8JXH4
	e40nlP5iEQ8c/8a/QfRtklLIlAfpWkxs=
X-Gm-Gg: AeBDieuvutk81MeaH6iVWXFIA+wxbH0sLT7d3bENDz4nLCTi0vnZ5A4BkctdRfS6eUr
	H+qxRx6Fb+Fj/n/zeQnvPte0vQQ06yFY+rphx9Tm1SMi19+cKzEToKM2W21/lt26447YlB0JFg0
	ZL3W+8yv7W/kr3s6QiN8XGQl/9T54dsNj5ZtdbP4FbhKZF0OVfMwoIE7DyJ6ObpdK8ah+Bbrhke
	MvmeBgS4I49J6HgHCPhnqp76NsnUN6s8SNrCZwPr71Fl2ZgORrmiRuL3kh2OE7mnv9QWD3Pg22J
	oXfdHT1V8T+aMmKCj/WV24zvPP2ZR/5TCoqxDm3a+YHgpeIVksjA4gikqwO8JvKJX5VceJ2mPO4
	o6/g+lwm4+dvV+XEjS9N3A9Ga5w==
X-Received: by 2002:a05:6000:e52:b0:43d:303f:f358 with SMTP id
 ffacd0b85a97d-43d303ff3c9mr14598152f8f.2.1775573235071; Tue, 07 Apr 2026
 07:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407060203.3391-1-adithalex29@gmail.com>
In-Reply-To: <20260407060203.3391-1-adithalex29@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 07:47:03 -0700
X-Gm-Features: AQROBzDfw806rbk62zqGXz60VYbL74dh0suuu09-A-cSlhpc4P2RimlV4vGLOSY
Message-ID: <CAADnVQJ5g8VKSiSLaN8KBSi3jZc0U4C-UEZeXrPVxF+ZMz6jZQ@mail.gmail.com>
Subject: Re: [RFC bpf] Ingress RX queue provenance across cpumap redirect
To: Adith-Joshua <adithalex29@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 11:02=E2=80=AFPM Adith-Joshua <adithalex29@gmail.com=
> wrote:
>
>
> ## Follow-up
>
> If this aligns with intended design, I would be happy to explore a concre=
te
> proposal or implementation.

No "follow up" please.
STOP sending AI slop to the mailing list.
