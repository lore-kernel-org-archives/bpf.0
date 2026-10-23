Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715123;
	b=PqCIse+e5YN5LZSRTzlFQwo8LiEDIOoQfLiWLIR0sNc/PoDHoBdji/9JB8EaUlgvHJKH
	 Ec6nZhJDnaZwH6hG+cuI8niuCpAaCe8MfVNRZ7fnTswT+ObMvXk9+D5hm1DkXXv4Hu4sA
	 MU2X6ZJ0/7bdfP+SRH5nXO2IFgfuzgDsw47Eq3nlwlP/8KSRMOAstKhLl1ZVRpR4jPmLc
	 5sPH9aHY8xFT/bbERTNN0W1iPT5HwhItYnASHaLa4AB191NqFMNqNP9DQ9s6VfARbRQN2
	 pfylNkN0E5cOq7mkCMgVX8S3YqCrWlzC0bEuPPVD+u8gO6GQ/98gOFJG7HTw4NNcFrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wyu1xOC4o4z4P+RM+5EbOtREZ5dwr9M81ncT2/vacFc=;
	b=mkLC4siO+GhIfmFw+9N8MjXtWo1xyqLD+PxIUZl6DiJrS4lKZLcapuVZPUYTMZMGkSms
	 JDVWZmUw8m+2Dz0PfoFxUt5Ml3HPldDgAeZABfxrAXu7rFeSS/KtJgd9kvrHgY96PXkFS
	 ++hNUeSyhE8sDTHhF5a4KjAOt6Q8u2tIEdxUCqd6wFw7JRfWYeYsAFOclcgwCSB/dUIai
	 GqB6dyZCdbyv2QfP1fxE8XFr7VofsiEkOyBNFw+8m45qz9rT/Z7LVh3aDzA34cX4WBJLa
	 0mshpOHEXeZJ5Qr6Ah+C5j7OBtFW3uDcandxZ5jZ65bKemkPj78Y4kUepF0I7kjDYzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T98x9TSL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292D606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T98x9TSL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E291F01825;
	Fri, 23 Oct 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792715122;
	bh=Wyu1xOC4o4z4P+RM+5EbOtREZ5dwr9M81ncT2/vacFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T98x9TSL7Gyw48oIsEDCvf+1yEBAEBM5ndwG17QLe6yfzA6IBBN9HmSpplbE4MUgu
	 ZFgcRLCYqb4SQTnrMYkhmaiacowugc6pY/0RFQn1BqpkekrxzNSBs4I08ieBceQgCh
	 f59OujLF4wKYA5SDdQh9QxEJlt/R/9Efg888nniQXyy3MclYnzK6p3/XKB3nqbLoLh
	 JyvoZafA4KN+gzD9QpOAYCkW5z8K9wo1ZCRDVpzljW4CgLmkTSPfjFBNqFdvDFXVPK
	 2XpSVN/6TJcBvZruKqF5g1Mme6MZPseWFwzCwygM+9V3UAKb2/6s//ex6YsbqFTjjr
	 YLkePN/buh0uQ==
Message-ID: <sashiko-outbox-182165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/6] selftests/proc: Add KALLSYMS_QUERY
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samuel Wu" <wusamuel@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261023001603.560210-14-wusamuel@google.com>
References: <20261023001603.560210-8-wusamuel@google.com>
 <20261023001603.560210-14-wusamuel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 00:25:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/proc: main() bypasses kselftest reporting and ksft_exi=
t_*() wrappers
- [Medium] selftests/proc: main() skips silently with bare KSFT_SKIP and no=
 reason message
--

commit 309c42ade27ce014cdfb65d22ab97d40bf7dcd32
Author: Samuel Wu <wusamuel@google.com>

selftests/proc: Add KALLSYMS_QUERY tests

