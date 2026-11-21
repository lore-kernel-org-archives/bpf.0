Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244380;
	b=AYhdYR+tFBMp2h7/1At04CXcS5VBnGvG6ig40LbwGcBtaCWMLEWHkH7tIRw9iaW3P/29
	 uY0NFsflYYZ4+PMYSC6ySftPQtZAFe46dnuqoU7Mv7hj+iLOizkikLfQVcf4c5K+imyLi
	 h7dG4XyJLg5zTFECvex6o4an4PRBz25hVrxD7jbXRhyIi7WN33/geM+/N+yFJnVL0qBKe
	 hXm0B20+Oo/N7FNDLypFnknClHZEFx03VoxX6TNWWQDYmUVROtkZbBps855Epoo7nGkQB
	 A63pH0MAQcOzKI5fqrNO27TxT249CFXxjaTcLwoKV3crpqotu9LM8QVCv3pl/CBTNqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KOONOUBRea55D4L/MhBbf8K2lc+JFi0aqBhiCgSX6Yw=;
	b=BBmhikkTiSMl5nTmgrHB0zEvJvTF7QQ8IDDPdEgBAAKu/8yd7Ryl+Ij1ZSOA8n92BtPo
	 ZraK5KoBTNwTPfk+Nsg8c9A/DKcbZpm6MOj51he6yUmcG/ZJgFfcZ5tE1Ulbo0rN5HvP/
	 hlctEuj/6fjvYGDQCS17qKTuL9s/bzC/bqMdl75JfpXB1lVdzCDpxZOPVSuHiTPOrkO5U
	 9pyYb7fWLkyM3rjrj1n+zvjOhYV5krZu7uz05vrFNb0obSYv6csADdKzZmtGFQH8/16p+
	 rqZLDy4lEH8DURoxypdRrsRfcXs6XkV8hDFmea0FZdDCazOQGqMozRwlxSinrmkbPaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XTr5xx8D;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6FD606A32C
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 06:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C6FD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XTr5xx8D
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-46617932071so947099fac.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244379; x=1795849179; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOONOUBRea55D4L/MhBbf8K2lc+JFi0aqBhiCgSX6Yw=;
        b=XTr5xx8Dnfe+l2AuL3AwIcShg6lt/rcTnFHr7wqhNtlP45dfH3p2umXPfPwGVvSKLk
         QKZyt4dQ9J4pEdjvz/t/AlS14D+x0aaAjSFJ77CtBLSzQ9TkPLMlwXHd8kmdju6GQTo4
         oIKvi/FuH1/jq3SXIMokDR5wHPvPHi2HH+cupOO1L+plr9zdvsYqwck2QodoiJHLQJvT
         sdC0ZyskYnIG0zMxw+NrmEBJEN2JYMEfXqLY7V51vLbAe9mD9qGfjTSPsbAHFCOjcWJG
         qyt0m56DUrdlqy6QRlm7pOWVKQlNYk5S9x1g+UKDEUv3y7JJiB3OJz4wO2mnHQJxqYJP
         k0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244379; x=1795849179;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KOONOUBRea55D4L/MhBbf8K2lc+JFi0aqBhiCgSX6Yw=;
        b=dtuPudmfmRxuZW5dEzowbI1HQrqYMXE8IuVvyBa3SSYAz+WB/UAj2fVx78jfFwjCfi
         QVkkMw8Ou7XA5EoSX2XMSEtLYcCqkynwd+yNyIxHXzZN+5IQ7kpnOoWxXOQhWlKLr7do
         4m5719jBrndoVbOIGx3oLg4fv8T75iD/1lShVV1bYuoIE+u0kxAJ9K4k5sBk9M8o31zE
         TwMcb2lbhICeeYPP7f/su/V8tkQzBiaih1TsP+zaWZvVNudTi/4t5LqvIvQQEkThBt4D
         rxxjefcID/qSYj56/ziWCtTm0HHkus/mNBTsF73jljoRloGclRoEKH+HM8Ph3vnkzKpf
         dcrw==
X-Forwarded-Encrypted: i=1; AL+hErG/Au71+JeqVEwl4H6rLQEyGRuxramQvuy+yMn67jwMAsKSzbzOwR7Q9HRZ6w3EGTTknl0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mriTmUlkPwa1hUfuwW5H1kYoQs/gCFcIT5e1hSOP+bhcNmi8h
	E2PBO5CUFnVwCQiuoVrzBNJiA2oGTacXGMlMQ01WxdwA1wvDtDnSYFH3lR1A9rpjpAhUHudthfA
	KSZDIx/dmDw==
X-Received: from iobmr2-n2.prod.google.com ([2002:a05:6602:a542:20b0:9e2:221a:fd83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1a02:b0:572:2919:eba3
 with SMTP id 5614622812f47-57a0ccdebf8mr6144982b6e.67.1795244378377; Fri, 20
 Nov 2026 22:59:38 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:08 -0800
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
Message-ID: <20261121065813.4143649-20-irogers@google.com>
Subject: [PATCH v15 19/23] perf maps: Remove unused maps__load_first()
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

Commit 553d18c98a89 ("perf lock contention: Load kernel map before
lookup") removed the last caller of maps__load_first(). Remove the
unused function and its declaration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 10 ----------
 tools/perf/util/maps.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 675fe0223faa..496a592284c5 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1457,13 +1457,3 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	up_write(maps__lock(kmaps));
 	return 0;
 }
-
-void maps__load_first(struct maps *maps)
-{
-	down_read(maps__lock(maps));
-
-	if (maps__nr_maps(maps) > 0)
-		map__load(maps__maps_by_address(maps)[0]);
-
-	up_read(maps__lock(maps));
-}
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4ec9b7453a3b..4e6eff244125 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -83,6 +83,4 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
 void maps__fixup_end(struct maps *maps);
 
-void maps__load_first(struct maps *maps);
-
 #endif // __PERF_MAPS_H
-- 
2.56.1.750.gf70dc682cf-goog

