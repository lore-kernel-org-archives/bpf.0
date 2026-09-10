Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDD38657E
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064797; cv=none; b=MzOXTuCXTIcNNKgF6W4KpQ1PsIPkTckZaUbtToGUgGBJpysuhYZSdXh7N0MgE1Dt4rLuv6SvhOseDCLUvJmR/lnR5aDrCUWG4h/rt025uExlUrjehDcAdSVuN7fhPpFLVpFrjh1UGYmz8QnGsj4Knmj1eQzKfhfDcHGb9NmbXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064797; c=relaxed/simple;
	bh=Ms4uaEJ00/5CDTcHh+58Ut7o4Dra5yGZKYsQw0ufUyo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g9o/Ea1kTBo69I90j5U1KKX4HnXRZcWSXNublHS2cLKoqKWqfV83AhjXlgwQNaZX/tAJJgAJsI4CR7nPitrwczxBMyS85cGL1e/BwNJfWXNQIZFbHcFw/LKj9OPE6AN6HvP8z5kMrdTs8yQU6sCnAEZGWRIvWcSd8C6LRMy/Dic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRovR/yb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRovR/yb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0B71F000FF;
	Thu, 10 Sep 2026 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789064795;
	bh=GMYQZAhKQxvNsRjhCGx1BDagJoXyChc7HCPEKeMGfAg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WRovR/yb7Hp+Pnbx9TuRUTSP1aYtN85uU6hUn0NzHKs4FqzEHYJ8DHBOXqbuzIX1a
	 sF8QwIJntpANVta+hklcNoNFkNYs6SIkDmum8F90lkLzeelOxJ9iSdEE/PoSX7TSAV
	 Ny9A0RTrsQfAd98K/Ou9qvatMRR0EegbEVsmOKaGAh6LhXC3bPjpAL91BFPriWl4Wj
	 cAZwv3rI1Pv1gLkSrybjjx4JVPp0xTQ+BUskaN0GwRmYW+SUWnK+weuYPAaOMBUjhP
	 vdiPEiTTrUtUYtqmoClOmXl11Hi7DOsuCkL293CS76KbWIqijfBiWJZ2bGhqIMIXkx
	 MQzBoWDPjM5OA==
Content-Type: multipart/mixed; boundary="===============5886678989985608438=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c593a6c05cddc5a649a9160e6a4e8d6f7840a1cc9f20314873c5c289d80dcead@mail.kernel.org>
In-Reply-To: <20260910172340.1467764-3-caomingpei@gmail.com>
References: <20260910172340.1467764-3-caomingpei@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test private struct_ops bitfield rejection
From: bot+bpf-ci@kernel.org
To: caomingpei@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,caomingpei@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 18:26:34 +0000 (UTC)

