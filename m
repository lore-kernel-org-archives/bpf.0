Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2349309EE9;
	Fri, 25 Sep 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335602; cv=none; b=j830QPiX6CiLZe7yELi6DC+hQf0EHreJPSKhshwwu6na1mLJFWAhZInoOxHAPFmcDTQbuDbmsnQqUicxpev9oD8Kb22xitlrJ6gPecB5wHeJfBOEKBk3GPkuNsfZzNjGeuyt3ZjdoXkuRVvb/5f4Fs0rdPeH8xa4P4KT29eimPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335602; c=relaxed/simple;
	bh=D7Yvy4hNrY/p1Hhz1gzNBL+rTfVomawQy02wANoCHM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCzcRCh8WFqA1vjVpKFeHcN7X50bwBnUUW7VZViZIGlVj/F+puee4vO4sKLj6tg3VKsgii6pMg+LrwYdQeRwQnyKnnc7ZdQXF+wX/9WYk4/Gc8ZZ3UKtDS9Ml2pKULJibYJPFB/0/ayNPaJn6/TGn5xHcBLdvg/FoHX7/EoNl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1H/qz8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1H/qz8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B271F000FF;
	Fri, 25 Sep 2026 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790335600;
	bh=hcMpStTWjEU8CeTeasF3QtRDkd+276WFSNQ1pxkbh/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=X1H/qz8JlUwVh29IWCGEsrl57BgyoX6S4Ai5bARkRgwmjRk8xZw2UythD5y8pE7YJ
	 QZHFr2PwS7NMdMsx0CXP2AtYAsjF/iBJwgjWnDErKZpIJXl8pm1LxawlwdHoZK2Ya/
	 axusHLwH6xM4rJWx0NbOp6+MT6qTWgqTiGc7n2h6hhivXsrS7CGHYxqoR3D7fmLgou
	 luoU0VURgHv3/y+fzWi3OQ7bEowsoSKabvQmikc8ivQsseYTbfSW0XFx0GvUNuL/Q7
	 aXNap0L+cJzq+o9Ci/ulzg/leTnfI741K/jXf2vQVJap6+Dc35CdR7rfbsf1g80lFd
	 Eqm1ha7Eb6SCA==
Message-ID: <6ed88738-4e3b-407c-90c2-bf7717f3e653@kernel.org>
Date: Fri, 25 Sep 2026 12:26:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 1/2] bpftool: Add recursive map dumping
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260924161434.95116-1-hi@tychen.cc>
 <20260924161434.95116-2-hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260924161434.95116-2-hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-25 01:14 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Dumping a map-of-maps currently shows inner map IDs without their
> contents. Add a recursive keyword to map dump to include referenced
> inner maps, leaving the default output unchanged. Show selected maps
> followed by distinct inner maps, preserving plain and BTF formatting
> and using an array of map objects for JSON output.
> 
> Holding every discovered inner-map FD open would make descriptor use
> grow with the number of maps and could exhaust RLIMIT_NOFILE. Keep the
> selected map FDs open, queue distinct inner map IDs, and open, dump and
> close each queued map in turn. This needs only one additional map FD.
> The tradeoff is deferred ID resolution: concurrently removed inner
> maps can disappear before they are opened, so the dump is not atomic.
> 
> Report failure when an inner map cannot be opened, retain per-entry
> lookup errors, and close JSON containers before returning.
> 
> Link: https://github.com/libbpf/bpftool/issues/58
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 20d59eab09a1..ef47de7da200 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

> @@ -907,21 +960,37 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  	free(value);
>  	free(cpu_ids);
>  	free_map_kv_btf(btf);
> +	if (plain_btf_wtr)
> +		jsonw_destroy(&plain_btf_wtr);
>  
>  	return err;
>  }
>  
>  static int do_dump(int argc, char **argv)
>  {
> +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts,
> +		    .open_flags = BPF_F_RDONLY,
> +	);
>  	json_writer_t *wtr = NULL, *btf_wtr = NULL;
>  	struct bpf_map_info info = {};
> +	struct map_dump_ctx ctx = {};
> +	bool recursive_dump = false;
>  	int nb_fds, i = 0;
>  	__u32 len = sizeof(info);
>  	int *fds = NULL;
>  	int err = -1;
> +	size_t j;
>  
> -	if (argc != 2)
> +	if (argc != 2 && argc != 3)
>  		usage();
> +	if (argc == 3) {
> +		if (!*argv[2] || !is_prefix(argv[2], "recursive")) {
> +			p_err("expected 'recursive', got: '%s'", argv[2]);
> +			return -1;
> +		}
> +		recursive_dump = true;
> +		argc--;
> +	}


If we put the keyword first, we'll get a confusing message:

    # bpftool map dump recursive id 1337
    Error: expected 'recursive', got: '1337'

Can we align it with what most other subcommands in bpftool do, please?

	if (!REQ_ARGS(2))
		return -1;

	fds = malloc(sizeof(int));
	if (!fds) {
		p_err("mem alloc failed");
		return -1;
	}
	nb_fds = map_parse_fds(&argc, &argv, &fds, BPF_F_RDONLY);
	if (nb_fds < 1)
		goto exit_free;

	while (argc > 0) {
		if (is_prefix(*argv, "recursive")) {
			NEXT_ARG();
			recursive_dump = true;
		} else {
			p_err("expected 'recursive', got: '%s'", *argv);
			goto exit_free;
		}
	}

The rest looks good, thank you.

Quentin
