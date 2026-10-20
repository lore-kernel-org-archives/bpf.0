Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482633;
	b=wR7BUi/n0VeunaYzbwPyKYZgc8vo7Eo1VZzbs0iM/XTyPFlXToCIkNfDCIuVVTqo7n5g
	 C3Vmtl1SsHADWaO66273DqD401CjN5lweyLVKU8yOxcgwG1b878ix7EsMWvrM8dQN7QJ0
	 ZGvIcp3B3qjmjaCICEVwE23koPfkKYNdtVYlDbAn4Zw1rAvdlQPWZR4RMXE832txnKTwx
	 FgOOoNgWsPfTkuloC8B4XPm54JXhGxytPmYx0TUKSluc68SE2yju1lKeWK5Z9JPtQKcQ2
	 S+RJ6D/3LDER4klTQONo8IIthIwJKynD7SQid6rUGZXmaIBuOGSk23wUVPeHCDfCixw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482633;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lkDIuBRDwBt9QuWfP6v+tNbF2hM2OFlcCRYMmL+zaDM=;
	b=dKbvQFngMPBwLkrA68C5BbuIk1sHROFpKFXjoc3MT4O/JaHrXfpI3L9EVvVVUt9mUHs9
	 YziEL/0LvUQ3Whqyii236ZVLKkdlW9peCam5aGVhSkFk9K1nyCS96ELPTWTP1uX6URazQ
	 866eoRo/qXaY0ov3/ahIne0b3aHsVk7kdfjX70woB+u34MJvKelQMeNOoLhrd+qTN/9H5
	 /SD552+P8anskMe11KdCni2e6NW9xII1a43cMZVRP9aS8HOB2WrK/Rwr2+Psl6wJiSEGt
	 hbA1fIGytXFCFyek9xElNOo4lcR7B6pZYeoera8x663uT6lyx1Qx7Lv6gCxkDtMKE9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvMDyHAr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423C606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gvMDyHAr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F391F000CB
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792482633;
	bh=lkDIuBRDwBt9QuWfP6v+tNbF2hM2OFlcCRYMmL+zaDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gvMDyHArDqv9jrhMiL1TmNeikvVAOBuBZMinOTYn+/Zrm0RwHEBx26AKNbVv3BSiz
	 uZK+Jw+DwhoZO3U9FYy1kVqQw2Hz/UrhLZraQlatGfOrPN197YQb6ggoc5PaMCcM4l
	 mOfLFnw4YSClb/QNP6lhbV8hw2QfgIb2wGaRl3xuFKKbul9NU5kEova6XKT8s36S+P
	 1s/UvXDgtwL4Kg3myaTLGDI/OdVQc9+3bt6hzMbNLkkQaoq5aMqgdEN12+YkqnqzkS
	 qSqfMXQgHwyYvR22uIruDCeQ9Ugq9hYFxJ+fvT29tLi4tQalq2J0b/KYPBLGRilTtB
	 wRWvNir/fhhmA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4a6bb779d13so1486797fac.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 00:50:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByVQaCzRf8As5FZspS/pCoVMiFj+gwh5undvtHmtn1cWrhhT2tgVgKm50PeK6x5XeeIEbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWpZDRzC1F8RUSo7EKHIQd1djkZ4I9cFJKMZFIqhaebS1kE80O
	5ouzQgnAdeHM2VNS9GAy5BWvxebaPBKvQjxcHpL2ydv/DK5hCDMMIquJmCJR3TxX1QlhLfWX9MF
	HdCs/ZJLRCBmtsYn2vot9RkGKNlDyCoU=
X-Received: by 2002:a05:6870:ac20:b0:475:a1ec:9616 with SMTP id
 586e51a60fabf-4a75795be3emr8911747fac.24.1792482632305; Tue, 20 Oct 2026
 00:50:32 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019082214.102398-1-dmantipov@yandex.ru> <CAL+tcoAyM0uL8UWqYMH9=bCrLwtqorAKHqm=v1tQ95p2y5AqBw@mail.gmail.com>
In-Reply-To: <CAL+tcoAyM0uL8UWqYMH9=bCrLwtqorAKHqm=v1tQ95p2y5AqBw@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 20 Oct 2026 09:50:19 +0200
X-Gmail-Original-Message-ID: <CAL4WiipY6wmLFLAYFixj153jSBTG=3QrK-KHeUj80hqeyMoZ5A@mail.gmail.com>
X-Gm-Features: AclHuK9QC9cuFZdOl573QWNYzlljhHxBTaYVBVby7uu1YXb47yqDbTTaJfdCnc4
Message-ID: <CAL4WiipY6wmLFLAYFixj153jSBTG=3QrK-KHeUj80hqeyMoZ5A@mail.gmail.com>
Subject: Re: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Kicinski <kuba@kernel.org>, Levi Zim <rsworktech@outlook.com>, 
	Denis Yarapov <yarapov_d@mcst.ru>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	lvc-project@linuxtesting.org, Sashiko <shodan.ai@mcst.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 20 oct. 2026 =C3=A0 08:23, Jason Xing <kerneljasonxing@gmail.com> a=
 =C3=A9crit :
>
> On Mon, Oct 19, 2026 at 4:27=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.=
ru> wrote:
> >
> > In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
> > is checked for error but not propagated to 'out_err' label, so error
> > handling may not work as expected. Fix this by assigning error value
> > to 'err', thus making sure that error won't be silently ignored.
> >
> > Reported-by: Sashiko <shodan.ai@mcst.ru>
> > Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
