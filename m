Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244358;
	b=BH62oGpqqx9VjRooGH+FNgsO8TFjw1SpHcI2lCLXMQ9+iggvxT6O76DiBbGcnFEikGfM
	 a75TNQjIRQQbnwmrsoJbXM0goIF3Zjkcc9ytmfGTZSVRXdBp8ZHwI0GxMfsNLzO0uO+Xr
	 9u0RYtnAZ1Wfj2sAs2CJEpg4VtMttPK8XkT3JVLAYvDIw6ExVkkfDjp8wJ4STQvjspI/Z
	 FVFhzPJFP02H1bYgMModKSD/wk6GFnXSN7fPZjRupT9hj4/48N2snAODL2E/mXBfrO0EL
	 /qu+bQKq5HylPIAX8/ZOZs90262p8doi+DgDPYBHjhBa7oSJW8QUnqvL2lcMZAj1BbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aVB8Y+p+SSfHh9qUhyaF69ZnIILGyQybiQn1OGrqgeA=;
	b=db4ltBP4jrsQSc6/wSaJkRWe6k+wA9hWHXhpOk1uPgLe2scVYKkAvNXyu/y9XU2ZNrlc
	 Rlm61GZqUfQopHJL0VYOodLOh5BWOTazlyWlQWGTyDWxXA3CFAs2mDykrG0Km1lGNG8WZ
	 PxN0rgW+sWYqXhCwsiKqJiBrNjD9i9SNYg0FkfC2PpUbn/H97JiSjQY2lnPXekI/xl9Dv
	 BIBovFe0W+h0fRGv4l+VcGNs1uf4E0gn2Axp5SsQofPd5/ueFn61WXhTmWhAmDDLi5JCa
	 zTghdAPUDNCoQSCePiZw9SDQkmP4QP43PqU133JCIOvTlACmNC/LETs3lhfTMEn1fGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="bcz/Hiqv";
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4A606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 06:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B4A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bcz/Hiqv
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-46617932071so947011fac.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244357; x=1795849157; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aVB8Y+p+SSfHh9qUhyaF69ZnIILGyQybiQn1OGrqgeA=;
        b=bcz/Hiqvau/FgiI1iUoF4h2WuewcMNku0Lw8lw0801v3iwqnMJHDykyGuFAsJ6bSGu
         4DoLXYnhQTBaihx2J6NOoxHeXlM34Ex1A02LfSeFXHJ9V2A3DcuDt2zaa14XvxdUBeXh
         RuutfG6xHqzC2MxQ0pifuS6IJQW8UXaLNQk6+zFFWDj2uts4bpovVmqAOvWZtdZrBViS
         5Zmwq29iMcTbhjLnZvn1f+3dNEicMPWdaUNQeVvQPb7WRW2NXnq+8Wo5tYulVC4KJhsM
         jV8450brPVmJa6h8aYZBr6iH8uuR3Z4FWGdxAUEbeG5Egb2yw2s3w4OGkN4hfjz7lmau
         4PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244357; x=1795849157;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVB8Y+p+SSfHh9qUhyaF69ZnIILGyQybiQn1OGrqgeA=;
        b=jZibyTcGXUljSQL5KbwKOngu+UnCVUyCCYx1Ly+xVywxgVlXWxwoxYEtnxmrINaWFm
         jHxF4edgN/5avRDGE+ut/Bxx9I6NgLF7iiEQmEnBecm0fnFRfdDj1eaFVEXu8OJKNh73
         LKdYm5bAV8JOYHDX5uM+g3+yIL/Yc7ue+QZqGEPSWoivCNWs0ZXwmiAhOvrXmURCECnd
         w2HYMP3hqyl0wIjN6cbcQhJ5c7FQH3jaXVbhwjAF8o4CA1r5/YtDHiKOQdyy05/7afUb
         CNngQzi3bRBclNp7VMk8q99Urm/r0Ba7Lbpm+hk/bDVSibTF2vX0ZN4l4Mn6Iaw9hSG8
         pGrA==
X-Forwarded-Encrypted: i=1; AL+hErG4u8wz3aUKXWpcuvdJeAN8ClrQACmcObQn6FDK6XuSOtAYgn3ql5jN/g/Hm19GqwsBPeE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KVbjnlOjERcnqf2zS8lJ2sI6jMFKqBhlo5vwF9CCBnvi3LFO/
	lGAlsor3//+Uu0PyDEOGx059/0AP/sjvQ1AsQaGR3JQZOUt3GcW+UnHlSc+YZzILXXnaZieywi/
	BtF6btnkMXw==
