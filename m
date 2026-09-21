Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3F439F88
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023229; cv=none; b=ptf5d8u3MJjLGTigY9gFcjZm+ZkALQy0wGwybwvIxjftFR8rfFuTmUFemz7veoRHDgI+wfqXgCsHNOZKPkTe6h/+fyJBMnMmrz+9d3t8vEdpYb23zPc6QpTKBIgA2ApWAdG8aVd7Pj8VF2YFtv0nv29uAtgcuip9DRbdYIugas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023229; c=relaxed/simple;
	bh=+NjMmAqTe3DBtOof46jNgH0Ha5pqjYKueS3olSSLV1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLB5E1vEER3XspFKByo1BAZ1BHnSCxvf234ntjh7XVTSUz0arRH/gb3tj5TOhz4Gljz4GidfVdS2Ffa3aN5DuH0RW5ZMMqafUzJerocI6cAvSmqCdzk/y/sJ8BMnJnD1u1BxFdnC1HUv1xwIkP938hn0Wi7CE5zxa9jYotHnScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dxsMG4IV; arc=none smtp.client-ip=95.215.58.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dxsMG4IV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+NjMmAqTe3DBtOof46jNgH0Ha5pqjYKueS3olSSLV1E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790023222; v=1; x=1790628022;
 b=dxsMG4IVKcsgAW39Y4sXV6+b6bqlaDLpCkx0xBNMz4E6FAB9ejKFXjHDtkp87YDdnMhcHu6W
 4svO360/jz064Qx5NXLb4fbLHua3DVEYw4Gq8aH94KCS2IikQWidWkUvTvZMZlyyCGYoPrfH0I4
 5o/PTtAoNIYeN5We1ItZvIm4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 66aea15dc36d8793;
	Mon, 21 Sep 2026 20:40:19 +0000
X-Mizu-Trace-ID: 66aea15dc36d8793
X-Migadu-Flow: FLOW_OUT
Message-ID: <6f95ec90-194a-4304-9673-c7bb50065223@linux.dev>
Date: Mon, 21 Sep 2026 14:40:15 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests/bpf: Fixes for out-of-tree builds
To: =?UTF-8?B?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
 ihor.solodrai@linux.dev, nickolay.lysenko@gmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
From: "Nico Pache (Red Hat)" <nico.pache@linux.dev>
Content-Language: en-US, en-ZM
In-Reply-To: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/28/26 6:06 PM, Ricardo B. Marlière (SUSE) wrote:
> Hello,
> 

Hello! Thanks for posting this.

The Fedora build system is rather complex, especially around selftests BPF. We
are also discovering we need these changes.

Due to some other oddities in our build system, we would also like to specify a 
precompiled vmlinux, rather than defaulting to $(objtree)/vmlinux.

I developed the following commit on top of these changes, and was finally able
to get a successful build in our env.

commit 616e12baf39ac44680c1dc22d31dbeea63e196b7
Author: Nico Pache <npache@redhat.com>
Date:   Fri Aug 7 12:37:36 2026 -0600

    kbuild, selftests/bpf: allow overriding the module BTF base
    
    scripts/Makefile.modfinal currently hard-codes $(objtree)/vmlinux as the
    BTF base used for module BTF generation. That works for in-tree builds,
    but selftests/bpf/test_kmods may need to reuse a vmlinux resolved from a
    prepared build tree or from /sys/kernel/btf/vmlinux.
    
    Add a VMLINUX_BTF_BASE override so module BTF generation can use that
    pre-resolved vmlinux instead.
    
    Signed-off-by: Nico Pache <npache@redhat.com>

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 01a37ec872b9..fd16e66aa156 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -38,16 +38,19 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T $(objtree)/scripts/module.lds -o $@ $(filter %.o, $^)
 
+VMLINUX_BTF_BASE ?= $(objtree)/vmlinux
+VMLINUX_BTF_BASE_PREREQ := $(wildcard $(VMLINUX_BTF_BASE))
+
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-	if [ ! -f $(objtree)/vmlinux ]; then				\
-		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
+	if [ ! -f $(VMLINUX_BTF_BASE) ]; then				\
+		printf "Skipping BTF generation for %s due to unavailability of %s\n" $@ $(VMLINUX_BTF_BASE) 1>&2; \
 	else	\
-		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
+		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(VMLINUX_BTF_BASE) $@; \
 	fi;
 
-# Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
+# Re-generate module BTFs if either module's .ko or BTF base changed
+%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(VMLINUX_BTF_BASE_PREREQ)) FORCE
 	+$(call if_changed,ld_ko_o)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 53e47e715ec4..8580eee34f32 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -11,6 +11,8 @@ KMOD_O_VALID := $(if $(KMOD_O),$(if $(wildcard $(KMOD_O)/Module.symvers),$(KMOD_
 KDIR ?= $(if $(KMOD_O_VALID),$(SRCTREE_KDIR), \
 	    $(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR), \
 		/lib/modules/$(shell uname -r)/build))
+# The parent bpf/Makefile may already have resolved a usable BTF base.
+VMLINUX_BTF_BASE_ARG := $(if $(VMLINUX_BTF),VMLINUX_BTF_BASE=$(abspath $(VMLINUX_BTF)))
 
 ifeq ($(V),1)
 Q =
@@ -32,10 +34,12 @@ PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
 all:
 ifeq ($(PERMISSIVE),)
 	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID) KBUILD_OUTPUT=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		$(VMLINUX_BTF_BASE_ARG) \
 		$(if $(OUTPUT),MO=$(OUTPUT)) \
 		M=$(TEST_KMOD_DIR) modules
 else ifneq ("$(wildcard $(KDIR))", "")
 	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID) KBUILD_OUTPUT=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		$(VMLINUX_BTF_BASE_ARG) \
 		$(if $(OUTPUT),MO=$(OUTPUT)) \
 		M=$(TEST_KMOD_DIR) modules
 endif


