Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0F31E846
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148656; cv=pass; b=ccgU50f8rIIexymsClT56RKCMCribqXC1UpDxYhOPxyQXmOV/3LVfR9Z7l2kGagpGEv4/ptFebvMeU6POWcvGiysFOUVVcegpETwku7lcPCiRMYyvKfZJ+eLeZcPG6ZZNQgP4D1PRZ8vJbgPtsA+nHE6bV73Xq+qmwLYchgMNrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148656; c=relaxed/simple;
	bh=4xz9D7VAQrmdEZXxAcS5UoEWPCKtzjLiBUCPWtmx2B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iy4zY3cB3DR5YZYiP0hMaUpOpvghbHiWydgItqiNsnEPvzCpoQMi0RNtdGOZQIuO0pU6uvXovIPeT9M12GPys4HwL7s0K9Oj83INID/Dl76dpHLw4XVwju0b+jJBHCTKuUIhwRwBJ336kpG+RiQU90yh4IcYzRTH3Do0tXzY5KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkzAcBi6; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkzAcBi6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a4113ab355so3531940e87.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779148653; cv=none;
        d=google.com; s=arc-20240605;
        b=h0EAH3xJaDfyB5EeHsTlET0Oeruay8LYdaE0yoVISZtiy5Mg2huZgEMjalJH67lg4t
         m3AUcqXLX8lKhFRKY11dEDrQ9rtlXruoKYFMXIQ6vVgxXQuoZgMT8Q5ByTR1WZCD4JmV
         If7ALR6CLrBkkJavq2+/qkqQAYuKtWvp2/KX17Cfe65QEdVrFACELmBExmIUEGe8E0uy
         Fflks4Oha4aUnHigub5Tl5cVq+qwRmSNbEiZ7hDQgDiNMU0aureq7ir0OmJW7c3y4Y53
         Gfdd2nxDHJUXJcw0Cp2vWvF3iuObG0GNnWTK3E2TK+KmbEvNUE4JpK7HKZCFhXB6El/G
         miyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W8rgBOoJQIg12SJZYcIEL+l2QP9Xebk+rpGwoK9DyJ4=;
        fh=P4qKipo/Ikcq5Vu2m/7Mg9VNsNvNXrMGmp7o6ww0kLA=;
        b=QVjzzwetACBhQymH0A5RASjXo+NqtUUL8BFVasVt3vmnbGcTmJUbkD/u9ZHfvoLBPg
         MmGGWM8XDEWpG9MUv65a8esmFF0ZwvbMrUh2ZxaubBOKzX2hX5zZNYXV1CQWPFp9FZFK
         mKoD8+9iGdTOLxi6UWJbRTAmf4YYAsdKDBJtj9UXpJsJmKDJj68CQMyVj3zC9muLxKpV
         A+QWmo4SwdM1JfxSWo8tb3TxqffM0nqxyEKn0S1D0ZjvG6ghOtE3KO3Uo8WzmjYy3LvJ
         e1fzV8qxAf1WG/4Cs35V0Egn3woBAe5QQ+2dXOVGxFxGSjiKeW43Y6LF6XRDZkJ1jGZh
         sgyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779148653; x=1779753453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8rgBOoJQIg12SJZYcIEL+l2QP9Xebk+rpGwoK9DyJ4=;
        b=mkzAcBi620+pQwhVeVniDJ17RfgJhvsMhOx3i+BhAl1H9J7himww5AH/FFlSDwiGkD
         Ao5qNXgFsLIzq7jSmQkAjWHprvlbpVBntUkb31O2EF34b5kz7RqBSbZh9LM8rcU/ZpGU
         BUOcoByPnEaX3V9+pJWSSe0Ja4ZV6TX8g2//ZFPrVuh4+Gzk+EoCqEinLMUU7JOjMcyY
         hlku4y2imW8glzB9nWIzmuCa+LH486+eGcTE37ZLTLppPfjnwPhXk1TrmFPOuCh7Wb0V
         5Dq7QL1+HHu1S7R+A6Zg8l1v9JKPTHFIyNTs9CJCTAzSP4syXfJfRVJcrigqma8JKVhr
         uAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148653; x=1779753453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8rgBOoJQIg12SJZYcIEL+l2QP9Xebk+rpGwoK9DyJ4=;
        b=awkUuUSYp3gRW+io98OxM0+dE91cmZDv0tOwsCgE7M+7gxkkOrTdpz0n0byFOOdGIL
         gqfopeA1i2PmeKdxKvbfMheMKDUNbtU64VH0Okz8gBe/tWZic6YB3BD8PJ0W4dOh4qXY
         LFGHf1X3vPQBPOLGs0no0YBB1nnErzMdZ9kB3oFrBAz+3uOmQjNzL2FIbHLQyubgodbA
         W6gg5SLPAVDzg1GuyIiskv1pBjiBHWTN9fB0hMcgTKtflVWshBKhNxVc+wfvggcMxHZx
         uuYt4z3z6qDON5ffeJMQPQvoTXHqvqytprQNA+lyHfLiYKt8gRaz7zjZetZo0zWh7Z80
         cLmA==
