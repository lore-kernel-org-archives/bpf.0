Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD22A3E3D84
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933787; cv=none; b=svfl7bZ3HtULncZIgiY5wQrLq+TwC1QOwmUeF3ARl3pXUuXQlL9DAYeT/18SWmK2I9C+BvmSnbqnmHb1He55p1/7Eg5clWYXRto4d+IqCkfJLBAkYA3Ku/a004yJq5+u2rlagq33VYPAjGI7hgT6TAh5Wst0OFnsYtuqZtSgJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933787; c=relaxed/simple;
	bh=TI8QoQWvL9nJWRkyfRutiVn0vo3hVS3/ZsOIKo7VsCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pfxvtXG3cNwD+sQI/rF6F0MFsi/vizHWBhp4MWbzueinE5gzF1UHugIepPv5q90H6BT8FxZ7/ZerudspbA/9GKEBCqADSr+9xfH8pnpPZGuhJXWOJGQXE/ioxqSE/3FedKT6eYMOCJI26KCzLMKpDyYy8/5lUBZXG1WKjVhXVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaA39XFn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaA39XFn"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fda2a389so2594415e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933782; x=1774538582; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KoC3MEeE9a06VfxukdKMfULwtBT7iGo7LMQs4bVX0h0=;
        b=RaA39XFn9bZQOrhVJDrOXm5nD+M4/uMdtvGRIqtrkuyFY56tleWaYtIK+txca2NFtH
         lhOOyWOPVw0A3hhUqDx+K5zqDsLk2QhnD1x1os40z89BhIdsr8ELx3Vjz4AtvFdDbt7f
         JIOG25gZcBRDerNXFgmrJr322/AD+0fYThFqCm8Ul4w+++/r4k1J1j8/+o2Q0wOnJPoe
         EU9ZwXftQ1ZngD/Fex6ENbOpzLMyGOO0qzR25B0qxpzqwmIQGGlhKNhsyqOGlhWn5chl
         VZHjf71CnLTIQ1PJnld81r9nhg3v2jPWJSqeulSoJqwDKkBg8bVQamsOVx7YSeMuH5lC
         f9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933782; x=1774538582;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoC3MEeE9a06VfxukdKMfULwtBT7iGo7LMQs4bVX0h0=;
        b=AnbZtlofhhrMFWyHFu+lClWOpdrCT7mhTudW97sGRsgOjHbuQg9R6McNaPa1RmGOO0
         4c4rdSt+sraq/Z29HHqCXtlo6OpkhSP05PccgbNTJhzcw+fXs7SxB5WAs5Gqjlh5gms8
         NPKeF+t0XaTuQbBgd5JtFPqCyuCHbvGMLj9+SdVDwDX1r208Cc2ckpqYfbX7JlaO+1LW
         iCJKhWOxizFkYAKzpKnwBNr8G7+wEMpyEz6wteO3sg+dSuTS5bhaX6XRYYY34YEhVTLo
         evniRASMvlYpg2f6dbUJcd2Tvkd699z/xDZATDx/UDN3kn4panOQ9krRa74fZRFLMsyC
         1SWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf7cjp3sNRboyYaluhCIzhbb2SciFRuZYEx5wslps7UiXqE0wd9i3To1v7M/9SdCpCgPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/ooX/U7CJmdMA1utuitYbL6+zzqG8wAbh4NBPSDoF/rz3lcs
	LrJPrDqBY07cSl3vFvtyVZb8yLi88FkEigH3RCvD0Ux9oaWMWwLu3gVw
X-Gm-Gg: ATEYQzxypYnLmXUZvcHXkkYzwMd7D86ddkMEFJQYjIlcB9HwOp3lIHkymceovXew2NX
	yM18Dd6ZyNZ7+2XssK6YFwXG0pE0NvR+QaGt3N1ENI5TN0oS3xnSfax3Jxg+NqzOy9uR23Gz19y
	kAWRh/eu+jFsan/2ULUdtVEzNAwu4SerL55i3C7cORheu/aHb5enS/svhI2c4snDEeKH/8DyE26
	KW9scB+Q+GncuH4bd7hzbnbmC9vZlq7AsZxsx6h6v27hyS/nMyIjygqKRyCBuuAWZ84OouwS9sp
	LJ1rCP0SoZ2r7rB30jQQ0uPvT1ac1xBUPuZvXs8O/Uk8XUEsnHXm63meIKhdmm98BWzBahsgqDz
	4hYncQ4nEPX9fCcajkGVJ4C/nHIwWSF7mBdLw9ELOB2xnzU27S6aTraxokMoUEN1mUH0LX7T5Ze
	jaZfn32b3mQGQZFeBiGb0kNVX4JQLXphmfIA==
