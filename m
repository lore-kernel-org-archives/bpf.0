Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55C367B72
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334689; cv=pass; b=UX2d1oQPJgywWvaecOgbHX2aU0mGXi5ptWDztWllMHCCWLsAIu+hfQGaCq8O7FHdUL8Rao5+vrONEGz2qg4Sa0M7vKO4l89GkCrHFYoZOXefzTBh5d/Uh7yPQ/B7yqO/U3c21JqebJrPuzcDvDXq7l9ouFhTUQ6V7vzFbgVa7eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334689; c=relaxed/simple;
	bh=iE8Td62QGhxkIZbgcUbiontrp6elfLPsvStG0K7afZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OT/aOozcVxBymv9rVGH1sBVzHXTI80oBDLOwBrxVRxR5T9HSSnyHLWjKlQx1iKVVqYHm6ASp67iYyOvKIYX9ybHKpSa918ckx/DcX5v09gdfF957H9zB7eJR89X4dtGD3TVq+kc7/Zxip7DSHEaJ5V6EmshTlSSCyHK+GTBcXWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga1nF4Bc; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga1nF4Bc"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80236b44a1dso16509357b3.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782334687; cv=none;
        d=google.com; s=arc-20240605;
        b=DEJn95UprdoC4S6dOrxYV3ovEpM/K2yKtZjC7TRdjiLiUJGRpcBWAMf3knFzCp/wEx
         aSEdoaEb76qfeHx5EobKfgv0rOfBJDpyPGOeVCn1HAT1g0sCCzt7ZFxx89PLXN6w+sZl
         vbOzLd2jClNO+jvnz2M2oc3FyZwz/fOTOBgwohWULNACUcGm15zP/tPgbHsrAhNbSqhv
         vRgIlDdD/YPK2qsfRJdPBi46DAcFJKasPikhchCD54pNdG9mBS/7MerzBaqiJR7R4vqm
         sa+QTNmAEZP9QHPiANyZRWG7GiH2Z4UxXbcPr2Iw2CoDkbaYywpu1CrX0O3u/7mpsPOe
         /hqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1LWBkTNGly9Qx1uX6BXZJ5XtlUUnwZ8c7mDUm/i5F9M=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ZOqjjXytq4qJwfmTQXKD+HNEMC65awMe4XhmesbDNofYnoA3zVS6TPpvUL+fgxaNm+
         jE1zlksqQ4qJ3HJq+oK1/drzyjZ2ew9mA2drVQlJ50NRNF2sJEnbHFEpGqVah7diHxCS
         r+rmWMa1X3xTxLugT5NjTzoeXr7wc/8S1RorRE1fxSgfA6BR4kwZu/UZ9gQJIrz7EJTD
         RQhwYXwaMyWwCDdcA2q5/FEW7+Q6d9bt1CaPWIFM7Q+QQI6YATDquQ3TLDxHPRAzZ/JC
         /7qIccz40fPwPO0GmYujakFH+Uv2GVWXcE5hQdr97q/Y20ZKM782rCmeGrOclnnps5HD
         R6/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334687; x=1782939487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LWBkTNGly9Qx1uX6BXZJ5XtlUUnwZ8c7mDUm/i5F9M=;
        b=Ga1nF4BceAbGxDydhD4YzSix2ofI3nzOlbTVkPqwou/20/kxhueRH0P/ES9MMYxQRy
         2oiBVVmnBvprnsU/QKTCM/Dp1udnMeP71Slf4yTtmFF2w2qWn+8Pr0GtJLdP4hm40442
         VaT4JDdRWyvMDKHDeOA3YAcSz9zmXPqNZX4zYR8QESyq2NRHoqFTe9amVzKur0zcNp6e
         pDuFhVxt8wyY4ZRQYQ6UB6EohgUeyhHhZiLaDiGRliGsHagc6xqrQQAp8AmHt5ftfpHO
         eRuSrup1ImROFzlnYyKtpY5mDHZsZsxnAvl5m7YgYwS9ZrV7OcmLA10Y5FhblikOSiRv
         Zlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334687; x=1782939487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LWBkTNGly9Qx1uX6BXZJ5XtlUUnwZ8c7mDUm/i5F9M=;
        b=Hwcwqb124JfRmmeCPxoEN8A9OUaJNRpFsvJAgXfD7N5CEzcrI0c+0aJ+mm79B/w8ne
         M3xx94BXoo7vv7D+28AX6Md0CONulQDzosdYWNuCII7OiU349jcRpFUkZskF4BI9JNEx
         X2Rf+luyi0CFx2BxD0g5FkCeZJIsrB61V64dfEiutSHB5byKJrAZjWCM8MOQdqEr+byB
         ySbrsbf1geQ68SJ4mznfe5M/1mTD/5/I01A3//bmVqtpk4j3gPk6xrkpuXrUOLuIRBL+
         iIaPQzy7h0aKJoreshjA/bHZYiylW6KQn/O3nICDhzbMK7t5zzdlejxhPYHcgYLRb6y3
         SICw==
X-Gm-Message-State: AOJu0Yzbs6FhA/khw7AQG7+Dljmz7eIbf4hj1aU772PJnsHY/rpYMXTj
	n9XmhVVNFo6/N7Qm+jYeszrAzpXOpw2YtMop3Cu+7W+CP9fQNIlXsQaGtIXvpX5eM+8p/9rEg/2
	9Xa85s/Db9MoYjUJi7ARZSwuhVHiwpPyj3V2x
