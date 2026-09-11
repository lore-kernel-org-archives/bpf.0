Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF51338939;
	Fri, 11 Sep 2026 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100914; cv=none; b=RXWo9Fza224yOknHQnrYCeo1MlpD1uZxfHdRA9bP4TQhdl0+kSQpQx+bewu3tASBNvWqQCoUP7YDWwwBede67HIlPK5M70+d2ROaRffSKCWEkEHzhmSbGz6Mt+W96Mhum95UiPP4WRpv+Alq8LBbTkJ4q67j5hzgsTlnfxpnokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100914; c=relaxed/simple;
	bh=c/YmVaP5Lv3//fdcX609axxuB4op9EaK3jPwljKT5Pk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m/i/dZVetnN9AlgmYh6xj27ffDBP2FBXEwrlRMXKpCGus9OIZ5wYlN8kHRLyU8sr7NXp998+6WUJTcvqVQqBStUSd1AFVAsIYmRs1zLgaDEyQpUyELZisGjDDANkGTRJ0ARtpV+HNXq2Dk+Lrjwe77ZBJmk+MHibpnObYEvBJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEwH4IHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEwH4IHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4353B1F000FF;
	Fri, 11 Sep 2026 04:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789100912;
	bh=HdrEKubkyqoCa6VHA9yBwBINmN02gNg/uWhbZibAKtc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bEwH4IHksJwVx7Hp1TK6vpUTgs1yLMiuemlFEkGJJWs3iNrNXIVWuVGwl/XfIlpjg
	 qzGQk2+cfP9cgrPdIgCiFggMgzoghk0t6lViYFpGt+/ekzJMQ2VgWMst1dUwHJFEe2
	 ks6TYk4NF77CBGVJloLGz65xecatX9/JyQzXtnPuoaRHs/VnVJ9J4YtrQXtHUJSDXV
	 OrDTxLuHzcFntJ2ft7SXFXgAqLGVPu4rGY1uIEqpJ75Y1b0ZHMI8RlTvVG6XkaQSeT
	 RLGLy370G66H1I+CtRQVq6o4WWoCtSZkDtMIEqNgjYscCQqI9mR6RZA2Bs1MGsTJge
	 1xGnaaPvZdQ1A==
Content-Type: multipart/mixed; boundary="===============1357064658013625355=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4fba1aedc906d6c5072a1ae9a72496e6d307abd60c456cb870077cf93cc8f4ce@mail.kernel.org>
In-Reply-To: <20260911034715.219552-3-diannaaav@gmail.com>
References: <20260911034715.219552-3-diannaaav@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Cover recursive bpftool map dumps
From: bot+bpf-ci@kernel.org
To: diannaaav@gmail.com,qmo@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 04:28:32 +0000 (UTC)

--===============1357064658013625355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Exercise recursive map dumping for array-of-maps and hash-of-maps,
> including shared inner maps, empty outer and inner maps, BTF-formatted
> values and multiple selected roots.
>
> Check complete JSON documents against the existing nonrecursive entry
> representations, and check plain headers and typed values. Verify both
> short and long options, root ordering, deduplication and unchanged
> default output.
>
> Cover ordinary and nested perf event arrays to ensure unsupported
> element lookups retain their error markers without failing the dump.
> Dump 64 distinct inner maps under RLIMIT_NOFILE=32 in both JSON and
> plain modes to catch holding every discovered inner-map FD open.
>
> Open 32 extra descriptors before forking, close inherited descriptors
> in the child before imposing the limit, and verify the parent's file
> descriptors and outer map remain usable.

This isn't a bug, but could the changelog be trimmed to focus on the
coverage added and the reason RLIMIT_NOFILE=32 / 64 inner maps is the
interesting case?

