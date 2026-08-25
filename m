Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B637E5D4
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702140; cv=none; b=Ou1aSj5+o3YtqfWrLnfuBOKYN0Sh+AKe0e/exvHfL4MmucQi+SdZXsoRxBPP1BfR5cjJzMW2iP8VhtzFoWXtQkeNpkSnoS9VLEKbLh0bmCi/lh1i5f6GX0XIoaLVG1KDI0r8bCFtxLXnna3oK5dhQ1nzJ6Q8CNSQ3XrpcTSFZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702140; c=relaxed/simple;
	bh=mOP/mxNe8fSrLLB6WqiNYk3lG9jPrDBmJwdKfLFb7L8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2dslWeVrlGz+K4R2X04KxWUAmvhgaoRKofk19fi/2PpHNBf5xxjjnNDbFSLBHBVEtKe7STTDBHLfIAz9XkBCR+oPrc479dyFNLWhvn7hTHb+gjrg9btW/EQp6rpZI+YGnTrXgvPvtDqFNfv/tMSy8gUBHP44/J4LMLFvA1E384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7p/mSvY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7p/mSvY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cace91f112so5319905ad.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787702138; x=1788306938; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=En9VV+U/u4kPQNQCrzY6v+QcpcYxWxqBJdqhTsEhdwc=;
        b=F7p/mSvYh1I4JGcTk1HERkwv78S3G1h+6vijt6U/ZJszfBpCp+rPj3FgHqjfQU5LdO
         QtUXd/9o5WjuCGyX6AC35CoesdYMEHknuZr7FVzvawVYKjBTncbfyOn5DBQsRKLvHkW0
         vhKEcb+VKccuWUcyqOQ9V18o/N364OiiqUMsntGzuoAWPqbo9rkE9wDn75I/Es4RFtKn
         tNSaxchI5/NmX9oOO4Xhv/1CCpWHToVkmqwxjjxtwVgV/Xjs9DkBZdsj4l038st+hLRf
         Sc+QuShlHjNbVDbLNTrSsx9qbIOU0NMGtc3Yoex7E7AP6B5tJ30uDa2d3u3fuId7gEw2
         HMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702138; x=1788306938;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=En9VV+U/u4kPQNQCrzY6v+QcpcYxWxqBJdqhTsEhdwc=;
        b=XOOvFSbzu0HolEwLP5nTcVl3x54AE1f3bfkYIJFoIGuuH7ilj/bzLZKThAhsXpAUm4
         Fh1j76vq+4PM7Ll5XxDbk5i4odX7ft+7Uausqf6atP45V0Jpw2jeyEe7ot4feSx+LShc
         xO0hEjHnvuoFVXNXSAJT4rgXMOwEMxX9r0kfz3aMAFCMF0IPCUu1WOtijoM5vFKXqv7N
         n7YmJ5TOWH72ls50HwKrqSN83Xd+0BLQrW4/CsWTpFBn0E0Ca2uxszypcCwXWX7VIAAQ
         rltKuWFVehGMQM/KSMhdcaIjbSQaXLtteKY3OTJetn5F5mlCNv+KXmk10ApqkzCkNhsI
         Dkvg==
X-Forwarded-Encrypted: i=1; AHgh+RqqLVKIwRyXAV73YVZJGmBXx45QEsGMQoCofhQNlJ/dm73IVDMvjW9KRyuYHx+BVMMWjTM=@vger.kernel.org
X-Gm-Message-State: AFuF++lcmn86Sr7FaSvEw1pqBmJQknhb1AcNnAOpFHaJkdiAMth/mM+O
	7dcH8T4AS96qLl/nX5yaJ0SesOP+lC/QxBZjnzcmU+Inj9tnvoLdKoUn
