Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A464C0439
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192379; cv=pass; b=ns40xMhFV6JXvmQs86gsHzYBsgospELEvCg+m779UFdj0SHBZKd8G604aue0MpoTNbDZgvhGld/rMdOBVE5MaoDyOIeNcxhh6kIx2lt7SUm1rJcbUrqKYEb8yJebLTXE7bPKTJlN6m+ao0BF6ecakGaXY+tO6+ElKHJVixxt8IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192379; c=relaxed/simple;
	bh=CGxVSGycpBzhHRm6QLRx4kIqnzL+aHoMvldBecTAROE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8VB+29n6dMHFDjZYDOcBS9+68hM14WDC7Z6Y1p/pn7/ugnQ7EkgNIxYJpoW1JhdG+IY9p5yMCF8UNtIZP3OzjllHg9J5jIdEgtEvI3W5BbcyMfLHaqFW80fFM/sMfpEFScaKgoUnj7AmAvVY3hrb9w7tvkWcRXWFmlsEH5/ua0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7WIn25R; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7WIn25R"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so33878441fa.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 05:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779192374; cv=none;
        d=google.com; s=arc-20240605;
        b=gN+x74GvMCbstpxOfwGGQYwI62NyBLdpiuddhmhqDjxCvQ8AEv52Thpe+9xYEYMDNN
         wlLVrInge3YkmnMJaMrWNSHffwfO9OBM5f/qhoMhYHqHPHWF7jb5E8WdOUzxfYwtDEiv
         Svn5w+bgJXqiu0NiV3hpWGNTcPvR6lUn/sXIgMhZ7UC7wUtnZ6MQKgrUhRcTqOA9HhMy
         2gw1YyHFTR/65A+UVLKZlnfmFhJPENxVdO2Hr8bOkG+6ubh8VX6OVoHzCE5h4G+qpAav
         tiWxDq1TXs1HOzgfgq1Ya+WqSLT0T5ssowUEhE9TkBnLFCUouYk+w/wB7a3kV6E3I8lG
         zzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kp7kUH9UIq+pMnPJFmd1HjQegMSsejvI9T/sI2XmpDI=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=eAvw8PXgvl2Ai9bJdzctQfnSo+ioJPveNfglxtlpjFktv/b6HB2h0TY7FdoPhO4KAv
         fItsdr6Ke4qmx7ZZtTg1AxDmNNMsAJjdvUn00BZbG7PrzrT9VZjm6OptC5LgNiWeZ2c6
         6kA8zQ9g+sTYXzQXne2T/kxy6zvOwIkm+B6dvytBvt/iTSiGys99oLdXkUS2bHU9380G
         fQyxIqEvyJZ98nJR2xOCA+xJmOQGbd49FPW9SV9033fAYMNXfMezhaOh7pj9HuKR5m+s
         DBKHvsg8rmdOjxNaLaiX9wOxnzwxyhInpocUeZBKx135tGnL7M21wiX0nQHYze2pyLNj
         DixQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779192374; x=1779797174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp7kUH9UIq+pMnPJFmd1HjQegMSsejvI9T/sI2XmpDI=;
        b=S7WIn25RJnzegY8+O5vNELXElFea41ZqTf+6dQseGeiMSGi5q7TMhi9zVUIbZZEcDk
         5Gt8I4e6549lsl/3rXV66PK2KVwi0rZqBpwk+IOx+zK7CVRLPH4Tv3SiMx7rmKO2nlxn
         lpPzrALVhuCk6bPzcQj4PZ9QHx1rdrb968oBIjVnqi9fBCl/nKZTeOYYVHuKkCV2R4Qi
         uAEn6U9EFV4yzG/Ry9+7vQ00HFqgyvjU5pR3RvfS1MYL11MhN5fe5g4kHeuT//IO/ETR
         fwTa9+hJbu7RBhT+hF6IhkHRVHUMayU32boClGmLH+2PMXiVDJFRflzQhKVfPcwIq05V
         VBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779192374; x=1779797174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kp7kUH9UIq+pMnPJFmd1HjQegMSsejvI9T/sI2XmpDI=;
        b=Yr+leDI7IXdW246Aj6JxzaLAzZ7tRkoJr/otOhVpxYZhWKf25PWDIhtG/SgSSMh4/Q
         idxUbr5WQf0irYS2belUsH3XJ7oMZBs9HQ7o6de8xYLb19gHV7C3POO54VIdp3apPAY9
         OeBFke16ZsFbV46fvhzj5GWrdiHvoFlL8NR5M1I7D0h9XVDi4xFFW2L35/6X5xuQU4XK
         U7G9tkws1dSMczTnmoMaRdyyR5DUyKQJiOZGHg04zmR0nSna0x6vOAi52eWpVykVnclt
         3woBf7jzPn5MzrPPqi48kdknQnAuW2XdwbfslBut0/Ce8hhR49k64mXvXSqgqytD1T5F
         sKTA==
X-Gm-Message-State: AOJu0YzDw/eAiQcL5BxZTGXwW9GSwQ5AjRMRb6UR/Mm/zFjTZ7IrvwSz
	p7A16xr9QPsMGpZ1Q8jfmjKDmJwlT/ClZCgkaAzTy7YoqSwO87Wl2PRskft0EtKzuwCvu8na7d0
	xvI6934DQ+0UXB96YbHBIvyJHqWvJ2Zb9MI/FxI+Xsw==
