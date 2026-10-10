Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C6364927
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644932; cv=none; b=Xpv6bpa7BCbRkRKfFy4nkzX8pVyOORyYvNr7NfupR6bKfY63MZ4gUAPmqjH2slftGsU+7Re8ALl4EdydlNHcULqDV58EzgQ0NtkPXwdFa8xNYptZ5VlTjFAdA47BTWHBS4kR+ZlhXE/Dj8H9Z6l+V4zsndIlz4k7uA+9L4Ngx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644932; c=relaxed/simple;
	bh=qFvCp69MA6ATmyRUIxjDlMiYwkPSFx0MslAORicGbU0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oM5o3OSINDLrDYYCvH/4o0HLeW7S0Emk6DcoSwlaYUgnwbZa+xi8XKu4QDe7zs/GdcMaRu0E6MmMv91pWAzMp92ELwsuhcpDe4UxjnzyEKEeoNkzo5ERHf+u01+iRj2mEApqvakpDp5Riw0bh0LgS0bLiA943+XjDelr4jrtzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWShqzE/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWShqzE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E151F000FF;
	Sat, 10 Oct 2026 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791644931;
	bh=d+b3PnSgW5837uDU+SvEhPa+UftDDhASZcFUd3ZfXJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWShqzE/Xku5f8t0qIa7Sk6uSHphbPsFDDAuTDwCLrX2j4RfkELW1Si5J96/N244e
	 rwrBWe3hCAaiuUrW5R6gPGWt8xow0OK4VLuapKcOcFqmwZVBBkyS3upeT+0G5i94Li
	 8F2l/om4aJl32zv1Boj7F0ntNMtvg5dpzqeIjAtEGVoyYQ2YCp5k4TBf1OTHf7u/t1
	 heOZk6eZ7RaNKxuwsLmoywNQ1KznXBQ4Xvc3ANClTZzPM05Oy2dO6+iJ8eq8KSkmgi
	 uLIysimq2ngsXdWsIisyl6PgcXZP6Q+aqvJd0n1MQ3VDxhhFyW8JSL5NXuzDgU3UGp
	 I7BSlCfRhwhsA==
Message-ID: <sashiko-outbox-166685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 7/7] selftests/bpf: Convert veristat to
 BPF_PROG_LOAD_STRATEGY_MANUAL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261010143156.379864-8-andrey.grodzovsky@crowdstrike.com>
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
 <20261010143156.379864-8-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 15:08:50 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: veristat uninitialized memory read of log buffer on early l=
oad failure
- [Low] bpf: veristat skips cleanup and info retrieval when BPF program fd =
is 0
--

commit 9ac34aec88e7eee9b39c53e8055bc5989345ce5b
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL

This commit updates the veristat utility to verify programs using
BPF_PROG_LOAD_STRATEGY_MANUAL alongside bpf_program__load() and
bpf_program__unload(). It replaces the previous use of bpf_program__clone(),
ensuring RODATA maps are properly bound during verification and subsequently
dropped upon unload.

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 9cfc9b4b41c12..0cd19b59037f6 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
[ ... ]
> @@ -1726,18 +1725,15 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>  	if (env.force_reg_invariants)
>  		bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANTS);
> =20
> -	opts.log_buf =3D buf;
> -	opts.log_size =3D buf_sz;
> -	opts.log_level =3D log_level;
> +	bpf_program__set_log_buf(prog, buf, buf_sz);
> +	bpf_program__set_log_level(prog, log_level);
> =20
>  	cgroup_err =3D reset_stat_cgroup();
>  	mem_peak_a =3D cgroup_memory_peak();
> -	fd =3D bpf_program__clone(prog, &opts);
> -	if (fd < 0) {
> -		err =3D fd;
> -		if (env.verbose)
> -			fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
> -	}
> +	err =3D bpf_program__load(prog);

[Severity: Medium]
If bpf_program__load() returns an early error (e.g. from libbpf without
calling the kernel), could the dynamically allocated buf remain
uninitialized?

When env.verbose or env.top_src_lines > 0 is set, buf is allocated
via malloc() but the fallback initialization only null-terminates the
static array:

	if (env.verbose || env.top_src_lines > 0) {
		buf =3D malloc(buf_sz);
	...
	verif_log_buf[0] =3D '\0';

If bpf_program__load() returns early without modifying the buffer,
parse_verif_log(buf, ...) will read this uninitialized memory. Could
buf[0] =3D '\0' be set directly on buf before loading?

> +	fd =3D err =3D=3D 0 ? bpf_program__fd(prog) : -1;

[Severity: Low]
If standard input is closed, can bpf_program__load() assign file descriptor
0 to the loaded program?

If fd 0 is assigned, later checks will explicitly skip handling it:

	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=3D 0)

This causes the program's JIT statistics to be skipped. Should this check
test for fd >=3D 0 instead of fd > 0?

> +	if (err && env.verbose)
> +		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
>  	mem_peak_b =3D cgroup_memory_peak();
>  	if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
>  		mem_peak =3D mem_peak_b - mem_peak_a;
[ ... ]
> @@ -1774,7 +1770,7 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>  	if (verif_log_buf !=3D buf)
>  		free(buf);
>  	if (fd > 0)
> -		close(fd);
> +		bpf_program__unload(prog);

[Severity: Low]
Similar to the issue above, if fd is 0, will this prevent the program from
being immediately unloaded and leave it in the kernel until the entire
BPF object is closed?

Should this check also use if (fd >=3D 0) to ensure cleanup occurs?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010143156.3798=
64-1-andrey.grodzovsky@crowdstrike.com?part=3D7
