Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5813947AF
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499768; cv=none; b=EvBi1fqQkxJGVxGglY7XwO/VhRAUm3hSlXYEiSfh/LmVB7A7XCIDZI6DzoTXxSMWn2HYZNaNuR5v/qYCb0ReaJC/EjXfrZPxqIT7y4ZCU0Do0z6x0Jyi4rAumKoPrb7kONAcGSUrW4UMIDd3bnSQ0Luw+8leHoZhqID61bh5L+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499768; c=relaxed/simple;
	bh=ucptwUIJtqhx8dsrJhSQ9C3w9ScuJ0w9Y+4aIdpjm+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLNt5VD5/Ha4SithWMe98IALWnVOBFvqIn2lZBg1ESZIQUteBYeBDDI9KCGNaDqHyyV1gk/nLP6MbVoXi3pICnjaTmkTp64wWN23G87V2ift9S396X7YsIpEp+iacwjf9Lr649mfulzffSbugiTqpPRzPy89wDKpWAgLzqZT2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cQpMFB0T; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cQpMFB0T"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso28087355e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775499762; x=1776104562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtaCX1T0hy3mWY06GsAlGBkN/yaFPOhiixn1CTjMhwc=;
        b=cQpMFB0TJaAYdE0Vuuouqw71yOWty9L79FfJlLrbrsEpDT5hp5epswGnBHphQHVZzE
         kfaCUlxYrasn2fVTr+E7CaFFc7TTItDA0n0lbWnraL4QUh6W36HIUg/SLx6A/bGWG6hg
         HCQFhzESdl9Oj6RnEgBWPhgxG+KbqKxM5syP00qvpkyNnGY0SSlF26VJV8HiFdV7fmKb
         4sw1vs1BolgFd3O/g4eXhd1qSrE9GhLKQOsyFeEa2wxDFfjDJK7ygYkOVB01tuoNzXzW
         wGH7fm0tXuYw4snRyGEQRzcFrBcUsF1/OPEq5y8W/emaq88hZMReZBUnVahnthC8FsEK
         usbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499762; x=1776104562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VtaCX1T0hy3mWY06GsAlGBkN/yaFPOhiixn1CTjMhwc=;
        b=Qny5SLHiqpLDqvGOPynl2ogWquo0havgVZ3xH0T9T7TX0wVhtU1Eim/K3+MEath3fl
         XoRriz3KC8wRiwukSsv4+KcaEXTN+61F3s/4yp6Iw1DUP2KaosNP1OsrjLzt8p581uMV
         hbdxe+dNmZ2/ACoGx1nv3sipJSrtfTZ8/vsfQvJZ7inSirMlBc3juB3e54eCdjjncvpV
         /dzeMjq1kzRB9+2sBXuAi6flKm3LAFAtaHy/ZlwLwT0jH4olJDI7PD86XwnFIogApPq7
         Y7dTb8RvOtU8gmUSZMZPnrI570GZQ1kSo+x2rAQCv72WktJ1haFOxCWD4GNcnRhnJAHO
         NLGQ==
X-Gm-Message-State: AOJu0YxGi0g1Xy1f1ckEqCzBrmzbH1HLtIgxAG4+zQG00hfUZrPw2W9K
	andU61mWyVryCwDI4bdQDF0KTaIo+sYVoyfgHgFRzH6UpU0xfu2shvD8O/NiFaNYcRU=
X-Gm-Gg: AeBDieuuU9x8rQu9Z9C3tHbd9vB7NeJvWUS3YlcGii1LNQJXb8i9A07qrWqL5XYYimE
	UGowPCi/Zoec49e+U94c3BeCoIspJZZ9f6rICi3Ex6eFhiSjDXzrEWl3rSWn+07Mcaq/6aXf/Uk
	f2xvPsNjAjqiWbVAFP+Fd31es3HKn6edZqG4992/t2aNEzEN1GMkhijfz/zZsUGR2KKEHDk7lSH
	ro6IGda4OHvN4t/13pQTATAIuZYR4zgi8z0KKFFC6OrcpAEUnRVJJQVJAQA0Q/KwjP54gmnQthY
	qV+zvCNOHSx6hGaYXKz8g164M59r1YQTQGHWg9PqsBOD+g2CW+XxF0QsnDG5P7aTA2zgzNvJMko
	F81mLcL66MCclokmQhYBZ8zuHELY3XPPEebmo9BA9egbiAzkpddH8Fv/Uie2ei/W96vR0gj4dh9
	7+ZlzT0Lvojq0m
X-Received: by 2002:a05:600c:c8d:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488997a6883mr187562235e9.23.1775499762028;
        Mon, 06 Apr 2026 11:22:42 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bd2106csm17014057e0c.18.2026.04.06.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:22:41 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 15:22:19 -0300
Subject: [PATCH v4 07/10] selftests/bpf: Tolerate benchmark build failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v4-7-9914f50efdf7@suse.com>
References: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775499736; l=1818;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=ucptwUIJtqhx8dsrJhSQ9C3w9ScuJ0w9Y+4aIdpjm+8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHRyc3p5anKKcI/W38lb5jswVJrWqewGR0lwA51VbpiHo5xK1mR7Q68dPAHEDbiBGKp3PiIOWQz
 8yGfmpM0cuwk=
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
index a12bc9d76f8e..2b0747604d5f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -875,7 +875,8 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@ || \
+		($(RM) $@; printf '  %-12s %s\n' 'SKIP-BENCH' '$(notdir $@)' 1>&2)
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
@@ -918,7 +919,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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

