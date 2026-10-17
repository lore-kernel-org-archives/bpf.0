Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C033F8AD
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200299; cv=none; b=C0kBktcyciFejv1leQmYws1swl/EfSfF8xap5lMA7r9Ord4ESvfjE9UjyXjLWZn8pwrw3NHSGc1wze33KIzvcED67yhbDgPcR6Zcra3BELEmCIMAUn1pw/7n74TM6MXO81+aZojI0aT2+qxEr8xaHa1yqVY1IjIOas82pdxle3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200299; c=relaxed/simple;
	bh=uNhcfOVvO5EyhAEQvhBee7dTOn4Fd/svgh9qOCa/V5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ps1skn4qbz2QJgB8dak7fEmNwDYL7VSMp6TeSTwzFqIhdRDZYIyIcnJ36Qb/DJZrutqFkMnQHYsdTUMd5y4M0QPNFlIukCUT6jP36XJa9LNJaLIZi7/XBTxZIC6H2J8w5eTQ3ombkJJYtuOknO/8WcwEw4IxUQfC+F2c5FprWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho4kGXLM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho4kGXLM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso2177625ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200296; x=1792805096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQ5o6CAkHnui4iB7g1UmuXabwwcLJv9UBtrsrOaE95E=;
        b=Ho4kGXLMKTEtNjKCKRho59Vtva+xYm46uXAJt2nSVZINP8u/xjLa9/yBm1NbpGK9jN
         WMAJXmkX4xd00HpJX55cjWHRfKfeR/ur5anIlOXNqxEO41dFjDyAxzRUUJPosHvBgG1o
         SodsNZBexTZn3jmlE0RPrIx4m76E7/tWnWSFj4qGAmbGXWpvz9Dx9B/VIsk/PN6kPCSM
         DCwq8o+9EKg3clcfVX19vP8w61f8BGq8WVf0cUbduAMtFTbZiqMcVNs0xuYxZMnS8vFb
         cL4UWgDfrIUYmbVUU2+Ri+MctlOrM/TU36Nk9TYJ8y/OhTbqzglhCP8BUdOSACQgIVqh
         KRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200296; x=1792805096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQ5o6CAkHnui4iB7g1UmuXabwwcLJv9UBtrsrOaE95E=;
        b=ZYgylUhICjQ4FBaeE9L/gMuYjulCiQ+GRYE/E0CmpXM0EMke+WWJe7rjz1XtVNklGn
         moXYV0O24CDglJkuHuph+oiRz9wvrD06br96EHUaJ/13BJH6BiDtRAhBo0cYdMUixoE1
         FKtTHrFzPASX7gb/FgInKrPT+Lzu/2C6Ec5FKdc3b5gQpcQ6ZhoaY/a/iVAxAVRrkjl/
         7RTBBpnC2k/JBkScJj5ikb9XgFnEzCD8mJ3P31EE/toIyA6vk37hCP2qUp72lVvpx3u1
         +fWpuWEbadz4kA/Jgycnar5G+6O2FfrDmN7olTSFLHk5y5w41+DpxSnw/A23KWZQZ6rn
         w7EQ==
X-Gm-Message-State: AFq9FYJ97jHqAHNzTUqD5VQz8vWU/J5EL1p2ONG17h6ci6Gs+cMMfk9y
	ThYsh8DpJb82v/PLWr7SgddIzA5AXbyWmR/4yLInK6DBfnf4m68sYoG9Ena3qEyQ
X-Gm-Gg: AYBFou2ZYMNQVZ5NBVjDOlp0SMlKrSBt11nne+A1eVOUuHbY81dzFy0K4bVVz+mj5ws
	wd+Xlrdwh8aEpCNvnQUlCcu1X6uEDS4nXpFOK1TugSPEU9k8WcqXD2rzdHjxCqM56h99tS9ajqr
	KWNrDzM+uAFum07YjBybXjFpoBhBvA+rHceRWJnGKzRLHl1VV5r/hhV9SjsrO4ivsoYHzXP823b
	AEQzFgrvKyUW2I6VfwX8T/5ixt7pbb4VjcjAblrXiKjOzhAfiEVq0qwP4VFqXxhej/xl3IJ3Mlj
	MBWh14CzTq5S0W80pM13+7/odpDt3YRkZ4hzVU45FLm8QQ7gY4eq908U9tpu02SD/58kar/ISp9
	SA0b2onNlxX2FxTXz0qj+QHrNDJ1IQWCcCVmHpRStTrVfeXBFpEjScokHWwmVnuuHivEMO/U0WJ
	S/n0hQjn9gyNOyYyKiRhkXVkO4Hvk/SjdVH+r2BzHfNUUKmLM2DL+4n7tF27COC559hOSQ2Kww5
	wy7UUjtAoVyH9w9j1n+S/wMSdDtKVJ02tUR+0juGKkkWiS65LB1ETegv0voEEY1OS15G77JomXb
	vSeAPSXeZq9acldXM6AKa4H5iSSf5OvaXnhZvDSIaLPB
