Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B043DA5AB
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167236; cv=none; b=g11Le26psx4ujMo6bo24r071lhKLN3gm2gL3ycuscfTULQ08oZcbeEuJNxPtYAeJWPdrbpQwy5XJ258Je3QIRKDfpEt5l7+4iAFKYM3dOEU4xPnKcI89tgcY66ocdw8sJRfQJsCBPfjVzUeSJBS0A/VfljbpFgbpUtZzSJRSQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167236; c=relaxed/simple;
	bh=xN80Pfs67HCbw+oDmc7ZViSyGz9ljql1b1gK0ht12no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2kt1luuM6Znv9MiI283+AbkutDaXn7hyp0Cz8kqmIE+qCVR6wpgjMFCeashFIdx78fFPnn+6g6TYOdqaviBkgxpGfEBaPRvsYae/qMq98V5pndRtW4Q75sa279h8XT7LbMyHNYsLOOKFaNN8nvgBlEDlrAAEnvbyGvUz+MSUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewN1rj8A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewN1rj8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9nODF3ao4BoTMuSTnZHD2rQJuc0s627BBlq9bQmlc8=;
	b=ewN1rj8Ar0/b5PBvI8VCqktPD9TpeiVoD0EuotL3dCRsyXf8sU87UKmmL4CjkCBhgmZvG/
	L1dRSjMwfQ8o7ZSsLmSqTOcPmXY6hETZbAoJkFUno2wUCD6NBCBZknOE6u+PcK2Xuoq9Py
	Qqp7rDlOHtpbiqIj7jbrUG3LY/fP6EY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-XgWx3pW2NR2sPHVbt1Fasg-1; Mon,
 31 Aug 2026 05:07:08 -0400
X-MC-Unique: XgWx3pW2NR2sPHVbt1Fasg-1
X-Mimecast-MFC-AGG-ID: XgWx3pW2NR2sPHVbt1Fasg_1788167226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2D671977536;
	Mon, 31 Aug 2026 09:07:06 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE602180034F;
	Mon, 31 Aug 2026 09:07:03 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 03/20] rv: Refactor da_trace() functions to get strings internally
Date: Mon, 31 Aug 2026 11:05:07 +0200
Message-ID: <20260831090524.106845-4-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The da_trace_event() and da_trace_error() functions are currently called
with strings and the callers are converting the state/event enums to the
corresponding string representation.
This is unnecessary and is problematic if an alternative implementation
is needed (e.g. BPF without using strings).

Change the functions to accept enums and pass the string representations
to the tracepoints only internally.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 6fc5ef8142ac..7f0bdfd7cce3 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -633,19 +633,22 @@ static inline void da_monitor_destroy(void)
  */
 
 static inline void da_trace_event(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
-				  char *next_state, bool is_final,
+				  enum states curr_state, enum events event,
+				  enum states next_state,
 				  da_id_type id)
 {
-	CONCATENATE(trace_event_, MONITOR_NAME)(curr_state, event, next_state,
-						is_final);
+	CONCATENATE(trace_event_, MONITOR_NAME)(model_get_state_name(curr_state),
+						model_get_event_name(event),
+						model_get_state_name(next_state),
+						model_is_final_state(next_state));
 }
 
 static inline void da_trace_error(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
+				  enum states curr_state, enum events event,
 				  da_id_type id)
 {
-	CONCATENATE(trace_error_, MONITOR_NAME)(curr_state, event);
+	CONCATENATE(trace_error_, MONITOR_NAME)(model_get_state_name(curr_state),
+						model_get_event_name(event));
 }
 
 /*
@@ -662,19 +665,24 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
  */
 
 static inline void da_trace_event(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
-				  char *next_state, bool is_final,
+				  enum states curr_state, enum events event,
+				  enum states next_state,
 				  da_id_type id)
 {
-	CONCATENATE(trace_event_, MONITOR_NAME)(id, curr_state, event,
-						next_state, is_final);
+	CONCATENATE(trace_event_, MONITOR_NAME)(id,
+						model_get_state_name(curr_state),
+						model_get_event_name(event),
+						model_get_state_name(next_state),
+						model_is_final_state(next_state));
 }
 
 static inline void da_trace_error(struct da_monitor *da_mon,
-				  char *curr_state, char *event,
+				  enum states curr_state, enum events event,
 				  da_id_type id)
 {
-	CONCATENATE(trace_error_, MONITOR_NAME)(id, curr_state, event);
+	CONCATENATE(trace_error_, MONITOR_NAME)(id,
+						model_get_state_name(curr_state),
+						model_get_event_name(event));
 }
 #endif /* RV_MON_TYPE */
 
@@ -695,17 +703,13 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_
 		next_state = model_get_next_state(curr_state, event);
 		if (next_state == INVALID_STATE) {
 			react(curr_state, event);
-			da_trace_error(da_mon, model_get_state_name(curr_state),
-				       model_get_event_name(event), id);
+			da_trace_error(da_mon, curr_state, event, id);
 			return false;
 		}
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
 			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
 				return false;
-			da_trace_event(da_mon, model_get_state_name(curr_state),
-				       model_get_event_name(event),
-				       model_get_state_name(next_state),
-				       model_is_final_state(next_state), id);
+			da_trace_event(da_mon, curr_state, event, next_state, id);
 			return true;
 		}
 	}
-- 
2.55.0

