Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C53932EE
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541597; cv=none; b=ukztz2+tfIQSfff1a+zaGpgMM4RXfAhe+c5Ny5ziyJyHQBB7J1WpG6a1gfj5TIzb9m/lD7cWBF0em/s7bD9pyYVkoL+3TcdUePpdeUB3t5TVB5rRfVJ7NnI3acSF0/M4wuYo9WoST+UHX6qX1524Ztp72yGpVKtZVVOzl9tV6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541597; c=relaxed/simple;
	bh=r06YoeAgAw6bvDQi5QDWDIfaJAYvvKJCxVFbYdIDDBo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aymMzRJwm9k6bB9oc9C3guU7AdeBJ/Eo6wDvm0irU5Sn6ALiO3jMrziOwPCjWhDo/KFNiD56K4ry+XV7O46mV4eSrJ1aeP+APtEMVQEVCy/Q93XPaTru7IfMClTrzsWFzMFyiD5FRE6WeLPTtI78UE340Ux4l9yhRhwxxcx0ttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/4FP1xS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/4FP1xS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CB81F000FF;
	Sun, 27 Sep 2026 20:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541595;
	bh=5S0y1ihDtFp0zVX5kGmUi0Xl2mq6/lRx3q4Y/55fyj8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f/4FP1xShO0U5sOlozSPpnTeQ+6vNjRfgWjCYwWpEwVJBKvSBATaP+JiWXgqnyVfv
	 j7hU3BCG7546GgUeKIk3Q8yhGqPsL9Ch1Q+c6d+NPjuZTE34iG90KNrdXfotXA6i+Z
	 iTEUq/kSGqAaOLKmcNtLIHKURnNlCi14+gUDR1FBetDTERyj+jvoJwC4fkxPgCecUV
	 C+mUDPIdwPlxUGHbpWy4XgqR/e7hmDjy+aP37jHNZ8dg7h70dpsLuak/tUsTLokLt6
	 dtvuBSy2jNaLNZAAcg+N3D7MZLraO4Lmebz8hYwbdFjMTfRvsz6Y3wJdW1QtOgdZyv
	 GuXhN7YOm8/ww==
Content-Type: multipart/mixed; boundary="===============8715775116836626608=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b553c5ab29803b0aa25087a5a5b0e1d15bfce01166bfa8e97aad8e704cce09f@mail.kernel.org>
In-Reply-To: <20260926050123.2220977-1-yonghong.song@linux.dev>
References: <20260926050123.2220977-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 15/21] libbpf: Collect .bpf_cleanup records and pass them to the kernel
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:39:55 +0000 (UTC)

