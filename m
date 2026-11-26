Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698055;
	b=mKL4NzkqyIZ1H6o+1DHyjUOsf1cfRbO69KjseCYyfy+2ojI4jsA1yJ/tZpQCQYLhbLxX
	 OKpKBg2y39AAuUAH1vsMPwCVvmqtDvspxo4B7YKZnPSrg6eFUXhRfLgnhed1w0NXcDbjy
	 ImcxPmI18TY25ygqwkm7i1uAlD/ckZQVxEciBGvmjlNIKPJYy192eyMQE6lbtQEUFpyVr
	 7wWaQQ72/irbTpkkr2gZn7co+k3GUalfApnfntt4pOZaXuImYoFsM9dtgOrUJgJwQht8g
	 GqVmdezoCeWryJZ33BVzvRkPHIP5s8bYXJ2AxhHBz2bAp0lUxZUJ/je23jA8YXY7Hng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698055;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ro9hjr+hebg6cNpIqN7FZXX+UD1iMbZ9GxlQ425ZZro=;
	b=rWGtocj/WysTp/PcdtQHnWXfJDdtIKdXIFzR5yll3Xm3Lyp4Xzhhr/eJgEqW4XzjiC1/
	 XaDoDIEz4FRJpE5MsWMcq2w7TfAmP24kh9H9qbTg5sXbYMfHVhYZ925mPTy1bvDewC3uV
	 ZdW2QsI1WJo2emsNYgVrzrnI/0RsL9kKYpsPSz439AOdOP/aWuOFMsRdpo5Hze7vGWup4
	 tSmPfmQhMBl5soQ/p9Us4IGbCD5heHtpablYVcdGKVDbJSqz3GfhOS6+vFkq/9mWjkp/v
	 UCErpNCACoRaq+7eFYS7TWWIOuv+cYVs8tfFOHai3AC4Sng/Ae0nmL6+v7U5dyh8Wvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ULChCIR8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465E606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0465E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ULChCIR8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ro9hjr+hebg6cNpIqN7FZXX+UD1iMbZ9GxlQ425ZZro=;
	b=ULChCIR8ji10Ygo/k/cENxUkydDE3sMI4+ddj29cB0IjEpiiLgLDhZWbKWIjAbJndnDWxU
	3ziN6cntkvRMxjJDuqsMg3oLNEoPSYIZA6gMD4iJaVqZORt9Cu1T8btKpBkTBOBduzafVV
	UApHWPc6nyH/fsfoieOtUIrOqSBK6jE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-pojnjwP-PL2_a9Ky9fSSHg-1; Thu,
 26 Nov 2026 13:00:46 +0000
X-MC-Unique: pojnjwP-PL2_a9Ky9fSSHg-1
X-Mimecast-MFC-AGG-ID: pojnjwP-PL2_a9Ky9fSSHg_1795698044
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACA2C1800558;
	Thu, 26 Nov 2026 13:00:44 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01168180054C;
	Thu, 26 Nov 2026 13:00:40 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 04/18] rv: Propagate const to model strings and tracepoints
Date: Thu, 26 Nov 2026 13:59:50 +0100
Message-ID: <20261126130004.127155-5-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Functions like model_get_event_name() and model_get_state_name() are
shared with BPF monitors, however those programs don't play nice with
string pointers without fixed length and the event_name and state_name
arrays need to be defined differently. This gets the compiler to notice
those are const char and the above function discard the const qualifier.

