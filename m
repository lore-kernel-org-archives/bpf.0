Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E982CCB5
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383830; cv=none; b=adVdh/EWVQGk6VypSQrB0R5bGQqePoKSbONTy9X4DTqkQtldBMwmIsmf9xHzuu+yArjl+if6DrFvRPzfp8UZKec69T0JC60FtpLCt/jXGOhk04rAFQa3GydN4stZkMk12ITB4/G4sRVUtLHjTjH0MD+DT17M97SJXZGuQswZNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383830; c=relaxed/simple;
	bh=6KzoMcz9+9nVPueqkGJQf9m8sDUTL2nwDXFbE75XwrA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lfFJGaUC7CZIdiikYl1qwvBw0mnblbLhiHgw7g0XnPFj56YteAyHm5XXd0TzBWo4OQdrxTmhhprytMjKFertvMxlKX/Qp7fusGgXcinQ/6Hctm90NbUa4SuEb3oIzfVCTAml/R2gNaIBwMpD5vnm/USMLJkFd2Az3hWuUNXA1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REGjQsEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REGjQsEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC791F000FF;
	Sat, 26 Sep 2026 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383828;
	bh=vHPtIsxR4hejplPGRjLk8Q9Hf5V6F8V82pZmPwgAzzw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=REGjQsEnJZWbsjjdRiJzcUJ8EGP5i42+wg/HEyCjIg0Gb/HIoEL58bU9riLPlVbJY
	 CTVlfuC5Qu/yQWIXDIpwAG0NQvD5rUFLUx8Yr541vV1LQvoa4UvkdkQyQ+/4zaFdUf
	 eABtt78D3Xpz2iuFOKcrx9TJPdXYgxdvpUu3QUlDKdtGPEIwp+a6oLl4GKY8urGTZ6
	 H91TZI2dJ7ixLCiJfq8+5v5y+yPC4Sasp8YGPvQwTNDNhITozenWkPXjzF+/1OsPoY
	 NPlDpA83TBdhJR7fZycIVx+zMSbQuym8JdAcCLYO523YusuNIXrvucI8ojKctfSYtq
	 Patc/W6XP/kPA==
Content-Type: multipart/mixed; boundary="===============0205434016660070218=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9a922a1c758bb9987b8c91766987999c31d8d9bd3dcb500b005e7e8fec2ff64e@mail.kernel.org>
In-Reply-To: <20260926000243.2830819-2-andrii@kernel.org>
References: <20260926000243.2830819-2-andrii@kernel.org>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add linked_externs test for externs in allocated sections
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 26 Sep 2026 00:50:28 +0000 (UTC)

--===============0205434016660070218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_externs.c b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
> new file mode 100644
> index 000000000000..29358c82dc35
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
> @@ -0,0 +1,109 @@

[ ... ]

> +/* link in1 on its own first, then link the result with in2 */
> +static void test_relink(const char *in1, const char *in2, const char *sec_name)
> +{
> +	char out1[] = "/tmp/linked_externs.XXXXXX", out2[] = "/tmp/linked_externs.XXXXXX";
> +	const struct btf_var_secinfo *vi;
> +	struct bpf_object *obj = NULL;
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	int i, id, n;
> +
> +	close(mkstemp(out1));
> +	close(mkstemp(out2));
> +
> +	if (!ASSERT_OK(link_objs(out1, in1, NULL), "link_stage1") ||
> +	    !ASSERT_OK(link_objs(out2, out1, in2), "link_stage2"))
> +		goto cleanup;
> +
> +	obj = bpf_object__open_file(out2, NULL);
> +	if (!ASSERT_OK_PTR(obj, "obj_open"))
> +		goto cleanup;
> +
> +	btf = bpf_object__btf(obj);
> +	id = btf__find_by_name_kind(btf, sec_name, BTF_KIND_DATASEC);
> +	if (!ASSERT_GT(id, 0, "find_datasec"))
> +		goto cleanup;
> +
> +	t = btf__type_by_id(btf, id);
> +	vi = btf_var_secinfos(t);
> +	n = btf_vlen(t);
> +	for (i = 0; i < n; i++) {
> +		t = btf__type_by_id(btf, vi[i].type);
> +		ASSERT_NEQ(btf_var(t)->linkage, BTF_VAR_GLOBAL_EXTERN, "var_resolved");
> +	}
> +
> +	ASSERT_OK(bpf_object__load(obj), "obj_load");

Does the relink_arena subtest detect a regression of the second libbpf hunk
in de5494287bf5, the one that sets dst_var->offset = sym->st_value in
linker_append_btf?

If that hunk were reverted, a_val and b_val in .addr_space.1 would both keep
BTF offset 0 in the stage2 output. Both vars are already
BTF_VAR_GLOBAL_ALLOCATED (complete_extern_btf_info updates the linkage), so
the var_resolved assertion passes.

bpf_object__open_file() does not repair the offsets, because
btf_fixup_datasec() only recomputes them when t->size == 0:

tools/lib/bpf/libbpf.c:btf_fixup_datasec() {
    for (i = 0, vsi = btf_var_secinfos(t); i < vlen; i++, vsi++) {
        ...
        if (t->size)
            continue;
        ...
        vsi->offset = ((__u32)sym.st_value) - start;
    }
}

At load time the kernel rejects the BTF in btf_datasec_check_meta() with
Invalid offset. This object has no struct_ops, though, so libbpf treats BTF
as optional, logs BTF is optional, ignoring, and bpf_object__load() still
returns 0:

tools/lib/bpf/libbpf.c:bpf_object_load() {
    err = bpf_object_init_prog_arrays(obj);
    if (err)
        return libbpf_err(err);

    err = bpf_object_load_prog(obj, prog, ...);
    ...
}

Arena relocations use ELF symbols and section data, not BTF offsets, so
obj_load still passes.

The skel_arena subtest does not catch it either, because gen_bpf_skel.sh
relinks through linker_fixup_btf, which recomputes the offsets from the ELF
symbols. The commit message says the direct linker test exists because the
skeleton path hides the problem, but only relink_maps (through map
sec_offset matching) would expose the offset bug. relink_arena would not.

Could the test also check that the DATASEC var offsets are distinct, or that
they match the ELF symbol values?

> +
> +cleanup:
> +	bpf_object__close(obj);
> +	unlink(out1);
> +	unlink(out2);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36204104252
--===============0205434016660070218==--
