Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D67C2C8
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420893; cv=pass; b=Z4pV9BEjacgJ7PJGCJIld5SCHkv7Jk1RpqJbocEMHFUi9I5KPtycin8fb9+Mlf81g3MqWgEa+YKFYKkKiW//xyh8u+HWKW8JDs/X2Lsa4P4OrhLtHEN8T1J7EuFRoLcYbgRG0/xykJuWsAFPIgqCnHGRVpRJhjJrPYg24DZSeJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420893; c=relaxed/simple;
	bh=N4cvQQpSCCVxgobS+gaXKU9+FfwbkYYY9srUBSprNeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L40BkDg45vrWsbSeajyyNE+YtuUVQvLYqO8P8A60fjbFCgeHL/TXXAyfMGoyvMGBqLtQRZMB+U8fyT/gZcvl9tDUpCiJeDcCQyKVpIBVM9hCgAgysqEWceCDwjtzuYY2TcDz7qAXtpjP1CsAVmowDmglL05u1aihyYEW1/l7EU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9to7u5m; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9to7u5m"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf27856f9cso31208945ad.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786420891; cv=none;
        d=google.com; s=arc-20260327;
        b=qRsTPPtxlWNmJlF76jJyw2f3q+GyYfSal1RE/DrDtUG9A9lW6U4J921J4HkW+0Ibno
         snqD3/D058/+0xe+6ECtDRpPU2T9cDQWX11bp4nYyAxrlKXb0Ff3yNPuSumB39bGUI/x
         paRbHGkdrcbL6/d/zLC0lfFaAf6tEZB8HcmWAIb/DkFRG0xSDqPBI65SY97BYYwiIy1Q
         F0P0tr0uI6oM2JCZNEcygWSz5DhqTwt+54Eqqs8UjSBP+LnxXxOgl8PIsi7StaQPT1l3
         Tv22GJRGJ9pULWRwCpS57SkOtG2N0TtUd4+7lCQI3ECeJZ+NEYyB3VfgEQ6oMUd3JQfW
         gWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IH8X9ffFgCCA9HcSxvTrvo6l9aZatdGsDMaoXD1Tpj0=;
        fh=tIft1W+1yI1ewJUuHlHaCzqxmAWp5pHc60UEWLQNmE4=;
        b=ATfUK2fhYBOsIMQUCATkfj04J/hOI4uiKyLA+dyyE3Q7cVLRyvX6dbzYm6jib0ayYo
         oo6ol1eTlo9fRp9OXwB4QBiB6Qinxdt0fWBATaO4rXDzbRGujEtu6EvJj8OxG07k+qoF
         z1wF+IQ0OJUaTw87O6OlrGiw/fpP0WtyF32igTKUhoKLNYjC/KEZgNKOl/tNHGCZ9EVH
         2yag+3Xw1JwiKc3q6VQ/DeNT6Oy0lDs1io5VWuTEYR+WS8MOsxKOP182dqy6m7rGKymh
         SLuHWq0oQG8E7E0M2u0GEMlf0o17NC3f5cY8btP0ylWkevSEKnOKZfj3dscWLlcAC8PM
         JBrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786420891; x=1787025691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IH8X9ffFgCCA9HcSxvTrvo6l9aZatdGsDMaoXD1Tpj0=;
        b=f9to7u5myVXpsq/8C3mjhsZtex1wLRZgyv8c9f3AjUjURqjoN+NoL+8NA1eFsu+RCp
         woOOlGcnaesq4hyN6WdW2CN+Dlz7Unj0YGziXVsBI0vIIGqGlKOApn2oo+dJPyOFNnao
         /gmp9FgQxYRpF4ehn9NCvJSuUknjlxbY+PEugwoj74r3AgE/GxW5mToE2Gtey7uNbW6p
         q/Dd6XWFMjIMuO6JKIbExcNH+PjIDD3RHttBflf9w3n8uy4KG9V5OMtHgCNaYU7USiJk
         QKyB62XIJ5I3gDcNgAFQDXfqTuHnTGNTbls4/V4B5t7uRVDdlnawir+l4xf3xpMwSFEK
         CS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786420891; x=1787025691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IH8X9ffFgCCA9HcSxvTrvo6l9aZatdGsDMaoXD1Tpj0=;
        b=H8iqeVOOg6NWIWronIZGL5X5VSj2ZroK6o5fSkCnmu7rv0wXDKJb7gfk/3/AabwwwR
         AxGrs57gwVatGl+dNHfbBgjMQry/P6THBNvSoH5Tpa1czNtF1+UgMusBvmiE0vMTWOnY
         jx2b171FNNce66XIzRmYdf6VSDic3SpAPmwfWYAIEKoEZZLIuq9mPELvIpchcrhQTCJM
         60Fzex7hoUdxx5/G2Cb3MBbUl8B5nEYANYAkjuzqb3wrRt4bkZ3Kfyop45KJGSWrkdLt
         tNUVjOYqg+nnXZNNq2M4drMcv7rd6AKmJvlKcDNVVNx37IA5yy8Cj6sJUL+FvkzkLR/e
         YZDQ==
