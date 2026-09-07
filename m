Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323838E8A6;
	Mon,  7 Sep 2026 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746675; cv=none; b=srb3SHo6/HqVa6B2bWBAMnSXgEGU45kUwBgOthvu+8t0GY8iphhNmkFFk8DVfTzxA0JvLbKnpgX2rRbyXc3oKFqPX/gh9KcERo6EMS3jv6ZF1+wgjoGXmoLC1gOnzHE3u2Bgng/rnGZICG7FgtvwHvKRHSXy9H7B53rme9yez04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746675; c=relaxed/simple;
	bh=V36Au4NzPFBXNM1smISm5+IAxNhS0ueflVligj9LBwY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pjWleLtI8utnp1X+G9RX26X0qIFaAoOi8sUfrrWkBgzXpgkXc8396tXGgdplzBbKV2De8CwSs4EYcW19CsXASGhdO2gnJX1jHykqwYea1VXRQpQxD+5dibhoygbNG4blAL/qwruUGyAOKmdnd/q4KDp1SQ8rEha3aRevN9doPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kdyxz2D/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdyxz2D/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D511F00A3A;
	Mon,  7 Sep 2026 02:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746670;
	bh=Ixo9qoVXlWHfShNVzjkhekkfGs91dWLjwjX1dSt6FQg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Kdyxz2D/U+P37SRgpQxIvGyfYuza7+WN8AA1YzDCF9xeyTVScHnVM/yY8XKWhpyWp
	 rvRX2j3CfXgJAM/2hMerYziIc1D5Y5Bd7W01JSNo3KsUpfnZ+2ysPQ5n8MgG5UMa15
	 dUPM5Y8xhodvYgJgsbcq57PBe8Y32zZBpz9oLyXu/ApGm4nUS5XI5h6YFywaUpy2Ew
	 mFmKzBMzkECfw2QYTG7WRoz8KhvpovA0eeTK4NiBzezjT8y0HsMBOHySWrvQW8IWl5
	 k7cRwMvWaB99UwGN5VaKCV8LINk7Sw3JqFaSVHxUgZPkRgdClaCvtvZ7ScPBEZuj8Q
	 7/STjXEy7pFjQ==
Content-Type: multipart/mixed; boundary="===============7826773269766246971=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7dbfef853aacc32527a352d59861e86f00b7a1e4634c070e569aed415792b926@mail.kernel.org>
In-Reply-To: <178874362959.1415955.8526609394619576332.flags-v2-2@tychen.cc>
References: <178874362959.1415955.8526609394619576332.flags-v2-2@tychen.cc>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover symbolic bpftool map creation flags
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 02:04:29 +0000 (UTC)

--===============7826773269766246971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c
> new file mode 100644
> index 000000000000..140401dd2548
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <errno.h>
> +#include <unistd.h>
> +#include <bpf/bpf.h>
> +#include <bpftool_helpers.h>
> +#include <test_progs.h>
> +
> +static const struct map_flags_test {
> +	const char *name;
> +	const char *flags;
> +	__u32 expected_flags;
> +	const char *error;
> +} tests[] = {
> +	{ "zero", "0", 0 },
> +	{ "decimal", "129", BPF_F_NO_PREALLOC | BPF_F_RDONLY_PROG },
> +	{ "hexadecimal", "0x81", BPF_F_NO_PREALLOC | BPF_F_RDONLY_PROG },
> +	{ "octal", "0201", BPF_F_NO_PREALLOC | BPF_F_RDONLY_PROG },
> +	{ "positive_sign", "+1", BPF_F_NO_PREALLOC },
> +	{ "single_name", "BPF_F_NO_PREALLOC", BPF_F_NO_PREALLOC },
> +	{ "combined_names", "BPF_F_NO_PREALLOC,BPF_F_RDONLY_PROG",
> +	  BPF_F_NO_PREALLOC | BPF_F_RDONLY_PROG },
> +	{ "repeated_name", "BPF_F_NO_PREALLOC,BPF_F_NO_PREALLOC", BPF_F_NO_PREALLOC },
> +	{ "unknown_name", "BPF_F_NOT_A_MAP_FLAG", 0, "can't parse" },
> +	{ "other_command_flag", "BPF_F_PATH_FD", 0, "can't parse" },
> +	{ "update_flag", "BPF_F_LOCK", 0, "can't parse" },
> +	{ "abbreviated_name", "BPF_F_NO_PRE", 0, "can't parse" },
> +	{ "lowercase_name", "bpf_f_no_prealloc", 0, "can't parse" },
> +	{ "empty", "", 0, "can't parse" },
> +	{ "whitespace", " ", 0, "can't parse" },
> +	{ "empty_list", ",", 0, "can't parse" },
> +	{ "leading_comma", ",BPF_F_NO_PREALLOC", 0, "can't parse" },
> +	{ "trailing_comma", "BPF_F_NO_PREALLOC,", 0, "can't parse" },
> +	{ "empty_element", "BPF_F_NO_PREALLOC,,BPF_F_RDONLY_PROG", 0, "can't parse" },
> +	{ "number_then_name", "1,BPF_F_RDONLY_PROG", 0, "can't parse" },
> +	{ "name_then_number", "BPF_F_NO_PREALLOC,128", 0, "can't parse" },
> +	{ "numeric_list", "1,128", 0, "can't parse" },
> +	{ "whitespace_in_list", "BPF_F_NO_PREALLOC, BPF_F_RDONLY_PROG", 0, "can't parse" },
> +	{ "overflow_u32", "4294967296", 0, "can't parse" },
> +	{ "overflow_hex", "0x100000000", 0, "can't parse" },
> +	{ "overflow_u64", "18446744073709551616", 0, "can't parse" },
> +	{ "negative", "-1", 0, "can't parse" },
> +	/* Numeric bits unknown to bpftool must still reach the kernel. */
> +	{ "all_bits", "0xffffffff", 0, "map create failed" },
> +	{ "invalid_combination", "BPF_F_RDONLY,BPF_F_WRONLY", 0, "map create failed" },

This isn't a bug, but is the comment meant to cover both of the following
rows? The "invalid_combination" test uses a symbolic list rather than
unknown numeric bits, so it might read more clearly as something like
"bpftool does not validate map-specific flag combinations; the kernel
does".

> +};

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34073340278
--===============7826773269766246971==--
