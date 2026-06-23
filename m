Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E736F8EF
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243117; cv=pass; b=O+hYj9UsbbMAI3mjpSeH6QzqqxpFwqa3EGQFqgyCzQbU+15OCF8JGaXGDrl6HQqDgLLBbgRL7RNr3HytZrvBthkmSQxR//hh8rJn3zjwBUoJ0i1IA+asFVZcuer0RDMNG8fAeidgicmcS9ygYxiakkKjHgZtRSqXLOtfrd94DHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243117; c=relaxed/simple;
	bh=YYV/g9hIJvV8ysqGi0tTc/m+i/fqrwPDVXz4yll3gXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uow9S0TGC+52WTzwUVyYxaSs4EnCxWxMFcl+EHLY+907nBpVlKWQECV96HHhflWMe5Z1niFLNVZNgzjLjRCIyFsns/iR/UYrfuA3tK8lPl1adTGlAga7+K4Hbj6bABr2kegalpF6NgZcF6Aod5a7cXOzuFAdQKNlCFT/r/gLb7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zw02IrmR; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zw02IrmR"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-139a71baa35so566781c88.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 12:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782243115; cv=none;
        d=google.com; s=arc-20240605;
        b=CmtHL7SjQ3E4kqhS/Rg0ETFI6ZhOubt6/byhaeURE2rkkD/R0rGNRhk/wocvzXPF7A
         Bnm11vhGrXxevPBbhrqtXO2dx3LH5QyDgWSN4PwnoeCWA9cEXrxU9c3W/T6vaCgqonU8
         7oT7A5ciathe+eRvgyF2a4RkVsMtm2Iz4CNpaqTevQGtEKDsPt3XnKpk2bT+42II1NtZ
         acOOp5Yn+bz8kerejA4x/cNDwEsZPFephWXfSO/9YPS0RRcDopxdfnBwP735sUg8Dkzj
         nNDjjZ2FHwO55MYlvIV0B2KwEay5LSaQwT6kWn3Afm9ThDMTGCqeMSm/dHGVBdOzKcMU
         MmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LiRXa3AUVgbFVOjg4pvQyLBN61LuQwPW9zXG1uly1ys=;
        fh=eHpjKHrsPBLFAo6qmWotK/iSi5qSGhcL42Rz33h0Ek8=;
        b=Ja0Jbbe3G6llhDh51U8UjGe9mMzprhEBCoQPu0q8nrrznJS2VQ5oP1E+olY6Vnad0y
         XKEQFPSelRKRgmSHX58gSyC1pHvH1iNFrGGckg5iPAWxsCmK8PQB8jXQWeLHakLZUDPt
         AUH68kXe79sryl6O7XP/D8BJpJsaZe7bBKhxCDigtNegQQNN/mmunXEq2sAYpaI7WPUQ
         1J54LUp8ulclVaRKio+cNNGsirtfvgdvxheLGFUjWpDpmjCE64sfyC06WuT3Fx3PhiWd
         XvnUAo8YBbmuKrTAUrMsBQC9jXZyyzWmlUs/mAjI8cRvS2uh6DIBpcKS57SeRSx8iUv2
         V+XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782243115; x=1782847915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiRXa3AUVgbFVOjg4pvQyLBN61LuQwPW9zXG1uly1ys=;
        b=Zw02IrmRCcz0pgx5Sa2gqpe5R2mViIP/T+3gdQV3T9uIeGvmyvbY2sve7/CyBns36O
         hNx6LlajN1dOfJ/3M45Vx12Jc0fK6R+X48POQGfoWJ5ZWhncaRjgcYsHFNjnCY5rmUOo
         yjscuzLARBCDgVM/OX/O0N9oPWfjLE3XuKBDxT9pg+VjDSA9diVNU0wskzGmx0/jcESX
         Rq2iCj5Mp5/Rtc+S/1fG79iLmvEfbaAt9+HJsxDcFCO40GYvGIURnCsefZAq0PEAi8i+
         Mgt9BRHfKl/IRiPqIj7Lw4SluVOb/0Irgjj58aYjBd+M+bqMq3POhmPmNYzt4yMU7kGU
         AXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782243115; x=1782847915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LiRXa3AUVgbFVOjg4pvQyLBN61LuQwPW9zXG1uly1ys=;
        b=olA2TT6l4FXBULHWTbCZRMZkqtmgSJEiSx7zeZCozRTZu3TBw/ETMEnhRnEb160LN9
         S4jr24EEyZPnbTZKNP990p63hiaE1Qo6AMgElmFfylJ9SQYU42J23XpMSWkzQaDxwdkw
         JWBLwfqce8aIDUEfpciEh/iVzOzuwYvjXa8NEmeE544xTroUwbF6DGlH6f61M0uOjrnz
         kYfOwUEsGK9Kc9OHghWluzq34g70/Y0ePYlKUkcMBgT79+uwF3r9XZEQepAIw5R7ZP2b
         OJj+3sZT8mSBtPRW+X488ENJ8eP69LWjXrEEyTrV1WKCvy6eKDdrf3J87DpAp2Uv3713
         uEOA==