X-Gm-Gg: AR+sD13HA1MH+1EKgq4LJjFTLSWkFeOFuVQCQrMQArBhI3OU/CUTNsAsCWfBkzJo1hO
	QIrS5lOwEz0qpcZdjSLmV9yxqWkzsM7Hk5CdEebLMw22eaV8SwQwFXnLO4VcvsGlbj9/Sq6pvfB
	rkvxVX6Is0u3PyyqhSf0KQoYmjZGiSb693DqpPUXi3mgknDReX8fayuN+r6w5XIAfTo2xt+/FSu
	z5PLgWRntXgnhoGPL1x6z/jbYr05cW2DKeWbj80LZK7KO6G+WgVE2kF9PFbH4RlTnncCqXoUf7c
	Cja7jgEi80C8h/tWwldRxwkCcHFWEhTBraTRzI4SmxblMmgwKhZrCN+re12Hr4Ubh+0hhxKgq8k
	9yz1/FgMMm52/WS7YvjrjcvCxCCSHCf4c5Iaf2cmY/kyKuKdAxJqcVSnI8sdRpPtIJdJm+9dMFq
	2D7wHEoupVSSs65Pe/B0D7TqvxnyeLdAzknOK6IKhYWyRirw0ZwiIeDIqDOSZLPFeWtltpuiAky
	spCrwldCnlrYRGb
X-Received: by 2002:a17:90b:4b04:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-3966d3e1e87mr5615463a91.11.1787702137601;
        Tue, 25 Aug 2026 16:55:37 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e8csm5415164a91.9.2026.08.25.16.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 16:55:37 -0700 (PDT)
Message-ID: <20cda214c123d41183bb1e5f95af8c1d9dd6621e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: build each test runner
 instance in its own sub-make
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Tue, 25 Aug 2026 16:55:33 -0700
In-Reply-To: <20260823194241.3415152-10-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
	 <20260823194241.3415152-10-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-23 at 12:42 -0700, Mykola Lysenko wrote:

...

> The runner sub-makes receive CC and CLANG as resolved by lib.mk on
> their command line: Makefile.buildvars probes clang's capabilities
> with $(CLANG), and a runner has to reach the same verdict as the top
> level when LLVM=3D<suffix or path> selects a non-default toolchain.
> The unflavored in-tree instance skips the extras copy as before; the
> runner compares the realpath of $(OUTPUT) with $(CURDIR), make's
> physical working directory, so a tree reached through a symlink
> still counts as in-tree. The userspace objects depend on the
> generated tests.h of the runner that includes them only
> (test_progs.o on prog_tests/tests.h, test_maps.o on
> map_tests/tests.h); before, every extra object of a runner depended
> on that runner's tests.h. The other headers those objects depended
> on - flow_dissector_load.h, ip_check_defrag_frags.h, the libarena
> skeletons - are included by none of them and are dropped.
>=20
> Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Assisted-by: Claude:claude-fable-5 shellcheck
> Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> ---

As a general note, please keep commit messages less verbose.
E.g. if a message spans several pages, I switch to reading patch
directly.

> =C2=A0tools/testing/selftests/bpf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 475 +++++-------------
> =C2=A0.../testing/selftests/bpf/Makefile.buildvars=C2=A0 |=C2=A0 12 +
> =C2=A0tools/testing/selftests/bpf/Makefile.runner=C2=A0=C2=A0 | 199 +++++=
+++
> =C2=A0tools/testing/selftests/bpf/Makefile.skel=C2=A0=C2=A0=C2=A0=C2=A0 |=
 141 ++++++
> =C2=A04 files changed, 478 insertions(+), 349 deletions(-)
> =C2=A0create mode 100644 tools/testing/selftests/bpf/Makefile.runner
> =C2=A0create mode 100644 tools/testing/selftests/bpf/Makefile.skel
>=20
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 432897613b90..9b9905610070 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

...

