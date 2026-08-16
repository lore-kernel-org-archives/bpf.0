Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02023C277C
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845483; cv=none; b=oFWNhsTQW0bznDmE/DEqkmAVHvoIbcOQWprEf3GUHTMCA++7YIWodFfi9FQCveqTY8AOpGDgH8LUZ8sgs7Lv2SDgqsWPb1juK+QTip1Yg/CgVX+IFN2vqxDElpbpUHcvmKHjupnHreJWQDLl/D2ey7DuLQTprBtNyoO/Jg07wCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845483; c=relaxed/simple;
	bh=sSTghYsIudOjjzJoBuPEODOXK/ZCofEkdfSM7Md6pUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDIMxy7XpBrfXUaYwOUni0Wvqhb+bGVvg3jVy9I1ntVcy0/a4pz8vosHlSQXTD+5JD454VtLj0n4nwIFrIvQ4mBAkkkJebA357fmftDVXc5x9nBOl8cbYYGeUDnQ0tJlrQgLBbJV+FHYTzCsdRKOT4Pbu8y7RUapWKJyAvrH+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yal+TUFE; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yal+TUFE"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso714990f8f.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845480; x=1787450280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaSF+U02ZBszMbc3rRt/VX/kBTH/XLumkD4iYoS0eLo=;
        b=Yal+TUFEanTFv99NIUSZv1oSak342a3hJ3N39QoF9+XTqi77MErMdS2dCHAdhvbWMV
         E9mPwBZy9YAo5QMiu4IOg4E/b/p4oqd+yovL99cukTUU1p6eaaZPCwumdCEQtv0/m7g9
         hbBi5G+NFZOEB04ByMIqM0Gwbk8EopoRTQ91iVICh2PELIvvvhNcQ5WU7fpdMwaNgNnZ
         rKLuYanq3MTisjrsvcHXtZwPU0g9MH6fUzO3zzESo2JiontoemulIh0KV/pz39DCNsZZ
         NYVDWK3OGB/oAFZiLPecQw4ufATZCxYgJj0oPIlpc91kfIqdM06ax7Zl5mSLk/2r6s7n
         +Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845480; x=1787450280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QaSF+U02ZBszMbc3rRt/VX/kBTH/XLumkD4iYoS0eLo=;
        b=WoSG4DtSxeokgAEZg9jIFcBBY15k5CdV94tjjxjsBzgpBn3GbuaodAIkmjPpOZLU3K
         HGsIp8jNuDC+eNtogFI+XAmXV5XhCWv12HehQf49XJ9C8nvZieJzJjVZ+AqCVfkF7xP3
         6tVn9tzU9k9kWJjjDvM9jTRLCpZDxTb87cvEPWUFe6ZZH0HgrFVfZMS8SrSWdXq8QpeL
         qoPWuQBzdG+DCrkLAZ+M1V/9VH1PONiwLoVROHOOaILtiBA0YrVXFjqRDm1kS8hc2qGZ
         pYAYz7+Z7vs++9c2AktNKYVsAPavFwj91CKPOTwls8pQasF/T6iaQ1vSHhUzETb/GnTs
         8d7Q==
X-Gm-Message-State: AOJu0YyGjq56myEB9V4/tBIVsb5XhQZsfmYty6ztU/CI6sHJroOOo0kq
	QzWwHZd5i4T3hSNZQuttvK2K2IsS4I3DALAznjBwesdnV8lKXACvr6T4d+nZnN00
X-Gm-Gg: AR+sD10aItxf4l/uN7yhdrAZZySMzEccqTTyidybZZMSHGPzvnhlS8+LGn6PDLRiIsZ
	p5zdPexgs1+XKi9/c74fCV13VHlx4R8q3Tnb9qd4K9BBEwZvxY8Q4Qzz1bbN66kf6esQZy5fsrH
	q30sGNymKGr28hXmh8DVjXk4kIV+b6b9G+WUREaq/X8ZfJA4h3mMgFyzrbjs1LWn5g2mOsMfr2q
	QiuJVSlcYeyz6sp8Ud2iXtkTmYjC/S92lP8SQsGeE7/T6YQS1aAGfTdqPhQIlgEYzS2Wi2iqRgE
	uqFSG21e0BkaMq0icBAiCR6KrxRdX93VN0+ktJiYHh96uAES7A/Y1jcuRNJux6K10pVUoBsUSil
	ytRwZwTFwIo2UDJTi9QAx11MIFrxxLqHLvbN+RLMen1CkWO+3Sgn2DvqKuNPHXaif63tR+TNgJ+
	dpmiRgLmUrwpcW9TFgCp6LNHPrz5vo+u9bqGHHy0VM/R4W1Q8uIom6u8U6OlFHaWIcOYLXZL43M
	J2sdUnFicvshwxWRugO4WfYOkpfh1WYAYqru6KeyNLxnkcYekzT7Ly+p3xhPWn3CEQLU4ZD1gzm
	G+qR8REQIkLdQIRs0UcI98QMcGk=
X-Received: by 2002:a05:6000:430a:b0:474:530:9d with SMTP id ffacd0b85a97d-4816072d2d1mr22810258f8f.13.1786845479914;
        Sat, 15 Aug 2026 18:57:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc81csm21492343f8f.34.2026.08.15.18.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:59 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/14] selftests/bpf: Test non-sleepable kfunc context
Date: Sun, 16 Aug 2026 03:57:37 +0200
Message-ID: <20260816015746.2632990-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=memxor@gmail.com; h=from:subject; bh=sSTghYsIudOjjzJoBuPEODOXK/ZCofEkdfSM7Md6pUk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQvx9/JQ37xITnL6E6EiKTZn7R1tawJJbtvf9vXnVZ 0sLD3J3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJ5zIwMM5M1RcMOMSy9PiOI vyXs3s6AMK810Xf5eYpffZ7bqDh9OyPDyfgnMY8W3XlgdPykQ3X59tVl6Vp5bVz3DRhYKrza7NK 5AA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise a non-sleepable tracing program that enters an RCU read lock region
before calling a sleepable kfunc. Assert both the legacy verifier message and
the structured reason based on the program's sleepability.

This distinguishes the program-level rejection from the later check for a
sleepable program calling an operation inside an active critical section.

Link: https://lore.kernel.org/bpf/2e42a1a2bf45f4d2aba7495bdc9f147558055740e2f3c8b9dae255f6c57fc13c@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/preempt_lock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 6d5fce7e6ffc..83c911494a34 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -6,6 +6,8 @@
 #include "bpf_experimental.h"
 
 extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
 
 SEC("?tc")
 __failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
@@ -127,6 +129,19 @@ int preempt_sleepable_kfunc(void *ctx)
 	return 0;
 }
 
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+__failure __msg("program must be sleepable to call sleepable kfunc bpf_copy_from_user_str")
+__msg("cannot be used in non-sleepable program")
+int non_sleepable_kfunc_in_rcu(void *ctx)
+{
+	u32 data;
+
+	bpf_rcu_read_lock();
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 int __noinline preempt_global_subprog(void)
 {
 	preempt_balance_subprog();
-- 
2.53.0

