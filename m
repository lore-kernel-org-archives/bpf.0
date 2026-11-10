Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329215;
	b=1QEw/fDOTxXatGYW6KgcIlfN/UqsbqyCiAaoEQvrhGgBAuYrddamtpyOTbtLdPaVyINX
	 kfb3K3AjO/qGeqZXmTafETjOc7PaTBMQO5rgSeDzzlWtBEJE8CSsNeyunGNg5SDjWkBwj
	 Mga+Bzos2rofgShwS3Fg+0Xn841HZiEBISBLx1beSBlnE3+CtFxkJlL3IMB++WD2QW64e
	 Yskee09eShwXZ10CQm5Y0VCqCHFDpuzrkC1aT8+qhrBtDfL9xFDSmW9qfsBYB+sqS5bRN
	 e/OkoSZCg+/EN6VMJRWU+MmRxiwxSVByzJcztJvDiw3oFiNcmuNabbk2mo+LhsoxOCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329215;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mgYDBwL3t2ZWVsbpa7bCSIH5rIRHkEyd38LzWhc7YQU=;
	b=wQw9yc9yG/yeEQD2Vwh/0x+Q1dgw782pWlaThJd/pLmCwKQhKP2KIh8emb41P4r9vQL/
	 2nKsYKHfjHk2kbVTsY1pHPmqQYfpv0xG2e1TRw9QY/1LO4oBTv4VW1IZ5MMVOSd1BxCzd
	 xcOXhXr7jfqXb9ZISRLk91zkprmrUOLDN2mydQathLyf9H8biK7xubUNi19sPtrvioELo
	 J1YGWaTQ4a/eL8A6t7qSyprNCHRUQtO+qsQ4+chhu4nA1a9sjAyxpc91WOdEK7dmyuEHv
	 cerZbCG28lcqEwR9m5Iui/SYUGUzYdI8+MkI7ys9A0c8IvfoqbZLKcalr/ampYonKfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCr7enKn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C943606A337;
	Tue, 10 Nov 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCr7enKn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC411F0089F;
	Tue, 10 Nov 2026 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329214;
	bh=mgYDBwL3t2ZWVsbpa7bCSIH5rIRHkEyd38LzWhc7YQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XCr7enKnWsrAipMWLDNpTp6sLFZS0sKTQvZjmmF7+1Fj8O3CB3f8YH+jI6EmZFjpo
	 7EPCK7IyLT46dg5M52aQfoX5RSAp9Z+IH3VK4DedDAlbBZMb4uF8q9iXikitC09s0P
	 ovLiiWRSLDXXoT4ZLxklGStTWPCht/mxpeC+WGMKSyFNr8GQRrv1Pos5RbB5cpW/Am
	 I4Sjhsr7xuQLcfyVTepE4vDaicB9xouyHIrFOi9AXfKNAERayCEDTed/rPFPeYKT9g
	 GIyXjvkm2o1gQjbdNJfGmD0qFEcAP5gep2pDc/suvk8YRP/JayTM0Ooq62rJ9eSnFR
	 ME/iZWDRsnkYw==
Message-ID: <a24ec940-ca3b-419b-85ae-9de88cd991d9@kernel.org>
Date: Tue, 10 Nov 2026 16:46:53 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 2/2] selftests/bpf: Check bpftool batch map
 dumps
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, alexei.starovoitov@gmail.com
References: <cover.1793821981.git.hi@tychen.cc>
 <e4cd18723b893385d66232276f44049bb86c8e51.1793821981.git.hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <e4cd18723b893385d66232276f44049bb86c8e51.1793821981.git.hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 19:54, Tianyi Chen wrote:
> Batched dumps must print the same output as individual lookups. Use an
> fmod_ret program on security_bpf() to count the map lookups made by
> bpftool children of the test, and to fail batch lookups with -EBUSY.
> 
> For each map type with batched lookups, compare plain and JSON dumps
> with a dump whose batch lookups all fail, and check that no individual
> lookups were needed. Cover BTF and per-CPU output, an empty map, 1-byte
> keys and unaligned values. With 4 KiB values, check dumps that need
> several batches, and that failing the first or second batch lookup
> continues with individual lookups without restarting the dump.
> 
> Pre-size RHASH maps so asynchronous growth does not race with the
> order-sensitive dump comparisons.
> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>