X-Received: from oacje12.prod.google.com ([2002:a05:687c:2e0c:b0:4a6:98a5:8dea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:6986:b0:4a7:5eb7:ab8e
 with SMTP id 586e51a60fabf-4bc84b1d780mr4716649fac.44.1795244356893; Fri, 20
 Nov 2026 22:59:16 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:02 -0800
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
Message-ID: <20261121065813.4143649-14-irogers@google.com>
Subject: [PATCH v15 13/23] perf dso: Expand context analysis annotations
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

Annotate struct dsos fields with __guarded_by(&lock), annotate
dso__data_open and fd_limit in util/dso.c with
__guarded_by(&dso__data_open_lock), and tighten __dsos__findnew_id() and
__dsos__addnew_id() from shared to exclusive lock requirements.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dso-data.c |  4 ++++
 tools/perf/util/dso.c       | 14 +++++++++-----
 tools/perf/util/dsos.c      |  9 +++++++--
 tools/perf/util/dsos.h      | 10 +++++-----
 tools/perf/util/vdso.c      |  1 +
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 18b7052a2dc5..6ef59929e6c0 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -116,12 +116,14 @@ static int dso__data_fd(struct dso *dso, struct machine *machine)
 
 static void dsos__delete(struct dsos *dsos)
 {
+	down_write(&dsos->lock);
 	for (unsigned int i = 0; i < dsos->cnt; i++) {
 		struct dso *dso = dsos->dsos[i];
 
 		dso__data_close(dso);
 		unlink(dso__name(dso));
 	}
+	up_write(&dsos->lock);
 	dsos__exit(dsos);
 }
 
@@ -254,6 +256,7 @@ static int set_fd_limit(int n)
 }
 
 static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+	__context_unsafe(/* single-threaded test */)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt();
@@ -324,6 +327,7 @@ static long new_limit(int count)
 }
 
 static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+	__context_unsafe(/* single-threaded test */)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1c938d1b11e9..49813424e4ee 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -525,7 +525,8 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  * Global list of open DSOs and the counter.
  */
 DEFINE_MUTEX(dso__data_open_lock);
-static LIST_HEAD(dso__data_open);
+static struct list_head dso__data_open __guarded_by(&dso__data_open_lock) =
+	LIST_HEAD_INIT(dso__data_open);
 static long dso__data_open_cnt __guarded_by(&dso__data_open_lock);
 
 static void dso__list_add(struct dso *dso) __must_hold(&dso__data_open_lock)
@@ -757,7 +758,7 @@ static rlim_t get_fd_limit(void)
 	return limit;
 }
 
-static rlim_t fd_limit;
+static rlim_t fd_limit __guarded_by(&dso__data_open_lock);
 
 /*
  * Used only by tests/dso-data.c to reset the environment
@@ -766,7 +767,8 @@ static rlim_t fd_limit;
  */
 void reset_fd_limit(void)
 {
-	fd_limit = 0;
+	/* Only called by single-threaded test setup. */
+	context_unsafe(fd_limit = 0);
 }
 
 static bool may_cache_fd(void) __must_hold(&dso__data_open_lock)
@@ -1726,8 +1728,10 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 			changed = true;
 		}
 	}
-	if (changed && dsos)
-		dsos->sorted = false;
+	if (changed && dsos) {
+		/* dsos write lock held by caller. */
+		context_unsafe(dsos->sorted = false);
+	}
 }
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 4ff38cb5e2cb..7a56577f4ec8 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -12,6 +12,7 @@
 #include <unistd.h>
 
 void dsos__init(struct dsos *dsos)
+	__context_unsafe(/* initialization */)
 {
 	init_rwsem(&dsos->lock);
 
@@ -50,6 +51,7 @@ void dsos__exit(struct dsos *dsos)
 static int __dsos__for_each_dso(struct dsos *dsos,
 				int (*cb)(struct dso *dso, void *data),
 				void *data)
+	__must_hold_shared(&dsos->lock)
 {
 	for (unsigned int i = 0; i < dsos->cnt; i++) {
 		struct dso *dso = dsos->dsos[i];
@@ -182,7 +184,8 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 		}
 		qsort(dsos->dsos, dsos->cnt, sizeof(struct dso *),
 		      dsos__cmp_long_name_id_short_name);
-		dsos->sorted = true;
+		/* write_locked is true, so dsos->lock is held exclusively. */
+		context_unsafe(dsos->sorted = true);
 	}
 
 	res = bsearch(&key, dsos->dsos, dsos->cnt, sizeof(struct dso *),
@@ -194,6 +197,7 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 }
 
 int __dsos__add(struct dsos *dsos, struct dso *dso)
+	__must_hold(&dsos->lock)
 {
 	if (!dso)
 		return -EINVAL;
@@ -320,6 +324,7 @@ static void dso__set_basename(struct dso *dso)
 }
 
 static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
+	__must_hold(&dsos->lock)
 {
 	struct dso *dso = dso__new_id(name, id);
 
@@ -336,7 +341,7 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const
 }
 
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
-	__must_hold_shared(&dsos->lock)
+	__must_hold(&dsos->lock)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index dbd06f420753..cc7e3a42f9cb 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -19,16 +19,16 @@ struct machine;
  */
 struct dsos {
 	struct rw_semaphore lock;
-	struct dso **dsos;
-	unsigned int cnt;
-	unsigned int allocated;
-	bool sorted;
+	struct dso **dsos __pt_guarded_by(&lock) __guarded_by(&lock);
+	unsigned int cnt __guarded_by(&lock);
+	unsigned int allocated __guarded_by(&lock);
+	bool sorted __guarded_by(&lock);
 };
 
 void dsos__init(struct dsos *dsos);
 void dsos__exit(struct dsos *dsos);
 
-int __dsos__add(struct dsos *dsos, struct dso *dso);
+int __dsos__add(struct dsos *dsos, struct dso *dso) __must_hold(&dsos->lock);
 int dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short, bool write_locked)
 	__must_hold_shared(&dsos->lock);
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 8bf81e2c9e78..fe28e346dc2f 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -126,6 +126,7 @@ void machine__exit_vdso(struct machine *machine)
 
 static struct dso *__machine__addnew_vdso(struct machine *machine, const char *short_name,
 					  const char *long_name)
+	__must_hold(&machine->dsos.lock)
 {
 	struct dso *dso;
 
-- 
2.56.1.750.gf70dc682cf-goog

