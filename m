Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067A4D7D51
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160026; cv=none; b=MT4BrFH2Jq7xqgAO2lexoxpcbmy/M6yCgSEc4m0+9l3t7081kqBqlKyKFlus1SEhyK7MU4Yf6nXWxJAzkl/zBLMj6k5/twetjOjC5c7Gu+qKKFH8BikgTwyvqrLxMU3zeqFtgktKf5J5zYKXa/qQqbwon/ZbtUXW7/reXLsJK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160026; c=relaxed/simple;
	bh=MznHK4k+jXw1Q8CLiUhFRY4nSzKzfvRRwP5cLMaCGpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUFu0p5HAyOQ8i5siRf2k/Gxn8Zw1lrZ//cd7d2/PWw4osYiQfJ0JgO3RKY8/SQ081RE292YPBRzavzwa7bWsWxcagON9dSNgX9zHlxvIfpH4weXNI4mZRkddEtDfvp28KsZfHV+Z52iBhXgGb1la+empEBSlKVm4kIgwB2XiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsiYYTaj; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsiYYTaj"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6798af41644so17818d50.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792160020; x=1792764820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kicPn9pLyqUB4uQFYtxQb96ov4ppi766ZrD8qiHNydk=;
        b=UsiYYTajPusR8T/Q4eECPb30eyuYd56nZyZINtWjbZ9UYHGSkC/g/a/77BdtFbzk6M
         AyXdHR/X9pekUuCjoBQbCHclhMXFnWAAHOcTEug7CyBD8HDSgHDUeYn8bhRuIacTUc1x
         wS126bytu9oXHqfUBj/KmQwywu5ob5uFOLb8SUlbjasCX9CqeRkw3URI7FKnvkH1Sdae
         j27MyZUXEubz53QGorBSZIfomaohQ5x/7VQ9+BrawVYz8RHkgTEcn9/+EBnLKEmDRtAG
         7gnzwm2ecZgXJmsO1qmLcslPJZFRHckxxlwWuQHpD17RDHQRmGqp7uVyKEb0xdX9XReQ
         KeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160020; x=1792764820;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kicPn9pLyqUB4uQFYtxQb96ov4ppi766ZrD8qiHNydk=;
        b=Gx/5FoXH6J5mNrbZu1Bs5F4dRx21GF39gBK0g2XtE3OwSrPFOqmfMOWIkWHExxyqib
         BMtMTZ8/PRQi0DFq6c9BIcWFzMJhCRD6cHAlpW/WRyrAoserRFXmDjDN6iHTwo0ppo9J
         1efYVKqLh66spapjzHM+yMm+G4eSbG2oTv73mh/hF3VwZaPiqTKqsx2X4qfCKYrA/eKv
         XKCLRL6SsUqNxuGIxO3RaFL61+sxuQURFWKUWMowPzi25MfRaywoGql7kMrWOezC8/l7
         9SRB393cgI+Q+kTcolu5NQqy6BUd6ZEYycq5AXbf6AvM3jiqDbfUR8RocXBZZ66kouOZ
         IrPQ==
X-Gm-Message-State: AFq9FYLPoWg3h3gJwtXpeGmjYWWx86Z8aYnYXW4qcL1IP01nxfql4J+s
	dBXlkl1IzzO5HIA1gI5Mmhpgrkf7bAm1ZP1wIcd4ySuQTgOjYvjoyOs6
X-Gm-Gg: AYBFou0tsivSO8/vkQuLqbN0rp+13eOM5N4nA9bT3h/T0gyznftz7Ra+IupSjTMzubs
	K6xI5jHhrdtnneTNmMm6jo4jqLYPnVOH5iHHLFa2YJ6aViLzIIrcWJMtLgwWDFyIYPIxOOEF0uP
	owLA5Q+2yTHQwga269JsvzEMNMfCIkiyJQmWeyVMMkr7oCyi/VgwGaGDP5ax3oQ6Ibo8w2fxAzF
	eClEXkOecU5VyX+aZc/4XZGZGdY/PWjlf15pNUETSff/XCyYt9FHV+wEhVzo+JY2BMC53EB0bSL
	V9OplWFHXqW8k32l2VzIbVrUXysx2xv9vLG/+OL0cmaUa9tBQf1mrmId7ADYprnmNh48FuDSkWp
	bG603Bu2uFiLevqhTrRf1MtTvqceOAhYvsSQ646ThqZBhwEkjtiKmjoO7iZaTTrc5szIJJWtN+9
	wzdFnj/HuHdur6yu6/vQ2QJFslII15F34IWT02T2+6lfYgrm4Wk9JdYrxWlR6dut3eciJZqQ8q
X-Received: by 2002:a05:690e:168f:b0:679:8ba4:e917 with SMTP id 956f58d0204a3-6798ba4fc0emr3321211d50.99.1792160020411;
        Fri, 16 Oct 2026 07:13:40 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:1002:ecef:6e38:613d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1e408bcsm1116711d50.10.2026.10.16.07.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:13:39 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:13:39 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>, 
	Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpftool: Print verified instruction count in
 prog show
Message-ID: <atIk2wLkzW8KcyGV@zenbox>
References: <20261016071700.280539-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016071700.280539-1-chenyuan_fl@163.com>

On Fri, Oct 16, 2026 at 03:16:57PM +0800, chenyuan_fl@163.com wrote:
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
>
Reviewed-by: Justin Suess <utilityemal77@gmail.com>

This patch on it's own looks good to me.

Maybe it would be useful to print subprog count as well? Useful for
analyzing programs.

This looks like it would work to get subprog count regardless of whether
JIT was enabled.

  static __u32 prog_subprog_cnt(const struct bpf_prog_info *info)
  {
          if (info->jited_prog_len)
                  return info->nr_jited_ksyms;    /* exact, BTF or not */
          return info->nr_func_info;              /* interpreter: only BTF knows; 0 = unknown */
  }

Completely optional / don't have to include this if you don't want, just
a suggestion for another patch that could help show how many functions
are being subprog'd or inlined :)

Justin
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
>  	printf("\n");
>  }
>  
> -- 
> 2.54.0
> 
