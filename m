Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C32D81A0;
	Tue, 29 Apr 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970817; cv=none; b=FcjsWhU9aoZwKz7DIDFYYOz3pBFU3bAjoCgv/vkJ2ldtWZbBgCyMHJBxoq99MwDZs5o6gseJ3d4glXEHBkACC0lts7fVnEnfL1lQ+0Pr7rc4XFa2qhOcgKSXUPzSNxUS6JBgaaq4cxYmKhBgXfzsjihf8I+LrHlZjZXg0iTI5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970817; c=relaxed/simple;
	bh=2lwC8t7cAngkPhM9CWEOePbjKZzinY9vlg4dD5N0xGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbJ7RMXCMYU1T6sXoid3SqJdOk7O/2vWhXTuO7PR0KGJwIAF/ACd3Kjo0lLgXhU5FOb/LzBwl2Jz6T/2wBxdwXZ+Nty3/ix7TMkv/rWA8lT7GFYMyUDuUcwZkpzVVRQUyKGOsujDSWMs0waslAjRksNxOKsa86v3MRle8mW67E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja55T0ns; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja55T0ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7332AC4CEE3;
	Tue, 29 Apr 2025 23:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970817;
	bh=2lwC8t7cAngkPhM9CWEOePbjKZzinY9vlg4dD5N0xGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ja55T0nswkxn8SnXB8nxQ5xmsJYujAPU3voR0n3oUI/bdEJ2/4KTV7sc9oWtMpcMJ
	 Q1BR6CUyq+OdAahdexN1mtNSytKSDGmkzMzZKroJP3q2sxWuLw2NE3L2Sfb7XGu386
	 rsxVkMuE1/5G/qQPk/35M4JnApiEjjMRjAD9cYB8H9cr116KATkMQfuX6byBzynARu
	 sg+MRWCFHYBRZWuF/n/YN4OLGhgF3VHZUC0nK4hzmW3Xh18Y5jU9nb+RUGZgKES0iZ
	 Hm4rQDA3GV2G4+Pu/Q3gERT/tMgUO9Ll2Z/9c3cHNwL8UNEYwuJYtJLufGnx30vC3y
	 v2hP24G4c7wUw==
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
Subject: [PATCH AUTOSEL 6.1 10/10] samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora
Date: Tue, 29 Apr 2025 19:53:15 -0400
Message-Id: <20250429235316.538129-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235316.538129-1-sashal@kernel.org>
References: <20250429235316.538129-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.135
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
index 727da3c5879b2..77bf18cfdae7f 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
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

