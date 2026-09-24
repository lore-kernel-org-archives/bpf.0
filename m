Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07E20C029
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209865; cv=none; b=MZyOiy+6IB5ueXvOSi8Y1gNzY0McRpXyG7dYePqQZ34pmDIuXiu/gHWf/5BFpX44NOP22YA9M46VpPlNwve2ijXXo3aW+HXmvdZpJsCJcW30NkO5Pfz89o74m59dKKe/rj6e1EzkunPRxnBfxRGH8hX/pqQw+BwKEBR8VGyDCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209865; c=relaxed/simple;
	bh=ywojNsAkoWXzWiMvE3FWqBUGOqW4wRkOqPfIs9yqsd8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ADYKxgIWmaPC7Fmsf8UrK2HKnW8PbYpAcSzLvXMZhCK0GgkieFgospIjM+2awJKwvMYBswRZ5h7mPUSFhBXlsKHcbNrRlvI3Jm4knxbn/zbJaUWhZx1FqZmkIIddErvsqbWlr8Gu8QOyxeDumvldnRtT1ySspaeWD/KFUSwrmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=iIsBT9RQ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="iIsBT9RQ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso4746815e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 17:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790209861; x=1790814661; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GtgUDodL7we/Be5fjT5jS7XSFaC6E7MII3rvDV+0kbg=;
        b=iIsBT9RQdiKEzTEkN04ZvBADH71RJV1Y4601bbyNhUA4M1Oh1ycUa3jLhqXIHrItPY
         dFu7C7drsPXb7YtURgAjyAfMmXro/V+iuouTXqbJKonbhibzRmCSALpZj1oUJKJbZPSB
         FxHj5Y704DG3dmsPKCATkxHMz6uOeuLH3MH0ohTREMciZXa8x/nPVaKJ0xGX8cyUoMy0
         ZPuXvh3qjmHigt2gBNfuUzOoQduLIg11I5J+jOjjZxXaW/xiY4pilVSBoXZ4KcE6bP52
         WOCxYMHev8mISFISOLdZ3C14ZLKHAjt4EeHZ+bqeEIB4Rxe2lrR3GUvkhDe/6XcbX7rB
         IJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209861; x=1790814661;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtgUDodL7we/Be5fjT5jS7XSFaC6E7MII3rvDV+0kbg=;
        b=tZYO8sNaJ55ZDRXFVxy71UdeJdnuNSCmtpjjCMgqf6j8hrJf5tCXUIJydjH0MYGVD0
         KTpnpuIe7jZFyc066sQlH3qaBPLHAVDJTfa/gecwl67OhI9gKksyb1NWywFfuOHRksum
         kmiKOM+RFDpa29Yrb1INEffR1bnCqouQcQqvyY3juXursy5MZiOAsWKF+ttmIaTixKTi
         1j1n4ggH85Pu1qHaYWhojl6OCPHGb/sNXmPa/hExjwMNwBC2Gdzw3GyiruraTx9ViA+c
         4GnBZiYTWqt7HYEqvYPvxW6vsRvQyCh9gwr09LJmonzRTLu4wmvssx7dgwuXK4pYukEQ
         m22g==
X-Forwarded-Encrypted: i=1; AKwUvByxwLeoFeJAFyOZikjExFqf0IksvL9ltFsj6xlG2zgFw7duTWZHHkmzTmwIQ/MHYW1Cjr0=@vger.kernel.org
X-Gm-Message-State: AFuF++lXJXVu4RarMDHrieLMlrdN4uBGStXenPhEvkLVlwjMxYIGgbyr
	wGgKh4HwTrERoszh5LB078luXcL8ur+6EFX5k4re3SFV9lBs0HgmwpOgpc28S1vcuoU=
