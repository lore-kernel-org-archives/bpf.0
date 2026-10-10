Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987036D9F5;
	Sat, 10 Oct 2026 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791675653; cv=none; b=VaeHYiPY+uODyOc0w9FggpEUjLqgzC8wn5nV2S6SZDt0QAQJ9SaHbtJByv7y0ZowY1UDVbJOgFEBEipuRBAFM70l1PZhgbXGC4zr6ZnJkJqMY6SX7rfwpJDTT5lg4foW7GMK5DA+ubv7fDG6ealOtobcheEkTZuz5bDsFIv8xrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791675653; c=relaxed/simple;
	bh=3YcLR+Q/EgA5Cmhs8aVsptl4bJU1GLwsmsO2zStWZh8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O8A/pDeUmF816mR0S8sSOzlkoJ0tJcv51/c91UQXQwgkoZ/GGMt5H6bTdLtqALOvx9dUPKDjdBbnKSlL63McMZOWlyATlaavjvfdKYusZwPQFF2QRD2wzY6cFC8URQpmKCAzzneISkFeIzxiWIXu9JncgIuQpwtR/Qbz4i377yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVv4UE/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVv4UE/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581BD1F000FF;
	Sat, 10 Oct 2026 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791675651;
	bh=i6vUHfSfWpYSqu5mYd4dpZsW4QX/acyAYkDxfm22Fyk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hVv4UE/ZJiNq+7cNfViBS7srF6LefjYULWq2FFaSrBn/RKRnCoPuxoA8fvuqxmxWl
	 7ROxqC/NFu/GhH22jzN2y978LVRFVH6NV6E0lAFT8I8mu0wdycYb1DNXO7KFkMNPTM
	 KT4gwZ7ZF8aLgbpGmL4HiMlL1gYM9bTLJ/mPhTDet8/gn7GEzivGv1mZAEzFGBeu8f
	 zymgUFB45lq/dEctA4W4sl25FN+fNl/vRflReyQh/r9KeJWKmKTHBBDR0JRvMWIs+7
	 iceXRK4nBXMUvSEbxuZ/Q3ZnVkvRbeT/6N9eUE9i0WXOL92VpfzS+eqQzAj7R0mnlQ
	 iYUy7K73FlTeQ==
Content-Type: multipart/mixed; boundary="===============6577853072240553165=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a1b29fc1533b362c07bdb93b2180a8ba199c1a9d09c3c26019ad63b3c9bdc3fd@mail.kernel.org>
In-Reply-To: <20261010224902.1232178-6-arighi@nvidia.com>
References: <20261010224902.1232178-6-arighi@nvidia.com>
Subject: Re: [PATCH 5/5] selftests/bpf: Test two-way arena access with two guests
From: bot+bpf-ci@kernel.org
To: arighi@nvidia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,joshdon@google.com,vineethrp@google.com,balbirs@nvidia.com,skolothumtho@nvidia.com,himadrics@protonmail.com,royfru44@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 10 Oct 2026 23:40:49 +0000 (UTC)

--===============6577853072240553165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test two-way arena access with two guests

TL;DR:
- Unconditional -lzstd in the new Makefile link rules may break the whole
  selftests/bpf build where libzstd is missing
- arena_kvm.py doesn't use ksft.py reporting (minor; results still counted)

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index a22be7efd1fa..29fffa7857c1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -94,6 +100,25 @@ BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
>  HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
>  BPF_TARGET_ENDIAN:=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
>  
> +# These helpers are installed beside arena_kvm.py, including for OUTPUT=.

[ ... ]

> +$(OUTPUT)/arena_kvm_guest-init: arena_kvm_guest.c arena_kvm_shared.h \
> +		$(BPFOBJ) | $(OUTPUT)
> +	$(call msg,BINARY,,$@)
> +	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $< $(BPFOBJ) $(LDLIBS) -lzstd -o $@
> +
> +$(OUTPUT)/arena_kvm_host-runner: arena_kvm_host.c arena_kvm_shared.h \
> +		$(BPFOBJ) | $(OUTPUT)
> +	$(call msg,BINARY,,$@)
> +	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $< $(BPFOBJ) $(LDLIBS) -lzstd -o $@
> +
>  NON_CHECK_FEAT_TARGETS := clean docs-clean emit_tests
>  CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
>  ifneq ($(CHECK_FEAT),)

Is it intended to pass -lzstd unconditionally in these two link rules?

Neither arena_kvm_guest.c nor arena_kvm_host.c includes a zstd header or
calls into zstd, and no other userspace link line in selftests/bpf uses
-lzstd.  test_progs, for example, links with plain $(LDLIBS), which is
$(LIBELF_LIBS) -lz -lrt -lpthread.

Elsewhere in tools/, libzstd is optional.  bpftool only adds it when the
feature-libelf-zstd probe passes, and libelf builds without zstd are a
supported configuration.

Both binaries are in TEST_GEN_FILES without a CLANG_CPUV4 or feature guard,
and these link rules do not use $(call skip_on_fail,...).  On a host or
sysroot that has libelf and zlib development files but no linkable libzstd,
wouldn't 'make -C tools/testing/selftests/bpf' now fail with "cannot find
-lzstd", even with BPF_STRICT_BUILD=0?  That would block all of
selftests/bpf, not just this test.

Would dropping -lzstd be enough, since a dynamic libelf pulls in its own
dependencies?  If it is needed for a static libelf, it could be made
conditional the same way bpftool does it.

> diff --git a/tools/testing/selftests/bpf/arena_kvm.py b/tools/testing/selftests/bpf/arena_kvm.py
> new file mode 100755
> index 000000000000..552bfcfb80ac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/arena_kvm.py
> @@ -0,0 +1,448 @@

[ ... ]

> +KSFT_SKIP = 4

[ ... ]

> +        print(f"OK: two guests exchanged BPF values through arena slices {offsets}")

[ ... ]

> +def skip(reason):
> +    print(f"SKIP: {reason}")
> +    return KSFT_SKIP

[ ... ]

> +if __name__ == "__main__":

[ ... ]

> +        stop_children()
> +    sys.exit(status)

A subsystem guideline flags this as potentially concerning: a test that
prints its own ad hoc result text and exits directly, instead of going
through the kselftest reporting helpers.

arena_kvm.py defines its own KSFT_SKIP, prints hand-written "SKIP: ..." and
"OK: ..." lines, and then calls sys.exit(status) directly.
tools/testing/selftests/kselftest/ksft.py provides KSFT_SKIP,
test_result_pass(), test_result_skip(), test_result_fail(), exit_pass() and
exit_fail(), and none of them are used here, so the output is not KTAP.

Should this script report through ksft.py instead?

For context, when the kselftest runner executes a TEST_PROGS entry, it
prefixes the script's output with '# ' and turns the exit code into the TAP
result line (exit 4 becomes '# SKIP'), so the one result this script
produces is still counted correctly.  The other TEST_PROGS scripts in this
directory (test_kmod.sh, test_xsk.sh, test_xdp_features.sh) also print their
own results.  The guideline text is written about C test binaries and does
not name the Python helper.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38093513563
--===============6577853072240553165==--