X-Gm-Message-State: AOJu0YxCGkmBifuNAw5+i8tw6QVkjcBw5MWngPY0YY37enhKrhpVt36O
	bnYrmtN+o/HY46e5fcA5Bl+rIMSlABt+JPAoegGOtSqBpqi+dP96ndOe88UD+E5aBWrKppB5Rak
	Kb6lMcfK9/2hoxynYpZrsH/1Pcv5hEsRmY+2OrQpT
X-Gm-Gg: AR+sD12EdcgrQcmN80eG+FlAYxxnXKtCUd/5RVaWaIjY1PrD1j32++a4PbuYFWnhtrg
	Lohm8y8Rv+NGGwrNqWqKZfsvRw3SI0D64R2oWznh3983Ouf1/eqfoIl0C5ieliWbivcR59I2Zqh
	tIoojpAHu52SFbJjr0j2rKIeGmR0Q2px0YdwLpr5SBPYTnv1/0Bc1hwPCOPP3ayigTUO3DHZvvn
	pUdzwgWU3rUkK6Dub+iwdzYg/vbp76HJHQFDgoQVgSbjlE7Xu1TJCQnDCba4mjFgODdVHYMJy18
	idOH61orAQYj2mHVsfPkRQxgjcRyzTfQS8qR2DGIsIQxMJxm56lTO3Pt05KPfabupe/e4hNKXh3
	8HQmIf81PPmClk87jZAXtdyGiU1Y9D3ucaemgomIw77PwBAsKiZlKVgbE0C7Rg34vDPKqp2mUqS
	EfkXJWiFtPEW9ERQ==
X-Received: by 2002:a17:90b:288b:b0:38d:f94d:4c6e with SMTP id
 98e67ed59e1d1-392ec68df93mr369793a91.17.1786420890210; Mon, 10 Aug 2026
 21:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807171532.125149-1-mahe.tardy@gmail.com> <20260807171532.125149-2-mahe.tardy@gmail.com>
In-Reply-To: <20260807171532.125149-2-mahe.tardy@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 10 Aug 2026 21:01:18 -0700
X-Gm-Features: AUfX_mxByUImmrQfMF95LGk7G40gNzehtqjcJh8N2O1ME8rfof2nVWqUpUM5ct0
Message-ID: <CAAVpQUDcckytw4Y9S4mK8T75DniD+_=stL9BOo7Sp70OFAOjgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/5] net: Add connect_socket() helper
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com, 
	ameryhung@gmail.com, memxor@gmail.com, jiayuan.chen@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 10:15=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> Add a helper that connects an existing socket while invoking the LSM
> hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> logic. Other socket operations have equivalent helpers that trigger the
> appropriate LSM hooks that can be reused, this one was the only one
> missing.
>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  include/linux/socket.h |  2 ++
>  net/socket.c           | 32 ++++++++++++++++++--------------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 2a8d7b14f1d1..5a5eb1250103 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int=
 type, int protocol);
>  extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrl=
en);
>  extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storag=
e *address,
>                              int addrlen);
> +int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> +                  int addrlen, int flags);
>  extern int __sys_connect_file(struct file *file, struct sockaddr_storage=
 *addr,
>                               int addrlen, int file_flags);
>  extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> diff --git a/net/socket.c b/net/socket.c
> index 63c69a0fa74e..8f18f124d92a 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr _=
_user *, upeer_sockaddr,
>         return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
>  }
>
> +int connect_socket(struct socket *sock, struct sockaddr_storage *address=
,
> +                  int addrlen, int flags)
> +{
> +       int err;
> +
> +       err =3D security_socket_connect(sock, (struct sockaddr *)address,=
 addrlen);
> +       if (err)
> +               return err;
> +
> +       return READ_ONCE(sock->ops)->connect(sock,
> +                                   (struct sockaddr_unsized *)address,
> +                                   addrlen, flags);

nit: indentation is weird, and

> +}
> +
>  /*
>   *     Attempt to connect to a socket with the server address.  The addr=
ess
>   *     is in user space so we verify it is OK and move it to kernel spac=
e.
> @@ -2119,23 +2133,13 @@ int __sys_connect_file(struct file *file, struct =
sockaddr_storage *address,
>                        int addrlen, int file_flags)
>  {
>         struct socket *sock;
> -       int err;
>
>         sock =3D sock_from_file(file);
> -       if (!sock) {
> -               err =3D -ENOTSOCK;
> -               goto out;
> -       }
> -
> -       err =3D
> -           security_socket_connect(sock, (struct sockaddr *)address, add=
rlen);
> -       if (err)
> -               goto out;
> +       if (!sock)
> +               return -ENOTSOCK;
>
> -       err =3D READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsi=
zed *)address,
> -                                           addrlen, sock->file->f_flags =
| file_flags);
> -out:
> -       return err;
> +       return connect_socket(sock, address, addrlen,
> +                                   sock->file->f_flags | file_flags);

same here, otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
