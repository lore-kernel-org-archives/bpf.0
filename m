Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE317C8B
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712376561; cv=none; b=FbLG6BMDNb1MXlioRD3l0GrcQgASCY+WinK5325uDgENf/SB9tggcreGDMwDlb55h9ss9sHX1c5VgCLKwkXkEe0b5DeaHKaP/wgj7X/Y+7YR4AFV/bLoL6HP7K0nh4yX9nCfAxlqyiUZnWQaO3SVcarjIn7LJIs1QbPBqymJ464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712376561; c=relaxed/simple;
	bh=ryhaCjT8y83e6nm9rSvWXbKLjBmeKFK9uS2+aXyQEW0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=AsVaHit6hpfOQ2jo+UMreore3LPeOYdDripXU2B2sNXLw9gSF3nC/IwcUkH+0Zb3XNOaKHNz7Za+K6CuK1D7uZOgxNv3yUDJXqv/ThsnaxKyFltB2QIxWKsh51Q1wyJMK1S3DeY0X+oR9Gjvl/PWDraqnTI5O5dtL/rfBUAHR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zBk0Xr7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zBk0Xr7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2386e932so52655767b3.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 21:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712376558; x=1712981358; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNu7c9amoaI33ZXVqjycoBCCoj/nNGvrPWP0zIU3JJE=;
        b=3zBk0Xr7z/O6DQ7wPX07f9FomFCdMKYk+5o37Ytw0tYuIrpnIAtC3TjJcAycYEYmK4
         8rjVaH7lXIa6Xel7D2it7fad1mWR2UbUMNUlrlnkDSKMdqSYcBd4L526I1caImigrENJ
         wokRdsmVG2KuNTgb2kCSu8BM8XixsY9/VFaRf3muRRqr7Vh4XfurriIDhyHh1o3zXQOC
         NSQoUYtzDiPlA34Dzn4WXbxpQET1AuD/caeXMd+cXp1s2hv07GrVSUjIGWmeHo0afjDw
         Ew0c1EaU0addIEkgbwFjvlTBsaGUs2LRloTptPy1TIrjT6Ta/hTKYvmWOk2UBNu3B5lD
         smFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712376558; x=1712981358;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNu7c9amoaI33ZXVqjycoBCCoj/nNGvrPWP0zIU3JJE=;
        b=IsHI7NiPadGeP9hyBDEpAWEvhyyhE1gERyDhSarw2o5nLp0B0Tm+mXOKoKD51f0mtr
         XW/EvvsqaHD84Ldu7XtB80wzxl1Z37o7O/17KX5MBLxiUHWkpKlj7n/TgKWc2Nsk/6LH
         xTCWhMl/wxYpTDPz4Elq+VuKOVtXQ8NzG9mc5CITGSF6k4++o3Rytw1yWuvsjCnMi0di
         wFDt+aACFqxNX2JdEiUpZNaAHVclApMbSoFeA8TILG6Q4upQnztWVJNCtK1LvuAy9jgu
         XJRQVJxd+Je81X+5DSKPCKkTPRRjUM5gOz2BEo6NTto59wOYPzI/3KFHt4koDU+9eabX
         rqjg==
X-Forwarded-Encrypted: i=1; AJvYcCXRe7fqT0kuWdETHKI4CLtduECpyaulep6jr0ISmwKMxx2tbl/MW7fFaw9hNYxIulcWHc1J+0h833C65eCCLqEc0R1+
X-Gm-Message-State: AOJu0Yzli/IFcDUOYONRPMpt4tr1sGF+ZPuOY36Yb9GqQXYDbVJ2cTfH
	y50wnLXKZWwKxIvv8CQNA/oLOYedTEhgHf4j2tOo2J/dzjianXPZqE5a3cMVcmapOKxpdnjGO3W
	JeQHFvA==
X-Google-Smtp-Source: AGHT+IH7IGd2BpRVCyTAOvsnf3SjaXVdsGIlIFz5FXVc55i7Tlr9PCarJ5xLRb9aFCQWhPs6faG7upJWWRWK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51c1:e2b:9198:3cdc])
 (user=irogers job=sendgmr) by 2002:a0d:ca88:0:b0:614:ff0d:2c7b with SMTP id
 m130-20020a0dca88000000b00614ff0d2c7bmr806437ywd.10.1712376558227; Fri, 05
 Apr 2024 21:09:18 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:09:10 -0700
Message-Id: <20240406040911.1603801-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 1/2] perf bench uprobe: Remove lib64 from libc.so.6 binary path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kees Cook <keescook@chromium.org>, 
	Andrei Vagin <avagin@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_program__attach_uprobe_opts will search LD_LIBRARY_PATH and so
specifying `/lib64` is unnecessary and causes failures for libc.so.6
paths like `/lib/x86_64-linux-gnu/libc.so.6`.

Fixes: 7b47623b8cae ("perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 5c71fdc419dd..b722ff88fe7d 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -47,7 +47,7 @@ static const char * const bench_uprobe_usage[] = {
 #define bench_uprobe__attach_uprobe(prog) \
 	skel->links.prog = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.prog, \
 							   /*pid=*/-1, \
-							   /*binary_path=*/"/lib64/libc.so.6", \
+							   /*binary_path=*/"libc.so.6", \
 							   /*func_offset=*/0, \
 							   /*opts=*/&uprobe_opts); \
 	if (!skel->links.prog) { \
-- 
2.44.0.478.gd926399ef9-goog

