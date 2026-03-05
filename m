Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054737649C
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714560; cv=none; b=W558bp0kesDnlYe0fZPGM010pJ4yv6bqaIl2xJTD686eiHYsRZIvoWdGRUPh7PIx3mws2c7WrUso2VJyO3ZUK6H/nTgRVGWLfhVll/pAqXjFme4ma9OYM9MmllDARYbT1PBOsR1nFNJW78c9Tpr46mGNsYwoCdpozTuShDmyXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714560; c=relaxed/simple;
	bh=F8woh9js9XcHNLC38nopuCN1xsLDX1k03bkw/YemlEE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=UOmYP0NYJwyAAkbACVnus8pUgAta8jALoHFGCwphd7xhhHbojc9TDwEJTHDHECJpSVeBfgdJB5AAm3ZvhyVQ1vErBtMkxkKvY2QGiIXed3YmgRNhDpI/aI04CBC6tyTtzQuhK2CWJdfvPnTODdNrNpLz7NIGRjssBMmX8Xo961o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JremhocD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JremhocD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480706554beso86591925e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 04:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772714557; x=1773319357; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8woh9js9XcHNLC38nopuCN1xsLDX1k03bkw/YemlEE=;
        b=JremhocDidVGA9xi2y+kd6lN4USCRKAt0hsXie3N2VYF2p1DLBtH7vn7irPYWhPMog
         7QjQ2vXbfAd9z+OtIB/domBtDenOuqYmQe1aGy308qoGHQB8I9Bdey/PEVBt75OimgVm
         ZNMPd1mGcYQMqRtHqK0ayTcs0Cuxy875aP/iLp1xPfg1n2vQz+lUVUMXxxe1NFPSYAkP
         oJ+uTJl82NqRfS3q0x0dXxcnHrCTvwhLtj//S+P+66Tp03+VQu6cYwlWQLnZLgsPAlSX
         KvizdPU2C89TD9h0Tgk2zWLfUlg5zB7LPHN9+hmZRRUzk6HoH8zPP5U7gTqFLNrs57oC
         lytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714557; x=1773319357;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8woh9js9XcHNLC38nopuCN1xsLDX1k03bkw/YemlEE=;
        b=g0XXxQ26/XawcwrUhR1kQBFO+lEP57lXYVQss1uxfb9HJbxY8hGCdu3YlisTQz8G8r
         9YSff/iSur8qTOyJ4ccjmV6tdIC78aaYHJ0PF+e31K3wVtmRm0IgsY0eeknRmu6ZHe49
         n+gVrNISRxXx5ac+m6d56EsTJ9vq9CKyW8XQODlkiQBb7tXncYbnmG/4OBoRukdoch0u
         J4gvCKkU7YFb184l20itzX5sn3wTg9N+IDYRPS62lvnUsqvR+eaJXc7HPi7sicmLi0pE
         oxaNpIPNNjVFVEYoO/Lx2Pp84qH/n+7PiNkQJZfjBG0ttcvCkyHg7sZIRpimpgav7709
         zQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCWnvY3n921cSw6InheyaLa6JNqffk/5S1/hYXsjg4hibRzpy3EiO2HYf7ZDt9RyR3JN03w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymVGIBrFnqdCT5QWccjORnekI99enL99rkjIz/Fsx/R7g0pZeK
	aNdueyIyAVu1TAq55KxqG+XPW0ztCC35yb8cTd3DoKG9GIjwUSk32ocVp1tJPN6dyk4=
X-Gm-Gg: ATEYQzw/ElhPbEemEpXJQsLknFjgUmAuFCUh+iBO3I9ozdRzz4a7W8Sc3IZfQq4oKOU
	+6Lp3mgBHroztw9yF9rqDQWIO6E+oZ3SbNk0dRoOAKF5cTG/4cFw2EsiY0Tpmye63bRA9sI8QbE
	kJhphCIo6yLUBh952V/5K6YSGrZ6A+pTKaUNMsq5O7sKUBfMZ/ILV8q/AY0wmquS2/ghmMUfu/d
	bHlLxg6cDWIA0g35miDplu9pLA9wPgrJc014vTM6eEFx2g41kkI97H7HteiocccPGaMhcFDeedA
	zs510najFStjTHM4hPnwphFv462HS7QOwZR5EW15aSrQkFb9S6/7RMTlMIlyLwSxmBrfQZa9eKT
	PVHwuPtjhCKzIIQjaUQ5RQPYjVZnxPfhuBRD9Jw1XU/9YO49ruorbDQUhvJGLh0YKEFJ6avD26e
	vYLMyGCLpvsw==
X-Received: by 2002:a05:600c:470d:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-485198a2b1emr99378065e9.29.1772714557221;
        Thu, 05 Mar 2026 04:42:37 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffaa208aeesm5252381137.12.2026.03.05.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 09:42:33 -0300
Message-Id: <DGUUV390XWEL.3BNFHCZL5RJJ@suse.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Cc: "Fernando Fernandez Mancera" <fmancera@suse.de>, "David Ahern"
 <dsahern@kernel.org>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Hangbin Liu" <liuhangbin@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0-120-g50bad16c3d41-dirty
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
 <20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
 <0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
 <20260302171131.28373ccb@kernel.org>
 <0d7bb5c5-4122-4dc9-b52b-c305591207d1@suse.de>
 <bbee1ce1-0615-4be2-b7b1-a14eaf2afe26@iogearbox.net>
 <ba665193-bb6f-4293-b8ca-bbb267e92eb3@kernel.org>
 <ba35fa2c-0085-43c9-afe0-3b2e0351ca3c@suse.de>
 <525dab04-4e64-49cf-94d9-12084e146b80@iogearbox.net>
 <20260304174327.0a48ff45@kernel.org>
 <ec1fdead-8a2b-475b-a786-846b81234b74@iogearbox.net>
 <20260304185056.4ef945d4@kernel.org>
In-Reply-To: <20260304185056.4ef945d4@kernel.org>

On Wed Mar 4, 2026 at 11:50 PM -03, Jakub Kicinski wrote:
> On Thu, 5 Mar 2026 02:59:27 +0100 Daniel Borkmann wrote:
>> >> I presume you mean disable_ipv6_mod which then bails out during the m=
odule
>> >> load process without error, right? It could be deprecated with a warn=
ing so
>> >> that it turns into a no-op: =20
>> >=20
>> > I believe disabling ipv6 may be legit. Some admins on ipv4 networks ma=
y
>> > be paranoid and not want to allow any ipv6 traffic if their "firewalls=
"
>> > can only understand IPv6? This is just a guess on my side, but I'm les=
s
>> > confident of deprecating the disable knob than =3Dm. I'd be happy if I=
'm
>> > wrong.
>> >=20
>> > To answer the earlier question -- I would prefer to take the fixes now
>> > and make IPv6 bool in net-next, feels like too big of a change for rc3
>> > :( =20
>>=20
>> Makes sense, I think starting this process via net-next is fine and can =
be
>> better justified. Fernando, maybe in that case resend with the unlikely(=
)
>> added.
>
> I think Fernando was chiming in because he sent similar patches.
> Ricardo, please respin checking ipv6_mod_disabled() ?

Will do, thank you all for reviewing.
