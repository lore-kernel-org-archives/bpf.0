Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8138A713
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280469; cv=pass; b=fkvs5nFmSk3iYe7gfu+u/BvLbk49lzqhQQjAEIgbUP2n03mlCd0NPSgOK2G76JyrXHCZrkDGuOOuReJbMrem6tXW3dnBDPjpG5BeFnsY/nr4qmM7gDIeoRwFIdp0XBWgpQzjNyExZVT7VBY0xzdVd93W0HaIYGVQCP2s7bJT13w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280469; c=relaxed/simple;
	bh=ClpI8Jlme1QeRO8t/qIzKXdal214TarR5FWmGVqWkuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhAqVmCo5d/jYY6N1H8auiF0YAmAUXU9agak9QyNzC39a1gMiLRxrd2tPC2Rm/80PjRJk/uCYZG+Ju6h+JvIYsK51WQKugHsvVJhIj13W5TwmE7bCelkpDcNYAaw0xSMfgb83uhVkpM+Av/TVW+ofoz6wO9Z2t7z2hZ+spEaKEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPrSbYOo; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPrSbYOo"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-132830d8281so2266791c88.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 15:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778280467; cv=none;
        d=google.com; s=arc-20240605;
        b=T3eznDAtxqt7eHeQZYiLEyK0kyl1Ko/R6g+P01uzsH1fRvqJ44YKiHL6F6TZuepck1
         sx3XQAj9ef7jqrZf2Yjbm6DsOTna2nxcgfz7j7hSDuha1ypSt6jQp5h3DCKhPWbO79gW
         CJIQTwOxqfy7FcZT5FUjjZWJNqRv80gDKpGk6Ag3qb35IN0+eQ3a9ab/A1ukBOvQsIhN
         5VDjqO9EDB/L05oV/zF/DAS04Bltwmg/v4NEkPa3HqZ5UlYksH84JrVEVWGBNxe+9t7C
         VPZAsKNDb9m3E/9nmApLl+2uiXdBAvkacfrG2270EFhbiC3nH2Z5kW9qSNR29BggE7kS
         F+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LO9HnjJ/HwzGlHuNioBxerXiRJfjT6Qmmmi8RvuKYZ0=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=jsEVs8rm6eLyU+RgMVnCKjsv7yvW++/5RqOdj9AqKyz7X42RutrrNwsZSiP7DcGaGw
         bo/4/zxA8Kp3fKyp6jnKWFUPFRzUBfYTMeJ9wowEA+oMOhXTPPD96c38z6HydXVIP6tG
         S+uTJjZ0xvEoI81OLKuhokls97wCJW+G0IrdYtiRbANqTC7lzrCkBANdL2eMkgHqnzw0
         n/DXdsphpCOY+im4SyLlhm0movCtBLdaCbM9QRQAtCyBSObEFTF6bw/H+SOIlLKPQ5rw
         /7oF6IOg25mbPLOUVIiVtEz/+xxmAjX/bFKfGUlu9+cFnedAa9wFqGssNfDekd8hvKIo
         +hOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778280467; x=1778885267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO9HnjJ/HwzGlHuNioBxerXiRJfjT6Qmmmi8RvuKYZ0=;
        b=FPrSbYOocy641oPG43LEW1gOytLLXvxWXkiS29BcVG9Z7p6JSHMvTabQ7dFxdzpC3q
         6ApCkbJf7gLy7uzN9yc7uds9jEcVKCuzxB2LTka5SjRjQVHS6O6o1jjt21I5qnQg7jxJ
         FlOJ44v947NBHvHqIMvhKOxvOtjdQMs2H3/nXC/3Qp5gcTOgZf4gcwG22ZMJSFKMmVYu
         NqXe8iJR6X0rUT0yv4iG3CqujcHHotwaWh9gNsoWJ1It6Q2h93o3pETGuhlRwgVTjqiq
         xHQV7JyZFBgYS/eoEh/Q/+R1d2xni4yDBwDzN4f8rhAUyvrE9puAZNzg2nkJwQw8+Fow
         omiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778280467; x=1778885267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LO9HnjJ/HwzGlHuNioBxerXiRJfjT6Qmmmi8RvuKYZ0=;
        b=a6W61/SyIJz/yWGWIiRiXBUV/LQ852KDRDygflkPW88HAfwdNUYV3eQCx/4QBKj3X1
         g/ZtWOq8jM94pbpddyxFSJyYls6wCJoz6dr2hphQXghN9gr1ldUeh7MoVCF5vcdFlGMO
         23+z0QNvie+N0ySvaAxDUliaYqvenGRj0uIWFXeKSQWZ86vmOI787d9ANXvVnzdg6LgZ
         pcP3mIN3Y1/MiCtwsAP/8gxxkKu3Jd27lCUGIfVqCjckXtFMXczIqfaA9Ml8oZg+5L+i
         BpTRIkVSrJKm3X9tabEjS+L12LBgoiZJSBFNSnIhW53DU8sDJfxyMn1UWZ4tpbGTNjLO
         qPyQ==
