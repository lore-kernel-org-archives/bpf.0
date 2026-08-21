Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0C719F137;
	Fri, 21 Aug 2026 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787354028; cv=none; b=nBPTbA///FImbSWb8LsTN8EM0KNr9Aucl7qiTCGP5cdqIFNsvcbjdlsLMT0AGxmeFondYeLN9qFwwL4OU5PHJPxjwwQBY/Dhk56nmzmCgeRFsuzZq3qHd6Oy2P1wuX622gpQvR9Q6FVC+b4tgFsEVQcaI3Z9wE+0AqSSNXY3qAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787354028; c=relaxed/simple;
	bh=1ZvSUicyAJNEegbIgxNiVYcG4IjhG2QpQb4lecFZ+Tk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WqhpLhXa7e/9fFJPmsGso8r4sWJLv66H+wsnObZpl6VcEGPaS/X3ibNoM478mIbksVGRjdQy+4RyG2mvDqiKx7nwkeg9vX3mDC5NP51/qKsB9NOiuBY5AtfmyU70YtZrJfxAdtL5+1rl30dteg/PoLoLc6ic/8EpcQPOUYYtts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7x/hfel; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7x/hfel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402EE1F00A3A;
	Fri, 21 Aug 2026 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787354026;
	bh=mlGPbCkAa/702rVv4p8IJAvdiJPS0Jjy+BT8Am7xl7w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=C7x/hfelgGPxbUanGN0gFvwMPjNWsOj4BggZ3rilKU3vUhyhT/zZkJGP0/rhq0HqQ
	 GjaOCEQSydJztNd6brFrX0cukUsw23Q4UbAP4ukXq/qOnNHsK8ne2SuQXHxVdpjpOI
	 S5eF6H7TGDHn9WtbH7B5pCsY+r6ApAcFycc/AxzGJxZ9O7xtYIJK12cNUJ76ZYu1K/
	 fhC+TjHix4qSq5N/DyR9zjwlmYi+pvovTracSSSw3qjNyF8O22L7bSWCMczZKKnNNr
	 VhcUsHuF9c/4n/zLkvdt/gVPTPecni/eS7ABW+QUXWvfZI9jl2Ng6DlUL8VYsXstiJ
	 FW1iY7RohcTXA==
Content-Type: multipart/mixed; boundary="===============5513344914068873113=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <db81907efdc93ad319c92588f45a3e8c0a999cf14fc59f55d4cfeacb8011cde1@mail.kernel.org>
In-Reply-To: <20260822-kasan-v7-8-99afee6ef7fd@bootlin.com>
References: <20260822-kasan-v7-8-99afee6ef7fd@bootlin.com>
Subject: Re: [PATCH bpf-next v7 8/9] selftests/bpf: move bpf_jit_harden helper into testing_helpers
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,laoar.shao@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 23:13:46 +0000 (UTC)

--===============5513344914068873113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 0222a9a5d076..815f3e04540f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

[ ... ]

