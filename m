Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453DD35E94E
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 04:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595940; cv=none; b=QQKeQHI8d3WyXa2yFMs+dIoMzRzE4Qfm6C0RWzkOntqjhAnjwRdYCD/l1z/0Yp/5tbnjj41iWKd7hxU2m1f12oMkLdocoRffs01c3eORO/etXrF/i5cpu4ro6QU5DqjB7pS9l6LMGp/cpU5fdBs5Z2NBdwobON0eQBZqIlsEu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595940; c=relaxed/simple;
	bh=ZP+YmiMqjne+BIOHGU+qADJTqbtfWsS0k9JYL/OigHc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jHBxKeoKaAE2g6BHbOKSSge+vQf7vD+9Nrtia+FYJQw5DQBoEBId4L0tqnQIFy+KbW3d1QN/lmKcolZ3G8i9Q44nr+xPlc8JSX1OeHKkdbwQh8zOlP7cD0AqLOIJrLr2MzF4jBFPZXXFmzarqO5nflzzFymqXeRGOMuZ1Lryo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8wH5v1i; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8wH5v1i"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so6781945e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 21:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786595935; x=1787200735; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GAZ+x7z6BZhFTzywSoAUTFEoxQswSZuOueFTYMsV3yc=;
        b=I8wH5v1ipf6jTzf73Skb6EHOHlwIuVrP9/aKf1nPZPfErp3694i96FbuBa4CaPgnG5
         euuzpDWKP6LZt/vDumbKB4jYBPn+sNHH0a1K1fkPsQ/EYjm50Ij5lWaO3v8JW7CuNZp9
         v6lqk7Cr+2XzGmxYTCXRM+2nr0YR+xfXLD1aKX2Q8HTqfubflWXi/YH/JqAHJiStN1K4
         b6Ozvw+gOSvFyWwK3iZtONVF+fi19GJFuVjV2eHunCDqhjdpLqdc8quZtGnwhS8dWpQf
         QT7KFwRHRI91ywlDV7DJcpIIRPlyf+tWJK9JN3cnLIBExVjl9R7bEHtop/eDAgF7Ndcs
         wEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786595935; x=1787200735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAZ+x7z6BZhFTzywSoAUTFEoxQswSZuOueFTYMsV3yc=;
        b=oCJcLLJAgv0AvzfEVOzuwqoa1QOOhqqMVTFflH7m5XoYcNwdjADQ9Bq2LB2nY8egwT
         xH08ZRwUeRchEdP22y5TnMbU1BnWGLXGnZtfDeFnc1s+/2rZNUjRCyYSVYcigOKfFyuQ
         RKSC9xsWeglPL0+LXhHU1wqlI7Je3hEDIMiZEXvNrNxszzcrUVtSjUiy/0lbyHjKi8/b
         1E8KYZDg+SK7znOvNGc1Crh/j9lhWlXqE+hGl1vozR27MKK48nvCG8yo9yUp6j0qd9H6
         SZOHkmzXPTjfH3n3J6lB1M79jPvhDRPdr6ca18Vx0QvjFLQryKQxYaGqR8Gw1RSHbyiS
         24HA==
X-Forwarded-Encrypted: i=1; AHgh+RouONzNHzn1S0DTKttDwAtyA4ilKM8f3WMQK5uhic9JItN+kNa++lNZKwin1zqd6Z/tmCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQG/xe1MrRR8fh347YEqtdYHr1Xy+aqIdau9mCZvqX5h6qxo4
	oGCvL1UqKlHmrrPBBDM4weiOZauXyvxtZFndvNhSSJYHata6gV2mcRFK
