Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820102;
	b=ZVK8iVkSMRF0D1fYgH6wD8BQ2B1h4A05KcO4cdPSTWXJAKz5/m5hbzZIy8j9DA3uGB9u
	 aAQIx72MKXHX2Q0vSfIwPXNQGyHqYR4qzzvbbQixVAkPvKAox7fnkWYXb/KTe8Aga9u2e
	 by+Gq9EHJmPTEcyetmGvQoGrrpBihzlPQhC5qzxUeSIIFp0lx7m7a59RRAtdWZTsqtvdT
	 eoleI3PJOgHue3XB0BQOR1J88DY7HVDtv3V8RCJvkD2oFPfbBygNP9Nk176Q/HrI3rm4/
	 Bc1rjak5n4jJNpVqOVx8w94s7Qf8WYldoEXcy7sKrruqwRW2zVXbDJIF09d5N4mV5PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820102;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uU9s9C1o+HyqlrWjOAZmUUUB8ZRG2Mo4Mxxh4trltwU=;
	b=UR60NlYVbMs4P0lQyB8Cx180JSV6EkWFDORMeIrtrfw/ztnw/O1OwTRbRSiqRctS3mH5
	 4XXcMIBB1gkqUxNwdU6gvFlROJuHL3dMcV5CZMxRH9Th8jrsP+5V75FD5f7eh39W2nnC5
	 dk+qNGCqNLKK7+qmPiAdCgg0cAxkIeH9XzFERCvW1R3WHXe755Vha6lzB0xJsdXMKG8WB
	 +WhHPx/8k/glLQSpRshEnjp+vlTP3aePb3j90dwhsHrY7GpfBTm1QNU9U4XsaTjKvVcgt
	 lNOjbf+EXcF2Z8B3OpZ6Vv686rvSWzGHn4VanWSwMJdDr7GN9e7TIvyL3Lfa1XxsfWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ja9VmqAG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D6606B383
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ja9VmqAG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3981F00A1C;
	Wed,  4 Nov 2026 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820101;
	bh=uU9s9C1o+HyqlrWjOAZmUUUB8ZRG2Mo4Mxxh4trltwU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ja9VmqAGG593uWGkxxRlyRxEFLZj09uTo3CWdbl+hOsRzR0jNMjBPea3YHkOv79OC
	 JCfb8k82UQgjgLMY+rsHSAc34OwVlJGPNDov7LCYE3gqRNc874CJZ5hBQD3fjEcc6a
	 uIIP8INSthH9EAgMn55cnEzz0aTJD2fmOuPV+GwrDnJrgyw7WpmaD88e5aOhnK2Iau
	 rFr5qgN89dYizUJaa9pQz7X9QnTKHD6TPOoS9wzOBFEV+bUCqI65J6FncJpeKav3Zk
	 +8InNPfpi2e2lde5yWljQORcuwcRyEAHG+Cs00zii4P7eXLZYZNUWAnquXS1dU4U0Z
	 Mh0ChEIF36sog==
Message-ID: <sashiko-outbox-197940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 2/2] selftests/bpf: Check bpftool batch map
 dumps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>, bpf@vger.kernel.org
In-Reply-To: <4b2b24fdabd4cdef1364a8664d7d9615e960c72c.1793818387.git.hi@tychen.cc>
References: <cover.1793818387.git.hi@tychen.cc>
 <4b2b24fdabd4cdef1364a8664d7d9615e960c72c.1793818387.git.hi@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:21:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: async rhashtable resize race on RHASH dump in run=
_case()
--

commit 6de2831c6843be67feeb4ee441d5b150a4946b8a
Author: Tianyi Chen <hi@tychen.cc>

selftests/bpf: Check bpftool batch map dumps

This commit adds a BPF selftest that verifies bpftool batched map dumps
produce the same plain and JSON output as individual element lookups across
supported map types, including fallback handling when batch lookups return
-EBUSY.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c b=
/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
> new file mode 100644
> index 0000000000000..5cf764bb5e362
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
> @@ -0,0 +1,228 @@

[ ... ]

> +static void run_case(struct bpftool_map_batch *skel, const struct dump_c=
ase *test,
> +		     char *expected, char *output)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	int fd =3D -1, inner_fd =3D -1, cpus =3D 1, cpu;

[ ... ]

> +	if (test->type =3D=3D BPF_MAP_TYPE_LPM_TRIE || test->type =3D=3D BPF_MA=
P_TYPE_RHASH)
> +		opts.map_flags =3D BPF_F_NO_PREALLOC;
> +	max_entries =3D test->entries ?: 1;
> +	/* Leave room for per-CPU LRU free lists instead of testing eviction. */
> +	if (test->type =3D=3D BPF_MAP_TYPE_LRU_HASH ||
> +	    test->type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH)
> +		max_entries *=3D 4;
> +
> +	fd =3D bpf_map_create(test->type, "batch_dump", test->key_size,
> +			    test->value_size, max_entries, &opts);

[Severity: Medium]
Can the rhash subtest in test_bpftool_map_batch() race with asynchronous
rhashtable resizing during check_dump()?

In run_case(), opts.map_extra is left at 0 when creating a BPF_MAP_TYPE_RHA=
SH
map with 100 entries. In the kernel, rhtab_map_alloc() passes
params.nelem_hint =3D (u32)attr->map_extra to rhashtable_init(), so the
rhashtable starts with the default 64 buckets (HASH_DEFAULT_SIZE).

During the 100-element bpf_map_update_elem() loop in run_case(), inserting
the 49th element exceeds the 75% load threshold (rht_grow_above_75()) in
__rhashtable_insert_fast() and schedules rht_deferred_worker() on system_wq
to resize the table from 64 to 128 buckets. Inserting the 97th element then
exceeds the 75% threshold of the 128-bucket table and queues a second
asynchronous resize to 256 buckets just three updates before check_dump()
runs:

run_case()
  bpf_map_update_elem()
    rhtab_map_update_elem()
      rhashtable_lookup_get_insert_key()
        __rhashtable_insert_fast()
          if (rht_grow_above_75(ht, tbl))
            schedule_work(&ht->run_work); -> rht_deferred_worker()

If rht_deferred_worker() runs concurrently with or between the bpftool dumps
in check_dump(), can an in-flight rehash cause bpf_map_get_next_key() to sk=
ip
or revisit elements (failing the individual_lookups assertion), or finish
rehashing with a new hash seed and bucket count between the individual dump
and the batch dump so that their iteration order differs (failing
check_same() on batch_output)?

Would setting opts.map_extra =3D max_entries for BPF_MAP_TYPE_RHASH avoid
scheduling background resizes by pre-sizing the rhashtable to 256 buckets at
creation time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793818387.gi=
t.hi@tychen.cc?part=3D2