> @@ -272,7 +236,7 @@ static void check_blindness(void)
>  		BPF_MOV64_IMM(BPF_REG_0, 1),
>  		BPF_EXIT_INSN(),
>  	};
> -	int prog_fd = -1, map_fd;
> +	int prog_fd = -1, map_fd, ret;
>  	struct bpf_insn_array_value val = {};
>  	char bpf_jit_harden = '@'; /* non-exizsting value */
>  	int i;
> @@ -291,7 +255,8 @@ static void check_blindness(void)
>  		goto cleanup;
>
>  	bpf_jit_harden = '2';
> -	if (set_bpf_jit_harden(&bpf_jit_harden)) {
> +	ret = set_bpf_jit_harden(&bpf_jit_harden);
> +	if (!ASSERT_OK(ret, "set bpf_jit_harden")) {

This isn't a bug, but could the first call just be
`if (!ASSERT_OK(set_bpf_jit_harden(&bpf_jit_harden), "set bpf_jit_harden"))`
instead?  It would match the restore call below and drop the extra `ret`
local:

>  cleanup:
>  	/* restore the old one */
>  	if (bpf_jit_harden != '@')
> -		set_bpf_jit_harden(&bpf_jit_harden);
> +		ASSERT_OK(set_bpf_jit_harden(&bpf_jit_harden),
> +			  "restore hardening configuration");

> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index c970e7793dfc..737f668b35e2 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -519,6 +519,38 @@ bool is_jit_enabled(void)
>  	return enabled;
>  }
>
> +int set_bpf_jit_harden(char *level)
> +{
> +	char old_level;
> +	int err = -1;
> +	int fd = -1;
> +
> +	fd = open("/proc/sys/net/core/bpf_jit_harden", O_RDWR | O_NONBLOCK);
> +	if (fd < 0)
> +		return -1;
> +
> +	err = read(fd, &old_level, 1);
> +	if (err != 1) {
> +		err = -1;
> +		goto end;
> +	}
> +
> +	lseek(fd, 0, SEEK_SET);
> +
> +	err = write(fd, level, 1);
> +	if (err != 1) {
> +		err = -1;
> +		goto end;
> +	}
> +
> +	err = 0;
> +	*level = old_level;
> +end:
> +	if (fd >= 0)
> +		close(fd);
> +	return err;
> +}

tools/testing/selftests/bpf/ already has a shared sysctl helper with these
semantics.  Is there a reason to add a second sysctl read-modify-write
implementation instead of wrapping the existing one?

sysctl_helpers.h (same directory) exports:

    int sysctl_set(const char *sysctl_path, char *old_val,
                   const char *new_val);
    int sysctl_set_or_fail(const char *sysctl_path, char *old_val,
                           const char *new_val);

and sysctl_helpers.c implements 'open the sysctl, save the previous value
into old_val, write new_val, return -errno on failure' - the same contract
the new set_bpf_jit_harden() open-codes with
open()/read()/lseek()/write()/close(). sysctl_set_or_fail() additionally
emits the PRINT_FAIL diagnostic that the moved helper drops.

sysctl_helpers.c is already linked into test_progs (Makefile
TRUNNER_EXTRA_SOURCES) and is already used by three prog_tests
(test_sysctl.c, token.c, unpriv_bpf_disabled.c). The only consumers of
set_bpf_jit_harden() are test_progs subtests (prog_tests/bpf_insn_array.c
here, and prog_tests/kasan.c added by the follow-up commit 7af63bad7fc6), so
sysctl_set() is reachable from every call site.

Since this patch's stated purpose is precisely to provide a shared way to
change the hardening configuration, landing a second sysctl
set-and-restore implementation means a corner-case fix in one (short
read/write handling, values longer than one byte, error reporting) will not
propagate to the other.

The immediately preceding function in the same file, is_jit_enabled() at
testing_helpers.c:505, already hand-opens /proc/sys/net/core/bpf_jit_enable
with open()/read()/close(), so the new code matches its neighbour.  Also,
the patch is a pure code motion - the body is byte-identical to the version
removed from bpf_insn_array.c apart from the deleted ASSERT_FAIL calls - so
it does not newly introduce the hand-rolled I/O, it only relocates it.
sysctl_set() reads the old value with an unbounded fscanf(fp, "%s",
old_val), which would require the caller to pass a sized buffer rather than
the single char the callers use today, so a straight substitution is not
free.

Worth asking whether set_bpf_jit_harden() should be a thin wrapper over
sysctl_set("/proc/sys/net/core/bpf_jit_harden", ...) instead?

---

This isn't a bug, but the patch is not a pure move: the three ASSERT_FAIL()
calls that reported which of open/read/write failed (with errno) are dropped
from the helper, and two ASSERT_OK() checks are added at the call sites
instead.

The reason that rework is required is not obvious from the diff -
testing_helpers.c contains no ASSERT_*/PRINT_FAIL uses at all, and
testing_helpers.o is linked into standalone binaries (test_maps, test_tag,
test_sockmap, bench) that do not provide the test_progs failure machinery,
which is why network_helpers.c's users have to define stub test__fail() in
xdp_features.c, xskxceiver.c and xdp_hw_metadata.c.

A reader also loses the ability to tell open/read/write apart, while the
retained comment at the call site still says "open, read or write failed =>
no write was done".

Would it be worth a sentence noting that the ASSERT_FAIL() diagnostics had
to move to the callers because testing_helpers.c is linked into binaries
without the test_progs assertion machinery?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32534828209
--===============5513344914068873113==--
