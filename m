Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058679;
	b=YkpopHCH92ARedPjWwhDguifbl7yp2EY+I482cWGGNzF/MQmYH3yRs66OAmHPRnxlfYh
	 FK56l1QznAOt8vvPJixHRSo3vrQ+X05IgzXoBwq907OE1YSq5NZz6wbLQj4kN/v4TnUUo
	 JQbDwHUeJMKKfDFFNKcnZDgeIZRjYMYdUJYdkRh3G4zwmap+9cl/8ZvOhBJuisziwhdBC
	 Gk2XfNII+BKI5DzhC+UNfuc4UV6JhKpnDoGbT6V70vVbzVc+saDD/eMxQJX/xA3AmYzP4
	 1LazcLUPagJm4zfhU7EM2VvZeqQDVSukwha38GQbSkhfuxIYxIOYTKXIomI47w3oxwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=Mksf8c04Aw0L2Hfo4ayDiGAZQxhxUdwk6sNiM+OA6Z8=;
	b=4cURIW+h9XP4f2/AwoSSRfjALa2qiTDihUfCqWs6/MJRIhjsSDQrGv0cq2qFyy1l7sFa
	 mB7YKeUBIl7aZbi6aWe8YW6N+JrTh+h/iyp/XuXgJqurBlm1ljD7jal6BWisCUVxvU33a
	 v4JM87RZgw/K9KWDsI6tUGAvBIJSyAVHtVw18Xd6MT3RsmFDlpoYBC8teRvg+jFuRpv8a
	 lBupdq7QHQZlVNLhNdqGhytjIEuqtRZjxCxfmqYhV/fhWwamqn7SKHyuJUl2dqhZzMU8P
	 Zf3fJnrINSLc94uJN1r/8Sccut1eIn9kOx/HjjvK2tzzvEOOzPK+ZAZlYNDqXMGkXdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HECaO7GW;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8A606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD8A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HECaO7GW
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9995ce866so33043715ad.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793058679; x=1793663479; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mksf8c04Aw0L2Hfo4ayDiGAZQxhxUdwk6sNiM+OA6Z8=;
        b=HECaO7GW+LGib2KjKXOADmfIUadv5bcKiK/AFIMGDvSQUlkWMAj2Mgh5IZSXHPaAVM
         NRqmJCUX+D+ak9XK5/Jhn88L+/PKjfkYAO5ikjDCYy0BI8Weg+Ifwb40dTZ3AdpQiKZf
         qBxq/BNYcCaIDdpl3QGeniFeXPyRJ1e9An7RpZHQIq6gb7MgWZqQ+tfGlVzwH8pgj8HN
         A5RUZ26XauEJx03R8j0Lq0+HtecYL1kq8Tt1JUJ90K0pFGHx4XnjKj9mNZ1sh9M8gKL9
         JlOQz0Cx8GVwVWDbzcpkT2qAhcYolJ6S7sEN9iG5UTTv8hCr0ZkpbkXtMBHWkpClXsRM
         vEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058679; x=1793663479;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mksf8c04Aw0L2Hfo4ayDiGAZQxhxUdwk6sNiM+OA6Z8=;
        b=Llq68wqSR9li9vH/c1vhFSciodz2L2wmoLMGTm+AuMl47Du1Z3d5VeuB6iUxBMU9Jz
         dRf4EoTglAXoKrwCa/E3KWDhl2xYZUgw3PgVIU0AbL/RE7gGf5RwInYTYKltZffkqpl1
         2ap9Dm1P/Q8Ab5QY7yDAbYBLqJ1fx53AoEIjr6sQOLWp3QD+GX0srPJ9DUOfiZV5jxJ6
         VHCbG9RGy0CfSxMQU7QfH8KaYOIQXILc8OcRbqhYzDPkPPBUo5sM1rRoLvWvfOlYe2JP
         jXG/0MpIPbAFquGW6HSxiWkrqAdH7/BZrba4KY3tQml2Uvx8qrUL1MWsqny2YCQHr7UV
         aueA==
X-Gm-Message-State: AFq9FYLXlANOPOpLVpxJegNKIPoJ62LX/0PQ2wfLzXTdyA6C2J+kDQkI
	cne/LjP1zWqNhuzSZ04pdzhixvRJ4GTnzRinMBHLGloBIjBJONNQbsSv
X-Gm-Gg: AYBFou2Iqmjlh5ohBs8iJgdwg0C2AgYTcN+zqytkU0y20brJQVHqmviIdt0pZ7vIkzY
	srp0RlX3Z+/94AoYGu/60l/eLVISUK4WkYX4fYwdsJRca526yrAKb8ob610lMTWpCsYYHoRF5rf
	+pMnun0SvlQhM6FlPWXnqf/6ExKe8RaMMwllBXdlUSOuqd99a+4CljYnTS4iCrSvRDJUVnbHwLg
	d3dUjJxZPWBIYpD50U/JIYyHZSszv0oeNaBqZLZHc2PuiJcOJkenWFJMAZsTi5t6los09FdczEt
	aE1m3g+AQVE9tJwv2n9TaNT1Uvz7D+98mfBc2eBvra6SHdFC7+jttQ3XbU/KtuoluzPjsjaoat4
	xAOy1b7iSg/0z8oNQSUo8zNMhLZEW1snjP+ayRD8GPqqc+hWFkml5wBI9lPGjBlNgAt/1lCRfXG
	xfyy/cERGLzu4yhPHnBcB8qCoWFLxdEqpAMmtiQxKA8TyxRD1Grl7c/ydFUPBKY3GOnaVl56jSl
	5vxHfgphaIbSYSQHohydiBnl1sUeqhrU1SvI8S2SLnfTN4uogTYVNrP7Rw+txkwXmWuyXSL2AMm
	l1P2yPYeY41Qm4b5v0b45f/nYYaUxyB+Dy+tlswhrGjBfCzj+WpJVKIGAIZc
X-Received: by 2002:a17:902:da91:b0:2df:7fe1:72b8 with SMTP id d9443c01a7336-2ea9c621714mr76732525ad.16.1793058678506;
        Mon, 26 Oct 2026 16:51:18 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm1516215ad.65.2026.10.26.16.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 16:51:18 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 23:51:17 +0000
Message-Id: <DMF694XH2TJO.P59A31VE6GWP@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-27-alexei.starovoitov@gmail.com>
 <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>
In-Reply-To: <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>

On Mon Oct 26, 2026 at 5:47 PM UTC, Kumar Kartikeya Dwivedi wrote:
>
> Some initial questions without reading the code:
> How will this split stack model work with trusted objects whose
> pointers on the stack are taken and passed around (dynptrs, iterators,
> etc.)?

dynptrs and iterators won't work in rust. No need to drag old concepts
into rust ecosystem.
r12 is opt-in. rust will compile with extra llvm backend flag.
It's not for old C code.

> Also, will this lead to miscompiled cases where ptr to ptr to trusted is
> passed to supbprog as r12 relative access? (As a way for the callee to
> fill a trusted pointer for the caller, etc.)?

If somebody will use this flag for C code the ptr to ptr will be arena ptr
and won't become trusted.

Not sure I made it clear, but some rust crates need your typed-arena featur=
e.
