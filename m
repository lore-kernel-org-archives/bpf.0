Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734406;
	b=u+PwUjFkAQw2Em+rE+qTW/JesKZdegqcuCvXZ0u8iH32HoIGob7MZ9mJ+Ypn4yjwUp4M
	 2Yl+NvJ4McK2xV6r12sVqrlqygavFGHWtuwGI4RFC4/Ncb1YxJYvGjes+v/+5VCt8wGgk
	 WI7OpUfXVLOX+wbz7T4lShT86L7BHQ93P956matv6ZN1bOlgxEGXva4rUQ8hAzevN2vIW
	 e8cFBgkG9zDDbijUF5U2n1cjUAJiBTKAvFjU6nnmaOmlx+HfFZaIknQmqHGzwMthIyWH3
	 RClFG4j5VF21OefASoruybAotEXCcEtOwSiJIe6yn/gn0+xF4D7ElIBc89qDArAfUVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WLkZnlYTPQB9u5XkBC13rSiJ7ZjBn3AlusJ3/Izfois=;
	b=LgWFiIS3GRZKGudo87i/ZIMQt1+l6Tp/zH+y/kTLC0N3rOeby/WSAc3FXSjF7cMxZiac
	 y9aqTQPnAXoEmOpPPCZIMIEebCXkFoztnyVA/BFQwjoYlnIyqGZT2uu56lNbD5w9HcOaD
	 KYB1BrZ+mdF9HuiPBzq58Ueq7076xS30m7hNJSAQvVoZT0vdlaRQ6aUMhYW44jgjVSHVD
	 6R+V9WQKaDlxDyGaLZcfX22WgjJM3AxSU81Uma8SnerstMcF/OrouLSrXodbaTR9K+6Mj
	 UNQMmK5/UQUPwxad2hrAEVixD83yqMjKVx52o3h2pth+3bvpT4azFFNinno76F3HI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J61wv2ex;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B31606D81C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1B31606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J61wv2ex
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537f63c9e6so1789929eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734405; x=1794339205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLkZnlYTPQB9u5XkBC13rSiJ7ZjBn3AlusJ3/Izfois=;
        b=J61wv2exN8htNK9lYuklAxCur6wcv0gV5hEC4LTnv0vsbzjE6WiHCt7vWZjwAitqGZ
         Z7QJGrGIyNMASgr4gdZuZj1Pu4FrPDgNq7pR64TF8oxW2MfIBxs8YSw804DfE+kcoqFa
         Z+DARbn0OIX1wVOExotXpAuNN6Bq0mUytJTfXlWwhCDJKVjg6shwf838sdNKtiGXZtNA
         kTL3VZ2irXkBCgWt7lgX730fCFRMNjbgrM8zlymS/OyKDhqfczbPlbUjQgX4NgsTN56b
         nnhnk4sJ4BnyPDMipav7BMCwKwX0BrEMBZAwBM+9E1xFpuf2BeG33U/EQifOTZyox99s
         xi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734405; x=1794339205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLkZnlYTPQB9u5XkBC13rSiJ7ZjBn3AlusJ3/Izfois=;
        b=PI15ltk1iwQDDwzNEn/mHk60by0LumSjM9syW7sTbRJwKkklLFJsNEpvT6tvGbMrjV
         hDCNQLhZsxH2hD5gU7eq/7kaHjikuv/YILb1XcNuE6ONE/xUC8RpMdBUjtveaLTx8h7r
         tYVqKq94f46yTwQ4sNBrfRVdxgdZ9UI8ksDQR+z4OvqpQGNmrBcptDEdI9FRT8GY2uw8
         tblEFJEyG9Ctw5yJhhj+VUUR5qE3bbfWO6A+4Grai7EXkUz/7cgrpANzECRKVbvVAzKR
         hIkd+uNNEqPC3yU1ZbLOfpMV7C27Fo4kInUvFwBFaTfObBnfH2jhKUp64rCe8U1XD1hJ
         yOzQ==