X-Received: by 2002:a05:600c:1d0c:b0:485:2ce2:4c8a with SMTP id 5b1f17b1804b1-486f442df40mr129862875e9.1.1773933781586;
        Thu, 19 Mar 2026 08:23:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f5e162e2sm40063325e9.34.2026.03.19.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:23:01 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Ibrahim Zein <zeroxjacks@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, andrii@kernel.org,
 bpf@vger.kernel.org, Ibrahim Zein <zeroxjacks@gmail.com>
Subject: Re: [PATCH] bpf: fix out-of-bounds write in bpf_bprintf_prepare
 with %pI4/%pI6
In-Reply-To: <20260319043029.3067-1-zeroxjacks@gmail.com>
References: <20260319043029.3067-1-zeroxjacks@gmail.com>
Date: Thu, 19 Mar 2026 15:23:00 +0000
Message-ID: <87341vlu7f.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ibrahim Zein <zeroxjacks@gmail.com> writes:

> In bpf_bprintf_prepare(), the bounds check for %pI4 and %pI6 format
> specifiers uses sizeof_cur_ip (4 for IPv4, 16 for IPv6), which is the
> raw byte count of the IP address. However, snprintf() returns the
> length of the formatted string, not the raw bytes. For IPv4 this can
> be up to 15 characters (255.255.255.255) and for IPv6 up to 39.
>
> tmp_buf is then advanced by (err + 1) using the full string length,
> which can push tmp_buf past tmp_buf_end. The next iteration's bounds
> check underflows due to unsigned arithmetic and passes, allowing a
> write past the end of the per-CPU bin_args buffer.
>
> Fix this by checking against the maximum formatted string size:
> 16 bytes for IPv4 and 40 bytes for IPv6.
>
> Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
> ---
>  kernel/bpf/helpers.c                          |  2 +-
>  .../bpf/prog_tests/test_snprintf_ip.c         | 54 +++++++++++++
>  .../selftests/bpf/progs/test_snprintf_ip.c    | 77 +++++++++++++++++++
>  3 files changed, 132 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_snprintf_ip.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_ip.c
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cb6d242bd..dcaa822ba 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -930,7 +930,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
>  				goto nocopy_fmt;
>  
>  			sizeof_cur_ip = (fmt[i] == '4') ? 4 : 16;
> -			if (tmp_buf_end - tmp_buf < sizeof_cur_ip) {
> +			if (tmp_buf_end - tmp_buf < (size_t)((fmt[i] == '4') ? 16 : 40)) {
not sure if casting to size_it is needed here.
>  				err = -ENOSPC;
>  				goto out;
>  			}
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_snprintf_ip.c b/tools/testing/selftests/bpf/prog_tests/test_snprintf_ip.c
> new file mode 100644
> index 000000000..5b000d6d1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_snprintf_ip.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Ibrahim Zein <zeroxjacks@gmail.com> */
> +#include <test_progs.h>
> +#include "test_snprintf_ip.skel.h"
> +
> +#define EXP_IP4_OUT  "192.168.1.1"
> +#define EXP_IP4_RET  sizeof(EXP_IP4_OUT)
> +
> +#define EXP_WORST_IP4_OUT  "255.255.255.255"
> +#define EXP_WORST_IP4_RET  sizeof(EXP_WORST_IP4_OUT)
> +
> +#define EXP_IP6_OUT  "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff"
> +#define EXP_IP6_RET  sizeof(EXP_IP6_OUT)
> +
> +void test_snprintf_ip(void)
The test passes with or without the fix, I suggest to rewrite it to fail
on the base revision, otherwise it is not very useful.
> +{
> +	struct test_snprintf_ip *skel;
> +
> +	skel = test_snprintf_ip__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	skel->bss->pid = getpid();
> +
> +	if (!ASSERT_OK(test_snprintf_ip__attach(skel), "skel_attach"))
> +		goto cleanup;
> +
> +	/* trigger tracepoint */
> +	usleep(1);
> +
> +	/* Test 1: normal IPv4 */
> +	ASSERT_STREQ(skel->bss->ip4_out, EXP_IP4_OUT, "ip4_out");
> +	ASSERT_EQ(skel->bss->ip4_ret, EXP_IP4_RET, "ip4_ret");
> +
> +	/* Test 2: normal IPv6 */
> +	ASSERT_STREQ(skel->bss->ip6_out, EXP_IP6_OUT, "ip6_out");
> +	ASSERT_EQ(skel->bss->ip6_ret, EXP_IP6_RET, "ip6_ret");
> +
> +	/* Test 3: worst-case IPv4 "255.255.255.255" */
> +	ASSERT_STREQ(skel->bss->worst_ip4_out, EXP_WORST_IP4_OUT,
> +		     "worst_ip4_out");
> +	ASSERT_EQ(skel->bss->worst_ip4_ret, EXP_WORST_IP4_RET,
> +		  "worst_ip4_ret");
> +
> +	/*
> +	 * Test 4: near-overflow scenario.
> +	 * Before fix: tmp_buf overflows, kernel may crash or corrupt memory.
> +	 * After fix: returns valid length without overflow.
> +	 */
> +	ASSERT_GE(skel->bss->near_overflow_ret, 0, "near_overflow_ret");
> +
> +cleanup:
> +	test_snprintf_ip__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_snprintf_ip.c b/tools/testing/selftests/bpf/progs/test_snprintf_ip.c
> new file mode 100644
> index 000000000..5471a2b8b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_snprintf_ip.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Ibrahim Zein <zeroxjacks@gmail.com> */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +/*
> + * Test that bpf_snprintf() with %pI4/%pI6 does not overflow the
> + * internal bin_args buffer when the buffer is nearly full.
> + *
> + * The bug: sizeof_cur_ip (4 for IPv4) was used for the bounds check,
> + * but snprintf() returns the full formatted string length (up to 15
> + * for "255.255.255.255"), pushing tmp_buf past tmp_buf_end.
> + */
> +
> +/* Output buffers */
> +char ip4_out[64] = {};
> +long ip4_ret = 0;
> +
> +char ip6_out[128] = {};
> +long ip6_ret = 0;
> +
> +/* Test %pI4 with worst-case IP (255.255.255.255) */
> +char worst_ip4_out[64] = {};
> +long worst_ip4_ret = 0;
> +
> +/* Return value for the near-overflow test */
> +long near_overflow_ret = 0;
> +
> +__u32 pid = 0;
> +
> +SEC("raw_tp/sys_enter")
> +int handler(const void *ctx)
> +{
> +	/* Worst-case IPv4: "255.255.255.255" = 15 chars */
> +	const __u8 ip4_worst[] = {255, 255, 255, 255};
> +	/* Normal IPv4 */
> +	const __u8 ip4_normal[] = {192, 168, 1, 1};
> +	/* IPv6 worst-case */
> +	const __u8 ip6_worst[] = {0xff, 0xff, 0xff, 0xff,
> +				   0xff, 0xff, 0xff, 0xff,
> +				   0xff, 0xff, 0xff, 0xff,
> +				   0xff, 0xff, 0xff, 0xff};
> +
> +	if ((int)bpf_get_current_pid_tgid() != pid)
> +		return 0;
> +
> +	/* Test 1: normal %pI4 usage */
> +	ip4_ret = BPF_SNPRINTF(ip4_out, sizeof(ip4_out),
> +			       "%pI4", &ip4_normal);
> +
> +	/* Test 2: normal %pI6 usage */
> +	ip6_ret = BPF_SNPRINTF(ip6_out, sizeof(ip6_out),
> +			       "%pI6", &ip6_worst);
> +
> +	/* Test 3: worst-case %pI4 "255.255.255.255" */
> +	worst_ip4_ret = BPF_SNPRINTF(worst_ip4_out, sizeof(worst_ip4_out),
> +				     "%pI4", &ip4_worst);
> +
> +	/*
> +	 * Test 4: near-overflow scenario.
> +	 * Fill bin_args with scalar args (%d), then use %pI4.
> +	 * Before the fix: tmp_buf overflows by 8 bytes.
> +	 * After the fix: correctly returns -ENOSPC or fits exactly.
> +	 *
> +	 * We use fewer args here since BPF_SNPRINTF macro has a limit,
> +	 * but this validates the format string parsing path.
> +	 */
> +	/* 11 x %d + 1 x %pI4 = 12 args (BPF_SNPRINTF max) */
> +	near_overflow_ret = BPF_SNPRINTF(NULL, 0,
> +		"%d %d %d %d %d %d %d %d %d %d %d %pI4",
> +		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
> +		&ip4_worst);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.52.0
