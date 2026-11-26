Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698114;
	b=wXMuHE8/MWPH1blJetEvWJ1XFbQMPg9ZPX90WYTCocxq8EOuJREXVNwkTaP2Fj37b72H
	 qJWhBWrrRZLYEeBNypdGmNoivPUDwaBtUuwuEEypPWgjYboGW21Ykj/ULJzczCCwIE5wC
	 9dbySZqGKj7VARSKz7sLT4s/iYVa+sXb3XO30A9IvUqMsG68dHfJPipQBX+XoNhYj3AGC
	 G4sxsobNBJogkeEmwXas9zvr1rQoB1SIkhsdfKcRROyUz1r3gEsV8lSeiavCFCU6gO3vY
	 aiIBYn4lF2Y/6dSlumtKo9/+r7F5VDunPxBtScy7jrdzwVepsiha1xS1Als4jdG0b3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698114;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=94GBFyLqhGymKpb0WzpatnIudNDmY6MT+lr25C957NM=;
	b=XotqzwTJf7UDqFTYwLkfliCAcsSy3xHU09tfqgiOTGbZpZKuDNHzP+IAROJrKTyWijNg
	 e0HdRg7x73APYp7xIDZH5X1gfOrYIiOd7hLa2rwegOH5/7cWjkoJK5cpNjVgPk+Noypw+
	 B7wOon00P55uAmtftcUx7ngJnNHzULM4AOmEc+VHPipsDq/Sdg/X/hu/N7mfp/mrytrKc
	 cTDqnJ8FeCk8jV4FBiwYep9wiIKTj42iRn/1u4G+ctKOuFJULNTO0mNDjYQwr/EVjv0xo
	 OXb11lRn1XkHXwpGxqoob2+3kxkkQTqxsTaL/Da3B6inXrxaS7Gm9j9vyIFxF0y/mpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZqzZfjzT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2E606A335
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58E2E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZqzZfjzT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94GBFyLqhGymKpb0WzpatnIudNDmY6MT+lr25C957NM=;
	b=ZqzZfjzTsoL/BhreCFuXjiP5uvlJzVv6coEb/pMdXkRK0KxovKyEnTcTSuMioLV4fc66eM
	KqQ2jfxZvn2sJJ5J4POaiywNseK4BVB1tYAHl/A3BCvVprLVzQZtnAkBMRFCZAb3yx14KG
	THAMAMpleUhzsLyrIgNNoibIFdr05jM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-WuCDb3g9Md-UsRTbdTsUUA-1; Thu,
 26 Nov 2026 13:01:50 +0000
X-MC-Unique: WuCDb3g9Md-UsRTbdTsUUA-1
X-Mimecast-MFC-AGG-ID: WuCDb3g9Md-UsRTbdTsUUA_1795698108
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B25C1955BC2;
	Thu, 26 Nov 2026 13:01:48 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 090DA1800543;
	Thu, 26 Nov 2026 13:01:44 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 17/18] tools/rv: Add selftest for rv bpf monitors
Date: Thu, 26 Nov 2026 14:00:03 +0100
Message-ID: <20261126130004.127155-18-gmonaco@redhat.com>
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

Add selftest cases for the rv userspace tool BPF monitors, test BPF
monitors listing and functionality, including traces and reactors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/tests/rv_list.t |  6 +-
 tools/verification/rv/tests/rv_mon.t  | 80 +++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/tools/verification/rv/tests/rv_list.t b/tools/verification/rv/tests/rv_list.t
index 201af33a52cc..9eae5c3c6eba 100644
--- a/tools/verification/rv/tests/rv_list.t
+++ b/tools/verification/rv/tests/rv_list.t
@@ -6,6 +6,8 @@ test_begin
 set_timeout 30s
 
 RVDIR=/sys/kernel/tracing/rv/
+# only works when running in the kernel tree
+RVTOOL=$(dirname "$RV")
 
 # Help and basic tests
 check "verify help page" \
