Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AEE408023
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201109; cv=none; b=EFp0GE3l0+nHXF1OxiEZ/Er8pKLyntRBf8465916L7B0MbdLXYvdXVBZkY/Se4Rg9Y9e+q+n09H+aW9moKoqMKyOyBxL+W82KIQnIW50e9vQkPI3/0f7QrHZKj1mrguIMd7nOboxK8X/0duOFay1GIF+w3zmIljdiMYUxVKrBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201109; c=relaxed/simple;
	bh=P5eWCGTTQ8d2jkKVAwCYDe1DjbP0ceDUryIyut6T5JU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Fw0BmDWjIDN+qAKVjIavK2a3ab4jhiXhP5isQKkZMAt4OKoGnh4MMFBdjFw1J4iCvXpGUDI6ozpOcP/854p8SzJ6x3TZmvomOlvdKy5f3M31m7uVWRkRUjkW1g9sutSRF1DwcHcWV7qcrUkrgyXLluUsv3N9tbVlQ8c1CHFD6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=pMKYGWwq; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="pMKYGWwq"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so8367205e9.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790201105; x=1790805905; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GMxiUjlq5D/9eSR9q5jbzQ1uIEtNIDkPTSNMNH/2G7o=;
        b=pMKYGWwqtwl3mJhPALQnFLD+2JX7BF3E2XteHiULR3QnoEhA17lKQWSkRJ8QyXR6xS
         4CL08y63hQxLD//rhOfTBN4yVnxkXpA5m/q0G4D/DwRPJHDQKzsJx20jdUqYryj6D02/
         co0VHxr7XPcGkoqVivC4FA/UnZWO8PKR79A6x1vTxDBfNSXH8LzzXpBXCpzKCz1VeHQ/
         bmWoXdUTtQmgOiQrIE7JZ2Zf1XEFzlRFYJSMCSjHX+feAHRXAtoqcRytijSKCMfTDs0k
         3NXqnYyUTs7PJLsQvu6iZd3Qg7JK6oKaTuM2gKiQItpXV8yy7r3KBcxB49qZRn7pJMQS
         nrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201105; x=1790805905;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GMxiUjlq5D/9eSR9q5jbzQ1uIEtNIDkPTSNMNH/2G7o=;
        b=RdPKWasTz2OI+tSYhY+CewkSc27ySdEIDgMhNCCFJlLn/yTNzkQCstnTegO4xdtE/V
         xEc0hNUa8JxzCbpkWtgW77f8JYs2QTlC4Dvj5uuZAiQwKB6mrZXMVEpXW1Mv0zhVlatQ
         aJDspzcb1twpR09tUBNEjbSCoiohEFsLaoogLYfcYFo8eyR1dJgFauYlEHJ/EEIo0rlO
         ZHTqlLIId/1cnB1JP2KovVxn6IUNg4koFDLEk8PCC0b32Y2N0Qv6bkJN9Lir26oDeGoP
         yUWSc8u0/QR2l0b/kkHfeT4/9wXULSAcpFiU5d233ktu1H+NMIENddqEiPWqGPLvU/cc
         T3qw==
X-Forwarded-Encrypted: i=1; AKwUvBxfRocz1YVo5eAdeqwuJukBTuimuK62veUnpafoDQcQ70OiuFEzTJ8sMAWn4V/pdrAOK1o=@vger.kernel.org
X-Gm-Message-State: AFuF++mpmuJ6hj9H/nxYZng7ex2fvQKptP1A9rrGJF0CIO0vNEDYTeeD
	i5TYK2qJQQwxsiwSpUPD2vGAHibeHxI4Ck6nDmSpm1Tcul9cVQkovG/49iFV4g6p91U=
X-Gm-Gg: AYBFou3iqeeB3kcCEFtdoQUYGHrFzU/v+gedow8oUPEspfLl6FPa+qXQVYP01MyQHL3
	mkaXTl1u9+/gTK+qgxRPenHwJRHH47KRC21L6tAMKbjMNcZIi9dKj2XHAZLc/mb+AKez9r6x3Od
	Ut5sEhuDaFrMd/j9sZ7fiW0glklN/J0uUfrKtgr97i8gYIXctXf6mr7bsnD2P8ofWO57rEryxvL
	M3WG7WTy84+ecsgFQZvcOXbbALb9XOqNthmpB1TGQ2ZzesrcAOxfc8ilInDqqSmLbtumSUVQQrP
	672enkkHhjKoJ76R7fR3YzYvktmfYfgXOUFzEO+PokzrBqDjZMPL8WLEqGfk2Sr08nblMX1V0Yg
	kDymA/uZh9vkVYFdTuHxmkHHLU9i0KRIkinx5ROSdFMA7W3XkUS5Cg9bdXGTCR7oR/PkmswBrTG
	HygalBM6FkRgVZFjWJJj6jItcPO8Qe/KSKlbdfBp/Zzf6qW8rPvZVxakU=
