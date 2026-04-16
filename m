Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB33B8BB9
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342130; cv=none; b=RE82QER5Rhnn0H/IRdmB3XnIX4sCgueVu27ea+fqIM89qAPf60DpvkYwGZoGouuxAYvb2Mp7QRX90xjHgEYg2V2dsNROnRCvKOqJn9Zgen14OPVRsrecdAsVsXNbPwfJBxh6wF0ABwvkb802bpXl+c39vxfDf7o/WYS3cBcc/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342130; c=relaxed/simple;
	bh=oQ0Flhcav2dCZkm26xLB8SFWrrDDjyjtQCHU087O1gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFo7VjdqQWfW24M2DPhMOcouW72XpXx0oPXmx7/13EQvGzC/e0qtRcdA/bmca7++SuSg+zAfPbZ0wovdhj0zyDK5J3h23jZvltuA986/lKWCtWoF8hV1//UGDJz/GUX5eYepdvqx3HYYAnQGxrXkLkwnT4wjDFWrdTKHHqCSMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U1kD0HBn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U1kD0HBn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ad135063so76735835e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776342128; x=1776946928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EEdDDWfB1ZZ/NmsE/xkRqHhbnFjt08q4lL8Y16J7M4=;
        b=U1kD0HBnwNXTd2ILBet958Ae/VGeqJBmZj5j+2vZeEY1CiJ9MBhozCkYkz93meCyeu
         rkFPkTiHoSeb1oEXa98cF+PEjK7rKQ6DqUZ8DJzmFOxCmcQs/gp2lxq5xMfB2/cq5YHD
         kes3pxxYDOYMYMckik2xmO/rNeXwRnGErG/xyMSFxeq9ocwfzlTWjRSP0YdSUKfvsvGy
         o8T7J+oH7fwXeWzjc1nDtAYllj2Nu5cwnvm5iRn+jZB8FAv7D+XCEx1JnAl34fJ7g14z
         V6x6rZU5dkRDOoovTXiIYfEa0vfIUOkDdFs41DMGxG8/iMZx1qDnRTVKaytq1Xe0ZiAW
         r6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342128; x=1776946928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EEdDDWfB1ZZ/NmsE/xkRqHhbnFjt08q4lL8Y16J7M4=;
        b=WCkpfczXBhArUdGwT08dacoa9TOpp5+2GkyFa8orRF0E6YSssKeya0xDF0LbgXs92t
         EvApeIqbcp0taySAdKSJvVpUgX9uJ5Yyzpf66DmK1ZSlWWWbWS0ZBWwZciWHSTEgAwIe
         8/SQCc+PjixpKtywh9DAQIe24ondp5OolmUQe2HMJXV/tnc6Mh5WdCT2DrVf97GyY8g0
         VQL5MIxPfTpok+YK56rfKqg8Y4u0nsZ/v+ZQYMUoSqhTVtGpcn85cX9hMH/HJi/6E+qQ
         PgrcQlw1ym3puOyLR+jI1rY1XCDXyYE1xI0dEFO/LBRGsrSp/98X95AMjOSsFAAOKaN9
         c4mw==
X-Gm-Message-State: AOJu0YyiHw2CIF4nyXRwvXtyjZVCbVGlKCPJrNiiDn/SanZxNBxEDmEZ
	rpUr+Sfa13W/ooWIeoLpoBLBifwW5T210Ukpntz5+/htqfLmtZKHywb+2UxYrGVQrKrGancWWpl
	+ltIUtEs=
X-Gm-Gg: AeBDieuJ8jLCa77SIZA8CC2D/ObcCSGunQ3IxE11KGb8wJtZ+1VJ0seGDQxuugV2Em8
	AC+fpqFSfPycirVY/seuoDJKbmXiZwsYYkYAj+vCPBUHKzYqXM4qoVQRq9fh9e6ODY5zUqAtVmd
	nT0ioW6KL2v97rdJUN1+8kbhyh7URqDxCqh6ED/h5E8wcgomXs3XISAGAQem03xZ6LPXWU0PQ8n
	VmwuqDB8zbHfU9A1y2a1o7fuhTwXylKcnIMl1VqqVZpIXPawtGVQY9KjrantIa2zgXujhDuKftc
	kL1LQxaRyMocaJg7oFqWnhVPCKQVtOr4kIgpMQAmi/gHWUWCGZEuPGCbH/tiQiB+k/mnO8BrdXw
	zOS8dKCIMm1EzX/cQfNVrQREGP7t65Hyx9pp+oFH+n60jdXcmkmBjXR3eUI2ASX7KgkOrce7EBc
	r1D/c96s4idIo=
X-Received: by 2002:a05:600c:c0da:b0:488:b043:5efd with SMTP id 5b1f17b1804b1-488d682628dmr311205855e9.13.1776342127847;
        Thu, 16 Apr 2026 05:22:07 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6b6a05sm6438257c88.14.2026.04.16.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:22:06 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 09:21:26 -0300
Subject: [PATCH bpf-next v6 09/11] selftests/bpf: Tolerate benchmark build
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v6-9-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776342088; l=2217;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=oQ0Flhcav2dCZkm26xLB8SFWrrDDjyjtQCHU087O1gY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAQh8rHa14rUl8QAExAeTdNkUq+kn+3xXOq28lt+IwmB78MBk/5dae80B6Z0oOTEG0t5I+rY3Mc
 kb/G+tEnwuAA=
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
index 79991dc98ddd..9e3e0a898e40 100644
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

