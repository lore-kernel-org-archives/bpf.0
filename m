Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F364ABBAA
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799732; cv=none; b=qkrMZzC5boJQTGXS7AWZDxUnxyK+2Pj3HonpQWWhCn+0gKAeAFJslcRNJaqUSZ/Cy6ZzzfNuaQ9J+EUdfXUB6MaGuZ25ViwoojNla+QUYhlojrearob2tJDs8CVHvmsnlXXIhBrGVK9t4JNFWXX3go5YzY8rxtXWQeYdgkqaEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799732; c=relaxed/simple;
	bh=fbFeaKC2RgrEztmYK22LuXFd+X59Y63LgRQarSx2aTQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HpBWJYxEKOWzytBqKdk5Q/giarA9ivbKdaDLLDxUvJZx1qkpiB6vdZcK0V/1t6zL0AztKYJSmaUg6Z47oQVxK5Nijn216hpc5K6T3s+wPwz3ejzfnLIS0bciQTAoQwE6fi9nJ6jweIoAIwg/f1b/0q9frZzY/moxT7asSt0MDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp2gNFSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp2gNFSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2B21F00898;
	Wed, 30 Sep 2026 20:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799730;
	bh=JEilaV18FdSoOQPR6xECVjY9OgGzqJeD5iRcnDoJ46A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Hp2gNFSMlinDFpP6K824NxMdutAhV+Rp2zp0uNO854bvYZuDg2Q9VOPUups93y5OE
	 GUH5yTwTa48OiJ+pGpqtSduy/bmrq6+YyzUBkz6YpbZmiOQAIy5PG4oiMP2bbVQxFH
	 kahEon0/7sRmrWix7O5vv0hoWCe4ALhPa+ENOV16bNSGnPJKVxBCKVPDbyMyHQdBYH
	 n9oX6Pcn4QULdmrQ8Vrw7E3HqIGsg1r7OCRu8O7BkrD20psHSAn/Gow5fXQ0l1hU/7
	 27UE2WN50WxlgotBMRXFUb+NQRuaxDY12aq270u3dnbpH3OVbEcOAE/Pudu6+mM9os
	 wFDTq6GsWZ1LQ==
Content-Type: multipart/mixed; boundary="===============5907084836630735380=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e46a2220bc2579c95f6372a7bf7717371f94870bacf58222bea62dc6d6d8012d@mail.kernel.org>
In-Reply-To: <20260930193127.2181684-7-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 06/14] selftests/bpf: Add tests for names of Rust types and functions in BTF
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 20:22:09 +0000 (UTC)

--===============5907084836630735380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for names of Rust types and functions in BTF

TL;DR:
- Test issue: btf_rust func_name may fail spuriously if JIT hardening or
  kallsyms settings hide BPF symbols
- Nit: open-coded kallsyms scan duplicates kallsyms_find()

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_rust.c b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
> new file mode 100644
> index 000000000000..b0128daceaa1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +#define FUNC_NAME "write_fmt<scx_simple::BpfStream>"
> +#define KSYM_NAME "write_fmt_scx_simple__BpfStream_"
> +
> +static bool kallsyms_has(const char *sym)
> +{
> +	char line[1024], name[512];
> +	bool found = false;
> +	FILE *f;
> +
> +	f = fopen("/proc/kallsyms", "r");
> +	if (!ASSERT_OK_PTR(f, "kallsyms"))
> +		return false;
> +	while (!found && fgets(line, sizeof(line), f))
> +		found = sscanf(line, "%*s %*s %511s", name) == 1 && !strcmp(name, sym);
> +	fclose(f);
> +	return found;
> +}

A subsystem pattern flags this as potentially concerning: kallsyms_has()
open-codes a scan of /proc/kallsyms for an exact symbol name, while the
selftests already have a helper for this in trace_helpers.c:

    /* open kallsyms and find addresses on the fly, faster than load + search. */
    int kallsyms_find(const char *sym, unsigned long long *addr);

trace_helpers.h is already pulled in by test_progs.h, so no new include
would be needed.  kallsyms_find() returns 0 when the name matches, and its
.llvm. suffix stripping only applies to type 'd' symbols, so the BPF 't'
symbols compare exactly.

Could the check be written as:

    unsigned long long addr;

    ASSERT_OK(kallsyms_find(sym, &addr), sym);

and kallsyms_has() dropped, so the suite keeps a single implementation of
the /proc/kallsyms parsing?

The code as written looks functionally correct: the buffers are bounded
(%511s, fgets of 1024), and the file is closed on all paths.  The concern is
only the duplication of an existing helper.

[ ... ]

> +	if (!info.jited_prog_len) {
> +		test__skip();
> +		goto out;
> +	}
> +
> +	p += sprintf(p, "bpf_prog_");
> +	for (i = 0; i < BPF_TAG_SIZE; i++)
> +		p += sprintf(p, "%02x", info.tag[i]);
> +	sprintf(p, "_%s", KSYM_NAME);
> +	ASSERT_TRUE(kallsyms_has(sym), sym);

The func_name subtest skips when the program is not JITed, but fails
outright when the JITed program is simply not visible in /proc/kallsyms.
Can this ASSERT_TRUE() fail spuriously?

Visibility of BPF symbols is decided at read time, not load time.
bpf_prog_kallsyms_add() always inserts a JITed prog into bpf_kallsyms, but
bpf_get_kallsym() in kernel/bpf/core.c starts with:

    if (!bpf_jit_kallsyms_enabled())
        return ret;   /* -ERANGE */

and bpf_jit_kallsyms_enabled() returns false whenever bpf_jit_harden != 0 or
bpf_jit_kallsyms == 0.  get_ksymbol_bpf() then ends the whole BPF section of
/proc/kallsyms, so kallsyms_has() returns false and the assertion fails.

This looks reachable inside the selftest suite itself.
test_bpf_insn_array() in prog_tests/bpf_insn_array.c (built on
x86_64/powerpc/aarch64) is a non-serial test, and its "blindness" subtest
does:

    set_bpf_jit_harden('2') ... set_bpf_jit_harden(old)

around a prog load.  Both test_bpf_insn_array and test_btf_rust are
dispatched to parallel workers by test_progs -j (test_progs.c skips a test
only on 'if (!test->should_run || test->run_serial_test) continue;' and
otherwise sends MSG_DO_TEST), so if btf_rust scans /proc/kallsyms while the
blindness window is open, func_name fails intermittently.

Other tests that change bpf_jit_harden (serial_test_kasan,
serial_test_arena_scalar_blinded) are serial precisely to avoid disturbing
parallel tests.

Outside CI the subtest also fails deterministically on hosts running with
net.core.bpf_jit_harden >= 1 or net.core.bpf_jit_kallsyms = 0, which is an
environment difference rather than a kernel bug.

Would it make sense to either make this a serial_test_btf_rust(), and/or
read /proc/sys/net/core/bpf_jit_harden and bpf_jit_kallsyms and call
test__skip() (with a printf'd reason) when BPF ksyms are hidden, the same
way the no-JIT case is skipped?

> +out:
> +	if (prog_fd >= 0)
> +		close(prog_fd);
> +	btf__free(btf);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36768148430
--===============5907084836630735380==--
