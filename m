Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675F496D50;
	Tue, 13 Oct 2026 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871935; cv=none; b=H48Vx4wZqKEeBPg5OEmhJmZvlOWXaVyKAQAKhCWjbt5xoiw+g885ZsgdP+E/P8lm5PgN1Kw8roTw6VpFoqzEC9nOuESNB00gMWo8Mqhnt7EHs0aUhfSwCVtSUOePqi+T0twV2vA7Nb+KRNpQmWJmei6T/O5eI6Sy48+/a0ulPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871935; c=relaxed/simple;
	bh=OcklgfN6+iH58QEPF1QtOz+aJDX6ub8vvNErqZCPGQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bq1Sjvz+1+N+KablNOieplxJ7fkFT4QNjAHbs2rcQPxKlZwjUyDvELjNSwpZQaF7rzJmU1ckOQxdzhybrRz/6euvXMl9/BWlYKqlxi8tKiUuM+4KIxyRnM3iEykfT4+3F22j+pt7ChDicED/0e8joMC6vfutUkUaFaYzgSIGRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceKHu7bT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5drMN9du; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceKHu7bT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5drMN9du"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791871927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UWT0gM8Dme1ASvlCUTF41jYvDbeGJH4dFMNy4dRBXM=;
	b=ceKHu7bToARk9x1EPVk2gcVZLvpK/ok8vJ0TMzM+4M/f94QBm+YFI01qGR94PxM0WGrDWA
	tEAAqw3/cA2xz44Ndm0MVlKqxjEqZ96xUIoQSlDwu5ZwriVkOdBBKg/dquJ1E9yxTm8ftd
	uvcvHHML9QWbPYv2vB8ILZkch99u+o6RsadsFwQSP/LSWo0sFW/qAM9VD2YeMlwwSCNRBm
	qEvhAofL8CoDrVluu3ZuZDyIa8YQPBnvhIN3u07j/pZWoq9KEYU2b0ruPL/hCoB4MOel8m
	Kg6Lju+BL0YhThqzzNpTP82pYXDtTmYoVxp2Wa9XIJMYX26EtnrYfsuHdSSiJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791871927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UWT0gM8Dme1ASvlCUTF41jYvDbeGJH4dFMNy4dRBXM=;
	b=5drMN9duayjsNAnYh8JzvAm40UuPTSb0EOta2NjwedWbpkRBPixJLW2+U3oeSFkfHuHH5Z
	tUzYbDj9xYwWZCDQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang
 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 04/15] rv: Cast result of model_get_*_name()
In-Reply-To: <20261001152042.124445-5-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-5-gmonaco@redhat.com>
Date: Tue, 13 Oct 2026 08:14:47 +0200
Message-ID: <87jynmgm94.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Functions like model_get_event_name() and model_get_state_name() are
> shared with BPF monitors, however those programs don't play nice with
> string pointers without fixed length and the event_name and state_name
> arrays need to be defined differently. This gets the compiler to notice
> those are const char and the above function discard the const qualifier.
>
> Drop the warning by casting the result to (char *). Note, a cleaner
> solution would require to modify all callers, but that would require
> changing every single monitor's tracepoint and the advantage is minimal.