Acked-by: Quentin Monnet <qmo@kernel.org>

... with a few, non-blocking suggestions, inline below.


> ---
>  .../bpf/prog_tests/bpftool_map_batch.c        | 231 ++++++++++++++++++
>  .../selftests/bpf/progs/bpftool_map_batch.c   |  42 ++++
>  2 files changed, 273 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpftool_map_batch.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
> new file mode 100644
> index 0000000000000..4cca77f410a06
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c


Maybe bpftool_map_dump_batch.c, so it's easier to visually group with
the existing bpftool_map_dump.c?


> @@ -0,0 +1,231 @@

[...]

> +void test_bpftool_map_batch(void)
> +{
> +	static const struct dump_case cases[] = {
> +		{ "hash", BPF_MAP_TYPE_HASH, 4, 4, 100 },
> +		{ "empty", BPF_MAP_TYPE_HASH, 4, 4, 0 },
> +		/* The hash cursor is wider than the key; values are unaligned. */
> +		{ "odd_sizes", BPF_MAP_TYPE_HASH, 1, 3, 100 },
> +		{ "btf", BPF_MAP_TYPE_HASH, 4, 4, 100, true },
> +		{ "lru_hash", BPF_MAP_TYPE_LRU_HASH, 4, 4, 100 },
> +		{ "percpu_hash", BPF_MAP_TYPE_PERCPU_HASH, 4, 3, 100 },
> +		{ "lru_percpu_hash", BPF_MAP_TYPE_LRU_PERCPU_HASH, 4, 4, 100 },


If I remember correctly, lru_hash/lru_percpu_hash are mostly the same
code as hash/percpu_hash, so I'm not sure they're worth testing, unless
you want completeness.

You could also avoid checking both plain and JSON for all types (pick
one, and just do a few check for the other?), if you want to save some
bpftool invocations; I don't expect differences in the code related to
batch lookups between the plain and JSON output printing code.


> +		{ "btf_percpu_hash", BPF_MAP_TYPE_PERCPU_HASH, 4, 4, 100, true },
> +		{ "rhash", BPF_MAP_TYPE_RHASH, 4, 4, 100 },
> +		{ "array", BPF_MAP_TYPE_ARRAY, 4, 4, 100 },
> +		{ "percpu_array", BPF_MAP_TYPE_PERCPU_ARRAY, 4, 3, 100 },
> +		{ "lpm_trie", BPF_MAP_TYPE_LPM_TRIE, 8, 4, 100 },
> +		{ "array_of_maps", BPF_MAP_TYPE_ARRAY_OF_MAPS, 4, 4, 100 },
> +		{ "hash_of_maps", BPF_MAP_TYPE_HASH_OF_MAPS, 4, 4, 100 },
> +		/* Bucket and key cursors, up to 255 entries per batch. */
> +		{ "multi_batch_hash", BPF_MAP_TYPE_HASH, 4, 4096, 256, false, true },
> +		{ "multi_batch_array", BPF_MAP_TYPE_ARRAY, 4, 4096, 256, false, true },
> +	};
> +	struct bpftool_map_batch *skel;
> +	char *expected = NULL, *output = NULL;
> +	unsigned int i;
> +
> +	skel = bpftool_map_batch__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +	skel->bss->test_tgid = getpid();
> +	if (!ASSERT_OK(bpftool_map_batch__attach(skel), "skel_attach"))
> +		goto out;
> +	expected = malloc(OUTPUT_SIZE);
> +	output = malloc(OUTPUT_SIZE);
> +	if (!ASSERT_OK_PTR(expected, "expected") || !ASSERT_OK_PTR(output, "output"))
> +		goto out;
> +
> +	for (i = 0; i < ARRAY_SIZE(cases); i++)
> +		if (test__start_subtest(cases[i].name))
> +			run_case(skel, &cases[i], expected, output);
> +out:
> +	free(expected);
> +	free(output);
> +	bpftool_map_batch__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpftool_map_batch.c b/tools/testing/selftests/bpf/progs/bpftool_map_batch.c
> new file mode 100644
> index 0000000000000..0ca6f7973e880
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpftool_map_batch.c

bpftool_map_dump_batch.c?
