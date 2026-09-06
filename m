Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B54331A66;
	Sun,  6 Sep 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708566; cv=none; b=l8/KEwQdbrKlFRPGXbd2DFTubqVTz4Qj0qLMDsKOQ2yFl+wX4Yud7Xq6tiCL8BjLxAEau67xDYHDzczfTv+cE5vwZbzQ8RGIxNJ1PAr8SGlIQAiy5JGfW5OZfyXeTQt8Pma8bjFrQUIAbAeBnPhp1XDpRyeBMvQuZAb6hKWoPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708566; c=relaxed/simple;
	bh=OV/5IWe5pistXA3pi9H757XvIyzE8TuEEpfpAfTdGRY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=msSnO57gHQnUCh6vgm+pL7VMlB9rdwgsu+yJlkqKaiFj4jFRPFVyN3JS2KQpTvXTURsfk4irF1puCmze5aB9dWNgdq1K/7RODy1uaKIVgz8yPBGZMms+w3D7XL31MhgjVZIxZD8LgUJn6o4tisIg8ggp0cm9diT6FAvFHvD6qVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIdZKaX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIdZKaX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BCD1F00A3A;
	Sun,  6 Sep 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788708564;
	bh=3z6kdk9HvzCnOoTTMspLK3Wnge5NvKjkMS82ssnyvzE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QIdZKaX0Ym/iXkHIMfzigV/MF8Ip1JNSJCGewiW9pTEmMGTelB0j5zj2vqrgCi1lB
	 X2VBKcgW7LD7S3gioCxSmpur+mWaOaah36pUjmTJ35uROxhNIujSF2LewqQm3Y0DtI
	 bm8GcLF/g8SRkZITcpIWNzmvHS7D8qDAdnm3n4L7ek3hpPdCh03E87BGVu87rrnY7A
	 xffl3WzofRpWjNtuUmlcaOME/Cj7WdH6DG5HsMI7LlfULjT6dCS4/CD5NXX/pERT2U
	 yX5AgBOp+/Uqk3dV9lgzgXyYofuaEWw+vk1HlOlUYLvriKnKlEFUwVOVdVFp2NvZlU
	 3ineLUXAOxWqQ==
Content-Type: multipart/mixed; boundary="===============0986854606940610145=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c7c61d154f13c45ee2007e3162e9b36a4886e624d5bfb19fdd0793a100347d30@mail.kernel.org>
In-Reply-To: <20260906143950.848769-1-hi@tychen.cc>
References: <20260906143950.848769-1-hi@tychen.cc>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Add recursive map dumping
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com
Cc: hi@tychen.cc,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  6 Sep 2026 15:29:23 +0000 (UTC)

