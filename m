Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63B364EB2
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707656; cv=none; b=uVG4Uw1aMJaWRt8avDOoYXjUERMyC38BKJkQEOZBnJ38tk7y9XsGYgBOzaRSKsYcMsDllIHTI5grvSZE8HLuBl/QSW081s7W7iMCF3UB4qHC6EjC7UorQ0DVc3ytoIdypnKaW2SW+BPLWG9vwjUJnj+NdsYS7ACfJPRENrqwcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707656; c=relaxed/simple;
	bh=nO+QVaxnEIIjpUG5QU+gSZDypwpQBt6ivW57GPfv5EY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EDhJzCKqnmaksQz60iSFNqhxghVAvQS9x05CFE7B1s/S86k9Ol2IglONswlYpfTyIVwUrXWPvatcMunu3pOiytys1sE+JOsRrmbxeiDV9W5EzDa5wntCveZkRxwSUmdmmVpfYhGEME2eiOhTUYfoqNNZZ9/1gbIqkNJyuQ2dddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKg52Hd0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKg52Hd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFFB1F000FF;
	Fri, 18 Sep 2026 05:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707654;
	bh=3vw4rTZTc51w24QIjM2OcVLCOPmv9luQlIA8EE7bY8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TKg52Hd08UEE65R2rbXNcOuhjtGAIeBzKUgHAEDvxNKvyWS+2mFvIddB1oUi/nRqu
	 45POMkivWKOvKpPq5kpnO4fdKtUNSo1ycbjqrVbhZv3KZsU5dI2QEX7CGBCRuerAqF
	 pppO0Od5YOimcvmuQOTVQzLiZ5wDl9/TM25Y4C8lswVUln3J+eM1F1+rRdshzkaYK5
	 s5u7sUGIZqm+SVcgymnJJXxYsXzQhu2V8ytbwnqJv7xdoSR8xZ9P14bgRPdzNdlUTO
	 MU3NZCqgvH4vLwErZL9PX5kntr/XFOeuzx9cqx4PdWJjvakdC3TTi58ZlxqaV90d1D
	 4rFCzUM1WyqFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 15/20] libbpf: Collect .bpf_cleanup records
 and pass them to the kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918044317.3291712-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044317.3291712-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 05:00:54 +0000
Message-Id: <20260918050054.BAFFB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: empty cleanup range check in bpf_prog_collect_cleanup_info(=
) only catches offset 0
- [Medium] bpf: bpf_object__init_cleanup_info() rejects valid objects with =
0-sized .bpf_cleanup sections
--

commit a645d3bd249aceee4909edcc78e5fe4247fd3432
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Collect .bpf_cleanup records and pass them to the kernel

Parse the compiler-emitted .bpf_cleanup section and hand the resulting
table to BPF_PROG_LOAD.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 27f2eec13f76f..1b8b978e7b7b9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -4852,6 +4890,221 @@ static struct bpf_program *find_prog_by_sec_insn(=
const struct bpf_object *obj,
>  	return NULL;
>  }
> =20
> +static int bpf_object__init_cleanup_info(struct bpf_object *obj)
> +{
> +	Elf_Data *data =3D obj->efile.cleanup_data;
> +	Elf_Data *relo =3D NULL;
> +	size_t i, nrels, nslots, nrecs;
> +	struct cleanup_raw_rec *recs;
> +	int *slot_sec, ret =3D 0;
> +	size_t *slot_val;
> +	const __u32 *vals;
> +	bool native;
> +
> +	if (!data || obj->efile.cleanup_shndx < 0)
> +		return 0;
> +
> +	native =3D is_native_endianness(obj);
> +
> +	for (i =3D 0; i < obj->efile.sec_cnt; i++) {
> +		struct elf_sec_desc *sd =3D &obj->efile.secs[i];
> +
> +		if (sd->sec_type =3D=3D SEC_RELO && sd->shdr &&
> +		    sd->shdr->sh_info =3D=3D (Elf64_Word)obj->efile.cleanup_shndx) {
> +			relo =3D sd->data;
> +			break;
> +		}
> +	}
> +	if (!relo) {
> +		pr_warn("%s present without relocations\n", CLEANUP_SEC);
> +		return -LIBBPF_ERRNO__FORMAT;
> +	}

[Severity: Medium]
Could this reject valid objects if the compiler emits an empty 0-byte
.bpf_cleanup section?

If the section is empty (e.g., exceptions were optimized out), no relocatio=
ns
are emitted and there is no corresponding .rel.bpf_cleanup section. However,
bpf_object__init_cleanup_info() requires the relocation section to exist if
.bpf_cleanup is present.

Would it be better to return early if data->d_size is 0 before checking for
relocations?

[ ... ]

> +static int bpf_prog_collect_cleanup_info(struct bpf_object *obj,
> +					 struct bpf_program *prog)
> +{
> +	size_t i;
> +	int j;
> +
> +	for (i =3D 0; i < obj->cleanup_rec_cnt; i++) {
> +		struct cleanup_raw_rec *raw =3D &obj->cleanup_recs[i];
> +		struct bpf_program *owner =3D NULL;
> +		struct bpf_cleanup_info ci =3D {};
> +		__u32 fields[CLEANUP_REC_FIELDS];
> +		void *tmp;
> +
> +		for (j =3D 0; j < CLEANUP_REC_FIELDS; j++) {
> +			size_t idx =3D raw->insn_idx[j], final;
> +			struct bpf_program *p;
> +
> +			/* The end of a range is exclusive, so it may name the
> +			 * instruction just past the last one of a function,
> +			 * which belongs to the next function or to nothing at
> +			 * all. Ask about the last instruction the range covers,
> +			 * the way the kernel does.
> +			 */
> +			if (j =3D=3D CLEANUP_REC_END) {
> +				if (!idx) {
> +					pr_warn("%s: record %zu is an empty range\n",
> +						CLEANUP_SEC, i);
> +					return -LIBBPF_ERRNO__FORMAT;
> +				}
> +				idx--;
> +			}

[Severity: Medium]
Will this check catch empty ranges emitted by the compiler at non-zero
offsets?

If the compiler emits a .bpf_cleanup record where begin and end are both 5,
the check for !idx evaluates to false. The code will then decrement idx to 4
and look up the program for the previous instruction.

If this empty range is located at the start of a function, looking up the
previous instruction will fall into the preceding function, potentially
triggering a spurious "spans functions" error or silently accepting invalid
records.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918044156.3283=
973-1-yonghong.song@linux.dev?part=3D15
