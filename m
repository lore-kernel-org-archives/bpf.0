Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E215D29E10B
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781237810; cv=pass; b=HDwofTD+u5tTNF9gCcwYLMKyMGmCybobWhSZOXxgKaBOPN5mRIxDGxzpQZnCOQod9PG9d7mNerPf2WLuKN4/ITDDQdmk1CV4MEK8w6vHk0B9EHY36rv4tAVxOI30q5A6ZJZnn1U+KLT3z5+ltyOvnYgudb/DBHdQJEsgO8nuti8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781237810; c=relaxed/simple;
	bh=aByKdEYmDrdAXoT4Aad2acQd+T7frYW7KWYyXTDQum8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl6Ak/IASj81r/mb0GI9nWlZRi/2EX68ba6ivPDumF3++UWNDOVwxw+eErUL43aqnmegZHJXyr9LJ/xH5Lphjz5M3dlpH+32jhfolk3GVp6t2sXySMgwfUVAA50ph63unCShtjxXJsRELO59LLVeOL6njHQyh6SzFTQ4yo/wv0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPjr1kZT; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPjr1kZT"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1383e116edfso454780c88.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 21:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781237807; cv=none;
        d=google.com; s=arc-20240605;
        b=gwzXi0bOVydyUJjWIwrGgLtnZ6+0Bk1zEqWBcbLg4fO+02p06n6DixWaGhj+hv0SIs
         NIf5F5BlmZwdZmarUPewp4yRLmMlFBpYf4hykycg5n2NXwyrp+6nyj7ud6Um4hBvt9nN
         kr9upOZ2+SJF5N+SMpQzFqmtuRW5idJljhr2dOwiTrsCJUJ1VzmZeTzbnTHJVh4QQbx1
         DA8/OEkllZ/hc2C1Dz+Xu5eTvjzfq53ojCvRHChEeXQ7u6vkjC3FD2Z/9jWDlRvWxTYt
         pxyCUshoLpxfyTGb740+4nNuIXHlfUVi1IPzdkYtNQYYfLrjadFHHJIWLf+y51oJ2o2I
         mbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t/9qixpLC6/JP2Ij5RyIicR2pVsaWdLKqWMkigjsGTs=;
        fh=yz/PqW/vLKzbSN1P9mA9QSxzftUWueW774WL3jcL5Ms=;
        b=LfqBkibn1cXkYpw5sx30lrYF+GyW/W4g1LkQULZGhIDoJ1aMWoMHn/TnX33GsbUiW1
         vT35emgbtXF6ydZo5cPhs2uTtZmkRaHvQ78Z5lpo7GOYteE8h3MrZKdjdidQRfmp6IHY
         Q3Pv1/SLxqFB/RhcShHcz2L2Uwj6uzEFs1eHiCYJYgx2MQoDvCFlb3g23wza5Bel1uxs
         NTfmgr4JmNTOv1S3XqHaoZPun0G7CN+IAVrtXETazP0LKCfBa2YNArhyxAPVEulhpWZL
         2L5SKNP8sVkEO7Ykav0poMNJ4Lz7xsa9lC4xfTdlxGWE3Z3R0iKJrAahX9LTL5KDiIIN
         92zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781237807; x=1781842607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/9qixpLC6/JP2Ij5RyIicR2pVsaWdLKqWMkigjsGTs=;
        b=mPjr1kZTTPI8PiFiAuG6eP7z/vf7YA3yoZ+qwGhSm+8B/yG6YBf4VHVsHF7YRjcVMA
         lcp8IkZ/bwL7k+1Hh9wHVyQEYV7MrCvLcWTbRp5jgeqcDoAczDz7GKyVk++4AfjXWVx3
         jcVtmC1p3kMj4aA4Lp+yhNk7tdKrsHVrABQ/Q+KAAfIHkTfsN+sbZlTJglKXLnTOB8XW
         04NC7m7mQr/B7gk/CYaE5mCZbJwMM07GRjIyeJSSmZPz9Ws5qwDYNWc6SALtwPOnubBq
         EbtPjopqh+nIv5noidtADKX9lg+NZ/q+oGScu1cqIdP20XGb3OIpJDkdh273IDIyWJJM
         VPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781237807; x=1781842607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/9qixpLC6/JP2Ij5RyIicR2pVsaWdLKqWMkigjsGTs=;
        b=safdX/YRvetT8rgEnfIXXmlpKIsvWfi9xEJ3Y9I0AQ1lKrA3ujtpFJkgtg+e+IgUHv
         DGdjvdW8c7uaceUIs1gJGRPTn9foZ2PUOw2uq+e38Ej4Gnqm+zx9X+M848onq7AdMptT
         qVM3UDxujh4GaaKKu4PIo9XEO+Ok+mnSmi8v1dE5+CeX1tXkCL57h+PMcp3+Gb/m6zTP
         5bT/E6CkPmC1YYVaCtmrC4/BT4yZqEBM4Ek3Vsrdj8ZeXv8hGjNgYlDrYvpyE4r9If+G
         6hWdyOtPLjtpoPeGK/zr9MA10uL+wuc5/FLMOGfn079dyFkzaxAKy0/vABmmecuwJikK
         5feQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1FgApKg5y5Gd242gzU4o6EWWHhGnqO5QuQeYW5ipXxVjNjcYMEZVTJniqCSaUJZZT95c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ5+PRVLCDByX5J6R6lCuhSDKdVopFwc4H0VAonJTjzzWQAYi
	TkQhXBaGMDMWqEetu1Yvn2DL53fBBef4IT0+mggevxmmF5fmCsJ/pPvLoVm/n8YYnHuCkBaw29g
	fCBeL3J71S/qyku8s8yEah2q807Mx5xW4vCGnTdQO