Given your series was defferred, and there is a "rewrite" coming, what would
be the best approach to working together (between us three) to get these
fixes in that series too. 

Cheers,
-- Nico 

> When doing a simple out-of-tree build, e.g.:
> 
> $ git clean -fdx
> $ mkdir ../build
> $ make defconfig O=../build
> $ scripts/kconfig/merge_config.sh -O ../build ../build/.config tools/testing/selftests/bpf/{config,config.x86_64}
> $ make O=../build
> $ make -C tools/testing/selftests install O=$PWD/../build SKIP_TARGETS= TARGETS=bpf
> 
> Will leave behind several build artifacts:
> 
> $ git clean -fdx
> Removing tools/testing/selftests/bpf/libarena/asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/asan_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/buddy.bpf.o
> Removing tools/testing/selftests/bpf/libarena/buddy_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/common.bpf.o
> Removing tools/testing/selftests/bpf/libarena/common_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/libarena.bpf.o
> Removing tools/testing/selftests/bpf/libarena/libarena.skel.h
> Removing tools/testing/selftests/bpf/libarena/libarena_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/libarena_asan.skel.h
> Removing tools/testing/selftests/bpf/libarena/rbtree.bpf.o
> Removing tools/testing/selftests/bpf/libarena/rbtree_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/spmc.bpf.o
> Removing tools/testing/selftests/bpf/libarena/spmc_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/st_asan_buddy.bpf.o
> Removing tools/testing/selftests/bpf/libarena/st_asan_buddy_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/st_buddy.bpf.o
> Removing tools/testing/selftests/bpf/libarena/st_buddy_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/test_parallel_spmc.bpf.o
> Removing tools/testing/selftests/bpf/libarena/test_parallel_spmc_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/test_rbtree.bpf.o
> Removing tools/testing/selftests/bpf/libarena/test_rbtree_asan.bpf.o
> Removing tools/testing/selftests/bpf/libarena/test_spmc.bpf.o
> Removing tools/testing/selftests/bpf/libarena/test_spmc_asan.bpf.o
> Removing tools/testing/selftests/bpf/map_tests/tests.h
> Removing tools/testing/selftests/bpf/prog_tests/tests.h
> Removing tools/testing/selftests/bpf/test_kmods/..module-common.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.Module.symvers.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_modorder_x.ko.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_modorder_x.mod.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_modorder_x.mod.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_modorder_x.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_modorder_y.ko.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_modorder_y.mod.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_modorder_y.mod.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_modorder_y.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_no_cfi.ko.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_no_cfi.mod.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_no_cfi.mod.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_no_cfi.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_rqspinlock.ko.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_rqspinlock.mod.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_rqspinlock.mod.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_test_rqspinlock.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_testmod.ko.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_testmod.mod.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_testmod.mod.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_testmod.o.cmd
> Removing tools/testing/selftests/bpf/test_kmods/.bpf_testmod.o.d
> Removing tools/testing/selftests/bpf/test_kmods/.module-common.o
> Removing tools/testing/selftests/bpf/test_kmods/.modules.order.cmd
> Removing tools/testing/selftests/bpf/test_kmods/Module.symvers
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.ko
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.mod
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.mod.c
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.mod.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.ko
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.mod
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.mod.c
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.mod.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.ko
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.mod
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.mod.c
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.mod.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.ko
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.mod
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.mod.c
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.mod.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_testmod.ko
> Removing tools/testing/selftests/bpf/test_kmods/bpf_testmod.mod
> Removing tools/testing/selftests/bpf/test_kmods/bpf_testmod.mod.c
> Removing tools/testing/selftests/bpf/test_kmods/bpf_testmod.mod.o
> Removing tools/testing/selftests/bpf/test_kmods/bpf_testmod.o
> Removing tools/testing/selftests/bpf/test_kmods/modules.order
> Removing tools/testing/selftests/bpf/verification_cert.h
> Removing tools/testing/selftests/bpf/verifier/tests.h
> 
> This series fixes this.
> 
> Assisted-by: claude sonnet
> Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
> ---
> Ricardo B. Marlière (SUSE) (3):
>       selftests/bpf: Route generated test headers to OUTPUT
>       selftests/bpf: Route libarena build artifacts to OUTPUT
>       selftests/bpf: Route test_kmods build artifacts to OUTPUT
> 
>  tools/testing/selftests/bpf/Makefile            | 45 ++++++++++++++-----------
>  tools/testing/selftests/bpf/libarena/Makefile   | 24 +++++++------
>  tools/testing/selftests/bpf/test_kmods/Makefile |  3 ++
>  3 files changed, 42 insertions(+), 30 deletions(-)
> ---
> base-commit: 62cc90241548d5570ee68e01aaba6506964e9811
> change-id: 20260728-selftests-bpf_oot-da8b59be69fc
> 
> Best regards,
> --  
> Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
> 
> 

