Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5A4854F7
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595248; cv=none; b=cyE+3KopzfxbCO3tifTXo7La8GyKG7Nsh7Z5D/7hJFLJxoQ5NGtcoZ10gky0iMmJMNwKpmx5osIBnSxo8DC9on6YZpS6nLu6LYidcz7vzEGtZlAZHpwVKpBMQin/wdKODv88F5P7XEplV6dNM8IwBC+mpTeZx9533X6D02JjGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595248; c=relaxed/simple;
	bh=V8ZbCGo3t3R0JpWi3Ir4JSR29RrX8tyMEPqFfTcJaiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKQCgJ7OSAqo+4RTM+kwiqlRlkXztMUR40/BNiqPa3WvLROT0Lk7FA4EbwgJoUNRFNi0WCEwqiV7tMhOVmgEFSa4l/9yCa6s/fe8TL09gCb+vMXPHv6SZ8X7ast67Q8UB4r/paumDfkPa9DXZqv1k+21T+LIZTGQuuWv0gBYCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7K1cXJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7K1cXJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4061F00899
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595236;
	bh=BKgCCFGN6jBwDhfi6TCpAdpQqIHyfoSi+GJbRxa4SOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i7K1cXJAiZ42c3Y67CoPxg3ZTvOcNb1Ho/Q0n9wc76vc42OnAbKKl0BYyoOFkQIub
	 tB9wfV5LOiJ/WCbQSDLU36bUjw1Fq7cK3sVbsi+mkCCl/B24e+XoqQYtVlHlcAPLfm
	 /0JVJ2HgO5ZjtBpDPTKS06H27OhOTmyjaQZ0IcKb7YDwZCWr27DsAHT1oreBUYxeWK
	 Ym27jQwg3P2+dGSTb/3hsVVTWhZfQjv9xXVtnLiFRPXdlGP69RHp5Dn1wWHOOD541X
	 QkLARJrJ5roWoLwUv5E94qQsZNI+Ej5efe9XjMJ0+IK5LBzk9Z+khff+kBHfg+LxHv
	 G5dbOO4YBiXhg==
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109f067fso14308685a.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:47:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzGBjnEIsiFdwTVY0CIuBmhS0mk8I5J2CAO7TVN0SY50RyD3tr6PwBZBcV7QV+7a6eOQvE=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ3pkQZfgq2inVA3IAxQGOdtN5J8RV9vdWy3z89t70WQy5dJvp
	ZMxS0HEbxY6X6LBfDAS96uUn9r1rwkselGb6f21mpm6qO/cAqUM53qA0w8GjyQoD967AsdgHFTB
	gG+Uro9N2JypxqbAAK9K4YpfDHmBWRrc=
X-Received: by 2002:a05:620a:2312:10b0:93b:c07d:a6bb with SMTP id
 af79cd13be357-93bc07db157mr388003585a.16.1789595235708; Wed, 16 Sep 2026
 14:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789475073.git.zhuhui@kylinos.cn> <ee6bcf945910babab2200f05040975492aed21b3.1789475073.git.zhuhui@kylinos.cn>
In-Reply-To: <ee6bcf945910babab2200f05040975492aed21b3.1789475073.git.zhuhui@kylinos.cn>
From: Barry Song <baohua@kernel.org>
Date: Thu, 17 Sep 2026 05:47:04 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wggMLKcxwtDhzPS-P2sF_NyqL8tsKKnP1jdk04aCECAg@mail.gmail.com>
X-Gm-Features: AcwNN1X8tj6qrT264I7u0puPG663sCANci7__uZPqHwmsLy7UyUcS1gzMfRwgL0
Message-ID: <CAGsJ_4wggMLKcxwtDhzPS-P2sF_NyqL8tsKKnP1jdk04aCECAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 8:30=E2=80=AFPM Hui Zhu <hui.zhu@linux.dev> wrote:
[...]
>  /**
> @@ -159,6 +161,47 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct m=
em_cgroup *memcg)
>         mem_cgroup_flush_stats(memcg);
>  }
>
> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory cgro=
up
> + * @memcg: the target memory cgroup to reclaim from
> + * @size: the amount of memory to reclaim, in bytes, clamped to
> + *        MEMCG_CHARGE_BATCH
> + * @swappiness: the reclaim swappiness, in the range [MIN_SWAPPINESS,
> + *              SWAPPINESS_ANON_ONLY], or -1 to use the memcg's own

I assume you missed the word "swappiness" here: "use the memcg's own
swappiness".

Best Regards
Barry
