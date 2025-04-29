Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE332D47AF;
	Tue, 29 Apr 2025 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970795; cv=none; b=elAP9FpyebOCAoxZhFcCSC/md7ourXj5gx9sJN8UJ5O3VAGp8wIAtuF8scXZIloHtH4OfKvOiW5tdiabal4MBAV1wkQusXdM0J3wxH3utVXmwpFmqWVsTlWHxi7crUzsH62Gf6z+Vvzx713OxVwWItx+GQcZLDbNDXDyxvaeVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970795; c=relaxed/simple;
	bh=vWHYUEi9UcQLIVL8E92xlFKnf+7fdSSjqTckVyZk79I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6mDBkrXdqIS+pn0SqaB9gjAx9OZ/ClIc4hCBGEpmac3SY7YRwW/iZ81otnWQF0LjO4POvDFHYMOhg95BW3SmYNzSuMZW4JyvBLb+h7WZ/gXhJgK1mgn1O8e1QYNX6Li8J0sfzTlj0g5pk/bzuTrgcZX+Mzrqhp9kf3sBdu516k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRDzEbDr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRDzEbDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D68C4CEE3;
	Tue, 29 Apr 2025 23:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970794;
	bh=vWHYUEi9UcQLIVL8E92xlFKnf+7fdSSjqTckVyZk79I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRDzEbDrjCTK9cu379h+hlb57NsHFCj40nD5+f7EC7oJVM3FUxNarwKZit0TNxSYi
	 tXjM/5YlFWls/9rBAx4TDo2hUcjGXaXIGoQxo69gSmnI/mPJnYHi+bmB/vdhEtYW/9
	 sMe508i7nAEyaqW+MeAtmbn1Sa/BtMGpT1crTwHDbgXmfA81aAl7a7VI2ko0N3Y6rY
	 n7nKvc+rdoJLFhTceEEc6AQ79T5r8CZ9ZvWjNaewdthDt+98zGxvFYcVwNucuQ9RwR
	 rMQBrxEEyO7CB5FJorJ6SdN5GS90LAGaipG1+9Cf0qhX3XHJkguJq8tVpaVBmFBSu8
	 SYr9RxYs8fMtw==
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
Subject: [PATCH AUTOSEL 6.6 21/21] samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora
Date: Tue, 29 Apr 2025 19:52:33 -0400
Message-Id: <20250429235233.537828-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235233.537828-1-sashal@kernel.org>
References: <20250429235233.537828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.88
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
index 3fa16412db15c..927d72659173e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -392,7 +392,7 @@ $(obj)/%.o: $(src)/%.c
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

