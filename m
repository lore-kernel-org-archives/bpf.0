Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66CF214A9B
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929488; cv=pass; b=YTEGK04zIqhLD5yxhw/R0qh9iaF/diBZNabfp8VDSZjljJucgelDyDKgWPi9fNsY2JHZslCVetO/zEdPn71vbJIfzDO7p0yWEoxI2N7Z7cIbhF4a45Ka1ypCkxxGtBPp4XNrk8oJp/Gh0hLFw/xogRSqPI3q9rj09d4Z8pZLzrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929488; c=relaxed/simple;
	bh=a6f2SLT1GPJi4izrfMemOEuzQDyU010ja+PV5H2i20k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZtXDtusfdJDXNDukTwTISO8Z5KAoNycZcaOhpJmoNr0xXINv60amolQWl77NiRsjDMiobaKFkixLN6OIhl0tyuQ1EB1bJMVWe17ENFKf/5Y/LnlWSV1UvWOF0Z+pjs3OchQEYSETgmo+sj92x8OnPLqKDQwJ5OMpqcXsGCqX1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CscUn77h; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CscUn77h"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so15196875e87.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 17:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779929485; cv=none;
        d=google.com; s=arc-20240605;
        b=KcpG69luDZxZTJbhxmCVxAqLfndrHjtCRhdo5wukqITgUYJLD0opZPbLpdH668Ov3N
         GNJXPtHvACyLIpI9genZf0hYsUXpZID3pzWNQ8xZ9KDnS+bvi5wFv+UNV7bfIGZiKmQO
         lgU4hK7r0QWUG8ygI57nVC4cIq82f0jjTq9jhw5y4QN5z7I3PsJnnhPKNcerOT8zdPX9
         FmG/DYga/Yn6zivtTomslMUQyqv8Zd3JWQJyrv9Kh6GuPk6io0+vzwP2m8A9Swu/ZmPw
         hFsI5qqK4uRIKM+P5lQArJU4rQbohw408nZfDmm9IQXBT55U+3Pw626o25yeceXZP0x4
         +hNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9cHiZnFP+maioEiAfwsmvGD3ZcMnOA0PgSE42ZM/Ag=;
        fh=JvW1njakF0y+bxHhnNB5rMMrFFe3bHQcG8NlR9dHmVU=;
        b=J/bpFClm5He+a50F4SssHtskigevEGmesbgdDBQI85fFSCBc2lv+0eHcMkxEvP+awj
         1LeQU6BEnqhLATRaYeM+/sTJrbyMjb7Jtktgk1CFBfnS+LiffMWuY9OhQ8OsE7fIK9mY
         ZBL3xSyZhKZen6PIHt5hwdbFR8ZBgh9GFBKkJTp+yUqVdVFw9eL63UVpsq09wlwDSdUG
         fy4FYCGhXf6oShKpkPXxfO/i7wBTNasdDGXL7BOc9jOq0HGHSCi7+YCzmsomUTfEXa6F
         nUJB3ggTV2XYgxxSWztASnpFtQiClnuDErg3W04Nm03RbodbRrmUr9zrkLhjFoPybr6/
         5f9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779929485; x=1780534285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9cHiZnFP+maioEiAfwsmvGD3ZcMnOA0PgSE42ZM/Ag=;
        b=CscUn77hoZkAoEysSp4YdBSEId4tEW2O+KLCappTNSowCOBEXck3zY2IgUk81tySbG
         Vs7TKjIGGFRaKwly23CAMJopm6uvfbfE2Kh5vO5pJxX2jFyMPz+UmRoZB0KAJO2jQ7qu
         Jp3b6RfEwDFlTw2BvbsqulwHlM0noYeb7gnJRI8oCuhWQ9AJdlnN7mcJpwfTu+4WsLCw
         jvykHCTWlbdofPzxDJtpGCiMw+E8YIQuUHFl90g6VvLWAYB9QnDTOueEcdgdRtVvJywG
         9zJIznSDu9BrY2SJnPgRHuMh39QHs39LIjUgbFlZN7Grf1oE912LSAI7OKlOPFKBUzNA
         GRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929485; x=1780534285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9cHiZnFP+maioEiAfwsmvGD3ZcMnOA0PgSE42ZM/Ag=;
        b=fKtxZg+lT9HOBqSJ+gyhYlWi91NeCvVq9c31hAmC/09+6GOgF3S/ks0TbbUYWRxkMP
         1gQox3oIdnBvDU1Ie/bBUI5j+n3+ZwmMZaWN3cLnUR+WDFgJNEVCtDOyOcdjc1/tQ+Y/
         WIdWErEy50q3eOQ/2jKUrcUAvMwtCxQSMT2p8urz/ld5oL3DbnQEUj+9WhUUuIGjIwpN
         ptXsTmpMlu8lAeKDb33BgvpQxK7a23EPvUFLri1+IxLWJWdcyedj/5hXxM5Zkk1VOPal
         yh+x9uUL9sLgSh1zTQyiG23qvlALsTr9pHbg/lmOGKNqkNCy/wDxEHzoCXSJDbu3MGjk
         KGoA==
