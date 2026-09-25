Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679302D63E5;
	Fri, 25 Sep 2026 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361142; cv=none; b=qvjUvEw7Rn8vDyimF6bQ1PtX78Y/CPtCSCIY05fQrr729GOyH09L97GWJTfhXurLySgCgWgZaULh+I202Qbond07V6MIP2ZIHhi+/+ihEsxjGE3cFdPD55EPjLs3nNwRVqj7Yi2TwLbyqgHSVimHOc3TjyPK6+DlhplFZQFFmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361142; c=relaxed/simple;
	bh=Z7pFavOJrEfLFkHVLkF2ggQirU7ln6iZRXVEaXbRtGA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ppWdP2SozI+IF+yLtAwmgirCdaNKda00QVftfRNgRNlBOYq84bXfgvHWH0/3yu5CA4TReszbGMxSa739EROayYefEPW+C8qcx8Y7dN1Ic9E5jvAMuBOVioGnvpL4Vtxm4Tw8ufCf2pKhKiihqC8g8jaBGneorNbl6AyWTl1RNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtf+VFOh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtf+VFOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2091F000FF;
	Fri, 25 Sep 2026 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361141;
	bh=4DKXGY4W9CJyCP2LsrBPNOjJ9OlDQDusad8clfE8tZ8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gtf+VFOh6RmrVYsP1Cbn3VuhOZun151Gqyr7/K6XdFrpJWvoBDsP9N/q63ScsYyFz
	 A2j+ya25+T5XzF0tmvjSoXxA/iKG3FZZiGKdiA2WUjcCNqQ0nhZWmLdLGv8zMtZbRX
	 IzYkjrg0uC4XxsH/tBLXhsHtKkQCmZPFFudLW3HbXde9LirFikc8lw3BHhHZ0kp/Wa
	 e2cAeGZAil8gh0qTkNa+flOIjHuU4JJdU4LW22ox6tSHWpWVPjPKLqx/qdkLTWwp7E
	 d74pn2J+yqCRzPJkdzkGF8LE1sb6tjuODlmp8cBFOMCMKi6fBrRJCoSj9GfBM4SudO
	 xCIbkqVUxw+GA==
Content-Type: multipart/mixed; boundary="===============0506911882495437760=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <06229dde91361ba3f8d3c8d5ab0350f4a66643eb72b0c3554b1c146fe8523eac@mail.kernel.org>
In-Reply-To: <20260925174402.2028649-2-hi@tychen.cc>
References: <20260925174402.2028649-2-hi@tychen.cc>
Subject: Re: [PATCH bpf-next v8 1/2] bpftool: Add recursive map dumping
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 18:32:20 +0000 (UTC)

--===============0506911882495437760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 20d59eab09a1..be338b4fbbea 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> @@ -907,21 +960,29 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
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

[ ... ]

> +	if (recursive_dump) {

[ ... ]

> +		/* Record the selected maps before discovering any inner maps. */
> +		for (i = 0; i < nb_fds; i++) {
> +			len = sizeof(info);
> +			if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
> +				p_err("can't get map info: %s", strerror(errno));
> +				err = -1;
> +				goto exit_close;
> +			}
> +			err = hashmap__add(ctx.seen, info.id, 0);
> +			if (err) {
> +				p_err("failed to record map id %u: %s", info.id,
> +				      strerror(-err));
> +				err = -1;
> +				goto exit_close;
> +			}
> +		}
> +	}

Does this pre-loop need to clear info before each bpf_map_get_info_by_fd()
call?  The kernel's bpf_map_get_info_by_fd() starts by copying the
userspace buffer, then fills in the fields:

kernel/bpf/syscall.c:bpf_map_get_info_by_fd() {
    memset(&info, 0, sizeof(info));
    if (copy_from_user(&info, uinfo, info_len))
        return -EFAULT;
    ...
    if (map->btf) {
        info.btf_id = btf_obj_id(map->btf);
        info.btf_key_type_id = map->btf_key_type_id;
        info.btf_value_type_id = map->btf_value_type_id;
    }

For maps without BTF, those three fields stay at whatever the userspace
buffer already contained.  In this loop, if fds[0] has BTF but fds[1]
doesn't, then info used for fds[1] still carries fds[0]'s BTF ids.  The
main loop below sees info->btf_value_type_id != 0 for a non-BTF map and
tries to load the wrong BTF object.

The same problem appears in the pending inner map loop:

> +	for (j = 0; !err && j < ctx.pending_cnt; j++) {
> +		int fd;
> +
> +		fd = bpf_map_get_fd_by_id_opts(ctx.pending_ids[j], &opts);
> +		if (fd < 0) {
> +			p_err("can't open inner map id %u: %s",
> +			      ctx.pending_ids[j], strerror(errno));
> +			err = -1;
> +			break;
> +		}
> +		len = sizeof(info);
> +		if (bpf_map_get_info_by_fd(fd, &info, &len)) {
> +			p_err("can't get map info: %s", strerror(errno));
> +			err = -1;
> +		} else {
> +			if (!wtr)
> +				printf("\n");
> +			err = map_dump(fd, &info, wtr, true, &ctx);
> +		}
> +		close(fd);
> +	}

Should each iteration clear info here too?  When one outer map holds both
BTF and non-BTF inner maps, or when dumping multiple selected roots that
reference different inner maps, the inner maps can have different BTF
states.  Stale btf_id, btf_key_type_id and btf_value_type_id from a
previous map cause map_dump() to select BTF formatting for a non-BTF map
and call btf__load_from_kernel_by_id() with the wrong ID.  When the
key_size or value_size also differs, btf_dumper_type() reads past the end
of the malloc(info->key_size) and alloc_value(info) buffers.

prog.c's do_dump() already does memset(&info, 0, sizeof(info)) before each
bpf_prog_get_info_by_fd().  Would the same pattern fix this?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36170286834
--===============0506911882495437760==--
