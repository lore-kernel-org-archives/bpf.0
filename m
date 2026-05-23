Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24620DD51
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495682; cv=pass; b=VF5jJjLRswBhOuEKi+TGAEJSsT9V3PeKrqmae6WtAJveB90rfThWnR9JgqHZ5XZPa3xsh3W2q9Yzm/syaeuHZArbH+2TYG8NLcpSOfkijwuk4WhvUwnsd4PGKFq4pOKNpoSIRR182+5ml+BdU90W9aln30OIthI6UyQ7eNOAWZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495682; c=relaxed/simple;
	bh=D4mJ8FPVD1YjGkYCg49HEYymj35lmCHehpyNdIcT9kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKgM3KmTXollBGjqnQm+DrCfOtYhsCuv9dmihxg+1isJXYNY643ZEc7eRpMz/lTkUCvIRKFR+/mKYN627qi55oK8bBBuYkZVxHH790968Pf/Su2cJMRAq5kuUw/KUgAJpMdP4XbWrp/lvQ6EaXvdDW6j2Q2klhtQaTRi+Q73Noo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXfrZJ7X; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXfrZJ7X"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1331e851faaso4172901c88.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779495680; cv=none;
        d=google.com; s=arc-20240605;
        b=F8GHa81GI9iUOkJ1gdsn6dZNHZuvKEkRvA2ioxfRL5SaTwbaUaVMHJ62a2rqGEoXm3
         GuWnbmJQPsUcfaSi8gZUdNasXsRtjBFx5OpRm9v4OjvJ6MevY6NvpOVWcVLE7q3Ymq9I
         MmcnLZ0knX44vZOUJiDmRqvUXkXrinAEWMiW07wYx50T50bCL1NvO5jQsoF78EdXqnHJ
         64wUG73snIW96/CsRlW3d3xyNETpjTDGDN9gZgjO9TAwZf4tzYmS2Fh5LLxSwTCUgqHE
         EKSPWaP8PMFEEVRNozmR9RNUjAJBMNwvi4xNGu9tveMlGTqKHOnFFrmf3nUPgedMV/mR
         RSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KiTRmoMTsTluTUU/2DSUVxylkh745cLyHVvfMEMV7To=;
        fh=3Mb3107mXxMlrTp2PZSjGdeb7AY5Yi2LUcG7jqNEmtc=;
        b=LUnQPEnMWfnI+aBm/Ys5MC3PR0pcJaatKRJfzzWkd/qp5/VqAE0nlu1zgJ6xPHA7pr
         yNp+Mw4hy+rnmSakldL3Cl6EJ3lEAlVQ7REvuoEoq7iNoNL9am8m8ZwktQEU3DNAkWSz
         BLuBhFDxZbWvCXeLPZSfLY7eUdv+4LXSFPueLlGVMvQpEQVwxNYXulnLHAYzkPTQUY2I
         1A2c6rg21LffNeYHGak1hdcECii4lRq7IkR1jsJHeZAiYSndyxDEDI1rPfVq93LuwdqL
         XddzeHaGi2iQEGU7/A3ICXejl9tOeJlD7dNb0mmWJ5+KOQSCCCOgVN94ll1iYCmV2fGG
         g2/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779495680; x=1780100480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiTRmoMTsTluTUU/2DSUVxylkh745cLyHVvfMEMV7To=;
        b=oXfrZJ7XEdYbE2gNV6Z+eeknlVX1u2cgiuCa8/ZjUBIl8N0aqibJCsA0s2oXHryWEy
         Mpvw3YVyhEXPLKmZv6BqFdJtLmJgQh+EtmV9NGDEm/NbZSYFqEgFxIF+AlZi/JLENxHa
         Y/u7sUYSnxgPys4/zbaU/SH1nH2+Hm6pa32uOIVzcWqmoxDG3EFfocW+fuS23rq8du8j
         4abWAg4T3fsihV5+n76pIFYLcj+I90O9fRnbFZTzypYPlZiVLgSeCqm7tQDjNP6p7L/L
         Xz3OshajrqRIrgalbJrScup6WyrxyM3SIFX2W8rdSqzWZVfukNm9YEpb1jSqBUYlBFWy
         Th8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779495680; x=1780100480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiTRmoMTsTluTUU/2DSUVxylkh745cLyHVvfMEMV7To=;
        b=I1I1An2WWuQwEVoojQPboOBlz9RxwGjSCtFuSKliEcYvXZCHwyY1fQK8lzgsMXWIMZ
         K2aH1cxtIQsIRSDZTc3zv2E6a5fcTtgUPwq9h4VAd8AkmN5t1+4lISILbkuN0Y1wDJXB
         A7t8yQec00u1g3ZpdpRyI424z/f+fjhnK+/PDdbJcrhIq40zLlSpDwbZBxMSSCUrfp80
         YbOkVsZHUlQjjq9isQ5ElhItTvHrVBJEm/5+E0q+x2TzrO5Yo7I7rGVT8sdssgNobSq0
         tFgyxANzJ9IUUCozx6kzNo7kWq+3Knmph/oYb5SCsxkcuAgFtJNGI3zVqXTW0ppixKMQ
         jIsg==