Mark all monitor strings in headers as const and propagate the change to
all callers, including all tracepoints.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/automata.h                         |  4 +-
 include/rv/da_monitor.h                       | 12 +++---
 include/rv/ha_monitor.h                       | 10 ++---
 kernel/trace/rv/monitors/nomiss/nomiss.h      |  6 +--
 kernel/trace/rv/monitors/nrp/nrp.h            |  4 +-
 kernel/trace/rv/monitors/opid/opid.h          |  6 +--
 kernel/trace/rv/monitors/sco/sco.h            |  4 +-
 kernel/trace/rv/monitors/scpd/scpd.h          |  4 +-
 kernel/trace/rv/monitors/snep/snep.h          |  4 +-
 kernel/trace/rv/monitors/snroc/snroc.h        |  4 +-
 kernel/trace/rv/monitors/sssw/sssw.h          |  4 +-
 kernel/trace/rv/monitors/stall/stall.h        |  6 +--
 kernel/trace/rv/monitors/sts/sts.h            |  4 +-
 kernel/trace/rv/monitors/wip/wip.h            |  4 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h          |  4 +-
 kernel/trace/rv/rv_reactors.c                 |  2 +-
 kernel/trace/rv/rv_trace.h                    | 39 ++++++++++---------
 tools/verification/rvgen/rvgen/dot2c.py       |  6 +--
 .../rvgen/tests/golden/da_global/da_global.h  |  4 +-
 .../da_perobj_parent/da_perobj_parent.h       |  4 +-
 .../golden/da_pertask_desc/da_pertask_desc.h  |  4 +-
 .../rvgen/tests/golden/ha_percpu/ha_percpu.h  |  6 +--
 .../rvgen/tests/golden/test_da/test_da.h      |  4 +-
 .../golden/test_da_kunit/test_da_kunit.h      |  4 +-
 .../rvgen/tests/golden/test_ha/test_ha.h      |  6 +--
 .../golden/test_ha_kunit/test_ha_kunit.h      |  6 +--
 26 files changed, 84 insertions(+), 81 deletions(-)

diff --git a/include/rv/automata.h b/include/rv/automata.h
index 4a4eb40cf09a..e4afd5ba1d06 100644
--- a/include/rv/automata.h
+++ b/include/rv/automata.h
@@ -22,7 +22,7 @@
 /*
  * model_get_state_name - return the (string) name of the given state
  */
