Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60B194A6C
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929457; cv=pass; b=dFijQ22rInlLy6p+PUh0x9YWeC2dpDnzkhXGPM2ItatsNCU7XBS/iGtAYlYqIYIiHGltzBnaGCo/4ieonHrpwRA1Rnnkna8STdp8lcKDUKpZig9A1caKFIqXiVxWfKug215RM3Uh0yzRVPlKh/DiivkBBzZGizQEO0RdwiYy16I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929457; c=relaxed/simple;
	bh=giW7cE2Ul2827hcqIcTdpNfD7jsVV5kq3POoqaLjUfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo0GQ6vjYuD5eOkQX1tzGaQ1NQzBaagBXhAkL/N+MxPkGmSYI7LrwwHCU6JwwnK7+RrAG6Fq4NnfJRzAe0sScr8qIN6oIuhcOEGWYpGhMeXQGyppdKU4WCuhXsKFOat/PxOp5oLYKhyK80hWQOCBh3r9d0QZ9XXP0UqKVLcp3Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnRUg0lW; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnRUg0lW"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa2691db86so12616990e87.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 17:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779929454; cv=none;
        d=google.com; s=arc-20240605;
        b=E2UV3IijawNlCkt0B3iOm9f80GXGPEd6KKNiXdEAyfO1W7U5cFXsvmDdciX7fPyctb
         68rCFejK57BQKCcTi7tF/s1eDhFdWkwJWwpxB0zYDljbznJ3XMPlBQvGpMZd/qZ3lIRV
         sB161lFkPzCceDO+KZbEPMid/XeGAK526uekoMzGQyuWqvbiJg0IF1jAn6eAcocIbNvl
         p5+/RGGzCM0dtOIUv4dk3qUM4sZAH05o33I7PnJAFiydXlklIcUXL9rxBnub8UK7nxDf
         a3gA2cso4+l5mdCh7cmUYxFdjLbiAVT+eRQ4TfpPQ/2ITm7tj9CopNJfzLgOHs5feB0V
         NcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BlHi7pwvmhTqmHOFUpaKkZe0PG2OdoCLfoe4VT5AXRo=;
        fh=eeywhRgfquiovFkuqSP6OTj/yUabA2Nslu7Z21E0bRM=;
        b=WXi4wdbs70HmZeS3tT0rvT0JueZwKxjeIrLlf9C4L7Y4jjwQ1t5tdMp1T9sj9fVv9q
         cuJz7UqMxWveWJGhH/gBlnP8vxVFT+zf5ZKNFerdESfDT5f/LEYGjkNUauhjI29+v0Cz
         L3BdbYSNi9tnyxWC6wbON3QiH66KlRIuvoS9QlmFX+M8x+Qdci70aCSlL5Bs6gY7gEQy
         cIHH8VwAetNR32AtvpehzVjq++UfSpupPpFh4Q/1RXh5vbV6D4tDwSXPS0XnXrrLwLag
         32ZR72yzdiaaGQ0VcdMPAonSBZFaf38mdYGs/Mz2QAiguPxcMOsYZldTXsgUTmXXx/Gy
         fF3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779929454; x=1780534254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlHi7pwvmhTqmHOFUpaKkZe0PG2OdoCLfoe4VT5AXRo=;
        b=NnRUg0lWgvcmeDKtcUNIPH6r3mE6H+tpcHzMq4S2zJOTXQzvotaAP64KbUMF9jwCp6
         XCvNrJ3kFBs0umwwGx4xQVz4fxPYVcuuxztA3vY3jTy7vdz9ph1F6hPmYwdpfkqjdwCa
         xpPdxnFa+K9X/7oG6nNA/sMNqx24x540MqZm371sE+Qpg2y4NT/uPDtdqMRvQth/x1t2
         8RPK5NedmNMjARr4VzRkmEYUK4sTSd1lwyiDsUWMAqsWobIn+jXZo4j9TStkfJDme8vR
         SqPFQHpUWFsp84tn2Cm+geC5bBiHU50ysiKUGwYneKHIQ2fNXhcyrHTZRk8maLcDtiXg
         yCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929454; x=1780534254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlHi7pwvmhTqmHOFUpaKkZe0PG2OdoCLfoe4VT5AXRo=;
        b=OuDCRfzyPE0BF+d1mQjDC+RwYdHdgNzzh21+/GS8Cymz+sKYSvU5mlQamUveIPfbtN
         bvJuzvzvqEFsN4KBv58JbAPdYBneEQ14Mt7Ej2E9AZqYTnD0AO+9k6c03xnrtnNhs9Fi
         OAq4DsrI/DorgNHdV0OMEkVLKbOPWvj2yX4Y7adc/nT2aT6K1S2HNrbEYZvPoBmTwlo5
         5kXZAjG4Ur32BTFqFM50G/LJCAiqCjEdjEuvdpRDCXQgXlSc3dP29WcNHLHt3Uy6y1aJ
         Wek2t52rIebjeqDaiOoIxN6LAAeG6xoaO+Pc0r2uvfYgP4HMntGzTh2GH4UOwgwyuvGz
         J6Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/GPvbLKWQnXQUtSFqGetn/nLz5K56h402tonAwJpo8+e354TqM99wDaLJEO/dzS1mClOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCuZiPefD9qciADPxGVs2CPJQTrVs4iQH5oGnYF731z+An7hL
	2vz9C1iC4iyPqs0GICEZ1HZLNv/sXaJkVYApAicS7rKODmiqQycq29dujNwwyvKLufHM2z4r88a
	XFIFHmfh4QLFs7hNGiJsZtaZdrlB1ziE=
