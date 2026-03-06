Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E133B96A;
	Fri,  6 Mar 2026 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763923; cv=none; b=OLcnx4kN76mGmbb6sLbfncYPc1JbjypF5NNaouNqUyPggHeEnZxdHNt3yp1+OIflqcUWYkT7H30NzATiNeD5QM+y9dEfILM8iknlL+dhoAItd/xVn+D0MRQkOuM6tsS3NIBvsdQoofzy/xXgmhSFaYdaNlNKvWwbbgnk1z5KoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763923; c=relaxed/simple;
	bh=ooqZNkuq+MbCKB3WkGV8xm7iUfWSkkLNN9oheChyRnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkzpZO+94KtzFa2425tU7vlDnDhlWXj9OLQ8K8sW27QqN8u8kN1tbE1bSvHV5wN2jYYzHVzkZeKnAOUoj9cdr0HbvNLSVUN8pbfEli/8Gqj7vOHQWN/k+ljKxKA8kHi4U6nv56j8TwXyhghpyfIEQpSrA0b6zGbV8HRQ3LYjCeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCKqfVhr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCKqfVhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD27C19423;
	Fri,  6 Mar 2026 02:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772763923;
	bh=ooqZNkuq+MbCKB3WkGV8xm7iUfWSkkLNN9oheChyRnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCKqfVhrwS4y8gd0iYWv/hkaF4e9Q1eVroZ/WB0YN5ChA8knYnj5GLsPwFuiLYS7i
	 yiSk151B1zd4Sh0URJwb2FdOsYC8fpwb6VZU86xK/O8p1X5p+v6bUnONutNCC6B0kT
	 uPqO3Qhs98CFSRivejJE4p8yIdFD08a7ML1d2k+3xi9TsuHFedBcdVciIy0RO2nSrN
	 OBvA9+xSBIbFrrmnGPiI4ubYU702BJOlV1AZC5MZMsWkGU4J02vUeNJnZk2cS6zS2g
	 HCp2NJFBuHsXd9cLpPOytOL6bP2/cn+2fuYmrC6cAX4tIfkm8Hksm16wdXOJT7/r5x
	 X56LHukUM3VGw==
Date: Thu, 5 Mar 2026 18:25:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, David Ahern <dsahern@kernel.org>, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu
 <liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Message-ID: <20260305182521.0ca7313c@kernel.org>
In-Reply-To: <20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
	<20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Mar 2026 18:29:56 -0300 Ricardo B. Marli=C3=A8re wrote:
> +++ b/net/core/filter.c
> @@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct=
 sk_buff *skb,
>  			return -ENOMEM;
>  	}
> =20
> +	if (unlikely(!ipv6_stub->nd_tbl))
> +		goto out_drop;

So neither Fernando nor you checked whether this code can be built
as a module? ipv6_mod_enabled() should work just fine

SMH
