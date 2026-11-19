Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110666;
	b=at3aBy+W/Z5Hla7+3AHY64cBMrGEDQpAjTs77wRTWcLm9cn0oiX1CYuUUY0DIsewWp07
	 nRKcrAjg8vZoxs6fRlkvWSFEMsCQpcVtbPS5eln0/iBCdtCfDOQqbF+O80ALeECtP1SGl
	 i9d0XYa00+v3APV8FgBf7s1zarbwqfLlcC7WvO01IrLO24wzD1FBP3HSgqG6J0FQlf11E
	 fhkMBYKFUKeKid9pIcOc9Sn+UGZW+74ShdQB4gpwL6WzsTPondfwvR/O3qOohN3KtvnQx
	 DO8R0KudW6Y8LoZu/rhU5jC9rMyiBHfOBdD7hY8Q9maSxtgdH6f3kYqUg8tMu3wmuXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PAxZIVc3BZ+cIHdTDgBUyRKBf404I6ObunFzKbCzhrM=;
	b=KBKEWlL8SATzsl6r1uYcKc+vX+lvljrqUud/YbCGdsW8UJuk5UMajCsk1sc57ohmJhJd
	 HuQJ/jbQXUDFq/oqJHYtc3ZZTigL0veU2LfeoKfQNEJ+TDOUtr0Qlr+Sgt6P/GQRrnuiF
	 d3WWg+cxn0onTRBvi9gCQmmoCDBMgzLsdcDZQIUtkIJ4BxzHxcRtG2xJOh3Bsij+mPo6o
	 jpCDf8biEeaBaCc5S+MiyuDDbPJQ07XscbU+aetPXXO111i/EZOO2fevVNgCOX+lNk0SO
	 2zkDJMil5KUnyhRaSwVAbZ2mhox6Yzm9TciGJWRjUGYcy97gt2xzyCwHdljJAlwoLbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bgYWtpIa;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71497606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 17:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71497606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bgYWtpIa
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so23114055e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795110665; x=1795715465; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PAxZIVc3BZ+cIHdTDgBUyRKBf404I6ObunFzKbCzhrM=;
        b=bgYWtpIaPdbKZ2qHz8iwHRb1iVorMu307hYRPjqxc7Jd3NO+o3lRDAEgNg0W8ckrZ4
         eGDD1hUN4yN37RHRmNzfLaGVNvVlDav9adgYxDxtpppguT29gnM/tL7IyJL5JzxhSE+X
         oa7KOqg251NfS89hyBc3SY81cEXQ3KQVlE5d3sA3u5bz51hAnnxLtGq+13zak8Jsl9ia
         0KBN97zxXHv8z+Bzazu+tyUnH9Ph7jMEVRL1rEGTq1ZAx08QBjq75S9AgFeJ1Eh/qtAP
         bO/JQFhbnR6j7LOkATP9z0fSw4sQvt1+6NSji5kmtXQt5yJdpma33Dbo0yNvBUU7l3c+
         h4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110665; x=1795715465;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAxZIVc3BZ+cIHdTDgBUyRKBf404I6ObunFzKbCzhrM=;
        b=zoARcX0QMFC74NV4gLv3DYlUe6WTyqkzqcsQebxKWylGDU3YN7XVj0jr/MOhL8mGDa
         dOdV0yTfLdMMdNCiVerTyeHEmQuZxZKV6uvQjLwDPQEdE4wDK6De76u/dsEgtWmdAZLe
         we2X1Ks+tNipEdDSqVnD+CLxKQQ2PExp4umBbMZnFkQrpKznTTW6bbOyE8xxCbhaW9Wj
         AITx38bKHY1JmHqIZU0dd1hGJXrkh9S121Xck19M+o4pKhl+YjHTDOubvhE/AdUiJzhy
         VnL6UcZU5rkAeqvEu05Hz3vRFstqx2E1Hlxb4mMiPtFytaGcvlNZuVmIGil2fwqGsyPy
         msYg==