> @@ -260,9 +250,31 @@ $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TEST=
ING_HELPERS)
> =C2=A0$(OUTPUT)/test_tag: $(TESTING_HELPERS)
> =C2=A0$(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
> =C2=A0$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS) flow_dissector_lo=
ad.h
> -$(OUTPUT)/test_maps: $(TESTING_HELPERS)
> =C2=A0$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV=
_HELPERS)
> -$(OUTPUT)/xsk.o: $(BPFOBJ)
> +
> +# Defined ahead of the first rule that lists it as a prerequisite.
> +VERIFY_SIG_HDR :=3D verification_cert.h
> +
> +# The userspace objects the runner instances link (RUNNER_OBJS, see
> +# Makefile.buildvars) are built here, once, so that no runner sub-make
> +# ever writes a file this Makefile also builds.
> +#
> +# $(TRUNNER_BPFTOOL) is a prerequisite because its sub-make is what
> +# installs libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal=
.h)
> +# into $(INCLUDE_DIR) - the cross-compiled bpftool's when cross-compilin=
g;
> +# without it, trace_helpers.c races the install and can silently pick up
> +# the source-tree copies instead.

Nit: I was a bit confused by this comment. Let's compress the last paragrap=
h as:

     Helper C files include headers installed to $(INCLUDE_DIR)
     by the $(TRUNNER_BPFTOOL) and $(BPFOBJ) targets.

> +RUNNER_OBJS :=3D $(sort $(RUNNER_OBJS-test_progs) $(RUNNER_OBJS-test_map=
s)\
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(RUNNER_LIB_OBJS-test_progs))
> +$(RUNNER_OBJS): $(VERIFY_SIG_HDR) $(BPFOBJ) $(TRUNNER_BPFTOOL)
> +$(OUTPUT)/test_progs.o: prog_tests/tests.h
> +$(OUTPUT)/test_maps.o: map_tests/tests.h
> +
> +# find_bit.c is the only runner source outside this directory,
> +# so it needs a rule of its own.
> +$(OUTPUT)/find_bit.o: $(TOOLSDIR)/lib/find_bit.c
> +	$(call msg,CC,,$@)
> +	$(Q)$(CC) $(CFLAGS) -c $< $(LDLIBS) -o $@
> =C2=A0
> =C2=A0$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/M=
akefile)=C2=A0=C2=A0=C2=A0 \
> =C2=A0		=C2=A0=C2=A0=C2=A0 $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
> @@ -331,7 +343,7 @@ endif

...

> +DEFAULT_RUNNER_ARGS :=3D RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dprog_=
tests	\
> +	BPF_CC=3D'$(BPF_CC)' BPF_CC_MSG=3D$(BPF_CC_MSG)			\
> +	BPF_SYS_INCLUDES=3D'$(BPF_SYS_INCLUDES)'				\
> +	BPF_CC_FLAGS=3D'$(BPF_CC_FLAGS)' BPF_DEFINES=3D$(BPF_DEFINES)

I'd try to join BPF_SYS_INCLUDES and BPF_DEFINES as BPF_CC_FLAGS,
but we can leave it as follow-up.

> +$(OUTPUT)/test_progs: $(RUNNER_PREREQS) $(BPF_OBJS) $(ALL_SKELS) FORCE
> +	+$(Q)$(RUNNER_MAKE) $(DEFAULT_RUNNER_ARGS)
> +
> +$(OUTPUT)/test_progs-no_alu32: $(RUNNER_PREREQS) FORCE
> +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3Dno_alu32 TESTS_DIR=3Dp=
rog_tests \
> +		BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDES=3D'$(CLANG_=
SYS_INCLUDES)'	\
> +		BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv2'

...

> diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testi=
ng/selftests/bpf/Makefile.buildvars
> index dc0be9ee72bc..5c6c147d03c7 100644
> --- a/tools/testing/selftests/bpf/Makefile.buildvars
> +++ b/tools/testing/selftests/bpf/Makefile.buildvars
> @@ -182,3 +182,15 @@ ifneq ($(CLANG_HAS_ARENA_ASAN),)
> =C2=A0LIBARENA_ASAN_SKEL :=3D libarena/libarena_asan.skel.h
> =C2=A0CFLAGS +=3D -DHAS_BPF_ARENA_ASAN
> =C2=A0endif
> +
> +RUNNER_OBJS-test_progs :=3D $(addprefix $(OUTPUT)/,			\
> +	test_progs.o cgroup_helpers.o trace_helpers.o			\
> +	network_helpers.o testing_helpers.o btf_helpers.o		\
> +	cap_helpers.o unpriv_helpers.o sysctl_helpers.o			\
> +	netlink_helpers.o jit_disasm_helpers.o io_helpers.o		\
> +	test_loader.o xsk.o disasm.o disasm_helpers.o			\
> +	json_writer.o bpftool_helpers.o usdt_1.o usdt_2.o)
> +RUNNER_OBJS-test_maps :=3D $(addprefix $(OUTPUT)/,			\
> +	test_maps.o testing_helpers.o)
> +
> +RUNNER_LIB_OBJS-test_progs :=3D $(OUTPUT)/find_bit.o

Let's merge RUNNER_LIB_OBJS-test_progs into RUNNER_OBJS-test_progs
and drop RUNNER_LIB_OBJS variable.

...

I tested this patch-set for:
- clean build within selftests directory, ok
- minimal rebuild after progs/*.c is touched, ok
- minimal rebuild after prog_tests/*.c is touched, ok
- test_progs, test_verifier, test_progs-cpuv4, test_maps
  all work
- build with O=3D specified, something goes sideways:
  the build completes but the tests can't be executed.

For example:

$ make -j O=3D~/work/tmp/tests-build

In the vm:

# cd /home/eddy/work/tmp/test-build
# ./test_verifier
Failed to load bpf_testmod.ko into the kernel: -8

# ./test_progs -a verifier_and
./test_progs: error while loading shared libraries: libLLVM.so.18.1: cannot=
 open shared object file: No such file or directory

Note the following oddity:

[root@testhost bpf]# ldd ./test_progs =20
        linux-vdso.so.1 (0x00007f8bf85d5000)
        libelf.so.1 =3D> /lib64/libelf.so.1 (0x00007f8bf01cd000)
        libz.so.1 =3D> /lib64/libz.so.1 (0x00007f8bf01aa000)
        libm.so.6 =3D> /lib64/libm.so.6 (0x00007f8bf00bc000)
        libzstd.so.1 =3D> /lib64/libzstd.so.1 (0x00007f8befff8000)
        libstdc++.so.6 =3D> /lib64/libstdc++.so.6 (0x00007f8befc00000)
        libgcc_s.so.1 =3D> /lib64/libgcc_s.so.1 (0x00007f8beffca000)
        libc.so.6 =3D> /lib64/libc.so.6 (0x00007f8befa0e000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f8bf85d7000)
[root@testhost bpf]# cd -
/home/eddy/work/tmp/test-build
[root@testhost test-build]# ldd ./test_progs
        linux-vdso.so.1 (0x00007fd8fe342000)
        libelf.so.1 =3D> /lib64/libelf.so.1 (0x00007fd8fe319000)
        libz.so.1 =3D> /lib64/libz.so.1 (0x00007fd8fe2f6000)
        libpcap.so.1 =3D> /lib64/libpcap.so.1 (0x00007fd8fe2a9000)
        libLLVM.so.18.1 =3D> not found
        libc.so.6 =3D> /lib64/libc.so.6 (0x00007fd8fe0b7000)
        libzstd.so.1 =3D> /lib64/libzstd.so.1 (0x00007fd8fdff1000)
        libibverbs.so.1 =3D> /lib64/libibverbs.so.1 (0x00007fd8fdfd1000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fd8fe344000)
        libnl-route-3.so.200 =3D> /lib64/libnl-route-3.so.200 (0x00007fd8fd=
f3c000)
        libnl-3.so.200 =3D> /lib64/libnl-3.so.200 (0x00007fd8fdf1a000)
        libgcc_s.so.1 =3D> /lib64/libgcc_s.so.1 (0x00007fd8fdeee000)
