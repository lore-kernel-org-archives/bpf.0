Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135546;
	b=adh/jxhhcJq9YY2DY6j+JTsDBT6IM6AFAirarNkpfoRdEVDkfc9+HGvhNwCPvMoQbU6Z
	 6sBm+3n85BZ9t90a7YA9UXdf1U9Pfh4ZqRno+rYQgfRlaL2NLeI2dlkX0DBvJNw1KAhLi
	 N3NM7mwN1864U4zkXWxMPJbxChgMTzbQC2QyezbRMxgvdnXFxTqx/UKGyHTA2aYpSjaP6
	 VoxuwZOkKwC3MOUWIIGWK02cA90MpTxZFM/AFO1BuL/BIkEXWX0r2xabcrKxqCiFeIhqE
	 mmEBLiLgNW1wOW5zhjGf4AOar1Ucwd5XXqlGypG5SsIUwlpE0lhBslr0wcIF5JcDtKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LjPg5eGBAkl27QIXuERKq4M1Nr0IJU9tD3WQRXevBNk=;
	b=Xdl3Gt1vUj7p06Cnm6kZm12QHwKNo8OLtCakq4KYcl9JcB2uKTSTfQJL39+z0K2DNBf4
	 iDteQmMKdKtRWrIFifCSWerCA6ZzHNWswiB+JPz0nfwH64S/Mty/0AVtcu4s7eDdhB/hb
	 nOn6keBXaWDXGl2mabnDteoo1Z45zOOtI7QhMnLM1PUas2qaRCrlwpY8b+zF/Zgfs6Y5R
	 dI1EqCnIxIMQpYjjdb15Xm6u4zvroZaoLg3KDAjlYpUGUIKtEhXPkfvPFkyXcYmdNbrrR
	 onZHvR0W4TnfVs+V8rA4RSw1bKGNS7zEAIvBbZjfDpSvBAVWgfefcp4Uz2mSb/nzpjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOTfaWiW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A4606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOTfaWiW
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4a16dfb8fa6so2091955e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793135544; cv=none;
        d=google.com; s=arc-20260327;
        b=QVsxBH7U8ScyYQKRmJb+BulK+D4jIZcPkqKb6ZnTwbPbejydXoRmEqsUNnl2x9LqMJ
         buscFK5y8CekWfiM3BMPgfECYwF/v11UGL+76HvsyKsT5ccjgYd40LrME+gaMAf9y0r8
         5jxs1jIUP4ntRfaAvkM6UNOYK/fX+ISRjShNd4KVmYwdMME5tAsn3geRk7IJN0FgyFjF
         hDZUssaDOzkZAMzbwqQ8V/Pl+7L2tv/dQv3535uL0Xj4Sh1H6ib8pfkZbbnTD/p9nN3E
         5L80i1YAc7AXAzISaDLcMg7m1xpE3aE1uGuXDOsuBUCVplQD1X2l0obVU3BI6X7eYA8v
         cbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LjPg5eGBAkl27QIXuERKq4M1Nr0IJU9tD3WQRXevBNk=;
        fh=yQ3yRz//mCwMtH7cG8AFO6yhk2j+RpfvNKPiLCIEUe0=;
        b=L6cCm9Uhhob09mV220Ict0UTWcqc13jt9Ng2F0/K5EqKXI91VozSWUkp5MKatCKYJi
         kDkaK4x1HXMzlD/0cxEPwrE8MQJ9pgJlK/OgRoHtAEbFg+90rwMPElEmKpS2RP0RcYV5
         bORgwZ4xUHVE3PDKye5JTGAzYTeoaoQWclSODfUg4rcAm0I6C3hsp9Z7uL/Z2QnvU7bI
         eNMB2RjgmbeNtd147tlrtboqsrZ7RoJUT39rsUS+29qRGDwHmAQBNl9+Epop4IrsiBEu
         axGsRZ2Z5Kut9a9UWEHD8da8UCHSGOMqmifIfpNZgMycLAyZKGJzLq62+sTv0cvo2578
         gQNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793135544; x=1793740344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LjPg5eGBAkl27QIXuERKq4M1Nr0IJU9tD3WQRXevBNk=;
        b=jOTfaWiWAwRNEiBeV1NeipCQAmTNceEvuS+g+7wkBVEQB2tV73bzuJFZfqQN66+E39
         tQxBJmfDPtRpkT+J5KGTyp8Gao18OTC6S4qYHAEX2WK/zprRLa4pfM68cwFqYJQVXJGZ
         WuQyxQKobP+wYhloHDoNTHTjiGGmYDdebWHoYzUdrNYc5hMVHv8orNq0NvSWfCK4JDzK
         ocdgD0opDSU0yi3+YYe0csIRHE9uhCZfmfFRG6+hjsVY2ZCh9w1kBvFZu//48LNgcKQI
         6ItL18HVC9JfZg8BlWSjDuRvs2grrXtzb5jc5P/bb66fWW2/F8qS9CpnIF0aI1BQma5t
         q8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135544; x=1793740344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LjPg5eGBAkl27QIXuERKq4M1Nr0IJU9tD3WQRXevBNk=;
        b=G+SL0sPdpSz17LH1rlnVmD1AyjTNaufX7QFYND2z1UNjc3T90L0IVgeCyOKJUA6OJE
         yU8c95+bkEUVW0vNlVuGckUpJKjBJSU7uCvcLrTUhWpqz6FkQUu3m5kcQwRCwj/96TWL
         rIsOUhMpxkQenCIEFPN3hdHJ+pYmudLUZdKV1cqb1QET8KSZ32AAiOPzTLeLuAtBhiwU
         tMMIWjAc2/FfyVdRofjbDmZTG5As8vvssbm0ArpqWzeW07UGzK5zyFD1/1R9FSPBD11k
         23pBn9QQxVaT0vjUOi/HOMlyjuHG6AhPU60mbjWV3RMAuJ7cv4IEyb4H9LARwsbREx5C
         SaDA==