X-Received: by 2002:a05:600c:4f12:b0:49f:ce78:356b with SMTP id 5b1f17b1804b1-49fe6700d0cmr8409595e9.28.1790201105209;
        Wed, 23 Sep 2026 15:05:05 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:c3af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cc90ccsm27381195e9.10.2026.09.23.15.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:04:58 +0000
Message-Id: <DLN1BR3DH9EF.1SIZB3GN9XEVQ@etsalapatis.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: tcp: Convert deny-list for
 bpf_{get,set}sockopt() to allow-list.
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-2-kuniyu@google.com>
In-Reply-To: <20260923213719.224838-2-kuniyu@google.com>

On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
> Currently, four bpf_tcp_ops callbacks are not allowed to call
> bpf_setsockopt() and bpf_getsockopt().
>
> However, the deny-list is fragile, and when a new callback is
> added, we might re-open a can of worms. [1][2]
>
> Let's convert it to allow-list.
>
> Note that it can be written as offsetof(,X) <=3D moff <=3D offsetof(,Y)
> but clang can optimise to similar code anyway.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Even if in the future we need to split the allowlist further it's better
to be verbose than have it break out from under us.

>
> Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.=
dev/ #[0]
> Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux=
.dev/ #[1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/bpf_tcp_ops.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 681fed642999..1ada3b781bf1 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -210,6 +210,24 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_p=
roto =3D {
>  	.ret_type	=3D RET_INTEGER,
>  };
> =20
> +static bool is_sockopt_supported(u32 moff)
> +{
> +	switch (moff) {
> +	case offsetof(struct bpf_tcp_ops, active_established):
> +	case offsetof(struct bpf_tcp_ops, passive_established):
> +	case offsetof(struct bpf_tcp_ops, rto):
> +	case offsetof(struct bpf_tcp_ops, rtt):
> +	case offsetof(struct bpf_tcp_ops, set_state):
> +	case offsetof(struct bpf_tcp_ops, retrans):
> +	case offsetof(struct bpf_tcp_ops, connect):
> +	case offsetof(struct bpf_tcp_ops, listen):
> +	case offsetof(struct bpf_tcp_ops, parse_hdr):
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static const struct bpf_func_proto *
>  get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> @@ -221,22 +239,13 @@ get_func_proto(enum bpf_func_id func_id, const stru=
ct bpf_prog *prog)
>  	case BPF_FUNC_sk_storage_delete:
>  		return &bpf_sk_storage_delete_proto;
>  	case BPF_FUNC_setsockopt:
> -		/* The sk may be an unlocked listener (synack path) or NULL
> -		 * fullsock; disable for members that can run unlocked.
> -		 */
> -		if (moff =3D=3D offsetof(struct bpf_tcp_ops, rwnd_init) ||
> -		    moff =3D=3D offsetof(struct bpf_tcp_ops, timeout_init) ||
> -		    moff =3D=3D offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
> -		    moff =3D=3D offsetof(struct bpf_tcp_ops, write_hdr_opt))
> -			return NULL;
> -		return &bpf_sk_setsockopt_proto;
> +		if (is_sockopt_supported(moff))
> +			return &bpf_sk_setsockopt_proto;
> +		return NULL;
>  	case BPF_FUNC_getsockopt:
> -		if (moff =3D=3D offsetof(struct bpf_tcp_ops, rwnd_init) ||
> -		    moff =3D=3D offsetof(struct bpf_tcp_ops, timeout_init) ||
> -		    moff =3D=3D offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
> -		    moff =3D=3D offsetof(struct bpf_tcp_ops, write_hdr_opt))
> -			return NULL;
> -		return &bpf_sk_getsockopt_proto;
> +		if (is_sockopt_supported(moff))
> +			return &bpf_sk_getsockopt_proto;
> +		return NULL;
>  	case BPF_FUNC_get_retval:
>  		if (moff =3D=3D offsetof(struct bpf_tcp_ops, timeout_init) ||
>  		    moff =3D=3D offsetof(struct bpf_tcp_ops, rwnd_init))

