Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244392;
	b=NpUoIK0DUkKyvXIIutuf8ieEYgAGJ2Xe15qFjZnEWMBz0sEMSIUHuWqLvyktR/ZU+orV
	 CaSH8M+Qw9vzrtPklf1qYZEqacYLBXy5aVL7qVwKJkbzKr3P4uhFSwkX6XkBwNE3ym5/F
	 ywvjGIKC2Ghd5TCBBqEx04SJ6ZDDU3q+NkbI5S6B+tEwYz/DMzQtdPuZAM3EBKn83WFHB
	 /rWxOgZns/oBfuNTonMm31WY6dCN/Vahl69lJoitFpc3Po90LXTNAGOH0nO/fMZ9lgQvB
	 0F881j06tzKGlM+DOtsnQYWbvVb+kGKUGjxWYvqcF8N0TLBr8nUyMv/9geYQVLu7FNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fGAdvKbnnDNvC7VTESnuJjeTLcD1XbFE2xtDIUZCto4=;
	b=HjNpMn/b4A6MMjN4f2Fyd133+TKUg7b4KuaeS+z3/dx6wHyqcB2/CQHanQbQuqevDu+f
	 L+4EiL6/ItpBVJaBFmu3162gmYLsEhoRjGaRVaj8Im5P8FNhOk8s09NE/RG5xjiyPqUYg
	 9DcXxcvExI3uryyLl3Rv+1G1WO9z96CDvETrrJAch7bM+PcdibXYXRUX/sj9QcFKGS/LU
	 /yEpBnJAn7N7azJsshbW5mkV4eI9JE194Am7hLG7ez386ftROGrtfURFtBad8leXMWL0w
	 2oBUQp8z/K6uZdJvO2aFd3qpamEBi7xuCo7xLUbOI7qute1S5saHptSJyYrwNAwqCAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=INpYishy;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14C606A684
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 06:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE14C606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=INpYishy
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a71dd190b0so4907863c88.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244391; x=1795849191; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGAdvKbnnDNvC7VTESnuJjeTLcD1XbFE2xtDIUZCto4=;
        b=INpYishyBjqzCHtPkLUzALLHXaqZglbxaIt1wiWcwva416LFtcMHBPD2+cGMjFnwo5
         tlhv7jPuRv22yW66JdlmNOITf5OD2JCpqy1Yfz+dOkJSUBiEVaknErML0ozRZnojN9BD
         YAbCoPAOCh4MQ47VZKnT+f6uJxo7wgXDfoceg11V3QX52PYw1uNuyvbcfRYgUjL4a1n6
         AxmjgAeAZr6J4/gg3wc8pbud+J1ULoTNT+Cdo69+3xpe1nlsmJrWxZ6UAzZMPcDRFMqV
         Yiq35+1wY9gL7VKZnda839ti7EbYrTd6CZQP0rBH5NQH3DHUAohPdTSHd15uoQX7vEjG
         PoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244391; x=1795849191;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGAdvKbnnDNvC7VTESnuJjeTLcD1XbFE2xtDIUZCto4=;
        b=q+oPYmbf0PGQLGeWikMTtaBjwTFnDub+frU1Fg0x8lqOX7MgXxlAuqSgcDnxisDB7w
         z1U4Wjodfk6dtqCbfT+u9Cb5L4bqVPnzHjidzd+75PGDOYPhqwz4hSLNNWtCud183UDa
         Wnt2d8PlXPF3N6rtuvSn2tnftONAi9RkwE1DXmmasl6jNtoDc2EpcTiUHU3hm40C4UxD
         8ZbpZJz+mCQoQ5Vkd6tQa7Gf3ZfTcfDe+Jr/yUB453Ub02FCFFAnMOkYD3jZxHpPo67W
         ppPljIlCf8DE51V3JyEj9mGrAudJfV47IJwKm53c39eiJQH3K0Ay0eUIDAR4Y5ZttAMx
         Ioow==
X-Forwarded-Encrypted: i=1; AL+hErHcNBKpB51g+b3JMml7HE7vAfoBm+d1JH6l23hJcNmp5apHV2aWSglGh7lSfXeLhMKCPjs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zrjZP8ctoUff9K5+df01SyKJ900d2AePHH6LVC2ESvCKFUYkV
	yRbkfZK01yMZcVtc4Y3YGMHoIW0HJdWKsuaALeN5jgyOqcuTeujtAVb4Ih+U/5Wp/yynnF1PIJb
	MmsB+WyGEXQ==
X-Received: from dloo27-n1.prod.google.com ([2002:a05:7023:a5b:10b0:1b2:48fb:f4d0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2608:b0:1b5:342a:e4f0
 with SMTP id a92af1059eb24-1b5568b678fmr7282977c88.6.1795244390557; Fri, 20
 Nov 2026 22:59:50 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:12 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-24-irogers@google.com>
Subject: [PATCH v15 23/23] perf machine: Add __guarded_by annotation to machines->guests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate guests in struct machines with __guarded_by(&lock) and mark
machines__init() with __context_unsafe().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 1 +
 tools/perf/util/machine.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cc593d5372a..70870baa157e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -234,6 +234,7 @@ void machine__delete(struct machine *machine)
 }
 
 int machines__init(struct machines *machines, struct perf_session *session)
+	__context_unsafe(/* initialization */)
 {
 	int err = machine__init(&machines->host, "", HOST_KERNEL_ID);
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 80191545ee8a..67d517742fb6 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -3,6 +3,7 @@
 #define __PERF_MACHINE_H
 
 #include <sys/types.h>
+#include <linux/compiler-context-analysis.h>
 #include <linux/rbtree.h>
 #include "maps.h"
 #include "dsos.h"
@@ -153,7 +154,7 @@ struct machines {
 	struct perf_session *session;
 	struct rw_semaphore lock;
 	struct machine host;
-	struct rb_root_cached guests;
+	struct rb_root_cached guests __guarded_by(&lock);
 };
 
 int machines__init(struct machines *machines, struct perf_session *session);
-- 
2.56.1.750.gf70dc682cf-goog

