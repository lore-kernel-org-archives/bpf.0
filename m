Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E52BFC79;
	Tue, 29 Apr 2025 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970753; cv=none; b=MVo0+SnYY0d7IDgMu8lXGzdPeXOyvvsEzF29YdmWFjfaDsW89DaIn+2OCSrtBmOCe1MWLSQ6ZmfxcjjycDUybR5XFb/VoHGcC+7WHKiNv+g6EjnOe/18FBL6WkUcmv92On0718NgVSUD/qU4TtwhZaPJ1EF+OGvKT6s7fK+yJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970753; c=relaxed/simple;
	bh=Er3aY9LjtWCWUFSG8bdrcX0y6a1XyBTgdSUDsN4/Tjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teNTEUhliMgLsPyuR64waGHU7qR8Hek1qnZhj9HSTvoqFr7vjvSz6KFsyCYRxOtEqKX/jVBP3Q/yccsRYjg7c7b7VLG3n/d9EMQT8SEOK2sNtecDWiRljn2wviiayLeIg1o2POpqYRJ+VKZixofF1DiRcJyFkub+K/uDmlIUDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j97kjp77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j97kjp77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EE8C4CEEE;
	Tue, 29 Apr 2025 23:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970752;
	bh=Er3aY9LjtWCWUFSG8bdrcX0y6a1XyBTgdSUDsN4/Tjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j97kjp77fhzKykPA19k4lo89y1GUkil81xt0wpNM9PEdye9ag6oVexkfJTdEGTE0p
	 fvMOTMnwVZcfCG41ZcZ9zrxxggq2YapfhAblqANbN1DhNWtIoKnm8N+Z3jmGHl5JWe
	 Ou4RgaOv4lcjfl7CeUi/lbHYsN1HTud0UNoHf4PLQWdY9SDOrhsdhU4Syefc10fkiZ
	 9lOp+/b9Pb5rKoxBF/0zbuYwkOsqqt9Y5XlnU0W1mxOURN9R5Nop5Ea9TiMZ4ZmbL+
	 Fw2/ExafZKxsoh8nsrNqRem6iYdt2YMag1vILZLQ2UDuzBTVYmWnfjS4pV3ndgSdF6
	 dT67bViJQSBxA==
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
Subject: [PATCH AUTOSEL 6.12 37/37] samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora
Date: Tue, 29 Apr 2025 19:51:22 -0400
Message-Id: <20250429235122.537321-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
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
index 7afe040cf43b3..f06f88b26183c 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -400,7 +400,7 @@ $(obj)/%.o: $(src)/%.c
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