X-Forwarded-Encrypted: i=1; AKwUvByk9ZlesYwlKi2QcmR1+43ww/BFjWh/uk1trxcnN5Gd+zxXEyMUeLDAOBhcs61t23aZDwo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6ZS5JwfbBWxPrxZdTUUrtDsCS0po8HLEpYTAw2jLk2zww6oY3
	bswH8oJHhE90YKmm2kunbt+aLFxTfCPN1ZKl+JOSjvoKGaLdPyHqW0lo
X-Gm-Gg: AYBFou3UCYusAciZhDF07WMGmiH8qBW2z+PsTTfhdAmVQkP6WOPNKuSdjgjEI6pWIkn
	/RK4X5d14IVwRNo/6v9WD/3GP1ba0wTI9PVxHdTq/c8fNtVSdoxhaXKNxwB1YrD3ihSnqbs9rwV
	KdA6fCUdbeJV5dTktIqRabBpgLhup5Y26RGkolO+hxpC/A8kYEkLvp92mRBfHUPS1GP7wezVpAK
	+8B9ZU80JDDH7tooPe99PdzUxkAHREifo/EiaXInXSdFowK568Fl4Mao3B7Z+DgnnmNt9q79TPw
	wtCCsJoAtc6QRrju0WwFg9Ne3IHsEtQjfjtN9IqEw4P1QDTqPhjw3z3HuBpJVWK3vf74PlnNFIg
	gZeFN0JaKh/gub5PNvKHEm6mpNLwEAnwhW86ogAFWxO3FQWpPo8Diy6xjeOjltrqZopcBxfAjxU
	G8aZofNTyI5glzyK3ZFW7dvNLrvL9nSs0iJzumrip8nQ5KkQ+XvgQzQPKxEP0pS+udrCKibqRG/
	G96/rsfuQmmuFd/ZAzNdHE0+TPhw33A18ucI0Zill/krIbi4Pl3lOEHHt0y+UQsxbNK01CKafKm
	zn2089FKRKwlLjE0aMevrg==
X-Received: by 2002:a05:693c:4159:20b0:351:29c8:643 with SMTP id 5a478bee46e88-36a423a8b7fmr23017109eec.18.1793734404871;
        Tue, 03 Nov 2026 11:33:24 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:70::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a54ccsm285396eec.4.2026.11.03.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:33:24 -0800 (PST)
Date: Tue, 3 Nov 2026 11:32:55 -0800
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
Subject: Re: [PATCH net-next v4 7/7] selftests: net: getsockopt_iter: cover
 ip and ipv6
Message-ID: <auo24Z7c121m91VZ@devvm16445.scu0.facebook.com>
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-7-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-7-2d36da923578@debian.org>

On 11/03, Breno Leitao wrote:
> Add an ip and an ipv6 fixture, pinning the returned length and errno
> across buffer sizes, the branches that answer empty, an unknown
> optname and the options dispatched before the switch. The clamp tests
> also compare the bytes copied back, not just the length.
> 
> SOL_IP answers a sub-int buffer with one byte where SOL_IPV6 clamps the
> int. IP_PKTOPTIONS and IPV6_2292PKTOPTIONS want a stream socket;
> MRT_*/MRT6_* want a raw one.
> 
> ipv6.pathmtu_negative_optlen pins the clamp of a negative optlen: taken
> as 4, it is too short for IPV6_PATHMTU and fails with -EINVAL, where it
> used to pass the length check and fail with -ENOTCONN.
> 
> Only the two hop-by-hop tests set IPV6_HOPOPTS, which needs
> CAP_NET_RAW, so the other ipv6 tests run unprivileged.
> 
> The MRT_*/MRT6_* tests skip on a missing /proc/net/ip_mr_vif or
> ip6_mr_vif, rather than on the ENOPROTOOPT the switch also answers for
> an unrelated regression. A kernel with CONFIG_IP_MROUTE or
> CONFIG_IPV6_MROUTE built in no longer hides that regression behind a
> skip.
> 
> The config fragment only had CONFIG_IPV6_MROUTE=y, so add
> CONFIG_IP_MROUTE=y for the ip test, and CONFIG_IP_MULTICAST=y, which
> IP_MROUTE depends on.
> 
> MRT_VERSION and MRT6_VERSION are spelled out; linux/mroute.h does not
> coexist with netinet/in.h here.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