X-Gm-Message-State: AOJu0YxfszF+kupBcnwTl9p5Pocjs1yEUYsFKAmDOwGANdto/8Z6dWMu
	EjAKLRygqrDSSEthjmCqpLf/B/4EAgDRy7ACtU4J1eRz5tHmVo/sVZ0hp8oK1SjW9zXfXRUf0u+
	yLT+RHNnYJEPL0kUkXWbnPoXAs45NXy/Z5XjO5NqcY+qiVWoKf1R29VJS
X-Gm-Gg: AeBDieuSLhTtfQ5y1YsY9gwHhF0SXHD74QPXIb2bgOXcmJp8Hgojq9PDhr50Ah5Lt3E
	aMJ1sp14F4I5c6Zd29wLAf1MzOyz0gc5LbQQiiWbHNQNSIARUJ9Sgq1QAsTwYXPYpZpBmQfsGjH
	057GZc0IvpD24G6uym5MYhbQyfKI+fZFYWAYrBc7wM56u1s+bRP+nNhlMPSGK2fPIWQGcSbXH4f
	0DZkupcW51VOFXpHp2Z5PWBMTziIlOJjRNnt52GvxWDjFPezdDEQcTXmDM2Bmos55bz/BTpxh6B
	aTrfi4Hhorm6OHyn8WurTVSpH10sDZrPIJv1L5jIkz41QqHIqPxAr4bHercaqW++UDiuEr9CEN8
	elaQ5oWTHlcUp6zlCJabJkHWzuA3MabU=
X-Received: by 2002:a05:7022:6987:b0:130:68a1:a237 with SMTP id
 a92af1059eb24-13271cb33bcmr2739311c88.35.1778280466191; Fri, 08 May 2026
 15:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-9-kuniyu@google.com> <20260508221719.EED64C2BCB0@smtp.kernel.org>