X-Gm-Message-State: AOJu0YwTR0gHv5QtmjIEfXJ9bWQ/by76EXkyQft8F2jZxWYEseHgnrII
	lICe8TA853AjOifYhU87sLU8603j+RGEekLEGV12r1o0RBLDdJKd/plEmuizdhvphxt2wlMQ5xP
	23TCLkGl65UgXnZkJOOolrPB0waTPC1nqiIGuBnHq
X-Gm-Gg: AfdE7ckHyhWNXsL3SJ2Cj5xNymV/IXvH1cWk8OckTNvJgIntr9zUkge2XATCTy/wvaA
	CyTJ/FUSk+Y1zn3ka0M/G2Op5dIkzJKSo4jwTI4N/hfIh4BSovl+mknIflIFhhPd+esi4MDsUzT
	1MzUUbonyV7KAzI6ULwCoke24Pac+V1cdrzqnzSlVSCC+89qQvkT4TP2SBBM4zBjVuZKUmf9JoW
	VNh3DiZNSUFYmFNj6uZJ7WBt1PlpSO6NHpjfNFx72Y25Lxy/2hyf8PW6ydPXCU0gE0NmkUJbjEb
	5QyTNWJC81La/Qp6zBScPy2CB9d6P9A0yAKd3k4MTWLMpaP1FWvTRJ/Bap1O2eOofmPpNRy4Rz9
	ogQgcLtMDjb/94u/PhhslIsN7mEukUkIrGRXyw0E=
X-Received: by 2002:a05:7022:6196:b0:139:cca6:54e1 with SMTP id
 a92af1059eb24-139d0c06c48mr104435c88.8.1782243114416; Tue, 23 Jun 2026
 12:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com> <87v7b9ysep.fsf@cloudflare.com>
In-Reply-To: <87v7b9ysep.fsf@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Jun 2026 12:31:41 -0700
X-Gm-Features: AVVi8CfuZZw17LEOEaWQQolrSVOcFnrMg6KA7Zb61QKHMEK4GXhNhK7MVne9oHY
Message-ID: <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>
> On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
> >>
> >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
> >> completed all code paths related to sockmap-based redirects should be
> >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
> >> disabling NET_SOCK_MSG. The implementation of sockmap as a container f=
or
> >> socket references would remain under BPF_SYSCALL.
> >>
> >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> ---
> >> Changes in v2:
> >> - Handle prot->recvmsg being NULL (Sashiko)
> >> - Elaborate on the end goal in description
> >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-=
v1-1-d7e0cb7bb03b@cloudflare.com
> >> ---
> >>  net/unix/af_unix.c  | 4 ++--
> >>  net/unix/unix_bpf.c | 6 ++++++
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> index f7a9d55eee8a..84c11c60c75f 100644
> >> --- a/net/unix/af_unix.c
> >> +++ b/net/unix/af_unix.c
> >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *soc=
k, struct msghdr *msg, size_t si
> >>  #ifdef CONFIG_BPF_SYSCALL
> >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >>
> >> -       if (prot !=3D &unix_dgram_proto)
> >> +       if (prot->recvmsg)
> >
> > There is no reason to have this dead branch when
> > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> >
> > Let's compile out all sockmap code when both configs
> > are not enabled.
> >
> > Since AF_UNIX differs from TCP/UDP, it can take the
> > simpler approach.
>
> Okay, will put the whole file behind hidden config option like so:
>
> --- a/net/unix/Kconfig
> +++ b/net/unix/Kconfig
> @@ -30,3 +30,8 @@ config UNIX_DIAG
>         help
>           Support for UNIX socket monitoring interface used by the ss too=
l.
>           If unsure, say Y.
> +
> +config UNIX_BPF

Maybe UNIX_BPF_SOCKMAP or something.
bpf_iter is supported without this config.

> +       bool
> +       depends on UNIX
> +       default y if BPF_SYSCALL && NET_SOCK_MSG
