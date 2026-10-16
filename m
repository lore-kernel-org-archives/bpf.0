Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C293148B4;
	Fri, 16 Oct 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160702; cv=none; b=DGWqrajGSO2rUpEFxgWgk/VHzIL5OVCOgsWNxS7EV2SOAKkfAnkxWhZEuzpDsR4VPA4R393DLoEArya6r8aUAG3GwBxzji9l00x9aQEKVcENkzWq3DNyH4yiXWzKRs/yWStz+uQC3ZjfSIf0BST0FGbMMvHBT7b0znGUMo4HRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160702; c=relaxed/simple;
	bh=BjaG0A3KflZ2fnKglMM+nFKkPwxYCIsn9Y6W0gKdy5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+dzT7Nv1GPYL+uWb5jtRSDonk3Fn0qPMBoCUHxT33MrmaBkRGIwBf6eHUyTDt8nsuvB0MlhkYpRQplTUfH1wmOCEaWu6Fl4MiBqFzbqkVCcRn5qBDPQJ5sycZaGQxTYzboWEvHn/Lg12E1juaRHEFLp/7BxDg5ayTIpjE8WM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4rxLjkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4rxLjkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0F21F000C5;
	Fri, 16 Oct 2026 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792160701;
	bh=Bz+GxVr4dlEeQzhf+FUIQ3S+8z4o4wVUtyCodsJ/Q5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a4rxLjkURZIsI/Fd6D5pBcUhIqHG50MaciNasuiafr8h7qg2+b9L0G/YZktwVQzkD
	 kLBVchM2FcOkvQjO/E1PbHMzLrCl4VlYlIse/uRL1JBmRuuoiTBp1nwa/qH7VMaFxi
	 xhZWNUpPF/cxjsmMLUHpQOizWdtk8aJGG33dK1uyB6FUD/4l7iABQ12aGo9Q13oOJq
	 wu7wqNC24hHrSiq+Bi7CpBu5BydYWxivMuqARUleFJRAaptHqRUEU2x03dV3kXj8JX
	 xZVxOO5Ykm5wSiKdYpCNQUGm1BHV5EFjGv+KN9W157gYenDnTRtLJKD5TqTxxYSriN
	 jOaSS5Kz4Gakw==
Message-ID: <7d4d6870-7734-460a-8391-a41322d61e79@kernel.org>
Date: Fri, 16 Oct 2026 15:24:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Print verified instruction count in
 prog show
To: chenyuan_fl@163.com, bpf@vger.kernel.org
Cc: Yuan Chen <chenyuan@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mykyta Yatsenko <yatsenko@meta.com>,
 Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261016071700.280539-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261016071700.280539-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-16 15:16 UTC+0800 ~ chenyuan_fl@163.com
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> The number of instructions processed by the verifier is available
> through bpf_prog_info::verified_insns and the program's fdinfo since
> commit aba64c7da983 ("bpf: Add verified_insns to bpf_prog_info and
> fdinfo"), but bpftool does not display it, leaving no convenient way
> to check a program's verifier cost.
> 
> Print the count in the plain and JSON output of bpftool prog show,
> following the convention of the other conditional stats
> (run_time_ns, run_cnt, recursion_misses): kernels that do not fill
> the field leave it zeroed and nothing is printed.


It's different from the other conditional stats though, unless you run
bpftool on an old kernel verified_insns will show up every time. Can we
move it to another line to avoid growing the first line too much,
please? Maybe after loaded_at and uid?


> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst | 3 ++-
>  tools/bpf/bpftool/prog.c                         | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 8dbd34ef3d8b..d4a94e0737a9 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -285,7 +285,7 @@ EXAMPLES
>  
>  ::
>  
> -    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl run_time_ns 81632 run_cnt 10
> +    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl run_time_ns 81632 run_cnt 10 verified_insns 528
>              loaded_at 2017-09-29T20:11:00+0000  uid 0
>              xlated 528B  jited 370B  memlock 4096B  map_ids 10
>              pids systemd(1)
> @@ -301,6 +301,7 @@ EXAMPLES
>              "gpl_compatible": true,
>              "run_time_ns": 81632,
>              "run_cnt": 10,
> +            "verified_insns": 528,
>              "loaded_at": 1506715860,
>              "uid": 0,
>              "bytes_xlated": 528,
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index eb077236d2ea..c77e871b8859 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -441,6 +441,8 @@ static void print_prog_header_json(struct bpf_prog_info *info, int fd)
>  	}
>  	if (info->recursion_misses)
>  		jsonw_uint_field(json_wtr, "recursion_misses", info->recursion_misses);
> +	if (info->verified_insns)
> +		jsonw_uint_field(json_wtr, "verified_insns", info->verified_insns);
>  }
>  
>  static void print_prog_json(struct bpf_prog_info *info, int fd, bool orphaned)
> @@ -526,6 +528,8 @@ static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
>  		       info->run_time_ns, info->run_cnt);
>  	if (info->recursion_misses)
>  		printf(" recursion_misses %llu", info->recursion_misses);
> +	if (info->verified_insns)
> +		printf(" verified_insns %u", info->verified_insns);


Note: Moving it to another line means you should use a double space
(rather than single) at the beginning of the string.

pw-bot: cr

Thanks,
Quentin