--===============8715775116836626608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 7eb15a013a83..4e9584fff264 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -4915,6 +4953,249 @@ static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
>  	return NULL;
>  }
>
> +static int bpf_object__init_cleanup_info(struct bpf_object *obj)
> +{
> +	Elf_Data *data = obj->efile.cleanup_data;
> +	Elf_Data *relo = NULL;
> +	size_t i, nrels, nslots, nrecs;
> +	struct cleanup_raw_rec *recs;
> +	int *slot_sec, ret = 0;
> +	size_t *slot_val;
> +	const __u32 *vals;
> +	Elf64_Shdr *sh;
> +	bool native;
> +
> +	if (!data || obj->efile.cleanup_shndx < 0 || !data->d_size)
> +		return 0;
> +
> +	native = is_native_endianness(obj);
> +
> +	for (i = 0; i < obj->efile.sec_cnt; i++) {
> +		struct elf_sec_desc *sd = &obj->efile.secs[i];
> +
> +		if (sd->sec_type == SEC_RELO && sd->shdr &&
> +		    sd->shdr->sh_info == (Elf64_Word)obj->efile.cleanup_shndx) {
> +			relo = sd->data;
> +			break;
> +		}
> +	}
> +	if (!relo) {
> +		pr_warn("%s present without relocations\n", CLEANUP_SEC);
> +		return -LIBBPF_ERRNO__FORMAT;
> +	}
> +	/*
> +	 * LLVM leaves sh_entsize unset, so this only bites a producer that
> +	 * declares a record size -- which is the one able to tell us it means
> +	 * something other than three 4-byte fields.
> +	 */
> +	sh = elf_sec_hdr(obj, elf_sec_by_idx(obj, obj->efile.cleanup_shndx));
> +	if (sh && sh->sh_entsize &&
> +	    sh->sh_entsize != sizeof(struct bpf_cleanup_info)) {
> +		pr_warn("%s record size %zu is not the expected %zu\n", CLEANUP_SEC,
> +			(size_t)sh->sh_entsize, sizeof(struct bpf_cleanup_info));
> +		return -LIBBPF_ERRNO__FORMAT;
> +	}

Should sh_entsize == 0 be explicitly treated as 12, so that wider
records (if necessary in the future) end up being easier to reject?

This design question was raised by Kumar Kartikeya Dwivedi in v5:
https://lore.kernel.org/bpf/DLMGMYOHSGFW.24JML4GSMTV2K@gmail.com/

The current code accepts sh_entsize == 0 (LLVM's default) silently, but
treating it explicitly as 12 would allow future tools to cleanly reject
wider records by setting sh_entsize to a different value.

> +	if (data->d_size % sizeof(struct bpf_cleanup_info)) {
> +		pr_warn("%s size %zu is not a multiple of the record size %zu\n",
> +			CLEANUP_SEC, data->d_size, sizeof(struct bpf_cleanup_info));
> +		return -LIBBPF_ERRNO__FORMAT;
> +	}
> +
> +	vals = data->d_buf;
> +	nslots = data->d_size / sizeof(__u32);
> +	nrecs = data->d_size / sizeof(struct bpf_cleanup_info);
> +
> +	slot_sec = calloc(nslots, sizeof(*slot_sec));
> +	slot_val = calloc(nslots, sizeof(*slot_val));
> +	recs = calloc(nrecs ?: 1, sizeof(*recs));

This isn't a bug, but could the relocation loop fill recs directly
(with sec_idx initialised to -1) so the slot_sec/slot_val scratch
arrays and the copy loop go away?

The relocation loop could write straight into recs, using sec_idx = -1
as the 'no relocation' sentinel and checking alignment while the byte
offset is at hand, the way bpf_object__collect_rodata_relos() checks
(sym->st_value + addend) % BPF_INSN_SZ inline. That would leave one
allocation instead of three and drop the copy loop.

Also, is the 'nrecs ?: 1' needed? d_size has already been checked to be
a non-zero multiple of the record size.

> +	if (!slot_sec || !slot_val || !recs) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	for (i = 0; i < nslots; i++)
> +		slot_sec[i] = -1;
> +
> +	/* One relocation per 4-byte field, naming the section it points into. */
> +	nrels = relo->d_size / sizeof(Elf64_Rel);
> +	for (i = 0; i < nrels; i++) {

[ ... ]

> +	for (i = 0; i < nslots; i++) {
> +		struct cleanup_raw_rec *rec = &recs[i / CLEANUP_REC_FIELDS];
> +		size_t field = i % CLEANUP_REC_FIELDS;
> +
> +		if (slot_sec[i] < 0) {
> +			pr_warn("%s: field %zu has no relocation\n", CLEANUP_SEC, i);
> +			ret = -LIBBPF_ERRNO__FORMAT;
> +			goto out;
> +		}
> +		if (slot_val[i] % BPF_INSN_SZ) {
> +			pr_warn("%s: field %zu offset %zu is not instruction aligned\n",
> +				CLEANUP_SEC, i, slot_val[i]);
> +			ret = -LIBBPF_ERRNO__FORMAT;
> +			goto out;
> +		}
> +		rec->sec_idx[field] = slot_sec[i];
> +		rec->insn_idx[field] = slot_val[i] / BPF_INSN_SZ;
> +	}
> +
> +	obj->cleanup_recs = recs;
> +	obj->cleanup_rec_cnt = nrecs;
> +	recs = NULL;
> +out:
> +	free(recs);
> +	free(slot_val);
> +	free(slot_sec);
> +	return ret;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430
--===============8715775116836626608==--
