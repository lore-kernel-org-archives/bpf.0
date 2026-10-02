Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FA3112BD
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931176; cv=none; b=Ly1clYfTVmU1UUzWzrO6vvMneT4OSu0aPNR2VkJK+E+Aa1ZFkRQ1amtAeybbznuJt5z5cgEsPbNXqRMMQvv5kGu68dbDJK4LDvQ5T3rMWhAw9UD5iojsxCdZnxemTaSc6c3hQdkTKknAyGbOQ1xEoACWktxPqDIyLT+FaGqjRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931176; c=relaxed/simple;
	bh=1HRuClBs+9wcnXTCDpjs1Go7ysobHRZWvHIHP9aB3II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wd7l7EHjUSbZc+8Hf1oaytuci06FYVjoam7cyk3S3uxrRAIHXkA498TzjZMHgZDBzj3lpO5Hst56cSucuygFlGvO/fvLU3YTC02bZEpl/FWhKx9WmS8xBsmSwoGx4hYKkFLSFeoc7hhnW/AvnLaFmIOLN1vx2ES6nyYUMt2EmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWs1Nk6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWs1Nk6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D657C1F0089E
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790931174;
	bh=II2i7KXaSjS5yiJDHC8RNg96Czr9lF05UVBVD37FVSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kWs1Nk6QkbpFIqApAlg9PdNinUPVcMF5EX68nOHiOvEJoEzywc17J3RRIga90CL/d
	 Z042lxfzSkzbDC33veTk4QMuDJChC/RsgIYubTF3Dbu68bj5vr0ucf+YGm1oz4jR9v
	 p3HyKZisGUSwpSxrpDRLgij1B4YS1fx/XjVlcFbZbpdn2/VTBx+BFTVsXW23miVXWC
	 rxQ24M2uj+akTw+3dDhVJs28KRBAE8D6DOFDvCSNzsebnPOKa7I09OGqOx0iYE+w9U
	 NCWg2f7OivApouHlIoPZXxBu2f3NliUJh5wBhj6sgCK6Ipa8mKhuuuWboN0kthDZyo
	 k8OjSa8DmhtUQ==
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-80a71781323so4320659a34.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 01:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw5/x9c7XPSojEAayg1YXyrGcY1nFYaDc8cxvIwFScJLceCEEpJ7eMXyT2xoMYXGu+cxSc=@vger.kernel.org
X-Gm-Message-State: AFuF++ndAV/BPnKjyKEphrpOcOeWCQtzGX7f+0//HZzpGkgQkteKZZVm
	LHExE0272FZkN0CPoqocgfxSKm51qdXJbhmVS4Oez5eWdapCAnTMYYc0UElZR6RAGZQ/nJ4NC3l
	fnWjdEqg/x05K+pz8H9con9aglnCDSUQ=
X-Received: by 2002:a05:6820:221c:b0:6de:ba4f:aef7 with SMTP id
 006d021491bc7-6df35746daamr1487310eaf.74.1790931174179; Fri, 02 Oct 2026
 01:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me> <20261002-tls-fix-sk-kcsan-err-v1-1-baa0ba056323@proton.me>
In-Reply-To: <20261002-tls-fix-sk-kcsan-err-v1-1-baa0ba056323@proton.me>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 10:52:42 +0200
X-Gmail-Original-Message-ID: <CAL4WiirRTTzrAu6vqA6KWU5z3mK6_GTPzJY_tsR0M-nbPeiMxg@mail.gmail.com>
X-Gm-Features: AclHuK9Jv6gTNJU_9I5u2gA0R-3jGf7ZShcueDTlOKFlchkVBn6m45fEhIemxxs
Message-ID: <CAL4WiirRTTzrAu6vqA6KWU5z3mK6_GTPzJY_tsR0M-nbPeiMxg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tls: annotate lockless access to sk->sk_err
To: quanyeyang@proton.me
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 9:29=E2=80=AFAM Quanye Yang via B4 Relay
<devnull+quanyeyang.proton.me@kernel.org> wrote:
>
> From: Quanye Yang <quanyeyang@proton.me>
>
> kTLS sits on the same struct sock as TCP. do_recvmmsg() and
> getsockopt(SO_ERROR) still call sock_error() without the socket lock
> and clear sk_err with xchg().
>
> tls_rx_rec_wait() already peeks when data has been copied and consumes
> otherwise, but the outer if (sk_err) is an unmarked load. On the
> no-data path that check-then-sock_error() window can return 0 after
> another thread consumes the error. Call sock_error() once and only
> return when it is non-zero; keep READ_ONCE() on the peek path.
>
> tls_sw_sendmsg_locked(), tls_push_data() and bpf_exec_tx_verdict()
> read sk_err twice. Fold those unmarked loads into one READ_ONCE()
> and use that value as the returned errno. The field is still not
> consumed there.
>
> Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365=
@redhat.com/
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> ---
>  net/tls/tls_device.c |  5 +++--
>  net/tls/tls_sw.c     | 45 ++++++++++++++++++++++++++++++---------------
>  2 files changed, 33 insertions(+), 17 deletions(-)
>
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f11d0528fc43..03ce83a9d4e9 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -444,8 +444,9 @@ static int tls_push_data(struct sock *sk,
>         if ((flags & (MSG_MORE | MSG_EOR)) =3D=3D (MSG_MORE | MSG_EOR))
>                 return -EINVAL;
>
> -       if (unlikely(sk->sk_err))
> -               return -sk->sk_err;
> +       rc =3D -READ_ONCE(sk->sk_err);
> +       if (unlikely(rc))
> +               return rc;
>
>         flags |=3D MSG_SENDPAGE_DECRYPTED;
>         tls_push_record_flags =3D flags | MSG_MORE;
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index d1ad31986cf2..12e4458b44bb 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

It seems you missed tls_encrypt_done() ?

Thanks!
