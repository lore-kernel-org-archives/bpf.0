Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25F221FB4;
	Sat,  3 Oct 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059234; cv=none; b=peXdT6R6gFNVdAO2Dk5wJe9ejikd87PR2a67hp3qjP1K00JyaH+Qr+FHM+NxO3A5IGjPRg6j81IjRovggnymsfkzTrZTjfG1HyGkgK6nMcUYkBsdEQuKnxVzUXQpeNj9AltIx2VGcaSlqNXLVbJ+qAMSVgEQk/wEyySEIdVDVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059234; c=relaxed/simple;
	bh=+dD832sbF2SHlArforF89aT+7NfY16uOn2jqHtx8Lxc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gqDKw375/qnBKdHn0wyGJftKD7zvLGokYzRmZ9Fj6Uz0zHnQ4s+qE2qTRY+tB/+ciOSti8H/qJ9fMqqa+3ef5hYa5tkYQuU89xYUG1796GtedYnRuf8sxdzexuGUsDEMCPeils0fvuHG1GXMcYKnMHQ9gt7aQPuhAUafTzJTFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d91y8msC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d91y8msC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FE21F0089B;
	Sat,  3 Oct 2026 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791059233;
	bh=S9iiOowmd4Ohz/z9sZh+/ZRxOTBmpsHoWaUVXw8AO7E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d91y8msC6pPHUbsNbBiJ75mW5O6kkWfFR0KCY3BTQowl6j1UssPW+lkzNohdWvMZy
	 vRKHOkD5xM6O49YW3rakUy1MZBrHHKNWhCFtoPIlZ891uOC3kJura69VIMhPmVhkkK
	 6SS6eWGTJeGbSjpEM9USy14PaKHfSCAtPyx8hirPxiKsdtakNVOyWp9Q0QYKBU8/fq
	 VpoJ35dqyy50UxHanQSvi0EsaYh5Rz3TAxD1Kov6H+T3rp1//Mv1PEIGv+Cv9/7cmJ
	 vtCHUcPmCq99bpXE/7FZUGpee7M/KjCd64a81/iNQXXHMsf6GUi1DPoxjwMAV5R1RY
	 qq5VLr7SpC51g==
Content-Type: multipart/mixed; boundary="===============9077155915361011397=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56cb8412ae0f25a42289986ef6005a01b17dcc487692d9d21ae6de977eaee66e@mail.kernel.org>
In-Reply-To: <20261003194323.817885-2-alan.maguire@oracle.com>
References: <20261003194323.817885-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 1/7] resolve_btfids: Build separate main and inline BTF objects
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com
Cc: jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,nathan@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,arnaldo.melo@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 20:27:10 +0000 (UTC)

--===============9077155915361011397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Build separate main and inline BTF objects

TL;DR: In resolve_btfids --inline, extract_inline_btf() may free a base BTF
that the new main BTF still points to, causing a possible use-after-free for
modules with .BTF.base; in-tree builds seem unaffected.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 37d7e7224207..dcd289d16faf 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -1510,6 +1569,85 @@ static int btf2btf(struct object *obj)
>  	return err;
>  }
>

[ ... ]

> +static int extract_inline_btf(struct object *obj)
> +{
> +	struct btf *btf = obj->btf, *main_btf, *inline_btf;
> +	__u32 type_cnt = btf__type_cnt(btf);
> +	__u8 *colors;
> +	int err;
> +
> +	colors = calloc(type_cnt, sizeof(*colors));
> +	if (!colors)
> +		return -ENOMEM;
> +	err = color_btf(obj, colors);
> +	if (err)
> +		goto out;
> +	err = btf_split_by_color(btf, colors, &main_btf, &inline_btf);
> +	if (!err) {
> +		obj->btf = main_btf;
> +		obj->inline_btf = inline_btf;
> +		btf__free(btf);
                 ^^^^

Can this btf__free(btf) free a base BTF that the new obj->btf still points
to?

btf_split_by_color() creates main_btf with .base_btf set to
btf__base_btf(src), and btf_new_empty() stores that pointer without taking
ownership.  btf__free() on the source also frees its base when the source
owns it:

    if (btf->owns_base)
        btf__free(btf->base_btf);

libbpf sets owns_base in btf_parse_elf() when the ELF passed to
btf__parse_split() has a .BTF.base section and no base_btf was given.

This looks reachable with "resolve_btfids --inline mod.ko" (no --btf_base,
no --btf) on an out-of-tree module that already has .BTF, .BTF.base and
.BTF_ids:

load_btf()
  btf__parse_split(obj->path, NULL)
    owns_base = true, obj->base_btf stays NULL
finalize_btf()
  distill is skipped because obj->base_btf is NULL
  sort_btf_by_name()
  extract_inline_btf()
    btf__free(btf)
      also frees the distilled base that main_btf->base_btf points to
main()
  symbols_resolve()
    btf__type_by_id(obj->btf, ...)
      btf_type_by_id(btf->base_btf, type_id)
        reads freed memory

Without --inline the same command works, because obj->btf keeps owning its
base until main() frees it.

The in-tree build does not appear to be affected, since gen-btf.sh passes a
raw --btf file together with --btf_base, which leaves owns_base false.  I did
not find a fix for this later in the series.

Should extract_inline_btf() keep the original BTF alive, for example in a
field of struct object that main() frees after obj->btf?  Alternatively,
could it reject or handle the case where btf__base_btf(obj->btf) is set but
obj->base_btf is NULL?

> +	}
> +out:
> +	free(colors);
> +	return err;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37149955093
--===============9077155915361011397==--
