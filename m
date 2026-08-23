Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6671A8F7B
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787450488; cv=none; b=aehpm/BdxvTz+A5XRo4cH3FXnCQP3zzkmmY1TVnk8+pX21xrmltkQqCsx3pfvNlgCf9EZrmT6mrugCeBPQjOj3bRZGKai5OPSd4M5Mo0XBnD7IfzzvGpW/2+0J2GJPTlFnj/UC/CX3OgDWU/B2wXlkOjsIUpiTL/C2UZmUCr9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787450488; c=relaxed/simple;
	bh=5EZGTHEEAIckD9tYoBfwn/hWPRK0FMX9M61cqCAR5Bc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s1tLdLyZ0ioiPpSphZqDOIx/ZDSpth5G8B5/Z4TwBePl6LJmAXupT+EzVCKGHqNZUW8YuWPwm5wv6pBmrKAvb04CuC2O4EDUhnVm7FYwrZ/PVZ8aHQIPmtLiIIU907TBTN0SZFD98q/Vvwktq/6nfRCVQqWGMFy4E6JOcIkx+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgrYKLlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgrYKLlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716E91F000E9;
	Sun, 23 Aug 2026 02:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787450486;
	bh=I1eJofPV5iUj+EhBpoMLs2jqMBnxCPOekgbSnu7dT3o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HgrYKLlN8zcpoe+3s9z1rsich6g/mjLql55i6HSpO65X+qsuhEoIQmwMo6+SoZHWZ
	 i+gMf7Q5UwKoUN7/uBqs5ejI/a/a6xUCb2phpHNWXmXUCGFe8OVkqu42hy4EHM2PUC
	 v3ToXCD7ymQjBkBqZYg61x2cbwoJVaw3/U6Eum0qcUmQ8MTPeTUGeKeHxfqWW4Scyk
	 A6IdDjifBz5IiXRvonmKxaYPnQeTeKexYO91uCtLCQVrwYKf8K3Mhgs3iGY/XN6xoH
	 nLuAnJjGNJZzuKFu7i+k3hWCehLNGkXWOwBRZmx/PkFAz0sY8UhXV2yBHd79++7D9K
	 Afr6TrEq7UYag==
Content-Type: multipart/mixed; boundary="===============8946505077942693406=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9f88f9519021ce15bb886a84246e786aba20cb6395d7c73bbe14905dd329967@mail.kernel.org>
In-Reply-To: <20260823010900.1730708-5-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-5-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v6 4/9] selftests/bpf: generate the signing key and certificate once
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 02:01:26 +0000 (UTC)

--===============8946505077942693406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: generate the signing key and certificate once
>
> $(VERIFICATION_CERT) and $(PRIVATE_KEY) come from a single genkey
> invocation, but a rule with two normal targets runs its recipe once
> per stale target - under -j both runs execute concurrently and the
> openssl invocations race on the same output files.

The -j race described here isn't reachable at this commit. Can the
changelog clarify the ordering?

At af5eea54, $(PRIVATE_KEY) appears only at Makefile:569 where it is
embedded in LSKEL_SIGN, and at Makefile:790 as a variable assignment. It
never appears in a prerequisite list. The only consumer is

    $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)

which lists a single stale target, so the old recipe could only run once.
The -j race becomes reachable five commits later (8cedb1c0019b, 'build
each test runner instance in its own sub-make') when that commit adds

    RUNNER_PREREQS := ... $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT) ...

listing both files as prerequisites of the same target. This change is
correct and needed, but as a prerequisite for that later commit rather
than as a fix for current behaviour, which is also consistent with the
absence of a Fixes: tag.

> Rewrite it as a
> pattern rule: pattern rules with multiple targets are implicitly
> grouped even before make 4.3 introduced grouped (&:) targets - the
> same workaround the test_kmods rule already uses.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -789,7 +789,11 @@
>  VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
>  PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
>
> -$(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
> +# One genkey run produces both files. A plain two-target rule is not
> +# grouped - under -j make would run genkey twice concurrently and the
> +# openssl invocations race; the pattern form is implicitly grouped even
> +# with make < 4.3.
> +$(BUILD_DIR)/%.pem $(BUILD_DIR)/%.der: $(VERIFY_SIG_SETUP)
>  	$(Q)mkdir -p $(BUILD_DIR)
>  	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)

Is this pattern too broad?

The old rule named exactly two targets, $(BUILD_DIR)/signing_key.der and
$(BUILD_DIR)/signing_key.pem. The new pattern claims every .pem and .der
under $(BUILD_DIR):

    $(BUILD_DIR)/%.pem $(BUILD_DIR)/%.der: $(VERIFY_SIG_SETUP)

Because the target patterns contain a slash, GNU make matches them against
the whole target name and the stem may itself contain slashes, so the rule
also covers arbitrary depths such as $(BUILD_DIR)/libbpf/anything.der.
$(BUILD_DIR) is $(OUTPUT)/tools/build, the same directory the libbpf,
bpftool and resolve_btfids sub-builds write into (Makefile:223-236,
255-257).

The recipe only ever produces one stem. verify_sig_setup.sh genkey()
hardcodes the names:

    -outform PEM -out ${tmp_dir}/signing_key.pem -keyout ${tmp_dir}/signing_key.pem
    openssl x509 -in ${tmp_dir}/signing_key.pem -out ${tmp_dir}/signing_key.der -outform der

So for any stem other than signing_key the rule matches, make runs genkey,
openssl succeeds, make reports no error, and the requested file still does
not exist. The failure surfaces at the consumer instead of as 'No rule to
make target', and it repeats on every invocation. The same applies to a
mistyped .der/.pem prerequisite anywhere under $(BUILD_DIR). Also, 'mkdir
-p $(BUILD_DIR)' only creates $(BUILD_DIR) itself, so a stem containing a
directory component would not even have a writable destination.

The grouping the change needs does not require this width. The precedent
the changelog cites, Makefile:313, deliberately keeps its multi-target
pattern narrow:

    $(addprefix test_kmods/,$(subst .ko,%ko,$(TEST_KMODS))): ...

where % only stands in for the '.' of each known module name. The same
trick applies here, such as

    $(BUILD_DIR)/signing%key.pem $(BUILD_DIR)/signing%key.der

or

    $(BUILD_DIR)/%_key.pem $(BUILD_DIR)/%_key.der

with stem 'signing', which keeps the implicit grouping while matching only
the intended pair.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32610372822
--===============8946505077942693406==--