X-Forwarded-Encrypted: i=1; AFNElJ/oeWOaW4F96DjQGSffy/mZVwxwjdVUTLAhfdsJ9f1ZFLbggFLcqv9+zdQ/GkwQkmFGBgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQK4wQdZaDl98XVUpwiWRy+HwCuR9VpuVGjpZSEAngWIOjFP1O
	zHoMdN+ZfVgJ3cC/xsE9BZgCIXMm2rf2T2R1hiIsP3hxACxpNi1hsMJLzM+TXx94A0khyUZCr8C
	VO/pBU5Bnkt/q5OEFHG/SmBntHiHI9MA=
X-Gm-Gg: Acq92OFKf7Eg/mEz6rX3qvmax6pkVPg8fbCzw0T6kdqR4Zb4EqdnSu9idzJ6HgdWkS7
	P/YNRxDTLqfSHK6FGhM0trGqLQnvzgkTE7YBlLhEWFq6PP44r15DV/62f9qQHtDRCahlUA/YH5H
	IIVNK1kki2ReYw9e1NRllSJmhBthuohiA022uRI8zZT1S9P0oi4I7V042m3bobXRdMMBoUc3zxy
	HsF3LZMdcBdnb5ooWMgdA4pOHvCBY0aIODjra7BfGPuUldbde67oXxcECymnQOpVQEtadpuc2K/
	zfDNKSOQYNAhUgRyR+9aHkvAiVr04AbIU8sSnBk8ZeKW3JRoEQ==
X-Received: by 2002:ac2:5606:0:b0:5a8:6ee0:ff40 with SMTP id
 2adb3069b0e04-5aa322c9b4fmr4671981e87.7.1779929484779; Wed, 27 May 2026
 17:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com> <CAAVpQUDu_UXZSqGNhKKyrtR6VF53vRcM+vLvE4OV-HnrJ4Wzdw@mail.gmail.com>
In-Reply-To: <CAAVpQUDu_UXZSqGNhKKyrtR6VF53vRcM+vLvE4OV-HnrJ4Wzdw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 28 May 2026 08:50:45 +0800
X-Gm-Features: AVHnY4KU2z4siULEeXOFZcRcPUBdcPXCf7bV3t0DxKEV9UNwpR0ELkShqU5KC6w
Message-ID: <CAL+tcoCQRzWJEh9YM=XjO_OUAhiYyznvQvn-z8RZ80eGTU2tgw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/6] bpf-timestamp: support rx side
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 11:47=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> > [PATCH net-next v2 0/6] bpf-timestamp: support rx side
>
> nit: This should target to bpf-next.

Fair enough. Will rebase.

>
>
> On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Previously the series[1] has already supported tx side for BPF
> > timestamping, now it's time to support rx side.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t/commit/?id=3D68b92ac494eb
> >
> > ---
> > v2
> > Link: https://lore.kernel.org/all/20260518082344.96647-1-kerneljasonxin=
g@gmail.com/
> > 1. support tcp rx zc case (Stan)
> > 2. add if-statements for ASSERT_TRUE (sashiko)
> >
> >
> > Jason Xing (6):
> >   bpf: Add bpf_ktime_get_real_ns() kfunc
> >   net: export sock_disable_timestamp() declaration
> >   bpf: support bpf_setsockopt for bpf timestamping rx feature
> >   bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
> >   bpf: enable bpf timestamping rx in TCP layer
> >   selftests/bpf: Add RX latency tests for bpf timestamping
> >
> >  include/net/sock.h                            | 12 +++-
> >  include/uapi/linux/bpf.h                      | 10 ++-
> >  kernel/bpf/helpers.c                          |  6 ++
> >  net/core/filter.c                             |  8 +++
> >  net/core/sock.c                               | 20 +++++-
> >  net/ipv4/tcp.c                                | 10 +++
> >  tools/include/uapi/linux/bpf.h                |  5 ++
> >  .../bpf/prog_tests/net_timestamping.c         | 71 ++++++++++++++++++-
> >  .../selftests/bpf/progs/net_timestamping.c    | 35 +++++++++
> >  9 files changed, 172 insertions(+), 5 deletions(-)
> >
> > --
> > 2.43.7
> >