X-Gm-Gg: AfdE7clOuoHdn98WXHmKLRq21ZpNQs9P7uucrN7iG0AVyyWVXnrfmkrf/ri0xv/KgYy
	UZI0xLhpS+b9igOsYHUUjdhvorOFXix+Q8KY67+3UXqW2DOn04deDMV8hYigVo9f6BFDsdNsc5M
	NGZMpxfrcIYqCwQxcBxiYBv4ICOE69kh06DxSsZowV6ZMS2vg8aeukyfVEedAk46u26wRpti3nx
	Xsr9YisjN2VJQKMaUzQDFbh02gXuQTWc6z5a6z+TM/SxB7fnv9/i7G4IZjKRS5fzYn2lp5t8Uxv
	NVdjzHQ=
X-Received: by 2002:a05:690c:680c:b0:7dd:3ed9:10dd with SMTP id
 00721157ae682-807eec6b9b4mr51362227b3.27.1782334687200; Wed, 24 Jun 2026
 13:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-16-ameryhung@gmail.com>
 <20260624001445.AE70D1F000E9@smtp.kernel.org>
In-Reply-To: <20260624001445.AE70D1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jun 2026 13:57:56 -0700
X-Gm-Features: AVVi8CfN8nRA6KomJ3hzZL_ho7Gj9C9TvR4N-lQMcuuX0lrbh3kPtjtxoueMi4c
Message-ID: <CAMB2axPRrUzzbGqW_6jssbbzma1Kz-WGAfJvdtoOyuUkX5h+wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/15] selftests/bpf: Add test for bpf_tcp_ops
 header option hooks
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 5:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Unchecked ASSERT_EQ failures on blocking sockets can cause the=
 test suite to hang indefinitely.
> - [Low] Multi-line comments do not follow the mandatory BPF subsystem sty=
le.
> --
>
> commit a1c417fa7da14f2f4f18705173e644ec97f1f5c8
> Author: Amery Hung <ameryhung@gmail.com>
> Subject: Add a test exercising the bpf_tcp_ops parse_hdr, hdr_opt_len and=
 write_hdr_opt members together with the header option helpers.
>
> This commit adds a new BPF selftest that verifies the behavior of TCP hea=
der
> option struct_ops callbacks and their associated helpers. It uses a
> cgroup-attached program to reserve, write, and parse custom TCP header
> options during socket communication.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c b=
/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
> > new file mode 100644
> > index 000000000000..73e34d2be9a4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
>
> [ ... ]
>
> > +static void send_recv(void)
> > +{
> > +     char buf[64] =3D {};
> > +     int server_fd, client_fd, accept_fd;
> > +     ssize_t n;
> > +
> > +     server_fd =3D start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> > +     if (!ASSERT_GE(server_fd, 0, "start_server"))
> > +             return;
> > +
> > +     client_fd =3D connect_to_fd(server_fd, 0);
> > +     if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
> > +             goto close_server;
> > +
> > +     accept_fd =3D accept(server_fd, NULL, NULL);
> > +     if (!ASSERT_OK_FD(accept_fd, "accept"))
> > +             goto close_client;
> > +
> > +     /* Exchange data both directions so option-bearing data packets
> > +      * are sent and parsed on each side.
> > +      */
>
> [Severity: Low]
> This isn't a bug, but does this multi-line comment violate the BPF subsys=
tem
> coding style? The BPF guidelines specify that the opening /* should be on
> its own line.

[...]

>
> > +     n =3D send(client_fd, buf, sizeof(buf), 0);
> > +     ASSERT_EQ(n, sizeof(buf), "client_send");
> > +     n =3D recv(accept_fd, buf, sizeof(buf), 0);
>
> [Severity: Medium]
> If the send() call fails, ASSERT_EQ will log a failure but execution will
> fall through to recv(). Will this cause the test suite to hang indefinite=
ly
> waiting on the blocking recv() call?
>
> Should the return value of ASSERT_EQ be checked (e.g., using an if statem=
ent)
> to prevent the test from hanging on local socket errors?

I didn't catch this part. I will remove send_recv() and use helpers in
network_helpers.c

>
> > +     ASSERT_EQ(n, sizeof(buf), "server_recv");
> > +
> > +     n =3D send(accept_fd, buf, sizeof(buf), 0);
> > +     ASSERT_EQ(n, sizeof(buf), "server_send");
> > +     n =3D recv(client_fd, buf, sizeof(buf), 0);
> > +     ASSERT_EQ(n, sizeof(buf), "client_recv");
> > +
> > +     close(accept_fd);
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tool=
s/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
> > new file mode 100644
> > index 000000000000..46618a604d96
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
>
> [ ... ]
>
> > +SEC("struct_ops")
> > +void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
> > +           struct request_sock *req, struct sk_buff *syn_skb,
> > +           enum tcp_synack_type synack_type, unsigned int *remaining)
> > +{
> > +     hdr_opt_len_cnt++;
> > +
> > +     /* Reserve TEST_OPT_LEN bytes; the helper decrements *remaining. =
Stacks
> > +      * with other progs in the cgroup hierarchy.
> > +      */
>
> [Severity: Low]
> This isn't a bug, but should the opening /* be placed on its own line her=
e
> and in the other multi-line comments in this file to match the BPF
> subsystem comment style?

Will change to kernel style comments.

>
> > +     bpf_reserve_hdr_opt(ctx, TEST_OPT_LEN, 0);
> > +}
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.31=
36053-1-ameryhung@gmail.com?part=3D15
