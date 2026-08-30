Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991139F18F;
	Sun, 30 Aug 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078906; cv=none; b=mYqM4f0Vs4K8D8GMSfkID09sSK76Kz/6sx/UkQ4NaRMm4AG01Uig1jA5j6kWBXhcQxlolYgbiBmxfkwY4jrEIh3ErRgpqH0MnPSyvhI4NKNzdiSq+TwzyektRfz9sgqAFUFOUv7alHstUS2qiXGqjlh6gNZhCre1ApI14g+RMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078906; c=relaxed/simple;
	bh=t0ULoBbUWSXQR6jFxZZMOtZ82pTQJfQyoRp0HuG+wfI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qEMlRUbACvmfnzvSqWyO/tO0M5AEAf7zSG3rMzebVojgWqjcv9vQLeFv0NnAPWl1wG1O+bioVjahHMV+41wqkm4Z5ORXO3E2bAgrGTRzsC94dK/EFYlvNJ16BgWsZnu4izljOGWm6e7WCWS3q7G7wyg8ewiHlyK/O4zPRr5npY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRuAzrzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRuAzrzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56FA1F000E9;
	Sun, 30 Aug 2026 08:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788078904;
	bh=//6EIw0TmevYBfzr9LAzJqRiFSmjxzFjKjwndiGQmuM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nRuAzrzxiGH6CLu3SIUpq8FRLblOIh100+u7lObOq/t91yX0h5le5soc0IrLttWeZ
	 zKhHQr/aX4jGIPMi0y8Bjk3fvy94i83haQ5Zw4eHSl1oQPpw4znh5Pm4S9vlo8qENQ
	 snNz2JNHVWbLDk3LzNtue+BYrLfg/J1lMJZd/KNSeODngwNJaFEms9hVRrZ/JBixPa
	 YZmo55KbwMETzSPZruOcSKUyxpX8quonkGTL1G9rjU8siQUTT7gBxsZsyIoqA2unLS
	 Kn/e+prrgc172Ir7gQok6FLiEn1gHYlBdupQ2TZwRNga80tSxa1kOJu2T2RUdFRNrf
	 gzkDlBi8qqIUw==
Content-Type: multipart/mixed; boundary="===============6912060039075541794=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0b556284a4c3787b32de46566bb60b385131a27b3eeea488b54735901daecb1f@mail.kernel.org>
In-Reply-To: <20260830073242.148092-5-jiayuan.chen@linux.dev>
References: <20260830073242.148092-5-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add test for showing a void BTF type
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 30 Aug 2026 08:35:03 +0000 (UTC)

--===============6912060039075541794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_show_void.c b/tools/testing/selftests/bpf/prog_tests/btf_show_void.c
> new file mode 100644
> index 0000000000000..5468331991958
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_show_void.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "btf_show_void.skel.h"
> +
> +/*
> + * bpf_snprintf_btf() with the type_id of a "const void" (a modifier that
> + * resolves to void, present in the vmlinux BTF) used to NULL-deref in
> + * btf_modifier_show(). A fixed kernel prints the "<unsupported kind:0>"
> + * placeholder; on an unfixed kernel this oopses the task (and panics it under
> + * panic_on_oops), so it doubles as a reproducer.
> + */
> +void test_btf_show_void(void)

A subsystem pattern flags this as potentially concerning: this adds a
new standalone test file pair for one narrow case (a modifier resolving
to void in bpf_snprintf_btf(), exercising the btf_modifier_show() ->
btf_df_show() fallback). The directory already has
prog_tests/snprintf_btf.c (serial_test_snprintf_btf, driving
progs/netif_receive_skb.c which includes progs/btf_ptr.h) that exercises
bpf_snprintf_btf() output formatting for a range of types.

Would this case fit better as an additional case in that existing test
rather than as a new binary/skeleton pair?

The counter-argument: snprintf_btf.c is structured very differently - it
attaches a netif_receive_skb raw tracepoint and triggers it with
system("ping -c 1 127.0.0.1"), and still uses the deprecated CHECK()
macros. The new test instead needs a type_id discovered from the vmlinux
BTF at runtime injected through rodata, and drives the program with
bpf_prog_test_run_opts() rather than a real event. Folding it into the
existing test would mean adding a second program and a second run
mechanism to that file. That is a plausible engineering reason for a
separate file, and the new file is the more modern idiom.

> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	const struct btf_type *t;
> +	struct btf_show_void *skel;
> +	int i, n, cv = 0, err;
> +	char ctx[16] = {};
> +	struct btf *btf;
> +
> +	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
> +	if (!ASSERT_OK_PTR(btf, "btf__parse vmlinux"))
> +		return;

Both environment prerequisites of this test are reported as hard failures
rather than skips.

On a kernel built without CONFIG_DEBUG_INFO_BTF the /sys/kernel/btf/vmlinux
file does not exist, btf__parse() fails with ENOENT, and the test reports
a failure instead of a skip. The path is also hardcoded; btf__load_vmlinux_btf()
(used by 14 other prog_tests, e.g. fill_link_info.c, tracing_multi.c,
btf_module.c) additionally searches /boot/vmlinux-$(uname -r) and the
module build dirs.

> +
> +	n = btf__type_cnt(btf);
> +	for (i = 1; i < n; i++) {
> +		t = btf__type_by_id(btf, i);
> +		if (btf_kind(t) == BTF_KIND_CONST && t->type == 0) {
> +			cv = i;
> +			break;
> +		}
> +	}
> +	if (!ASSERT_GT(cv, 0, "find const void in vmlinux BTF"))
> +		goto out_btf;

The test scans the vmlinux BTF for the first BTF_KIND_CONST whose
->type == 0 and hard-fails via ASSERT_GT when none exists. Whether a
standalone const void node survives in a given kernel's BTF is a property
of that build (pahole version, dedup, whether anything in that kernel
actually uses const void *), not a property of the kernel logic under test.
If it is ever absent the test reports a kernel regression that is not
there, with no indication that the input the test needed simply was not
present.

Would a test__skip() with a reason string on both arms (the pattern used
in prog_tests/snprintf_btf.c) keep an environment difference from being
read as a failure?

Mitigating context: all BPF selftests already require CONFIG_DEBUG_INFO_BTF=y,
and the exact idiom btf__parse("/sys/kernel/btf/vmlinux", NULL) followed by
ASSERT_OK_PTR is used unchanged in prog_tests/libbpf_str.c (4 sites),
prog_tests/libbpf_probes.c (2 sites) and prog_tests/btf_sysfs.c, so the
first arm matches existing neighbours. const void is also very likely
present in any vmlinux BTF, since const void * appears in many exported
prototypes. The concern is robustness/diagnosability of the failure mode,
not a functional defect.

> +
> +	skel = btf_show_void__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto out_btf;
> +	skel->rodata->const_void_id = cv;
> +	if (!ASSERT_OK(btf_show_void__load(skel), "skel_load"))
> +		goto out_skel;
> +
> +	topts.ctx_in = ctx;
> +	topts.ctx_size_in = sizeof(ctx);
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.dump_const_void),
> +				     &topts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		goto out_skel;
> +
> +	ASSERT_EQ(skel->bss->ret, sizeof("<unsupported kind:0>") - 1, "ret");
> +	ASSERT_STREQ(skel->bss->out, "<unsupported kind:0>", "placeholder");
> +out_skel:
> +	btf_show_void__destroy(skel);
> +out_btf:
> +	btf__free(btf);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33300136294
--===============6912060039075541794==--
