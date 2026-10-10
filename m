Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612B2DECBF;
	Sat, 10 Oct 2026 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791675644; cv=none; b=fPYfH6F3gGTsPl6PQj+gANtvN0osYNgki451OCfgkxz8JCcWqMeEwELoSCtQZMsHSblCrVBGhoNVgWJlMaaIO24/K5AnxulvyDN9wvcC4T9axoal7nFWE3IDBj1hYc4c19RpNGuveH3VIzcF5emIDra4kTAnK0oJ6ujx7u5vGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791675644; c=relaxed/simple;
	bh=ZN0ZAZtTISUaQRKFc89HkZJxB0gd+IbVVs+w9gTnym0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=u08xAW3l8J6ibBBeyvH5A4tuU165zh5MUvDaqIpYDNb+FB9wefnmxDtDHxoqybCAMQDWKigy1vrWfwQfZGqrTZIbnelmf6T5BSXDgVBca6yyHQdLKOgSkSM2eGMGSxGw38Jf+TzoGv3Pd11HyNaYWQl/ciHIJVXd+NJB3XrEveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEIh6PpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEIh6PpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8F01F000FF;
	Sat, 10 Oct 2026 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791675643;
	bh=O08No+ZLnddMNkvkaDcN+wNc2a2NNQMCgwswGt0fy+A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YEIh6PpIHh92qwKFhjktLWI1COUDgwnCdFqf0ycrWfz0UZX8LNBUFmzZsuJKYbG6y
	 o8QN3Ip321wnYo/resJVcsNIIG6BUusoLIsocbc+IKtsBd9bWGRi87RNSIGDgvfqjv
	 nrQp1I6hLmrRsPV8Q0NksjWfQ1JTqwshvCTLC36Z6ooFKlOw+qudiacPbU76Ice5DY
	 04eSQU+hKOUMMDRzlHE2p3Wie4Hj4gcC0p/Ow4aWlqkAqEKG1/EG7fgEau6ZrIZ5HD
	 U+ZXNMZJgaddYdiXeTVdrp7LadWtvfCHQ0l8ZlSEgaRP4dNszJI3/+K8v+AvD/Utl8
	 11xXwDVD2v93Q==
Content-Type: multipart/mixed; boundary="===============5396071750237871502=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <431ff6251cc556b2c294aad5492f3aac4998bb448d22b1a7a6ab8d84c6240c5a@mail.kernel.org>
In-Reply-To: <20261010224902.1232178-5-arighi@nvidia.com>
References: <20261010224902.1232178-5-arighi@nvidia.com>
Subject: Re: [PATCH 4/5] selftests/bpf: Test pinned arena file mappings
From: bot+bpf-ci@kernel.org
To: arighi@nvidia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,joshdon@google.com,vineethrp@google.com,balbirs@nvidia.com,skolothumtho@nvidia.com,himadrics@protonmail.com,royfru44@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 10 Oct 2026 23:40:40 +0000 (UTC)

--===============5396071750237871502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test pinned arena file mappings

TL;DR:
- Commit message second paragraph uses imperatives that read like kernel
  changes and repeats other paragraphs
- Selftest skips print no reason, so address-0 and unsupported-arena skips
  look identical

>     selftests/bpf: Test pinned arena file mappings
>
>     Add native tests for pinned arena files, covering canonical range setup
>     via map FD mmap and map_extra, exported slice bounds, full-capacity
>     canonical mappings, and mapping lifetime after unpinning. Check that
>     oversized mapping requests fail cleanly and that size changes are
>     rejected without zapping mappings, while permission updates and
>     BPF_OBJ_GET still work.
>
>     Reject canonical mapping lengths that differ from the exported arena's
>     capacity and map the entire size reported by fstat(). Preserve short
>     canonical mappings for ordinary and retention-only arenas. Drop other
>     mappings, the pin, and open FDs before checking that the exported slice
>     retains the arena. Change the pin's mode from its creation permissions
>     to verify that metadata updates take effect.
>
>     Test O_RDONLY pin mappings with MAP_SHARED and MAP_SHARED_VALIDATE.
>     Verify that readers observe writer updates, retain access after closing
>     the FD, and cannot request writable or private mappings or upgrade a
>     mapping with mprotect().
>
>     Check that ordinary and retention-only arenas keep their existing pin
>     behavior, while BPF_F_ARENA_EXPORT requires BPF_F_ARENA_NO_FREE.
>
>     Check fixed-size seeking, canonical setup at address zero when security
>     policy permits it, and the exported mapping lifecycle restrictions.
>     Verify that partial unmap and protection changes, MADV_DOFORK, and
>     relocation fail, while fork leaves the parent's mapping intact without
>     inheriting it in the child.
>
>     Assisted-by: LLM
>     Signed-off-by: Andrea Righi <arighi@nvidia.com>

This isn't a bug, but the second paragraph of the changelog uses
imperatives ("Reject canonical mapping lengths...", "Preserve short
canonical mappings...", "Drop other mappings...", "Change the pin's
mode...") that read like kernel behaviour changes, even though this patch
only adds a selftest.

Could the second paragraph be reworded to say what the tests check, for
example "Check that canonical mappings whose length differs from the
exported capacity are rejected ...", and merged with the first paragraph?
It also repeats items already listed there ("full-capacity canonical
mappings", "permission updates") and in a later paragraph ("ordinary and
retention-only arenas").  Any version-to-version notes could go below the
--- line.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_pinned.c b/tools/testing/selftests/bpf/prog_tests/arena_pinned.c
> new file mode 100644
> index 000000000000..8b7ca9021129
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_pinned.c
> @@ -0,0 +1,442 @@

[ ... ]

> +static bool setup(struct arena_file *file, __u64 map_extra, bool zero)
> +{

[ ... ]

> +	file->map_fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_pinned",
> +				      0, 0, ARENA_PAGES, &opts);
> +	if (file->map_fd < 0 && errno == EOPNOTSUPP) {
> +		test__skip();
> +		return false;
> +	}

[ ... ]

> +	file->canonical = mmap(NULL, file->len, PROT_READ | PROT_WRITE,
> +			       MAP_SHARED | (zero ? MAP_FIXED_NOREPLACE : 0),
> +			       file->map_fd, 0);
> +	if (zero && file->canonical == MAP_FAILED &&
> +	    (errno == EPERM || errno == EACCES)) {
> +		test__skip();
> +		return false;
> +	}
> +	return ASSERT_NEQ(file->canonical, MAP_FAILED, "canonical_mmap");
> +}

A subsystem pattern flags this as potentially concerning: a skip that
prints no reason.  This isn't a bug, but every skip path in this file is a
bare test__skip(), so test_progs only reports SKIP for the subtest.

For the zero_canonical subtest this skip is taken whenever mmap_min_addr
or an LSM refuses a mapping at address 0, and the log cannot tell that
apart from the arena-unsupported skip taken after bpf_map_create() returns
EOPNOTSUPP.  The same bare test__skip() appears after the EOPNOTSUPP
checks in test_unexported_pin() and test_export_requires_no_free().

Other arena tests print the reason first, for example arena_htab.c:

	printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);
	test__skip();

and arena_memcg.c:

	fprintf(stderr, "%s:SKIP:no memory controller or other env error\n",
		__func__);
	test__skip();

The bare test__skip() after an arena bpf_map_create() returning
EOPNOTSUPP does match existing usage in arena_direct_value.c, so the main
gap is the environment-dependent zero-canonical skip.  Would a short
reason such as "mapping at address 0 not permitted" or "arena not
supported" be worth printing before each test__skip() here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38093513563
--===============5396071750237871502==--
