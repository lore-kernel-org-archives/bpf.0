Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555F3B8921
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669867; cv=none; b=HQl/oKVZ/ehOy8kv+T5DcOpl/TL+XNghGk5Sn5oB3rUQuatiZQNUyl5fAaFPrWDniAbfAmq7J84g6CWRrsJA05jKPolBZRiH20+IdZYmTrQRigxORVNN+TlK1mcmcod1Fgluw7vbWX9aBHRlfO4Thv9admq1c9ZKI8eSDwrWxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669867; c=relaxed/simple;
	bh=jWHrHLUA0XAdQ6FrMHpGA0niKWdjG4eYNFrXMypc/bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ui5ckw3XS3ujtomxGKtlPyQb3cV4XlXYqXJdfFkcludSN09CzYNlFie+DRpe8+c2ubTsNJpYG+SA/BenR0vWBvM8wicu7B5ZYTcoQTPaHo+PefmmqCSQXcUZlK+UQ1qEpBuuL7zWPHj/gJm8eaMGnQQ0wAYObk6XhFT3y0hD3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B51IbvS5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B51IbvS5"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec4639953dso338943466b.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780669865; x=1781274665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkRYOYq8QjeI8NvdQ6nqQjhp1Ulgc3imvtojJqTYeqQ=;
        b=B51IbvS5MOxk+4ThjixrJMSiKyFnwsMVx8vyr8GxpJoiZCUpRUKTqFsXKX3s20ibOn
         R1MLGnCF2AmD9YviudNgkGuO3i2gRUTHwlgQCLolkQOxg5uSeSO5eTkisAUYLpN53ELN
         HmXL9gUnlu4tGXQ4cAKtx9ztw14+s3aREcnI5lCucgkRiyZjnCBSJFPev0oVqTitGSjl
         OBeu9vjJMj8bhtEU3Nfjr7WBCQ+Raeo2urLMB/Vsu2dtGbBJmTRJVaDjHhmxBQzbDEtC
         Vm0sldvrYOCH2GLQCOuWNCwKwqaDtKDPzLwerhfpCWjMaZJm+a1OfXCSfZ+yw7QnxYxu
         Xk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669865; x=1781274665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkRYOYq8QjeI8NvdQ6nqQjhp1Ulgc3imvtojJqTYeqQ=;
        b=ZctNNTd8iah5rs+v7biQjzzAfERuGxWRB0PMVwMs87p3vWIAbsXEzzeIRB6NV/Afgq
         ORVfGpuLedJnA0WyFv3TokvvnVxovSzwtip03pMkjPAjtCEnHOcEmyK0EqVtPcXkB3Jr
         VTnKbzOdlDCpmuJ7/7MhBmIrkj5ZPJl2I0GO+jyr9crvNq/azehV+Uw71Bid/UkQdGEG
         U1BNh6zaXeuPFpJyiRerQXgimxe1+Usng8B7tcJPCZsmBWr/TW7jS/Fd6l0xmBY6Qm4G
         g4XpBZkuvLfqP2NZbtSMZKyH0FdwGZWYPctRB+JUGjoeVgjhe0bW0YDqCYw6PEsVmUmP
         0NNw==
X-Forwarded-Encrypted: i=1; AFNElJ8sej4yPZQp65G9NoSXHLYF7nUYGWDHdEJ4tsV0hU5vvo4/3CaRoMxl9VNWYnDaLat1CQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfdtqMC48IQWZ/+mjoiHD+V4gnzt4k2EI/m1UhC61UPFwF3dZf
	WwhcIaCuPytASWNVPctUbN7KJuUTJ/meiZm67zUFmWxZKbEikbdf9l8b
X-Gm-Gg: Acq92OH3DssTmlIPbTHorJgiG1cIxrX7b7kooo25qmOLEiifu8bmApYu4vxC+zFqm/R
	NNWMMy33cnOeNhs7lW2Wt7xJrE1mJxbErUZfzT9lEvEu90KJWhnxyXY5xdvVBURVtkJsv7HzT8s
	cBjjOYszgYo55FgBDiuEE2STvqeEZKRwjZX5qtLkRPvZq868MhcXYEW27dtTMN2zZ1K7hffc9Ih
	QcLr+RtqKxdXDmCHj0hE3NwgDSHKD51GbS2H3ELQ0Nrx+a3+xCdWA9npaA1HPPqOkAKIy2NS5mA
	1iEuXuGkdlkDk5JVwg3tEn8csn8v0k2soy7todZJ0SF7/lpXAfj7436aeKRE4APvbWPZtWoktTr
	u+dPi/Te6vWWQMiwJSThyLdcsoavt7jxUTd17VDqJRp0XgecpMt25l0AAxQ0xtiK4ugI51PP+oO
	iu3UvbXsYICZG/icS2/cClCcw8dm4tX01u/Mpvi0+IWf1mlTjHvgHiUrt4R/BVTdTNnNL7V5FOW
	RXdWJ2YJt7Lg0gvjh4UCA==
