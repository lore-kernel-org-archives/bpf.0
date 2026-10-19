Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692378F3A
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380267; cv=none; b=RbzFacdqEHNkhxO4wsph11UcsmNnazfkr1/wo+K2BJhTjSnTd3FKlfqonwuu5KNwQofun/z6eNTWxPnUfxLqrr5+YVoayeXNvDVDeGKveiNe+3gJklMa23LnF3iI2t/wbEpwRZU2eOxYMe7vt2cqpkOEcqwyScpD8WwrxRf/hXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380267; c=relaxed/simple;
	bh=An2lPq5GJoEtpPlx78EEh85Czi/YtMsoji95nHL5xy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVVkIMlzlFsVIgA1AjQ2iS3EiJ0nwhxu0SCYaRvwNrukdJzM6Pc9QGt3y83z/50Icy9AfPo5DeqHEbzbF/GCb6y944OjVwqQuD/EAWglCcmkw9u+CFcQDNsbBxD3fYqUnD5iYx1yehZztgvcK+C+aAIg2RbUaS91A11H1CFP+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KetEH4qL; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KetEH4qL"
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6dd3bb640bcso282761eaf.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380265; x=1792985065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5zZfPljFbBSjJQeQz+Dmo5DUnM65THe9CEIaweqKdo=;
        b=KetEH4qL+QtoZpvgAYxYVZbbOavxrK83pbcqzKMIpdolfGKAcLevP54NvlRmUS9gki
         pd0yF8qybwURWrtnRtDHdGLMkLIz/GAIIjg+7eqAmjHfeompnIpxIt1UdLT3rUtAZzFG
         iUFr5SsJMTgqu1vSV3XD0Abpzzw4KwOKjqYOTMWuMATtOv7ROGCPuF/KwmgTbRJRoD6e
         xT7G2Gi/GX+giFxN1jFpIQfF+bVXg6Ab7hAuEGnV0Ade/efBHgDde1kEh39fnJkLNQaY
         WjzFj1W2jjDVBr9ij80EY1pZVbS8Dg5sIq4AE4/tTQSTD6AKLkGLlGQg2abqb3ovMrxS
         mZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380265; x=1792985065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t5zZfPljFbBSjJQeQz+Dmo5DUnM65THe9CEIaweqKdo=;
        b=Y6u/o358F47ZyBNDN6+XceGc+0b+lr2/zshMCay0cXSMcTFpP+MEkVGCLSYOG6wZsf
         I+xP8yZVfEHudGb8/cy4Um3Z218ESfDLQhLGcUdPvj2b5mpkhnjWAbx9mx/aEkhr2SgR
         bk8aiPtwHZKu8RPoycp/ZP67eGKxdYuI1T9EOf9t2Gq6+Qsfy8/kUpzCGTjSjd6U/t3G
         F8ALWWSXKrMsIbuiZMzaqo6xJELnmaWX4zdsi/MmpltCjy03aRR3GG+um83s4t971o7h
         WRi1xPW7c65NUcjXjOdqdR1M5X1pnOEOAJbTsEIEGPSH+BUkq35aRDoTRVqNhUfMBeQq
         2cPA==
X-Gm-Message-State: AFq9FYLusp+HQSK5B3QKVt+ss1uYoRoqbzpNqCEU5kIZJY5a+v+zogZ+
	qG91sXf8VROOIQbBjj58fKfSoATcBSH3N19mHhIk/bIVVXyKnROIMu0tiADRdROqQ+0=
