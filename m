Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E73202963
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779594733; cv=pass; b=JUlne0vLsuJ0tPaF9UBAZRcyZOxD+yohw2SmhAjkOFom5BGectPhHMPi3461c/FZLYujA19HOWQ4W6ww5aLyR3Q9v5sop07stiY8C5CnoW+6Fnry5naPbTo9UfcLWYEd80UEV1yT1UPNwj1l1r97poYzR5utQIrLVePM3f6CpeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779594733; c=relaxed/simple;
	bh=uV1E8iHkG/G3zQNseFTbJjQByr54VkxJaRdd/6skFgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLACeU/MonqjlYj5Aq/CizJTS8S87crup1Rzg9bd3JI0Nyk8TLdX3G99F1Lk7REFOm0vfgax796Xz59GmTsUWM6hwhwbMYjE4tUGGPNydc2wMbBhi3SxMlQ6yTUDzxil+KxmIaoEaX/pMwuR83a8r8zcuf2O+0SjrGQ/qcfRO3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ED9yYxKp; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ED9yYxKp"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-136a89595c3so614006c88.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 20:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779594731; cv=none;
        d=google.com; s=arc-20240605;
        b=STQJh9McObrkRxob7kdpl+etP6jQ00qLFatQC7+GEHAO05jut2a1qjb1QnEg87Bo8/
         iB+Flyov3WRgbBtCXJp0Hc9mg9PXXzAiy9fFm3MhS8f74VQylI/tQu8ukQ+Ak55+TwXy
         fSS54nR6O8TL1722UwDPKzZcuRGpfWc3Cb56ogIukPJHGvOYZEbonDB8Qu1PNQKcXdjI
         c1r9wiTGsxifMIciCrBbdfBdswjAt9ipFJCn5FLIh79gaGmipZ0i98mPsCbGO70yjAoI
         ikE7GhQCzihKeDpuYkfqD5yxiBXIN28NlQ0GDXgOcdYeZLMBFBgqBFM/Rb9/BGmrc8b4
         XD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dGy8YHOGuSh2N3eIcWlk7IPH/bQpL0e0bWKETQzWtaM=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=lKPhm5WNDPPbkFXpnEo1t9ksPwRwNuWyMAv3AXW1NRoPWUtjspzD1Jr0wk8GqEKdMK
         GKC4ppEeKWqE8daSkT1QZjhIQTdzcpGS55tXHbBaaS4H3OFPMrXIECA9BKZUNMDMi20c
         JA4zKPDjIjY+GO8gIGEVrOBKGkYs8Ug8+qJA1d4oKY5PoExUIRzKfeSsXGirquERh965
         7fzZkF0xev9mgmz8QlBNowq8SwaaMbK2iS2ZEaJoQpjxVzxcEzBrEWmzGhiiJbREw2QZ
         4yI70h2/WjIpZerIcphpI1IZYC+48RIRbV9wqUV14lO9yTuRGMn82VcYZG6WP7T/Xsxc
         oVfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779594731; x=1780199531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGy8YHOGuSh2N3eIcWlk7IPH/bQpL0e0bWKETQzWtaM=;
        b=ED9yYxKpB9ppymAu//pzGYmXnci1zffAfh6ncXPv41lgw9Xj2Sq6MuDaW5Xky3Rm2E
         v77R451XV4ZfWBFlwmlpldGP0kSv5a+KpPPe/eI/K249eZoF6qfj3uL1BE9ERd2PRh2f
         1u/aBsvX4duBdv7bd1eUnUJYZWlO6q4xYqHYO8RxYLRqceSqCiXPAPDmpaQRZFMpHtyf
         n81OdVbIM+VGZPgb4hLvfg2rsY8/0CAawZhUoiwuFwmHbScAMqAO8IsmcpE+/6K8OPzs
         J//S7UXhfXshfWbXSUXS799NJqNE4Ywfmrbt0rFHuo7i+ZRw8R1ZrB+OwTItMHFD7hx4
         h7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779594731; x=1780199531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGy8YHOGuSh2N3eIcWlk7IPH/bQpL0e0bWKETQzWtaM=;
        b=eiQ5SMROIVsnqqcTMwZRpOFVa5SDlEo5OVUH1BO1YZA+mCh4z1zeEp8PiSr0QJk9wN
         EYEatphHc8xEN5KWetQ4Stv3FjFE1EQ+UvSbUys4zBkXNFzKmFazVdvB0FBymY2MyN8I
         jX/IpT5kSJuCAxKGzZBl3jZmWP37LeZ4qKS6LWh2fXaK7n+wDzYJTNSZNa8OWDAvOnz3
         G99b2qYgzaKLCFxsDU885mOmaslQ0KvtUGdLoX5wrF48HTfziLzdb1qXrlGmCFeEYfVN
         HIEyH7uD6A+HbGyyParuLM4o4dFUUINUo+GK+K+R9ZUktHMi0iBKCmoTaOAnk+86xw05
         P0aA==