X-Received: by 2002:a17:907:970e:b0:bec:d5e1:5aee with SMTP id a640c23a62f3a-bf372446932mr236229466b.34.1780669864530;
        Fri, 05 Jun 2026 07:31:04 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0553fd86csm469474866b.46.2026.06.05.07.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 07:31:03 -0700 (PDT)
Message-ID: <d12081a0-b933-44cd-8c46-5d7b83cf0347@gmail.com>
Date: Fri, 5 Jun 2026 15:31:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: add arena split and fork tests
To: Ruslan Valiyev <linuxoid@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 martin.lau@linux.dev, memxor@gmail.com
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com
References: <DJ0F0WFEP78A.1VV9Z7T71JJX5@etsalapatis.com>
 <20260605115713.3224051-1-linuxoid@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260605115713.3224051-1-linuxoid@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 12:57 PM, Ruslan Valiyev wrote:
> Add two tests for an arena map's mmap()ed region: arena_split checks
> that a partial munmap() that would split the mapping fails with -EINVAL,
> and arena_fork checks that a forked child does not inherit the mapping
> (mincore() reports the range as unmapped).
> 
> Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
> ---

Two tests are quite small and share common setup. Does it make sense to
put them into the same file, extract common function and turn them into 2 subtests. 
You can check other BPF selftests to see how to implement subtests.

> v2:
> - Drop the regression-test framing and per-callback details; use
>   short one-line comments.
> - Split into two separate tests, arena_split (partial unmap) and
>   arena_fork.
> - Unpack the mincore() child check into explicit statements.
> 
>  .../selftests/bpf/prog_tests/arena_fork.c     | 53 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/arena_split.c    | 34 ++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_split.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
> new file mode 100644
> index 0000000000000..bb134e9adb607
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +/* Make sure an arena mapping is not inherited across fork(). */
> +
> +#define NR_PAGES 3
> +
> +void test_arena_fork(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
> +	long ps = sysconf(_SC_PAGESIZE);
> +	size_t sz = (size_t)NR_PAGES * ps;
> +	void *area;
> +	int fd, ret, status;
> +	pid_t pid;
> +
> +	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_fork", 0, 0, NR_PAGES, &opts);
> +	if (!ASSERT_OK_FD(fd, "arena map create"))
> +		return;
> +
> +	area = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (!ASSERT_NEQ(area, MAP_FAILED, "mmap arena"))
> +		goto close_fd;
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		unsigned char vec;
> +		int rc;
> +
> +		/* If the mapping was not inherited the range is unmapped in
> +		 * the child, so mincore() fails with ENOMEM. A success means
> +		 * the child wrongly inherited the mapping.
> +		 */
> +		rc = mincore(area, ps, &vec);
> +		if (rc == 0)
> +			_exit(1);
> +		_exit(errno == ENOMEM ? 0 : 2);
> +	}
> +	if (ASSERT_GE(pid, 0, "fork")) {
> +		while ((ret = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
> +			;
> +		if (ASSERT_EQ(ret, pid, "waitpid"))
> +			ASSERT_TRUE(WIFEXITED(status) && WEXITSTATUS(status) == 0,
> +				    "child must not inherit arena mapping");
> +	}
> +
> +	munmap(area, sz);
> +close_fd:
> +	close(fd);
> +}
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_split.c b/tools/testing/selftests/bpf/prog_tests/arena_split.c
> new file mode 100644
> index 0000000000000..8a59cfdb2ef89
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_split.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +
> +/* Make sure an arena mapping cannot be split by a partial munmap(). */
> +
> +#define NR_PAGES 3
> +
> +void test_arena_split(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
> +	long ps = sysconf(_SC_PAGESIZE);
> +	size_t sz = (size_t)NR_PAGES * ps;
> +	void *area;
> +	int fd, ret, err;
> +
> +	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_split", 0, 0, NR_PAGES, &opts);
> +	if (!ASSERT_OK_FD(fd, "arena map create"))
> +		return;
> +
> +	area = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (!ASSERT_NEQ(area, MAP_FAILED, "mmap arena"))
> +		goto close_fd;
> +
> +	ret = munmap((char *)area + ps, ps);
> +	err = errno;
> +	if (ASSERT_ERR(ret, "split munmap"))
> +		ASSERT_EQ(err, EINVAL, "split munmap errno");
> +
> +	munmap(area, sz);
> +close_fd:
> +	close(fd);
> +}
> 
> base-commit: 174914ea551314c52a61713b9c4bde9e42d48073