X-Gm-Gg: Acq92OG8m0QG74/GnrW+K5IMuLPB3oPvW+vlRFkuFO4sNsZB0bBQYA1aGQzk3JYtAsk
	gVrB0bc62vyLjvKDoXg4XvCJje5GUCJG1ZQN3AOXWak4LwrtdFk4Kvm8FmgH4odR/8uNHKLp3oj
	1ATDIz3JSFxq5eMV79hRZLZojgPz5KTcm+/hTRC7iGR8+DTk7yKAJwi62EEKeSM6RBtxecsgZrz
	/LIenPhagYGSPlGroWz7VAND//P5NERiJkmv+EktOsmJJm4hZjHDKCvjc8JlMTGQZARG5t+Ph/I
	mjI53ZDmjBDdJTeP1FwdAeZQAc22QSLktYCltnwHoqQ7Z8n7scLKyuhh1P82V9ZMxaGq4bmmu6F
	8QKNgY00xFsuWGko/9/hoVjjxXcSI4cXWvCcaOxpss99GS4lVGyLg
X-Received: by 2002:a05:7022:5f13:b0:12d:cbce:5fb7 with SMTP id
 a92af1059eb24-1384baee489mr399369c88.6.1781237805827; Thu, 11 Jun 2026
 21:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com> <20260612001803.23341-5-kuniyu@google.com>
 <CAADnVQJjHDbpAt2=Jkytz1GxHebPXeSEM2drekh=7vXhgQBkmw@mail.gmail.com>
In-Reply-To: <CAADnVQJjHDbpAt2=Jkytz1GxHebPXeSEM2drekh=7vXhgQBkmw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 21:16:34 -0700
X-Gm-Features: AVVi8Cf5RgJoicxZH2wP_fvnr9jS4dqjKjYyC21aEmx38pVrIOokFw2JIrbISWU
Message-ID: <CAAVpQUCUCETHTWR=_7E3eP8L-00NeJU1=b1pYJ8mjXcV6KbRhg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW Timestamp.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 11, 2026 at 5:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index b4ac1180f5a8..bd9343288928 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4706,6 +4706,14 @@ struct bpf_hwtstamp {
> >         u64 reserved;
> >  } __packed;
> >
> > +struct bpf_tx_tstamp_cmpl {
> > +       u32 tskey;
> > +       __be16 protocol;
> > +       u16 network_offset;
> > +       u16 payload_offset;
> > +       u16 reserved;
> > +} __packed;
>
> Here and in the prior patch..
> let's not penalize modern architectures like x86 and arm64
> just because somebody has sparc on the shelf that collects dust.

Oh, I didn't know __packed has such a side effect even
with 4/8 byte-aligned struct.  Will remove __packed.


>
> Also don't use 'u16 reserved'. 'u16 :16' is better from backward compat p=
ov.

Will use it and ensure 0-padding with memchr_inv().


>
> And consider addressing sashiko findings.
> Everything with [high] or [critical] most likely needs to be fixed.
> [medium] and below is a grey zone.

Sure, I'll reply to them.

Thanks !
