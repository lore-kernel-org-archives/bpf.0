Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086EF411FBF;
	Tue,  1 Sep 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276888; cv=none; b=SSfc8yN3jCXm/uuixAtntq25lf3T7GxsQXFqRIMtN56AaLqJBYXyIDJVD10xfOCQBEo2Z2Hu1SrMFRBvjc01/yVSUTWviyOVQD0T1EEWq0kdLthM004IQClOYRYZUJWKRT/vzO7updOsqDKHw+KPunYZvI2gja/UELzzaYvJPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276888; c=relaxed/simple;
	bh=XLuK/PZ58lDhZmg6xDRQ9In2m+ureWTnrZMeNLfg+vQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J2uF3XCerp269UwdVEYeDH0HtDDlUSTsiDp+x1fTBfI9yQ9m4N1DQDZXWGD9MR2izg05aGtsGQMqKjMjCNJnh8U7PA8u6ShihlOslI3TiUDx9Jl4uKh3d1MOm+hl73AigX9gyNCb8LDMKJIV12NzySGLTFpcyk84UAQx1dAaSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC1nNhPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC1nNhPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F48F1F000E9;
	Tue,  1 Sep 2026 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788276886;
	bh=sXDKWyKAaYd6V/9rFYp5krd/4rh/b9keSzpuKc3ug44=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oC1nNhPC8CSLvJ7DmoQa5fClWUYEKBBK8TqAd5V2p0PDokhn2XA0bHuiDnm9H9Em1
	 6YZljdShXLM7ndMP4NO8e7P4eaAmBM/HIBB7uSOPUu9C6CWSGcYFUqIzmmunUD4QDS
	 y4ekkUeYhkf3SbhBUrbPAaTLA7Q1V1oaVHszAuSksd7tlhYgScqKDP6jOaOs2dPoFJ
	 ZA+7WXtFNXR8orl5LxZY/0sjxrtUZYlZF1VjfytHrLk36rpEffDEx1vOhmjuAUHCtc
	 bW1ZDJcvTVpAcixdjZyH1nXB90TfEKyOJUSWPppPJLGSPHndcXZ3gD37WiSIZFDFAB
	 pl5P7wRY+pWCg==
Content-Type: multipart/mixed; boundary="===============4761417725018966106=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f987bc5dcd678e13cd661ba9830f30d43cf612f3ee8548020491c791c35308fc@mail.kernel.org>
In-Reply-To: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
References: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix map_lookup_percpu_elem on sparse CPU IDs
From: bot+bpf-ci@kernel.org
To: suchitkarunakaran@gmail.com,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org
Cc: emil@etsalapatis.com,ihor.solodrai@linux.dev,jolsa@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,zhoufeng.zf@bytedance.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,suchitkarunakaran@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 15:34:45 +0000 (UTC)

--===============4761417725018966106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> index bfb1bf3fd427b..849f33259c003 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> @@ -2,29 +2,45 @@
>  /* Copyright (c) 2022 Bytedance */
>
>  #include <test_progs.h>
> +#include "bpf/libbpf_internal.h"
>  #include "test_map_lookup_percpu_elem.skel.h"
>
>  void test_map_lookup_percpu_elem(void)
>  {
>  	struct test_map_lookup_percpu_elem *skel;
> -	__u64 key = 0, sum;
> -	int ret, i, nr_cpus = libbpf_num_possible_cpus();
> +	bool *possible = NULL;
> +	__u64 key = 0, sum = 0;
> +	int cpu, nr_cpu_ids, nr_cpus, ret, slot = 0;
>  	__u64 *buf;
>
> -	buf = malloc(nr_cpus*sizeof(__u64));
> -	if (!ASSERT_OK_PTR(buf, "malloc"))
> +	ret = parse_cpu_mask_file("/sys/devices/system/cpu/possible", &possible,
> +				  &nr_cpu_ids);
> +	if (!ASSERT_OK(ret, "parse possible CPU mask"))
>  		return;
>
> -	for (i = 0; i < nr_cpus; i++)
> -		buf[i] = i;
> -	sum = (nr_cpus - 1) * nr_cpus / 2;
> +	nr_cpus = libbpf_num_possible_cpus();
> +	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> +		goto free_mask;
> +
> +	buf = malloc(nr_cpus * sizeof(*buf));
> +	if (!ASSERT_OK_PTR(buf, "malloc"))
> +		goto free_mask;
> +
> +	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
> +		if (!possible[cpu])
> +			continue;
> +		buf[slot++] = cpu;
> +		sum += cpu;
> +	}

Does this buffer layout match how the kernel expects it?

The userspace side fills buf[] with one entry per possible CPU, storing
the logical CPU ID at packed index 'slot' (0, 1, 2, ...). For a mask
like 0,2-3, this creates buf = {0, 2, 3} with 3 entries total.

Looking at the kernel's update path, both percpu array and hash maps
index the user buffer by logical CPU ID:

kernel/bpf/arraymap.c:469 bpf_percpu_array_update()
    for_each_possible_cpu(cpu) {
            ptr = per_cpu_ptr(pptr, cpu);
            val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;

kernel/bpf/hashtab.c:1038 pcpu_copy_value()
    for_each_possible_cpu(cpu) {
            ...
            copy_map_value_long(&htab->map, per_cpu_ptr(pptrs, cpu),
                    value + off + size * cpu);

With the mask 0,2-3 (num_possible_cpus() = 3, nr_cpu_ids = 4), the
update walks possible CPUs {0, 2, 3} and indexes the buffer as:

  cpu 0:  *(value + 0)  = buf[0] = 0   (intended)
  cpu 2:  *(value + 16) = buf[2] = 3   (expects 2, gets 3)
  cpu 3:  *(value + 24)             (past the 24-byte buffer end)

The userspace layout is packed (3 entries), but the kernel accesses it
as sparse (indexed by CPU ID). The test sized the buffer for
num_possible_cpus() bytes, but the kernel's 'size * cpu' indexing can
exceed that when the possible mask has holes.

Should the userspace buffer either be laid out by CPU ID (sized for
nr_cpu_ids, with holes at non-possible indices), or should the kernel's
update path use packed indexing like the lookup direction does?

> +	if (!ASSERT_EQ(slot, nr_cpus, "possible CPU mask weight"))
> +		goto exit;
>
>  	skel = test_map_lookup_percpu_elem__open();
>  	if (!ASSERT_OK_PTR(skel, "test_map_lookup_percpu_elem__open"))
>  		goto exit;
>
>  	skel->rodata->my_pid = getpid();
> -	skel->rodata->nr_cpus = nr_cpus;
> +	skel->rodata->nr_cpu_ids = nr_cpu_ids;
>
>  	ret = test_map_lookup_percpu_elem__load(skel);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33521264909
--===============4761417725018966106==--