X-Gm-Gg: AR+sD125NGTunBpdVUyMU5YlZ3+wm+HcMXi5BiR3KGMaWK5bLG6ItLGLBXuzKDg6zJc
	KW12iZvQ9g7MHLHp4+H1hA4tq/cRd9bv5xFC9nscsmh0o3+7znOMP43wfPEBYLeILUfKPCGjvQw
	VLo9ZS+frzAl1AtzXJA5eQkvPclt5mTSvzRoBVTB1fd7d8bHPfHQQPrDsG6ATXr6KMKVkn3GJ1J
	ZthsdTpOgN878UYbRi466A1bcre89V0foWonoiO7UdXZyp1qUQ5fv4mZRo2f8fmZ7DJH/CY7WAi
	utwMkKz0sLjIh6vAv49u0veqiVwuIcLl0IxkW8PVz8FEM8BDt5KnHTN0GYkLBsDEufgeltLbnif
	T/d91/xlOeg6hp9j1UhZJasGnTLyO6mjSoJjYNoBMdkKD/2ZChdLnJiPhFdNtUzPtH1ypMjmHS0
	E1bsmQzV8fDZcgN57YTNn9RWPH5CVLWKsQX90ZR9TzH6Eq1/FGVRJWaeOQlnXqyjbreIVycldBk
	M1YUh24NvmuzPJTXoNHEj5Hp2L5X4lE0Qj5SSpOLnn2QUZbqxPJhsy6EQKaQc+vijJEiDUJFqet
	n5i+JkwYiI7WGNclTzlTeGSLiGA=
X-Received: by 2002:a05:600c:310e:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-499821881d3mr26179715e9.1.1786595935294;
        Wed, 12 Aug 2026 21:38:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499820f5d26sm23033735e9.1.2026.08.12.21.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 21:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 06:38:54 +0200
Message-Id: <DKNJEHJWIC8Y.2QH6JE3N590FS@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [PATCH] selftests/bpf: Remove duplicate copies of the arena
 spinlock qnodes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Shuah Khan" <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260803001807.646357-1-changwoo@igalia.com>
In-Reply-To: <20260803001807.646357-1-changwoo@igalia.com>

On Mon Aug 3, 2026 at 2:18 AM CEST, Changwoo Min wrote:
> bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
> every translation unit including it emits a copy. __weak makes them all
> resolve to one instance, but bpftool gen object merges only the symbols
> and concatenates each input's .addr_space.1 bytes, leaving the surplus
> copies unreferenced in the linked object.
>
> libarena links ten such units, so nine copies were dead weight (bytes):
>
>   object                             before       after
>   -----------------------------------------------------
>   .addr_space.1 in libarena.bpf.o    676200       86376
>   libarena.skel.h                   2100123      892371
>   libarena_asan.skel.h              2641124     1466477
>
> Declare qnodes in the header and let each program define it once:
> libarena in src/common.bpf.c, and the arena_spin_lock test beside the
> lock it guards.
>
> Tested with test_progs -t arena_spin_lock and -t libarena.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---

This seems ok to me. I don't have better ideas. Emil, any thoughts?

>  .../selftests/bpf/libarena/include/bpf_arena_spin_lock.h   | 7 +------
>  tools/testing/selftests/bpf/libarena/src/common.bpf.c      | 7 +++++++
>  tools/testing/selftests/bpf/progs/arena_spin_lock.c        | 7 +++++++
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_=
lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> index ae6b72d15bb6..71d9db610263 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> @@ -103,12 +103,7 @@ struct arena_qnode {
>  #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
>  #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
>
> -/*
> - * The qnodes are marked __weak so we can define them in the header
> - * while still ensuring all compilation units use the same struct
> - * instance.
> - */
> -struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NO=
DES];
> +extern struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NO=
DES];
>
>  static inline u32 encode_tail(int cpu, int idx)
>  {
> diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/common.bpf.c
> index 50be57213dfb..06481f2a2892 100644
> --- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> @@ -8,6 +8,13 @@ const volatile u32 zero =3D 0;
>
>  struct buddy __arena buddy;
>
> +/*
> + * Storage for the queue nodes declared by bpf_arena_spin_lock.h. Each p=
rogram
> + * linking the arena spinlock provides exactly one definition, so that t=
he array
> + * is emitted once rather than once per translation unit.
> + */
> +struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
> +
>  int arena_fls(__u64 word)
>  {
>  	if (!word)
> diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/=
testing/selftests/bpf/progs/arena_spin_lock.c
> index cf7cda79c16c..92e75ec3844c 100644
> --- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> @@ -23,6 +23,13 @@ int cs_count;
>  #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CA=
ST)
>  arena_spinlock_t __arena lock;
>  int test_skip =3D 1;
> +
> +/*
> + * Storage for the queue nodes declared by bpf_arena_spin_lock.h. Each p=
rogram
> + * linking the arena spinlock provides exactly one definition; libarena'=
s lives
> + * in libarena/src/common.bpf.c.
> + */
> +struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
>  #else
>  int test_skip =3D 2;
>  #endif

