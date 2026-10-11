Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A43D5C07
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699722; cv=none; b=un9l1whHEZ8c1a7uiH/Pm2gV9/pi73tyYpZXZEK8B8fYLW90KPeKXpxp80BiND6/kAHdphHiUapyXRepbt/Rh3/JeFROU+AkvNRAeoKcjGlUN+9wkHKi/yiRbA9e/8egU8716jhgBuNpKv4sYDpdiCDspTQzw/iXgzubqxxH9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699722; c=relaxed/simple;
	bh=fKdB/WsnGY6uK1jttDMIVi9j4zZ7OwHKe8Hz+d44YwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9w15rxavxK/sbWh7tnrZhyJmlNE2Aux+DqyOnkGZOVKajLFFgfIh/jWzKqu8V4lnZ3vaH2x6/4Rts8ex+91iN+9x+Rjm/l03jmLyfyFiQwF0RdXRBIDJbez5FZ+nKvABvXdFKleGjUFG65R/ZSXmCKgygnhY19gOm/8EmZaAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIijWE2F; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIijWE2F"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8874539bccbso372099b3a.1
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699721; x=1792304521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PY4Zk91vI98NdjrFu8Uk9ZUTtzPjF9UNkOxHbrgeurc=;
        b=CIijWE2FqyUtIEWRU29aryLbhEAa5mkd1G0QqL4XQKe0EnREHmbYSqJv1RLVWnSZZL
         iBefTF0hoW98wbn2/J1lfBEbLjVs1mDQ0oMJkk1N+XfzBrH6TFoZD1aLrGuYc7HzCqHH
         OaHcdFrQK73OY2YmPsR9g5GLyhzUjFDgYqgnTNK2pybidclkx56v4PfqS2x1Ps5anZeg
         KNJr+7W+rT7K0pQrETCzqmNiswHjPcYLzqZ8Jjb3i6z37p+MLwU8a67U20wIZgZoZpbp
         3JOIFWjNuziZRUNAq55yuY5L22pC6lLkPHz6xNzekR73SXXYnbGKJp3pW7G5O2zdODAF
         o3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699721; x=1792304521;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PY4Zk91vI98NdjrFu8Uk9ZUTtzPjF9UNkOxHbrgeurc=;
        b=mNrn/YJGUiUeVflxwm6g6B6pbEOmmtk8rIfwIXYMaBlEhBR4QjB3rzeyAusGeQS5zg
         oimw2rXjhaz+Z/Ju8YGEuQiwO/amNbPU0jtgw+02dJo4iM5E0YfDdAFCfeSt/9YxnoQk
         XTvdCTDkJc51ADmjSsBA8kzU+nKSaCRfteLeMAcpMM709smO+HKsSrjCLp4sZqHhjdpb
         dUp+I9LcqVriBtN/wKNlhzRUcAHJqoFpC42ybAWTYgBYnrkRPmrfenHBIDQG24LxVowq
         7ft31L4RWgt8z80lBD8Ed+a+z25tDhGd6P0jI6Fo/lCAtbaIX50QUkwmLif8QEctjVG9
         7TsA==
X-Gm-Message-State: AFq9FYJol6CpIOYWXS20ycpC06GUUuY6s8WVH58LqW18gwaPjzcXcune
	TSlXiZdSd0wp6K6rChm4HtrVW7wrj/eM2caSrcEs7CtIMQPEW6I/NMFNucOmMA==
X-Gm-Gg: AYBFou2JodoJRcbCqNHm3+7BUtMabCLYBf/xx/X6ipSPPWcHYylx/HEoTwy1caR7XTx
	hI5ZZCCVs19ZikJimUsCob0QX1gIITK1AQ0mmWtosZgFZ9KumZxcHoCGiKPo5jl4nxs7O+ovmC5
	XSrwdf8wZgbqOU7TrXw+qzctdXy4rJEfXrnIYiqpDgwkPIS595UBS1ZeVnAAis7IuP7ykBnGFjV
	AI4k0Qh+a67rQ/+WzseZgHkAERWhqngl5mvKLStzKaamUTlLphw9E0cwDZasHw42A4J7vd+KQnN
	c5MUI35zgR7ZLQ2nxj96g3vmb6KsJhp61laZ7pQKhwjBx/RqhazCUGCBJxf3VptnhRojrmgjwSG
	hYKRxUXLFPxuiTgqlwCtcDH0jv6uE691mQIPNcyxThR0LxR/Gk3macS/nDHJOiRKnlPx4cb0K/A
	m4fXXBWKP4S4eTxH36WDPCkYSGRvyv7eb3PIWV+LyNbFsDlai9tEvT14GlRRyPyIQuSmqCGUk6O
	yVLXzJ1Hz3O6eTHAPU5zNNE7w==
X-Received: by 2002:a05:6a00:1882:b0:890:a995:1f61 with SMTP id d2e1a72fcca58-897c6e1e03fmr6219842b3a.15.1791699720665;
        Sat, 10 Oct 2026 23:22:00 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:22:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 7/9] selftests/bpf: harden __msg pattern for global_callee_btf_arg
Date: Sat, 10 Oct 2026 23:21:41 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-7-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The original pattern:

  __msg("3: (85) call pc+{{[0-9]+}}\n")

Is ambigous, as this line is printed on the main verification pass as
well. Harden the test case by ensuring a __msg_next sequence matching
the stack use/def results specifically.

Fixes: 063c85f5d8c7 ("selftests/bpf: Tests for BTF-based global subprog stack liveness")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_live_stack.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index d2fdc65c84c5..5f9b11a81260 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -249,7 +249,11 @@ SEC("socket")
 __success __log_level(2)
 /* Untrusted BTF pointer arguments need no caller stack state. */
 __msg("stack use/def subprog#0 global_callee_btf_arg (d0,cs0):")
-__msg("3: (85) call pc+{{[0-9]+}}\n")
+__msg_next("  0: (7a) *(u64 *)(r10 -8) = 0{{.*}}")
+__msg_next("  1: (bf) r1 = r10{{$}}")
+__msg_next("  2: (07) r1 += -8{{$}}")
+__msg_next("  3: (85) call pc+1{{$}}")
+__msg_next("  4: (95) exit{{$}}")
 __naked void global_callee_btf_arg(void)
 {
 	asm volatile (

-- 
2.53.0