--===============5886678989985608438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index 75a0dea511b3..517e5abe67c0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -150,6 +150,35 @@ static void test_struct_ops_not_zeroed(void)
>  	struct_ops_module__destroy(skel);
>  }
>
> +static void test_struct_ops_private_bitfield(void)
> +{
> +	struct struct_ops_module *skel;
> +	char *log = NULL;
> +	int err;
> +
> +	skel = struct_ops_module__open();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_private_bitfield"))
> +		return;
> +
> +	bpf_map__set_autocreate(skel->maps.testmod_zeroed, false);
> +	err = bpf_map__set_autocreate(skel->maps.testmod_private_bitfield, true);
> +	if (!ASSERT_OK(err, "enable_private_bitfield_map"))
> +		goto cleanup;
> +
> +	if (start_libbpf_log_capture())
> +		goto cleanup;
> +	err = struct_ops_module__load(skel);
> +	log = stop_libbpf_log_capture();
> +	ASSERT_EQ(err, -ENOTSUP, "struct_ops_module_load_private_bitfield");

Does this assertion alone actually verify the fix? On pre-fix libbpf,
m->offset / 8 evaluates to 0x3E00000 for the 31-bit bitfield, and
libbpf_is_mem_zeroed() reads ~62 MiB past the 4-byte st_ops->data. If
that read happens to land on non-zero mapped memory,
bpf_map__init_kern_struct_ops() returns -ENOTSUP from the "Cannot find
member %s in kernel BTF" path, so ASSERT_EQ(err, -ENOTSUP, ...) passes on
the buggy code as well.

Only the ASSERT_HAS_SUBSTR() on the bitfield diagnostic below actually
discriminates between fixed and broken libbpf. That makes the test correct
as written, but the two checks are asserted independently, so if the load
unexpectedly succeeds, the failure is reported against the log substring
rather than against the load.

The established pattern in this area gates on the error first, for example
in prog_tests/struct_ops_autocreate.c:

    if (!ASSERT_ERR(err, "struct_ops_autocreate__load"))
            goto cleanup;
    ASSERT_HAS_SUBSTR(log, "libbpf: struct_ops init_kern", "init_kern message");
    ASSERT_EQ(err, -ENOTSUP, "errno should be ENOTSUP");

Also worth noting: both the new local-bitfield check and the retained
kernel-bitfield check in bpf_map__init_kern_struct_ops() print the
identical "bitfield %s is not supported" string. The test only pins the
new one because the kernel struct bpf_testmod_ops has no private_bitfield
member, which makes the assertion meaningful but could use a comment.

> +	ASSERT_HAS_SUBSTR(log,
> +			  "bitfield private_bitfield is not supported",
> +			  "private_bitfield_rejection_log");
> +
> +cleanup:
> +	free(log);
> +	struct_ops_module__destroy(skel);
> +}
> +
>  /* The signature of an implementation might not match the signature of the
>   * function pointer prototype defined in the BPF program. This mismatch
>   * should be allowed as long as the behavior of the operator program

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> index 71c420c3a5a6..423caf78f420 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> @@ -76,6 +76,13 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
>  	.zeroed_op = (void *)zeroed_op,
>  };
>
> +struct bpf_testmod_ops___private_bitfield {
> +	unsigned int private_bitfield:31;
> +};

Does this bitfield width create a latent issue in bpftool's skeleton
generator? With kind_flag set, the BTF member offset encodes the bitfield
width in the top 8 bits. walk_st_ops_shadow_vars() in
tools/bpf/bpftool/gen.c does the same unmasked division libbpf used to do:

    offset = m->offset / 8;
    if (next_offset < offset)
            printf("\t\t\tchar __padding_%d[%u];\n", i, offset - next_offset);

For "unsigned int private_bitfield:31" at bit offset 0, m->offset ==
0x1F000000, so offset == 0x03E00000 == 65011712.
gen_st_ops_shadow_type() therefore emits into the generated
struct_ops_module.skel.h:

    struct struct_ops_module__testmod_private_bitfield__bpf_testmod_ops___private_bitfield {
            char __padding_0[65011712];
            unsigned int private_bitfield;
    } *testmod_private_bitfield;

That is a ~62 MiB shadow struct type in a selftest build artifact.
gen_st_ops_shadow_init() then assigns that pointer from
bpf_map__initial_value(obj->maps.testmod_private_bitfield, NULL), which
for a struct_ops map is the 4-byte st_ops->data buffer, so
skel->struct_ops.testmod_private_bitfield->private_bitfield is ~62 MiB out
of bounds.

Nothing in the new subtest dereferences that pointer, and a 62 MiB struct
type with no instance compiles fine, so this is not a crash today. But it
is a latent OOB accessor generated into a checked-in build artifact, and it
shows the divide-before-checking-bitfields bug still exists in bpftool
after this series.

The :31 width also has no comment explaining that it was chosen because the
width lands in the encoded offset. A narrower width like :1 still
reproduces the libbpf bug with a much smaller bogus offset (0x200000).

Worth either fixing walk_st_ops_shadow_vars() to use
btf_member_bit_offset() in the same series, or noting the interaction?

> +
> +SEC("?.struct_ops.link")
> +struct bpf_testmod_ops___private_bitfield testmod_private_bitfield;
> +
>  struct bpf_testmod_ops___incompatible {
>  	int (*test_1)(void);
>  	void (*test_2)(int *a);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34510539779
--===============5886678989985608438==--
