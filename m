Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8929D281
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928645; cv=pass; b=NXJ3cAOS5M477BC8Z6n7Up7hk2SYiA8eljkSIonxrPtMrDyeo833Dg0wHdaSr+0JbmEW0Hkdmk8CkRrWXPatM5ClAC1b36jYXwaH9i5oii2vXVq+DBhHiU1xEfscBFv3uSrfn6f60Z77PwN4vuE1cv4e1KHVdulzPL1TDpN7iAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928645; c=relaxed/simple;
	bh=pMLKLK3nq39gFcvHpxAl4HnbkxQ+9IlyYFibJ0T4x1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG7qnNM9XjBiyeTRQmrn/DRrX7s6vCO4crvtLGqQZHhuGi9Rjhv5WKocn22m+92sMAxKI/AlGwfPrCnpd28vRf49KR6X8RwPdGGC3FxZna6SLH7OfRWpv/qVB03zPz1PF3uKJyrZjoHpTrM8a4Gk5qyMri9rV0Agyq7qUFckN4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=f2YRI39k; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="f2YRI39k"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-86c0e4dd49cso69702107b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 21:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788928642; cv=none;
        d=google.com; s=arc-20260327;
        b=D5ev+jfsABMTNBGGxqwJNNWyaURgquf0YA1Nb7IsZF+aCJfsAe90Ut57lsJclp1GO0
         dtBQF94Mx4Y/bsDsbsSMUF6rqQfRRxMGyFvFkklPayByNCTgVxOIw8oYIAN20WBe909d
         txvv2HGSiyp6l+lxSJo3yDwgO7TJBThNsNoQXPo1tZ92ONpzq175F1ahERnxufb73LMo
         IUINeEt8Xc9IU9MU61+uyF7MEJaD7tx75E6kYQKfBbEsIjhaoHDIRBLKt0p13LiOM/FB
         MEXIEwDxDbklYFrmXf16NM0Xvj/m+joEgjqOemI/9N8RUmB/VatxB/6zVxO6eYccQnmg
         udGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K43nwTCuKB5R85lEVjD8dKcWwH128UtGJ64tWvb5aWU=;
        fh=9WrjyN4cHUBO9jgUHNBtV7dtIuQ7s8721skQEGzHYcQ=;
        b=PgWCjWtlcPiX9Avy/UOZgmhv2O0e1hGuEamfGiyZlZtdAtm/Cpc7o1y1Dhh/QJS08K
         NJGAhRTrg3vN2hLbIWYTv1CqhPsqNe4/2AzdbcL4Ej9PpPHvy5Kxa04L6iTRPVnFNcT+
         fz1UULlC8JAjJVXVjhmxtTCE8fOzg5yiHMJ4Y4KM6qLSZiBlkST5cZbWMuH9V5SLtCL6
         qNz/D18FsS57sC43F+WE5JqLxXMAaFi0BiO7hfb/o87lzXhSg7Ng7OUSmlBnItk0EjME
         sSRsuTDV/DxgJ/uu64QSwWi+2joSYHve5ylzK8J4WKWjFn69ugoZyW6v+Bfkv3N12cQj
         VOFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788928642; x=1789533442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K43nwTCuKB5R85lEVjD8dKcWwH128UtGJ64tWvb5aWU=;
        b=f2YRI39kffUJJeYkrAvr9ZNSn0YukvWryECgSyxlAbd1XfGCtqk0buz3YwNez+KgDl
         tds3RYTlR+d0jWGE/TSeOKyJAjb/k0R4iluCDbVHNNSg4Wui7z6RVSSIvdJFIdw14OT4
         5wvgPvlsMX01f+0zQvuiujEk+32hZMji5E10dKl3upzHW4sPKPxwdgG1ZaG7TJVmSJ4R
         zGB/Tlt3yLf2j+WLs0oe4jHi/4RHWEAvHvfoe0Jmhc2ToGt+F9z5FR4qnjsinK42px84
         Lw/OQcstN6E8BWzgO1riEtBz1hM++yEKn+b+mWfMF6GhMSWi+5VdkK4VtgahvL651rWC
         +oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788928642; x=1789533442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K43nwTCuKB5R85lEVjD8dKcWwH128UtGJ64tWvb5aWU=;
        b=DDlhSHjxo89Fp7UYnkkHWlYuIWgWhd1nDw3GEr2H7MQ1/B3D4MxWTmqi57kDtWkVcE
         JE+cw0qunRv6CcnlYoGyHJk4es8U68OYLVumUDAu2RvUrQ7wYBLdPKJ44TgSsF6raYA+
         0Vynos62WwyRNu+wD9kYV9hufONrxikP40AaUgu3/3N+JcLHjCjFSFZXIIF4ARJd67kW
         iHfYWGpGIGUNccLi+Vp6x21WkGHEKHmS5V0qY1DTBAQUAEfpEMrNo3pJ5GXvXBkJJm+0
         js3vzt7lOrSfAO6Z124AOoG5Emh1DXWn/zH6HbHeUVeWHmIfZJ3SkJwCyyUT3qg6XlaA
         CnVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGA7bUIxg/C1IchAIMPDoawzPHnLTFiXAPMiRtFAzQGwxmkkYnRh6BCwcm17xdTc/hOdA=@vger.kernel.org
