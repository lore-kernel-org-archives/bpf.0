Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149335B63D
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034707; cv=pass; b=etVI32gj3hgFQmt/dK9KX0+wea0Rxcf04JPrEGnLTpEj+83l27l4KlKXQEa2gr9tkPV5+cs7ZJd1BC8HFojyi8YagaTBYF2z13vizh01x/l1lXaT7jUCGmHx08AP4q/9XwuIkJ0S+sYiN0eqksWN31F/6fXFlyCLpla7KzoBtEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034707; c=relaxed/simple;
	bh=dmaTcuAy6jfJ+bmzS1Jm/uyBrkTWgyDnScrFaQ2/nas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjq+JQmd7npsoyOsfajEAtMc0SqjcZNTpWyczVSG2ge+qzNEUPNJoRbH0BjBmO55pPTbsqp1BmCKLReRcxPmzWsQoWiCuqRvwMa8tBn6KSNoartKn8yRWz0TJT8fUFGfInV+jU3NzZoasoIqoLYO69SZv1wU3QfB3ShWqEU7Rrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twFnRIT8; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twFnRIT8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-509061dab77so56640591cf.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 02:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034703; cv=none;
        d=google.com; s=arc-20240605;
        b=EyRxaIsqlTR9BJ64MuqKfJK5M+Zb1dyPKqvnAENcrjOwazalC6A2MlCDxBIZ82IzpR
         O+8vhR2T9v0MpX24Uk0XRcDN6wFypEkJWVlS3VJIdh08F0nFckUcrJKU2X3+Z6vEOt/Y
         no7+8I/KeRH1l2Dosgn+dNK0cTOHZIzc689l9DcViSe5nMSsqF2fFk5l1bQBblfq7XV3
         AETGk1qvLJarEm0akO/c3+3WxrA3wsKI3niumZifJvuU6rC9J28OJcmn18FREDAYLpRn
         kLlrwsC+59AGiC6hxed22jRYCozvYHN0L4pOQf8bpcZ5h0epCAtkQKswsKAHlO8AtZaA
         mqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        fh=NGqk7CD9Nx8VTgImWv152L6Stw215KUn9gaSSasBxHs=;
        b=iIcRD3KYkSet1/BZP93zQjrLmGRLWmDmcN0dnxDOe6mJ3iG0hE6+FrfYh2gXVQ+4uT
         LJTFWB32LNaHBeBLGGzmsYT7aIlbTeQRecGqhIHB6AAmpyoJjtWK7c5Fg+Bz4GNXUSwt
         wg9Q3S7ssTtuBTnkL8zNI5g7OGjd8PQBXN7DAUVh8JC8HHjPL1am3ohtBHzUS3FRb+5H
         vrhmuJ670Xxp86hagRmQ6//ji3LALNlO+ZVbFcev2sYpUJFyg/o1FaJ+4weSI7LFp1Fq
         tGFq4UioS5ySA5BLOz7oQlsFufW8C+6rkFUmXi9DjF9gN3RZeM494glzW+79xmvwNlvo
         pD8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034703; x=1775639503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=twFnRIT8SirtW12uUCHs6hTeF/J2DOg5PKAmKI/mwRCncAk4AIvZwUq8xR7yTK0iJ+
         4ImgI8xWhYvzAYMKo33ksmbew7TAwPlXPwRplqecw+NYSPwHcYD8NcIFmA0v/FzgmIrA
         GlgznlRQinWJpsA4qp4IlnNYa4zu4LMzYJu3khv64uuDL3+ybWpc3gfaIp1N30uXymnh
         o/KWJm7bZFr+X8f9bK2b9IBUwDPo2JrcV4mBBOIg3fqCL5h118wWZzw/mlpOg5YazSse
         2pJzkr32Nm/rqUXZUcHdfdBBA5R+Rztx/u8eIHbmmnYHi26nHKuFO8CqGzwdfgZfHKXJ
         VrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034703; x=1775639503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=JEn6PhDa66F0NNKoj01FVH0mf+wTHaeATfANYE0d29sLktqC/46ltxB9eHbThdCpqK
         hanF6n/DGGXoXZKQnAKj8jG7KkgQojuGzAICfxT9D/gO4M3/aritsuuCPkDiQTTiwh2H
         Z1+iL4L1BCz3QrqkK1O5zvPWUKp6qBAAHW1IMDrnYZpSVGZhor8h3vwAkUqPR/0dFqv9
         bod4hQUuSs9/xZnq4M+AIRXSnT+imLN7TQYrpWk6i+mdYxTRnO4pf8QStv0bcPme/Net
         wRCPPfnpzSbl1LNKFjSvGJTKl8j6Lu9IK6q6bGXL0vp62rh9KSddfrg4Bt/tvxg3ZGKq
         QVzw==
X-Forwarded-Encrypted: i=1; AJvYcCX4e9UhsYOsb4JZPBqbBwWIq+syRTNBQ+vJjf4hhq64b2wZzaTM/QHM825n5Ljp8J6BeY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sf+ymt6i36tPwvARwEDHxrfYFNyFBXfT/lVPeoJnJHi4vy+T
	G57FKWhJb/1t5rVqQwYwLh48KaeZ4voad5sMxzZdhg3OAwTjCxSuJdiGnsGqKaBKqelPsDyT+/c
	/8V8P8448Bbj51BLsCfIKCn3XaMIZBzxn/fHsATY6
X-Gm-Gg: ATEYQzxtBo9AHco/Mo9rERrYhXZrStjcAPAQITRiyX3EcRi7B3rIca1NQi5jToapPex
	hUOmS/BJhi5J9tbHL7yOV2NtDgw/FCaiOH0AkPwvqc4pCCF6x+4DyMQ7EMyuJGoD6qkJit5cpMh
	MnnUImmmer+KEqhoyu3p2FnZpfsgw+nCnXXXgm+aGXule+q3PgrdfPP2v+91w4f2KsezzQPcFQJ
	RuDMyW/nxkWVMP8i0M3vbmv4O74NQdgBnj8A5nuWfzjPX84IinWS0+x0mFHI/pMQERkAnBWl2MG
	d2/YUMwrhxORwfOi
X-Received: by 2002:a05:622a:5909:b0:4ed:b2da:966f with SMTP id
 d75a77b69052e-50d3bd84b29mr44808651cf.31.1775034702251; Wed, 01 Apr 2026
 02:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:11:31 -0700
X-Gm-Features: AQROBzDMpjzScINQf3v40GgXHFr7zNRIwe6Qb5aBvyyAycV5Up8H_bwJXHOzd_8
Message-ID: <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Guillaume Nault <gnault@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>, 
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oss-drivers@corigine.com, 
	bridge@lists.linux.dev, bpf@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> There is no need to listen on AF_INET sockets; a modern application can
> listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
> the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
> socket.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  net/ipv4/af_inet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>         struct sock *sk =3D sock->sk;
>         int err =3D -EINVAL;
>
> +       pr_warn_once("process '%s' (pid %d) is listening on an AF_INET so=
cket. Consider using AF_INET6 with IPV6_V6ONLY=3D0 instead.\n",
> +                    current->comm, task_pid_nr(current));
> +

Some kernels are built without CONFIG_IPV6, so this warning would be
quite misleading.
