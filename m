Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3621D7E5C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566786; cv=none; b=Fg0fUCi5kC3g8bxlH0sgupMZjgFAJnwImb8zhN88ApJVcIk15gqf8SZipl3KBNOuQAE41Me9UOw3kP2aCSLnPX2LQm41P8hVqqhmc+SGwxSOZME2uvnpdRaANSYZ5z76DsgutsOUaEuE6GsVPz1qz/RfkK+G4N1XrGENEN2+bmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566786; c=relaxed/simple;
	bh=XgVHISGH0KRGvYRS9vlOUHAh+y1Tm9fP1+Hc4OAW9Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTTY0IvwNB0bSeJFU7I1KXJSW8j/dx6sM0YN+psy08HyDVgXR9FAy87LIGPRHnL3Nkw9coh6RSYR4dbh2TPCvmmRQ9NvHeTf5C41xBBQmXLeRQC+sPD6GUPAnaLyhblcSPW7sgK+3x9hntTmMl03B4FEV/LD6jx6unESlHUXkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3iCOW8B; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3iCOW8B"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381b831d535so2328118a91.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566784; x=1789171584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fO7wA/D1WGxmV4jGTDHtjwx6Ro/sEQTVQb9a+IQOwEg=;
        b=T3iCOW8Bew/EXeYtePLve+1gCRkGCOD/6sXaA5PvLaW0pO2abb3DFJh4wUNK4McKhS
         CWJ9SKM9GPiosoGJYmBteCMfJ+Cg0Kagh3vUj0AbJP2Y0o8NZj13fAMWts+eM/zgWFdi
         TB6K42OS9YR3zH29cn/Q3+zgrcFN6EQ4+f6pc7gNQ/knrkyiwg0DubLxrc8NczkknLXL
         oHN5O5nmV2Xex5jLnAGJbd5YXkebzEbvwhWTAOGkC4wLhQzFRjYJmtxYWyYwpzkpMRFk
         RNoXFBmestUlYXJk/iunrpWmjQhOPD8U6lKr9DV0Q4OQbcJT9xunU9/pFgBQKChY4Pg4
         0K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566784; x=1789171584;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fO7wA/D1WGxmV4jGTDHtjwx6Ro/sEQTVQb9a+IQOwEg=;
        b=Fh9+5UlthTQFUguX7kx5GIpeNeyv2R37XFFRaXn4qGYJ4zstEkXd1YsJkY06V7T42A
         N9tR1VUsE51JM4B5ovpVupRvM7mozNOhmdQ/oc4iHuPhr0XH252g2I3/AvsU3s9NCAqh
         GPniYHDJKanXqMrBT7m4mQbMAe5wKWgcmXMGI6BR/bePBrXP+kYFT8rDYnVr2sSMplTa
         pL0j2L3IkJv/9wVxWz/H8KjwpTJeOioMEhAXPdro8zp4i6j5pmUGbn9J3LfFc+UGjHVX
         luMoGskIj/0M9LAF83WRasyXkSUJlVhFibjSq4A4I2441a+a+bjcvyC7o3DjH/9KPhVe
         jxnA==
X-Gm-Message-State: AFuF++nPfXrZ1q7S816y2Vys2Oj/5bFaTLN4/cbxc0eg4vrdOdQPRPtS
	HXJ4r3uya/ifxSDr+QYqFZDtPecTvncIvMhe2jY14slso3+5FTwof7WC9oT9GjgG1M0=
X-Gm-Gg: AYBFou3x5Dw+rLpDp5EXdb9LkRRaBvCzBGfkMLdiSLwmjoz0r3W0eG7sQHgGHM9mjnd
	PCLmaHC7HFB3sJwd1rNoFk6n2/dXwP4cU6B0izYSw2ezchhk92Nagh0Ua4ulYAR9ogGOJTvWy0i
	0itkH69VTWBSjWxIbs0j3NCS0HRWuBZAGnOpdjJdvRVrWNtdUcB2cZEV1oPa2UCZsg9vxaqhWCo
	dvB61iC3My/7HJwpL/8NfBAXn6MrsvchwIuQ9VulIZhR0Pt24v9jwDvZa5nJbxh1Y2HCbyf+z/j
	DoUePKG0mhRCbwL44I9UGJdI7e/RWO720Tf9uJN/JwrqQhZNYPYBEgRB4efLCQXvJ0/0tmp6Idt
	MGM2j8xlUvU5UjF/8sArHVGrKugvi64io1dEOE/ErkLLNNz+oqAPmR/JY6DBBH1/F9H2Q5Lq0VZ
	LNS5d69rUalYOZweIeCNkLvWlMAzjs67HbawkjKf7Nmz2InCNsTgutv3r3RoVOqnvcLNd0CaNrj
	AnEntt3IWapP2L4XiZeP+V6iWRq6Bd1xWWDq8efDKS9WQ==
X-Received: by 2002:a17:90b:4c52:b0:396:d27b:89b9 with SMTP id 98e67ed59e1d1-39b2612ccddmr13304256a91.10.1788566784444;
        Fri, 04 Sep 2026 17:06:24 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 06/10] selftests/bpf: precision of a NULL kfunc argument
Date: Fri,  4 Sep 2026 17:05:57 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-6-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Check that mark_chain_precision() is called for a NULL pointer passed
as a __nullable kfunc memory argument.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_precision.c       | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index fb7dfa1246ef..f4459561bf39 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -2,8 +2,10 @@
 /* Copyright (C) 2023 SUSE LLC */
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <stdbool.h>
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -708,4 +710,36 @@ __naked int null_mem_arg_global_subprog(void)
 		: __clobber_all);
 }
 
+/* Same as above, check that path with r3 == 0 does not prune the path with r3 != 0 */
+SEC("?tc")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("R3 type=scalar expected=fp")
+int null_kfunc_arg_dynptr_slice(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r3 = 42;"
+		"if r0 > 42 goto 1f;"
+		"r3 = 0;"
+	"1:"
+		"r1 = %[ptr];"
+		"r2 = 0;"
+		"r4 = 8;"
+		"call %[bpf_dynptr_slice];"
+		:
+		: __imm_ptr(ptr),
+		  __imm(bpf_get_prandom_u32),
+		  __imm(bpf_dynptr_slice)
+		: __clobber_common);
+	return 0;
+}
+
+void __kfunc_btf_root(void)
+{
+	bpf_dynptr_slice(0, 0, 0, 0);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.55.0
