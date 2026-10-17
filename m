Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF93B19BF;
	Sat, 17 Oct 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257426; cv=none; b=XLUgk7ZCRmdaZB0WkvAB4iE9Oz13xtcUkpBH7D5+vNB7fj/mGztVP5JF0ShjtiV/D9Qy99QrrDltwDl7TPPea8FT/aBRhKvqS5SzgyOMnkxRPWvxwXULO3Ev8pjV97bUvBkdbDbHBKYFJEgMchsuatPPrLDbcS7TWiyqOtIViVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257426; c=relaxed/simple;
	bh=xTfNnYw0h2b3kV65Bfmskd4UUVXuvxBbtrLwuAG8qeE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HsVVHiQyJZcMGy9xGiMNW4W/ff2NQRFRFDxWoGXOR6RxtZvZ7tsFKKL3yw/fEUFmUTqICQncT4mBuJ7gE1qNrDwmAh4r5cabIiwCJ2ohjZbTSX6wkHsUuWEppdxGL2snaXVV6aq0bLuDMvOwhGhv471STZHnwXDW91xWeBkbu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw1xiGK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw1xiGK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4568E1F000C4;
	Sat, 17 Oct 2026 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257425;
	bh=mLIxwzuNqdL3El80GubbVH4+RKdqLOW1pmLDNtAutGg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mw1xiGK+RVDBceUYhEQIVzzZOIBRTFw4SRbRmVWbURbspvwD6GNv2KIk8YVBse9Rv
	 xfV4rONqc/FHxeOcJa44pAqnjFM5+xV2XwINHkx7nv6LDsBug+MK2n5T7WKUZsGrSB
	 KeU942kPfDz1op5VE+UVQbGgXXyPcvej0LjouQZrl/FSTl7QC6BQxaJJ2qfpxXUgyo
	 aBUGU7lK1eS5VsS5o64PwtAmHoUWPn4MWoefi3K4E1p2CW/p5p6xUag4tW3itZfY4O
	 LI0Fv+AClRTH2V58SgSd47XIjiF89u2Obxp6VYde2dec4BkBS9IohrMau9mCKQuOYG
	 DbjhL/IeplUCg==
Content-Type: multipart/mixed; boundary="===============6818153484382916465=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d7a9499c2a05ebbecc13985c8fca50a809361cc38d18364a004f643b91bf9d53@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-27-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-27-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 26/43] bpf: Don't take an extension for an iterator program
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:17:04 +0000 (UTC)

--===============6818153484382916465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Don't take an extension for an iterator program

TL;DR: The new EXT check in bpf_iter_prog_supported() may be incomplete: a
TRACING/BPF_TRACE_ITER program attached to a JITed program's function can
still reach it, possibly corrupting the iterator target's btf_id cache and
ctx_arg_info.

> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 4668c1696a08..5fd376bd210b 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -351,6 +351,13 @@ int bpf_iter_prog_supported(struct bpf_prog *prog)
>  	const char *prefix = BPF_ITER_FUNC_PREFIX;
>  	int prefix_len = strlen(prefix);
>  
> +	/*
> +	 * The attach function of an extension is a subprogram of the iterator
> +	 * program that it extends, whatever its name is.
> +	 */
> +	if (prog->type == BPF_PROG_TYPE_EXT)
> +		return -EINVAL;
> +
>  	if (strncmp(attach_fname, prefix, prefix_len))
>  		return -EINVAL;

Is this check enough, or can the same problem be reached without an
extension?

A BPF_PROG_TYPE_TRACING program loaded with expected_attach_type set to
BPF_TRACE_ITER, attach_prog_fd pointing at a JITed program P1, and
attach_btf_id set to a global function of P1 named bpf_iter_bpf_map_elem
looks like it gets here too.  bpf_prog_load_check_attach() has no
BPF_PROG_TYPE_TRACING case that rejects it, and in
bpf_check_attach_target() the BPF_TRACE_ITER case with tgt_prog set only
does:

    btf_type_is_func() / func_proto checks
    btf_distill_func_proto()

Unlike the BPF_TRACE_RAW_TP case just above it, it never rejects tgt_prog.

check_attach_btf_id() then stores the subprogram name of P1 in
prog->aux->attach_func_name and calls bpf_iter_prog_supported().  Since
prog->type is BPF_PROG_TYPE_TRACING here, the new check does not refuse it:

    bpf_check()
      check_attach_btf_id()
        bpf_check_attach_target()
        bpf_iter_prog_supported()
          cache_btf_id()
            tinfo->btf_id = prog->aux->attach_btf_id

The 'bpf_iter_' prefix matches and strcmp() against reg_info->target
matches, so cache_btf_id() caches an id from P1's BTF as the btf_id of the
target, and bpf_prog_ctx_arg_info_init() copies the target's ctx_arg_info.
This happens at check_attach_btf_id() time, so it persists even if the load
fails later.

After that, bpf_iter_link_attach() compares iter->btf_id with the poisoned
id, so already loaded programs of that target fail with -ENOENT.  A vmlinux
BTF program whose attach_btf_id equals the forged id would be matched to the
wrong target (and the wrong ctx_arg_info) by the first branch of the loop in
bpf_iter_prog_supported().

The out-of-bounds buffer access described in the commit message does not
seem to apply to this route, since the program being attached is the one
whose max_rdonly_access is recorded.  Only the btf_id cache corruption and
the ctx_arg_info mix-up remain.  It needs CAP_BPF and CAP_PERFMON, the same
as the extension case.

Would it be better to refuse any program that has a dst_prog here, for
example:

    if (prog->aux->dst_prog)
        return -EINVAL;

That also covers all extensions, since they always have one.  Alternatively,
could bpf_check_attach_target() reject tgt_prog for BPF_TRACE_ITER, as it
does for BPF_TRACE_RAW_TP?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============6818153484382916465==--
