Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941389;
	b=zAdU+VQSH4DvIZcSJtlMqbBXfVvqNMzOkxQx/BeqCTCQgd17Ghb/EfrKYgnX/0dkHjSS
	 opnretBsZYP0DdgzmzFRobzBdkxysH3F3cCXDDLvUDW8i5CHpAi3NEJ2pzwi7BjEAp/zZ
	 5V4FWWNR4ZYkxbkxA8t2XP3rzeLIHjl7T+Hx5hYdKYQGqIIyY1thHdD3db+ssUFmu3Y9o
	 wog4ZOmBnfLB8qKsXxYvXsgrsYeZvChHp8FSlA4vlZai6sswd/7NFbkDMxWe80ApuPibI
	 7exyoEEpep8qHdFYOAMPEf298tzVRs4ECoKzG293iGZbsmimLlqZZYt6uxFNjgBh7MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=iqWw7gAI+Px1NGEUCbsYm+jBcmDfGV1RFufBqYlyomM=;
	b=uVgPdcmdwa7/tO889SJHU8Xh/+QLhiPmPwzASE3RJQ6r48Lq1t3YsH3nKM8tuZbqj9Ag
	 TOjyQ8UjgASZWQPshH+LVB88Nb9O+Kclp0mhj+xR6BpRD+G7ZhIkpyVk5Y/mA+rCZZUq2
	 DJnC/TSTVX2MPJul89f02NZpl1zxgaqxKxh+aD27Ge9vgEqEnt4Lzmb14aNsM/3b50nls
	 8JsM7nnxblqx2SZBxFyLCwSD0HOefk04sR7HLm+aJwEY4Icg4sq+Vhfr4xKhbFMlacRDC
	 yBd6m3ogieNyxdo6TfZmZGXVOVI+lwsXgRaON15rqoQdOnMl/BiJQ8B4ZPrMtiNXrMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qNa4CYQQ;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A787606A8BA
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A787606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qNa4CYQQ
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-370230d93efso600200eec.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941388; x=1795546188; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqWw7gAI+Px1NGEUCbsYm+jBcmDfGV1RFufBqYlyomM=;
        b=qNa4CYQQiFAQOhnMJ8i+DvWjy1uM1Wmhep3MRgShFLRvUsj+3/8Kc9vIefjmWiFz1a
         6HCjyNQJi+xJoTST73seidfYMIs0us5J0uHYh6Ng8deoOq/El5WvWP4W9hBAB7byTrRz
         O2jBC6G8jwT1KYyc30qJtBcbSKM5Gra7JUrtww8DrG9Fy0D8iEWMNkRtPJF8I7Y9sVcw
         0KHAIKxP/d2HrwzA1EBrACWdQTWhU4+uAs9NTBuCDNdt0ZnyC0FaHic/55gHT18hv1Tm
         sF/uNpgqucgF/bc3MdVM+iVduf596h1dOhSz2O0ah2xYePNOl3AFdiy7gmMK/z/l6JvK
         J7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941388; x=1795546188;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqWw7gAI+Px1NGEUCbsYm+jBcmDfGV1RFufBqYlyomM=;
        b=0dUHj5JuAf76LovAHWP+WU5WPFpAF2g8D3pA3r91apNzIT4V7hVlyae5wvPuBTDEB6
         UWgrF5xmj0OuFD8XrbAhIDIuIi2XZQHy162tjHr3+5jhOmuu0Kd2cun0SPdv9KT1hOGJ
         k/+kw10kEBlctO/sEsMlYrM6I+a8/UAnlv6QA+opIoklGi4USqAJT8TknE1JaqbKnwDO
         Bp2OmEP6mDWpb+buIupId4GvgucpNRqCEgVLlNBpeoZNVrO3jCXZuch4qhbRpqoZJN+0
         uxUQ9Hyp2rQZJXNKeyYrszt0o8kuOv+V4A2xG+Q3Itdd7BGf23Ew8qzRa0YO9nAzDsKU
         l2cA==
X-Forwarded-Encrypted: i=1; AL+hErFWWgdFFXwgsYuAX6NwDj/5k8iUs4emO4XQM4nNHK4dsZCWCScjWeEMX5TweGpTMbr12d8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AYec0ML09LLVg8Tkx4sOAi6iK5h3GDP7m3zevpgh7si6ds1t6
	gqHWPsVsNT8udVp59aXOm1JY4IR82cl24Boxz3jvNpBC8RhWmdLwkLAzXaZKZPSfL2K8NEhhLY6
	j7AtIW3dWKQ==
