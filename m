Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80638838B
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491921; cv=none; b=X+qCtVOb7hed3PJ6UgTBMg6MLfJ0arcNlKtJXJTbcx5iTT5KK5CCEn+25wo9cw1qXo6b2RK8OGkH0856QUK+w5RYJJjrL2cNPiMzm/LzCcNP8SFpXjCBJxey4qosq8wVfcz3Cmlo2mKdGYYPktzsf05ECB7/n3R2ATyKwLC91jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491921; c=relaxed/simple;
	bh=SxhjXuCfOoDBfzhpHd2FQo7WMYqlfNQJpvpfGE0Qcnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvc8OlmxpkkQvwPmkzjVSf/dGCTprs6OsR/AZY5/ZkLEwWvfXAS/qfh4RMyK1m+yAZ7C5C4P3Gy56KU3B8ZOihmX/bkeAM8LuKK9uBBxEbmW+HqPdHkhPT9MEKxxrJpbTFrVEFhaIVy5HBVDLSgpIM6sYlJmUzZ4tGTsUGS4bOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AqqIB/xV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AqqIB/xV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ba840146so1876715e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491918; x=1776096718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvVbJTt2G3f5MT1ZecImKaWgr21hR9oJpCuQYknRbaE=;
        b=AqqIB/xVV/+tl/ifggp7313YuHAocjmWlQmCEo54G8cMxxqGCca1cjIeOxTC2nzzpH
         XVlxLA/hXF9tma3WXOs6kcYQ2pYy/YsMnil9L1eZF7G8dNkDCw2ENs394sSTinjqZhDx
         Js+yPw5oDkjKJQp6HhOG7qGLrZyq9Y6odwqUMsZ9LP5hkGc4/c/BO4a4wKwDC/+oGgu6
         kvtYSkqu/Cap9/ynaS4VYJB34VAsiUcUWykDDXLIUWU8kYq00osVOLiZ8SJQmuCgc/z0
         7Z2+AulhbjdwdyqT7QnqQi4UQP6w1Y+6AOBp8JZc31c1tUTbQSCKeuWNFxbTM/4B3lFb
         IW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491918; x=1776096718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvVbJTt2G3f5MT1ZecImKaWgr21hR9oJpCuQYknRbaE=;
        b=jGkYmXnSg+YWfP+vWDWSyHSUO7cOSo/fSWE1CX6lVUpAjmSThwB90yi1QxsYz3hPgw
         JXnJlj7Jd93QpcgwBAAmr2ij668ZtbNThx+Paf0fK8OX2JPvljb2NNa30FrhwsLeB9jh
         p+qw1i17xdo32bW51fkFZOmORfKoSdQIoLcJrGFiyob3SeKsq0p5NljQN1rjVkgoaMhl
         qFw5SJKhv11YvmQyN1S0772Rr858gaco69+iYGQI9iXyEphuokAltEZ3MDasuc1vQ7p9
         w6sPg0OO55kXHim2ORUmVAN2OIA2YmJL38sumKThI3LBQ+dWJRvt9entmZYXl09Uaczr
         8icA==
X-Gm-Message-State: AOJu0Yz2MfCp0wuZ6PTEqiZUfQC+ZdnHRv+imoRyw9XLLEIqjycgHTUy
	1caUhcOnZpXdRzx96PEfxq+JJcEGEt10CPYgZ17m25YRgnkozUHR+3CiANEcTpdAvKIqZ4eU1p+
	gR0Wc
X-Gm-Gg: AeBDietI4jCCnajl+/Ff0bEcvWJT7kx4DGslHXGci7AoHaydnk5BL2fEyIL++vg5ZV9
	yuyOKgTuPta9rL0LDDgWAhRjmFgspOxl7UXADE8YHpwVlXbL2KE7lu6L2TSn1w9021BeALT9mvg
	rHRjPuLuCdTs+qkCxgIxgjNGp7S8OzCqVF29f9dL+dMjDO7hylOPrTO2upCvW2VTd6doZ8G+xRi
	mQkxl3K8CDYBx1d+oqZBa2xM4kmQI8ci8uPrYwd2Dnej82n0RX7gw3u8atCcDTm5v/tgdMcNsY+
	18gqTUj72psgmElYhbDZJNhH1BBRTIhfq0j/6lAdVlo6JU2QZTtP0acKF+CDUainJl1V3ERyvAK
	ProkeFSGt3trsDtahLW3u/zweeqsOOXEJTJfZWSgvhS5XpXyPxZf/pq6j2sy/6eDWFHfee6Quyb
	mo3/FJnTQsL6rgsRUvIOXZmgs=
X-Received: by 2002:a05:600c:8012:b0:486:f4d2:eac6 with SMTP id 5b1f17b1804b1-4889974a310mr198214275e9.13.1775491918502;
        Mon, 06 Apr 2026 09:11:58 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582b562bfsm17283320137.0.2026.04.06.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:11:57 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 13:11:30 -0300
Subject: [PATCH v3 08/11] selftests/bpf: Tolerate benchmark build failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v3-8-587a1114263c@suse.com>
References: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=1818;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=SxhjXuCfOoDBfzhpHd2FQo7WMYqlfNQJpvpfGE0Qcnk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMrhXQOPhVZEx57DEXWeTRhOLdCPBuBJxjffDgeT/GVPSwlxbq2FuHNs3JTsfnTU2Xw0l+8TPI3
 9coAEaN6I9AE=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Benchmark objects depend on skeletons that may be missing when some BPF
programs fail to build. In that case, benchmark object compilation or final
bench linking should not abort the full selftests/bpf build.

Keep both steps non-fatal, emit SKIP-BENCH or SKIP-LINK, and remove failed
outputs so stale objects or binaries are not reused by later incremental
builds.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index bfdae212037b..1e1da26153a2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -871,7 +871,8 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ || \
+		($(RM) $@; printf '  %-12s %s\n' 'SKIP-BENCH' '$(notdir $@)' 1>&2)
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
@@ -914,7 +915,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$(wildcard $^)) $(LDLIBS) -o $@ || \
+		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some benchmarks may have been skipped)' 1>&2)
 
 # This works around GCC warning about snprintf truncating strings like:
 #

-- 
2.53.0

