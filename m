Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734405;
	b=AuLy9RVSoaQSnt1NX6Z9Am02R4eQcwzj+Vum5EzmZLbCiuCg4lcR2q9ApFOHz1Tn5bpe
	 TzauS8oxw0YQbmCktG/CS8KOc50Jr4jIMtzPTviY0qcVZZvKC1AUPvP/LUUWQxPHm6Rs5
	 YagyhdcgwcqvG0JhUkfnfjYxFmVzgpW1E7F6Dp6ENGvTgRzr5xelMQKJBzTVVDvbUvgTF
	 renlnSuesCwAXAfxzz5LX1nfn1OVM29i1bzNwmopfHOihMCJUNCFDAqu1ETVdTGLqPnx5
	 cpuhALiBZK++uhx1h8O95e2J5gD+k1/xCEA6ZJx8bd00gMI85u9vVcBG0yCyt/Eb4Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=15RJraNkt4G9imlgns/mzHRKCrlWGmqvpmr2tllrIBY=;
	b=g7dPKLd60CRWZZ43sODKOcJQ3fTDzeb/dexGlqFu0BmL9NMSxxu/8K2GsPksbmEQJFT6
	 8JvVCQ/cSfSQ7PicKrF5VsxVOPsEsZFWHI6rmWk1Wv1gxRG0wVTKfkNCi2PD/IwQ5lM1w
	 Cjrt6Kwa0Lkqom3uowrYXYR3UAsM4QFY9TAqTG56A+NSMdz8oNxHha476mqZzqRD2PYyG
	 I1C78mlyxQRRbGjGphsrxN7KyMwGpvmfUbP+cd8eKl0cyvVwEe1/Lp63bNEuofpxqw6c0
	 kK6gA9W5Jgxgw05fJ4nKZULfGnU1ZplGpiBGrnDqeyUZIcvXroPrT9EIgPgGRGnEcCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wV02aST+;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97608606D809
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97608606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wV02aST+
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1346306eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734404; x=1794339204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15RJraNkt4G9imlgns/mzHRKCrlWGmqvpmr2tllrIBY=;
        b=wV02aST+LnFuxBvV4bpYViFOafiBAI18U+cmy1u7/O8lBLjisx42g0f7VqlS7j6qWi
         fzZdeH2AtavuBEinDao1789fn1sBOJr3JreFzWRfnqHWIS3MgMOBh+kCvVGAjlYJmkjp
         QgfY3aVLjOO27toy9Do9VDZOcgWKHeLvUXUJt9+QhVCfgJ8B4pweYXZ1VRn20ajx22In
         N4rtQdS+6e7xZeweLYsATcu/Kuk3bCtZw5GIGxJKzMd7MVsi0m5Otgs1Yi62uqzl21Oz
         tUF7KmL6ccLm27Tb19Y4GTxqG+Oyz0lqfrSYtZL/ELJWt//50dFblUY+uRpGpFRRPic4
         ZEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734404; x=1794339204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15RJraNkt4G9imlgns/mzHRKCrlWGmqvpmr2tllrIBY=;
        b=F2TOwsWeUfME20dxy4mXe+c3nuHYDG2D+pHsepNkY6XtJ4yf9sw8dATgQrCp75g+Up
         0hBdHLLf8F3RXbMiJLNqpCSJWCqaJKfizbPA9K20uU/e5rymunTm7CD1vMmmuigYr/Hl
         OHthoBTeQSe7N1Elfu0LO5Ejv7rlkmJY13QKdXFoBbY2vpO+vmMKI+CGwodklJ4zHyFu
         JosQdE25tEJs0DiGenDfTB5TqMkl9ZRKUFzltIRw5a3h5UucCNCUGzivwQ6Dv5mZTBkB
         L4y4NyxL7+5Ehp4NgVGpHqF+8LV6wSaxISjvRLm7s6hF+j9nTXnmfrRAqqmnjKnz7Bw8
         Jwzg==
