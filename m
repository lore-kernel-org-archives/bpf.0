Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20513EA959
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405433; cv=none; b=DqSG7/W/rlQb/eqdzIXSSFvdZ1dwxg8CiK3Pobh4PoLDIdLTSDYT6fGKiAYxxCvIc4WI1lnBzj2VUYo8nN0fhqN+utyhVHIo9bgPKnP2bcy99dF1nKZt9VGhxH7psKHB5MZNyogCbyvAEKHN0n5XwP0zydKl6bw5eakinbAYWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405433; c=relaxed/simple;
	bh=WDLnHiZPtsQn+nJrqLJZCP+unVavs2qfj0Icse9NGF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNsEZGS3YTpg43a7Avj5HQoXOGkSoQlqy7U197PhJO1I+rul0aq84lJdw/8C+XVtITyWQLHyEUsAWO0LrYmjq/89Rtsb9ojx/apMYDR9gx4y+gAsSAv+eSbsLvsijwqM2nL5dY+aT919wCRmu7SWXXg1dcuMiD7NhD+Wxqls0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K47k+/M5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K47k+/M5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec429c2bb1so352929766b.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780405429; x=1781010229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RALhkDAmVWzUkKWUeiSZlbMaX2cF2Z8Q6irmSkI6Xu0=;
        b=K47k+/M5Mnt81D1NBeHmlHjKLBcVWDW+b4FQVxLXtZ3yFD7R5jV+MmSQC+0gaeHnPo
         TUbU8eSwLkLdY7KtOFqTYkpHrxA69aNxegxHJxpzvg4WfwZYiCKL+sL5C5nOp/ld4PIO
         atrzYWTZWhnUZLXPpsgRsId8JA7Ia0qe+g2dKr5UNgcLQ/CIV7poluwxYPpAfpMmGSdF
         SM6COPql3NG7zYs2s1/7NGu8ZK3bVKv1BB8VV5hwzwIlV1lHamyj+C7UARN8z+vTbJA4
         XMMy33bPLK/UwU+fahHee3VXcWeP0nB1DysACafj9rRnTmckoM0ice3T02fqOHJQRd66
         wdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405429; x=1781010229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RALhkDAmVWzUkKWUeiSZlbMaX2cF2Z8Q6irmSkI6Xu0=;
        b=n7HvHLoIN5/Xv9Z9O0lFljAA+s5gX6M2oqFx3entfxrywZryk8LP6LRzR7pH+rzCFe
         oV5a8Yzi72DVvu5s74jR2OJF5Ymku/JJXU0x9ObXoz9Opk+9LEmYzusvCuOd5XKi0tHP
         DeQJ+RDELkrb/HGM3AzoEzIAUabPv1Tt1VGue0DTfFenom/33nUqAMzw6rNngX1pE/ZC
         Z/b+GccXpshG0a7x/lyo/PvAPKSfFW14Qo/A6H5as7gDpVJ/xsX2D6RRlqz5jbmfadyu
         jFI2NGTQF17aPMoa1IqcJ8dxTOskUz88F8pK4r6T6kiIGkhZzmsOhi/TGCe6y/UZpEkW
         1nFw==
X-Gm-Message-State: AOJu0YzuUSGIjAIvmLkW7mbNTGaSCT6Ovjgc8jwUTlFtSVW0SfTrtC6S
	vYL4CpZyZQFyMhYoInzU9DMZj2O8VNRvscgWlWL1Bq4qeskKIox9ygvMopUDIegM57s=
X-Gm-Gg: Acq92OEFA6eONHB5Zb/MdBudAZpOowcz0CQWjJjvn5ABwlSOJaTjLuwg1L+OBQ4+y02
	aj5kATl+hfdJZhahNS2M5Yr30x21yIJiQZtHzAy3j2Q4QRDJx9iI7kBZsSa1yLnYA/Aqm/A3iwF
	Vv2bhKgiHGfJdDygghI5w4FHdxa0xZr1LdsXOJFQibgIv415vn06JThhwjfokWqMA6+GyfKGnA8
	kPlT0xL+ZfmSO79mqkPQat62+zXDjccJ6wD4S+MtgaMqlzqsfpGqwF8Hq65GKTTR14ObozrstRu
	aeHE8rYyYvMW9UtTUB5cYI8Y4d5JcgWvkv+MoH3a2ImkvhpTqcj6C6+sN95z28dfIR0jVgyTY9Q
	2mc8uZWcCsQgXdr5ugxIm0P6puLTt/GaWYELsD5ykND1hqdbB761xUTqGwTXi/erwSX5V7TFTSM
	+MMs+nTDR5nvMiP7S3fzDZTg==
X-Received: by 2002:a17:906:45a0:b0:bef:12f:346b with SMTP id a640c23a62f3a-bef012f3d62mr204216666b.15.1780405429527;
        Tue, 02 Jun 2026 06:03:49 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d2de5c60sm493403766b.16.2026.06.02.06.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:03:49 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 02 Jun 2026 10:02:58 -0300
Subject: [PATCH bpf-next RESEND v12 09/11] selftests/bpf: Tolerate
 benchmark build failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-selftests-bpf_misconfig-v12-9-27f898b3ba26@suse.com>
References: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1780405395; l=2182;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=WDLnHiZPtsQn+nJrqLJZCP+unVavs2qfj0Icse9NGF8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKMXfHUk1I1JTIi4GTbj16UrnRNnyc+KvHxKx4cxzf3g9RoKrr0SQ0O3kfcYEedas1BqOUIhlYq
 o/u4jLX9QRgs=
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
index bc845022a7ef..4eebc15670e3 100644
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
@@ -994,7 +995,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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