X-Received: by 2002:a17:902:e544:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2e9a6833d88mr14646305ad.5.1792200296138;
        Fri, 16 Oct 2026 18:24:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e834ef9sm17723785ad.42.2026.10.16.18.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:24:54 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 09/38] bpf: Read the probe of a perf event under event_mutex
Date: Sat, 17 Oct 2026 01:24:22 +0000
Message-ID: <20261017012451.364800-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

For a perf event on a kprobe or uprobe event which was made in tracefs,
bpf_get_kprobe_info() and bpf_get_uprobe_info() look the probe up by
name in the list of dynamic events, and hand a pointer to its symbol or
file name back to the caller. None of the callers holds event_mutex.

The perf event keeps its trace event alive, nothing else. Other dynamic
events are removed from the list and freed during the walk. And a probe
which shares its event with other probes can be deleted while the event
is in use, so even the probe which is found can be freed, together with
the string, before the caller has measured and copied it. The result is
a use-after-free in the walk, in strlen() and in the copy to user space,
or a NULL pointer dereference.

The readers are BPF_OBJ_GET_INFO_BY_FD and fdinfo of a perf link, for
whoever holds a descriptor of the link, and BPF_TASK_FD_QUERY. The other
side is anybody who may write to dynamic_events, kprobe_events or
uprobe_events.

Take event_mutex in bpf_get_perf_event_info() and give the caller a copy
of the name, which it has to free.

Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c     | 17 +++++++++++------
 kernel/trace/bpf_trace.c | 13 +++++++++++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 654f896af265..4a9f28131791 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4020,19 +4020,19 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 		*ulenp = 1;
 	}
 	if (!uname)
-		return 0;
+		goto out;
 
 	if (buf) {
 		err = bpf_copy_to_user(uname, buf, ulen, len);
-		if (err)
-			return err;
 	} else {
 		char zero = '\0';
 
 		if (put_user(zero, uname))
-			return -EFAULT;
+			err = -EFAULT;
 	}
-	return 0;
+out:
+	kfree_const(buf);
+	return err;
 }
 
 #ifdef CONFIG_KPROBE_EVENTS
@@ -4089,6 +4089,7 @@ static void bpf_perf_link_fdinfo_kprobe(const struct perf_event *event,
 		   name, offset, missed, addr,
 		   type == BPF_FD_TYPE_KRETPROBE ?  "kretprobe" : "kprobe",
 		   event->bpf_cookie);
+	kfree_const(name);
 }
 #endif
 
@@ -4142,6 +4143,7 @@ static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
 		   name, offset, ref_ctr_offset,
 		   type == BPF_FD_TYPE_URETPROBE ?  "uretprobe" : "uprobe",
 		   event->bpf_cookie);
+	kfree_const(name);
 }
 #endif
 
@@ -4240,6 +4242,7 @@ static void bpf_tracepoint_link_show_fdinfo(const struct perf_event *event,
 		   "event_type:\t%s\n"
 		   "cookie:\t%llu\n",
 		   name, "tracepoint", event->bpf_cookie);
+	kfree_const(name);
 }
 
 static void bpf_probe_link_show_fdinfo(const struct perf_event *event,
@@ -5763,11 +5766,13 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 		err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
 					      &buf, &probe_offset,
 					      &probe_addr, NULL);
-		if (!err)
+		if (!err) {
 			err = bpf_task_fd_query_copy(attr, uattr, prog_id,
 						     fd_type, buf,
 						     probe_offset,
 						     probe_addr);
+			kfree_const(buf);
+		}
 		goto put_file;
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5465e7eba238..304b426bd44d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2209,6 +2209,7 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *
 	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, link);
 }
 
+/* On success the caller releases *buf with kfree_const() */
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr,
@@ -2218,6 +2219,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 	struct bpf_prog *prog;
 	int flags, err = 0;
 
+	/*
+	 * The list of dynamic events is walked, and a probe which has siblings
+	 * can be deleted, with its strings, while its event is in use.
+	 */
+	guard(mutex)(&event_mutex);
+
 	prog = event->prog;
 	if (!prog)
 		return -ENOENT;
@@ -2258,6 +2265,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #endif
 	}
 
+	if (!err && *buf) {
+		*buf = kstrdup_const(*buf, GFP_KERNEL);
+		if (!*buf)
+			err = -ENOMEM;
+	}
+
 	return err;
 }
 
-- 
2.55.0