X-Received: from dybry9.prod.google.com ([2002:a05:7301:4d09:b0:373:6c70:7c9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:b196:b0:377:678:2309
 with SMTP id 5a478bee46e88-3827fe76e1bmr299325eec.15.1794941388113; Tue, 17
 Nov 2026 10:49:48 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:43 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-23-irogers@google.com>
Subject: [PATCH v14 22/23] perf machine: Hold machines->lock for remaining
 guests rbtree accesses
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 1324aa051bed ("perf machine: Protect machines->guests rbtree with
a rw_semaphore") added machines->lock to protect machines->guests across
util/machine.c, but direct traversals and teardown of machines.guests in
util/aslr.c, util/build-id.c, and util/session.c were left unlocked.

Acquire down_read(&machines->lock) around the guest rbtree traversals in
aslr_tool__destroy_machines_priv(), perf_session__write_buildid_table(),
machines__for_each_dso(), perf_session__read_build_ids(),
perf_session__fprintf(), and perf_session__dsos_hit_all(), and hold
down_write(&aslr->machines.lock) when erasing remaining guests in
aslr_tool__delete().

Fixes: 1324aa051bed ("perf machine: Protect machines->guests rbtree with a rw_semaphore")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/aslr.c     | 4 ++++
 tools/perf/util/build-id.c | 8 ++++++++
 tools/perf/util/session.c  | 8 ++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index e365f807b021..f9ecb6d3f5fb 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -243,11 +243,13 @@ static void aslr_tool__destroy_machines_priv(struct machines *machines)
 	struct rb_node *nd;
 
 	aslr_tool__free_machine_priv(&machines->host);
+	down_read(&machines->lock);
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *machine = rb_entry(nd, struct machine, rb_node);
 
 		aslr_tool__free_machine_priv(machine);
 	}
+	up_read(&machines->lock);
 }
 
 static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
@@ -1363,12 +1365,14 @@ void aslr_tool__delete(struct perf_tool *tool)
 	aslr_tool__destroy_machines_priv(&aslr->machines);
 	machines__destroy_kernel_maps(&aslr->machines);
 
+	down_write(&aslr->machines.lock);
 	while ((nd = rb_first_cached(&aslr->machines.guests)) != NULL) {
 		struct machine *machine = rb_entry(nd, struct machine, rb_node);
 
 		rb_erase_cached(nd, &aslr->machines.guests);
 		machine__delete(machine);
 	}
+	up_write(&aslr->machines.lock);
 
 	machines__exit(&aslr->machines);
 	free(aslr);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 02233ef0eaff..c792448cc344 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -374,13 +374,16 @@ int perf_session__write_buildid_table(struct perf_session *session,
 	if (err)
 		return err;
 
+	down_read(&session->machines.lock);
 	for (nd = rb_first_cached(&session->machines.guests); nd;
 	     nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
 		err = machine__write_buildid_table(pos, fd);
 		if (err)
 			break;
 	}
+	up_read(&session->machines.lock);
 	return err;
 }
 
@@ -926,12 +929,14 @@ machines__for_each_dso(struct machines *machines, machine__dso_t fn, void *priv)
 	int ret = machine__for_each_dso(&machines->host, fn, priv);
 	struct rb_node *nd;
 
+	down_read(&machines->lock);
 	for (nd = rb_first_cached(&machines->guests); nd;
 	     nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 
 		ret |= machine__for_each_dso(pos, fn, priv);
 	}
+	up_read(&machines->lock);
 	return ret ? -1 : 0;
 }
 
@@ -962,11 +967,14 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
 	struct rb_node *nd;
 	bool ret = machine__read_build_ids(&session->machines.host, with_hits);
 
+	down_read(&session->machines.lock);
 	for (nd = rb_first_cached(&session->machines.guests); nd;
 	     nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
 		ret |= machine__read_build_ids(pos, with_hits);
 	}
+	up_read(&session->machines.lock);
 
 	return ret;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a58b4fe44b62..4e11eabbbe6f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -3965,11 +3965,13 @@ size_t perf_session__fprintf(struct perf_session *session, FILE *fp)
 {
 	size_t ret = machine__fprintf(&session->machines.host, fp);
 
+	down_read(&session->machines.lock);
 	for (struct rb_node *nd = rb_first_cached(&session->machines.guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 
 		ret += machine__fprintf(pos, fp);
 	}
+	up_read(&session->machines.lock);
 	return ret;
 }
 
@@ -4181,16 +4183,18 @@ int perf_session__dsos_hit_all(struct perf_session *session)
 	if (err)
 		return err;
 
+	down_read(&session->machines.lock);
 	for (nd = rb_first_cached(&session->machines.guests); nd;
 	     nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 
 		err = machine__hit_all_dsos(pos);
 		if (err)
-			return err;
+			break;
 	}
+	up_read(&session->machines.lock);
 
-	return 0;
+	return err;
 }
 
 struct perf_env *perf_session__env(struct perf_session *session)
-- 
2.56.1.703.gf848ed807c-goog