The last paragraph in particular restates the code almost line for line
(opening 32 descriptors, closing inherited descriptors in the child,
lowering the limit, re-checking the parent), which a reader can get from
the diff. The load-bearing part of this patch is the one non-obvious idea,
i.e. that RLIMIT_NOFILE=32 with 64 inner maps is what makes the FD-per-
inner-map regression detectable.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> new file mode 100644
> index 000000000000..1fb877fc68c8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

[ ... ]

> +static void test_outer(enum bpf_map_type type, int entries, bool empty_inner,
> +		       bool typed)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	LIBBPF_OPTS(bpf_map_create_opts, inner_opts);
> +	struct btf *btf = NULL;
> +	char outer[OUTPUT_SIZE], inner[OUTPUT_SIZE], output[OUTPUT_SIZE];
> +	char expected[OUTPUT_SIZE * 3], reference[64];
> +	const char *type_name = libbpf_bpf_map_type_str(type);
> +	int inner_fd = -1, outer_fd = -1;
> +	__u32 root_id, inner_id, key, value = 0x01010101;

[ ... ]

> +	outer_fd = bpf_map_create(type, "dump_outer", sizeof(key), sizeof(__u32),
> +				  3, &opts);
> +	if (!ASSERT_OK_FD(outer_fd, "create_outer"))
> +		goto out;
> +	/* The unused third array slot also exercises failed lookups. */
> +	for (key = 0; key < entries; key++)
> +		if (!ASSERT_OK(bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_ANY),
> +			       "populate_outer"))
> +			goto out;

This isn't a bug, but would it be clearer to say the outer map is over-
sized so the array_of_maps cases also walk unfilled slots, rather than
naming 'the unused third array slot'?

The comment describes one specific configuration rather than what the loop
does across the seven call sites. test_outer is invoked with
BPF_MAP_TYPE_HASH_OF_MAPS in four of the seven subtests, where a
hash_of_maps enumerates only the keys that were inserted, so there is no
third slot and no failed lookup at all; and for entries == 0 or 1 (four
more subtests) the number of unfilled array slots is three or two, not
one.

[ ... ]

> +static void test_many_inner_maps(bool json)
> +{
> +	enum {
> +		DUMP_OK,
> +		DUMP_ERR_RLIMIT,
> +		DUMP_ERR_COMMAND,
> +		DUMP_ERR_COUNTS,
> +		DUMP_ERR_IDS,
> +		DUMP_ERR_JSON,
> +		DUMP_ERR_FDS,
> +	};
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	const struct rlimit limit = { .rlim_cur = 32, .rlim_max = 32 };
> +	char command[MAX_BPFTOOL_CMD_LEN], token[64];
> +	__u32 ids[64], root_id, key;
> +	int inner_fd = -1, outer_fd = -1, status;
> +	int inherited_fds[32], nr_inherited = 0, i;
> +	char *output = NULL;
> +	pid_t pid;

[ ... ]

> +	root_id = map_id(outer_fd);
> +	output = calloc(1, 65536);
> +	if (!root_id || !ASSERT_OK_PTR(output, "allocate_output"))
> +		goto out;

[ ... ]

> +		snprintf(command, sizeof(command), "%s -r map dump id %u",
> +			 json ? "-j" : "", root_id);
> +		if (get_bpftool_command_output(command, output, 65535))
> +			_exit(DUMP_ERR_COMMAND);

This isn't a bug, but would a macro alongside OUTPUT_SIZE (and passing
size - 1 to the helper, as the other call sites do) keep these two sizes
from drifting apart?

The output buffer size is spelled out as two related magic numbers in two
places (calloc(1, 65536) and get_bpftool_command_output(..., 65535)),
which have to be kept in the N / N-1 relationship by hand. Every other
buffer in the file goes through the OUTPUT_SIZE macro and passes
sizeof(buf) - 1, e.g. dump_map()'s get_bpftool_command_output(command,
output, OUTPUT_SIZE - 1) and check_plain()'s sizeof(output) - 1, so this
is the only place where the size is not derived from a single definition.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34560347455
--===============1357064658013625355==--