X-Forwarded-Encrypted: i=1; AFNElJ8rtvk/3SByT+AvbGvgNIPH0tthdREM0jXmdqFqkWv2rF4pmsrCTEBKoB16wL55qLZUvu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVu0CMA5LPC/kZlMtnGTvqwU/H3NkaQEgzzm/aqKEE1uGLVc5e
	3qCifn/AcWvqINAk5zn+LYvpgabTmgSy8g++x3RM+YUlgJ3kAIl/xfdxvLHa6L7R1kFAGaBKIEM
	cTyapPXHN6qCWV+8Vr58DtGNBVqZEVTqCRtVBlLjJ
X-Gm-Gg: Acq92OFAvN/an1U36bncfUjo1t0ALgUtc1JE6wFfjQfnJy4gVs1wN3C4FwumZc9mKI/
	Zn6j3VK+LsWRq3v0tgoCLDqT2qxIiJ2ZJteukYPcctKxTu/i4TmIbIEZ4pEn6yQxcX39ExwkvZg
	ggQwVkC6Tl+kCeBQB8iKOBNYbHDBTjUvjHCx40xzvintu8Hghx7p26mnIiWn/+NAkXrOi21YQHi
	ChLiSzAsMfHQYAiScpLIMToD9OJOK7j/kjtI5yHoWw3844F3G+m3KtNeXNmutD8Kbc8mSQHeVeF
	RaaNZxwsUbmWEDFM5J6MtAEbDd/ilK910gTBIzgQhVJUpLjBPOkB77PWnR9fOtleOHQAEB/8lgf
	NCFgUWH9pCLvEyV2uBYdVXlW3k88zduK5w/sJBeDLlDyFYcOaBfaj0tI/ZLzh57I=
X-Received: by 2002:a05:7022:41a5:b0:12a:8122:24a9 with SMTP id
 a92af1059eb24-136341cd515mr3579257c88.22.1779495679240; Fri, 22 May 2026
 17:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522074601.1658705-3-kuniyu@google.com> <5d9fbf4b64d5684f423bcdb540d72734b962752adbbf69958138cfbc9c907f5a@mail.kernel.org>
In-Reply-To: <5d9fbf4b64d5684f423bcdb540d72734b962752adbbf69958138cfbc9c907f5a@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 17:21:06 -0700
X-Gm-Features: AVHnY4LDyBEijob0AU0ht4MUtMSwXuaQK-_gazG06ym8XCz2Jt6ctHmtZZT7Aug
Message-ID: <CAAVpQUBMpV3WyuuYZ74VjD7Wc94QdnSYBYSz16rgD5g8J2ocMg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/11] bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 1:22=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index aec171ccb6ef..31130e1b63ea 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
>
> [ ... ]
>
> > @@ -7031,8 +7034,16 @@ enum {
> >        * options first before the BPF program does.
> >        */
> >       BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> > +     /* Call bpf when TCP payload is queued to sk->sk_receive_queue
> > +      * and after recvmsg().  The bpf prog will be called under
> > +      * sock_ops->op =3D=3D BPF_SOCK_OPS_RCVQ_CB.
> > +      *
> > +      * It can be used to adjust sk->sk_rcvlowat and suppress
> > +      * unnecessary wakeups before sufficient data is available.
> > +      */
> > +     q =3D (1<<7),
> >  /* Mask of all currently supported cb flags */
> > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
> >  };
>
> The BPF subsystem requires multi-line comments to have the opening /* on
> its own line. This comment starts with text on the same line as /*:

All SOCK_OPS comments are written in the netdev style.


> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9590877b0714..4a50fe2cd863 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -6002,7 +6002,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       struct sock *sk =3D bpf_sock->sk;
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> >
> > -     if (!is_locked_tcp_sock_ops(bpf_sock))
> > +     if (!is_locked_tcp_sock_ops(bpf_sock) &&
> > +         bpf_sock->op !=3D BPF_SOCK_OPS_RCVQ_CB)
> >               return -EOPNOTSUPP;
> >
> >       if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> >               return -EINVAL;
> >
> >       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> >
> >       return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
>
> The patch allows bpf_sock_ops_cb_flags_set() to modify
> tcp_sk(sk)->bpf_sock_ops_cb_flags without holding the socket lock when
> bpf_sock->op =3D=3D BPF_SOCK_OPS_RCVQ_CB.

This is clearly wrong.  BPF_SOCK_OPS_RCVQ_CB is under
lock_sock() or bh_lock_sock().
