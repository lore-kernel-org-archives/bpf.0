Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818894229D0
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025638; cv=none; b=jzRTJZ9a8KeLc0aDZe1ZtkiZJniEnwSn6ofp46A/w0gv3QdriMBAof7AcSYWwpoI7P97poGE9QIy1w40ouenB944krvBHQeBDC/BTs9gNISQEeBYDqW3PSTVt6KJ7jxFilmvw66tARzI6nvp5KI/Sa4r5PNXM4PPzhzxdCWD+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025638; c=relaxed/simple;
	bh=LEs31QVTr0YKj7W7RJax82M8u9rrjupsDnvtPtckke4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=utyXjtXBrMG6OU+8cVMt5ZBnDwDqRbpqX3MB95NZDJMczAgW6cIac1kicH3MZev1mLv6aJD1oXcyBnylpxMzta6sqS0aafb7pGDRarquySPTHWCd3hQazWNNwQsC9MrQHWYsflXFJY7EITfmvJE+mYLpB2nps6gFRWSnXjDtQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3B+B+ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3B+B+ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254681F000FF;
	Mon, 21 Sep 2026 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790025637;
	bh=gs2IWNYJOovjoMSuF8Tt3IXK/gLIlXZu0NHoaaxEAWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3B+B+ipQOqucHkGnfxnY9WJ6sWpMfqhm+yORuZofD/d0zgB+7eGlL3VBfaHgXHYF
	 14KQiJqKwEcjpQ+87zFTBJ1+qS+K13qUrhQS1fgGIlEFX/iwJCZPBZZLOVFYQwN6Pt
	 N4ZRoq8br53wH/l5w+BHAWb437yImrkGHV/R/UZqvyIhRCrSQVMi+i6Mv/SqG47ZfS
	 Olhdpgr5kTNlgD51Et1Veq2d6XlZUoFdETViDM3zQmDJG+KprXJN2rkXi9RkJlfsXF
	 Iv0sQjb2Ev44PyTYuPyyYhRQ/hzNtYVMM7DvcBRneG8p6QN4GtQTwhJxagZo4UPLNL
	 7yGoCypVygByA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 15/20] libbpf: Collect .bpf_cleanup records
 and pass them to the kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921210150.1723467-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210150.1723467-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:20:36 +0000
Message-Id: <20260921212037.254681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: invalid multi-line comment style in libbpf.c
--

commit 640e4ca07507c0fa24643be768ba697d779b3ae5
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: libbpf: Collect .bpf_cleanup records and pass them to the kernel

This commit parses the compiler-emitted .bpf_cleanup section and extracts
the table of cleanup records. It resolves section relocations for each reco=
rd,
validates alignment, and passes the per-program cleanup information to the
kernel during program load.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 13ae9175e9686..e3e4db59fb5f4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -4854,6 +4892,235 @@ static struct bpf_program *find_prog_by_sec_insn(=
const struct bpf_object *obj,
[ ... ]
> +		slot_sec[slot] =3D sym->st_shndx;
> +		/* The addend lives in the section data, which libelf leaves in
> +		 * the object's byte order; a non-section symbol additionally
> +		 * contributes its own value.
> +		 */
> +		slot_val[slot] =3D (native ? vals[slot] : bswap_32(vals[slot])) +
> +				 sym->st_value;
> +	}

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF=
=20
subsystem style? I believe the opening /* is typically expected to be on it=
s=20
own line.

[ ... ]
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

[Severity: Low]
This isn't a bug, but should this multi-line comment be formatted with the=
=20
opening /* on a separate line to match the rest of the BPF subsystem?

[ ... ]
> +			if (owner =3D=3D prog) {
> +				final =3D raw->insn_idx[j] - prog->sec_insn_off;
> +			} else if (prog_is_subprog(obj, owner) && owner->sub_insn_off) {
> +				/* sub_insn_off is where this subprogram was
> +				 * appended to the main program being relocated;
> +				 * zero means it is not part of it.
> +				 */
> +				final =3D owner->sub_insn_off +
> +					raw->insn_idx[j] - owner->sec_insn_off;

[Severity: Low]
This isn't a bug, but could we adjust this comment to have the opening /* o=
n=20
its own line for consistency as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921210033.1715=
000-1-yonghong.song@linux.dev?part=3D15
