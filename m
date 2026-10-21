Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605397;
	b=LVPcWQxPgVL8033NIwGsg1zJkiixyL9XsGwdcRblLzJ0Lmu6GDGztsneMUr1hEp4ixPl
	 RKLxEpeo12GDkkFTchJ69cu5HYkR7H1BVqkW8YWA+sqqZxniFkVuxYp3DvIDD68mWNybk
	 xl/poD5Q4WUdBmgm15E4QvK7mDGFowYMiLCMLFWE4ktF5qeqsQ/+JhJUwy6Rr5MWIvHex
	 +0W8SKX0lII1cGQUsQ8uaSDJDZ2PVKR0Z11mm81OLsOzwn0wfeDSTzcsfYKYootCgUFKx
	 KYYRcwaz+SOBTX7HMjpJbBjOUmcza73dkBmFoboRfbiN3ZrGYdV9I+HPeIx7utx1/4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VbBlG9dBV9dQwd61zkZiG/rhXlHvnLvyJTnTn4Xv1Ho=;
	b=pK/C/N6Ua7ZGS81ZV0rOwCZwzKxDvmMuOor8oC7m1j+//zLKky1xKStydzzAv+0YhUdt
	 9AP1bVfVOKk8W6daAzTdhv+1XtmH+0+8WC84ioP8v+wc5wO4iqa16nBsFHKr/cdS8VpYf
	 m4S7fzHjJEKxLIGrtEhqFHR/Z/Cgn33IYJvhsTK7WYCfnHP+ha6XmBQoq6ofeJXcnuibV
	 PcWeksjzs5JRuYq70SvKna08yxkuFUockysCR7YfjTRS3oFW63giNO0gLO+oRPGlb3SEx
	 kELUNISfvlypEnGVQ+BwluZZh4+d2vsiElB77bOrBcHCRdEiSjxgyk3BxbUOj47y9UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="XjnGAW/l";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBCE606A321
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBCE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XjnGAW/l
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so905737a91.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605396; cv=none;
        d=google.com; s=arc-20260327;
        b=jlejmB1fPWeSMRAQRA2dxQCqm0pRHB+K/VIpGh/O49QwuQ+UUlXbd/SMzj2Ud2u1Bd
         TMcyjgRrVveaexszyet7hhuTiRnGq9WwyQBQfQe8vjthPiwdzhi/W6xQ7pJ3oSotqrO7
         FIJS1nIKMZkZVCFnONmyXCKa1R1ukYz15wGvaiuEn9UjcTF5sUiPvSeP8jaHS63oqcED
         8yTGphm4agxIP0RK/S1upLXXL+Fm2KcwzvOUbYXqCaoUAeJNOcpkNMzxjzQ/r08/AwfL
         DO4ehuwWd2XxVX1+e2elMdZ07tOfrasxV9k/PVJAT1nwapu0oYpqI3TTvyMeRFFtMVdD
         2bhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbBlG9dBV9dQwd61zkZiG/rhXlHvnLvyJTnTn4Xv1Ho=;
        fh=U+H70siX3Yw7f5IF1ljcjHRKDtNcFsRfDbBGgIDNOpA=;
        b=Os5MKhDrxKQ7JaqPFPW5IqSoykgcUbgkx2sctuZR8OZyuCX6rLxO92kjTHH9+ueteC
         hHHTX/9LL6LaiPJNSbGiRBLrUHulH/JJdyI8BhuHSYbnmfu4/0tLSrCGGjKnk8aZnRed
         ltGaIYeVpBVQBtq+UwfmYha3YQAsbg8qxKou+YugJkc9newttcT0G+MWKTw+rj2NlfPY
         LHOu9yjAQER6oGavMj5qPxN3BGoshW0JFrNRiGaRL+90XP8Tjj6CpE1E8X7cumrDkg8F
         40o7/rkaVC5n4JNFt435yQ3jSO1KLvnyjZDaGwOcH0h3FIVhb03tdj4RI4wIV0scCDRr
         Qoeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605396; x=1793210196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VbBlG9dBV9dQwd61zkZiG/rhXlHvnLvyJTnTn4Xv1Ho=;
        b=XjnGAW/lkqm11P0pMYijUpYq1oonr3mzQR4L5QXOUAKweJaJXolhjXgl0KiSNwUi3u
         RigAv+W5Q8JG8RSqBUZlwXm4QcaPSV25TJ0AY6NLXHBARGVhtc8DXc37Ve1Smjo+7BM/
         01pl/MPiu96OcvAljgHXE118771IPEAInsahOEQsONtETRODdd6gWJ5te20jZIGCnXd+
         1Fx4HrqZ8EWJEFjeW5Vk6vd/JvnLa8QmzUjHxXgNVaSIz1j1RlLQYsoIRAzzdUb2mBnS
         k0CkLW/aKowrDvCZpFU7mOYD5SRfQDVvohVauRNK7tN8aPLO7l+y2gBAS2NapsnO2Uz+
         3PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605396; x=1793210196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbBlG9dBV9dQwd61zkZiG/rhXlHvnLvyJTnTn4Xv1Ho=;
        b=CKWFGY0aywxL02FvugXf24G/rJNe0gx7APS6hEMYmtmgvC7KBwMd89aFS0br4hPcoF
         aOEl2D/t1SbMQgVgAR44IANBPCGgtmMGemcvF9vZWunJQ+TFDopI82Y8e/uw61yEGcwm
         fUTKvm0UL7YdJRoo5xd72KLtAi0F1IiZmxNnyM7bvrBi35IGU1o8pw4qnNIC/RVYrHl0
         DM244ic7KhfPCwHDMRWWrCKQ4G1W2qVL3zhX8uhVZRe3rTkHVnpAI6CSripqBDMhb09J
         lDqTjg3dimSEUHei9Br/73NJfB9S6BMSg+A3vA52WnE/fkV3Unqhqj/iQFVa/6yRJoUe
         nqvQ==