This commit adds a selftest in tools/testing/selftests/proc/proc-kallsyms-q=
uery.c
to exercise symbol-to-address and address-to-symbol lookups via the
kallsyms_query ioctl on /proc/kallsyms.

> diff --git a/tools/testing/selftests/proc/proc-kallsyms-query.c b/tools/t=
esting/selftests/proc/proc-kallsyms-query.c
> new file mode 100644
> index 0000000000000..229cde432d6aa
> --- /dev/null
> +++ b/tools/testing/selftests/proc/proc-kallsyms-query.c

[ ... ]

> +int main(void)
> +{
> +	const char *sym_name =3D "vfs_read";
> +	char resolved_name[KSYM_NAME_LEN];
> +	char long_name[KSYM_NAME_LEN + 1];
> +	size_t page_size =3D sysconf(_SC_PAGESIZE);
> +	unsigned long long exp_addr;
> +	struct kallsyms_query_ext q1;
> +	struct kallsyms_query q;
> +	char *page_buf;
> +	int err;
> +	int fd;
> +
> +	fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> +	if (fd < 0) {
> +		if (errno =3D=3D ENOENT)
> +			return KSFT_SKIP;
> +		ksft_exit_fail_msg("open(/proc/kallsyms) failed: %s\n",
> +				   strerror(errno));
> +	}
> +
> +	if (!find_vmlinux_symbol(sym_name, &exp_addr)) {
> +		close(fd);
> +		return KSFT_SKIP;
> +	}
> +
> +	/* CASE 1: Valid vmlinux symbol query (or -EPERM when addresses are hid=
den) */
> +	err =3D query_symbol(fd, sym_name, &q);
> +	if (err =3D=3D -ENOTTY) {
> +		close(fd);
> +		return KSFT_SKIP;
> +	}

[Severity: Medium]
In main() in tools/testing/selftests/proc/proc-kallsyms-query.c, when
opening /proc/kallsyms fails because the file does not exist, when
find_vmlinux_symbol() does not find vfs_read, or when query_symbol() fails
because the ioctl is not supported by the running kernel, the function
returns directly without printing a skip message.

Unlike the hidden-address check right below that calls ksft_exit_skip() with
a reason string, returning silently here leaves test logs with no indication
of which prerequisite was missing.

Should these three skip paths call ksft_exit_skip() with a descriptive
reason message instead?

> +	if (!exp_addr) {
> +		assert(err =3D=3D -EPERM);
> +		close(fd);
> +		ksft_exit_skip("kallsyms addresses are hidden, only -EPERM checked\n");
> +	}
> +	assert(err =3D=3D 0);
> +	assert(q.sym_addr =3D=3D exp_addr);

[ ... ]

> +	/* CASE 16: KALLSYMS_QUERY_BY_ADDR invalid inputs return -EINVAL or -EF=
AULT */
> +	assert(query_addr(fd, exp_addr, resolved_name, 0, &q) =3D=3D -EINVAL);
> +	assert(query_addr(fd, exp_addr, NULL, sizeof(resolved_name), &q) =3D=3D=
 -EFAULT);
> +
> +	close(fd);
> +	return 0;
> +}

[Severity: Medium]
Although tools/testing/selftests/proc/proc-kallsyms-query.c includes
kselftest.h and uses ksft_exit_fail_msg() and ksft_exit_skip() in main(),
it never calls ksft_print_header() or ksft_set_plan(), evaluates all 16 test
cases with libc assert(), and exits main() with a bare return 0.

When run under kselftest runners or automated test parsers, this produces no
plan, per-test result lines, or summary output on completion, and aborts the
process via assert() on failure instead of reporting structured test failure
results.

Could main() use the kselftest.h reporting helpers (such as
ksft_print_header(), ksft_set_plan(), ksft_test_result(), and
ksft_exit_pass() or ksft_finished()) or the kselftest_harness.h macros
instead of raw assert() and return 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023001603.5602=
10-8-wusamuel@google.com?part=3D6