X-Forwarded-Encrypted: i=1; AKwUvBx2naaBSCYIkCwePRwsHV41pMSVSILG6nkhJXjEld1vsd04rcYmb7tkoLQxsU42La84vgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z87gdgSulmy1tJd3ndmp1hJlJl8v12gYM6mfTF7txo5aN8sLQv8
	OS7zmRDl6UdRckZYkiKBJ/iYJsjiISzMxZmSMyW67KN5Q1mWs5Mk+goD7ZGFUyx+
X-Gm-Gg: AYBFou0e9FK3srTnYhbIiGzZhPujauN5LoMVgBr0F77UVN8iyjnswxFVhzPe5Hd17FE
	IDYwHjWhV3dTf1/BRUUGTR+qdC+uMyoeTORgmWqSg/l/yiGcaYJ9lyVXBFko2Sy3kzg20aulXXr
	yJmNsIuqnnAWBpFRxJFdAvut/8bHQgK9D/gulJ5fbm5lWuelw/zLbD1METmSpI8Vcrj52ROmKVN
	gDRJjnSxfDVGQZq5LF3cGe2JNLGEEiUyO16twoQsS1Xher/1wPsbWxInwj8457vRHeB7bIvzC5V
	8QBUovn8lDWiYcJ4mDRkZbDhxrmQ21C2v9LLVTYmpt9B6sdotWKD2LvvxwcMFrCBrLMp2JtT0RF
	gMtYFrUTcS7wruZ1TejsvInShexkNxDuPGoaxVjTiSnUyeTi2hotUbSOxEcJIJU5WGPi6ca8vJp
	MMdWWZ7rGfyv+lAYYqYCtYvYfu9SIrgOybPpPT4htkj1/hTmi05sqP+9kKBRR4qH4kWos+Zi9YK
	I+HZabE/Ubxb1MZWDhBCj1rP3pIFXjHPxSpdRQI+lP2X7b//u0+wmQR62HqUrQ3tUWhTiScvRZQ
	ANliL+KyscPzI7Bt4aQcIA==
X-Received: by 2002:a05:7301:103:b0:36c:9af3:22eb with SMTP id 5a478bee46e88-36c9af32cb0mr2691600eec.34.1793734403660;
        Tue, 03 Nov 2026 11:33:23 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6b::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3785430sm527244eec.3.2026.11.03.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:33:23 -0800 (PST)
Date: Tue, 3 Nov 2026 11:32:44 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 6/7] ipv6: convert do_ipv6_getsockopt() to
 sockopt_t
Message-ID: <auo21mFFkL2zH2MT@devvm16445.scu0.facebook.com>
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-6-2d36da923578@debian.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-6-2d36da923578@debian.org>

On 11/03, Breno Leitao wrote:
> Convert the SOL_IPV6 switch and its two remaining sockptr_t leaves,
> ip6_mroute_getsockopt() and ipv6_getsockopt_sticky().
> 
> ipv6_getsockopt() writes optlen back unconditionally, and
> sol_ipv6_sockopt() builds the sockopt_t with sockptr_to_sockopt() and
> stores optlen back as well.
> 
> ipv6_getsockopt() cannot use sockopt_init_user() as its IPv4 sibling
> does, since that rejects a negative optlen and this level answers it as
> 4. See "ipv6: treat a negative optlen as 4 in do_ipv6_getsockopt()".
> 
> Instead ipv6_getsockopt() applies that rule itself and builds the
> sockopt_t with the new sockopt_set_user(), which sockopt_init_user() now
> shares. MRT6_* is the exception: it has always rejected a negative
> optlen, and still does.
> 
> The write-back also happens before the netfilter fallback, so an
> unwritable optlen turns any error into -EFAULT and skips the fallback.
> Likewise optlen is now read before the MRT6_* dispatch, so an unreadable
> or negative one wins over -EOPNOTSUPP.
> 
> For the other options, a failing call that passed a negative optlen now
> leaves it as 4 instead of untouched, and the netfilter fallback sees that
> 4 too.
> 
> IPV6_2292PKTOPTIONS and the sticky options used to return the result of
> copy_to_sockptr(), the number of bytes not copied, so an unwritable
> optlen made getsockopt() return 4. They now return -EFAULT.
> 
> The extra code in sol_ipv6_sockopt() will go away when
> sol_ipv6_sockopt() receives sockopt_t, but, for now, it only moves the
> leaves.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