X-Gm-Message-State: AFq9FYKpwJ5zXAIF1U45Y4LJqvoCGAFFfphMNFGV96Cejh2siHmBTHC5
	ysaPYwg0/vYNCHUiQJv6KZRQWR3pQiYXktXxG8LgX7+fu9oWYE+qRAtExQsVqFqEaQyfHPiF94n
	b47qQsFswp4BISAlL7JhxVcieGtH2ijc=
X-Gm-Gg: AYBFou2uFwmy5mkrQ6rU+Ntm93tul8sB7U40f7ZHUssrDqHxeUbNg19f21pej3vrIL5
	Hy0AYosMAom3Q3eDxxbASUPA/XiSFOcnKcXtc+nPEAv+3mxJ525c+2rqy8mVM1ikZ8tWM+sxQJA
	Rx4Lx2V/aeKbboNky40u2Qp1ExC+uQ0VvKcLjyIUVA5Ideyy3OEVKdLL2c/Ne9G+2DZe6kiUPeo
	0n1bOxdxRNwy3TpmAQ3POIZfMRQFBv5df1FSyHC8UOWJCM5LBxy/4l3mjviaajU3hHjQire+o6m
	MdGRPqDOf8FttxYVTWm1EFJlD6Q8DcYXIXgdtcj0HkgCGdP/IOtVhguJYg89MDi81ecyFC6hXlm
	4MH9HMn3qZn4p7rrr7SAlHk3DwWEnp4deG1F35wFl+ka1OUN9C9eBhofUatY06zyRToKe79SIKB
	gfqwcXq/UrGDc2drS7603ofoX+V77W2cgbvQXLNHc=
X-Received: by 2002:a17:90b:4a48:b0:3ac:a139:1b14 with SMTP id
 98e67ed59e1d1-3ad870a090emr2485173a91.57.1792605396207; Wed, 21 Oct 2026
 10:56:36 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020155848.75711-1-mahe.tardy@gmail.com> <20261020155848.75711-2-mahe.tardy@gmail.com>
In-Reply-To: <20261020155848.75711-2-mahe.tardy@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Oct 2026 10:56:23 -0700
X-Gm-Features: AclHuK_Gjd_0JETWrWSuRV1IbMqYcY07rIIqTjIYhd9Ry3rga3lnZ6YW-KgPkzM
Message-ID: <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, yonghong.song@linux.dev, 
	jolsa@kernel.org, kuniyu@google.com, memxor@gmail.com, emil@etsalapatis.com, 
	almagui@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 8:59=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> The motivation is to plumb more of the socket API into ksock, thus