In-Reply-To: <20260508221719.EED64C2BCB0@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 15:47:34 -0700
X-Gm-Features: AVHnY4KKMq1w4Rg9ZKPKy6J_t8S5lTE6KZpSdpe5GwyyiTGMiekCJ7QG-AL3PAQ
Message-ID: <CAAVpQUAwFPkS3rL_RtVgVy7PtzXtxCN=ZfkTn71Kb2-37D+sDg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 3:17=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Flaky test design due to race condition between send() and epo=
ll_wait()/getsockopt().
> - [Medium] Pipelined data causes a TOCTOU race that permanently breaks an=
d disables the BPF autolowat program.
> --
>
> commit 7be0b88b0617982ff63886ecdcf680fd3a6f0db8
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.
>
> This commit adds a selftest simulating a production scenario where a BPF
> program dynamically adjusts a socket's SO_RCVLOWAT based on the parsing
> of RPC descriptors. The test exchanges partial and full RPC frames over
> a local connection and verifies that epoll wakes up the application at
> the correct boundaries.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/t=
ools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> > --- a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
>
> [ ... ]
>
> > @@ -0,0 +1,350 @@
> > +static void tcp_autolowat_run_rpc_test(struct tcp_autolowat_test_cb *c=
b,
> > +                                    struct rpc_test_case *test_case)
> > +{
>
> [ ... ]
>
> > +             switch (event->type) {
> > +             case RPC_EVENT_END:
> > +                     return;
> > +             case RPC_EVENT_AUTOLOWAT:
> > +                     err =3D setsockopt(cb->child, SOL_BPF, BPF_TCP_AU=
TOLOWAT,
> > +                                      &event->val, sizeof(event->val))=
;
> > +                     if (!ASSERT_OK(err, "setsockopt"))
> > +                             return;
> > +                     break;
> > +             case RPC_EVENT_SEND:
> > +                     err =3D send(cb->client, ptr, event->len, 0);
> > +                     if (!ASSERT_EQ(err, event->len, "send"))
> > +                             return;
> > +
> > +                     ptr +=3D event->len;
> > +                     break;
>
> [ ... ]
>
> > +             case RPC_EVENT_EPOLL:
> > +                     err =3D epoll_wait(cb->epoll, &ev, 1, 0);
> > +                     if (!ASSERT_EQ(err, event->nfds, "epoll_wait"))
> > +                             return;
> > +                     break;
> > +             case RPC_EVENT_RCVLOWAT:
> > +                     optval =3D 0;
> > +                     optlen =3D sizeof(optval);
> > +
> > +                     err =3D getsockopt(cb->child, SOL_SOCKET, SO_RCVL=
OWAT, &optval, &optlen);
> > +                     if (!ASSERT_OK(err, "getsockopt") ||
> > +                         !ASSERT_EQ(optval, event->rcvlowat, "rcvlowat=
"))
> > +                             return;
> > +                     break;
> > +             }
>
> Are the epoll and getsockopt checks vulnerable to flaky failures
> under load?
>
> Since TCP loopback delivery can be deferred to softirq context, could
> epoll_wait with a 0-millisecond timeout return 0 if the packet hasn't
> been queued yet?

No, it's over "lo", and TX/RX is in the same context.

>
> Similarly, could getsockopt read a stale SO_RCVLOWAT value before the
> BPF program gets a chance to update it?
>
> Would using a polling loop or a positive epoll timeout prevent
> intermittent test failures?
>
> > diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/=
testing/selftests/bpf/progs/tcp_autolowat.c
> > --- a/tools/testing/selftests/bpf/progs/tcp_autolowat.c
> > +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
>
> [ ... ]
>
> > @@ -0,0 +1,316 @@
> > +static int tcp_parse_descriptor(struct bpf_sock_ops *skops,
> > +                             struct tcp_autolowat_cb *cb,
> > +                             u32 seq, u32 end_seq)
> > +{
> > +     struct rpc_descriptor *rpc_desc;
> > +     u32 rpc_copied_seq;
> > +     u32 copy_len;
> > +     u64 rpc_len;
> > +     int err;
> > +
> > +     rpc_copied_seq =3D cb->rpc_desc_seq + cb->rpc_desc_buff_len;
> > +
> > +     if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
> > +             copy_len =3D RPC_DESC_SIZE - cb->rpc_desc_buff_len;
> > +     else
> > +             copy_len =3D end_seq - rpc_copied_seq;
> > +
> > +     /* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
> > +      * clang omits the "copy_len =3D=3D 0" check below, which is nece=
ssary
> > +      * to satisfy the BPF verifier's range check for bpf_skb_load_byt=
es().
> > +      */
> > +     barrier_var(copy_len);
> > +
> > +     if (copy_len =3D=3D 0)
> > +             goto disable; /* FIN. */
> > +     if (copy_len > RPC_DESC_SIZE)
> > +             goto disable; /* always false, only for verifier. */
> > +     if (cb->rpc_desc_buf + cb->rpc_desc_buff_len >=3D &cb->rpc_desc_b=
uf[RPC_DESC_SIZE])
> > +             goto disable; /* always false, only for verifier. */
> > +
> > +     err =3D bpf_skb_load_bytes(skops, rpc_copied_seq - seq,
> > +                              cb->rpc_desc_buf + cb->rpc_desc_buff_len=
, copy_len);
> > +     if (err)
> > +             goto disable;
>
> Is there a race condition if pipelined data is already in the receive
> queue when BPF_TCP_AUTOLOWAT is enabled?
>
> Looking at tcp_init_autolowat_cb(), cb->rpc_desc_seq is initialized to
> tp->copied_seq. If there is already unread data in the queue, the next
> packet arrival triggers BPF_SOCK_OPS_RCVLOWAT_CB.
>
> Because seq (which comes from tcb->seq) corresponds to the new packet
> and is greater than tp->copied_seq, will rpc_copied_seq - seq underflow?
>
> If it underflows to a large positive value, won't bpf_skb_load_bytes()
> fail with -EFAULT, causing the code to jump to the disable label and
> permanently disable the autolowat functionality for this socket?

This assumes the client will stop at a certain point; it will not
send the next request speculatively before receiving the previous
response.

In such an irregular case, we want to fall back to no autolowat,
so this is fine.