X-Gm-Message-State: AFuF++mQwGgFdaEoJJI9QRAARPC9wPiv8Yi6pIHVuswIbgxUpLhLh1+W
	UPj8cZ9IKEz6xfNni0Z9psXkhRzAAYumtx6UwW9GG0I7NjBHrWPk82hl9xCRQkDYG69w1VkDU4m
	SdwdbqocFlRdOh13GRB9Rh1WR6rOOAeqctLKuW33yOw==
X-Gm-Gg: AYBFou0gGrB1sxpZuogzJknVf0KKNk7UdiMPMiaOqpL2p29jwUM4btaN79j/sk1VUMB
	si0ZPQE7XMb6PMRT7NG0NiTuVQqhjg6GwnY49gjH572X8iBIdCHG1p16UjOL+/r1KCFgVkzixMd
	QzpjfVxA6+MA70p55vWY+lJaf/IJP4FYfLGWYxCUItDB1UnfzYmDJAKbrL/s0zpyTfqzuTppnUZ
	kq+jIS/a6jTTPb2Mp77QbpJFpIHXpXywazhvlf4WrHTQqDgzat4GiBlxBFbxciqsdJ/pPqxZoq+
	maPeAvkTIWjUUZ6oIzmEdS1Dtue9vx+vcFDr53qerKm0AgNsBT8FwSo=
X-Received: by 2002:a05:690c:4b04:b0:873:5c7b:c0fe with SMTP id
 00721157ae682-8735c7bc5bemr95111457b3.54.1788928642020; Tue, 08 Sep 2026
 21:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a8e797a1b26e2f695aaac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn>
In-Reply-To: <1a8e797a1b26e2f695aaac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Wed, 9 Sep 2026 00:37:10 -0400
X-Gm-Features: AcwNN1WgdNZqq0OGcQo1SC2KhlxqeXSqZYjx_8cGpWBBKPeJQarIS9HxT_HCEUM
Message-ID: <CABFh=a7TJzKd2bU3L0FtSh0gQjqTCCrd57W-bDs+ZFCJZ96vdA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf, sockmap: Fix self-redirect copied_seq double-counting
To: Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:20=E2=80=AFAM Geliang Tang <geliang@kernel.org> wr=
ote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> When a BPF stream_verdict program redirects an skb back to the same
> socket (self-redirect with BPF_F_INGRESS), sk_psock_verdict_apply()
> calls tcp_eat_skb() which advances tcp_sk->copied_seq. However, the
> skb is then delivered to the socket's psock ingress queue and later
> read by tcp_bpf_recvmsg_parser(), which also advances copied_seq via
> the copied_from_self accounting path. This double-counting causes
> copied_seq to advance by 2x the actual data length, triggering:
>
>   TCP recvmsg seq # bug 2: copied BF2E806, seq BF2E7FD, \
>                            rcvnxt BF2E806, fl 0
>   WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked+0x72b/0x2640
>   Call Trace:
>    tcp_recvmsg+0x10a/0x500
>    sock_recvmsg+0x168/0x1d0
>    __sys_recvfrom+0x19a/0x2a0
>    __x64_sys_recvfrom+0xe4/0x1f0
>    do_syscall_64+0xf7/0x530
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   cleanup rbuf bug: copied BF2E806 seq BF2E806 rcvnxt BF2E806
>   WARNING: net/ipv4/tcp.c:1609 at tcp_cleanup_rbuf+0xf2/0x1c0
>   Call Trace:
>    tcp_recvmsg_locked+0x8d1/0x2640
>    tcp_recvmsg+0x10a/0x500
>    sock_recvmsg+0x168/0x1d0
>    __sys_recvfrom+0x19a/0x2a0
>    __x64_sys_recvfrom+0xe4/0x1f0
>    do_syscall_64+0xf7/0x530
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fix this by converting self-redirect verdict to __SK_PASS at the
> beginning of sk_psock_verdict_apply(). This bypasses the
> __SK_REDIRECT case entirely (which calls sk_psock_eat_skb), letting
> the __SK_PASS path queue the skb to the psock ingress queue. The
> data is then read via tcp_bpf_recvmsg_parser(), which advances
> copied_seq exactly once through copied_from_self. Cross-socket
> redirects continue through __SK_REDIRECT with sk_psock_eat_skb()
> unchanged.
>
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Bot is wrong, in the sync path the whole ingress_bytes adjustment is so tha=
t
a later recvmsg will advance copied_seq by the amount of bytes we have in
psock after reading it. In the async path we just account for the data
immediately
in copied_seq and do not try to delay the accounting.

> ---
> v3:
> - add "bpf" prefix.
>
> v2:
>  - fixup the verdict as Jakub and Jiayuan suggested.
>  - https://patchwork.kernel.org/project/netdevbpf/patch/1d2370f4c81f10834=
b8dd77524924575c629a464.1788591198.git.tanggeliang@kylinos.cn/
>
> v1:
>  - https://patchwork.kernel.org/project/netdevbpf/patch/b840c35fdfdf36e9f=
ddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn/
> ---
>  net/core/skmsg.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05..df385a5a961e 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1000,6 +1000,10 @@ static int sk_psock_verdict_apply(struct sk_psock =
*psock, struct sk_buff *skb,
>         int err =3D 0;
>         u32 len, off;
>
> +       if (verdict =3D=3D __SK_REDIRECT && skb_bpf_ingress(skb) &&
> +           skb_bpf_redirect_fetch(skb) =3D=3D psock->sk)
> +               verdict =3D __SK_PASS;
> +
>         switch (verdict) {
>         case __SK_PASS:
>                 err =3D -EIO;
> --
> 2.53.0
>
>
