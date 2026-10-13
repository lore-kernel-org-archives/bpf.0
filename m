Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4933B14A3
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879628; cv=none; b=ia7F8EaVx5iGVTlXI1iW7IzoFWl5N3XPPQLyzoEpfGuJ841esohuO+xhztEB5lQAUVD/gq/PU1MAqRsppzyxU4U+0oafdF0FlxLIomzlcRcBSZbk85VvSVYICnM7/REwJ4WS6M4uSHz+4MnV4T+DkPALkhGNhoNbWWYy5dSl80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879628; c=relaxed/simple;
	bh=t7Ln/IuDVwV2Gh/NYDdesfc2WRWqWh0L7iicESGQ0i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyAuWYtLKA9Cc9rndcV1nkQ1sgsAG25I8fiK7qcYHKMNVwtnaBOoVRUbRBh5Wphw4GcuLOad1W6WmHxd3ZtuKrJbUY4cFm1Mh15vGGHl7UJ2SBJguiJVjJ2hT3RKDasAV0xkMAvQxWW3GHV+KicbI62R4loAu2WI3IbQ4TVXNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=resH9Avc; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="resH9Avc"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-826f42e479dso1809593a34.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879626; x=1792484426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+xEAs8Cym1k7nPLCuR91MjLbRNFmHcnKdg4A6RMQbg=;
        b=resH9AvcvCeLInjhNim4kMw6QRkKcrTq/W50gENLKZLM7Bw+qlYWJ0Ar0+09H3jiRE
         /JUcbpG8obF09/ZnI2SAWRMMjTTwvwoujBiovO6dtY1m9BPNkzqC7kBT2TQ9w1OZH/yp
         KMgqo8W0GGWZGmCGsGQPzV63SJzNYJZUDr/chHu6d8hSnM35EfZGJtOcQ6m3mLIEJr99
         EGYb1LMUE9JST8rVfzKHn7Y/Qiqn9ollNF+VqrELzV3GWFhrF1HgxaJkWmjha2i7gtAz
         b8Lk+7AsfdnggY8WtPa/rYMJteyEqD29VkfD6Qj98pPFZqyg75Y/Qxyfamsfq08tTUJQ
         XTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879626; x=1792484426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+xEAs8Cym1k7nPLCuR91MjLbRNFmHcnKdg4A6RMQbg=;
        b=mu7SiNAbTTUQWx4Q7+dCu2Dhzslk1MvSV2vS8lOCv8tnUW+SczDACz8NuTXCDnFH0K
         TawvjkxiJZrgZHNGofxAoMqZn/6EL19TR3LbjsSrahnaC7AKmDD0Vl6W14mhVrcI9n5Z
         4ELOS+FRDXEx4lpZLkAP+IJxQw709DNrWIua0cH0wQF/sJLODFITXj1HbiYsgv9eLziZ
         dxaZN5ICeUdsZPMjpjzZimnrMVL37+0hmBhoQLXKFcsjPYA8bnUxKzqZpz677dpza810
         HFDYQphOSM+T1boakDLqbjyS3m4nlzxRxUEOBWrit29yqFiWgplKseo3qn/CQDLhwCOn
         G1fQ==
X-Gm-Message-State: AFq9FYL9qQOxCqJvm989dPPnSBMBqNsXZzczpReYB48dWeXgnB1VyfJy
	dIi5slq+mJ95+4II24AloiEMgj7U4UvQvy/5BEbAO7BduXZZgiA4PDEc7WCT4X88kfw=
X-Gm-Gg: AYBFou3I9/zGIfQXupKaZ9n8GTtc+uXs/jijqHjEAuAHqYdP8mCO9xcQ9WUMdWXuK6h
	NfkNGS33B+SqDDLf3GZqQQDnQ4T9r59Aez5xevgIV8rvfmQuBq/XN0ChrLEIAUkf1BLCCT1VlWd
	6dQg+WnLlreSjnWjxH/zsuMluuv+a2oJYvFRKlRubgGaJvWU1y/RJ71n7rUc4STwvLBWoEoYawM
	DfWr0V50FDm6g4ki2Y9SfWaipwmfiydimX8Zz3wpQeyZtYmGDWFPzyNORur2oZPtqPNsYxS7lEj
	22ySIP8KSepovZXOT4JRjbM9VkB6G8YceDtwb94F4NlvoiTjX/0odfSuJ/UlGnFJe1YBbIB9Y6i
	tNsDDhzasskCWhGy+Mvjd8XSq28dMDD+FswtKPjR165B6vEJPQpXhW4FqGmWvvvv1kZHmRnB9MD
	ggEFGYfI7h78VnVAjE8a0RIjYKIS1yaDBF5lSVCVjozuekG4kAh+JOb9LcHJGT7w43ho1htXOoD
	Amxinou1RXxLRm95fWIOKX0qcpPKPt3OMOXsIWh0LmdE5Q0a2jdI4MY2koTkze+p3UrpN6JD+CI
	AZAHTQ==
X-Received: by 2002:a05:6830:449f:b0:815:40bf:e777 with SMTP id 46e09a7af769-83095d20990mr11430625a34.13.1791879626193;
        Tue, 13 Oct 2026 01:20:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830384c4985sm11295972a34.8.2026.10.13.01.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 03/13] compiler_types: Add __arena and __nullable BTF type tag qualifiers
Date: Tue, 13 Oct 2026 10:19:58 +0200
Message-ID: <20261013082012.1107446-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; h=from:subject; bh=t7Ln/IuDVwV2Gh/NYDdesfc2WRWqWh0L7iicESGQ0i0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy3lnf1a/7q+zTNTm1ntvGSPmlDopfurR/rCKlMQlN2+t my/XUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIns+MnIsL59So1gcOX7XbfEVs9nV5 lWF1He6GjLeHg2z85GEdkaY4Z/BquTs/evbdOT5O2ZZXZO7vt8586Tu3n8Vh2zrJ7V/vwyIwA=
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/compiler_types.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..e97ee2d4d1df 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -51,6 +51,8 @@
 # define __iomem	__attribute__((noderef, address_space(__iomem)))
 # define __percpu	__attribute__((noderef, address_space(__percpu)))
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
+# define __arena
+# define __nullable
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 /* other */
@@ -70,6 +72,14 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __iomem
 # define __percpu	__percpu_qual BTF_TYPE_TAG(percpu)
 # define __rcu		BTF_TYPE_TAG(rcu)
+/*
+ * Qualifiers for the BPF verifier rather than address spaces: __arena marks
+ * a pointer into a BPF arena, __nullable a pointer that may be NULL. They
+ * reach BPF programs as BTF type tags on kernel struct members; to kernel
+ * code the pointers are ordinary.
+ */
+# define __arena	BTF_TYPE_TAG(arena)
+# define __nullable	BTF_TYPE_TAG(nullable)
 
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-- 
2.53.0-Meta

