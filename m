Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506082253A1
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203969; cv=pass; b=OlsWQVqpq+4tVIAGrZOiqiF8oPPMM+NQV190gHsCVhfwS67Vl1baWunBVX4IO85TrKj33wxiP55mr3Z2aJtWGTZTmrECn1amRZycrr9rcEbrXr8egEljoVM4Sw5rg9mkO9KanGIis+aLdjAWycXEjle6Pym0DMTPQpBAttzy0pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203969; c=relaxed/simple;
	bh=8o+OxVo5dswvJmFHM5vqM2X67yKJoqyjQ3xOcqIc+s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOx3H2PpAo4bBMaTKWXPJYcU3gSiK01E7O/b6UUDS/EcEnRcc1zyQBB/SWXxBECMr8cih9xcFpXZMS8WipIXp7Hmzvfv2FkAuS3gdfPjeOOQDKc9l3+WSDXttkQesyuuRXcgt5Ay7w8hS9yTk0zVNBtIw3zFuOe+6oTeu/4XELQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17GawgO/; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17GawgO/"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1248d27f2b9so3374739c88.0
        for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 17:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203967; cv=none;
        d=google.com; s=arc-20240605;
        b=T+nGORpTe+kQwdQCil0DdXU081B/kU7LIEFxJvqZjbP47CkssIuIp4ndbZ/fbn0i1G
         XUd+ObvIGIspOB+f9cRKmvE4pcOvCJydfsLQ2bsAK5Kv7ceHpenliQWMoYNqv7m1BMXt
         9m6BrGWd6n6UUDGl0WbIDRV+kZ8uORxTABafBgjCeKjpTRdLR8dOx6iR9tPNSa2pH0tW
         jtVpPpMHN+XO23COkPq394Vwqf7+zxO+cUr51VDdg14Ulr2tBiYE4ymtJNIUkPBLs1CF
         n1BZz18Jszx2jqEWvw5Wz9ZucI0bHHo6zOkL7LifVrLWSecEe5/XY294ThTSdUzkr8iP
         iwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PF+PQBCSpqpBKQv+Qv1WvGtt0yqefm8/Z5K8hlHVTIA=;
        fh=XmYDTajIFo91PxL6n5JuF4mTQbBRmFRaaRZN7BBtlAc=;
        b=ihZJCo++QinfdbG4yWdDjZPt44TqX8G5yrMWdsr5IGgKk50tYOi+PDZGLgCZSGh65z
         2bsOvdKGk8HbdnIDCeXPkWIqzogGrn4kFXGri0qBD4IlMG0DZXJbwAi2WjotWMiOTlu4
         xekVvjYS8OPb8A1f32aQ+1S1fMqu51EVg0p6kYRThw88RfIMM01tAUUsp2Ezdp4+Xdw7
         e/sBdkgYyLzlAwRNsf3cbuo4zKuHx2ggaQPXwkgkIqkU1uNcQVCY/ROwg+b3+qTDVRCV
         NhPaXr+IsamZz+yF/0poA/lCfD9k6WzIYLDQyMzBUrNGbP1zKllxTInzTnQbHFk3bkz1
         hfCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771203967; x=1771808767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF+PQBCSpqpBKQv+Qv1WvGtt0yqefm8/Z5K8hlHVTIA=;
        b=17GawgO/C+Ma1AjjfYOiAuNKxfHydCl8cligxwoyRE5ThsskHch0muyvmOwJf7UtLi
         u/JPCaEFFT6nLqt1oK4+K4af36M0Wm/jLXzwYQxaqjvxolRii/RR2LIcyXqsxUKK+Rgw
         MjcUvOzaNYDbcxEj3eMA8tl1eah6vhnzYkK9uMEmRA+kDaY1gQALFcfNZTH2oY2aIprf
         7atBJDrEuGu2iy9OTCmUbq/QfzsylbPG7wz+PJ2xb8o38yDzGQ8OV+//UeeFu21U8wbD
         Vy+I5PKYOfLcFqHMsk7N7bqYtcwYupJB/RjUmSb+UG+7UgOC8EPfII2ookdgy5Wcp8Fw
         aZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203967; x=1771808767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PF+PQBCSpqpBKQv+Qv1WvGtt0yqefm8/Z5K8hlHVTIA=;
        b=PHJ+j70/fC3TGe+dfCDasNelk2Tb//B/wWZ+Vj0alvK/wQ3usrwjyU+ms59bqfwzc7
         b72Co14eiGebuOp9siqzlAqDrwmx0XzfjOoLS1apZ9+BZSpgieZpug54CJOnoFUDVz3z
         Yop5/MkRaOtc3tpUcP2KdVoUxS23ckc/Ilfo1pNATTZh4MESwwDvu+nWoTvvHYrmeMJM
         iwuAiOK4cdQyZCLpszIwQt2IV6qnh7plEbKwp4jePEwXqN93OSH5lBByxeEIkhW297SO
         ikUv8TeBPvYIDyFtRGaZVUPrZGZKiPsnCpZzDIy7fWVqy9C+xCSVrV52d7CH0HPANVUs
         Vh8g==
X-Forwarded-Encrypted: i=1; AJvYcCWeSgnC9Et66rMl7OUFzjAkfXE/T/9ZVYKu+Za9VI0R3ObXOAt94oWQ2Nv7M9/YHYmOUSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvyFAbv18V7E5OT6RxEk3O0aCWG4taP2gzkUKjqe276dwLMKWX
	6hNJ7LPx/fN0KQuSpEvVe3C0lnzETQlNtBsGpRLH/3TJIv46DN6LXrBinbHqlE3VCdNhxtNhx6l
	6lF8u5TCAVvLOMZROrAO8XzGVBEOqT0nauhg52r/z
