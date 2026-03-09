Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D226A1A4
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086419; cv=none; b=KbdHOx6OztXwMHEIkzfCkXK4kQuMgrZ2KeO5yW8mgK2BEpx4PKD/jE4XkhWUVeAgyLfFBmr00dC6QnSj+qZA+kCf1NDRbWIVEnnUaxVJ/K1qH66sJdlrP3x/Sl/XSfPWuuHGK5bjFVKwoejSWAFupY82k9c4u50N6E4fx3UaGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086419; c=relaxed/simple;
	bh=B3iJoZjVhcp1Xjyi183ExXCdQZi2kGROT9TFWwcw5Rk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO4k/KSAXnjsL/wpBlw9dEL5IA6NUEj8X1TfGfh3CjfhIXf6q7K9FH3YtUvFAAbAVtKMihNrTCh/z8MSEQ1aCFOpkwbz8RJ0npMV4/oWJGp/EPUa6eO46OnuZS32VzgxLirz/bYvVFC32tN+ptE2JF9/fQj1fDWl9gqLJ5Rmcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAQDaopf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAQDaopf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8lAUazNtEgHgFLO8B8tmHadfWKJ4P4/q5CxFLjPDZo=;
	b=dAQDaopf0msaXZVgq9wssnejFVYQE/2bdmRnwhvlNUrBDjeeGvezNmuP92FKI3Uc7yPEm8
	heErK/pIqqWpzeGNalf4TJvKGQkNkKSccunzIG2d3lfSofvfEGJxMu/peqq1o400GB/9oc
	t/k7n87y2dWiezrtADkJC2jK/OhSzd4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-mTtw5wnLNyGbylY6PZJMQA-1; Mon,
 09 Mar 2026 16:00:14 -0400
X-MC-Unique: mTtw5wnLNyGbylY6PZJMQA-1
X-Mimecast-MFC-AGG-ID: mTtw5wnLNyGbylY6PZJMQA_1773086412
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85D6018005BF;
	Mon,  9 Mar 2026 20:00:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E9073000223;
	Mon,  9 Mar 2026 20:00:06 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 17/18] rtla/utils: Fix resource leak in set_comm_sched_attr()
Date: Mon,  9 Mar 2026 16:46:30 -0300
Message-ID: <20260309195040.1019085-18-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-1-wander@redhat.com>
References: <20260309195040.1019085-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The set_comm_sched_attr() function opens the /proc directory via
opendir() but fails to call closedir() on its successful exit path.
If the function iterates through all processes without error, it
returns 0 directly, leaking the DIR stream pointer.

Fix this by refactoring the function to use a single exit path. A
retval variable is introduced to track the success or failure status.
All exit points now jump to a unified out label that calls closedir()
before the function returns, ensuring the resource is always freed.

Fixes: dada03db9bb19 ("rtla: Remove procps-ng dependency")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index c3ed9089e7260..bcc5b5d383d8b 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -377,22 +377,23 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
 
 		if (strtoi(proc_entry->d_name, &pid)) {
 			err_msg("'%s' is not a valid pid", proc_entry->d_name);
-			goto out_err;
+			retval = 1;
+			goto out;
 		}
 		/* procfs_is_workload_pid confirmed it is a pid */
 		retval = __set_sched_attr(pid, attr);
 		if (retval) {
 			err_msg("Error setting sched attributes for pid:%s\n", proc_entry->d_name);
-			goto out_err;
+			goto out;
 		}
 
 		debug_msg("Set sched attributes for pid:%s\n", proc_entry->d_name);
 	}
-	return 0;
 
-out_err:
+	retval = 0;
+out:
 	closedir(procfs);
-	return 1;
+	return retval;
 }
 
 #define INVALID_VAL	(~0L)
-- 
2.53.0

