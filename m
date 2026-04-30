Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A53BD638
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583665; cv=pass; b=qm8LXKpR3d5mzldeLTRr3ZwAazfZFqCjzuXC/XDT1/rPraNoeJe+D/Pif5c++dfBiOk+GUJk02sIHiKOb9RXzuAbJmeeZ6x/oDSX99f8VgRWzVVyUN3xPazhqkQDE8bDON01S+2QwAveiqdzE2g7sG+BE5vUKZqsRl7NIRpMoig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583665; c=relaxed/simple;
	bh=KeLktcW4RN4FirOdw8p7/AA+E8QD/RT5ZeIRPUFSs1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FV9CzkMIrFCfjcpXOyWO9dR4g3t1DVK+BbLqWhh+TNpM/Yckcs9m1p9v3TOlDREvZ8u+NqT+pFt+1W4TY0b00kiuHkfbbLJg4BXnralZF1ZnW4mBZSilXlpLGMz9JoDcES1zpJ/Z0gCv6XpKNmFomcIDWT3BRr3nghlhDks5hME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAzzHBve; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAzzHBve"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c6df0b9bbso1055488c88.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 14:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777583663; cv=none;
        d=google.com; s=arc-20240605;
        b=IgUEDjTpLQk7ZXOtZmW6MPElK3Tr45uRsOUTuUdUMzpquk+vkag9OHjW0w1UzDfuck
         yYL2RTqjBFSla4ZzWirUnjsYTKvgknDI7VI7Lba5hEM32XyMilfnjw8etf3Dwt5N4FFL
         LvIy3d12G2u8XOwogs/4PVsPcMeXGgYYNuss7WHtpMNdvk1UdBSAIFSBLOn+a0REbqzB
         7E29xMBshn2pBMxOIJeVecSsX5BCS+gBP1las4rbP9gSiVIMGz+XrXAQm9e4qm55Pmc6
         9uR514+ClCthATbLYvSewhyoLu6bqcYiGyxHHtdp7ncZve6dgPX191PsR3Shge86lOT3
         NRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+SlRNQThrT1EwiXTCbfvo7bMO9vi6fUh2+S5Zq2CcPo=;
        fh=isaxMwBG2p3KjSyHw4aq+Db1lFGDHMlYDN0Ntg8LQZk=;
        b=lIkVCT1V3W3nJaUzTwoITrHgiZOSaPq3AIpVA/O5Fxr/DE6Rm56hyzPl86CDdt+yXs
         BGRKPmaLHei+2dwizfhXYqpr6yQwgh9zv84fLeXvq2bvdLGwLCqvCn4QnsDNz9VJt8YD
         a17ay4NZC+AbD/A4NRI91I+0qlWed6E5XkhASnsbbn4rLyjMe5DM4SWVzBYNTQPjCAK8
         ALlcjMc5ug+yuXlxMqI8Jz804xGt9W418nqhHgQbM08eakqB5YTaAZ/PBLz3qVU9XdPD
         zi9KpD24bLjbTnI7fB4NH8G3RaTwJoAYQDNzT9tD35cdc+VPMhca2xaIYBSmYydetv28
         iG8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777583663; x=1778188463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SlRNQThrT1EwiXTCbfvo7bMO9vi6fUh2+S5Zq2CcPo=;
        b=BAzzHBve9b364iV3Mi/SVH/LVz04apzCb6+VObDETlc9zPZOpwRSxKbkbCY7MWiubz
         D4hSLJPSxZAE5hJSVMF+I0p9mKP677vJTLfyOreatbUmiDYLUuzEyvY9MROw9CozAN97
         MELLL2d65l3yfxZKLE64qevHyZ851SgrcVRbfIOpFIqP/DmX132KztvPKdh+les95biK
         5e4PiFl6sVnsrVxpjAze8CtUY1ZhNGOsSSdOFuKkso0tcbCYt5pZ33HcaTF5J7vMJ/L/
         UWM4DilYcnWfRxKGbHhhGN1kyflH6my5tfKQWmnYR7X8uKQH2G4MNwnHTHmodg+NIiAh
         ZO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583663; x=1778188463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SlRNQThrT1EwiXTCbfvo7bMO9vi6fUh2+S5Zq2CcPo=;
        b=rlKlNAoDpu5q6uDdJlNBYbip3VfTNp+S3vOGb8ZpORPfiIxUV3QhJaReBOBbWrRdhA
         VWPngIG4CEreP/7IvDBwvYh0BHphbAnDQuA7Xt8JgKjQBbfxUXOvYUFlFLEFS6LUAFts
         iOtr2CMR08zg3Jz2aE4twc922omn6silu4/oKpYjhO0WE1jvc3bDAPnyI9h0ZYYDy/T2
         VVJWr0KOFQARP5ZVsMTQ/lIPljSHEHef7YSTD0re7RcKxZ+GDH8wcnKCAeV9dk3WESFi
         1zLEXu4pexZdrPpjgsCGbBUrpd5pQLCqZy6NE7VaFl3OXANwNbzkSex7mekh7fxNFprq
         zPaw==