X-Forwarded-Encrypted: i=1; AL+hErFVcr0U33g3xRZNW+rb1KMHWy3Xn/YeR3l/WqOEltubZu8a/G866lKelEtHba9gtzEYGJI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1/PqZ0/XU+Jv24Zwpjro5UER1/oC0Ute6lY5kAOTkjrCqZBtk
	A9zvQgvspoo8jJHbpTlmHEetUw9fTxBMqL9bqywXSnETkwHHGsXNxW+zv3wAivKL
X-Gm-Gg: AYBFou12K/n6I/ZA5cGxBgAHX5bCnCsD+gjMXZTPLgqz20JCcBXPJoEOph5aiXVbL/6
	dvurEHPmYK98toZjvQQ3yry1UjSpKOwaCawoX5guphB2xc7hSNdlv78CETa15oNinwYyjdOFvxM
	zCWXUv/eyOsvdhNl9Pjbb/8vut6Ad50W0dh17qNO4AqGEgo9GbuQB05oyq/ccsKbqfknfhVViwW
	Eg0LD7LsirWhM1RS+HK/y4MrvxE6fR/Rme2KRhw004oMeRyQJWjmLHUSIYI6OXST+gvvp6QoMBz
	+8fuAaZ9/DSgFvt0xweKVvquyqbW6ZkiyZtfiFaQXUvBWVTdespCG17xbwhHOiZiqIurMpzFvhO
	DjkqorMqlpk54e1zyJcl6JHMDbwfztd66NJmSMhIOgJHgdAHCVZhTfe+ErE7Dx6yil6sZf0TtI5
	PdFGDMMVBr1sRhT1uCRcjALeCFZYgsjZMSxuZg2Hs6c/AvxXI3KJdYqG+0yNJeH4AKKzHGe/EHY
	xP4HIVbEDD9ZLIXAo1xRgjc6F3m+7EkOLrTTpiCsKZ9L0YuPeZU8x0oaj90/fNP4kc1zHO3RRfl
	lUbtJzwkG2PFqL0ngMBo9pDqrzl5HbQfhT7F087Fpyk8KCHES0JrFxE0LBysbUgvK+0=
X-Received: by 2002:a05:600c:a085:b0:4bb:7bee:5496 with SMTP id 5b1f17b1804b1-4bb8880f04dmr6670965e9.13.1795110664663;
        Thu, 19 Nov 2026 09:51:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a::28e? ([2620:10d:c090:600::1:977])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm13550055e9.12.2026.11.19.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:51:04 -0800 (PST)
Message-ID: <323410cacd68268a607902c50ff565af1e69e1cf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc
 flavors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Thu, 19 Nov 2026 10:50:59 -0700
In-Reply-To: <a54689c5-83d8-4a81-a8a2-ba971793d981@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
	 <6a1b6f05-448e-461c-bd79-0acd67fb7edc@linux.dev>
	 <d2f665211f7c294bf7a8f3897b247863090e4e19.camel@gmail.com>
	 <a54689c5-83d8-4a81-a8a2-ba971793d981@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 16:13 -0700, Ihor Solodrai wrote:

...

> > Maybe I have reading comprehension issues, but in order to decipher it
> > one has to:
> > - "kept old prototype" - figure out that two functions were declared
> >    "scx_bpf_dsq_insert" and "scx_bpf_dsq_insert___compat"
> > - "bind old binaries to it and broke them" - figure out that existing
> >    bpf programs referred to "scx_bpf_dsq_insert" and libbpf mechanics
> >    didn't work as expected.
> > - "reversed the naming" - like a new function became ___compat or what
> >    happened?
> > - "A ___v2 kfunc declared as vmlinux.h spells it ..."
> >    Now there is a ___v2 in the picture.
> > - "... doesn't bind" - figure out that this refers to libbpf mechanics.
> > - "fixed a compat macro that silently dropped enq_flags because of this=
."
> >    Incomprehensible w/o looking in the code.
>=20
> Your reading is a valid approach to understand the history in more
> details, and you are correct that the paragraph does not provide them.
>=20
> However IMO those details are unnecessary in the cover, but pointers
> are useful. Which is why I left this ai-generated paragraph be.

Examples are very helpful in cover letters, they save reviewers time
and make the changes easier to understand for people monitoring the
list.
