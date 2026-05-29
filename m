Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB713B5318
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050093; cv=none; b=aoBrlydwPyZXUcn5sAzxWYVK3sBXchIOeIV0N0feh6PRApM9ByE5piKIHSQEw4jAQC2zM8QLSz/Sbrd67b/gSSj0xOh+aCer2AsD88TyJ1jaIJ5rkHH8kTuEpkm1wDTebjcVfTkFeAhaUbTEe0C3wGXliRYQP0FadURAvEGFfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050093; c=relaxed/simple;
	bh=dQyhs1fZsn/Kj7XS6vbPKgVkf7TcoUrOuf7rVqJKRnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+U4iB/eF4zH6bhBjoDW9KOvZmI6HFz553jCGSpdhbwgpMjZyVRcAsTYiEpQs5piDdm2i6ZkP6WrBtMRYQlD8D/hFqv1hQuIPFNLG8ZnvSah8CvDNNpQ1xXZQPuexI8XruIkiJ8qlZFiJi0R0OvTAM0eyKmr9xUNW5NDQIVJ1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO89S8T0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO89S8T0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66FC1F00898;
	Fri, 29 May 2026 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780050091;
	bh=rLYRQ/Oegcc4Lc3bTE17ns58tD4DsN5XMDNt6xbX3HQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UO89S8T0ySNG5+vHjJr1tq4yAtxT9SEZMJm96TIfhQ5d0yXZKOm1JChZ+noiNHGNG
	 u2PKhkQsjLo0l2Mo13kWQ0cFzQrxzXbzgcM56xtRzbgeatfSQU03yjKuV9VA2ZX1pw
	 uMtqBnppe9lWbE3O9tPZTfn6DNurH1LVM/0fLx6KJJxb1W2X8TB8Bx7WgJNDdKIWUg
	 TMwNXkFeoDY267WzcJ2Kebh94jwxSVnUKGj4dulpayVViGXKQmYuVJ1ys8vkvwwrCx
	 VbgBpeGJXYPjPgHE/dPze8zawYCoCRUGSjEWV12p3BkhH9xM0I//wr/OUi3ew75M38
	 zfjBkB3gXTZ6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] libbpf: Skip hash computation when loader
 generation failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529094119.307264-2-daniel@iogearbox.net>
References: <20260529094119.307264-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:21:31 +0000
Message-Id: <20260529102131.B66FC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unchecked `add_data()` failures lead to NULL pointer dereferen=
ces or heap buffer overflows in `bpf_gen__prog_load()` and `info_blob_bswap=
()` during endianness swapping.
--

commit 586ab83145acd4d3b6d7223bb61c05d593fe3860
Author: Daniel Borkmann <daniel@iogearbox.net>

libbpf: Skip hash computation when loader generation failed

This patch fixes a bug in bpf_gen__finish() where compute_sha_update_offset=
s()
was called on failed loader generation. It moves the hash computation inside
the !gen->error block to avoid running libbpf_sha256() over NULL buffers.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 7b95ced7bcbaf..3a6e1d53f287a 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -397,13 +397,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_pro=
gs, int nr_maps)
>  			      blob_fd_array_off(gen, i));
>  	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
>  	emit(gen, BPF_EXIT_INSN());
> -	if (OPTS_GET(gen->opts, gen_hash, false))
> -		compute_sha_update_offsets(gen);
> -
> -	pr_debug("gen: finish %s\n", errstr(gen->error));
>  	if (!gen->error) {
>  		struct gen_loader_opts *opts =3D gen->opts;
> =20
> +		if (OPTS_GET(opts, gen_hash, false))
> +			compute_sha_update_offsets(gen);
> +
>  		opts->insns =3D gen->insn_start;

[Severity: Critical]
This isn't a regression introduced by this patch, but while reviewing this
file I noticed a pre-existing issue with how generation errors are handled =
in
bpf_gen__prog_load() and info_blob_bswap().

If realloc_data_buf() fails inside add_data(), it frees gen->data_start,
sets it to NULL, sets gen->error, and add_data() returns 0.

However, bpf_gen__prog_load() doesn't check gen->error before swapping
endianness:

tools/lib/bpf/gen_loader.c:bpf_gen__prog_load() {
    ...
    insns_off =3D add_data(gen, insns, insn_cnt * sizeof(struct bpf_insn));
    ...
    if (gen->swapped_endian) {
        struct bpf_insn *insn =3D gen->data_start + insns_off;
        int i;

        for (i =3D 0; i < insn_cnt; i++, insn++)
            bpf_insn_bswap(insn);
    }
    ...
}

If add_data() failed, this evaluates to insn =3D NULL + 0. Can this cause a
NULL pointer dereference when accessing insn inside bpf_insn_bswap()?

Furthermore, if gen->error was previously set (e.g., from a failed
realloc_insn_buf) while gen->data_start is non-NULL, add_data() still retur=
ns
0.=20

Since the loop evaluates insn =3D gen->data_start + 0, can this overwrite t=
he
beginning of gen->data_start and write past the end of the buffer if it is
smaller than insn_cnt * sizeof(struct bpf_insn)?

Could we add a check for gen->error before proceeding with the endianness
swapping?

>  		opts->insns_sz =3D gen->insn_cur - gen->insn_start;
>  		opts->data =3D gen->data_start;
> @@ -418,6 +417,7 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs=
, int nr_maps)
>  				bpf_insn_bswap(insn++);
>  		}
>  	}
> +	pr_debug("gen: finish %s\n", errstr(gen->error));
>  	return gen->error;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529094119.3072=
64-1-daniel@iogearbox.net?part=3D2
