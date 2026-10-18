Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3D4BB26F;
	Sun, 18 Oct 2026 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330151; cv=none; b=KOj54SA/U58W/oJCtQrqhX0PSn1lCJ5BCAHs+y0JkLocsVQ0KKQRegoMCvMOflLjuRkRAlnd7OY/ZAMLqAVVO83Vh/q7OCo3VwcdKPusdNC00z+loR7pibLj9uJwAFQxPKDiyws8BDrqaZj7oBqkZTusv+TOCO4m3seiOiDwFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330151; c=relaxed/simple;
	bh=Oy5y3DJFPzMFGOBPt5HJMvmmARQ2SdAdvs84vXit2Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DksC/LCqLIbrQ1AqRhiXQ4Z7dvM7DJFyaiCd9X+hp1XVt4PrN1WbqAmquyu5WLcGUfv+IQ/XA6tIOW5fG21WVr62ocrirRIFn85mvxqKEc9Tqv/+/bbfMQU+ms8beQ3S4fqQ6u9GFNk7D7cLCECEm2tctvIy/hg8Jlv/swqis5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ+7Gji5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ+7Gji5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D4D1F000C5;
	Sun, 18 Oct 2026 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792330150;
	bh=MGW9gS81JOGmQhAC9OrTzEkmznZ+6BrPV7a61PBlbiY=;
	h=From:To:Cc:Subject:Date;
	b=jQ+7Gji5398VsfxuIyNKoWG3c80C6uFP86YknrNLVg1SjybiOFqi6yQZAu46udGVk
	 v4j9A3HiMjwdR3X91FidNxnwzAlsgdxcd4jD3knSSkpE5zzx5XNGZs7ikGYIq9SS4A
	 BsKM/W2XpYjYGcFcBCbewR74GiDwqf0xfzKAEsAnSzJe4mXCRxV3r0k1gz2bWK4faF
	 b96B3/+XRXN3Nf+rx1G6M8xqT8yP8clPh1sqzmRd7d8Icb+6JdBzKfUZFPCbZxQCk5
	 cH8ZuzFDyM7R0v/HILU4i6ihzT5mwhT3/ZYUXU8WZr83Middj4kTXnh/jVmCD97NOI
	 m9ajISozhV7CQ==
From: Sasha Levin <sashal@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Stafford Horne <shorne@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	"kernelci.org bot" <bot@kernelci.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] locking/atomic: arc, hexagon, openrisc: Define arch_cmpxchg_local()
Date: Sun, 18 Oct 2026 09:29:07 -0400
Message-ID: <20261018132907.3823160-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ccb88db8dac8 ("bpf: Don't hand out a linked element as extra
element") made alloc_htab_elem() take the per-cpu spare element with
try_cmpxchg_local(), the first caller of cmpxchg_local() outside of
architecture code. It doesn't build on arc, hexagon and openrisc:

  include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit declaration of function 'arch_cmpxchg_local'; did you mean 'raw_cmpxchg_local'? [-Werror=implicit-function-declaration]

raw_cmpxchg_local() maps to arch_cmpxchg_local() unconditionally, but
these three architectures don't define it, and unlike nios2 and
microblaze they don't get it from asm-generic/cmpxchg.h either.

cmpxchg_local() only has to be atomic with respect to the local CPU, so
an architecture's own arch_cmpxchg() can serve for the sizes it
supports. arc uses its relaxed LLOCK/SCOND variant when ARC_HAS_LLSC is
set and its atomic_ops_lock() variant otherwise, and openrisc uses its
LL/SC arch_cmpxchg(), the way arm64, riscv and s390 alias theirs. The
hexagon arch_cmpxchg() only handles 32-bit words, so hexagon uses the
generic version that disables interrupts, like sh, sparc32 and xtensa
do. Linux has no NMIs on hexagon, so that is sufficient there.

Fixes: ccb88db8dac8 ("bpf: Don't hand out a linked element as extra element")
Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://d.kernelci.org/i/maestro:78b65519ee4561df1fbf1e72f1dec9da7e5b153e
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610181750.BoqAddaF-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202610182048.aEaiBP8W-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
The only user is in bpf-next, so it is probably easiest to take this
through bpf-next with acks from the arc, hexagon and openrisc
maintainers. A similar change was posted in 2023 for objpool and
stalled once objpool stopped using try_cmpxchg_local():
https://lore.kernel.org/all/20231121142347.241356-1-wuqiang.matt@bytedance.com/

Build tested on arc with and without LLSC (including both KernelCI
configs), hexagon (clang) and openrisc.

 arch/arc/include/asm/cmpxchg.h      | 4 ++++
 arch/hexagon/include/asm/cmpxchg.h  | 6 ++++++
 arch/openrisc/include/asm/cmpxchg.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 66b3743c94008..93f7153eb267a 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -59,6 +59,8 @@
 	_prev_;								\
 })
 
+#define arch_cmpxchg_local	arch_cmpxchg_relaxed
+
 #else
 
 #define arch_cmpxchg(ptr, old, new)				        \
@@ -80,6 +82,8 @@
 	_prev_;								\
 })
 
+#define arch_cmpxchg_local	arch_cmpxchg
+
 #endif
 
 /*
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 9c58fb81f7fd6..e6114e713db9f 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_CMPXCHG_H
 #define _ASM_CMPXCHG_H
 
+#include <asm-generic/cmpxchg-local.h>
+
 /*
  * __arch_xchg - atomically exchange a register and a memory location
  * @x: value to swap
@@ -72,4 +74,8 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 	__oldval;						\
 })
 
+#define arch_cmpxchg_local(ptr, o, n)					\
+	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr),		\
+			(unsigned long)(o), (unsigned long)(n), sizeof(*(ptr))))
+
 #endif /* _ASM_CMPXCHG_H */
diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index 8ee151c072e41..fcf1bc8db8fe9 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -140,6 +140,8 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 					       sizeof(*(ptr)));		\
 	})
 
+#define arch_cmpxchg_local	arch_cmpxchg
+
 /*
  * This function doesn't exist, so you'll get a linker error if
  * something tries to do an invalidly-sized xchg().

base-commit: a6303535c2ad9d49598d52556183911f02287791
-- 
2.53.0