-static char *model_get_state_name(enum states state)
+static const char *model_get_state_name(enum states state)
 {
 	if ((state < 0) || (state >= STATE_MAX))
 		return "INVALID";
@@ -33,7 +33,7 @@ static char *model_get_state_name(enum states state)
 /*
  * model_get_event_name - return the (string) name of the given event
  */
-static char *model_get_event_name(enum events event)
+static const char *model_get_event_name(enum events event)
 {
 	if ((event < 0) || (event >= EVENT_MAX))
 		return "INVALID";
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 6fc5ef8142ac..fc830c9f5046 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -633,8 +633,8 @@ static inline void da_monitor_destroy(void)
  */
 
 static inline void da_trace_event(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
-				  char *next_state, bool is_final,
+				  const char *curr_state, const char *event,
+				  const char *next_state, bool is_final,
 				  da_id_type id)
 {
 	CONCATENATE(trace_event_, MONITOR_NAME)(curr_state, event, next_state,
@@ -642,7 +642,7 @@ static inline void da_trace_event(struct da_monitor *da_mon,
 }
 
 static inline void da_trace_error(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
+				  const char *curr_state, const char *event,
 				  da_id_type id)
 {
 	CONCATENATE(trace_error_, MONITOR_NAME)(curr_state, event);
@@ -662,8 +662,8 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
  */
 
 static inline void da_trace_event(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
-				  char *next_state, bool is_final,
+				  const char *curr_state, const char *event,
+				  const char *next_state, bool is_final,
 				  da_id_type id)
 {
 	CONCATENATE(trace_event_, MONITOR_NAME)(id, curr_state, event,
@@ -671,7 +671,7 @@ static inline void da_trace_event(struct da_monitor *da_mon,
 }
 
 static inline void da_trace_error(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
+				  const char *curr_state, const char *event,
 				  da_id_type id)
 {
 	CONCATENATE(trace_error_, MONITOR_NAME)(id, curr_state, event);
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 6e1c7fe5449a..0952a3f161c3 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -87,7 +87,7 @@ _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
  * environment constraint is false. This function can be called also with no
  * event from a timer (state constraints only).
  */
-static void ha_react(enum states curr_state, enum events event, char *env)
+static void ha_react(enum states curr_state, enum events event, const char *env)
 {
 	rv_react(&rv_this,
 		 "rv: monitor %s does not allow event %s on state %s with env %s\n",
@@ -98,13 +98,13 @@ static void ha_react(enum states curr_state, enum events event, char *env)
 
 #else /* CONFIG_RV_REACTOR */
 
-static void ha_react(enum states curr_state, enum events event, char *env) { }
+static void ha_react(enum states curr_state, enum events event, const char *env) { }
 #endif
 
 /*
  * model_get_state_name - return the (string) name of the given state
  */
-static char *model_get_env_name(enum envs env)
+static const char *model_get_env_name(enum envs env)
 {
 	if ((env < 0) || (env >= ENV_MAX))
 		return "INVALID";
@@ -227,7 +227,7 @@ static inline void ha_get_env_string(struct seq_buf *s,
 
 #if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
 static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
-				      char *curr_state, char *event, char *env,
+				      const char *curr_state, const char *event, const char *env,
 				      da_id_type id)
 {
 	CONCATENATE(trace_error_env_, MONITOR_NAME)(curr_state, event, env);
@@ -237,7 +237,7 @@ static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
 #define ha_get_target(ha_mon) da_get_target(&ha_mon->da_mon)
 
 static inline void ha_trace_error_env(struct ha_monitor *ha_mon,
-				      char *curr_state, char *event, char *env,
+				      const char *curr_state, const char *event, const char *env,
 				      da_id_type id)
 {
 	CONCATENATE(trace_error_env_, MONITOR_NAME)(id, curr_state, event, env);
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.h b/kernel/trace/rv/monitors/nomiss/nomiss.h
index 3d1b436194d7..0e74a27bc38c 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss.h
+++ b/kernel/trace/rv/monitors/nomiss/nomiss.h
@@ -41,9 +41,9 @@ _Static_assert(env_max_stored_nomiss <= MAX_HA_ENV_LEN, "Not enough slots");
 #define HA_CLK_NS
 
 struct automaton_nomiss {
-	char *state_names[state_max_nomiss];
-	char *event_names[event_max_nomiss];
-	char *env_names[env_max_nomiss];
+	const char *state_names[state_max_nomiss];
+	const char *event_names[event_max_nomiss];
+	const char *env_names[env_max_nomiss];
 	unsigned char function[state_max_nomiss][event_max_nomiss];
 	unsigned char initial_state;
 	bool final_states[state_max_nomiss];
diff --git a/kernel/trace/rv/monitors/nrp/nrp.h b/kernel/trace/rv/monitors/nrp/nrp.h
index 3270d4c0139f..f6c1ec62233d 100644
--- a/kernel/trace/rv/monitors/nrp/nrp.h
+++ b/kernel/trace/rv/monitors/nrp/nrp.h
@@ -26,8 +26,8 @@ enum events_nrp {
 };
 
 struct automaton_nrp {
-	char *state_names[state_max_nrp];
-	char *event_names[event_max_nrp];
+	const char *state_names[state_max_nrp];
+	const char *event_names[event_max_nrp];
 	unsigned char function[state_max_nrp][event_max_nrp];
 	unsigned char initial_state;
 	bool final_states[state_max_nrp];
diff --git a/kernel/trace/rv/monitors/opid/opid.h b/kernel/trace/rv/monitors/opid/opid.h
index fb0aa4c28aa6..42680aa81f33 100644
--- a/kernel/trace/rv/monitors/opid/opid.h
+++ b/kernel/trace/rv/monitors/opid/opid.h
@@ -30,9 +30,9 @@ enum envs_opid {
 _Static_assert(env_max_stored_opid <= MAX_HA_ENV_LEN, "Not enough slots");
 
 struct automaton_opid {
-	char *state_names[state_max_opid];
-	char *event_names[event_max_opid];
-	char *env_names[env_max_opid];
+	const char *state_names[state_max_opid];
+	const char *event_names[event_max_opid];
+	const char *env_names[env_max_opid];
 	unsigned char function[state_max_opid][event_max_opid];
 	unsigned char initial_state;
 	bool final_states[state_max_opid];
diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
index bac3beb51e72..65bcfcb136b7 100644
--- a/kernel/trace/rv/monitors/sco/sco.h
+++ b/kernel/trace/rv/monitors/sco/sco.h
@@ -23,8 +23,8 @@ enum events_sco {
 };
 
 struct automaton_sco {
-	char *state_names[state_max_sco];
-	char *event_names[event_max_sco];
+	const char *state_names[state_max_sco];
+	const char *event_names[event_max_sco];
 	unsigned char function[state_max_sco][event_max_sco];
 	unsigned char initial_state;
 	bool final_states[state_max_sco];
diff --git a/kernel/trace/rv/monitors/scpd/scpd.h b/kernel/trace/rv/monitors/scpd/scpd.h
index d6329da2671b..e9742c2789f7 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.h
+++ b/kernel/trace/rv/monitors/scpd/scpd.h
@@ -24,8 +24,8 @@ enum events_scpd {
 };
 
 struct automaton_scpd {
-	char *state_names[state_max_scpd];
-	char *event_names[event_max_scpd];
+	const char *state_names[state_max_scpd];
+	const char *event_names[event_max_scpd];
 	unsigned char function[state_max_scpd][event_max_scpd];
 	unsigned char initial_state;
 	bool final_states[state_max_scpd];
diff --git a/kernel/trace/rv/monitors/snep/snep.h b/kernel/trace/rv/monitors/snep/snep.h
index 357520a5b3d1..fabc363684d2 100644
--- a/kernel/trace/rv/monitors/snep/snep.h
+++ b/kernel/trace/rv/monitors/snep/snep.h
@@ -24,8 +24,8 @@ enum events_snep {
 };
 
 struct automaton_snep {
-	char *state_names[state_max_snep];
-	char *event_names[event_max_snep];
+	const char *state_names[state_max_snep];
+	const char *event_names[event_max_snep];
 	unsigned char function[state_max_snep][event_max_snep];
 	unsigned char initial_state;
 	bool final_states[state_max_snep];
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
index 88b7328ad31a..12aa743e4f19 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.h
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -23,8 +23,8 @@ enum events_snroc {
 };
 
 struct automaton_snroc {
-	char *state_names[state_max_snroc];
-	char *event_names[event_max_snroc];
+	const char *state_names[state_max_snroc];
+	const char *event_names[event_max_snroc];
 	unsigned char function[state_max_snroc][event_max_snroc];
 	unsigned char initial_state;
 	bool final_states[state_max_snroc];
diff --git a/kernel/trace/rv/monitors/sssw/sssw.h b/kernel/trace/rv/monitors/sssw/sssw.h
index 1a4b806061c3..ad8d7a18c52d 100644
--- a/kernel/trace/rv/monitors/sssw/sssw.h
+++ b/kernel/trace/rv/monitors/sssw/sssw.h
@@ -31,8 +31,8 @@ enum events_sssw {
 };
 
 struct automaton_sssw {
-	char *state_names[state_max_sssw];
-	char *event_names[event_max_sssw];
+	const char *state_names[state_max_sssw];
+	const char *event_names[event_max_sssw];
 	unsigned char function[state_max_sssw][event_max_sssw];
 	unsigned char initial_state;
 	bool final_states[state_max_sssw];
diff --git a/kernel/trace/rv/monitors/stall/stall.h b/kernel/trace/rv/monitors/stall/stall.h
index 638520cb1082..ce38b6b2311e 100644
--- a/kernel/trace/rv/monitors/stall/stall.h
+++ b/kernel/trace/rv/monitors/stall/stall.h
@@ -33,9 +33,9 @@ enum envs_stall {
 _Static_assert(env_max_stored_stall <= MAX_HA_ENV_LEN, "Not enough slots");
 
 struct automaton_stall {
-	char *state_names[state_max_stall];
-	char *event_names[event_max_stall];
-	char *env_names[env_max_stall];
+	const char *state_names[state_max_stall];
+	const char *event_names[event_max_stall];
+	const char *env_names[env_max_stall];
 	unsigned char function[state_max_stall][event_max_stall];
 	unsigned char initial_state;
 	bool final_states[state_max_stall];
diff --git a/kernel/trace/rv/monitors/sts/sts.h b/kernel/trace/rv/monitors/sts/sts.h
index 6f7b2d9d72e6..74397c37cb0e 100644
--- a/kernel/trace/rv/monitors/sts/sts.h
+++ b/kernel/trace/rv/monitors/sts/sts.h
@@ -31,8 +31,8 @@ enum events_sts {
 };
 
 struct automaton_sts {
-	char *state_names[state_max_sts];
-	char *event_names[event_max_sts];
+	const char *state_names[state_max_sts];
+	const char *event_names[event_max_sts];
 	unsigned char function[state_max_sts][event_max_sts];
 	unsigned char initial_state;
 	bool final_states[state_max_sts];
diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index b4c3eea94c86..b65baeae5419 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -23,8 +23,8 @@ enum events_wip {
 };
 
 struct automaton_wip {
-	char *state_names[state_max_wip];
-	char *event_names[event_max_wip];
+	const char *state_names[state_max_wip];
+	const char *event_names[event_max_wip];
 	unsigned char function[state_max_wip][event_max_wip];
 	unsigned char initial_state;
 	bool final_states[state_max_wip];
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index a28006512c9b..06d724ac1182 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -23,8 +23,8 @@ enum events_wwnr {
 };
 
 struct automaton_wwnr {
-	char *state_names[state_max_wwnr];
-	char *event_names[event_max_wwnr];
+	const char *state_names[state_max_wwnr];
+	const char *event_names[event_max_wwnr];
 	unsigned char function[state_max_wwnr][event_max_wwnr];
 	unsigned char initial_state;
 	bool final_states[state_max_wwnr];
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 8e57a95d446b..8988b9ab2a40 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -71,7 +71,7 @@
  */
 static LIST_HEAD(rv_reactors_list);
 
-static struct rv_reactor *get_reactor_rdef_by_name(char *name)
+static struct rv_reactor *get_reactor_rdef_by_name(const char *name)
 {
 	struct rv_reactor *r;
 
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 36e7c78c046e..24d4b94a54a5 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -11,7 +11,8 @@
 #ifdef CONFIG_DA_MON_EVENTS_IMPLICIT
 DECLARE_EVENT_CLASS(event_da_monitor,
 
-	TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	TP_PROTO(const char *state, const char *event,
+		 const char *next_state, bool final_state),
 
 	TP_ARGS(state, event, next_state, final_state),
 
@@ -38,7 +39,7 @@ DECLARE_EVENT_CLASS(event_da_monitor,
 
 DECLARE_EVENT_CLASS(error_da_monitor,
 
-	TP_PROTO(char *state, char *event),
+	TP_PROTO(const char *state, const char *event),
 
 	TP_ARGS(state, event),
 
@@ -59,13 +60,13 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 
 #define DEFINE_DA_EVENT(name)						\
 	DEFINE_EVENT(event_da_monitor, name,				\
-		TP_PROTO(char *state, char *event,			\
-			 char *next_state, bool final_state),		\
+		TP_PROTO(const char *state, const char *event,		\
+			 const char *next_state, bool final_state),	\
 		TP_ARGS(state, event, next_state, final_state))
 
 #define DEFINE_DA_ERROR(name)						\
 	DEFINE_EVENT(error_da_monitor, name,				\
-		TP_PROTO(char *state, char *event),			\
+		TP_PROTO(const char *state, const char *event),		\
 		TP_ARGS(state, event))
 
 #include <monitors/wip/wip_trace.h>
@@ -79,7 +80,7 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 /* For simplicity this class is marked as DA although relevant only for HA */
 DECLARE_EVENT_CLASS(error_env_da_monitor,
 
-	TP_PROTO(char *state, char *event, char *env),
+	TP_PROTO(const char *state, const char *event, const char *env),
 
 	TP_ARGS(state, event, env),
 
@@ -103,7 +104,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor,
 
 #define DEFINE_HA_ERROR_ENV(name)					\
 	DEFINE_EVENT(error_env_da_monitor, name,			\
-		TP_PROTO(char *state, char *event, char *env),		\
+		TP_PROTO(const char *state, const char *event, const char *env), \
 		TP_ARGS(state, event, env))
 
 #include <monitors/opid/opid_trace.h>
@@ -116,7 +117,8 @@ DECLARE_EVENT_CLASS(error_env_da_monitor,
 #ifdef CONFIG_DA_MON_EVENTS_ID
 DECLARE_EVENT_CLASS(event_da_monitor_id,
 
-	TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	TP_PROTO(int id, const char *state, const char *event,
+		 const char *next_state, bool final_state),
 
 	TP_ARGS(id, state, event, next_state, final_state),
 
@@ -146,7 +148,7 @@ DECLARE_EVENT_CLASS(event_da_monitor_id,
 
 DECLARE_EVENT_CLASS(error_da_monitor_id,
 
-	TP_PROTO(int id, char *state, char *event),
+	TP_PROTO(int id, const char *state, const char *event),
 
 	TP_ARGS(id, state, event),
 
@@ -170,13 +172,13 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 
 #define DEFINE_DA_EVENT_ID(name)					\
 	DEFINE_EVENT(event_da_monitor_id, name,				\
-		TP_PROTO(int id, char *state, char *event,		\
-			 char *next_state, bool final_state),		\
+		TP_PROTO(int id, const char *state, const char *event,	\
+			 const char *next_state, bool final_state),	\
 		TP_ARGS(id, state, event, next_state, final_state))
 
 #define DEFINE_DA_ERROR_ID(name)					\
 	DEFINE_EVENT(error_da_monitor_id, name,				\
-		TP_PROTO(int id, char *state, char *event),		\
+		TP_PROTO(int id, const char *state, const char *event),	\
 		TP_ARGS(id, state, event))
 
 #include <monitors/wwnr/wwnr_trace.h>
@@ -189,7 +191,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 /* For simplicity this class is marked as DA although relevant only for HA */
 DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
-	TP_PROTO(int id, char *state, char *event, char *env),
+	TP_PROTO(int id, const char *state, const char *event, const char *env),
 
 	TP_ARGS(id, state, event, env),
 
@@ -216,7 +218,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
 #define DEFINE_HA_ERROR_ENV_ID(name)					\
 	DEFINE_EVENT(error_env_da_monitor_id, name,			\
-		TP_PROTO(int id, char *state, char *event, char *env),	\
+		TP_PROTO(int id, const char *state, const char *event, const char *env), \
 		TP_ARGS(id, state, event, env))
 
 #include <monitors/stall/stall_trace.h>
@@ -229,7 +231,8 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 #ifdef CONFIG_LTL_MON_EVENTS_ID
 DECLARE_EVENT_CLASS(event_ltl_monitor_id,
 
-	TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+	TP_PROTO(struct task_struct *task, const char *states,
+		 const char *atoms, const char *next),
 
 	TP_ARGS(task, states, atoms, next),
 
@@ -274,8 +277,8 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 
 #define DEFINE_LTL_EVENT_ID(name)					\
 	DEFINE_EVENT(event_ltl_monitor_id, name,			\
-		TP_PROTO(struct task_struct *task, char *states,	\
-			 char *atoms, char *next),			\
+		TP_PROTO(struct task_struct *task, const char *states,	\
+			 const char *atoms, const char *next),		\
 		TP_ARGS(task, states, atoms, next))
 
 #define DEFINE_LTL_ERROR_ID(name)					\
@@ -293,7 +296,7 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 /* Tracepoint useful for monitors development, currenly only used in DA */
 TRACE_EVENT(rv_retries_error,
 
-	TP_PROTO(char *name, char *event),
+	TP_PROTO(const char *name, const char *event),
 
 	TP_ARGS(name, event),
 
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 22938ce1bf6c..c6bd4d00d92e 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -111,10 +111,10 @@ class Dot2c(Automata):
         min_type = self.get_minimun_type()
         buff = []
         buff.append(f"struct {self.struct_automaton_def} {{")
-        buff.append(f"\tchar *state_names[state_max{self.enum_suffix}];")
-        buff.append(f"\tchar *event_names[event_max{self.enum_suffix}];")
+        buff.append(f"\tconst char *state_names[state_max{self.enum_suffix}];")
+        buff.append(f"\tconst char *event_names[event_max{self.enum_suffix}];")
         if self.is_hybrid_automata():
-            buff.append(f"\tchar *env_names[env_max{self.enum_suffix}];")
+            buff.append(f"\tconst char *env_names[env_max{self.enum_suffix}];")
         buff.append(f"\t{min_type} function[state_max{self.enum_suffix}][event_max{self.enum_suffix}];")
         buff.append(f"\t{min_type} initial_state;")
         buff.append(f"\tbool final_states[state_max{self.enum_suffix}];")
diff --git a/tools/verification/rvgen/tests/golden/da_global/da_global.h b/tools/verification/rvgen/tests/golden/da_global/da_global.h
index 40b1f1c0c681..3faf0c92b8b0 100644
--- a/tools/verification/rvgen/tests/golden/da_global/da_global.h
+++ b/tools/verification/rvgen/tests/golden/da_global/da_global.h
@@ -22,8 +22,8 @@ enum events_da_global {
 };
 
 struct automaton_da_global {
-	char *state_names[state_max_da_global];
-	char *event_names[event_max_da_global];
+	const char *state_names[state_max_da_global];
+	const char *event_names[event_max_da_global];
 	unsigned char function[state_max_da_global][event_max_da_global];
 	unsigned char initial_state;
 	bool final_states[state_max_da_global];
diff --git a/tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent.h b/tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent.h
index 3c8dc3b22443..8027c4eec979 100644
--- a/tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent.h
+++ b/tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent.h
@@ -24,8 +24,8 @@ enum events_da_perobj_parent {
 };
 
 struct automaton_da_perobj_parent {
-	char *state_names[state_max_da_perobj_parent];
-	char *event_names[event_max_da_perobj_parent];
+	const char *state_names[state_max_da_perobj_parent];
+	const char *event_names[event_max_da_perobj_parent];
 	unsigned char function[state_max_da_perobj_parent][event_max_da_perobj_parent];
 	unsigned char initial_state;
 	bool final_states[state_max_da_perobj_parent];
diff --git a/tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc.h b/tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc.h
index 837b238754b0..3e4501795f4a 100644
--- a/tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc.h
+++ b/tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc.h
@@ -24,8 +24,8 @@ enum events_da_pertask_desc {
 };
 
 struct automaton_da_pertask_desc {
-	char *state_names[state_max_da_pertask_desc];
-	char *event_names[event_max_da_pertask_desc];
+	const char *state_names[state_max_da_pertask_desc];
+	const char *event_names[event_max_da_pertask_desc];
 	unsigned char function[state_max_da_pertask_desc][event_max_da_pertask_desc];
 	unsigned char initial_state;
 	bool final_states[state_max_da_pertask_desc];
diff --git a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.h b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.h
index 2538db4f6a26..ee8aa72d6d5a 100644
--- a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.h
+++ b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.h
@@ -36,9 +36,9 @@ _Static_assert(env_max_stored_ha_percpu <= MAX_HA_ENV_LEN, "Not enough slots");
 #define HA_CLK_NS
 
 struct automaton_ha_percpu {
-	char *state_names[state_max_ha_percpu];
-	char *event_names[event_max_ha_percpu];
-	char *env_names[env_max_ha_percpu];
+	const char *state_names[state_max_ha_percpu];
+	const char *event_names[event_max_ha_percpu];
+	const char *env_names[env_max_ha_percpu];
 	unsigned char function[state_max_ha_percpu][event_max_ha_percpu];
 	unsigned char initial_state;
 	bool final_states[state_max_ha_percpu];
diff --git a/tools/verification/rvgen/tests/golden/test_da/test_da.h b/tools/verification/rvgen/tests/golden/test_da/test_da.h
index d55795efbb61..d4a230a1173d 100644
--- a/tools/verification/rvgen/tests/golden/test_da/test_da.h
+++ b/tools/verification/rvgen/tests/golden/test_da/test_da.h
@@ -22,8 +22,8 @@ enum events_test_da {
 };
 
 struct automaton_test_da {
-	char *state_names[state_max_test_da];
-	char *event_names[event_max_test_da];
+	const char *state_names[state_max_test_da];
+	const char *event_names[event_max_test_da];
 	unsigned char function[state_max_test_da][event_max_test_da];
 	unsigned char initial_state;
 	bool final_states[state_max_test_da];
diff --git a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h
index 290a9454caa4..ef98895fac1b 100644
--- a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h
+++ b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit.h
@@ -22,8 +22,8 @@ enum events_test_da_kunit {
 };
 
 struct automaton_test_da_kunit {
-	char *state_names[state_max_test_da_kunit];
-	char *event_names[event_max_test_da_kunit];
+	const char *state_names[state_max_test_da_kunit];
+	const char *event_names[event_max_test_da_kunit];
 	unsigned char function[state_max_test_da_kunit][event_max_test_da_kunit];
 	unsigned char initial_state;
 	bool final_states[state_max_test_da_kunit];
diff --git a/tools/verification/rvgen/tests/golden/test_ha/test_ha.h b/tools/verification/rvgen/tests/golden/test_ha/test_ha.h
index 949fa4453403..eb90c0600a69 100644
--- a/tools/verification/rvgen/tests/golden/test_ha/test_ha.h
+++ b/tools/verification/rvgen/tests/golden/test_ha/test_ha.h
@@ -36,9 +36,9 @@ _Static_assert(env_max_stored_test_ha <= MAX_HA_ENV_LEN, "Not enough slots");
 #define HA_CLK_NS
 
 struct automaton_test_ha {
-	char *state_names[state_max_test_ha];
-	char *event_names[event_max_test_ha];
-	char *env_names[env_max_test_ha];
+	const char *state_names[state_max_test_ha];
+	const char *event_names[event_max_test_ha];
+	const char *env_names[env_max_test_ha];
 	unsigned char function[state_max_test_ha][event_max_test_ha];
 	unsigned char initial_state;
 	bool final_states[state_max_test_ha];
diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h
index 5c428f818bdf..153533e5d47a 100644
--- a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h
+++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit.h
@@ -36,9 +36,9 @@ _Static_assert(env_max_stored_test_ha_kunit <= MAX_HA_ENV_LEN, "Not enough slots
 #define HA_CLK_NS
 
 struct automaton_test_ha_kunit {
-	char *state_names[state_max_test_ha_kunit];
-	char *event_names[event_max_test_ha_kunit];
-	char *env_names[env_max_test_ha_kunit];
+	const char *state_names[state_max_test_ha_kunit];
+	const char *event_names[event_max_test_ha_kunit];
+	const char *env_names[env_max_test_ha_kunit];
 	unsigned char function[state_max_test_ha_kunit][event_max_test_ha_kunit];
 	unsigned char initial_state;
 	bool final_states[state_max_test_ha_kunit];
-- 
2.56.1

