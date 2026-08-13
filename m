Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C038494A19;
	Thu, 13 Aug 2026 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638399; cv=none; b=lICvFn73zSjkYaVNDN4Uu4byBSA/iOo8EFU8VCGYdQY7RbYFLuZSymHDApYSUizIi6bLYUb+sdQD8eF3+bQUQhHO8cDEepfMGE2OTaZ9l7thOvenXM6RvOp+LkCpXgE75XRU+rlP2mP+Jc5bKTY8OLtu6W+p6yKrMGoFaIXB6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638399; c=relaxed/simple;
	bh=3viJ+U6Im457zuO4zp/pN3zOtDF5bXAuYSPyM/HJj1U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Rug/32JGRVIUP3FQkfzgyy78D4QzrVSXMrdM/TlJnxYofcQHiuh3vdLo4gzWJ7nh0aTAP/zJKGI+adP0+0H6aMXfVHODEyyx/KqEqvHC55AeHnCpyAWtz76/0rzqAWmeFiMUKc+1ar7e6LClqFxX0mM6DGluMXjq6WPRHSdSGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0h5Z8+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0h5Z8+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD071F000E9;
	Thu, 13 Aug 2026 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638391;
	bh=Wdk1e5FLQH7EBUx53jHiruEgvRSKARms+mqv1lqcbyc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=o0h5Z8+1Rgca5V3xwsZcKmc5p9bON3cIOULbviL3tNv7LeZbw6wRUk0Zea1l1vaxT
	 IT7nM4mjArD/4DHvmswRflWcH68rSOf+wwGh++O1zeBhuWRa9kx//I+sN9aCFK6Ppa
	 /v334tuQlat8mAm56rKprY8SrdDfi9V5PS2v2c3eV6jhivS/T5tBkTxOV7Vx8z6/VV
	 CuwWD1FcxR6eutdfCSwS1dnRZSPR+Br7ijMP4m8lElXjaXUpxws67ByvVZuIu3v116
	 SgV+m3kOXSCY2C+liCa9Vey53MAaX2vbOz9fa/KPUGNHec4wp5s77EaEYA2dhBxOcX
	 UX1IIITeHMdRw==
Content-Type: multipart/mixed; boundary="===============4818090833141130813=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bd01566fa68ef3b993bdd4cfbd9802a24cd9b5052b5a746712067d8571ea0bd0@mail.kernel.org>
In-Reply-To: <20260813152324.97937-11-leon.hwang@linux.dev>
References: <20260813152324.97937-11-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 10/10] selftests/bpf: Verify bpf_iter for global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 16:26:30 +0000 (UTC)

--===============4818090833141130813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index d308ca3b30457..7d6bda9092954 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -327,6 +327,56 @@ static void test_global_percpu_data_verifier_log(void)
>  	RUN_TESTS(test_global_percpu_data);
>  }
>
> +static void test_global_percpu_data_iter(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	struct test_global_percpu_data *skel;
> +	union bpf_iter_link_info linfo = {};
> +	struct bpf_link *link = NULL;
> +	int fd, num_cpus, len, err;
> +	char buf[16];
> +
> +	num_cpus = libbpf_num_possible_cpus();
> +	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
> +		return;
> +
> +	skel = test_global_percpu_data__open();
> +	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> +		return;
> +
> +	skel->rodata->num_cpus = num_cpus;
> +	skel->rodata->offsetof_num = offsetof(struct test_global_percpu_data__percpu, struct_data);
> +	skel->rodata->offsetof_num += sizeof(skel->percpu->struct_data) - sizeof(int);

This isn't a bug, but could these two lines collapse into a single
offsetof(struct test_global_percpu_data__percpu, struct_data.nums[6]),
so the offset names the field being read instead of depending on nums[6]
staying last in the struct?

> +	skel->rodata->elem_sz = roundup(sizeof(struct test_global_percpu_data__percpu), 8);
> +	skel->percpu->struct_data.nums[6] = 0xc0de;
> +
> +	err = test_global_percpu_data__load(skel);
> +	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
> +		goto out;
> +
> +	linfo.map.map_fd = bpf_map__fd(skel->maps.percpu);
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +	link = bpf_program__attach_iter(skel->progs.dump_percpu_data, &opts);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
> +		goto out;
> +
> +	fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(fd, 0, "bpf_iter_create"))
> +		goto out;
> +
> +	while ((len = read(fd, buf, sizeof(buf))) > 0)
> +		do { } while (0);

This isn't a bug, but would a bare semicolon (as in bpf_iter.c's
read-drain loops) be clearer here than do { } while (0)?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> index d086e9417f9fb..71ff8d1bf49eb 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> @@ -61,4 +61,29 @@ int verifier_snprintf(void *ctx)
>  	return 0;
>  }
>
> +volatile const __u32 num_cpus = 0;
> +volatile const int offsetof_num;

This isn't a bug, but would a name like nums6_off (set directly from
offsetof(struct test_global_percpu_data__percpu, struct_data.nums[6]))
make it clearer which field the iterator is summing?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31716447858
--===============4818090833141130813==--
