Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4F4FE2F5
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107715; cv=none; b=cO+u3a6GHiMyfFT2R3gM85Jhz35jSdEzJBB/HP5qjMELxmhR1k/jh3jm3xJYstUsoRLQXGbx32nV3eWk+597+vtZMDv7z6BpUwSrHCvdML/GolZj7Zwj5DwU9Gd3WmJRPGl5ei97j+QddjwKG4nj92RkgWpTL1hv1MSVqTc7ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107715; c=relaxed/simple;
	bh=t7Ln/IuDVwV2Gh/NYDdesfc2WRWqWh0L7iicESGQ0i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEYR1suySxUgAHMmnfL0rzxqDu51VPu3l93dOWK2rlNdwqts4Oa/B7qbk2akVz4B09kbwNCoVHJfP2NGM2WSzGF4hJ8XO7TBUslLijnLeOCMNC+nOC+dkkyRA7QxREsweThsj5n5OxGSHzA0ZwcW5BeoUUotmWvG0OGVvbeh3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlZHqvJb; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlZHqvJb"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6d7c77aa543so102068eaf.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107709; x=1792712509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+xEAs8Cym1k7nPLCuR91MjLbRNFmHcnKdg4A6RMQbg=;
        b=PlZHqvJblVVVJrlNQ73J5D4lh0ORVuVXIjCKG7xKHVHficsyXhfCVXqj+1S1i0eTuQ
         yJA9CHXz7hDZRlRXL1ceSzmAToTyq18X/akRyuxrGFkcATIe0JWyqo4HZ69n/PPedyQh
         TXuQ6xL4ayVH/cQCvKi4Lat4w1bbJsrpL2BVCEBPSyVtZ6fyyX2O5TUocq6LOL3QyzBj
         +WOJ9Ur3BrKSHd+LoBN/0MeSyEMj+uiyyYy9wEYiM0I4L+5qzuC3SxEbXHoD9fff/lih
         4Y17sRBnsXtt8HlHdWBgqRdOyTMkW8b3XUjQLYONYOMAd3g0KNCIRrMBcxFRAnynKKPY
         AjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107709; x=1792712509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+xEAs8Cym1k7nPLCuR91MjLbRNFmHcnKdg4A6RMQbg=;
        b=EcD83tmZfhyY4US2GNAiXaQNpTTLybesbddsrx8yRbtsHr2tptHQKksku72Wlp2lH2
         qlA5/nAUBKoS7pCJms7CqoXtHQYQGDGFcAR9FfCbWjYRKyQ6AwdDGajNgXs9+Vy7l2RW
         htcFNXYESrBDxeKI1/ZkMwN1CuZP/w1AxQ2K6Fu+8oH5lTBxE7S1lCpg6QYyXgx7Bpzk
         u7mqbMTmhhDz6PTkmXshS9wpXKqBooei1SRky4q2vILtzvf9mc2I8U5chHuguUGuGf+a
         4hQl5Sv8lQ5xeGvn78VCbrLiOrHXbukP655+o8Cew2dmmMjrGq1lr7wQ6IkhrhihU5CI
         Jrow==
X-Gm-Message-State: AFq9FYK1jOqcJaFcPIZgLCMvi0dCo+M545ayC41JxqtZBGO1L/r0mG52
	5ME1V5P9wpeVxWOQQRMX/8fmTw7h0sAlBZrAUe9b6Z2Sb3Uyzx3Hj4M4J504nbESh2Q=
X-Gm-Gg: AYBFou1i8jOoeRg83DUnOcdC6d6unYMRP6dNmDP171+d0rRGIvbmJFyngbiBaEG1uuo
	WMeHrenjIr5Rju453hgCUp7kHduw1nSsmflB9H+7dNyb9OldV1mtqC6cSpSpgqCcEp8jdFP7+nU
	Xws3Kz6kQMxRf2LVBexd90I0Lh7VpMr5WowPrVdXnYtk2QgoXdNOUJpPuUrIu215gWmQJuAXOxx
	NSftC+3G8i6CIfYLrD9A3yftzeMAcDxC2x9BLo+vZ4/ZfushdOKUB3JE3kiQW96bb8M5LhXh8Oe
	YM9HyTOzvDFaLdz33YlzLGDAAJUAXUHPtWt1rdY9VjDBgKCLSvcl4rWOe3RS0wdG48sPA0yMot9
	oUWxvdF/gfCstm0zSg+R4mzhU86S49UMudt5fwB9LScppxaNJoftwKloSiw9FcuYfRegvw6EqM9
	dGuaAjCev7uhTMozgqEc6xB8PTxV1GdMFa/mM614TQBcf39jX8uJ8pPhkGF128U2st4WmB4PgzH
	JFBRI0VRfmsrZ6OjHDUKqRVs/w4sVRo+REV+vi8tr6D7N0uUwRfv6Uw2Rhekv/NnV3b9appmQBy
	p4OA
X-Received: by 2002:a05:6820:f006:b0:6f4:fb85:5e42 with SMTP id 006d021491bc7-7010e4edc6emr987299eaf.21.1792107708924;
        Thu, 15 Oct 2026 16:41:48 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70190e07568sm485154eaf.14.2026.10.15.16.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 05/15] compiler_types: Add __arena and __nullable BTF type tag qualifiers
Date: Fri, 16 Oct 2026 01:41:11 +0200
Message-ID: <20261015234125.3152346-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; h=from:subject; bh=t7Ln/IuDVwV2Gh/NYDdesfc2WRWqWh0L7iicESGQ0i0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3OuzP6tf99dZJmpz6723jBFzSp0UP/Vof1hFSuKSm7fW zZfrKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQuLGVkeNPmwsjyhKk7o619zqYDFz 9PKRM+EbLfXiIrY2Ye8+63FxkZXsy8Ym730oDt5mP1ufLXl3d7mT7gLD118Epcn4XciqRH/AA=
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