X-Forwarded-Encrypted: i=1; AKwUvBxCvmiIsZOZ88XAoiVOtm4MZbsuJFCaYLTKqMaMKxfiF2V1sH0jZ3XjlHNG4QKjNCwAcAM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZsQQPUQgeNAWk8JBQYrNEGmQJTtuh13W/3ZWLAZVDJ0mdf45l
	8fU05H+LZ68X2/wfHXmYrxmQ4iCm9RTsvxvxuDveTxRzvgKklNotooK+yi9SycDqNYb/HDrvLlt
	Vg3fHnxCBVr/Fb1ttePjaNEO79uW8Zckkg5ds
X-Gm-Gg: AYBFou0tiN0UoH50KFA/MJMrOTpvuj4k+6Z0WEYgtLzSUjwqQuAwiBw4sDvW7WKuhSX
	o1SRS89MWmf+CXrHuzDNhj01PbigJBqCJL+9WnOl9CLVzPyVvR5tcOLTPwpxa8XhNk3rwyTIJFc
	wwMCrEktJLmuqeRlYAjO8uJKXhtmnLxFe83LDB7nFIOsVa4RnEiCkktWMaynqwspv75pIFpsDx4
	lveV0iAupWQA8TcGkfPYwmYM9g2CywRrqyMiYl1G74fuz6C7YCuNW4RHyEZOARBiG/RcqT6NDmP
	4bqc93I47ZszP8QgQBgXtY1ev1kIy3HvrikhKsg+yPZAee8LWH39KxNvpH1tYgX1RjCjYhK0Qbv
	etMmAHyJuVMR0+rCOJ1WMk/QsSGBWZ/tq6cu5daPhXa4jdu+zSYhzfq8wEKIpHIWyD6kBcLfrZh
	DwrO3WWebnhu/sKXkwxuX6RO1HIWW7iem/UO2iRMQt7N3kU5KJ73pYoRxH2aMWYovNiDUmat1Od
	9rN+sGLPnucozvF
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4a96720213bmr3336495e9.28.1793135543785; Tue, 27 Oct 2026
 14:12:23 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-17-alexei.starovoitov@gmail.com> <CAEf4BzYrpYHS1V=VXF0PTRXkXQo6FnseWirR-ka-O9wKTv_GcQ@mail.gmail.com>
 <CAP01T775XCUmtK97tBcWsvOvUsGxR7AKCGqfOCgebf+-_WfhkQ@mail.gmail.com> <DMF6PRBIH8GS.3LZZSW3LDCMWQ@gmail.com>
In-Reply-To: <DMF6PRBIH8GS.3LZZSW3LDCMWQ@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 27 Oct 2026 22:11:46 +0100
X-Gm-Features: AclHuK_XbrGlOwlhbLeimcMQvORPIge-lKfne9DKkNLbPFB7U7ztNSl615h7OYo
Message-ID: <CAP01T75GQRJWXWVNhxxYH6w21QfFVvi_eBV-ob0uEHLmx4DQrg@mail.gmail.com>
Subject: Re: [PATCH bpf 16/81] libbpf: Make arena 1 Gbyte when max_entries is
 not set
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 at 01:13, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Oct 26, 2026 at 4:59 PM UTC, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 26 Oct 2026 at 17:54, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> >>
> >> On Sun, Oct 25, 2026 at 8:01=E2=80=AFPM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >> >
> >> > From: Alexei Starovoitov <ast@kernel.org>
> >> >
> >> > max_entries of an arena is its size in pages. The kernel rejects 0. =
Thus
> >> > each prog must select a number, and the same number is a different s=
ize on
> >> > a kernel with a different page size.
> >> >
> >> > A large arena has almost no cost. The kernel reserves 4 Gbyte of ker=
nel
> >> > addresses for each arena, small or large. Only allocated pages use m=
emory.
> >> >
> >> > When max_entries is not set, make the arena 1 Gbyte. libbpf calculat=
es
> >> > max_entries from the page size.
> >>
> >> Why 1GB then, why not default to full 4GB size? And also why not teach
> >> kernel to accept max_entries =3D=3D 0 and treat it as "max allowed siz=
e"
> >> and set it to 4GB (as of today)?
> >>
> >
> > I would prefer this too. Also, commit log is confusing, it's arguing
> > that there is not much additional cost for 4GB region, but then talks
> > about the 1GB limit instead...
>
> Yeah. commit log could have been more clear.
>
> The reason I didn't go with 4G since 4k pages on x86 need 8Mbyte
> of kernel memory for empty arena while 1G needs 2Mbyte, which felt ok-ish=
.

I re-read the current code (even with your patches in this set), my
understanding is that regardless of max_entries, we always commit 8MB
of page tables, no? I don't see anything that uses max_entries to
decide that bit. So I think this patch is noop regardless.

> [...]
>
