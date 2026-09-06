Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B83B27DC
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710811; cv=none; b=YWXRz3B4MMQQQVS/9IpDu9Be5Jv1sQ/xppfbrB44VA0o21n8gFbpDz6G94YkhjBYTjm2Ep3Nq/eMBZKRnOT+QTm5nWLW093bfDKZ+h9Is0WA0wpZxQBUO+xGJtLEuNdAd750ymet9W5xIo6yVKPzqnjKCveShPd0+KICbDYkH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710811; c=relaxed/simple;
	bh=8CvFHtfn4Ljqx5Fa6L2b6SNfX914djxML7DsfBsaOO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCDM6jWz+MNonhF26b3eFFynM1h/+u5zX8FYQWhe1sqJusG6fiLC+WPt/Zkr3wBRUCfByptp/2lrj6+0ErY49DHqlMBR6GfwyD8OiOkn5snYXS2/xmP6+Oi1BsmNw8PdQgI0yXfmkR8KO96EehhZJurJNwnR28mbsyoYalrLZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0UdnlA1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0UdnlA1"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-866e57f63a3so29104867b3.3
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788710808; x=1789315608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9O0Uei0AmYGxnrMfKSWfJBNUDOym4vtr5Ws3/LSEZc=;
        b=b0UdnlA1i7u62AydPIu0wrFzSJ7OQ1+MOC4b8vkYeQHj7QEuOQI4qjmNsOZskPCU8N
         4/J7362MkX3tAq3VhcIepPS3k505WQSp7ysUOcsUl9T/roFFpWFNb1Aeoik856h1NcHr
         yXcL6aC9f7x/PboOkIAIiWtdha2yOMxIUS0/PLjN7nsZLk+wj6X9qY6XuZy3JDVJNB8a
         iUldX89wE4teHR92KdtchdD6Unk9fv8XScEdOJ55bNrrOWLuqG6DmjCKrllbOABkLrA/
         +mSmEkYaUuMnp8jUtr5IMInv1Q6/hwvOsZo7yhXnKxGSmtERJbL7qgUoyvWaS0fUVyHT
         dHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788710808; x=1789315608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9O0Uei0AmYGxnrMfKSWfJBNUDOym4vtr5Ws3/LSEZc=;
        b=enOxz7f/VoftKkpEjPqkVhOlnvwj9H/hOnU57sC4+kFZ4ZclhYfABlu3hjxLYZk0mI
         JULZNwt30CkDCrMrgxD75RdIJIIGgrl/BlwNDcH4GzehzBRlojRBotRzF61UMZGxp4jW
         upN3RknnfGzOg8t6ZMUXo3dBHUKqZi20xT2PrE1D2brdxbeqRyI8+Vv7BiT85xd6Y6gF
         9eXi5U3BGS1ey2PqpmE4IuVzsTmBsuOm5ZMZb2FFQYccAKtd1UCelxG/6TwVWPVyqqQm
         fAgd+wXqLpR2PbIOIz392ltyuLZhmX7njGZRydDcYAZaIUY/EHb/jqjuBlrUMWVhCGn7
         Wxjw==
X-Forwarded-Encrypted: i=1; AKwUvBzsczkbHWk08TQ0xuCcHHfRHb9ENqkqyz2XfAP8mDRg1kp+pzFif4K3SCgmISPzg5+T3+A=@vger.kernel.org
X-Gm-Message-State: AFuF++nycwSZAd/PcqzgQgXvVMQvyYYrzcMrrWtuAM8V+u7wLfvo01Zq
	bOcEFnZQBj+1iwEe8qCRiKyeXmbToFwH2I+Z9103o3UIH5MaZCxW53H2
X-Gm-Gg: AYBFou1gvt2iWJ+47ZTT+UJQdmmwEm52uZSQNyoqRyWCHsIDRWcPQ+KNmLTjkPWREjx
	DaeG76ssxkPfykVDt1fSYRyct5nxjhxbFDoAnROgTjaV/pATI9QfunO66tOQKWA2qZt7YAQCwCu
	3MYoAB70z8oocddEkEZDTM/2uCN2HXrl8uIqbtstdh0+PumS7GBTETPrd/M4B4A/flq51xJGoKX
	5TJD3xv+O7bqtCjRIUvs9jcula+7nDrqES4WotupkTCt1pgOe8Fnaaifwtd3TOqRvU+Krbv7JGC
	eSLHx+FtAkXQmWHPxttO/3qsUzsFd2mAjlhhoJdXgIC+7p86bgIvGe85KJ7k+f6EU/uaTkZajyi
	zXVQc17rVjevCwMTh64ralVuuRmszBSifCB7dyLF5TNQJEOg7vBRCT4h8xkAKc/lq209nVFUVW5
	RIwZgzS//WgYbQD7BTDpKByZSPi7CnZkb8rgPuMVnL//GSS7KGfYFcqcDX8eMB