X-Forwarded-Encrypted: i=1; AFNElJ+x7fsHWsIfLsMx62CZhCjN20+DGFJcY17xgj+WlnDybvgHqBDv5gEQo/KLiI3cBs8foIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3sV9XdCoK8D2phicaA6Q4MMYkdwrJsMCrXYoVp/EMu9IULiC
	gT3h+6CEFm6t6Drmyeaz9qtkgrJSgaMskMaRUp+cycnSSyjoSGR6QgMS11qaFkt201/HRrnBf+S
	X6nuYc98oLeKpcjdFYhlma/CHy7uqmcUMtptHxFZz
X-Gm-Gg: AeBDietsj2cVhFx7G5oZQuEUop9AipRzCT6h0J1MdJc0F4wrn/a1duXQSpCuPa3PD6i
	4xfZKYHIyh5jaa7vySLWx4ej2FJFExMCFzVn7jPAhH4bPNMrClryUA5HiJpWPQhv7vpu5xKgqPV
	aDpA5/tEu7DG988yFr3Q7F7bnfMsj5OkUoqbyDQ4pgSaOFn6bif0hCbjSAu3eBjl1XiK95Jhc0b
	K9ZFzJggid6z6M4eVcEH1l46xw+66V+cJPDJWAg6Lyc9ij1Tob3xFOkS7vRZHvnvQrDtznUvlbO
	xUDuozEc/qWJv1eALdm+UI8f6N9gQcmTIA7bzZtYY8R7iPuBsWAfmfoBO2/p+uAu0XhO98+9l59
	7nXgsizWWnl6iaytkKRltXSNsKa3tn6kRMFx+tTOnXZGdAVNnLK5cYFxL7HpVyZHerogQITi3Vg
	==
X-Received: by 2002:a05:7022:b8c:b0:12c:f77:f0a0 with SMTP id
 a92af1059eb24-12df8238de4mr158020c88.13.1777583660171; Thu, 30 Apr 2026
 14:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430184405.1227386-1-kuniyu@google.com> <20260430184405.1227386-3-kuniyu@google.com>
 <CAAVpQUC83MxhfV-sreAPvfPJoqW=G20CPCPdRaQ6hvMt_khFtw@mail.gmail.com>
In-Reply-To: <CAAVpQUC83MxhfV-sreAPvfPJoqW=G20CPCPdRaQ6hvMt_khFtw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Apr 2026 14:14:09 -0700
X-Gm-Features: AVHnY4J87pWikJxSFzLMx6MkBQcXq7p65ZvaRw26Ozcndpc40ZvjjYBHTpYi1TI
Message-ID: <CAAVpQUBt7X6YRC27jkoEHp+57z3P-Q-xcxGmQ3ZJKsR-F2oj8Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 2/2] selftest: bpf: Add test for bpf_tcp_sock() and
 RAW socket.
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 1:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Apr 30, 2026 at 11:44=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > Let's extend sockopt_sk.c to cover bpf_tcp_sock() for the
> > wrong socket type.
> >
> > Before:
> >   # ./test_progs -t sockopt_sk
> >   [  151.948613] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   [  151.951376] BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt+0xc7=
/0x8e0
> >   [  151.954159] Read of size 8 at addr ffff88801083d760 by task test_p=
rogs/1259
> >   ...
> >   run_test:FAIL:getsetsockopt unexpected error: -1 (errno 22)
> >   #427     sockopt_sk:FAIL
> >
> > After:
> >   #427     sockopt_sk:OK
> >
> > While at it, missing free() is fixed up.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/sockopt_sk.c       | 17 ++++++++++++++++-
> >  tools/testing/selftests/bpf/progs/sockopt_sk.c  | 16 ++++++++++++++++
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tool=
s/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > index 53637431ec5d..87e771c8991f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > @@ -190,7 +190,7 @@ static int getsetsockopt(void)
> >         fd =3D socket(AF_NETLINK, SOCK_RAW, 0);
> >         if (fd < 0) {
> >                 log_err("Failed to create AF_NETLINK socket");
> > -               return -1;
> > +               goto err;
> >         }
> >
> >         buf.u32 =3D 1;
> > @@ -211,6 +211,21 @@ static int getsetsockopt(void)
> >         }
> >         ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value=
");
> >
> > +       /* Trick bpf_tcp_sock() with IPPROTO_TCP */
> > +       close(fd);
> > +       fd =3D socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
> > +       if (fd < 0) {
> > +               log_err("Failed to create RAW socket");
> > +               goto err;
> > +       }
> > +
> > +       optlen =3D 60;
> > +       err =3D setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
> > +       if (err) {
>
> Ugh, I forgot to commit s/err/!err/ change.. :/
>

I'll include Matt's followup and extend the test
accordingly in v2.
https://lore.kernel.org/mptcp/20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5=
cda7da9@kernel.org/
