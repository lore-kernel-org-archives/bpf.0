Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23221A434
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595586; cv=pass; b=VRsXrXSGvgJooH85faA4aV5zoVftcJlNSPIrQRcvk8EVWMXvV5sQGKlBbY/D3lqCobJOeRAneyiC8l3M/qV8CH0jV/oYeOjlP5XkwS/MO9SzmYHISc0VWF/S/yPzSI1k0u6PhfQllTbA/w2zioQHNPu49Jviyt0DHNT1SXd3Zg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595586; c=relaxed/simple;
	bh=CA4DpKP1QcRdJpAKyGB+y5d2HftO/i17x4Nrs6fBWes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pqungu9i2Oa2DTIsaf41o1QaQuwo8gk16QxZo9q24y4QRD+dWgs3mEFkJDsn8j/5uYrfMrTuVCJ7m4asMTx2lo2nAmHVvJfZBe0radUp//hB7XB008EkafNi78+JeE+WrM3QvXpfStw+GhqQOmdILSwr16U16jHomNPRoFln3Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sxdo5sVG; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sxdo5sVG"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-136a89595c3so618749c88.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 21:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779595584; cv=none;
        d=google.com; s=arc-20240605;
        b=k7dGrfmCzd3qk1ERn6wQQc5tg19pRgU6Ch4GITf0zL8g6P3GcyTu7bKFkxljLR4kV1
         4cypGumuLdXNm4KHHrXaV0mQNlL1h99IDc1jCNBuh9GxiV4jfpJXMxNE/D0uQUh10H6a
         +BSdHUk4OEdmHSjLk+QYig0wDVxs8pacyp9w/iMzrc0qvCya7p+tIo6kj/w3Cmvzm11K
         Ba7EIFmCt8DSHvggKCyw6gjqJlBLnnABgPNXTgD8JUUk2ktefnoE2DfeeP+LliAZ5/oR
         1H1LscVvyfBgH/qxJZtfP0TfQ2X+e2z3Nc1HlD7U+WhvW7sBXC4M4W+qmyd3A/wZPclK
         LirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BDTMc4T6qshbywfcZtVUYE28VJXJ36+uZ3Xu2ID3Wt4=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=lkmUdp5djCAJKK9GV+fUNIE68xN50DrTL01U6abTgO9CdEu5PlI0yXB4pKyS/14POO
         p0paPGOpH/GKR3ik+2KSinfCTd/jnXTOqu2Te1QsCF/FZs+QAvY36LgOpa09wvHtR79e
         Z5CZjrWn0XBbV1uDTWCiUv2aFVvnVa2UMsEnvSHDLfRJY7W/hffeV7bXD7hJg3mKnrQs
         Vqjz94BHlMgqXUYgfowCWswCqHBSPZMXw4eKw/mTOKiq9QP46Xr/IK8xnJvTyc0PLO0n
         DxGTZoSDYjZjngkuz4/cSZfPC3Y7f53Vc+9j1nxBOIx4qaq2kuP6hJ3GJR2VWMyUHZ3+
         LLQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779595584; x=1780200384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDTMc4T6qshbywfcZtVUYE28VJXJ36+uZ3Xu2ID3Wt4=;
        b=Sxdo5sVG+SfNNNi1R0rGnBZI4Zo0yXikNHeLu11lLIaavjs/j3AlAQSvJpwpI971mh
         iM7kILVmePtudyX+CQdiScCU0w34/Qhl1cjeZwLp/tK8/oE4Jw0yF36cwnkfnV6wF1Le
         YuyRBf3mAxweizC/7QvVuaIW1WcBzib+QRNA0zs5h3SVA99+wQ3u1PjfTjZIJFLLQ4x2
         r3R6VbH7TRSzjpxE/gq/DB80D8UYHaBEljd3mvr58ugDV3ENjRW0RyWTXTlTVMOvZtlP
         NbvbnNCzTT+Cj6n0WohCAUqMdSpoHMnaHo9rgsBDy5+3pGWNT0l2uawJ0aklZisoXr+W
         p1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779595584; x=1780200384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDTMc4T6qshbywfcZtVUYE28VJXJ36+uZ3Xu2ID3Wt4=;
        b=AchBFmwKTFAnbFf/FVUHfzfHVil8InBl6E2vbGzj0YCAidwKHKPVG9t7h7dsh8Hbhi
         3CBoTPFjVvs9YQ6bTtF8TVS+EOCV+se4z4T2KaVbFT2BPdolEkoYsxjVYv2yyQkMnOJh
         aylDB0kydNnIxXhN3qMV/RjM4IQs7AkA8E5tqth5Uwnm8p/yAB8GhnEeAOyPR62qXthP
         b4ApJYsIKbzfQIc9sPabDv6lzlK8wGnT1h7j//t//t+cwYxed8f8SqcdR7rC9B3R1vOP
         lVe1k/UwjwyLJhSFAKuywcAAsU2f7rUj5s+h6ezAcp7Lgnb1qNTdH3w/0wr1h8XFmKdG
         fMXg==