X-Gm-Gg: AYBFou1eEIWPtwsy8toNahi/ROPvhGfK3v+5d2X02wWAunI4PBIiwVTgmVDr09rfS9O
	s7ZN0uuqx8RsDTb3u4nvQsqqP4cYifZaOPJZiy7l71qkVYJPNqeFDSYSB4UvBuLcAggT+LV+ATF
	QJbI8eI3NSD4/DriDDW6ki0/z7oicf4lB4lK3ZQxnRGiVLqF2hrR8+eCL0aAw3cOs0KDaOtvWGA
	0apjYXXRD+LjZRHRJ4Pd7EIsV/tGbNCy/VjGnrxiKHyP9N2yxE9gyMiUEHDFDcQvnL2M70kGJmj
	uh2SU6YV2FQQdUEuBe710PmdLSI8eYcm1pfCJfV+kPT5QL/svX8L0pYf259DpYcBcoIXp0mPmnP
	QRwTeVv2Ggbymh8pw/sR7d8lr12lN/IevP5JQUbGstXGsI+ikOqYtyN5uuXVbqTeJFvxwUZ9cVa
	0KM/DKPXXxWsfLhHXIYwLfVxlQ2MaA2dhosRJIpmNqgYjV/HbfxypdHWsYXd4gJra0ldyEL/m7l
	2KXGQ3D6iEbCxMT5vHTthzGWq0sG/RYQm9314rSl1d7BTujlGjhU7UfWi/G5lY84s/RNdWYobEG
	gP4VRw==
X-Received: by 2002:a05:6820:1508:b0:6f5:1e7f:c64e with SMTP id 006d021491bc7-70354c4b4a2mr3309036eaf.14.1792380264686;
        Sun, 18 Oct 2026 20:24:24 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70190c1c106sm7113161eaf.12.2026.10.18.20.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 05/16] bpf: Add the __arena and __nullable BTF type tags
Date: Mon, 19 Oct 2026 05:23:45 +0200
Message-ID: <20261019032401.2302823-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; h=from:subject; bh=An2lPq5GJoEtpPlx78EEh85Czi/YtMsoji95nHL5xy4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr+6WzmW7FWvF/Y49b2TXrt1uoM+XZX76j93zrntfM2+/ /v+1o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMxLWZkWDo/LLHjYOp3HVGnhf+y67 0O3135tbZ61uyXFWFSR9+IWjIynD54ZkODl+inQh/Zhkfak/dsnGbjJXgkYuEHgVWNZd928gEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kernel structures increasingly want to publish pointers into a BPF arena
to the BPF programs they are shared with, and some pointer members that
reach programs as trusted are legitimately NULL at times. Neither can be
expressed today: a pointer member reaches the program as an ordinary
kernel pointer, and sched_ext resorts to a plain u64 holding a
pre-translated arena address that programs cast before use.

Define __arena and __nullable as BTF type tags, the way __user, __rcu
and __percpu already are, so that tagged members survive into vmlinux
and module BTF and the verifier can act on them. To kernel code and to
sparse the qualifiers are empty: the pointers are ordinary kernel
pointers. The verifier side follows in the next patches.

The tags live in a header of their own, bpf_compiler_types.h, rather
than in compiler_types.h. They mean something to the BPF verifier only,
and only the few structures shared with BPF programs that want to
publish such a pointer carry them, so the code that declares such a
structure includes the header and the rest of the kernel never sees the
qualifiers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_compiler_types.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 include/linux/bpf_compiler_types.h

diff --git a/include/linux/bpf_compiler_types.h b/include/linux/bpf_compiler_types.h
new file mode 100644
index 000000000000..5c9e71acfdac
--- /dev/null
+++ b/include/linux/bpf_compiler_types.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_BPF_COMPILER_TYPES_H
+#define __LINUX_BPF_COMPILER_TYPES_H
+
+#include <linux/compiler_types.h>
+
+/*
+ * Qualifiers for the BPF verifier rather than address spaces: __arena marks a
+ * pointer into a BPF arena, __nullable a pointer that may be NULL. They reach
+ * BPF programs as BTF type tags on the members of kernel structs shared with
+ * them; to kernel code and to sparse the pointers are ordinary.
+ */
+#ifdef __CHECKER__
+# define __arena
+# define __nullable
+#else
+# define __arena	BTF_TYPE_TAG(arena)
+# define __nullable	BTF_TYPE_TAG(nullable)
+#endif
+
+#endif /* __LINUX_BPF_COMPILER_TYPES_H */
-- 
2.53.0-Meta

