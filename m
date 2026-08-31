Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB994A8438
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188441; cv=none; b=oDkrx6RZ9CvF7KkW0JNMCVf/Pf5M63tL4hRl33fo8URW9hAY9rxfEAEDc/GYjJLnwcfGVV+m6qTVrJe3OUZX6Z3Zrv5HdF3It6QVWkeDT4X9ZMXfst8tNIxiV8vyT9cNGenZ6GflETdvaEdHF9T8aWibMlzrp3d4XWM3hcmW+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188441; c=relaxed/simple;
	bh=9K/6PJaguZoiDf+6wZGGUbNkFvvbD+lozD8PmC2yt9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giEY7Hl32gCP/uoLMWa0hsuEdBYxJdwL+g7XhSkWecvY7BBBFv4R32E51L7Wh24m7JWfV8F7urmT6eIioTMEmDSpueX2aOMS5K4xYBtVkZhhPtpTdH9w/ftuvSnRAgvx8MtyyniRRxWooVSPnhq5fstCIMZwba9v69aG70jN5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqEu4qbu; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqEu4qbu"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66c82b32121so4081006d50.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188439; x=1788793239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HDGtPCx5xovkSN4f72iXHLyepfibwkWfrygjFuBGvns=;
        b=RqEu4qbuUxIWQUo6AUoEiJHxOsfHVpT0UJaRiltMiLwaPIXp+I2B9ODBSxep0nZMXq
         Onh0evcehQ59jb8+vmhkP4tq+1OQte0e8V67QDnhP6pE6DIZJMUB76+XF+EQF6FBSjKO
         uF8zYBSQLEYmXsh4v4N6tFnMcw3AlT9tc4isdMyyuX4Oq4o4Lt3ApLsj0eKMW1yvDXWG
         N33L9VulW0YdVO2FyVx4xzbJRb5clMAocVLqpnxOepzw75ohF0C4biWJ7RX+mRB2Oadc
         EvuhcrU3WiR1kxw0tRPmGSm5z6ytdMNYTtwYfq6v51+kSM6/w9cr6tblQrFCxwaJauJV
         7uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188439; x=1788793239;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDGtPCx5xovkSN4f72iXHLyepfibwkWfrygjFuBGvns=;
        b=WXulBaAIfLQLmeKf4JojNeg5HadcjMGyc3s1Au3787zzzIoZSBsJA1bOHO0zzZw79e
         zqTxmlKIQHQyyqmhA3QXhRmLm8r00Tu3fQPV/Ixr+d0llzT0xDT2f6CRF2eNx9826wQM
         GyHgsfa83Udj+jArRKyOSL8hKL2/IZLOBLA5Hw9459ZSwI8RCy5Sgce6+B6LJwQDZQaZ
         uy6Uy98uvuSWAzAkoNAQYwQGjY+3WLVuQj/ZQVY3M+oUqdovLWXzbN0VI8WNCNoimrSL
         oWOJwv6oApZo2doCZiNY5QnCVmv7Az/3bNhgqJX1hAd5B6C3AHwHRUQThXd85X4SHXQc
         H3zg==
X-Forwarded-Encrypted: i=1; AKwUvBzu1aZGWgOLDYGEdIZ2GcwwmmrVbrEpQ6KMf4FfYpZZu2WVwcFGqqMP8RBiYeoe+bRGOL4=@vger.kernel.org
X-Gm-Message-State: AFuF++nsRz/Ocx0tYFPxjIth03gpPQcXeNJPlPgG8jew0HOxr22RM0ga
	iP7sNisp78d2NTMSYU+ar2WeUTmIf20QDMoEdYEwjpF+gLVt3gbgOAln
X-Gm-Gg: AYBFou2e4kUzxx855jMdVYhDRGzrL7/kp0zEpo/20Zy8+dE8IJgR7xYrGqiAFIK3clm
	0lqzaGYiqnc27cXwfkkqDhjKqglnTboCiiBJpwI/TeppIL5C7nihdtSAjEpB2kilFjEJV5rk5Tv
	3BBnAamQUIdMZAQnirtAb5nWnNQR3kFXOx5ABIY7wDinxyheDmMm6gi1p/VqCj4HwBn5hKRR8Uq
	HJk+j0ERMMAh/9B/fxPS8tOghSP5VqVJqAajYZVQ+hFXDwvg3+94+PiuBpTXS8P/LZiC7Jo0vxq
	/TOXU0bqA+Wt8JSUWMYYCY14VJutxoJTexMDPYQbSuoIOccxgpmH8+uRY3Y2hTCs57nbfxhmQOb
	exiDr2UpnXsNu7/d2+duKnhZy7Gi6hKrUT8vZ5Iu4eP/RMXxeXGl5ICgf09N5LVG3ikyLmr70nu
	tkFrex6gux72yAg6dfEAWOl5EMhDOryUQaoMdIF2gsLwLFlkAvsHO2n7czLlk1qbO8NvKJtjqN0
	RClC/PvWTTbD2jvp4sOhrw=
X-Received: by 2002:a53:d045:0:20b0:66c:c683:5bdb with SMTP id 956f58d0204a3-66e4c78b3b5mr6500975d50.49.1788188438576;
        Mon, 31 Aug 2026 08:00:38 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:38 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 12/15] landlock: Free rulesets after an RCU grace period
