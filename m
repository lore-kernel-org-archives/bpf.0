Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953322;
	b=zc7+N961j+LIJXdni5X80drAneXwkWS6zSsvPgUio6Sd4eQty287LXyVT0kYTPL9DXZI
	 k6Ag9kATprgX52tDLRKmHGlkNk2E1bBofUKiSOyoSIKcVvKZhDzTnXV7um8euODdJf2TV
	 2hkNF1s+uu95D/pNGob6byHC09/RrlXr0gceTm+nXSJzoQo0dS7mIeWZ4AknYZBKRNniz
	 G3lp3ZMV6rPxi2PHaPtTAOh0JId7pwxI9RxHACKGDxZBtiRegjyff9zWbpW7ldYcpunHw
	 OWJ7ZBQgmqSkzw5QB/Uy4hYINg+pAoGIoGhrI4y7F7pdxNQGz2Y0wJvVcnZKjYvAg5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953322;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bI8B5pGHz5h1ly//mHf7ndgFx4Rz2ltW2HmUrfyIsQA=;
	b=PLHs4lw4U3gTKyTADdyO1X4g/nHw2nhPZa/86wIe1jK/c7KCTSJxjP5rbg6rD+YAcG6D
	 ZWt4R6JA01HrUoGpEI7yeExUqRmU9xJ+tkIAf35wHsbBqrDtppg+ljqavXv1XOIdJELtl
	 a/D+9sokAgvKiBfwQg835xLkqW6JaZ0tIK1BW7RtdSK5+zE1ac5DEMLSvWAZTPmbUjEJp
	 rm2nKan2BlbHn1FkjJ5dQE16ol0+8c3PIqF1n90lKKfa0dU4HrGzqWkLExk8JdosTF7RR
	 ABXDaC/cuwdkE9AT82sSoc0Byq7gXzoBvhDQSMd8rrGPfDhyZw8n5stfgn1OcCNR0QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M3qujAI1;
	arc=none smtp.remote-ip=91.218.175.129
Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887B6606A330
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 887B6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M3qujAI1
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6n3oDTFw9gSbVu7ljl4fwt44Xt31tv6c5y9tagZDFdI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794953318; v=1; x=1795558118;
 b=M3qujAI1eAiVRSUeR1KRAUAEnb1jINv2xfB6M1rMuIkDL39OO8hpitN0ywH/Wdh9ZqAEhH03
 ciCo0aG/EhCSCabtGg3pLu74jNK6ofZDj3NAY8n5s8y9Efri7hUovj4mC1emwg4EXZK0ls3/l+u
 DI7b2an/LIHq3fDEy3QuZNxE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2bbf6e667b38bebf;
	Tue, 17 Nov 2026 22:08:37 +0000
X-Mizu-Trace-ID: 2bbf6e667b38bebf
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org
Cc: chris@chrisdown.name,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	acme@kernel.org,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	llvm@lists.linux.dev,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH v2] percpu: do not put btf_type_tag on per-cpu variable declarations
Date: Tue, 17 Nov 2026 14:08:24 -0800
Message-ID: <20261117220824.609017-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__percpu carries BTF_TYPE_TAG(percpu), which records that a pointer
points to per-cpu memory. __PCPU_ATTRS() applies __percpu to the per-cpu
variable itself, so DECLARE_PER_CPU() and DEFINE_PER_CPU() put the tag in
declaration specifier position on the variable's own type.

arch/x86/include/asm/processor.h has

	DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);

which an x86 defconfig preprocesses to

	extern __seg_gs __attribute__((btf_type_tag("percpu")))
	__attribute__((section(".data..percpu" "..read_mostly")))
	__typeof__(struct cpuinfo_x86) cpu_info;

and GCC warns:

	processor.h:232:36: warning: ignoring attributes applied to
	'struct cpuinfo_x86' after definition [-Wattributes]

which -Werror turns into a build failure.

The compiler is right to object to a type tag on the aggregate, and the
issue is fundamental: every variant of an aggregate shares one DIE, so
there is nowhere to put it. clang drops it silently and GCC warns.