X-Gm-Message-State: AOJu0YyS1eqnw7UqM6Gji9ZmTV6yiChRWsdI3XqQpJ5tTncDrI2+lpqP
	2BliM6a8+/a45shXrFxIkZBefvOT5V+MwKjyd3WEZoGiLWP/AnWBY2nBSJCJDEaQpabc4ybOY3d
	UcuJnG8LIvYdqDtkvnnBhWjBSKISDNCusbLToAtJx
X-Gm-Gg: Acq92OH/juPP+VHm1kF31QZTqVJEQGcCOdkuBQk1wQ5vPDm/uS0uNpDpAl3BGFSATiJ
	VpVGAclLU600XX0ieeOlecOnEHlFMmRMwN1PGCrSBAtf8/oZfJfa3hlwD10j221AUGP06nqPFRh
	ZQr2Gpgfli1pvCFQwI5Vi3mqAHjf53ufK0SVh98wTWNr8RgPKYxplXEVleA693Kqfs1PKIUDHuy
	qK+8n9NX6l6Zx/w/Lm/oosxR3eDYP/O2N8Xr0PvpZsM/Hue4MbQD+1rxTBGt/qf0Ko0n3WcwN9j
	Do5ddkVD9IB6NUXlVcMojXQMnzN11zqBCUv0WY5S/q7D48JkqGr0xpu8z1jr/rznv/zbqy6VsbO
	VCPmUOoUdvyEngbM5PP2/lWBDR5WWtP4rBnPQBqznXOAd4T0OuV32fkI40QhCwgbsiTGhyRBRCQ
	==
X-Received: by 2002:a05:7022:e98d:b0:130:9bbd:47ec with SMTP id
 a92af1059eb24-1365f6fe11cmr3076626c88.9.1779594730148; Sat, 23 May 2026
 20:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-9-kuniyu@google.com> <20260523094252.99DAA1F000E9@smtp.kernel.org>
In-Reply-To: <20260523094252.99DAA1F000E9@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 23 May 2026 20:51:58 -0700
X-Gm-Features: AVHnY4LBikqAQlB4TMDabsQ3-7UpeagswaGMzjUl3CfqnJQs9wfnmdWVOYkG5AE
Message-ID: <CAAVpQUCw2i_XtBSrU9t_6gDsus2X0=cwjg_27CHH400ryQo_ew@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB
 if receive queue is not empty.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 2:42=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Lockless call to `skb_queue_empty()` on `sk_receive_queue` causes=
 a data race.
> --
>
> commit 928b34616ed5f1b766d25ef2fd83e4165fe1e903
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if receive queue is not empty.
>
> This commit modifies the behavior of BPF_SOCK_OPS_RCVQ_CB to explicitly f=
ail
> if it is enabled while the receive queue is not empty. It returns -EUCLEA=
N
> to signal that the caller must drain the queue first.
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 82ec2291d6f00..4041b9fc1c741 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5390,6 +5390,9 @@ static int __bpf_sock_ops_cb_flags_set(struct soc=
k *sk, int val)
> >               return 0;
> >       }
> >
> > +     if (!skb_queue_empty(&sk->sk_receive_queue))
> > +             return -EUCLEAN;
>
> [Severity: Low]
> Does this lockless call to skb_queue_empty() cause a data race?

No, the socket is under lock_sock() here.


>
> The __bpf_sock_ops_cb_flags_set() function can be executed without the so=
cket
> lock via the bpf_unlocked_sk_setsockopt() helper. At the same time, TCP
> softirq processing like tcp_queue_rcv() may enqueue packets and modify
> the receive queue.
>
> Since skb_queue_empty() performs a plain read of list->next without
> READ_ONCE(), this concurrent access can trigger KCSAN splats. Would it be
> better to use skb_queue_empty_lockless() here to safely check the queue
> state from potentially unlocked contexts?
>
> > +
> >       if (unlikely(sk_is_mptcp(sk)))
> >               return -EOPNOTSUPP;
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523083001.29=
11931-1-kuniyu@google.com?part=3D8
