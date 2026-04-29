Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C0376473
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473264; cv=none; b=jNF30nnIrrMafGeBqwpAgYa4E9D1NH4NXr1PJWLiJnHcm3NYxx0a2Nb4JzPeMBtkZ7w6yimIgoT6RW8AL6VuYIfARYvdoRkDIX93FkTitqnZ3s+p9c1zTAOr6iiaEnF/ftXPW6Px0QFhladtpaVE2oK++Tf3zSlkF45Xq01Xycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473264; c=relaxed/simple;
	bh=aqXG984YlUxMtsZ+i7vquyVJaGX8IceA6DEnTDh+TX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZilPFhaGyvWd26zfjdMRm07odU/HTuPEC9LoCvNF4tzlmMd3fGj9z9w9xQNZ+XGTGdnji1Jo6sXTmPyWg3TsJT3mMUGyVNwfEmzgK2nK6XEgwuhJyWPVasq/EG6lfvCoqTN2ghVF27rEezflGC1m0yFq0I3OiZb4MQSwoozhPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q2T3FS+p; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q2T3FS+p"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso16674700a12.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473261; x=1778078061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysP9AGtPxCAbfR+Tj7mfuITrZ+N0ZILV2wyZ0Jzr9sk=;
        b=Q2T3FS+pNznYI2mAKhOMxhCmLzbjwKMg1tjPVGpb3tsUzCYxvefV9zEcqk48e8CLDr
         56PbeUTFb8lpvHfSgWQOvrssDg0HJM9ogT3QS11oxs/CR29HpPltth6GVZmvbi6TSMM4
         p4SbiHLiir/FdvwJgfwu6OBa2oGbzvV3YPhpo9NC6gXUUrIyCBZ566WWpLRo+E1tqiCY
         9yXsZT9zDqeUq6QWRhu+hMP7GJ+/wvSemDNnQrAcUXHiO4lMTmkh0Z/BYqy49KUJIPw+
         6URLKbBPdtM7gvy5WWHFdWoDjVIxNMOQoDrDkCt11LXw9Ppu0loT859c3e/gsZ/lcSKm
         X+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473261; x=1778078061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ysP9AGtPxCAbfR+Tj7mfuITrZ+N0ZILV2wyZ0Jzr9sk=;
        b=G6k7F+yFgy5ykAl6G5sr/5v0UhPAQ02sL8x8w2/lcm5SgXWWbldwQni3ImsEkFNlzw
         WUdIDrROfOGg0/TUWuaHjnZM+8C0SPm0wjKWrULw3dr3RfA3QkSRlfEFeMkruk6ITCCD
         4mcF0xRXzWBfIup2//CR76kMvT6ecNcI0p02IZnTWLpXwzReLi3100V03uKHRsdiiR4a
         Sj5j7A24MoJnECwtQOFeHk/vKymDf4X+ZcV+3JWKbc5KbtMCs1Dmn3CMuDWQNYJ2VnIs
         H7EKz8nsVnvvremVDYxofmIN1xmuIHsb2n+NzqNlMXiRZAnH4AtP32A1+Sh5Dg65yKC4
         6m6g==
X-Gm-Message-State: AOJu0YzUCuzL/PuHuvEfQkviX4o2p42svNZ0VYFFKtXfa6q1Ntpa4IBW
	Sy/ZYXIJYtReopP113YscK3mZ9GClKRb+euQa/3Hw4bchKzQeyCb9mvnfC8CK9BzQwc=
X-Gm-Gg: AeBDieuyZsQubJm+Zj0WWo3fIWJfGr+CAnGF9yJ/aYT2jIzSzBUugFI2R7ETtIOum5x
	2rg2ETjp94Tbt8mUDqM7inyuekOO+ymHWRRbXCZS3LAY37fpWtbwPxTql9QL2YVWp5Vy8gBZd4t
	e0/yXWHa7qhJKOhyvSvC1mWNJIlsRA84BHkbrBOeku7FAe/wr2BMhfMjg5ruwkRvkq+KicH9kUr
	yhI2EDsGQrsXhSidUKjfXIV6BJ9MMmSbCFEbvodQB9MiV2RB36s+6M8AA8VnNegP5UcAp7batOD
	XM1pSWmD3YKdD8QN4jT8QlITBK0SSNuca6G5pAETb37byJz0R+T5bRjU6KfDbVXPtxATNK9oGQr
	e3i/yhliHzaPSwI9z0yFhLJXYjVGMxElLucdwcq0lFFWzrS5Br2ziyEH5niXiaArfQA8WrDqb+f
	NasPNgltlvuueU0dUNVbVfE3cY
X-Received: by 2002:a17:907:c50e:b0:b97:c719:14d4 with SMTP id a640c23a62f3a-bb93e64c44dmr268755366b.29.1777473260782;
        Wed, 29 Apr 2026 07:34:20 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6d87e40sm1209035e0c.12.2026.04.29.07.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:34:19 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 29 Apr 2026 11:33:47 -0300
Subject: [PATCH bpf-next v9 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-selftests-bpf_misconfig-v9-5-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=2402;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=aqXG984YlUxMtsZ+i7vquyVJaGX8IceA6DEnTDh+TX4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFgbYQ184IounnbSc2yS5rRTZVxJcGqh/hXS3g0Je6tNmN/jnaYCgSWS4Hbx4AaGX+s1ErFeyEs
 tZWsUuJcpdAo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

The .test.d dependency files are generated by the C preprocessor and list
the headers each test file actually #includes. Skeleton headers appear in
those generated lists, so the .test.o -> .skel.h dependency is already
tracked by the .d file content.

Making skeletons order-only prerequisites of .test.d means that a missing
or skipped skeleton does not prevent .test.d generation, and regenerating a
skeleton does not force .test.d to be recreated. This avoids unnecessary
recompilation and, more importantly, avoids build errors when a skeleton
was intentionally skipped due to a BPF compilation failure.

$$(BPFOBJ) is intentionally kept as a normal prerequisite: a libbpf
rebuild legitimately invalidates .test.d, since libbpf header changes
can affect the headers .test.o sees. Only the skeleton headers are
moved to order-only.

Note that adding a new BPF skeleton via a modified existing local header
still works correctly: GNU make builds order-only prerequisites that do
not exist (the order-only qualifier only suppresses timestamp-driven
rebuilds, not existence-driven builds), so a brand-new .skel.h listed in
TRUNNER_BPF_SKELS is generated even when .test.d is otherwise up to date.
The modified local header invalidates .test.o through the previously
included .d content, forcing a recompile that regenerates .test.d with
the new .skel.h dependency captured by gcc -MMD.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9a4d8bea0c18..608e6dff0392 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\
 			    $(TRUNNER_EXTRA_HDRS)			\
+			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
 			    $(TRUNNER_BPF_SKELS)			\
 			    $(TRUNNER_BPF_LSKELS)			\
 			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
-			    $(TRUNNER_BPF_SKELS_LINKED)			\
-			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+			    $(TRUNNER_BPF_SKELS_LINKED)
 
 ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))

-- 
2.54.0

