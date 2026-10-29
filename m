Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313931;
	b=2USpv5+GHBoI68facHkKveTNjtHi4B6whGHzLGkjUPhJ25TFBBtDbGQtvZCbiFnIq9y0
	 jXGqIr6kAR1+NTy9GIvq63rX72kqtmi8jyoodClSi6kK/p/4vKIcD62FPsW8iG1KYMa1J
	 JpfIx1x0Atug4yuB3MH5LyK/nRCcRDjz+B4Xb03R3DNqbgP2jQW/gqOA/t/Y3EFA1fNNB
	 dp8siMIA5A4uz0VrvynxZAd8bnsGpxEnx9jWJgMNeSw4rlp27wG7ND0vn0RM9qUhya89K
	 GvUqJhG/k6r+6gEKrh7grmB+QMFS/ILYbo7R/5bvDv7/akFysE4Dcz484LgNhx4Jf7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313931;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AaDgtL10FZWHfgxoGHPhD0+OZpkflwZQizDAnx44jY4=;
	b=i31WK4Tt/RMRBTAEMO3GYR9JFtxycHwR9kFr5GYnwRbg6XidYzi0PuY1Sn9cQ0ZETdxR
	 WlQzLdyDt/1vUsNg14Or4I/9rPaf8BY0YDTWgkGbXxB4KInr2X5jCkH1T3VQ41kECcgk+
	 MBTe6wtOY9hq8RS8MivWhdCQfx7CrFfEzMIMaC1MvqOegZT2859ytxZXLiY0e4RIhkcsY
	 LZ9srlcflGn6gFSsFOnxV9V365R/Anducw1e8YwWpSZQs8I7cvPaZduuAB4wwOSABLcGk
	 dLy48YGoUco9M7ttTSTi9PNCK0sA8N9PVRbdirJPBNZyYNFyhOU74GBTJWTqrhnwu9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij2PnseZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECE606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij2PnseZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DD41F01816;
	Thu, 29 Oct 2026 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313930;
	bh=AaDgtL10FZWHfgxoGHPhD0+OZpkflwZQizDAnx44jY4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ij2PnseZTo0dc7T1axNXf0eXz9CTw3EX4kTOozIswJ5niAitgxnm2V8Rd+ER9R45z
	 zAYFVba50kT3WyXg3sIumiINT28EUiLSd5ui0TYSVbucPNnZUuanz1DZ4pABiqRRdC
	 4/KPnAvZ4HR2l+VW8FF5FKwwPhytf1VkjtW1kfEr740UV+hGydQFqPYPZCyg4hk0EK
	 Pgff6wgj0FZTkSuMduQptNFjm6K4fv91Dwy1ov/1HUzm7FjgQd2BPeIV5kPnXquCwO
	 kyZb5QECOkhiepgOadD5zAcXSOI0OFEhUZb3Rqji8yhpdnTYVnvr1ZwAqdsgAqPB/y
	 8LHa8T+fytXcQ==
Message-ID: <sashiko-outbox-190102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 7/7] selftests/bpf: Convert veristat to
 BPF_PROG_LOAD_STRATEGY_MANUAL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org
In-Reply-To: <20261029223348.3730738-8-andrey.grodzovsky@crowdstrike.com>
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
 <20261029223348.3730738-8-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:45:30 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: uninitialized log buffer in veristat process_prog=
()
--

commit fdd973586d17be0beb9ecafccb03a9c1c652febc
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL

This patch converts veristat from using bpf_program__clone() to
BPF_PROG_LOAD_STRATEGY_MANUAL with bpf_program__load() and
bpf_program__unload() so that RODATA maps are bound during program
verification. It also adds a test case in test_struct_ops_arena.c covering
manual program loading.

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 9cfc9b4b41c12..0cd19b59037f6 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1678,7 +1678,6 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>  	const char *base_filename =3D basename(strdupa(filename));
>  	const char *prog_name =3D bpf_program__name(prog);
>  	long mem_peak_a, mem_peak_b, mem_peak =3D -1;
> -	LIBBPF_OPTS(bpf_prog_load_opts, opts);
>  	char *buf;
>  	int buf_sz, log_level;
>  	struct verif_stats *stats;
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
> +	fd =3D err =3D=3D 0 ? bpf_program__fd(prog) : -1;
> +	if (err && env.verbose)
> +		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);

[Severity: Medium]
Can bpf_program__load(prog) read uninitialized heap memory or over-read buf
when veristat is run with -v or --top-src-lines?

In tools/testing/selftests/bpf/veristat.c:process_prog(), when env.verbose =
or
env.top_src_lines > 0 is set, buf is allocated with malloc(buf_sz), but only
verif_log_buf[0] is initialized to '\0':

	if (env.verbose || env.top_src_lines > 0) {
		buf_sz =3D env.log_size ? env.log_size : max_verifier_log_size();
		buf =3D malloc(buf_sz);
		if (!buf)
			return -ENOMEM;
		...
	} else {
		buf =3D verif_log_buf;
		buf_sz =3D sizeof(verif_log_buf);
		...
	}
	verif_log_buf[0] =3D '\0';

Previously, bpf_program__clone() did not inspect buf in userspace, and
parse_verif_log() later set buf[buf_sz - 1] =3D '\0' before calling strlen(=
buf).

With bpf_program__set_log_buf(prog, buf, buf_sz) and bpf_program__load(prog=
),
if program loading fails before the kernel verifier writes to the log buffer
(for example, an early check in bpf_prog_load() before bpf_check() emits any
verifier log), bpf_program__load() -> bpf_object_load_prog() calls
fixup_verifier_log() in tools/lib/bpf/libbpf.c:

	/* post-process verifier log to improve error descriptions */
	fixup_verifier_log(prog, log_buf, log_buf_size);

which immediately calls strlen(buf) on the uninitialized heap buffer:

	if (!buf)
		return;

	log_sz =3D strlen(buf) + 1;

In addition, if bpf_object__prepare() or bpf_program__load() fails without
writing to buf, parse_verif_log(), printf(), and print_top_src_lines() in
process_prog() will read uninitialized or stale log contents from a previous
program's freed buffer, and freeing buf at the end of process_prog() leaves
prog->log_buf pointing to freed memory.

Should process_prog() initialize buf[0] =3D '\0' (and buf[buf_sz - 1] =3D '=
\0')
instead of verif_log_buf[0] =3D '\0', and clear the log buffer on prog befo=
re
freeing buf?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029223348.3730=
738-1-andrey.grodzovsky@crowdstrike.com?part=3D7
