Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EA36B92A
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902742; cv=none; b=na17LV+e9Ts1R2pgNHw9zDi2hZ89esQJgfN0zVkNeQ5R2mIbEaPTG2HMZw0gHZDowMqOSBGZBtWkB6jmmtITxtlgiBMnE31BbVrgCeBXCkn/xWgZ8zUf+Ywl6w8P6Hv/HKtDfsUGuXw7RPin1BOovg2t9tIVO6+nlrnL29anQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902742; c=relaxed/simple;
	bh=hSYPFxlYD1ip8K/v0cZqh0CiKk9SQUgVeVj9dCo/n3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiPucqM3X6/ytwtexz2RD4VvLDbHS1qi31KpU2gSo700CFiiu4HapQUOHUgx9bRrw8vYhpesGUX9AAwqjr4CMsr+LhoqF9mPV7UEkl7LT2ziBTwjJvoWYtvm+CZz6mleGn9nh2gm7JsIC8NMK+dvGMtnRcl3aP8eavw+6YgKsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zex5Ss6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zex5Ss6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D25C1F000E9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785902741;
	bh=/4aS5tqBbyEYg2JYic080MeS97BSf/0fWSkJxsY05xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zex5Ss6UMDChoqIIVmR0WFd+57R8aStO4uStxU1XWDa+XCoSIhUikt5fXLbBk0aZs
	 0XoTeTsqahVO9sdTE3q/FH5BguykLt4zJUBXTvyxlBtE0QT40sIA6K0A6F8ybUcWyU
	 DjHAVRU1n+QZKVy7rSXr+xA2JgCsZ+m6XeHAyCMOMzKXZaaKy24VO31hPW8sZfJXKB
	 QvBgwuN3v4b8oDuhaA8algqJHibEFSxA3Yki/Ub3/cGiM67suIdL6AaYoXpReI9can
	 tziHiUnVf1YyD+LhxW5l/EIjhQeFFXKfibMNZt4sFYD9HdH0vIeNOg6yaIDJi35ed2
	 ZlacRigG8aA4w==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92ed3993c1eso31311685a.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 21:05:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzrq5vx2rGwnAomqbk9PVlNpKdwZHADVSpLnV/cH4EKiGaoxFR3
	JhtFYjm9aRb5Dd+nq7u336/izKcLgHJNxAGvgX6nE4AnbxWXXCLFcbM4F1hN1LIDKmp/qLn14L6
	3B4tSqzoa0yA72+2QCD8qdyx4IxfoYIo=
X-Received: by 2002:a05:620a:6891:b0:933:4b51:d348 with SMTP id
 af79cd13be357-936492adf2emr349872485a.39.1785902740266; Tue, 04 Aug 2026
 21:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804164652.296919-1-mahe.tardy@gmail.com> <20260804164652.296919-2-mahe.tardy@gmail.com>
In-Reply-To: <20260804164652.296919-2-mahe.tardy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 4 Aug 2026 21:05:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ZTqfzpxNf=S6JbmGxWf2m9qPZGberdzRdLuvv2-Xwgw@mail.gmail.com>
X-Gm-Features: AUfX_mxVs_Mx-cddxwm6dK4qyFylkKDXY2mg3bGhGfKvvkKx3GxMUnPGS72pHIM
Message-ID: <CAPhsuW5ZTqfzpxNf=S6JbmGxWf2m9qPZGberdzRdLuvv2-Xwgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] net: Add __sys_connect_socket() helper
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 9:47=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> wr=
ote:
>
> Add a helper that connects an existing socket while invoking the LSM
> hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> logic. Other socket operations have equivalent helpers that trigger the
> appropriate LSM hooks that can be reused, this one was the only one
> missing.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  include/linux/socket.h |  2 ++
>  net/socket.c           | 32 ++++++++++++++++++--------------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 2a8d7b14f1d1..48f1eb8193de 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int=
 type, int protocol);
>  extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrl=
en);
>  extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storag=
e *address,
>                              int addrlen);
> +extern int __sys_connect_socket(struct socket *sock, struct sockaddr_sto=
rage *addr,
> +                               int addrlen, int flags);

IIUC, __sys_ prefix is for functions behind syscalls. Do we really want thi=
s
prefix here?

Thanks,
Song

>  extern int __sys_connect_file(struct file *file, struct sockaddr_storage=
 *addr,
>                               int addrlen, int file_flags);
>  extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> diff --git a/net/socket.c b/net/socket.c
> index 63c69a0fa74e..c7427dd4dd52 100644
> --- a/net/socket.c
> +++ b/net/socket.c