@@ -17,13 +19,15 @@ check "verify list subcommand help" \
 all_nested=$(grep : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
 all_non_nested=$(grep -v : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
 sched_monitors=$(grep sched: $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
+all_bpf=$(find "$RVTOOL/bpf_monitors" -name "*.o" -exec basename \{\} .o \; | paste -s | sed 's/\t/\\|/g')
 description_state="[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\)\]"
 line_nested=" - \($all_nested\)${description_state}"
 line_non_nested="\($all_non_nested\)${description_state}"
+[ -n "$all_bpf" ] && line_bpf="\($all_bpf\)${description_state}" || line_bpf="<empty>"
 
 # List monitors and containers
 check "list all monitors" \
-	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\)$"
+	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\|$line_bpf\)$"
 
 check_if_exists "list container" \
 	"$RV list sched" "$RVDIR/monitors/sched" \
diff --git a/tools/verification/rv/tests/rv_mon.t b/tools/verification/rv/tests/rv_mon.t
index cbc346c74c71..30d1ddaf0538 100644
--- a/tools/verification/rv/tests/rv_mon.t
+++ b/tools/verification/rv/tests/rv_mon.t
@@ -6,6 +6,7 @@ test_begin
 set_timeout 30s
 
 RVDIR=/sys/kernel/tracing/rv/
+RVTOOL=$(dirname "$RV")
 
 # Help and basic tests
 check "verify mon subcommand help" \
@@ -29,7 +30,28 @@ check "monitor name is substring of another monitor" \
 check "already enabled monitor returns error" \
 	"echo 1 > $RVDIR/monitors/wwnr/enable; $RV mon wwnr" 1 \
 	"monitor wwnr (in-kernel) is already enabled"
-echo 0 > $RVDIR/monitors/wwnr/enable
+[ -n "$TEST_COUNT" ] && echo 0 > $RVDIR/monitors/wwnr/enable
+
+fi
+
+if [ -f "$RVTOOL/bpf_monitors/nohz.o" ]; then
+
+check "invalid BPF reactor name" \
+	"$RV mon nohz -r invalid" 1 "failed to set invalid reactor, is it available?"
+
+fi
+
+if [ -f "$RVTOOL/bpf_monitors/tqueue.o" ]; then
+
+[ -n "$TEST_COUNT" ] && { $RV mon tqueue & disown ; tmp=$! ; sleep 1 ; }
+check "already enabled BPF monitor returns error" \
+	"$RV mon tqueue" 1 "monitor tqueue (BPF) is already enabled"
+
+[ -n "$TEST_COUNT" ] && { kill -9 "$tmp" && sleep 1 ; }
+set_expected_timeout 1s
+
+check "crashed BPF monitor does not leak resources" \
+	"$RV mon tqueue" 0 "" "monitor tqueue (BPF) is already enabled"
 
 fi
 
@@ -40,6 +62,12 @@ set_expected_timeout 2s
 check_if_exists "run the monitor without parameters" \
 	"$RV mon wwnr" "$RVDIR/monitors/wwnr" "" "."
 
+check_if_exists "run a BPF monitor without parameters" \
+	"$RV mon nohz" "$RVTOOL/bpf_monitors/nohz.o" "" "."
+
+check_if_exists "run a per-task BPF monitor without parameters" \
+	"$RV mon tqueue" "$RVTOOL/bpf_monitors/tqueue.o" "" "."
+
 check_if_exists "run the monitor as verbose" \
 	"$RV mon wwnr -v" "$RVDIR/monitors/wwnr" \
 	"my pid is \$pid" "\(event\|error\)"
@@ -60,21 +88,32 @@ check_if_exists "run an explicitly nested monitor with a reactor" \
 	"$RV mon sched:sssw -r printk & sleep .5 && cat $RVDIR/monitors/sched/sssw/reactors && wait" \
 	"$RVDIR/monitors/sched/sssw/reactors" "\[printk\]"
 
+TRACE=/sys/kernel/tracing/trace
+
 check_if_exists "run container monitor" \
 	"$RV mon sched & sleep .5 && cat $RVDIR/monitors/sched/{sssw,sco}/enable && wait" \
 	"$RVDIR/monitors/sched" "1" "0" "^1$"
 
 # Regexes for the trace
 header="^[[:space:]]\+\(\([][A-Z_x<>-]\+\||\)[[:space:]]*\)\+$"
-type="\(event\|error\)[[:space:]]\+"
+mon="[a-z_]\+"
+type="\(event\|error\)_$mon"
 genpid="[0-9]\+[[:space:]]\+"
 selfpid="\$pid[[:space:]]\+"
 cpu="\[[0-9]\{3\}\][[:space:]]\+"
 state="[a-z_]\+ "
-trace_task="${genpid}${cpu}${type}${genpid}${state}"
-trace_task_self="${genpid}${cpu}${type}${selfpid}${state}"
-trace_cpu="${genpid}${cpu}${type}${state}"
-trace_cpu_self="${selfpid}${cpu}${type}${state}"
+id="[0-9]\+"
+selfid="\$pid"
+# BPF monitors report via the common rv:event_monitor/rv:error_monitor
+# events, which add a "<mon>: " prefix to the message.
+trace_task="${genpid}${cpu}${type}: ${id}: ${state}"
+trace_task_self="${genpid}${cpu}${type}: ${selfid}: ${state}"
+trace_cpu="${genpid}${cpu}${type}: ${state}"
+trace_cpu_self="${selfpid}${cpu}${type}: ${state}"
+trace_task_bpf="${genpid}${cpu}${type}: ${mon}: ${id}: ${state}"
+trace_task_bpf_self="${genpid}${cpu}${type}: ${mon}: ${selfid}: ${state}"
+trace_cpu_bpf="${genpid}${cpu}${type}: ${mon}: ${state}"
+trace_cpu_bpf_self="${selfpid}${cpu}${type}: ${mon}: ${state}"
 
 check_if_exists "run per-task monitor with tracing" \
 	"$RV mon sssw -t" "$RVDIR/monitors/sched/sssw" \
@@ -92,4 +131,33 @@ check_if_exists "run per-cpu monitor tracing also self" \
 	"$RV mon sco -t -s" "$RVDIR/monitors/sched/sco" \
 	"$trace_cpu_self" "" "\($header\|$trace_cpu\)"
 
+check_if_exists "run per-task BPF monitor with tracing" \
+	"$RV mon tqueue -t" "$RVTOOL/bpf_monitors/tqueue.o" \
+	"$header" "$trace_task_bpf_self" "\($header\|$trace_task_bpf\)"
+
+check_if_exists "run per-task BPF monitor tracing also self" \
+	"$RV mon tqueue -t -s" "$RVTOOL/bpf_monitors/tqueue.o" \
+	"$trace_task_bpf_self" "" "\($header\|$trace_task_bpf\)"
+
+check_if_exists "run per-cpu BPF monitor with tracing" \
+	"$RV mon nohz -t" "$RVTOOL/bpf_monitors/nohz.o" \
+	"$header" "$trace_cpu_bpf_self" "\($header\|$trace_cpu_bpf\)"
+
+# This is unstable, we may never see events from self
+#check_if_exists "run per-cpu BPF monitor tracing also self" \
+#	"$RV mon nohz -t -s" "$RVTOOL/bpf_monitors/nohz.o" \
+#	"$trace_cpu_bpf_self" "" "\($header\|$trace_cpu_bpf\)"
+
+check_if_exists "run per-task monitor tracing only errors" \
+	"$RV mon sssw -t -E" "$RVDIR/monitors/sched/sssw" \
+	"$header" "event_"
+
+check_if_exists "run per-task BPF monitor tracing only errors" \
+	"$RV mon tqueue -t -E" "$RVTOOL/bpf_monitors/tqueue.o" \
+	"$header" "event_monitor"
+
+check_if_exists "run per-cpu BPF monitor tracing only errors" \
+	"$RV mon nohz -t -E" "$RVTOOL/bpf_monitors/nohz.o" \
+	"error_monitor" "event_monitor"
+
 test_end
-- 
2.56.1

