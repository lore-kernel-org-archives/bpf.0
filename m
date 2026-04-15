Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A638E118
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286804; cv=none; b=IvbeGVuEQJ+yOMzEZHHk17PBn4FSQDMoy5pYz5u8HrezcElSJq9kG0jbf/OXV+7M+fTuO45a1DP7WM6KnauCvTJq1CRebyHDaftCs1teJs4lSm6LvZwNUFPbwB4kK9fSwLLJ4SKaQiOm0lO8hQXiuMnAzWp40+5kngL9X1YC/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286804; c=relaxed/simple;
	bh=XCKe1TjHfJlwSJAX4fuY9DLW2sOgBtAwMXzZhTx/5F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3RSJfyp+ynqg3WJX21+metIbt43Y1HheKXAg9F7yZtOzbpRpYxPCc1pZQVLTTuFdjCitJ3Lrsb3MXECAw7LPgz6XtMIX1VcHRCSkBrYKa37/eg2lgsg42oZV8CSllDfrKgd+KfiNpekBlIOvJU27/oHG2MjgpZpD5g3zsU8BQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ECY9UoUj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ECY9UoUj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso86216165e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286799; x=1776891599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtePe4tVB1ppaoNVFmbhZuXMDT7E+RF+3Sc+9onPhUc=;
        b=ECY9UoUjSbklVFUpImxTqN5Y9k9yqBCaMPKuv4QeR+9KYHB5HBgLFbkfmzlznCh0VM
         LsK52Pa6PEjzbINNwpHe5ONhUlvXky85o/GCmFgRRDcNDKWILDYSPZ8v4DFO6Zycvv31
         DFEWbCklXpqQlntixEWer3P8MnIv4n8oaHBrn0EOn5z4T3EDslCVVpLq5iOYdLEYUSqB
         UgBPUqPXrIULVFA8FbuzBlz01lhbSSFVWE4XGd7cGS5F2Zgf/nHxcRtHQ9s6XGliIkoK
         5nLaT3x2nhTJormhXgKSc7wxPjopBe6SlJzJ5S26zFIYbPpaN6CWYpAQk3hssPIdr5e8
         6Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286799; x=1776891599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DtePe4tVB1ppaoNVFmbhZuXMDT7E+RF+3Sc+9onPhUc=;
        b=hdpBKT96mbqHtF5WuXUKasxKKXXxeAizDx6v5Xs1cMHvMn9ZE0AASH3BehfpcC3RPy
         ujTw31s1xz3M+o3P2t63dKIJvEq3PY8ZSg3IPRVDkmnA5b2q5zpooMUXUIgsDC7XSlWO
         TXQwJsA1QdIpbyt+mkaNDbZfC4vdqwc+wIwDkvfb6T5ZUnVTG3nGR2fGfY9FdTqikikn
         7jhe7hJzod2C7GkjkRkEQBnslTo/c8A27QJuutA76wrl0L/+tnhsbxUM7M9mcfvXRqZe
         /TP1tLpZKzBZtp5W0tXrKVM52Bl+TEkRsrxdM6uNpKYRXhMwkkFLeOi9WReLO3wyPXIm
         mRnQ==
X-Gm-Message-State: AOJu0YybX1kpxhn0+N9WiNP29ZFo9Atf2mMu3j9Paf9gbNBMLjvPQv/j
	kOlZRBxC1O2pfGh10h85s5cg7lpjq7QV7h5I+58Oh2xapt1GI+i8SZYaAUYvemvH+I8=
X-Gm-Gg: AeBDietaYZd7xYcZVzDDqQPHNdEVkzx/bkandF56CVt/QqhOBef95JgAWN6MN5/vDmY
	c1DnNE7L9nRJZ7pyh34YK+IRsYkXFMiuVQtcaX3mzC+SVF7NljTrYKDif5qTfcl8GetNgVEq3t2
	o0/mu67zyOBplje0TzqIUkaD2gL2gHnhrrGpv14sv3ebCFc4lUCHDOcpjNu68UtIZMSS6Owph2U
	v8YKootPX3uKPpkyC6yLfYpjxb1rEBgajg+VHvJ95eHgEQcK9ZTQUVt8qhg/BPMZZX3hGu39X2z
	fkRo1D0KF0lr828qG38N0APt1fcQWxBZIMUgImb5IzKpXeQzMUaySswV8pQI6YtoiuzVmNTWafb
	xJYWTrgWsFG3oYRrS2q1BJlxO2p/JLlY+IaHrJPFEoezVO5FM8HyBZ8KNDXGFICdN6higxNSNtD
	/ef5TzR/r2SeU=
X-Received: by 2002:a05:600c:c0da:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-488d685c12dmr272771665e9.19.1776286799559;
        Wed, 15 Apr 2026 13:59:59 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6b5627sm3423734c88.13.2026.04.15.13.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:59:58 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 15 Apr 2026 17:59:26 -0300
Subject: [PATCH bpf-next v5 08/11] selftests/bpf: Tolerate benchmark build
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-selftests-bpf_misconfig-v5-8-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776286765; l=2217;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=XCKe1TjHfJlwSJAX4fuY9DLW2sOgBtAwMXzZhTx/5F4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGIQ/GwDhPKHV+R8rebF8BWOcRFMS81S8508Z9JJXDlNZw35XGIdfstY8zicLVz7LEf5figjWEE
 JMfBs4EJgvAI=
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
index 128ea61fd986..163552458327 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -891,7 +891,8 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ $(if $(PERMISSIVE),|| \
+		($(RM) $@; printf '  %-12s %s\n' 'SKIP-BENCH' '$(notdir $@)' 1>&2))
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
@@ -934,7 +935,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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

