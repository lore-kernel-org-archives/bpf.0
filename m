Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B563B637E
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715094; cv=none; b=g+Ix8v4r35PKqObX0+OyKCIwhtwhwMr3Wa2lH0uT/Cjmtio00/XruTb2rVKlalXgEYJI3H5BnJ7SZuiuo6f1y3ZM2HlT0bMFynXCDpVBtVKCcreTO3ip5Ni1HrJ4PAe/+2eSYZRxgfj71X++ikdrcWkBkWedX0k8tB/TkI+x4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715094; c=relaxed/simple;
	bh=8CvFHtfn4Ljqx5Fa6L2b6SNfX914djxML7DsfBsaOO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TV0tNKqM3TeT+nhoKbue4lN5U/y+gQA/qX1Hfy4sBCmxRgmgWdEXN82LjPgdOlWBLEtN9OAwpfbBzwP+PJmkXElOPEQl1/ML76VWGbv0CM4Eg9e+KpsVmChh5yzwjW/6d8pKKL3Yjih+s3O5DQz9mF0mBHtT7wn0wPbW5cGKs84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ8HSNUn; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ8HSNUn"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8623b1e7cb2so9456957b3.1
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715091; x=1789319891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9O0Uei0AmYGxnrMfKSWfJBNUDOym4vtr5Ws3/LSEZc=;
        b=FJ8HSNUnHyZwKW7jb7fiThMpJPU5z4rzBQTJPq2vKn1bbOlCRSWCinjLZ/7NfYLeyU
         Cks0iDQipNobaTfzx7xcsQ/g0I+B/3dvnTizzNVWthJzyegwNEz/ni3kRt0FPY7caIns
         vBceNda2B20QHFYmIROPFwxaBr5YwZOnIrSu3D/iyXjjyIagkvOP8jPSAF5o7067epCW
         d2aVqC2z0v1mkKLQKLRKVTk8pSLP4piFn55YrVP6uMf5s9yDSdPqOD59HVIq/i/Zy6Vr
         67UfmUElqsDCF9dwSvmTi2l42tX9KZz7Ta9OpTxD2Gyo7K4AyRLpG32z+d5laTQnDObf
         5Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715091; x=1789319891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9O0Uei0AmYGxnrMfKSWfJBNUDOym4vtr5Ws3/LSEZc=;
        b=qMflXHT6LmiosKbUTyMsBr0AM/hjmjWO2f0Fc13swpkL8lRc9onMQK+23Cnw58I6++
         aU6waJHrlXn9FfgbiEuPpYz+WB/zrr6aAwnpN42AiEjrCfeX431fauWhrZMhxC5J2vS5
         PcTbqYXNQNtm/MaYGR00qVtiPX7biss892wAqX6zmy8PeXRoNEsRS07DR3BydZXpECsL
         dWXPoPMbcW4+FS1Bj0Da76vfveH9gcmmLOEzHNjFnGQ51cUaHH5aa5cUsVvEIhJc7d3T
         +KwKF+nmXxT5tU8/ISTBPluTgKZpdM3Mo9D8I/VKyir3DIecSk+PsErTBfNcQuubq0jW
         fj2A==
X-Forwarded-Encrypted: i=1; AKwUvBwZLcek8okSW9OmmNcDCaLkMMTX51aFDHATqsuYv3KhQUGkw78tTlpkua6cuMwzcabz5io=@vger.kernel.org
X-Gm-Message-State: AFuF++kY2BY2+JPJy7Rbu2nUg0QLbDTEjMShQiodZajjQCWgmiMj07GK
	BN/pvvfKOC/ZiGK6cZXnG4bQdmHwSZPL4B4mZgafCfg6vN2Vz7W9rNBq
X-Gm-Gg: AYBFou2BOCRZTR5q2pJwmVpH2MC8qU/rwqm0HclrRwoldEmSS7aXBvzpGs5nOBc9o0+
	5OC5rs7CVnXj9WNSVxLkY14Z3nTIpoPvIHTolbArB2fd6ZieAYL06NBajWlICOvRwUFb5X/Obnd
	T0RKwoPBVgnU/QAlhOCxwjf3mASfLd6wybheTWiskmm6JmV9z8EjlKgi6J1Rw/WsggwAy13gWHV
	sVEeyOfFav5080tdt95lPWm47YK4C5tbzNjeBYS0l4Txm6enT8AghFGM2Lj/9eOMLB165ZTx3cI
	UqrK42EejyHb14v9LNabKlqvTpQSwfJt6Xi6+TzBFQrO0Psf9DR1v+hZy/NWgGwYNP5FoFZRoD9
	IiiI4koLyltnAC2h+0X/60UblsdCvRiLqA7JnGw++KvmgqUY8xF+JX4avixc0/AUINMHR6TXqxg
	d5jPGVYBqxayA11HVBcmFTHT7dx7BOgCq7ZY/BgDIzUbonrgI/jalnze72jYNkI/ctfBVY1U8=
X-Received: by 2002:a05:690c:e3ec:b0:876:6206:512f with SMTP id 00721157ae682-876620652ffmr13759577b3.43.1788715091362;
        Sun, 06 Sep 2026 10:18:11 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714af5581bsm57889107b3.36.2026.09.06.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:18:10 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 13:18:05 -0400
Subject: [PATCH v4 2/3] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v4-2-97e92ee07214@gmail.com>
References: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
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
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmLvCZzJnAdcb9+Yu1on22p52udcRl5Pz9FffIcvsVu
 ZU7PsoZdnxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1kzoZGS6wF50pXb
 pduGe18uuyx5v7Hxx5YJO840my1U+DzTMUP59iZNi7nk06T06l83kze9/CCKOdUkvzRFkmap+xt
 vn99dfTFg4A
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

