Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CB280330;
	Tue, 29 Apr 2025 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970835; cv=none; b=IcPXWJiBo4dpefqnEFCRxgkFoqr1mcw+UHXM47tqzZVpcmvuHGVzSRbJRUsLtMJJ69/g+JUL5jmrQSf+Vybij6N2u8gArVF/rX5acjQ2r9oEe88O5tnRvhE549sZcoy1WGT2aHVEVCWNVpcoU+wD+LS0Sw+5UHx90Xe3ftl3wNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970835; c=relaxed/simple;
	bh=3maTfG7PXMhhsZXTByIasarqq9svT5JNZYu4B7xjUC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Edcv3DpEHDSy1J3enwlM9/bU88qFn7yk1fv/a0NBchaBJ2gGvqZai3QTjMEptSNMXhsLAey/MfzhCXSshJQDCOH/QK0q/LHpNl6oGkaiNCYjrzRhHYlXOOWQpGz46z2wdK74d02suHYsXfN8B8i7FyndLdNPwo3iE3L0KeuY13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP2/ffk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP2/ffk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C6DC4CEE3;
	Tue, 29 Apr 2025 23:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970835;
	bh=3maTfG7PXMhhsZXTByIasarqq9svT5JNZYu4B7xjUC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YP2/ffk+BYJJPqfI/2a53zm1+1i4uXp6CkZCL8mTMB2+bCiiD0Pumy/cUbLL9tCtL
	 9RQGgRxJHUkbY/9yaOOEJRfecUtWwCg57l3bOvBy7nQFDLNiOPKQr5drTHnbJeu7Be
	 Nt7QabtZFA12bKrA4qBpbzkBG0eScgV3aX3Hpd9eyKzXW5IREcAwvMNYfqVGqRO/WW
	 2RE7N+o2pJU68s8qIjjldhNsFjnfm45EYqmYFtwjYd1T2+QAE16H5U5qk5ThUVwy/7
	 6bVP7A6p+ZO55pJNahymqTaIH3amXbE+CnLg6Jvpg3Pi4nYfIkMAOKi5rV4BA6MOrq
	 AP4RFSRgRVIyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoran Jiang <jianghaoran@kylinos.cn>,
	zhangxi <zhangxi@kylinos.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	nathan@kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 7/7] samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora
Date: Tue, 29 Apr 2025 19:53:38 -0400
Message-Id: <20250429235339.538269-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235339.538269-1-sashal@kernel.org>
References: <20250429235339.538269-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit

From: Haoran Jiang <jianghaoran@kylinos.cn>

[ Upstream commit 548762f05d19c5542db7590bcdfb9be1fb928376 ]

When building the latest samples/bpf on LoongArch Fedora

     make M=samples/bpf

There are compilation errors as follows:

In file included from ./linux/samples/bpf/sockex2_kern.c:2:
In file included from ./include/uapi/linux/in.h:25:
In file included from ./include/linux/socket.h:8:
In file included from ./include/linux/uio.h:9:
In file included from ./include/linux/thread_info.h:60:
In file included from ./arch/loongarch/include/asm/thread_info.h:15:
In file included from ./arch/loongarch/include/asm/processor.h:13:
In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
./arch/loongarch/include/asm/loongarch.h:13:10: fatal error: 'larchintrin.h' file not found
         ^~~~~~~~~~~~~~~
1 error generated.

larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
and the header file location is specified at compile time.

Test on LoongArch Fedora:
https://github.com/fedora-remix-loongarch/releases-info

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
Signed-off-by: zhangxi <zhangxi@kylinos.cn>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250425095042.838824-1-jianghaoran@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index e2c9ea65df9fb..9edf83eb2a99d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -438,7 +438,7 @@ $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
 	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
 		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
-		-I$(LIBBPF_INCLUDE) \
+		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.39.5