X-Gm-Gg: Acq92OFp86g6zV2Id6+C+OoyooH1WMnDXMxo1HZYg/KJhSAnD7OK9T6tV4iBZr91IQh
	23Ws6vyXs7f3RPktrJl98WrwmbNkyw3Clb6J/Hz1Lb97dGxSxjYiCq6SKmrR7TXL9nGu1h5ySoQ
	j7QKky6ulY4IaxmMyNyOS0ykXjHR4m4YUbW0VLUELFp/cgh8dqI3a/+QXnzFvzFGvcI6SL6Od4I
	p24jJxlinCtPmiXPaVWgDKseZ3AKpz93zOYL3a2sXyaEkV2b7BhdJJsHAcYs871VDLaWlHM5l6r
	ydVEx0UmM3LEXjNhJc1zM+LWNDIZYIeLABQw710BbQHgwId+2tz6APRR+Zyf
X-Received: by 2002:a05:6512:38c5:b0:5a8:9b6a:5749 with SMTP id
 2adb3069b0e04-5aa323a9f51mr4812397e87.28.1779929454248; Wed, 27 May 2026
 17:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
 <20260521135244.40869-6-kerneljasonxing@gmail.com> <CAAVpQUD8gsYPyZS4Dbyo0DMEjEczBTJRZ3OW51CPZhnLw22YGQ@mail.gmail.com>
In-Reply-To: <CAAVpQUD8gsYPyZS4Dbyo0DMEjEczBTJRZ3OW51CPZhnLw22YGQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 28 May 2026 08:50:13 +0800
X-Gm-Features: AVHnY4JtxR6v6tEHKgUcEj2YPTM0SwOnxyZSTt214CNsHr2ghH9-fOy5Tz9QpJE
Message-ID: <CAL+tcoDmc5eOTPT1BWqagS6tcTZn-pfJuwrsPJ5dvq3ZJd=eGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bpf: enable bpf timestamping rx in TCP layer
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

On Sat, May 23, 2026 at 11:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add two if statements to accurately isolate bpf timestamping and so
> > timestamping. They can work respectively.
> >
> > As to so_timestamping, only add a loose condition via report flags
> > to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> > and performance impact. If the loose condition is hit,
> > tcp_recv_timestamp() is able to handle the exact case and doesn't
> > hamper the existing timestamping feature.
> >
> > Make it work in TCP protocol.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 21ece4c71612..7ad3561dc8cd 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2353,6 +2353,16 @@ void tcp_recv_timestamp(struct msghdr *msg, cons=
t struct sock *sk,
>
> Simply drop const from here rather than casting to
> non-const for bpf_skops_rx_timestamping().
>
> sk in all callers of tcp_recv_timestamp() is not const.

Will do that. Thanks.

>
>
> >         int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> >         u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> >
> > +       if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +           SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> > +               bpf_skops_rx_timestamping((struct sock *)sk, tss,
> > +                                         BPF_SOCK_OPS_TSTAMP_RCV_CB);
> > +
> > +       if (!sock_flag(sk, SOCK_RCVTSTAMP) &&
> > +           !(tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > +           !(tsflags & SOF_TIMESTAMPING_RAW_HARDWARE))
> > +               return;
> > +
> >         if (tss->ts[0]) {
> >                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> >                         struct timespec64 tv =3D ktime_to_timespec64(ts=
s->ts[0]);
> > --
> > 2.43.7
> >