X-Gm-Message-State: AOJu0Yx1P0IB74pzXaHCLy1ny0DHNJv3skIkfqlIQJ7UKphlrb6XBU67
	wB5W0aE0rKomIOQaNDzbJ+9g4pAqqdg58eUmYNn1pKcmyDWlYEC0eXsySeZXsmQpUB3++fEKRE9
	G7XtbU/sauul4IJoRJg2NgOFNQLcjx5aigVQ6+39KO9RUHoZdnxmzUc5rbf0=
X-Gm-Gg: Acq92OF4SuLSC0Qx/SBzJ+6iRQMGGykSa3ReGDULdcSQz2xDVRdYTeRgqZ+x9wcvm3k
	77TIvHQdMcd+IlEsLiWEzAN7v+Uz16tt7AX3UIZleam6gS8oE53+UZomEPZ8wnqcsKdDbkO6dKp
	WLVbVYC+tPd/qt9rbGWs6vnxVuOIp0lKG5VUlHu2DZYf1KE5XI40JcfvwVITxy9ZsX7k4hYJsFr
	fDu1rJ/2VFHhXpdh+axGD0tXo3XOFozJAqOoBRF6N8g9b8FZyB6vGi3rlIONIuRq5nzqlqf/009
	OcVjYzvRueOY97sf4RKpH+7RX5ltIVOwskRclsHfCKQCYfAmiscltVsqLRYd02EyTotqr/6eLp5
	igCa0VotORz1KP44C8blZsZWF/soAx8189xMS7DjhhQ8uMEOmvf7wmeDkJ6cXcFI=
X-Received: by 2002:a05:7022:68a4:b0:132:7ab5:6cb8 with SMTP id
 a92af1059eb24-1365f6fd8ecmr3312155c88.2.1779595583293; Sat, 23 May 2026
 21:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-12-kuniyu@google.com> <20260523091241.59B251F000E9@smtp.kernel.org>
In-Reply-To: <20260523091241.59B251F000E9@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 23 May 2026 21:06:12 -0700
X-Gm-Features: AVHnY4IXKNztwLGicUHyUbzx0Z9uq1pIZJd3nSCTf6QXyIlj6jVHE8xU5TicPm0
Message-ID: <CAAVpQUCKxvRrrP3VG+4iZo-xFokNWdCBbUdbj+DTWem_bRyi3w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 11/11] selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 2:12=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] The test case incorrectly asserts that `SO_RCVLOWAT` is automa=
tically updated to `RPC_DESC_SIZE` (8) immediately after `recv()` reads the=
 first RPC frame.
