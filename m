Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EE377574;
	Mon,  3 Aug 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753468; cv=none; b=hltN6ChqietiWZhV8mAV8uhkQoB6vT4PADdTSKNiUbN4G1WW3H1YucOARG96YCoAnsO9OJyBNRQg9ph1dridpc5hqD9fni/R1aY3ivrwOnlMiyhyAwrgSFUbkxPpNjQGfUUUWMkn/eA0kOlZ4gvMZvrDaWZBGdnJVWWpdrxZ+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753468; c=relaxed/simple;
	bh=D5Fcglo7FwS6EWzNqZc1s5F69IZCgRjUhsnK00NcAQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VHFXSKPDLf/GNtQJBnl5JWTAuJKQkTmYR2DMkSH8R2RFv+wMr71KCLjTTvmypHDZBcHsNeUXA6lsmy386vB1bT8pC8oupagv5mkUuw44vPaXKj1dvAr6QyeSaHlBVpWWI4BTdi+guCbDlfGgnY454FyNasb9Mu52EFMWs2bzKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ1R+oM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ1R+oM3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A81FFC2BCB9;
	Mon,  3 Aug 2026 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785753467;
	bh=D5Fcglo7FwS6EWzNqZc1s5F69IZCgRjUhsnK00NcAQY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kQ1R+oM3Lyab5V3dlnORsP/ZGimsGI6QojpAcPs90rxJRF5hH5IgTDtS6kQ1qpdgm
	 KIrkH9KEh9VySvTwEQK0Tq1Na8PU5IrL7tiar0BijJWT4FAvUTfdT+9//qCd/pngor
	 qXNDxGZu4aTyGpzO8xRC1EU3bu5+aqxGjo1i5QkgAiHuOYbtGwwEhZmZZvUcgOGA/f
	 Zo50py8hwIK2e7aHXR+58fnBl/WAYU738qux4g5WmofkIBrcaEPuvZ3az0PoKxSfVD
	 X3FXoTUGQ4ra+Z5/bH7o5nxSvTcN4n99AHA7rXhUFFz/7yni9hSiussnqMgX7sJsWY
	 FgHnCx9jUGGiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6E9C55196;
	Mon,  3 Aug 2026 10:37:47 +0000 (UTC)
From: quanyeyang via B4 Relay <devnull+quanyemostima.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 18:37:45 +0800
Subject: [PATCH] bpf: disable lockdep while running BPF on lock_release
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQoCIRRFf2V46x6YhlS/Ei0c51qvQkWdCIb59
 2xangP33IUqiqDSeVio4C1VUuyw3w3k7y7ewDJ1Jq20VUdlOMiHX8k/uRXnkZPExmMOm5uQOZw
 MjIaz5mCpV3JBn2wPl+uf6zw+4NsvS+v6BcS55mGDAAAA
X-Change-ID: 20260803-fix-lock-tracepoint-bpf-lockdep-f93e32ea6346
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, NeilBrown <neilb@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com, 
 quanyeyang <quanyemostima@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785753465; l=5960;
 i=quanyemostima@gmail.com; s=20260801; h=from:subject:message-id;
 bh=59e0ifW+sGTGcEX8QsHM79W5EIbcnLojZwFB3NuD+hg=;
 b=H9JQ1DDWqpCHrNNQMhoW+/N5WzRz6e6FP3sScJiWpy0LAEM9f5Ioq1Se3uJxwZhG13o01Azns
 YK5WTody7VxB5JQU06Fk5XygJOAY0N4RjbgwN3JjQroXRaLTxKeu3FQ
X-Developer-Key: i=quanyemostima@gmail.com; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyemostima@gmail.com/20260801 with
 auth_id=905
X-Original-From: quanyeyang <quanyemostima@gmail.com>
Reply-To: quanyemostima@gmail.com

From: quanyeyang <quanyemostima@gmail.com>

trace_lock_release() runs before __lock_release(), so the lock is
still on the held stack when attached BPF programs execute.  If those
programs take another lock of the same class, lockdep reports a false
recursive locking warning.

Mark lock_release with TRACE_EVENT_FL_BPF_NO_LOCKDEP and temporarily
disable lockdep around bpf_prog_run_array() for that event.

Fixes: 149212f07856 ("rhashtable: add lockdep tracking to bucket bit-spin-locks.")
Reported-by: syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ef8d17bae14efb960935
Assisted-by: Cursor:GPT-5.6 Sol
Signed-off-by: quanyeyang <quanyemostima@gmail.com>
---
Hi,

Small RFC to align on the approach before widening scope. This is the
alternative to the rhashtable per-init-site lock-class patch [1], taking
the direction NeilBrown floated in that thread [2].

The problem: trace_lock_release() runs before __lock_release(), so the
lock is still on lockdep's held stack when an attached BPF program runs.
If that program takes another lock whose class collides with a held
lock, lockdep reports a false "possible recursive locking".