X-Forwarded-Encrypted: i=1; AFNElJ9DM/lyjY5p3OZEGb40jcsNGJSmwiLmBJDPZexbexSLaP/5z7ryWBLWPUxN/7XcAizPxqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyycT8WOlwP39GGq4Ttr56VkOvQgrGqpzAOOq0/k0GCnRdELJrE
	IkVg8TQLj0QhUcDPq2sQT9rm/y10juTH975VxnmJy5xaMKo3MSxyvJSBaUqYN4OSJWgQpE2km1f
	NNTUUV+NssSVA9djhm7oP4f1x8hnKCKU=
X-Gm-Gg: Acq92OHGL358Kjv7fKyj6a2KEypXNLgMnx33xnvgGguWrlFAybmQ8euicWq24F1CPX2
	mY7yr6t8FdOotbBgLkl7TUltbKv5DZWuX4o+/puT24FN4HG3BUddqKl/QsCnzxO0ZzR8TGvlIbK
	5VlajP0UUsorCi69Z/B5jMr1cx3w0CI/Gvdn57ZdhZvAsBR6WJuhVddqfBrpJLUTCKdgB93CuSn
	afmlMz7a/yiReG7orh19sxz9Db7l+5uI+hGvpOiX1MVM4qzN41aDTR+6eewk5jkztc957FFUS5j
	+0nVRh/i5TxCKpGHjMU4fbaPD9w9dswz0Iet2K4=
X-Received: by 2002:a05:6512:1094:b0:5a4:175d:21a with SMTP id
 2adb3069b0e04-5aa0e600e20mr5276550e87.2.1779148652475; Mon, 18 May 2026
 16:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com> <agsxE575ri8iLgxM@devvm7509.cco0.facebook.com>
In-Reply-To: <agsxE575ri8iLgxM@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 07:56:55 +0800
X-Gm-Features: AVHnY4KqQCXKCs456Fffv-Vucw_lyoIiww_LVFXcU_9Mv3prioM5sCl1Gc9ovRg
Message-ID: <CAL+tcoASR9sfdi_TiMEN2kqb=WL+HCuOTcO3h4XrLVR+2G2XCA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:34=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/18, Jason Xing wrote:
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
> >  net/ipv4/tcp.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 21ece4c71612..64c69bb3578a 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *=
msg, size_t len, int flags)
> >       release_sock(sk);
> >
> >       if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> > -             if (cmsg_flags & TCP_CMSG_TS)
> > -                     tcp_recv_timestamp(msg, sk, &tss);
> > +             if (cmsg_flags & TCP_CMSG_TS) {
> > +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > +
> > +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAM=
PING))
> > +                             bpf_skops_rx_timestamping(sk, &tss,
> > +                                                       BPF_SOCK_OPS_TS=
TAMP_RCV_CB);
>
> What about tcp_zc_finalize_rx_tstamp? Do you not want the rx tstamp for
> tcp rx zc?

Zerocopy support should not be complicated, I suppose. Let me find a
benchmark to test it locally.

Thanks,
Jason