Date: Mon, 31 Aug 2026 10:58:54 -0400
Message-ID: <20260831145858.3869191-13-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Defer every ruleset free behind an RCU grace period, and keep the
fields that stay readable while a free is pending out of the union
that overlays the deferred-free work item.

The policy_object_get LSM hook lets a caller holding only an
RCU-protected pointer to a ruleset (e.g. loaded from a BPF map kptr
field under rcu_read_lock()) race a refcount_inc_not_zero() against
the drop of the last reference.  For that to be sound, the ruleset's
memory, and its reference count in particular, must remain valid
until every RCU reader that could still observe the pointer is done:
free the ruleset through queue_rcu_work(), which waits for a grace
period before running the free work.

The work item is overlaid with the fields that no one may touch once
@usage reaches zero: @lock, @quiet_masks and @handled_masks.  @usage
itself stays outside the union so a racing reader observes zero
instead of the work item's bytes, and the tracing fields @version and
@id stay outside too because the landlock_free_ruleset trace event
reads them when the queued work finally runs.

Since queueing the work never sleeps, the might_sleep() annotation
is dropped: a following commit releases ruleset references from
BPF object destructors that cannot sleep.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/ruleset.c | 24 ++++++++++++++---
 security/landlock/ruleset.h | 54 ++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 0d07707523cd..00a6b9938fd1 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -21,6 +21,7 @@
 #include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
@@ -346,9 +347,26 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
 	kfree(ruleset);
 }
 
+static void free_ruleset_work(struct work_struct *const work)
+{
+	struct landlock_ruleset *ruleset;
+
+	ruleset = container_of(to_rcu_work(work), struct landlock_ruleset,
+			       work_free);
+	free_ruleset(ruleset);
+}
+
+/*
+ * RCU readers (cf. the policy_object_get LSM hook) may call
+ * refcount_inc_not_zero() on a ruleset they hold no reference to: the memory
+ * must survive a grace period after the last put.  Queueing the free also
+ * makes this callable from contexts that cannot sleep (cf. the
+ * policy_object_put LSM hook).
+ */
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset)
 {
-	might_sleep();
-	if (ruleset && refcount_dec_and_test(&ruleset->usage))
-		free_ruleset(ruleset);
+	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
+		INIT_RCU_WORK(&ruleset->work_free, free_ruleset_work);
+		queue_rcu_work(system_dfl_wq, &ruleset->work_free);
+	}
 }
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index b58e3d9846af..1465f8a5c464 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/workqueue.h>
 
 #include "access.h"
 #include "limits.h"
@@ -157,12 +158,10 @@ struct landlock_ruleset {
 	 */
 	struct landlock_rules rules;
 	/**
-	 * @lock: Protects against concurrent modifications of @rules, if @usage
-	 * is greater than zero.
-	 */
-	struct mutex lock;
-	/**
-	 * @usage: Number of file descriptors referencing this ruleset.
+	 * @usage: Number of file descriptors referencing this ruleset.  Kept
+	 * outside the union with @work_free: RCU readers may still call
+	 * refcount_inc_not_zero() while a queued free waits out the grace
+	 * period.
 	 */
 	refcount_t usage;
 
@@ -175,22 +174,41 @@ struct landlock_ruleset {
 	 */
 	u32 version;
 	/**
-	 * @id: Unique identifier for this ruleset, used for tracing.
+	 * @id: Unique identifier for this ruleset, used for tracing.  Kept
+	 * outside the union with @work_free: the free_ruleset trace event
+	 * reads it after the free has been queued.
 	 */
 	u64 id;
 #endif /* CONFIG_TRACEPOINTS */
 
-	/**
-	 * @quiet_masks: Stores the quiet flags for an unmerged ruleset.  For a
-	 * merged domain, this is stored in each layer's struct
-	 * landlock_hierarchy instead.
-	 */
-	struct access_masks quiet_masks;
-	/**
-	 * @handled_masks: Contains the subset of filesystem and network actions
-	 * that are handled by this ruleset.
-	 */
-	struct access_masks handled_masks;
+	union {
+		/**
+		 * @work_free: Enables to free a ruleset after an RCU grace
+		 * period, within a lockless section.  This is queued by
+		 * landlock_put_ruleset() when @usage reaches zero.  The
+		 * fields @lock, @quiet_masks and @handled_masks are then
+		 * unused.
+		 */
+		struct rcu_work work_free;
+		struct {
+			/**
+			 * @lock: Protects against concurrent modifications of
+			 * @rules, if @usage is greater than zero.
+			 */
+			struct mutex lock;
+			/**
+			 * @quiet_masks: Stores the quiet flags for an unmerged
+			 * ruleset.  For a merged domain, this is stored in each
+			 * layer's struct landlock_hierarchy instead.
+			 */
+			struct access_masks quiet_masks;
+			/**
+			 * @handled_masks: Contains the subset of filesystem and
+			 * network actions that are handled by this ruleset.
+			 */
+			struct access_masks handled_masks;
+		};
+	};
 };
 
 struct landlock_ruleset *
-- 
2.55.0

