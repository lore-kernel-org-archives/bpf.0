Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708853D25CC
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791414399; cv=pass; b=rAq4xiDVVQoF93YxNmHFqPnY7e1XgNB0RiNHqpvy3YWZSFA9AXpCxyl1RhyIFtbSAEkCL+qQKAC7vCiVfktKXUcbQ8ViO4VN5x8UEMAq7s9TGniX3vRRIeMAVJcTLfdr5miM68O5F4M8QtPD6LBLcaaffq/Q1Ne29nm3XFkRyQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791414399; c=relaxed/simple;
	bh=EnvvshmgbGSgmvOAQQYj95OI1ypuk+0YI22QHqVZUZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSI/knNvnqoqQnmbwtsAqUbNe3Q09Hny8HTyTnAQ3RNBiC1/j4HDyo5Q1i4KP5S2kbYFOsYAIjKyv6NJDFuInp7ZuEeyjGJbnqXYoMBkmKq14Dd2rdhTwu/GX25m2ry1UYg75piSyYVQsFETCUasRNhDcU07dHVLecZzk859TvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUyyrPcG; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUyyrPcG"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4b21f71613fso1384082b6e.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 16:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791414397; cv=none;
        d=google.com; s=arc-20260327;
        b=loE3mPlHPbDfv0INuIK0XP2M+jIuhAG+9OCrLEQ4yxiR93cv1z9grUa5Gqgtb4sXtX
         KDD/WTOdeB4VLsTBpykFV2mx86RKenuwZm7OpLRiQOf2oQ0uOCbXekG7q/hhkMnF9mky
         py5sb7AVYgrD6ragGncpyfSbWBu2UESLCdKLCSQpgHAPBr0mWrAIlwPPHn4gWk2/hh/C
         fRxc++0Iemp0WZvSoA/8DdmyxF4GcLpkyi8+j0/W3fL574r0Wi0JA3r+2uu3Hg1o7w6q
         GXv6o4y9W0vlzpGT6vkDY01rASuPzOZcpDZFE3prCePnV7Dx5hmrPNaRDsXzTgfMHmWD
         SYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bFgc6Xa0HunmUOCklAqPECBS03DSMGCin3KVDvL2wI0=;
        fh=SFsmyw1RJz2pTPCo+egH4kvHp+SffTUZRLhkQhu5OKM=;
        b=k/GTQgdWO6VCwSzstA9Eb1cWrLx5mNI+v5y9C5eTkmt59uaMzlyEfAmd5xt+v5ZC/q
         D2yttwQVKPf13+Vh5t3skLV0tYiciGBPWXqcgnWTh6Vv0jAVQsTa7OJsLD2gIxuH4+3B
         RPGn0INGnReuuhqBQY+a3672uB5Odbrlq0DTGkKD1euv51vow5C5olMpHs+O/NqUmrZp
         p7s5i8AudbcR8n6738f+aMkLIi82FXd1+qB0lW+ieUHkub0MlWmMCHda5feGlxSXV9za
         /B9qO/+/KWmiNN3wkjJlyaTbLNeeqcsFb7IX5COY43HFKhTtQRfO5tvnCRS/4E2hF2vV
         i6sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791414397; x=1792019197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bFgc6Xa0HunmUOCklAqPECBS03DSMGCin3KVDvL2wI0=;
        b=PUyyrPcGsmGngBy6k64QNb63RefIMBfG6zIc4s3O7MlIlsewNXO3rCLbKjWi3NZqyt
         oM9no60NswYdJEaNLzI3II/geq8yH4RKuO0SocnfLhYiz5wsL4f39YVTM5xrofpzM6L9
         2J9zxfAzAFX2qegN3qWYvZBlWe61OajX7CUzKT7FgL7zCZs91KKJuQhDVnKDljzaHc5N
         3nR+MN57QiPLw1TORAc2wC267HqEn9vcMOoMbMisIKMOLh4idcxJnSmqOM9jx/CkaeXs
         X7S4taCeXFkasMr8MhuNPi8f+NGBEvmXAmRq1/HkRua6DOc2EZUZOUMY4eRLDV2yc5gn
         Yerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791414397; x=1792019197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFgc6Xa0HunmUOCklAqPECBS03DSMGCin3KVDvL2wI0=;
        b=uim08dPsxLW56gqX3RIfoAOh4QaFiwsHBhw0QAuIt+Gea2+GtxjBzjJywpi+hTpeHl
         OrsCso9piScwtNCRhelmgT1CjEK2sYaz06hCbTHPRRmr2/tDypwFAIdpp+9SR6iJhi8D
         DrcRoKMVHDDFA7FbhihD5iJka4oy94lwBGJ/GTPBY5WN9OaD+nyrCTaDrJCL+nDt00zJ
         NQtJSiVFFNd6NJ1NUBrpXQGw8lS1mdCgPMLI4W0ka4eBiU0XOq+gVwA/cwRSOj8+eg7R
         GiQPaTMPHs6pMGvfH9HkgvxiuzY5INaVe7dZ4UHqMguQzJVgXDMQPiuXhCdkXmuhLRWy
         PGGA==