The tag is meant to record that a pointer points to per-cpu memory, and
cpu_info is not a pointer.

And this gets worse: for a pointer-typed per-cpu variable GCC attaches
the tag to the pointee, so

	static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);

comes out as PTR -> TYPE_TAG 'percpu' -> struct bpf_hrtimer. The truth
is the other way round: hrtimer_running lives in per-cpu memory and
points at ordinary memory, while that record says it is an ordinary
pointer to per-cpu memory. clang emits no tag there at all.

Add __percpu_var, which skips the btf tag (__percpu under sparse) and
use it in __PCPU_ATTRS(). The cpu_info declaration above becomes

	extern __seg_gs
	__attribute__((section(".data..percpu" "..read_mostly")))
	__typeof__(struct cpuinfo_x86) cpu_info;

The pointer spelling, T __percpu *p, is unchanged and keeps its tag.

Before this patch the tag also qualified the variable's type, so &var
had type "T __percpu *", and a pointer does have a DIE of its own:
pahole emitted PTR -> TYPE_TAG 'percpu' -> T for each one.
this_cpu_ptr(&var) is that shape, and that is where the records came
from.

Those are the records an x86 defconfig built with clang loses: 280 BTF
types, 140 TYPE_TAG and the 140 pointers carrying them, with .BTF
shrinking by 3360 bytes. They are the derived pointers -- clang never
recorded the declarations themselves. None of them were reachable: a
record points at a type only if something is declared with it, and
nothing is declared with these. The 803 places that do declare a
"T __percpu *" keep theirs -- the 110 tagged pointers that something
references are the same before and after. .text is byte-identical.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>
---
Changes in v2:
 - Dropped the "message is confusing" sentence: GCC's "after definition"
   refers to the definition of struct cpuinfo_x86, not to the declaration
   of cpu_info, so the message is accurate (Chris Down).
 - Dropped 2/2, "local_lock: do not put btf_type_tag on the lock guard
   type". Only the tag on the typedef generates a warning, and that
   needs a GCC fix [1] anyway. The pointer usage "T __percpu *" is fine
   (Chris Down).
 - Rebased onto v7.4-rc2.

RFC: https://lore.kernel.org/r/20261110012235.1024461-1-vineet.gupta@linux.dev/

[1] https://inbox.sourceware.org/gcc-patches/20261112191815.884167-1-vineet.gupta@linux.dev/

 include/linux/compiler_types.h | 8 ++++++++
 include/linux/percpu-defs.h    | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..b250d6870324 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -50,6 +50,7 @@
 # define __user		__attribute__((noderef, address_space(__user)))
 # define __iomem	__attribute__((noderef, address_space(__iomem)))
 # define __percpu	__attribute__((noderef, address_space(__percpu)))
+# define __percpu_var	__percpu
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
@@ -68,7 +69,14 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 #  define __user	BTF_TYPE_TAG(user)
 # endif
 # define __iomem
+/*
+ * btf_type_tag records "points to per-cpu memory", so it belongs on the
+ * pointer spelling only. Declaring the per-cpu variable itself puts the tag
+ * in declaration specifier position, where clang drops it and GCC attaches it
+ * to the wrong type, so __percpu_var leaves it out.
+ */
 # define __percpu	__percpu_qual BTF_TYPE_TAG(percpu)
+# define __percpu_var	__percpu_qual
 # define __rcu		BTF_TYPE_TAG(rcu)
 
 # define __chk_user_ptr(x)	(void)0
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dbe3267a0a13..f53fc430aaad 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -45,7 +45,7 @@
  * that section.
  */
 #define __PCPU_ATTRS(sec)						\
-	__percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))	\
+	__percpu_var __attribute__((section(PER_CPU_BASE_SECTION sec)))	\
 	PER_CPU_ATTRIBUTES
 
 #define __PCPU_DUMMY_ATTRS						\
-- 
2.53.1-Meta

