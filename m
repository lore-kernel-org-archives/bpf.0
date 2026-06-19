Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDF33F584
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897411; cv=none; b=Ff2VrEq3BOcUnfBpDihFxwsR8ugaDexo6ssqMQx6dAPelM1cpImIYihpa/J1VqZ70wTtM0Zvmnk1lxJ+730Hrtzl0waeYr37Fig9dhdWrToqmu9LML4UtHFEzGtZs/gLJWNGy9/f8xAbXjrlcm5sW5exvwVUx6jHVFHI8KgbEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897411; c=relaxed/simple;
	bh=Oh2ybLLGC9jnpxFv2cvrWqY59mjTNtmLCVMVU0nxLTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRNXtO8ie1EdwAx5dbphdegtyqFeW/xSdpjiaZS1DDOtvL8DtXJyIBuN/fghf7jIuG9LOva+5x5uqwo/5CNSSvgu2FmgF103IpJg6fYauLida8AdVlkP73Egd9alIa68FSodixbU7xOIow+lVBaFg9W0W81WP2FiEEF3dKWATTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF5Oom64; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF5Oom64"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so1914880a91.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781897409; x=1782502209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7uOIAj81pDb7DXTvtaboe/dWyr0Wn96ZBecKWdg1P6Q=;
        b=IF5Oom6449vLnhIMgVWPw4Sr5Oh81jM7a9PwpYu6wYYunqkVz9heUGHhcr0VWahYtJ
         tzx5IPAKjMKnGkVssX3/4FDQbK7g3txsFEENFeZubKiNKnhpcwRVw0/PPEUec9khuwWi
         i6Da77lAVwHBTwfASrJ21I1T2OVcZMp8f3wnb+JUGP6KHOjrWY2nSowv/YRt2Vs/V6E9
         y49McxBlxBZmuBc2N2EWb5jNzFXIbYMifVd3ER9PzgQUJEpkE6VNUdK7TzVshWBtLb8p
         4rDsdyqOiZcQ+O+fKwM9SuqwRJZ6NDlPuC8ZJy6PTVtCI9+AlM4Fm4Yu2OKOq1othuqy
         pERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781897409; x=1782502209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uOIAj81pDb7DXTvtaboe/dWyr0Wn96ZBecKWdg1P6Q=;
        b=Dzij0ciEWaAKX2yiBTthhJGp1pzRI5ho6PhyQifmmRB3qxvGhb8uJy00/l6iGr3815
         IOO2nCTtDSPeXqv6v6UWEGWSYuU8UmVZmva14kGUjkL4gCqR9ID+N1kQuxtm693j2wZa
         MF9uQA8+ezzHSuXLK0zaOtkAU2htP2yp1qk7otucfYPrUmWJ03K/0zpmnfs73861Aa7l
         9UeHrLvWkDFZhoPW/CdDGj9T9r1SFiDATBJANTaZtGYK4UeDi/6XZwebKGD+h96yXpqM
         tcfmRG4Nav0oZnTHuQHAxM3xef7yfpnd8NRPH8N+1VZr2EyFEUnwYmEPDUMgffNk8gNE
         pgxA==
X-Forwarded-Encrypted: i=1; AFNElJ8+hbLo9E14UBdxUkgEQ1bADFb/WiNu+rdBwOE0Ma4OAjLzsVcIBUO5//qfl549OZN32kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNBTpLSaHAa+bJPXd3iJ1Ir7Vvpv7SktWj63iAWl/r5zbw2NT
	T0r+o0BZxsLbrfQHBFZ3oL3cl+ZbJd3Wi8Kn8LO96sSuElv91Hsqbsq+
X-Gm-Gg: AfdE7ck7dLmddxCi3V2YMSjhsXO7luI7gASl9CwdpcDH6HyhgkGnbiqCXQe91t0Vz65
	uEuYxZvc9oQUJGQPISbTqzQ+ULGQ1cub084QNd6HJuwcf1QDwxCMLHsEmnIcGNQVRuQI47BByxo
	ML1r8cuBFB3OfxA8Nzk2q0+0ryKp21Rgxsy1wlGpEvAE3Htgq9nawflzKh9gqxUwvwiW2GNR4Da
	uAjDVrX5PRhWQb5MLIci77z+DYE9Vmk7b79M8J8snXk8BsWWYoCZcTQ1teB3FRxPyBmxwEmUUf7
	3JBJ1DaaCrkB8HC8iJBVoVvq/dMyKG38AgOF/9vjG+R4lqx0C+xw6i83gY5pnL1Q68Btedf4qLg
	P408Kknz2FcCp35TRUHunpSWzZeHimwfc+SEhg4dXHy4cJ8ZqR/fVEFkPfSNWv8cohkCNqbg38i
	45OmUaBaVPvXe3aKAIbjZlh3lnVEq6EonwCiakgpzVwQ==
X-Received: by 2002:a17:90b:2709:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-37d15e51976mr5755105a91.12.1781897409221;
        Fri, 19 Jun 2026 12:30:09 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1558c6cfsm3705447a91.8.2026.06.19.12.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 12:30:08 -0700 (PDT)
Message-ID: <a180a5f633b3555630d9a9d2bef2573852918112.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover refcount acquire node
 offsets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Viktor Malik	
 <vmalik@redhat.com>, Leon Hwang <leon.hwang@linux.dev>, Dave Marchevsky	
 <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Jun 2026 12:30:05 -0700
In-Reply-To: <264dd4a10d3abdd037e01ccc6da44e5a5758dee2.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
	 <264dd4a10d3abdd037e01ccc6da44e5a5758dee2.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 07:59 +0000, Yiyang Chen wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/=
testing/selftests/bpf/progs/refcounted_kptr.c
> index 61906f480..7955a9973 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -741,6 +741,39 @@ int list_push_back_uninit_head(void *ctx)
>  	return ret;
>  }
> =20
> +SEC("tc")
> +__description("refcount_acquire_list_pop_container: acquire normalized l=
ist pop")
> +__success __retval(0)
> +int refcount_acquire_list_pop_container(void *ctx)
> +{
> +	struct node_data *node, *base, *ref;
> +	struct bpf_list_node *list_node;
> +	long err;
> +
> +	node =3D bpf_obj_new(typeof(*node));
> +	if (!node)
> +		return -1;
> +
> +	bpf_spin_lock(&lock);
> +	err =3D bpf_list_push_front(&head, &node->l);
> +	if (err) {
> +		bpf_spin_unlock(&lock);
> +		bpf_obj_drop(node);
> +		return -2;
> +	}
> +
> +	list_node =3D bpf_list_pop_front(&head);
> +	bpf_spin_unlock(&lock);
> +	if (!list_node)
> +		return -3;
> +
> +	base =3D container_of(list_node, struct node_data, l);
> +	ref =3D bpf_refcount_acquire(base);
> +	bpf_obj_drop(ref);
> +	bpf_obj_drop(base);
> +	return 0;
> +}
> +

Why do you think the positive test case is necessary?

[...]
