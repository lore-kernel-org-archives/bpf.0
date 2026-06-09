Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5ED363087
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030408; cv=none; b=N/fatnsw7Jzgtyz3ZcDRdlJ/404rKdNGO8QIlZs9X9YZA41P+jMQxHxUhzhuV+JywKCbim7+KFjFH6z5Btfla98E25174rBvma7eCEkpoA9UHKmx3FF6njmPdKNghRJbR3lOG1ePrbZR62rl5tEQWB0w9uF6vglN5zAsI2GKy0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030408; c=relaxed/simple;
	bh=KxcRlVXdhzyTftXTuirhm/LpEsvJti2IkH63RC84v/A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k2SairlSXEdL0YFyWpoAvHS1eGiOsNoDAZucWCD8V9N950XBB+MSJIGjxOWQ7AUuyVWoNPaQU/vpy1quccVMqL2Gp3CzzbiIGW3d3z4wihJ2AG5BVcVQEjibBq6+y5VwLhPg6OqHylYhZGy6M8xTAVLDyH10/6jxEfMiYHELyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gR8vZZn3; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gR8vZZn3"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-307d0405e07so1570415eec.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781030406; x=1781635206; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxZdzUXTKoVzY8ECTZacPVb3vRrlTkx7Oijlt3fiTlg=;
        b=gR8vZZn3HvnlPrIndunFV+wBaG6Q80/RDIqQN5IhYACB6r/+KMwRTyq4m96OmYzLlJ
         KTuxHaSiPRs07NoW5T5X8zMFSjRznBydVNdsYpeZD7voYYa12zcQlZnq5J0qD2SmUv7w
         Y73v9+u4q9EyuuK7+HrfRphjMvXyMP/FA2S/bm+GXse/j5Xq1ZTt5bqtbtt1PUMO92uD
         upXpAaCkrXQHXVUD3prAV4hApAV7OpNJICRUJPGPzuC94qK86yRSMgZxT4aaB5ON3w3j
         /As0Cnl1vCNBIzqminxURIjRW2TzlNJUy9O1Oigg0dJfW+vXCa44Rey7vXsszYKfKj3F
         lqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030406; x=1781635206;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxZdzUXTKoVzY8ECTZacPVb3vRrlTkx7Oijlt3fiTlg=;
        b=dd348CLuc1/OwIzzrJCPOJsRwKr3mnXbGP63MFPZJz7R2/KoWKWamXFIrZBFPzmkr6
         EdTrUkcLNQyA9ETNoBgl6kQFnrB7FdqYOGeawudZ5pBO2a5fTnW81rnzHB/MvvQsWwfn
         Bz+/HAXRGJfwTWf2AoE5zMq4YugmN/Ql4fF4hhMuzz4ZereXQEGKWUqYlM6DixktGjFk
         +523InV08M7/m5xpO1FO3fflIDM31VUY+mwJWayks59B16qZ0TJwrr6pE5w01hdcb8Uc
         +AfqWBGQtSg6H54vMTrBmCOCd5E/+aav9FQvB8PqZuGEUe6SxRUy+fDD8xOXwKb/ywo2
         ia4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Z9j61J0DeggVYD7VouI9eTu5EgXsWEYuqIOaWQcUbJjVEIkZQp0zc4/41zfLyCxwbYrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9JQ51iRD/O0hj8WzIbIlpJKYxAViRJGtA0XEtvEIYNziofrK
	l/41ZU1ZOpe8VY1I+VwpQjlYU34wAruRHOw2/c3AJYiOi+WZdM/sxpgzC5c3h5bkvgI=
X-Gm-Gg: Acq92OHiJHUZTRQ3kqMGgMknbU8nG4O9Gbl3/Hn+g2B894LaH4Sy/838//E0/3M8ask
	FIaxmAZEZI7usiM1cv60ITVDvYZDVXSPmo5mjDL5oIcwx12yiDK3le6ZdNqfmLEOuwRF2Buo7zi
	avKqiZEp0FK6tZhmfJJ/dZDcph7ikt4pAiNZd0x3Q9aah1OtTCgkcWifoIQ5Izgfc2jRxkZJhyw
	aRnBQ7/w/3biPNorrCaTDAVXy8HKOPdsH8tiJH9FmF02IXpdPWtke01uMTqEHvVx4pxomnszTiy
	kMk/N7hMD/YM92iX3GyzkQy9Z31BuFg/g0EYAzdBZ0loq7I1ideCND8KEIdcIcIiOYOB7TLkgGV
	ay8Qj/mEe5n/E/FwIl+MyM161w3djQ0vLcO82iHMVTyZYkDGDZ2DTnzd3J2T1JEshI3PvaoOQl0
	cd89JhN2o8fGa8mhKYpNGLWY19fA==