> - [Low] Multi-line comments do not follow the mandatory BPF subsystem sty=
le.
> - [Low] Incorrect ASSERT macros used for file descriptor validation.
> --
>
> commit ab873db7faa26eaced426077409e35dd60974a4f
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Subject: selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.
>
> This commit introduces a new selftest for the BPF_SOCK_OPS_RCVQ_CB hook.
> It simulates an RPC frame exchange over TCP to verify that a BPF program
> can dynamically adjust sk_rcvlowat and properly control epoll wakeups.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/t=
ools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> > new file mode 100644
> > index 0000000000000..5e971c42a32a4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
>
> [ ... ]
>
> > +     {
> > +             .desc =3D {
> > +                     {.header_len =3D 100, .payload_len =3D 150},
> > +                     {.header_len =3D 200, .payload_len =3D 500},
> > +             },
> > +             .event =3D {
> > +                     { .type =3D RPC_EVENT_AUTOLOWAT,  .val =3D 1},
>
> [ ... ]
>
> > +                     /* skb has the first payload and 1 byte of the ne=
xt descriptor. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D 150 + =
1},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 1},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE + 150 + 100},
> > +                     /* After reading the first RPC message, SO_RCVLOW=
AT should be RPC_DESC_SIZE. */
> > +                     {.type =3D RPC_EVENT_RECV,        .len =3D RPC_DE=
SC_SIZE + 150 + 100},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE},
>
> [Severity: Medium]
> Does this assertion accurately reflect the kernel's behavior?
>
> The test calls recv() here, which executes in process context. However,
> tcp_recvmsg() does not trigger the BPF_SOCK_OPS_RCVQ_CB hook, as that hoo=
k
> only runs when new SKBs are enqueued from the network stack.

This is similarly wrong.  I don't know why AI thought the hook
is not called from recvmsg() since it's overly explained in multiple
commits.


>
> Since no new network packet has arrived yet, the BPF program hasn't run t=
o
> update sk->sk_rcvlowat. Could this cause sk->sk_rcvlowat to remain at 258
> instead of dropping to 8 (RPC_DESC_SIZE), resulting in a test failure her=
e?
>
> > +                     /* The second descriptor is available. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D RPC_DE=
SC_SIZE - 1},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE + 200 + 500},
> > +             },
> > +     },
> > +};
>
> [ ... ]
>
> > +static int tcp_autolowat_setup_cb(struct tcp_autolowat_test_cb *cb, in=
t family)
> > +{
> > +     struct epoll_event ev =3D {};
> > +     int err;
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(cb->fd); i++)
> > +             cb->fd[i] =3D -1;
> > +
> > +     cb->saved_netns =3D open("/proc/self/ns/net", O_RDONLY);
> > +     if (!ASSERT_NEQ(cb->saved_netns, -1, "save netns"))
>
> [Severity: Low]
> Is it preferred to use the ASSERT_OK_FD() macro here instead of ASSERT_NE=
Q()
> for file descriptor validation, to better align with modern BPF selftest
> patterns?

Will use ASSERT_OK_FD().


>
> > +             goto err;
> > +
> > +     err =3D unshare(CLONE_NEWNET);
> > +     if (!ASSERT_OK(err, "unshare"))
> > +             goto err;
> > +
> > +     err =3D system("ip link set dev lo up");
> > +     if (!ASSERT_OK(err, "set up lo"))
> > +             goto err;
> > +
> > +     cb->server =3D start_server(family, SOCK_STREAM, NULL, 0, 0);
> > +     if (!ASSERT_NEQ(cb->server, -1, "start_server"))
>
> [Severity: Low]
> Similarly, could this use ASSERT_OK_FD() as well? This pattern is repeate=
d
> for connect_to_fd(), accept(), and epoll_create1() below.
>
> > +             goto err;
> > +
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/=
testing/selftests/bpf/progs/tcp_autolowat.c
> > new file mode 100644
> > index 0000000000000..41eacfdb34aa1
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
>
> [ ... ]
>
> > +     /* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
> > +      * clang omits the "copy_len =3D=3D 0" check below, which is nece=
ssary
> > +      * to satisfy the BPF verifier's range check for bpf_skb_load_byt=
es().
> > +      */
>
> [Severity: Low]
> This isn't a bug, but could we update these multi-line comments to follow
> the preferred BPF subsystem style, where the opening /* is placed on its
> own line?
>
> > +     barrier_var(copy_len);
> > +
> > +     /* Do not swap the order of the two copy_len checks below.
> > +      * The BPF verifier somehow does not properly track the minimum
> > +      * value for 'copy_len =3D=3D 0'.
>
> [Severity: Low]
> This isn't a bug, but this comment also starts the text on the same line =
as
> the opening /*.
>
> > +      *
> > +      * 91: (15) if r7 =3D=3D 0x0 goto pc+40      ; R7=3Dscalar(smin=
=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
> > +      * 92: (25) if r7 > 0x8 goto pc+39       ; R7=3Dscalar(smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0xf))
> > +      *
> > +      * This does not occur if copy_len is u32.
> > +      */
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523083001.29=
11931-1-kuniyu@google.com?part=3D11
