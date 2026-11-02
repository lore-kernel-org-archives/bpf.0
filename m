Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623516;
	b=X/7JPXK8ebw8CKM79GHh58MPD/XbhNYU9JzRqixP3Ay2zgGgmlKwhobjknnYa5To+3eP
	 4E5hEV4hiaY71/XFgOQzJGZf8x2WmnzYcIS1ZPlCxDPMwKZ5VovDaMnrSqQu5+P9IBpql
	 P5ZhiSie1cGbVVafW4awPKclf/bdvS+EuLw2ozwe1EQ1+/l6rI+YPNjbhQLIS8wqGESzR
	 V2oUKsHVt+93yeZy/HuSoMtY1Oi8gro61TKJCF/l/J5NNAnIPiVRyFI0DNFFnFSqwhmMG
	 Ky9uSX3gIjaVeXykUZCCiW+7mfntOE8wicbWN7nQjYMa+eT0jzOnMsKjfFqmKXZQuMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VUqu6sfLfbMcBDlYqJq7ZjiGJIZyLCH5NptoKl+iaKk=;
	b=wF6VXTG6cxb13LYPAlE1rcanwbeM9nFkgQ/wa+vQys4cpYwHgFmqBfSndYt5BlOLyW6u
	 IyueEtMw5q7+QM0WBwltg6zpavIrEY3609Rz4rmqcfdMLKKDbKVEMRpM77aUIUNpEebnH
	 Dva9Dd4AvWpVsrmmkkQWr3aFMB+dlMNbdZ2YRVZTzBh+JvbkZGONlYdccO4H9oGlg48d1
	 0tI+eByoXTlbrvuRjk2QB9Mm4XhrJPkL4fOqIQ05u+RUzJ1B1oRYmMeEFy3gKcexeJnNm
	 VYqp3P7EkeU4UCReBUXwGlou7RcM4T2KwaONDc6h+uy2lVdb1clGgFrzYulVNfH4ibA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXS1Y58E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32A60A2603
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXS1Y58E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ABC1F00A16;
	Mon,  2 Nov 2026 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623516;
	bh=VUqu6sfLfbMcBDlYqJq7ZjiGJIZyLCH5NptoKl+iaKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXS1Y58EHn39rEK70Ir6Sr7fBz0Ra0xXueOniTylDNQd1MUzSQ+wuX3jpID6mrvuq
	 A/V1IB0h8H+w1Gp07FXKJgExLMxxEAT9boTJNZy5EE1KLi+FEa/uFrn0ealdLJxney
	 Y9xEvYwIuFOJxyU0ASeNzkUOfdEQBcyoCD2vcQAKpnzy39Rd0b3VDyvOF+fD2wZlXu
	 jVhMM4lXBptisQwFqiEm8p+LRPF3B7bTjfBDITp24ZkpQ75C3zMBrEQEEpibApWZIJ
	 wdW1r62/47K5KKTcpyOQ3K0Q9IavmyT1jsLaCUmt9OzYX9f/eDMYhQEH3HW+pgPCbW
	 kKq+ZDA9KZ/Vw==
Message-ID: <sashiko-outbox-193441@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Test log_true_size with an
 error from blinding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261102-bpf-blind-nops-fixes-v1-5-844300e42cdb@gmail.com>
References: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
 <20261102-bpf-blind-nops-fixes-v1-5-844300e42cdb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:45:15 +0000
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
- [Low] selftests/bpf: standalone blinding_log.c added for single narrow te=
st case
--

commit 34995a62836807ba96cd4bc1543b3812e415d382
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Test log_true_size with an error from blinding

This commit adds a BPF selftest checking that log_true_size includes the
error message emitted when constant blinding with bpf_jit_harden=3D2 pushes=
 a
jump out of its 16-bit range.

> diff --git a/tools/testing/selftests/bpf/prog_tests/blinding_log.c b/tool=
s/testing/selftests/bpf/prog_tests/blinding_log.c
> new file mode 100644
> index 0000000000000..658a8494dae5b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/blinding_log.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* The verifier log of a prog whose constants are blinded */
> +
> +#include <test_progs.h>
> +#include <linux/filter.h>
> +#include "sysctl_helpers.h"
> +
> +#define NR_CONSTS 11000
> +#define LOG_SIZE 65536
> +
> +/*
> + * A prog of one function gets its constants blinded when its runtime is
> + * selected. Each 'r0 +=3D 1' becomes 3 insns, which pushes the jump ove=
r them
> + * out of its 16-bit range. Serial, because it sets bpf_jit_harden.
> + */
> +void serial_test_blinding_log(void)

[Severity: Low]
This isn't a bug, but tools/testing/selftests/bpf/prog_tests/patch_list.c
already defines serial_test_patch_list() in the same directory to test
patch-list constant blinding while toggling /proc/sys/net/core/bpf_jit_hard=
en
to 2 via sysctl_set_or_fail() and checking is_jit_enabled():

tools/testing/selftests/bpf/prog_tests/patch_list.c:
void serial_test_patch_list(void)
{
	if (test__start_subtest("line_and_func_info"))
		test_line_and_func_info();
	if (test__start_subtest("poke_descriptor"))
		test_poke_descriptor();
	if (test__start_subtest("classic_filter"))
		test_classic_filter();
}

Could this test case be added as a subtest inside serial_test_patch_list() =
in
tools/testing/selftests/bpf/prog_tests/patch_list.c instead of adding a
separate standalone file for a single test?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-bpf-blind-=
nops-fixes-v1-0-844300e42cdb@gmail.com?part=3D5
