Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F3560ADB
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001078; cv=none; b=Krb/c4r+2HIG6DdMSF0xgKe1kvMEp0cVi2l/VHjolbmyv6M4FJG8CRgLUSo8EPDbRpgy5ucQBqxJ7pDIvN7+8Qr4Qaw1Kj5M/C+0TtwIcJMMcTifyxdGKwNb3K4CMHR318U9Ru3ddImrRdPAOcmJxuqteYEhS1gzEQsxv+DHo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001078; c=relaxed/simple;
	bh=byT7Oi0cLhQwYSkFtKGiGpgd82T4uT9+1PBWVi3fXck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+LtLGyJrSJ49rQeHc8E5C5MQDLqGffxpA40898ws0zkF6mueMx0r0c5VvQ6xV+M5ZVfZGrFLoJiWEVtYtx4y5vDh/i9G/6QSX/h+LHSmLCWKES2Yy+5E4jp4Rzu8DAKv1oshidY2YNcWDC/hT1PknueiEXFItSUzilP1muP664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnd/SA38; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnd/SA38"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd616db42fcso875472a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001076; x=1792605876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wq8CsgNnCjhuDOhxvAaqmUytJ+XS+cCMriLGrdCHHLo=;
        b=nnd/SA38bm89Ivzv0ASOgGzzkdq+hLveZgclJ3DEmPRvXo1Wg/D1YxOmPVL3wXVBVJ
         egdZCD6DBy6RA95gnqJQP/JbeAwGIsEhqJJVUW/FaG4RAoOHBgIZmw8CgZ6Ga3dvPDB/
         T/1FNGlC6N1EIXCIY9h9oCc94t9BADftyB0PJZTNkbpjIJCwjCFtSZWqW159VIUo3IkP
         c2Yxr+UZohi7TaUpsFE9OgCktLRbk2m6i33/mFyyatpfc6MAVGLUn1xusutvGE6zBL3r
         wtZhfo6B9eK0gx9AH8kJF1D7IQXvzxM+iEvnKgTAAQAShLXzSeyY7sH3VJ2hyGOUub61
         PKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001076; x=1792605876;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wq8CsgNnCjhuDOhxvAaqmUytJ+XS+cCMriLGrdCHHLo=;
        b=v6sarLy0wCKsHw5QU+VDXiBo0hvZXHvSi9GlWtVoB9GR8ugl+JXsMhboGHXxN02jTO
         A6PExjQCCIuCFgau/ryyv76bPdcsKNHLAL1YDmj68wqrIguaOZ3he0iXrVe1JtXL9Kh/
         wZEJn6xReV2AVwhWTBCoGTf8Kr6e9e8/z64AAY54XsBIjKLe7VFxa05qAa9iicmofKMR
         RH9m+ccsuGdvpzzkmTrikJq01DtMRoAnShkpVQoF/mAqINLK3V5Cy2ftUeei07BnhkhM
         031C4HrQs5dS+kJ1FTBbUf1+fSTNuT8eL0GPj6byPyyvY62/tHB6PxNRGvS+ujpYWXel
         u9xA==
X-Forwarded-Encrypted: i=1; AKwUvBydVkoMahz0R0SZ6Sd7PkJFCozXOauZNwD2swrbNspe6qDAi0pJeiRsjouYodhWTp/yGe4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnAdmTAqDX6ZPuOhmm8+q3U6FqQT65Y+acOgAA7VA1ANqZb45u
	RQe2ulb+CYOcONOqLosBEuoXaviqDKs/VHZobg3jkM4JquFO+e+017um