I prefer the cleaner solution. Just mass replace "char *" with
"const char *", and manually fix up a few errors and we are done.

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
diff --git a/kernel/trace/rv/monitors/nomiss/nomiss_trace.h b/kernel/trace/rv/monitors/nomiss/nomiss_trace.h
index 42e7efaca4e7..8ad43b6dde6a 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss_trace.h
+++ b/kernel/trace/rv/monitors/nomiss/nomiss_trace.h
@@ -6,14 +6,14 @@
 
 #ifdef CONFIG_RV_MON_NOMISS
 DEFINE_EVENT(event_da_monitor_id, event_nomiss,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(int id, const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(id, state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor_id, error_nomiss,
-	     TP_PROTO(int id, char *state, char *event),
+	     TP_PROTO(int id, const char *state, const char *event),
 	     TP_ARGS(id, state, event));
 
 DEFINE_EVENT(error_env_da_monitor_id, error_env_nomiss,
-	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_PROTO(int id, const char *state, const char *event, const char *env),
 	     TP_ARGS(id, state, event, env));
 #endif /* CONFIG_RV_MON_NOMISS */
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
diff --git a/kernel/trace/rv/monitors/nrp/nrp_trace.h b/kernel/trace/rv/monitors/nrp/nrp_trace.h
index 2e13497de3b6..bcdb44c8e1fa 100644
--- a/kernel/trace/rv/monitors/nrp/nrp_trace.h
+++ b/kernel/trace/rv/monitors/nrp/nrp_trace.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_RV_MON_NRP
 DEFINE_EVENT(event_da_monitor_id, event_nrp,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(int id, const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(id, state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor_id, error_nrp,
-	     TP_PROTO(int id, char *state, char *event),
+	     TP_PROTO(int id, const char *state, const char *event),
 	     TP_ARGS(id, state, event));
 #endif /* CONFIG_RV_MON_NRP */
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
diff --git a/kernel/trace/rv/monitors/opid/opid_trace.h b/kernel/trace/rv/monitors/opid/opid_trace.h
index b04005b64208..daca1f4a1cd6 100644
--- a/kernel/trace/rv/monitors/opid/opid_trace.h
+++ b/kernel/trace/rv/monitors/opid/opid_trace.h
@@ -6,14 +6,14 @@
 
 #ifdef CONFIG_RV_MON_OPID
 DEFINE_EVENT(event_da_monitor, event_opid,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor, error_opid,
-	     TP_PROTO(char *state, char *event),
+	     TP_PROTO(const char *state, const char *event),
 	     TP_ARGS(state, event));
 
 DEFINE_EVENT(error_env_da_monitor, error_env_opid,
-	     TP_PROTO(char *state, char *event, char *env),
+	     TP_PROTO(const char *state, const char *event, const char *env),
 	     TP_ARGS(state, event, env));
 #endif /* CONFIG_RV_MON_OPID */
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault_trace.h b/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
index fe1f82597b1a..cd0915a42c85 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
+++ b/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_RV_MON_PAGEFAULT
 DEFINE_EVENT(event_ltl_monitor_id, event_pagefault,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+	     TP_PROTO(struct task_struct *task, const char *states, const char *atoms, const char *next),
 	     TP_ARGS(task, states, atoms, next));
 DEFINE_EVENT(error_ltl_monitor_id, error_pagefault,
 	     TP_PROTO(struct task_struct *task),
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
diff --git a/kernel/trace/rv/monitors/sco/sco_trace.h b/kernel/trace/rv/monitors/sco/sco_trace.h
index b711cd9024ec..99bc63873f4a 100644
--- a/kernel/trace/rv/monitors/sco/sco_trace.h
+++ b/kernel/trace/rv/monitors/sco/sco_trace.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_RV_MON_SCO
 DEFINE_EVENT(event_da_monitor, event_sco,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor, error_sco,
-	     TP_PROTO(char *state, char *event),
+	     TP_PROTO(const char *state, const char *event),
 	     TP_ARGS(state, event));
 #endif /* CONFIG_RV_MON_SCO */
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
diff --git a/kernel/trace/rv/monitors/scpd/scpd_trace.h b/kernel/trace/rv/monitors/scpd/scpd_trace.h
index 6b0f4aa4732e..d9013db67f94 100644
--- a/kernel/trace/rv/monitors/scpd/scpd_trace.h
+++ b/kernel/trace/rv/monitors/scpd/scpd_trace.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_RV_MON_SCPD
 DEFINE_EVENT(event_da_monitor, event_scpd,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor, error_scpd,
-	     TP_PROTO(char *state, char *event),
+	     TP_PROTO(const char *state, const char *event),
 	     TP_ARGS(state, event));
 #endif /* CONFIG_RV_MON_SCPD */
diff --git a/kernel/trace/rv/monitors/sleep/sleep_trace.h b/kernel/trace/rv/monitors/sleep/sleep_trace.h
index 22eaf31da987..446c30c3af36 100644
--- a/kernel/trace/rv/monitors/sleep/sleep_trace.h
+++ b/kernel/trace/rv/monitors/sleep/sleep_trace.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_RV_MON_SLEEP
 DEFINE_EVENT(event_ltl_monitor_id, event_sleep,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+	     TP_PROTO(struct task_struct *task, const char *states, const char *atoms, const char *next),
 	     TP_ARGS(task, states, atoms, next));
 DEFINE_EVENT(error_ltl_monitor_id, error_sleep,
 	     TP_PROTO(struct task_struct *task),
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
diff --git a/kernel/trace/rv/monitors/snep/snep_trace.h b/kernel/trace/rv/monitors/snep/snep_trace.h
index 01aad49a949a..d758882e7607 100644
--- a/kernel/trace/rv/monitors/snep/snep_trace.h
+++ b/kernel/trace/rv/monitors/snep/snep_trace.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_RV_MON_SNEP
 DEFINE_EVENT(event_da_monitor, event_snep,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor, error_snep,
-	     TP_PROTO(char *state, char *event),
+	     TP_PROTO(const char *state, const char *event),
 	     TP_ARGS(state, event));
 #endif /* CONFIG_RV_MON_SNEP */
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
diff --git a/kernel/trace/rv/monitors/snroc/snroc_trace.h b/kernel/trace/rv/monitors/snroc/snroc_trace.h
index 50114cef5122..aa9162a2d34d 100644
--- a/kernel/trace/rv/monitors/snroc/snroc_trace.h
+++ b/kernel/trace/rv/monitors/snroc/snroc_trace.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_RV_MON_SNROC
 DEFINE_EVENT(event_da_monitor_id, event_snroc,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(int id, const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(id, state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor_id, error_snroc,
-	     TP_PROTO(int id, char *state, char *event),
+	     TP_PROTO(int id, const char *state, const char *event),
 	     TP_ARGS(id, state, event));
 #endif /* CONFIG_RV_MON_SNROC */
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
diff --git a/kernel/trace/rv/monitors/sssw/sssw_trace.h b/kernel/trace/rv/monitors/sssw/sssw_trace.h
index 6c03cfc6960b..14d22f793a07 100644
--- a/kernel/trace/rv/monitors/sssw/sssw_trace.h
+++ b/kernel/trace/rv/monitors/sssw/sssw_trace.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_RV_MON_SSSW
 DEFINE_EVENT(event_da_monitor_id, event_sssw,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(int id, const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(id, state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor_id, error_sssw,
-	     TP_PROTO(int id, char *state, char *event),
+	     TP_PROTO(int id, const char *state, const char *event),
 	     TP_ARGS(id, state, event));
 #endif /* CONFIG_RV_MON_SSSW */
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
diff --git a/kernel/trace/rv/monitors/stall/stall_trace.h b/kernel/trace/rv/monitors/stall/stall_trace.h
index 6a7cc1b1d040..30896932a91c 100644
--- a/kernel/trace/rv/monitors/stall/stall_trace.h
+++ b/kernel/trace/rv/monitors/stall/stall_trace.h
@@ -6,14 +6,14 @@
 
 #ifdef CONFIG_RV_MON_STALL
 DEFINE_EVENT(event_da_monitor_id, event_stall,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(int id, const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(id, state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor_id, error_stall,
-	     TP_PROTO(int id, char *state, char *event),
+	     TP_PROTO(int id, const char *state, const char *event),
 	     TP_ARGS(id, state, event));
 
 DEFINE_EVENT(error_env_da_monitor_id, error_env_stall,
-	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_PROTO(int id, const char *state, const char *event, const char *env),
 	     TP_ARGS(id, state, event, env));
 #endif /* CONFIG_RV_MON_STALL */
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
diff --git a/kernel/trace/rv/monitors/sts/sts_trace.h b/kernel/trace/rv/monitors/sts/sts_trace.h
index d78beb58d5b3..61e8e414627d 100644
--- a/kernel/trace/rv/monitors/sts/sts_trace.h
+++ b/kernel/trace/rv/monitors/sts/sts_trace.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_RV_MON_STS
 DEFINE_EVENT(event_da_monitor, event_sts,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor, error_sts,
-	     TP_PROTO(char *state, char *event),
+	     TP_PROTO(const char *state, const char *event),
 	     TP_ARGS(state, event));
 #endif /* CONFIG_RV_MON_STS */
diff --git a/kernel/trace/rv/monitors/wakeup/wakeup_trace.h b/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
index 7e056183f920..79bfaf91c912 100644
--- a/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
+++ b/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_RV_MON_WAKEUP
 DEFINE_EVENT(event_ltl_monitor_id, event_wakeup,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+	     TP_PROTO(struct task_struct *task, const char *states, const char *atoms, const char *next),
 	     TP_ARGS(task, states, atoms, next));
 DEFINE_EVENT(error_ltl_monitor_id, error_wakeup,
 	     TP_PROTO(struct task_struct *task),
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
diff --git a/kernel/trace/rv/monitors/wip/wip_trace.h b/kernel/trace/rv/monitors/wip/wip_trace.h
index aa2162f47a4c..99cf368a4b03 100644
--- a/kernel/trace/rv/monitors/wip/wip_trace.h
+++ b/kernel/trace/rv/monitors/wip/wip_trace.h
@@ -6,10 +6,10 @@
 
 #ifdef CONFIG_RV_MON_WIP
 DEFINE_EVENT(event_da_monitor, event_wip,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor, error_wip,
-	     TP_PROTO(char *state, char *event),
+	     TP_PROTO(const char *state, const char *event),
 	     TP_ARGS(state, event));
 #endif /* CONFIG_RV_MON_WIP */
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
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr_trace.h b/kernel/trace/rv/monitors/wwnr/wwnr_trace.h
index fc97ec7476ad..c36c8935dce5 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr_trace.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr_trace.h
@@ -7,10 +7,10 @@
 #ifdef CONFIG_RV_MON_WWNR
 /* id is the pid of the task */
 DEFINE_EVENT(event_da_monitor_id, event_wwnr,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_PROTO(int id, const char *state, const char *event, const char *next_state, bool final_state),
 	     TP_ARGS(id, state, event, next_state, final_state));
 
 DEFINE_EVENT(error_da_monitor_id, error_wwnr,
-	     TP_PROTO(int id, char *state, char *event),
+	     TP_PROTO(int id, const char *state, const char *event),
 	     TP_ARGS(id, state, event));
 #endif /* CONFIG_RV_MON_WWNR */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 3ad11195e664..e70ae29da268 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -21,7 +21,7 @@
 static struct rv_kunit_ctx *active_ctx;
 
 __printf(1, 0)
-static void rv_kunit_mock_react(const char *msg, va_list args)
+static void rv_kunit_mock_react(const const char *msg, va_list args)
 {
 	if (active_ctx)
 		++active_ctx->reactions;
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2f5fc8d18dea..538fd0d70fc7 100644
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
index 2f8a932432c9..a756c7d11755 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -11,7 +11,7 @@
 #ifdef CONFIG_DA_MON_EVENTS_IMPLICIT
 DECLARE_EVENT_CLASS(event_da_monitor,
 
-	TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	TP_PROTO(const char *state, const char *event, const char *next_state, bool final_state),
 
 	TP_ARGS(state, event, next_state, final_state),
 
@@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(event_da_monitor,
 
 DECLARE_EVENT_CLASS(error_da_monitor,
 
-	TP_PROTO(char *state, char *event),
+	TP_PROTO(const char *state, const char *event),
 
 	TP_ARGS(state, event),
 
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 /* For simplicity this class is marked as DA although relevant only for HA */
 DECLARE_EVENT_CLASS(error_env_da_monitor,
 
-	TP_PROTO(char *state, char *event, char *env),
+	TP_PROTO(const char *state, const char *event, const char *env),
 
 	TP_ARGS(state, event, env),
 
@@ -100,7 +100,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor,
 #ifdef CONFIG_DA_MON_EVENTS_ID
 DECLARE_EVENT_CLASS(event_da_monitor_id,
 
-	TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	TP_PROTO(int id, const char *state, const char *event, const char *next_state, bool final_state),
 
 	TP_ARGS(id, state, event, next_state, final_state),
 
@@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(event_da_monitor_id,
 
 DECLARE_EVENT_CLASS(error_da_monitor_id,
 
-	TP_PROTO(int id, char *state, char *event),
+	TP_PROTO(int id, const char *state, const char *event),
 
 	TP_ARGS(id, state, event),
 
@@ -162,7 +162,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 /* For simplicity this class is marked as DA although relevant only for HA */
 DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
-	TP_PROTO(int id, char *state, char *event, char *env),
+	TP_PROTO(int id, const char *state, const char *event, const char *env),
 
 	TP_ARGS(id, state, event, env),
 
@@ -197,7 +197,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 #ifdef CONFIG_LTL_MON_EVENTS_ID
 DECLARE_EVENT_CLASS(event_ltl_monitor_id,
 
-	TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+	TP_PROTO(struct task_struct *task, const char *states, const char *atoms, const char *next),
 
 	TP_ARGS(task, states, atoms, next),
 
@@ -249,7 +249,7 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 /* Tracepoint useful for monitors development, currenly only used in DA */
 TRACE_EVENT(rv_retries_error,
 
-	TP_PROTO(char *name, char *event),
+	TP_PROTO(const char *name, const char *event),
 
 	TP_ARGS(name, event),
 
