Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A832861F
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670997; cv=none; b=SwZ4hstP7UabdbIQZ7w1N4jD5+zUQ54Gy7HWD/EKZSeOyTE4OfW3jEIUrES+IZ82zi/5HDBQNcCtch2mObWh4zxj8ZKEy6LJecVqQKo6u7N0WMLd5+NBJw+CcC5tV2n8+G61NyFzCva2wHtTKdpBnBEXCnLrmaK1VlIurBD5PKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670997; c=relaxed/simple;
	bh=hh/jG9z7Uw3vguED7ipaFPfR2knEKJa9dX9UcNVx/Xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QmhaOP9ejvnX6t49xPAlLugvjRFr0/jcUMLsnJGBjrMrYdrG/iJis8kUFZgpWWn5Ino+cKlae4c7bK5Rtw9vCNfB9fKe+bdtYR35siENu/mA3QzEJyq5KprCRpxEXYHP3jVi/j+yx8RCDz5iccA2Odu8riRNletxWmO8wY9ZDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brMSaeLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brMSaeLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BB21F000E9;
	Fri, 14 Aug 2026 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670989;
	bh=8Siug6toQ/JHfDMA5ghl+7FApJw6AmiwPjVz+UlSfx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brMSaeLtuPqMjVlvKGLgu5eh3Xiv4dbrgbHF/U4+uiAnsZZ+jQD+4BqUlI58irHQA
	 +EJOVC9X89iyjw7zIV1odM52sc1lJ+dQJtz8a5XXHRH2im/00Mgve5Qa9FJcEJ5jpw
	 3xQvtvRToujyGd7wr4yV7LA+YFGcXD9nnRD2xZMj2lHq5CGqrsLRIkO6+0btihRwKd
	 49EFsfS8sjjGkIrLQr00/DO4YtgrQ40RgQ70UmZGsEBhBRPITvMFBN6At2lF/jGtPz
	 GzZYsEWhJpDaUrm2txEeXfDaETCha8tuB7qU3ZWqsQLLx/3hu1XJqha2QQNqj1jg0O
	 eqswQPB1bHkGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Retry stat generation in
 cgroup_iter_memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813213701.3116369-1-andrii@kernel.org>
References: <20260813213701.3116369-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:29:48 +0000
Message-Id: <20260814012948.D7BB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The retry loops in test_anon and test_file destroy the memcg sta=
te before waiting for the periodic flusher, causing the tests to reliably f=
ail. Additionally, test_file uses a flawed retry condition.
--

--- Patch [1]: [PATCH bpf-next] selftests/bpf: Retry stat generation in cgr=
oup_iter_memcg ---
commit 6d80dc385d952485dfd4001f328081e6d5523309
Author: Andrii Nakryiko <andrii@kernel.org>

selftests/bpf: Retry stat generation in cgroup_iter_memcg

This commit introduces retry loops in the cgroup_iter_memcg selftest
to wait for the periodic memcg stat flusher. This addresses test failures
on large core-count systems where a single pass does not reach the flush
threshold.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b=
/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> index b7c18d590b993..37e2cf249be8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
[ ... ]
> @@ -53,6 +66,12 @@ static void test_anon(struct bpf_link *link, struct me=
mcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup;
> =20
> +	if (!memcg_query->nr_anon_mapped && ++retries < MEMCG_STAT_RETRIES) {
> +		munmap(map, len);
> +		usleep(MEMCG_STAT_RETRY_DELAY_US);
> +		goto retry;
> +	}

[Severity: Medium]
Does unmapping the memory before sleeping prevent the periodic flusher from
observing the mapped state?

If the mapped memory is unmapped via munmap() before the sleep, the periodic
flusher running during usleep() will observe a net-zero state for
nr_anon_mapped. The retry loop seems to repeatedly map and unmap the memory
without letting the flusher see the steady state, which might prevent the t=
est
from ever succeeding.

[ ... ]
> @@ -88,6 +109,13 @@ static void test_file(struct bpf_link *link, struct m=
emcg_query *memcg_query)
>  	if (!ASSERT_OK(read_stats(link), "read stats"))
>  		goto cleanup_map;
> =20
> +	if (!memcg_query->nr_file_pages && !memcg_query->nr_file_mapped &&
> +	    ++retries < MEMCG_STAT_RETRIES) {
> +		munmap(map, len);
> +		usleep(MEMCG_STAT_RETRY_DELAY_US);
> +		goto retry;
> +	}

[Severity: Medium]
Could this condition cause the retry loop to exit prematurely?

In this path, munmap() removes the mapping but leaves the file in the page
cache. The periodic flusher will flush a positive nr_file_pages but a zero
nr_file_mapped.

On the next iteration, memcg_query->nr_file_pages will be non-zero, causing
the && condition to evaluate to false and the loop to exit early before the
mapped stats are satisfied.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813213701.3116=
369-1-andrii@kernel.org?part=3D1