syzbot hits this via pidfs + a BPF hash map, because all rhashtable
bucket locks share one lock_class:

  copy_process -> alloc_pid -> pidfs_add_pid   [pidfs bucket bitlock held]
    lock_release tracepoint
      trace_call_bpf -> bpf_prog_run_array
        rhtab_map_delete_elem -> rhashtable_remove_fast -> rht_lock
          [same "rhashtable_bucket" class -> false recursion]

Why I pivoted from the per-class rhashtable fix: NeilBrown argued (a)
sharing one lock_class across instances is common practice (d_lock,
bd_holder_lock, kobject list_lock), and (b) BPF on lock_release() can
perturb lockdep for *any* lock the program takes, not only rhashtable
[2]. Disabling lockdep around the BPF handler addresses that broader
surface, not just rhashtable.

On the concern that this hides real lock-order bugs: BPF programs are
user-supplied, sandboxed code; their internal lock ordering is not part
of the kernel's lock contract, and lockdep cannot validate it
meaningfully -- here it only produces a false positive.

Scope of this patch (deliberately minimal):
  - only lock_release is tagged;
  - only the perf-event attach path (trace_call_bpf) is covered.

Open questions I'd like to align on before doing more:
  - lock_acquire can produce a (different, ABBA-shaped) false positive
    by the same mechanism -- tag it too?
  - raw_tracepoint attaches go through __bpf_trace_run and are not
    covered -- extend there too?
  - flag vs always-off: should trace_call_bpf disable lockdep for all
    BPF programs? The flag keeps blast radius small, but the rationale
    applies generally.

This fixes the reported syzbot path (perf-event attach to lock_release).

[1]  https://lore.kernel.org/all/20260801-fix-rhashtable-bucket-lockdep-v1-1-15a0f8ae094c@gmail.com/
[2]  https://lore.kernel.org/r/178572243204.3252194.4367547703856027885@noble.neil.brown.name
---
 include/linux/trace_events.h | 3 +++
 include/trace/events/lock.h  | 2 ++
 kernel/trace/bpf_trace.c     | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 308c76b57d13..6f67b5e9e38d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -330,6 +330,7 @@ enum {
 	TRACE_EVENT_FL_FPROBE_BIT,
 	TRACE_EVENT_FL_CUSTOM_BIT,
 	TRACE_EVENT_FL_TEST_STR_BIT,
+	TRACE_EVENT_FL_BPF_NO_LOCKDEP_BIT,
 };
 
 /*
@@ -347,6 +348,7 @@ enum {
  *                   This is set when the custom event has not been attached
  *                   to a tracepoint yet, then it is cleared when it is.
  *  TEST_STR      - The event has a "%s" that points to a string outside the event
+ *  BPF_NO_LOCKDEP - Disable lockdep while running attached BPF programs
  */
 enum {
 	TRACE_EVENT_FL_CAP_ANY		= (1 << TRACE_EVENT_FL_CAP_ANY_BIT),
@@ -360,6 +362,7 @@ enum {
 	TRACE_EVENT_FL_FPROBE		= (1 << TRACE_EVENT_FL_FPROBE_BIT),
 	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
 	TRACE_EVENT_FL_TEST_STR		= (1 << TRACE_EVENT_FL_TEST_STR_BIT),
+	TRACE_EVENT_FL_BPF_NO_LOCKDEP	= (1 << TRACE_EVENT_FL_BPF_NO_LOCKDEP_BIT),
 };
 
 #define TRACE_EVENT_FL_UKPROBE (TRACE_EVENT_FL_KPROBE | TRACE_EVENT_FL_UPROBE)
diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 1ded869cd619..5ccf5c54e3d2 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -72,6 +72,8 @@ DEFINE_EVENT(lock, lock_release,
 	TP_ARGS(lock, ip)
 );
 
+TRACE_EVENT_FLAGS(lock_release, TRACE_EVENT_FL_BPF_NO_LOCKDEP);
+
 #ifdef CONFIG_LOCK_STAT
 
 DEFINE_EVENT(lock, lock_contended,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75495a5c3507..f2460f3c860e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -24,6 +24,7 @@
 #include <linux/key.h>
 #include <linux/namei.h>
 #include <linux/file.h>
+#include <linux/lockdep.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -110,6 +111,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
  */
 unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
+	bool no_lockdep = call->flags & TRACE_EVENT_FL_BPF_NO_LOCKDEP;
 	unsigned int ret;
 
 	cant_sleep();
@@ -144,8 +146,12 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	 * rcu_dereference() which is accepted risk.
 	 */
 	rcu_read_lock();
+	if (no_lockdep)
+		lockdep_off();
 	ret = bpf_prog_run_array(rcu_dereference(call->prog_array),
 				 ctx, bpf_prog_run);
+	if (no_lockdep)
+		lockdep_on();
 	rcu_read_unlock();
 
  out:

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260803-fix-lock-tracepoint-bpf-lockdep-f93e32ea6346

Best regards,
--  
quanyeyang <quanyemostima@gmail.com>


