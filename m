Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811CF3B8D4A
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725595; cv=none; b=AL3vq1ziyaKmVNJBAvh0oOsFf7Jfp7yH7ZxPDomlRnklsXXMfpYxK5GG6s/OkIk3+OGdPFhP9/jPl3qpq6BH064SJV12LBNHV66jbTJ0rCwFeXNZVR8b31DY5xd3qC98ksssiz4nzWSkeTsGQJ/OMQhZRyCv8HdFlREx0GdUce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725595; c=relaxed/simple;
	bh=V13NjxcZ8Y+EH56zGxBFcHbqNp/dD0O+9buYDXRen/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyGMJsufD7jZq62U/LlhouuUmgHrgcE4c8RtEbj/2p6Iiiun7RY059G41NOerkQeG2/nkm5nhW2VxPnQ3fZineFAuSRpzxvb28aIYpA8X7MYU1s0pIFzf0TXQGO9ClhvSdDrg91FQ11WxkeRiK6X2+Q4Tc1xzSONVOcX25cMzwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+Oux/VC; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+Oux/VC"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66fc2844f0eso2743380d50.1
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725592; x=1789330392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8uHZ58VC3qmxtEe8gO2hHAyHIZcWIh7nanbyJ3N2VQ=;
        b=Q+Oux/VCRLBiFjHSPD9zk+ODhXkVu3xlGUOzwPZSg8cyCnuKlc5Pi17CgCkJ0PhzYh
         zNnrvnk5oZ4nIaQrn7kVJzMHS7LZCtTcBqbgKtphgdtAAAI2LhNksaMQsB+KI5Iv4yLU
         xstVsOIX6ssloYUwn/vOFcDNQEz5hcri/aJpvqVVvvPRo6KcW14O7wYNAfv6PBK1t67F
         UDlBjiNkCKWDCgLkjr7OasTTTnDTySgifVYzfOGFllBsCh/gCVO9MJy+Uro1tmv/3k4Z
         Tda7WmHfthD/vv7JRrVzLYOkCFrKcLuOp9tPSaVfffuLCSKelch6CQIPx7Rj6qfhzddH
         /DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725592; x=1789330392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8uHZ58VC3qmxtEe8gO2hHAyHIZcWIh7nanbyJ3N2VQ=;
        b=Iw2Fkjhcga+vzkIHPWMS9zqNu9NCkeAJnyY2hevONxZ4kuQqqkStLJNQJojz9qxkku
         ajRnzEq9rx02N22he6sporEoK9hKKkOMKyClsYzuYcVS7bwqGGliCOTnZ9uy+NohcRWc
         RIEgavlqLbXiQE+OYwhxo7YIMji0uVenQYlY+jOAl7UjiassAZdaSyZ1lpaqz0WCkYVk
         YXSuXQIver/7IhBqJAYDoz41yWlKgshGHgHE7cKHWVBuKtVaDBQ4stojAwoAlxGPQKYY
         gteG5w5mUN2WgvhEEWRKPk6uOFJBKiNehmtH7WSbnVUeTEYmHlDfY85HhqJ4VblJQRxe
         hvaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+9abTFAuu2SpKQKXFORgx/GadjQnOpCCK99EAkiuTpmQWA9zp6HlcoZ3xa7PlGzoA2FY=@vger.kernel.org
X-Gm-Message-State: AFuF++mNE/dqUiTTAdQ1G8vYdYoDqajsRjMuxEaTMqlwO2KXjQ9GxG7R
	L6KG0GoM2y+VpZdEPP7c/iz1f4lH816rqx7atrqLF3J7QRvP7vJ4Ntof
X-Gm-Gg: AYBFou3N0GOJEekTJH7KMK/LXs0SvDR0iHoMMeeD6mBeyyX8l8v1gw8j2Je+QKYg1/P
	wxLqBQ1E6pYVWZFhtQxI77BPbbVvJztuKLUKNFxE0JprPFpKm+VivxDqNckgQcNRoyiQkuUso4X
	6h68kyvS/+DUOOCNmWHVLhirklZHXMjecxuxbYdhae5b2x99YmxWhcldMZaEKKu12Ulo86GgCR8
	Q+h27QONL8gqisajb7uSzCduNFZBMB8hofMQD5zYhXhMoUUtnUu7+m6yIKwCrJ8mtbHOfzESYmh
	crjvHAJus2BunZJFwHA/1h7GkA+a+JrDos0FpE0KKNL7eUpJvm4bCtRoNp5p91Unc5z4PXnprof
	Cpx35C7hgQjiJ26mLDX3VcfB1y+w93BFTG0Eydq2nfi9vn+kxi3ZjW+TS5DlBq9ZWqAUH+ImBod
	V/vs6u4uGrFJ0h0k2YTjfJr8lF4Yyu8132jFGDQoggIehOCGqHrH4cOW+6Dsk1
X-Received: by 2002:a05:690c:31a:b0:80d:964f:88fd with SMTP id 00721157ae682-871221a70cbmr81582507b3.5.1788725592445;
        Sun, 06 Sep 2026 13:13:12 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714bb0efc1sm59661367b3.45.2026.09.06.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 13:13:11 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 16:13:07 -0400
Subject: [PATCH v7 2/3] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v7-2-1ece839fbca0@gmail.com>
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3810; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=V13NjxcZ8Y+EH56zGxBFcHbqNp/dD0O+9buYDXRen/c=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmngx8+f+Q6Pa3DOZ1dxaeNJeWfrzzeVrdCS3jJ7XHV
 yl1r/Vn6PjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhr5t5lZDi1Tf6edG
 HQv5T9jf+mBbBsNJ+4+cO0abknNycy+LZ/7PvB8E9xyqLPD+/vdrfYHeNxYynXJ85k28/X2EXf/
 Tq75+nb/ZWsAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf report --gtk dlopen()s libperf-gtk.so, which expects to resolve
symbols back against the running perf binary (callchain_param,
symbol_conf, evsel__name, and friends live in perf, not the plugin).
Two things broke that after the GTK 4 port:

perf never passed -rdynamic, so none of its symbols were in its
dynamic symbol table for a dlopen()ed plugin to find. Add -rdynamic to
LDFLAGS when GTK4 support is enabled.

annotated_source__hist_entry() was a static inline in annotate.h, so
ui/gtk/annotate.c calling it pulled hashmap__find()'s expansion,
hashmap_find(), into libperf-gtk.so as an undefined symbol. The only
hashmap_find perf links against normally is libbpf's internal one
(tools/lib/bpf/hashmap.c), built with -fvisibility=hidden, so it can
never be exported to a dlopen()ed plugin regardless of LDFLAGS. Move
annotated_source__hist_entry() into annotate.c as an ordinary exported
function, so the plugin depends on it the same way it already depends
on evsel__group_desc() and friends.

With both fixes, a default 'make GTK4=1' build (libbpf statically
linked) can dlopen() libperf-gtk.so and open the report browser without
NO_LIBBPF=1 or manual LDFLAGS. Verified with perf report --gtk against
real perf.data on a GTK4 desktop.

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

