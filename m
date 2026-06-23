Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F193090E8
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230902; cv=pass; b=uJyNd7Vyb29+Xb0ECp5TrQjy29WLBttUCp/HQ6DAPLylFG82HAYbPUa8OK93f3K9B5SpRUsLUcfFklhMjmeVMe1vdQoULXHx8GYLVc2nMPUsPd9imGuMYCyid9vW/S3TFKKOnpGEQ19MPYyrJoFZczvTYPaIKHF3Gvt2r4zyw2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230902; c=relaxed/simple;
	bh=efDqvwMKjO5LEpENsH6RsfoLlos+OcUFj5FOVKihLxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQOEyp1VDBWF5CUQxej42ueddNYHEib3wXGiS2Zst7Sq6icR2PiXJbMvv2SrJ/Be7qDRGY3OtnNVymMMpqTrwiTDc8fBuA6E1bFPsNw2jbgCQS4tSrmJ8vPYu5BbDPue8CnJAOAVFxVC1jLZgSbH6BspRr1JbEcG/z582rOaKbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6uZlRhC; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6uZlRhC"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139986373b8so22903c88.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 09:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782230898; cv=none;
        d=google.com; s=arc-20240605;
        b=Kq4jdxX0V/Lowm/IWCZGnSJl4bPNDaTUFF2D9jlKpfZpan9hPQJrtnL9vK5YdS5hOF
         kE15au1jYUUXMArgrS3dkoK20TJRAfuVzpiRifY3iZ5Q7NtcVN9rard9p8iAzWabq09+
         dEEeVp1Ov451bCzyMQHJoV1ZY/4mGLuVMrlqIhuAEYz0uULlxUac1ccrLeiYg6qyfRLg
         TB3GbkgqReMr87LE8eSYKJi+xZMUbE2sxcMmlWVZovyFjh7bPonLNPthx2DqSbhF6MEg
         vq5T4SlCkUsX1yqE1Kywo8XsKYWzzxNsv+iPrzvwziJWJzr+KdV5oIDvXhhAjG59ZNjD
         O4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QDEmqsxEFgmNDu79H8L8WmTiCEfrH+mtXrKKg7q/FzY=;
        fh=eHpjKHrsPBLFAo6qmWotK/iSi5qSGhcL42Rz33h0Ek8=;
        b=bVAu/UZbPZpWfqxWw2yJ5SujmwBy/Yy0TtMPlcn7uFOE6+5F5R1IiFvsUd1aPu3iXB
         mFBtYWK9A9I650oB0pcHG+hWCkD8ObObZAJT00JornrQ7BNNXuymRx8lAS2UOYib4HUz
         u46DvjW4utgdk441yzoMN1Pe/anwMoV40YsRDDvrW6cJxKSHd9UtHw9MK+eVoiR6VxBs
         W8O2DNRLHEdBgX2T6pUYJMc9Vf/+mInhb9pVqRbWf8bB8eUqbRbH6AMsXrte6Tl/6HI3
         RG3CUeX7vaGWkBmrrsxl37Gn+35OSDViG2/PteefTZ0kfcd++WgpOO+sH6G6Vs0bzlVD
         Pe3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782230898; x=1782835698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDEmqsxEFgmNDu79H8L8WmTiCEfrH+mtXrKKg7q/FzY=;
        b=S6uZlRhC91gyDu5/r6RLRvDFOdU0lWsEckTBDa2Q2gtCsxUolI8yMXdRUttF5kTHdC
         SLJmoNhBuhGVxoPM0bNmzACH0r7gcE4MynEExyaxGTVViaoXr3MIZ6yDgcpArTZyIpOm
         rD/JfRYz4l+0c53G2fKTliv4dotDajyqavEPm6OidvI7+jtBBdKMPQZU9zqWtcsklBhH
         Dik0wNX7/BaXR7ZDvSbs+Lv9VnutEWzXP5KlNt2bKbrA4MAkwPeASNOc+Uxt4RIULLTh
         c6qDjwR9YgxEM7JK3nxu5H78FKRYwcX6k0TFA6CDfEv9Mbap/Kl52coiQT/A7kt7PqKd
         f/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230898; x=1782835698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDEmqsxEFgmNDu79H8L8WmTiCEfrH+mtXrKKg7q/FzY=;
        b=nYmDY4aW80JbivT+e/3S4RSMdSV9JQle6YNMVtPVRRWK5gXghdkXX/TC+NbMw63sB0
         E652HhnIdbpIENucNdHpZ23r6U3yv25bpD4wY3wV5veaKDmoT9ycxmnRYjjBss8B9Rp7
         1kBoKrDjCBcXP2UPDALunVqEM87WNCiH+vArUNON6NIQniCSqRw41aH87UpO/gR0fUz5
         B6ZrzHGA0PcY+nPB373cKWR7LxCrPiKbDzGeaWvaLyKtGwaFkMDa5NMPrv+DC+cGg/ML
         YAW+3X7/l0iZHxdPwQuwbfEpw3d+kKd+8ZxrhEtwE/DCA0mfJqROd4d+mpZ1SroUldCy
         WymQ==