--===============0986854606940610145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb72414..853f775b7d52 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> @@ -745,8 +745,10 @@ static int dump_map_elem(int fd, void *key, void *value,
>  			 json_writer_t *btf_wtr)
>  {
>  	if (bpf_map_lookup_elem(fd, key, value)) {
> -		print_entry_error(map_info, key, errno);
> -		return -1;
> +		int lookup_errno = errno;
> +
> +		print_entry_error(map_info, key, lookup_errno);
> +		return -lookup_errno;
>  	}
>
>  	if (json_output) {

[ ... ]

> @@ -874,10 +928,22 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  		if (err) {
>  			if (errno == ENOENT)
>  				err = 0;
> +			else if (ctx)
> +				p_err("can't get next key for map id %u: %s",
> +				      info->id, strerror(errno));
>  			break;
>  		}
> -		if (!dump_map_elem(fd, key, value, info, btf, wtr))
> +		err = dump_map_elem(fd, key, value, info, btf, wtr);
> +		if (!err) {
>  			num_elems++;
> +			if (ctx && map_is_map_of_maps(info->type)) {
> +				err = collect_inner_map(ctx, *(__u32 *)value);
> +				if (err)
> +					break;
> +			}
> +		} else if (ctx && err != -ENOENT) {
> +			break;
> +		}
>  		prev_key = key;
>  	}

Does the 'else if (ctx && err != -ENOENT) break;' path handle all
expected lookup failures correctly?

dump_map_elem() now returns -lookup_errno instead of -1, so any
bpf_map_lookup_elem() failure other than ENOENT aborts the recursive
dump. Several map types fail every syscall lookup by design:

  * BPF_MAP_TYPE_PERF_EVENT_ARRAY / BPF_MAP_TYPE_CGROUP_ARRAY:
    bpf_fd_array_map_lookup_elem() returns -ENOTSUPP when .map_fd_sys_lookup_elem
    is not defined, and perf_event_array_map_ops does not define one.
  * BPF_MAP_TYPE_XSKMAP: xsk_map_lookup_elem_sys_only() returns -EOPNOTSUPP
    unconditionally.
  * BPF_MAP_TYPE_REUSEPORT_SOCKARRAY with value_size != 8:
    bpf_fd_reuseport_array_lookup_elem() returns -ENOSPC for every key.

print_entry_error() handles all of these, emitting '<cannot read>' or
strerror(lookup_errno), and the pre-patch loop ignored the result. So
'bpftool map dump id N' on such a map prints one error marker per entry
and exits 0.

With -r, 'bpftool map dump -r id N' on any of the map types above now
fails outright and exits nonzero where the same command without -r
succeeds. This also defeats the feature's own purpose: a PERF_EVENT_ARRAY
is a legal inner map, so recursing into a HASH_OF_MAPS/ARRAY_OF_MAPS of
PERF_EVENT_ARRAYs aborts with 'Unknown error 524' on the first inner-map
entry instead of dumping the traversal.

The new fatal handling looks intended for inner-map collection failures,
which is already handled by 'if (err) break;' on the collect_inner_map()
branch above. Could the per-entry value lookup failure keep the
pre-existing tolerant behaviour and continue rather than break?

> @@ -902,6 +970,7 @@ static int do_dump(int argc, char **argv)
>  {
>  	json_writer_t *wtr = NULL, *btf_wtr = NULL;
>  	struct bpf_map_info info = {};
> +	struct map_dump_ctx ctx = {};
>  	int nb_fds, i = 0;
>  	__u32 len = sizeof(info);
>  	int *fds = NULL;

[ ... ]

> @@ -936,7 +1032,7 @@ static int do_dump(int argc, char **argv)
>  		}
>  	}
>
> -	if (wtr && nb_fds > 1)
> +	if (wtr && (nb_fds > 1 || recursive))
>  		jsonw_start_array(wtr);	/* root array */
>  	for (i = 0; i < nb_fds; i++) {
>  		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
> @@ -944,22 +1040,28 @@ static int do_dump(int argc, char **argv)
>  			err = -1;
>  			break;
>  		}
> -		err = map_dump(fds[i], &info, wtr, nb_fds > 1);
> +		err = map_dump(fds[i], &info, wtr, nb_fds > 1 || recursive,
> +			       recursive ? &ctx : NULL);
>  		if (!wtr && i != nb_fds - 1)
>  			printf("\n");
>
>  		if (err)
>  			break;
> -		close(fds[i]);
> +		/* Keep discovered maps alive until the recursive dump is complete. */
> +		if (!recursive)
> +			close(fds[i]);
>  	}

Could the fd accumulation hit RLIMIT_NOFILE?

Under -r, every discovered inner map fd is held open until the entire
dump completes, so the number of simultaneously open fds scales with the
number of distinct maps reachable from the selected roots.

collect_inner_map() appends one fd per newly seen id and do_dump() skips
the in-loop close(), deferring all closes to exit_close. bpftool never
raises RLIMIT_NOFILE, so the inherited soft limit (commonly 1024) applies.
An ARRAY_OF_MAPS/HASH_OF_MAPS whose entries reference more distinct inner
maps than that limit makes bpf_map_get_fd_by_id_opts() fail with EMFILE,
producing 'can't open inner map id %u: Too many open files' and aborting
the dump after partial output has already been written.

max_entries for a map-of-maps is not bounded by the fd limit, so this is
reachable without any unusual privilege. Holding the fd does serve a
purpose - it pins the map so its id cannot be recycled between discovery
and dump. Could the number of concurrently held fds be bounded, or could
each discovered map be dumped as soon as it is found and closed then?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34040347400
--===============0986854606940610145==--