X-Forwarded-Encrypted: i=1; AKwUvBwen/fIhbubY9FjTf/IZzWeNMjd1zZ0snMkJXi2OMK2lB1hYXsSDkUg/ZAs4T1H+QdVb1E=@vger.kernel.org
X-Gm-Message-State: AFuF++mTTcb5i/OudViRzaPQ7WYtkhHS5HSLQ1lWQMi8oZTwxClNhIkH
	Rf6/lswKuGZ1HK7rhIFyb9DWwfF3MVoZKlM3aYKAgYzhvQkjYFza2Jc8Pk7wrtT9Ms6nL480AQ5
	scMH84wDOEuxtGF72utUgHMyQHHzgHhM=
X-Gm-Gg: AYBFou078jyLARq92exdJEvSJFvo5l/u8ezF4N3j/XIz/z96thu0hU59S9T1VWo1K7r
	93tlmiRHVcR69JlEBaKWxR0jVxF5tXgL7xd1YCmhSWwdYas64IXBli6IpNbpL30ABKDR5G9AILL
	caq8Yy1kgBIGxHbz7COUvDV+5mxUH1Hxoxot5DSzcWjjV2kupLTmzh8LxXHUGmNl1PBp2zW1TZT
	k3Uux3DbxoEBkAF5NEQxOJldaxAuwLpANEdHl7x+orkPbkeiXq93CxCACROpoN8u05w99KQa8+H
	ISsM1AyTpFOMzk6WRi0GrqqxFcwYDofKmGKLBqWI/J7pVoMonXJlz4o=
X-Received: by 2002:a05:6808:e85:b0:4d6:93c3:1af4 with SMTP id
 5614622812f47-4fc47fbb12dmr3546235b6e.63.1791414397006; Wed, 07 Oct 2026
 16:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-10-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-10-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 16:06:26 -0700
X-Gm-Features: AclHuK8EIBBvyKTE1JSHvVhz8LqGQYZ8HmQ0k4B7XhTAoNdBmoS0E8pU-kNmXGQ
Message-ID: <CAMB2axOLGbeYatQ8=XNmZH1PUmigRdz7qKxwZngt6U4FCmdQzg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
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
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  net/ipv4/bpf_tcp_ops.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 8182037c4269..2ba73dd6c52c 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -361,12 +361,31 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_so=
ck *tp, u32 enable, u32 disab
>         return 0;
>  }
>
> +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
> +                                        const struct bpf_prog_aux *aux)
> +{

Is there a reason this takes struct sock * instead of struct tcp_sock
*, like bpf_tcp_ops_set_flags() in patch 2?