X-Gm-Message-State: AOJu0Yywd6JcPEGUJlt4s9QWBmab0CeJl5xmmQuLl1eC2oAckIzAT1VD
	tB17WSQ/tCJexYJ0en+vdt6/lZu+tk80+Okvkr0xtJS8gdez3arwlslJvg0jVlPyU8bCMxF0na8
	wAGmKQhhG6FXrFAtQFmOHa9N0bWz1EvwB16Ntp2nc
X-Gm-Gg: AfdE7clmDY3uXt2TxkN7Yk3UnRpkDgsMm8ZYeBBSx4McBPAj0sEYLCqy9gnzqXUTaL7
	JUFbfrODqqhf8SKfpDi7CABbzwk1GjhvJyzgrbfrNKO2JbS9mTi1lgASpgRLtwoa6natozDrBYO
	CFlged6t2kszWJWwwbi9uI2EhNjjU++6ArjbmJJbig3gaEYODGVAF59/ws7dPvaqUEEExq6F1/j
	921aI7d3xBr3IBdkByLrPbMz52aPMTv+ieObSrwpg7lrad1O2LvGOxv8MweoUKTZAwkc0hEtM5x
	IjDm37NeQcylRUxFwOIujTJLuJNPEO1yCVLiXaC3Cfybwf9Whi4r1tRhH1zZXBzwISDZj4fxrVj
	T6IILgjie0M1NDix35dXbhGkFelpSTjH4o9QZLFs=
X-Received: by 2002:a05:7022:101:b0:137:64ad:a636 with SMTP id
 a92af1059eb24-139c6f4f350mr2671104c88.27.1782230897470; Tue, 23 Jun 2026
 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
In-Reply-To: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Jun 2026 09:08:04 -0700
X-Gm-Features: AVVi8Ce9xskQNam5h2s9SZz03OnfDUSiMjXUPhtZCQHvy-a98A3NZ4_p7YLSNqA
Message-ID: <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
> completed all code paths related to sockmap-based redirects should be
> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
> disabling NET_SOCK_MSG. The implementation of sockmap as a container for
> socket references would remain under BPF_SYSCALL.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Changes in v2:
> - Handle prot->recvmsg being NULL (Sashiko)
> - Elaborate on the end goal in description
> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-v1-=
1-d7e0cb7bb03b@cloudflare.com
> ---
>  net/unix/af_unix.c  | 4 ++--
>  net/unix/unix_bpf.c | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..84c11c60c75f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *sock, =
struct msghdr *msg, size_t si
>  #ifdef CONFIG_BPF_SYSCALL
>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>
> -       if (prot !=3D &unix_dgram_proto)
> +       if (prot->recvmsg)

There is no reason to have this dead branch when
CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.

Let's compile out all sockmap code when both configs
are not enabled.

Since AF_UNIX differs from TCP/UDP, it can take the
simpler approach.


>                 return prot->recvmsg(sk, msg, size, flags);
>  #endif
>         return __unix_dgram_recvmsg(sk, msg, size, flags);
> @@ -3152,7 +3152,7 @@ static int unix_stream_recvmsg(struct socket *sock,=
 struct msghdr *msg,
>         struct sock *sk =3D sock->sk;
>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>
> -       if (prot !=3D &unix_stream_proto)
> +       if (prot->recvmsg)
>                 return prot->recvmsg(sk, msg, size, flags);
>  #endif
>         return unix_stream_read_generic(&state, true);
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index f86ff19e9764..5289a04b4993 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -7,6 +7,7 @@
>
>  #include "af_unix.h"
>
> +#ifdef CONFIG_NET_SOCK_MSG
>  #define unix_sk_has_data(__sk, __psock)                                 =
       \
>                 ({      !skb_queue_empty(&__sk->sk_receive_queue) ||    \
>                         !skb_queue_empty(&__psock->ingress_skb) ||      \
> @@ -94,6 +95,7 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msg=
hdr *msg,
>         sk_psock_put(sk, psock);
>         return copied;
>  }
> +#endif /* CONFIG_NET_SOCK_MSG */
>
>  static struct proto *unix_dgram_prot_saved __read_mostly;
>  static DEFINE_SPINLOCK(unix_dgram_prot_lock);
> @@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct pro=
to *prot, const struct proto
>  {
>         *prot        =3D *base;
>         prot->close  =3D sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>         prot->recvmsg =3D unix_bpf_recvmsg;
>         prot->sock_is_readable =3D sk_msg_is_readable;
> +#endif
>  }
>
>  static void unix_stream_bpf_rebuild_protos(struct proto *prot,
> @@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct pr=
oto *prot,
>  {
>         *prot        =3D *base;
>         prot->close  =3D sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>         prot->recvmsg =3D unix_bpf_recvmsg;
>         prot->sock_is_readable =3D sk_msg_is_readable;
> +#endif
>         prot->unhash  =3D sock_map_unhash;
>  }
>
>
>
>