X-Gm-Gg: AZuq6aLx5TV3CI02vwkwIHtO4b5Qs6nnbuYtPa7tAxoZwReyxO7g4cS8pC3Igu9gU+/
	5esOgy9SBk/d7D2zr+HgzK8kw+RRgg/PGDAYJLWntdOnKsIfow/muMClU0klsXsX8G5YmTxuieI
	pHoHM2UZXbLd2z3vVAYgnp+0zR+9zTYlpOksYB36mQv+K8Xt2cV5Tt4fgO+3l01vZqVRhu4qGBR
	zPgVJeWb6qNm9QgrlK69fdZnYWV97CkF08LDi1JpXifPN7UXLuX709XPY6TRQ/UWsng1zGP3oHn
	dxbxj0W+oIdi/jfvq5EYht0qtlORdfVDDuzuQcRK9MfV8TahTXOeqo0o1J+438ATu5A8Bw==
X-Received: by 2002:a05:7022:608d:b0:122:1d4:28ff with SMTP id
 a92af1059eb24-127398196bcmr4548255c88.26.1771203966870; Sun, 15 Feb 2026
 17:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215204353.3645744-6-kuniyu@google.com> <0e28e4c337ddd569844020f2a999c7becc918fa9cfe2a0e0fa21ca363d3bb1f7@mail.kernel.org>
In-Reply-To: <0e28e4c337ddd569844020f2a999c7becc918fa9cfe2a0e0fa21ca363d3bb1f7@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 17:05:55 -0800
X-Gm-Features: AaiRm51D4W0-N7UOB1gIhuJx8dW0FG-7VHlWZksdnWF-OKNUYwEjIo_LcTMBs7w
Message-ID: <CAAVpQUCvSh8=297-3Qxo-TvsOrMh9vQ9o8eO_Q4OQHKpxqxNTA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
To: bot+bpf-ci@kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, 
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com, kuni1840@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 1:50=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
>
> [ ... ]
>
> > static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff =
*skb,
> >-                              u32 off, u32 len, gfp_t gfp_flags)
> >+                              u32 off, u32 len, gfp_t gfp_flags, bool t=
ake_ref)
> > {
> >       struct sock *sk =3D psock->sk;
> >       struct sk_msg *msg;
> >       int err =3D -EAGAIN;
> >
> >       msg =3D alloc_sk_msg(gfp_flags);
> >       if (!msg)
> >               goto out;
>
> [ ... ]
>
> >       skb_set_owner_r(skb, sk);
> >-      err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, true);
> >+      err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
>
> [ ... ]
>
> >-/* Puts an skb on the ingress queue of the socket already assigned to t=
he
> >- * skb. In this case we do not need to check memory limits or skb_set_o=
wner_r
> >- * because the skb is already accounted for here.
> >- */
> >-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_=
buff *skb,
> >-                                   u32 off, u32 len, bool take_ref)
> >-{
> >-      struct sk_msg *msg =3D alloc_sk_msg(GFP_ATOMIC);
> >-      struct sock *sk =3D psock->sk;
> >-      int err;
> >-
> >-      if (unlikely(!msg))
> >-              return -EAGAIN;
> >-      skb_set_owner_r(skb, sk);
> >-
> >-      /* This is used in tcp_bpf_recvmsg_parser() to determine whether =
the
> >-       * data originates from the socket's own protocol stack. No need =
to
> >-       * refcount sk because msg's lifetime is bound to sk via the ingr=
ess_msg.
> >-       */
> >-      msg->sk =3D sk;
>
> The consolidated sk_psock_skb_ingress() does not carry forward this
> msg->sk =3D sk assignment.

Oh right, I accidentally removed it while rebasing patches
from net to bpf.

I'll restore the part in sk_psock_skb_ingress().


> alloc_sk_msg() uses kzalloc, so msg->sk
> will be NULL for self-ingress messages.
>
> In __sk_msg_recvmsg(), the from_self flag is set based on msg->sk:
>
>     from_self =3D msg_rx->sk =3D=3D sk;
>
> This controls copied_from_self accumulation, which
> tcp_bpf_recvmsg_parser() uses to advance tcp->copied_seq:
>
>     seq +=3D copied_from_self;
>     ...
>     WRITE_ONCE(tcp->copied_seq, seq);
>
> With msg->sk now always NULL, copied_from_self will always be zero
> for TCP sockets using a BPF verdict program that returns SK_PASS.
> tcp->copied_seq won't advance, which would affect TCP receive window
> advertisement.
>
> Should this assignment be preserved in the consolidated function
> when skb->sk =3D=3D sk?
>
> >-      err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
> >-      if (err < 0)
> >-              kfree(msg);
> >-      return err;
> >-}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/220428=
99757
>
> AI-authorship-score: low
> AI-authorship-explanation: Commit is part of a coherent series from a kno=
wn kernel maintainer addressing specific syzbot bugs, with typical kernel c=
ommit style and mechanical refactoring consistent with human development wo=
rkflow.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: Dropped msg->sk assignment breaks TCP copied_=
seq tracking for sockmap verdict SK_PASS path, affecting TCP receive window=
 advertisement and potentially stalling connections under sustained traffic=
.