> supporting sendto() in addition to send() which makes a lot of sense in
> the context of UDP sockets which are the only type currently supported.
> This is useful when ksock is used to reply to specific addresses or send
> to multiple addresses.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 27 deletions(-)
>
> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> index 48a2e2327ace..37168f43c16c 100644
> --- a/net/core/bpf_ksock.c
> +++ b/net/core/bpf_ksock.c
> @@ -37,6 +37,49 @@ static void ksock_release_work_fn(struct work_struct *=
work)
>         kfree(ks);
>  }
>
> +static int bpf_ksock_addr_to_sockaddr(const union bpf_ksock_addr *addr,
> +                                     u32 addr_sz, struct sockaddr_storag=
e *sa)
> +{
> +       if (!addr || addr_sz !=3D sizeof(*addr))
> +               return -EINVAL;
> +
> +       /* Kfunc memory arguments may be unaligned. */
> +       memcpy(sa, addr, sizeof(*addr));
> +
> +       switch (sa->ss_family) {
> +       case AF_INET:
> +               return sizeof(struct sockaddr_in);
> +       case AF_INET6:
> +               return sizeof(struct sockaddr_in6);
> +       default:
> +               return -EAFNOSUPPORT;
> +       }
> +}
> +
> +static int ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data=
_sz,
> +                       const union bpf_ksock_addr *addr, u32 addr_sz)
> +{
> +       struct sockaddr_storage sa;
> +       struct msghdr msg =3D {
> +               .msg_flags =3D MSG_DONTWAIT,
> +       };
> +       struct kvec iov =3D {
> +               .iov_base =3D (void *)data,
> +               .iov_len =3D data_sz,
> +       };
> +       int addrlen;
> +
> +       if (addr) {
> +               addrlen =3D bpf_ksock_addr_to_sockaddr(addr, addr_sz, &sa=
);
> +               if (addrlen < 0)
> +                       return addrlen;
> +               msg.msg_name =3D &sa;
> +               msg.msg_namelen =3D addrlen;
> +       }
> +
> +       return kernel_sendmsg(ks->sock, &msg, &iov, 1, data_sz);
> +}
> +
>  __bpf_kfunc_start_defs();
>
>  /**
> @@ -155,22 +198,9 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *=
ks,
>         struct sockaddr_storage sa;
>         int addrlen;
>
> -       if (!addr || addr__sz !=3D sizeof(*addr))
> -               return -EINVAL;
> -
> -       /* Kfunc memory arguments may be unaligned. */
> -       memcpy(&sa, addr, sizeof(*addr));
> -
> -       switch (sa.ss_family) {
> -       case AF_INET:
> -               addrlen =3D sizeof(struct sockaddr_in);
> -               break;
> -       case AF_INET6:
> -               addrlen =3D sizeof(struct sockaddr_in6);
> -               break;
> -       default:
> -               return -EAFNOSUPPORT;
> -       }
> +       addrlen =3D bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
> +       if (addrlen < 0)
> +               return addrlen;
>
>         return connect_socket(ks->sock, &sa, addrlen, 0);
>  }
> @@ -225,18 +255,29 @@ CFI_NOSEAL(bpf_ksock_release_dtor);
>  __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
>                                u32 data__sz)
>  {
> -       struct msghdr msg =3D {
> -               .msg_flags =3D MSG_DONTWAIT,
> -       };
> -       struct kvec iov =3D {
> -               .iov_base =3D (void *)data,
> -               .iov_len =3D data__sz,
> -       };
> -       int ret;
> -
> -       ret =3D kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
> +       return ksock_sendto(ks, data, data__sz, NULL, 0);
> +}
>
> -       return ret;
> +/**
> + * bpf_ksock_sendto() - Send data through a BPF kernel socket to a remot=
e address.
> + * @ks:                The BPF kernel socket context. Must be an acquire=
d reference.
> + * @data:      Pointer to the data to send.
> + * @data__sz:  Size of the data to send.
> + * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NULL t=
o use
> + *                the connected destination.
> + * @addr__sz:  Size of the address union, ignored when the address is NU=
LL.
> + *
> + * Sends data to the specified address, or to the connected destination =
when
> + * the address is NULL, best-effort and nonblocking. This may sleep
> + * (kernel_sendmsg), so it can only be called from sleepable BPF program=
s.
> + *
> + * Return: Number of bytes sent on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data,=
 u32 data__sz,

This would limit API to fixed-sized data only. Have you considered
passing dynptr as a source of data, so you can send a wider variety of
data? I don't have a strong opinion whether we should add a separate
API or convert this one into dynptr, but I do think that having
ability to work with variable-sized data is super useful and should be
added early on.

> +                                const union bpf_ksock_addr *addr__nullab=
le,
> +                                u32 addr__sz)
> +{
> +       return ksock_sendto(ks, data, data__sz, addr__nullable, addr__sz)=
;
>  }
>
>  __bpf_kfunc_end_defs();
> @@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
>  BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
>  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
>
>  #ifdef CONFIG_BPF_LSM
> --
> 2.43.0
>