X-Gm-Gg: AYBFou1P4t8OQC5uoxz5AW6ZM21O+mMnz72lD/OOSkP2eRhIrWVqIkWieokvZ9UjpAZ
	QpPL8b+0PDTmGeBXZQvK33BdolRe6lXOH2E++5F2fXCmuKfwcV71z7mPARNQNwNOL1j5em0fkRB
	NaaKwgs/5jjgaaPP3C+o9IiFFNzorYZ0kOdo9JKh0YZ4truBGuHBNz8eyv2POWyOh+uDUVqcZs3
	h8hDrtWq1+ypJw1oV8yu9y756r/ZXOigMXobwhprk0t1sKAePiTATPA2GOyNXpjSLl9tg9qmY9t
	PxOJ0qiKZ5QVUy4ALmDcoqXKfFQvR+6y0brLBGMTPE9ln5tEyx6dkOiGNkCVKUgJbp8cUwUsxTM
	EICMY2v/ALD4LnhG/4+rCdQMFQ+y/R+ew3dnkYQGvYWYBQyc8wzMNshg8ABhkh6+7VoP0u3AuXl
	jHhWl8XzFMiM2IFhaMIQ11EN08v6jtfjhjtLEZcQkEBzW8QFKWj7k3rLyk0cZ2A0j8
X-Received: by 2002:a05:6a00:3385:b0:886:c8d1:632f with SMTP id d2e1a72fcca58-897c82b072amr13779945b3a.42.1792001076265;
        Wed, 14 Oct 2026 11:04:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804e391dsm1439578b3a.39.2026.10.14.11.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:04:35 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:04:24 -0700
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
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] ipv4,ipv6: convert the getsockopt
 switches to sockopt_t
Message-ID: <as_EIAJpsA1nWKU4@devvm7509.cco0.facebook.com>
References: <20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb@debian.org>

On 10/09, Breno Leitao wrote:
> This series continues the migration to sockopt_t, as described in [1].
> do_ip_getsockopt() and do_ipv6_getsockopt() are the last two switches
> still taking a sockptr_t pair, and everything they forward to now takes
> a sockopt_t, so convert them both.
> 
> Patch 1 settles what a negative optlen means on SOL_IPV6 before the
> conversion makes it matter. do_ip_getsockopt() rejects it, but
> do_ipv6_getsockopt() never has, and the int options answer it as 4.
> Treat it as 4, as David Laight suggested, instead of failing callers
> that rely on it.
> 
> Patch 2 fixes a latent bug in sockopt_expand_out() [2] itself: it caps
> the expansion at INT_MAX, but iov_iter_revert() refuses to unroll past
> the smaller MAX_RW_COUNT.
> 
> MCAST_MSFILTER has to move before the switches above it. It is the last
> option with the quirk sockopt_expand_out() was added for [2]: optlen only
> covers the fixed part, and the real reply size comes from the gf_numsrc
> field inside it. Patches 3 and 4 convert it on both families, and store
> the reply length only after the final copy succeeds, so a copy failure
> can't report a changed optlen.
> 
> Patches 5 and 6 convert the switches themselves. Each wrapper keeps its
> __user prototype and builds the sockopt_t, so the proto layer is
> untouched. ipv6_getsockopt() cannot use sockopt_init_user(), which
> rejects a negative optlen, so patch 6 moves the clamp of patch 1 up
> there and builds the sockopt_t after it.
> 
> Patch 7 grows the selftest with an ip and an ipv6 fixture, pinning the
> returned length, errno and reply bytes.
> 
> The temporary sockptr_t-to-sockopt_t glue can go away once the higher
> level callers take sockopt_t too. For now, the series keeps the proto
> callbacks unchanged and converts only the leaf helpers.
> 
> Link: https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/ [1]
> Link: https://lore.kernel.org/all/20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org/ [2]
> 
> To: David Ahern <dsahern@kernel.org>
> To: Ido Schimmel <idosch@nvidia.com>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Andrii Nakryiko <andrii@kernel.org>
> To: Eduard Zingerman <eddyz87@gmail.com>
> To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> To: Martin KaFai Lau <martin.lau@linux.dev>
> To: Song Liu <song@kernel.org>
> To: Yonghong Song <yonghong.song@linux.dev>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Emil Tsalapatis <emil@etsalapatis.com>
> To: Ihor Solodrai <ihor.solodrai@linux.dev>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Stanislav Fomichev <sdf@fomichev.me>
> To: Shuah Khan <shuah@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> To: Stanislav Fomichev <sdf@fomichev.me>
> Cc: david.laight.linux@gmail.com
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Treat a negative optlen as 4 instead of rejecting it with
>   -EINVAL as v1 did, per David Laight and Stanislav Fomichev. 
> - Fix sashiko findings
> - Link to v1: https://patch.msgid.link/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
