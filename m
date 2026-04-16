Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E583E717B
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367899; cv=none; b=upUw4Subs4noDEm4Ssnedz6vgh48/Yg96d7CGHkzGDRbCE5FC5KmRRQjJoeAwJ0x/q7uXvM/+072W3znuzobnfHmVFZNbrHAHbt9oMqmcPHOjzT51dTzRfGHa5YgIpMh6gmG10KuIb7MBASwtXAjML/kd2zdDSy0J0KOnpO7e0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367899; c=relaxed/simple;
	bh=Wbv1yMwruHmacSBHbwCIcsHQsTrMRdd03crOI382Os4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ih/tT6F20S4ABv/bvQR/CvE7rC3NepKsV/vwQBJckWZASfX3Dz2ufngTniscSs0GLshGkTuN4VpJldXjIu2QtYvm/Xb7xLnM5CA+csVlZZQyBPs5H0uy7cft14y6efMjgJY1iSHBB0jGIMYBLJho+j7ceOmpeScxeAKC2h+Sp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RE6OqRCd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RE6OqRCd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso84678315e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776367893; x=1776972693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdtCy+qHzaxZ/moUnNmr75mhFuvrteH3MIYR4DgHu4I=;
        b=RE6OqRCdVl1Pk5+229p6vlOAmIV9JR6i8cY33QhCvSq73FBC4c5/qPD7EoyP81YnDf
         9z1q7D3RFgsXQFxylYtJMLk0MzR9Ye0C5wC6NVoWbsyrnjDm1a8i8TQNpGRsNllsF0nx
         JZ6rXLbw2mjpkoevhulURBR9mQdABIcR44l0nmOPrswJX4IqzMaxA1J1dW/teA9UQgVu
         KD0aLg13x7bZ7arHLEPEbbw6MgNyKgHjb5wgQzpvNxf4F9UjzpLmKHOZgs38gtB+XY3w
         5Ohp4wfblCMM8jcsEtHAeO/uaPm9d35B9jpXF9963L5qJPeQ/+PmA0vN71y5lc8UE7se
         daNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367893; x=1776972693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GdtCy+qHzaxZ/moUnNmr75mhFuvrteH3MIYR4DgHu4I=;
        b=oJaRRDYFnLv8UB5B1DLJCsKnJRJxaD0pca/F2wFpgOEfQJXYo98NHfkZu/aXejZT1Q
         b/UoXTjEiYWBOnCl+zHt9/bFGvVMnJ/Uof8In5dCeTz7/OIsSIVpz375wbmKq6W0Cr6u
         jFCSyYzZa3DWGn+N7xYEq+NIpX+nl71xOFkn5KrDbxcX4OF01frYbDsY0TReSzbAOtT+
         +5e+LpHUcPpKqn1em9SqYRFNmdPJCv5GwgunMyYIf76FEUOM65V99anyn0F4Ahj1Lq8k
         +zwy1TDUc2FU46NW94W7w1FE+mQI+KwHxBOb5EYzZyV0TIA54Dt8iK5EydJO7nFCaFPQ
         UbbQ==
X-Gm-Message-State: AOJu0Ywu7/vA3jUKuB/z/eAcv7HjGdytHaZRHrklcVoTyIL2sJ1h6RaW
	dbELdGRbl+Z0orduJcm+W42H88qGkCrSxyfH/hVFAKiojhKtos6RAIGaIbDOOfWvJck=
X-Gm-Gg: AeBDieukJowGLfwmaI0w5OpfG67+4PpBj4e78Nx1zoC5GFICNmfFnrlVGV7c0yLg5dc
	Q2iChSwI21H6t2G70Cj2ep/B1ZFjD4/I0RNtbs19yvzcZlhN8RN3+TOf8qYQ500H/gWNbBNIS1H
	NBOQxZbGWRlepNeMzFBXtulTfjMW7JnqY1xdvCjvM8u1hnfaLpLVB0z5El/rDzp5rN9FkREAn8h
	16mDPpcL72JO5kFVJdTZLEzWgEGq0vouyXWqRs6tHorhsAOoK+TNn9b4Cj0Jtdt36aLU7p6TH6P
	Uf/niAuD23BUPZQCX3jCdSCj7DyBuwcmJh+PGPU2hta8J4PgqC04bIeSg3tPy2KDc/pfW29mSB4
	3BvYg1z8/H6CO7/iC96AVO3Ex5xMxyPCfachpuVuT8w7sPYsQ92cYcBzkd9g67nFk9cpmPKmElu
	5nTyHrhhOIqnCk5N3M1YiYi2I=
X-Received: by 2002:a05:600c:a102:b0:485:3f1c:d8a1 with SMTP id 5b1f17b1804b1-488fb261c19mr2801625e9.9.1776367892836;
        Thu, 16 Apr 2026 12:31:32 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:dc8:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8fd54ef0sm8310644eec.29.2026.04.16.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:31 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 16:30:58 -0300
Subject: [PATCH bpf-next v7 09/11] selftests/bpf: Tolerate benchmark build
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v7-9-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
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
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776367852; l=2217;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=Wbv1yMwruHmacSBHbwCIcsHQsTrMRdd03crOI382Os4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHeNPEzKx87y0oH3xHNzsJmu0HlabrtVzf0mkexFuF6yDtm5/jAYzEmJqmpIdxxMvWiTU1LrjUD
 tvfGonaegRwc=
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
index a5597e8431a0..88a03366f6aa 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -896,7 +896,8 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
+		($(RM) $@; printf '  %-12s %s\n' 'SKIP-BENCH' '$(notdir $@)' 1>&2))
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
@@ -939,7 +940,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$(if $(PERMISSIVE),$(wildcard $^),$^)) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
+		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some benchmarks may have been skipped)' 1>&2))
 
 # This works around GCC warning about snprintf truncating strings like:
 #

-- 
2.53.0

