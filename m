Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8FC3EE1F8
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458354; cv=none; b=seJdp0pCb21FbiNINkBcgX5HBXPrzTWe/FtgAn/AAE2QzZik4xSj2s14u/VGlOvQBFUx5E3Nmqos8gW08YEEfNbDgZyEzIFvPxuxWgfQ8QKanOsF3iseAubM0eCXWJJ5YesXQ8vYmUXgJOGS2W8p7MM7OP0SCCVG6wdJM2OMY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458354; c=relaxed/simple;
	bh=2iWKgdjnY/WKT1NRrSPFsVEZgqb3q8rtw1j3YXKRPfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVgzuFA+TOEKklSNXgzwwYKk9IXvTlYwUpaNPMyHYJ+nVch8E7uTksFxA9V94f/sR3DhClntkTUNDmEEEi0+5ICv/Ff6Wove5VJGmSCnQX96wlvLzGp/4S8hfnVgMaqzQl5Vl5JTLGqIOIZeAw9wh1AvoFTZhoMPIVM2Nw3vCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC4yXMux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC4yXMux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E121F0089C
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791458352;
	bh=NZcC7/xg5SS/eaNUvNNF7JTQ0EBiXnoG/PlgqRlweyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nC4yXMuxmMjU60Le+2fG+FqvSiQ7rKPZNcghMiB9i2JnmXYHvWr8CHGKo+cUg3eyC
	 tyz9yAp6jv7crdC0S35QVoCksEC9JaXnDlY8BJ92Nf36FysG12iKwvFwx8xsakSXKy
	 hHhua4yCU8H6sT3Xu229n9WyhY6PlU5iQcUSNzEwcKrCe/nMCecXfR8WB5n6dvNo6f
	 h8epILmsasVrPcPpm7tSqZOm0INZWaRL80oyengNFl01gcPbbCiOhUsXqei+Xm4juT
	 P43mQ9wQ4SqKMvX/hVwh7JPj7Cu8DxPF4NEFqi6yryVN3JWVxwD8OLfJSS7Q5cMgL0
	 ipSoSLdzkMJ/g==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e76469b93so281815985a.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 04:19:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwg+AemUxPNntAVpA+oSNscUzGuiciU1tEATSsTqL7pAOZqdnTNgZV6jwVaO4SgVXy4Gyo=@vger.kernel.org
X-Gm-Message-State: AFuF++m9nIBm35gt/cr6gqvsx5vSycDEuW0AmtnnJf+RhekR7b8s9iPy
	YCBP2Y938rAl/NLPoFjQVJRCWVN0iC/Bg+ZD3mEApM1RFj99WDKSWdh/U0zdlR1ubyhKSNYj82h
	xYjC1JIESjEPtLv6KPH72E0Kd7NC/GRM=
X-Received: by 2002:a05:620a:4709:b0:939:761c:4f59 with SMTP id
 af79cd13be357-93e9b76c78amr924707585a.16.1791458351308; Thu, 08 Oct 2026
 04:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008070928.113530-1-hui.zhu@linux.dev>
In-Reply-To: <20261008070928.113530-1-hui.zhu@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Thu, 8 Oct 2026 19:19:00 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wW=XXe6=1GucvA1pUSkhLCosJh+bc0-97cYGGWW=MtPw@mail.gmail.com>
X-Gm-Features: AclHuK9Y4gxfKhBzGtl0K9V-EYLUU5MKewRW9HUXdq9571fi07WGLf_34qgAkY8
Message-ID: <CAGsJ_4wW=XXe6=1GucvA1pUSkhLCosJh+bc0-97cYGGWW=MtPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add bpf_proactive_reclaim test
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:10=E2=80=AFPM Hui Zhu <hui.zhu@linux.dev> wrote:
>
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> bpf_proactive_reclaim() performs one bounded reclaim pass per call and,
> unlike a write to memory.reclaim, does not retry until the goal is
> reached.
>
> Charge 32 MiB of page cache to a cgroup, ask for all of it in one call,
> and check that the result is positive but well below the request: one
> pass is capped at MEMCG_CHARGE_BATCH pages, far short of 32 MiB on both
> 4K and 64K page kernels.
>
> The test deliberately covers only the kfunc itself. A full example of
> the intended asynchronous use, where a BPF program watches one cgroup's
> workingset refaults and reclaims another one from bpf_wq callbacks, is
> maintained out of tree at [1], released under GPLv2.
>
> Add CONFIG_MEMCG to the config fragment, without which mm/bpf_memcontrol.=
c
> is not built at all.
>
> [1] https://github.com/teawater/memcg-async-reclaim
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
[...]

> +
> +       /*
> +        * Both candidate directories can be tmpfs (initramfs-based CI, f=
or
> +        * instance). That is an environment limitation, not a test failu=
re.
> +        */
> +       dir =3D workload_dir();
> +       if (!dir) {
> +               test__skip();
> +               return;
> +       }
> +
> +       snprintf(data_file, sizeof(data_file),
> +                "%s/memcg_proactive_reclaim_XXXXXX", dir);
> +       data_fd =3D mkstemp(data_file);

If we can't write to the directory, will `mkstemp()` fail?
Should we check `access(dir, W_OK)` first?

> +       if (!ASSERT_GE(data_fd, 0, "mkstemp"))
> +               return;
> +

Best Regards
Barry
