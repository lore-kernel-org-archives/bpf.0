Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87D40627B
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553638; cv=none; b=okp86hau7uRXUVtwegW3ZSh8MHG4yIAljcayRSfBPGfTXDn+u35za8lk/BhMgdP/sucB71K7CW2XvzuD+uqADakYn8cR/d/r7lxGNqwg1ZkLFcyYBYNxgnosu+WQGaodh8Aj5UqKCWqs/4ovWdbaVbvno0W+0RmxF6VEbAI/Bsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553638; c=relaxed/simple;
	bh=g1IPrukXdfTha1L81vMX7RIO9kNQy26KDYwIrzAmnCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8EZqUE3qXYStJnaOmksL/CwDH6UYTb69BQRywstbm1H82PV3s/tsOCpGm1c8Vrql2CPH+orWXGIm/+1+X6qThg1+uoS7XkvXvFyrVHvWkhnny+LFwqOnS9CGQd3ftEubc1xUZ1VzCT+yjmZz6jw00ax5uwO43V/Mje0F6xAN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KcdNUl+f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KcdNUl+f"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483487335c2so10102795e9.2
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777553633; x=1778158433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7/TuOwF2JlmKiSd4FRcLat+/O0pJJ7pZtNrVGAkImI=;
        b=KcdNUl+f2Kt0tBgXJ9PBZHSHesce+jTzIKB/buOfq92I+udLDukn5HP7XtLgvMOdpx
         1+l+NmNaFYrgOYkFRZuv4OpxC32lsQ+4a2uD22z1FbAIxvOIiQbq5eB5A7mO55dhRSkh
         sOILtZHIGleRAzGXNM94KxlvN9sJAWwdZUttM6eMZzAhHFYa2Td+n2r5g7Atq1Qi7iZ7
         8rWDygGoQLXcuhAhZQ+kdh8k115v1foLoEiXbyMxone95W01uEuXSpSt4p3sPtRleBW8
         AcQ6P3V23M5YOhVghEZQLreQfGUSjC3rZuZ2yCWoU82dGvy3bzPSrVS2y56Ey3Ke78lg
         TakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553633; x=1778158433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f7/TuOwF2JlmKiSd4FRcLat+/O0pJJ7pZtNrVGAkImI=;
        b=XR9MX1Nxn5lGz8NJU2HJVd2+J7CWJ44O8ZkcGnMX0dVMAPD9kRRnYjzW0WgvXgnf1W
         AtLE3E6f6HZSWQDb+b3mAcHrczwrU21FZvzwBU8ti7yABHNUULc2880m4BwZNsoWjVBG
         36F2vTLHYAvasnTQkG4Ude+l02NE36Fcki7EPeL5EMBSHk9Xk2qA5mbj1HTAyQy6+vIG
         iu5lpRqV9yL/5AygZf3/l5eckJXclWnt0YOmksx0M9HitZJshvoX9tLLyWSN38Cyz6Ei
         QnpVLAXZ6vdgjifmEZ02M1aGIUWyKfZvBSI0L22GXtSrkhDtVb5+6eFx6i4H3Y1OktMu
         n+QA==
X-Gm-Message-State: AOJu0Yza/swiYUQAWaFo8E+VMWnI69htAylex0c4UHb7xO+Ndc4AelyE
	LQ8TQ/FBF4ihrVZR9b3Kf66Fi+Fuog+sF8++P2ioVG+yvgqRoGoLsSFcfYSDVm7YzDs=
X-Gm-Gg: AeBDievTyjdBJdcnLEaOJbX3uADUyPCXkj+bGkih2XafLuSp5mmy4Igd1ghou1zXvo2
	3ekn2OPwwpu1fFyymQmT1TXffwH1CPlZbHDi0SJofPxjXNONjdfp5zISx9czZTXMcSNdFjBF8PH
	imvE5GilX8ZnQ+TZoIc07ZIHu5cW1knpmv2D2hbJqi06agpUsK3/QFsUrR3moQ8VsPuy7rjn+Rn
	hHNl3vxw2I/BZhcDouYDUi66FvkjYHMVqJZr6LedcRCWPrgMfBHSCgL19NmoVmWabPUvXYlzOI9
	UxCawpZvxxi9h0zm18i6T4fdURORgYYzRqnnJpLoqzAos761qBhTUYCSrdAaW/a4YRKpI7B2vGw
	XZg44zMbKCPwYoyUhWlFFYuf/YOsxNCpekqxdYoOmBZg/rC5dfMVNukEecmvNob2a5SNRctIn6e
	5dyORhg+T4wgaZAE4k88vRzaIz
X-Received: by 2002:a05:600c:a30b:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48a8451cfe2mr34518965e9.16.1777553632830;
        Thu, 30 Apr 2026 05:53:52 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c07058esm8543457eec.15.2026.04.30.05.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:53:51 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 09:53:21 -0300
Subject: [PATCH bpf-next v10 09/11] selftests/bpf: Tolerate benchmark build
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v10-9-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777553600; l=2182;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=g1IPrukXdfTha1L81vMX7RIO9kNQy26KDYwIrzAmnCQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFrprJLNfF/AMQtIohJ9qwKSRFoGc3sU5lSGc2K+fLOKPKd8TPdpoBYF716d7APQ1EEWkWctrAB
 bALNYv5AqLg0=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Benchmark objects depend on skeletons that may be missing when some BPF
programs fail to build. In that case, benchmark object compilation or final
bench linking should not abort the full selftests/bpf build.

Keep both steps non-fatal, emit SKIP-BENCH or SKIP-LINK, and remove failed
outputs so stale objects or binaries are not reused by later incremental
builds. Note that because bench.c statically references every benchmark via
extern symbols, partial linking is not possible: if any single benchmark
object fails, the entire bench binary is skipped. This is by design -- the
error handler catches all compilation failures including genuine ones, but
those are caught by full-config CI runs.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a64e822dc540..0559742137e3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -945,7 +945,8 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
+		($(RM) $@; printf '  %-12s %s\n' 'SKIP-BENCH' '$(notdir $@)' 1>&2))
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
@@ -988,7 +989,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
+		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some benchmarks may have been skipped)' 1>&2))
 
 # This works around GCC warning about snprintf truncating strings like:
 #

-- 
2.54.0