X-Gm-Gg: AYBFou2sqEX4nIpfhDxkeVNkEWP8uHhEtiJXS/BQXuh7qUN9vTp4l7PMEL6R7lf1juH
	LP5N/K9ugmF3k+8SbpeAZUy5TREJUhd45p/evQL4YrIiDk9wcLO+nQPIAMQy5LK/DDPMVD+lK3b
	z9dLc03+vYOLwXz4vDqf9ZjYHenj+guKC2j3+lNrF8kwuiT0nM7MBcFEVkt1oULjI1A0hfEOhTZ
	h0XMW0PdlGOm9E+P3PTsbIJoSXFYlPfQ8t7do1sfRRCmjwyyaRip3xBOuYQk7IgyiJyphn1fFGL
	ixHZstlKeBFq3pvm7/mMK+WpDZcDSrwAJB2C16od1reQPS0Ia+fggE0vlpmBEIFdM27UqjoEIKW
	ispipSxBHeR3OSlGCDQV2twU2AKBoCw/4doC4t/39qr9P1ZvhKR2Y7/uSSTq+KzGDMCM1fHvjuk
	dTLncHEFbX6PfpBHbH4CW37lMcmi2QWv5+4f63Im5qIqFotlxQeHbCSFY=
X-Received: by 2002:a05:600c:3513:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fe66ca6f5mr13250065e9.0.1790209860799;
        Wed, 23 Sep 2026 17:31:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:ef15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ded2b7sm22459445e9.10.2026.09.23.17.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 17:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 00:30:53 +0000
Message-Id: <DLN4FH1Z5CDQ.3S3F6PBHHVRGO@etsalapatis.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: tcp: Add kfunc to adjust
 sk->sk_rcvlowat.
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-8-kuniyu@google.com>
In-Reply-To: <20260923213719.224838-8-kuniyu@google.com>

On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
> bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
> adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.
>
> Let's add a new kfunc to set sk->sk_rcvlowat.
>
> Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.
>
> For enqueue_rcvq(), wakeup is set to false because:
>
>   * tcp_data_ready() is always called after the hooks in
>     tcp_queue_rcv() and tcp_ofo_queue().
>
>   * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
>     not yet accept()ed, and when called for TFO SYN+ACK, the socket
>     is woken up by sk->sk_state_change() anyway.
>
> For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
> is not called in that path.
>
> An alternative would be to support bpf_setsockopt() for these
> hooks.
>
> However, that approach involves excessive conditionals and an
> unnecessary memcpy(), costs we do not want to pay for every skb
> in the TCP fast path.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  net/ipv4/bpf_tcp_ops.c | 56 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index b0cade34cce6..e93c8d13684e 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -368,8 +368,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
> +					 const struct bpf_prog_aux *aux)
> +{
> +	u32 moff =3D aux->attach_st_ops_member_off;
> +	bool wakeup =3D false;
> +
> +	if (moff =3D=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> +		wakeup =3D true;
> +
> +	if (rcvlowat < 0)
> +		rcvlowat =3D INT_MAX;
> +
> +	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_tcp_ops_rcvlowat_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_tcp_ops_set_rcvlowat, KF_IMPLICIT_ARGS)
> +BTF_KFUNCS_END(bpf_tcp_ops_rcvlowat_kfunc_set)
> +
> +static int bpf_tcp_ops_rcvlowat_kfunc_filter(const struct bpf_prog *prog=
,
> +					     u32 kfunc_id)
> +{
> +	u32 moff;
> +
> +	if (!btf_id_set8_contains(&bpf_tcp_ops_rcvlowat_kfunc_set, kfunc_id))
> +		return 0;
> +
> +	if (prog->aux->st_ops !=3D &bpf_tcp_ops)
> +		return -EACCES;
> +
> +	moff =3D prog->aux->attach_st_ops_member_off;
> +	if (moff !=3D offsetof(struct bpf_tcp_ops, enqueue_rcvq) &&
> +	    moff !=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_tcp_ops_rcvlowat_kfunc_id_set =
=3D {
> +	.owner =3D THIS_MODULE,
> +	.set =3D &bpf_tcp_ops_rcvlowat_kfunc_set,
> +	.filter =3D bpf_tcp_ops_rcvlowat_kfunc_filter,
> +};
> +
>  static int __init __bpf_tcp_ops_init(void)
>  {
> -	return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
> +	int ret;
> +
> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					&bpf_tcp_ops_rcvlowat_kfunc_id_set);
> +	ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
> +
> +	return ret;
>  }
>  late_initcall(__bpf_tcp_ops_init);