X-Received: by 2002:a05:7300:8cac:b0:306:f474:738c with SMTP id 5a478bee46e88-3077b084d97mr12702339eec.13.1781030406061;
        Tue, 09 Jun 2026 11:40:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3297])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm32039312eec.11.2026.06.09.11.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 14:40:03 -0400
Message-Id: <DJ4QL4538Q8K.1CQO51UWYJQ2J@etsalapatis.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: add tests for arena vma
 split and fork
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ruslan Valiyev" <linuxoid@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <martin.lau@linux.dev>, <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <d12081a0-b933-44cd-8c46-5d7b83cf0347@gmail.com>
 <20260609083709.168755-1-linuxoid@gmail.com>
In-Reply-To: <20260609083709.168755-1-linuxoid@gmail.com>

On Tue Jun 9, 2026 at 4:37 AM EDT, Ruslan Valiyev wrote:
> Add a test that an arena map's mmap()ed region cannot be split by a
> partial munmap() (the "split" subtest, which expects -EINVAL) and is not
> inherited across fork() (the "fork" subtest, where mincore() reports the
> child's range as unmapped).
>
> Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> v3:
> - Consolidate into one file with a shared setup helper and two
>   subtests.
> - Put the opening /* of the multi-line comment on its own line.
> v2:
> - Drop the regression-test framing and per-callback details.
> - Split the original single test; unpack the mincore() check.
>
>  .../selftests/bpf/prog_tests/arena_vma.c      | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_vma.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_vma.c b/tools/t=
esting/selftests/bpf/prog_tests/arena_vma.c
> new file mode 100644
> index 0000000000000..f6c07cd31d08b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_vma.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +/* Make sure arena mappings cannot be split or inherited. */
> +
> +#define NR_PAGES 3
> +
> +static int arena_mmap(int *fd, void **area, size_t *sz)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_MMAPABLE);
> +
> +	*sz =3D (size_t)NR_PAGES * sysconf(_SC_PAGESIZE);
> +
> +	*fd =3D bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_vma", 0, 0, NR_PAGES,=
 &opts);
> +	if (!ASSERT_OK_FD(*fd, "arena map create"))
> +		return -1;
> +
> +	*area =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE, MAP_SHARED, *fd, 0);
> +	if (!ASSERT_NEQ(*area, MAP_FAILED, "mmap arena")) {
> +		close(*fd);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +/* A partial munmap that would split the arena mapping must be rejected.=
 */
> +static void split_test(void)
> +{
> +	long ps =3D sysconf(_SC_PAGESIZE);
> +	void *area;
> +	size_t sz;
> +	int fd, ret, err;
> +
> +	if (arena_mmap(&fd, &area, &sz))
> +		return;
> +
> +	ret =3D munmap((char *)area + ps, ps);
> +	err =3D errno;
> +	if (ASSERT_ERR(ret, "split munmap"))
> +		ASSERT_EQ(err, EINVAL, "split munmap errno");
> +
> +	munmap(area, sz);
> +	close(fd);
> +}
> +
> +/* A forked child must not inherit the arena mapping. */
> +static void fork_test(void)
> +{
> +	long ps =3D sysconf(_SC_PAGESIZE);
> +	void *area;
> +	size_t sz;
> +	int fd, ret, status;
> +	pid_t pid;
> +
> +	if (arena_mmap(&fd, &area, &sz))
> +		return;
> +
> +	pid =3D fork();
> +	if (pid =3D=3D 0) {
> +		unsigned char vec;
> +		int rc;
> +
> +		/*
> +		 * If the mapping was not inherited the range is unmapped in
> +		 * the child, so mincore() fails with ENOMEM. A success means
> +		 * the child wrongly inherited the mapping.
> +		 */
> +		rc =3D mincore(area, ps, &vec);
> +		if (rc =3D=3D 0)
> +			_exit(1);
> +		_exit(errno =3D=3D ENOMEM ? 0 : 2);
> +	}
> +	if (ASSERT_GE(pid, 0, "fork")) {
> +		while ((ret =3D waitpid(pid, &status, 0)) < 0 && errno =3D=3D EINTR)
> +			;
> +		if (ASSERT_EQ(ret, pid, "waitpid"))
> +			ASSERT_TRUE(WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0,
> +				    "child must not inherit arena mapping");
> +	}
> +
> +	munmap(area, sz);
> +	close(fd);
> +}
> +
> +void test_arena_vma(void)
> +{
> +	if (test__start_subtest("split"))
> +		split_test();
> +	if (test__start_subtest("fork"))
> +		fork_test();
> +}
>
> base-commit: 174914ea551314c52a61713b9c4bde9e42d48073

