Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7913C1966
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719220; cv=none; b=q9oYGwDDxZvFZNXTAPTz+3l9ujPJxwYtLFMEsG9lzW9/L7GjcGN/wNnF6YdK793fcdHPuQmMpj+XOUZpbVurgzqwXBqgtA6Z8oPQuODkuK1e+2n+8p0VIoH91W6tQNIgoHz1PzICAjH45Bws/0re+d0yxc8P0ID9Z8uW8kWiTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719220; c=relaxed/simple;
	bh=8CvFHtfn4Ljqx5Fa6L2b6SNfX914djxML7DsfBsaOO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pf/sRO72ksnYF6GtG3sAG1/lJhqpq+DNRsGO/FtkOtiuAmrLMTyVg6U5HOOwFadleT3fEQqklee4uYN8E6KAzdfeyVA59csggdpjLZ/YyUUk+s1WKP7sQ5cy98TOKkJfrtMrzMEzYf6AFLv9D1f5ovnhiIpTeVyn/d3QaYubDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPt7XD1Y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPt7XD1Y"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-866e57f63a3so29777477b3.3
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788719218; x=1789324018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9O0Uei0AmYGxnrMfKSWfJBNUDOym4vtr5Ws3/LSEZc=;
        b=TPt7XD1Y0GpOyoWvWKiKN/BoX2CpFJOgA6TaXiuHoW6K2LDxlu/8/E/e74JCOhdxj/
         K1nD/c5mDI16i4pJy5jzcRk0CsywQ/62cqLU+/Hj7Xcnv6+UbQNBZoKLbvuSY6H6Zp3c
         JDeaJ/TwxDDAgB+xrHqDrxMe5A5lpwkOzswlhKR5rcLU6A8aBDQqelPAHR0pfwH1gX+G
         KP7mc/XOu06OZZyFmJdr44e2+G6NV/bEwt3apNqlYjmHEhLxIMAMvHea4SMAcyYbcYTW
         GCNXBMDQsvR2QnNSM65AfxMrs0ieME38Qw2hOu2C8PrsVGuZqoFQdyJISuPCC5gU3Gr1
         Ycow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719218; x=1789324018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9O0Uei0AmYGxnrMfKSWfJBNUDOym4vtr5Ws3/LSEZc=;
        b=KuHX42frVkheaC4MrjGLBtQTqnL3TSuubR8z7gZM0eW6+cTFa+QLM4TJPlndo77lb4
         bh7UhSqxEyyRtWHL25UiRq5KjQNwAxfNXiwyOci0jrLkBNuMMW7voHY1XQSslH5AZCuI
         iwDWfXMzf6uQN3vpOTCWFwJKFxJ2FppUg1+ejpIIn9BJlsOlnJhWt45VEQTJHh0B1D+H
         lJr/SWHrVy6gXx/CvLa13zO6YdWjdO4sQ2B61sj3x7lKw2Vdx3C0r3bXFvz764m2IK4T
         LB0ek6IzaRFjsm36Z8QtHKAlZEXnmqGDzcBOCCeO6Xxi8ByS6fTXTdLlxWOwijGKgWUd
         AGQg==
X-Forwarded-Encrypted: i=1; AKwUvByvAMjx9q4Ndk8YQ3E51ruPPqX+DbS4CkTMFguBNzyTJAOY68TtSYgoGB4qY+iGf+vsH20=@vger.kernel.org
X-Gm-Message-State: AFuF++mYO9anv2Lm/4uRlmEBupbXtgd5/sxqiuTVcbAqn17gpH1Gn+9+
	7DagyjStVHjwkuKa/FREJB+CwFP2CvWAabmU96aABEi4LnSbJAInMELB
X-Gm-Gg: AYBFou0Z3Px94UlskzvbpbNpeInI50tH21KTXvgFHc1u+TVfzxrBqOjkiThVwzxfSat
	RdQn/njaWI2R+/CTVl+1wG0f+8pvpeM0X8SBHu08Sg/qmAAn3Y9y31BEgvuLiTJmbKLgxY/NlRT
	+TmBEj78VkzggzxZ83fMjeo2mEFHaBr7RJerj3EFQnpnZMcmbCsnCoQ8A63fdfFoeP2HMhIVJGL
	l6lIFoadKCukr+6okwF6sWpJc9JZXc/TSW7I2jR93iixoZw558yhlzhpw8cbu09YjJnfPDEYbg/
	7BY/dwz8MXbysGxXeS9W/LyxeGcRZ9UTRxY4a0a5h7wZu6Prxt4sj8ewzCp8SkGFzdns3Cw4fRC
	ayEG66nPnB0wP5mXtzqr4/OliQ9fTZ03xRa6ftd2CnoD7novwjmAM5uQIItgcL3UM4Wo173AijU
	BBPObKvDrR9GLnYUiIQHypRsgroZncXDoUnL6qITDcttgOvJCBT8quM76oueNq
X-Received: by 2002:a05:690c:4023:b0:865:b26a:8e30 with SMTP id 00721157ae682-871290a5cfcmr47919017b3.34.1788719217740;
        Sun, 06 Sep 2026 11:26:57 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-873194f76e3sm44502337b3.5.2026.09.06.11.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:26:56 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 14:26:51 -0400
Subject: [PATCH v5 2/2] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v5-2-e8747a65c240@gmail.com>
References: <20260906-perf-gtk2-v5-0-e8747a65c240@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v5-0-e8747a65c240@gmail.com>
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
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmbsjaGz1JN7Y0uePi8UVJjh4fSpW/ncj4Fn2uL/LGi
 d92OS11HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNNzXFGhov/9+1Zwc
 ActsrbJa37V00M82a/Of/P8Xu1p/msL1wi8pfhf36mzc9950qvnItxNSwuumCU2bvm+FatK8eeu
 V3Y2f9mKgMA
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