X-Received: by 2002:a05:690c:c6d0:b0:873:5ddf:d874 with SMTP id 00721157ae682-8735ddfda9emr27184317b3.63.1788710807793;
        Sun, 06 Sep 2026 09:06:47 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714c0e5c6fsm57754457b3.48.2026.09.06.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:06:46 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 12:06:43 -0400
Subject: [PATCH v3 2/2] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v3-2-e1f2086214a0@gmail.com>
References: <20260906-perf-gtk2-v3-0-e1f2086214a0@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v3-0-e1f2086214a0@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4031; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=8CvFHtfn4Ljqx5Fa6L2b6SNfX914djxML7DsfBsaOO4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm9k/yW8VW37RnaZlKRnHbITP5s2v2nnm7ql7eOethZ
 dhltutWHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNN7gJGhjsnLzlPyx
 Th/Pj/d/iZlcYmjDuKJc9M9Hwg82XxtntvH+Uz/LO91Ln8gHbGx1X9O/J9mXf901h+xpvby09g2
 vGm3Bf6lYwA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf report --gtk dlopen()s libperf-gtk.so and expects it to resolve
symbols back against the running perf binary (callchain_param,
symbol_conf, evsel__name, and friends all live in perf itself, not in
the plugin). Two things stood in the way of that after the GTK 2 to GTK
4 port:

perf never passed -rdynamic, so none of its own symbols were in its
dynamic symbol table for a dlopen()ed plugin to find at all. Add
-rdynamic to LDFLAGS when GTK4 support is enabled.

annotated_source__hist_entry() was a static inline in annotate.h, so
ui/gtk/annotate.c calling it pulled hashmap__find()'s expansion,
hashmap_find(), directly into libperf-gtk.so as an undefined symbol. The
only hashmap_find perf links against in the common case is libbpf's
internal one (tools/lib/bpf/hashmap.c), which libbpf compiles with
-fvisibility=hidden; a hidden symbol can never be exported to a
dlopen()ed plugin no matter what LDFLAGS perf itself gets. Move
annotated_source__hist_entry() out of the header and into annotate.c, as
an ordinary exported function, so the plugin depends on it the same way
it already depends on evsel__group_desc() and friends, instead of
reaching for hashmap_find directly.

With both fixes, a default 'make GTK4=1' build (libbpf statically
linked, as usual) can dlopen() libperf-gtk.so and open the report
browser without needing NO_LIBBPF=1 or manual LDFLAGS. Verified with
perf report --gtk against a real perf.data on an actual GTK4 desktop
session.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/Makefile.config |  5 +++++
 tools/perf/util/annotate.c | 11 +++++++++++
 tools/perf/util/annotate.h | 12 ++----------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3e59e2b7eaec..4ee7393a39f9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -785,6 +785,11 @@ ifdef GTK4
     GTK_CFLAGS += $(shell $(PKG_CONFIG) --cflags gtk4 2>/dev/null)
     GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk4 2>/dev/null)
     EXTLIBS += -ldl
+    # libperf-gtk.so is dlopen()ed at runtime and calls back into
+    # symbols defined in the perf binary itself (callchain_param,
+    # symbol_conf, evsel__name, ...): perf needs to export those
+    # dynamically for the plugin to resolve them.
+    LDFLAGS += -rdynamic
   endif
 endif
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index df70e95a8470..123b6d5fcea7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -145,6 +145,17 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	return src->histograms ? 0 : -1;
 }
 
+struct sym_hist_entry *
+annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset)
+{
+	struct sym_hist_entry *entry;
+	long key = offset << 16 | evsel->core.idx;
+
+	if (!hashmap__find(src->samples, key, &entry))
+		return NULL;
+	return entry;
+}
+
 void symbol__annotate_zero_histograms(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index fa08d09b80f7..40038a3779d4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -406,16 +406,8 @@ static inline struct sym_hist *annotation__histogram(struct annotation *notes,
 	return annotated_source__histogram(notes->src, evsel);
 }
 
-static inline struct sym_hist_entry *
-annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset)
-{
-	struct sym_hist_entry *entry;
-	long key = offset << 16 | evsel->core.idx;
-
-	if (!hashmap__find(src->samples, key, &entry))
-		return NULL;
-	return entry;
-}
+struct sym_hist_entry *
+annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset);
 
 static inline struct annotation *symbol__annotation(struct symbol *sym)
 {

-- 
2.54.0