X-Gm-Gg: Acq92OFHqzsrnoUEOZzzThpqcBtEJwBANKi817T2n8MmRCJLHN7Z5/jU6XZ8FMtblJi
	qwyEwQNnB6Z7P0eJyguP4NnTNo4REZ/U6LmJTeAuvXWLGGy3DyhuXov4P4FFeV9ouD9eTDoDQMO
	xmp91SVk+KkAuVXMIpqUTdqe8BEgtkxXthU3ttAW1No6nBHm5B/wZv6BzkdB2rUi0zHJ2/aKFmD
	jrxXZeRue+24G99M37f/C1uLz4YA8VGC8fV4UD6YYgznHVYyQ2NW+w/qRJG7u33OHcQ4o5TLiy2
	UMFVs4ttS2ZcDNO245ZbsPJjZIWIl+jiyqc++Voh
X-Received: by 2002:a05:6512:398a:b0:5a8:e336:b55a with SMTP id
 2adb3069b0e04-5aa0e61948cmr5619291e87.7.1779192373905; Tue, 19 May 2026
 05:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-7-kerneljasonxing@gmail.com> <20260519082515.AF651C2BCB3@smtp.kernel.org>
In-Reply-To: <20260519082515.AF651C2BCB3@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 20:05:36 +0800
X-Gm-Features: AVHnY4J2CCAk_a1JeE9M8IeVY0qq4Nch-g9YVsRP0rcTv7eisiLVVhlScWxxLHE
Message-ID: <CAL+tcoBa3_mGcULSbvtqWvK1ZbffX9CKQXznYpvaV+du7a8Ntw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] selftests/bpf: Add RX latency tests for bpf timestamping
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] The return values of `ASSERT_TRUE` are ignored in `recv_verify=
_rx_timestamp`, causing it to unconditionally return `true` on successful `=
recvmsg`.
> - [Medium] Using a fixed `usleep(10000)` to wait for a workqueue to run i=
s prone to test flakiness on heavily loaded CI systems.
> --
>
> commit 3f1fdeab36943dce908082eb563628a5f8ca353b
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> selftests/bpf: Add RX latency tests for bpf timestamping
>
> This commit extends the test_tcp() selftest to cover the new BPF RX
> timestamping path. It tests a mixed mode where SO TX/RX and BPF TX/RX
> timestamping operate simultaneously, verifying they do not conflict.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c =
b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> > index dbfd87499b6b5..3cc52b670e74b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
>
> [ ... ]
>
> > @@ -143,11 +143,45 @@ static void test_socket_timestamping(int fd)
> >       SK_TS_ACK =3D 0;
> >  }
> >
> > +static bool recv_verify_rx_timestamp(int fd, char *buf, int len)
> > +{
>
> [ ... ]
>
> > +     for (cm =3D CMSG_FIRSTHDR(&msg); cm; cm =3D CMSG_NXTHDR(&msg, cm)=
) {
> > +             if (cm->cmsg_level =3D=3D SOL_SOCKET &&
> > +                 cm->cmsg_type =3D=3D SCM_TIMESTAMPING) {
> > +                     tss =3D (void *)CMSG_DATA(cm);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     ASSERT_TRUE(tss !=3D NULL, "SCM_TIMESTAMPING cmsg present");
> > +     ASSERT_TRUE(tss && (tss->ts[0].tv_sec || tss->ts[0].tv_nsec),
> > +                 "rx sw timestamp non-zero");
> > +     return true;
> > +}
>
> Since the return values of ASSERT_TRUE() are ignored here, will this
> function unconditionally return true even if the assertions fail?
>
> If the caller expects a false return to abort early, this could cause the
> test to proceed regardless of the assertion results.

Even though it doesn't affect the result, I will add checks here:
if (!ASSERT_TRUE(tss !=3D NULL, "SCM_TIMESTAMPING cmsg present"))
        return false;
if (!ASSERT_TRUE(tss->ts[0].tv_sec || tss->ts[0].tv_nsec, "rx sw
timestamp non-zero"))
        return false;

>
> [ ... ]
>
> > @@ -187,7 +221,27 @@ static void test_tcp(int family, bool enable_socke=
t_timestamping)
>
> [ ... ]
>
> > +     afd =3D accept(sfd, NULL, NULL);
> > +     if (!ASSERT_OK_FD(afd, "accept"))
> > +             goto out;
> > +
> > +     /* net_enable_timestamp() defers the static key update via
> > +      * schedule_work() when CONFIG_JUMP_LABEL is set. Give the
> > +      * workqueue a chance to run so that netstamp_needed_key is
> > +      * active and skb->tstamp gets populated in the receive path.
> > +      */
> > +     usleep(10000);
>
> Could this fixed 10ms sleep cause test flakiness on heavily loaded CI
> systems?
>
> If the workqueue is delayed for longer than 10ms, the static key might no=
t
> be active in time, which would leave skb->tstamp unpopulated and cause th=
e
> test to fail intermittently.

From my limited knowledge about CI tests, 10ms is probably enough...

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518082344.96=
647-1-kerneljasonxing@gmail.com?part=3D6
