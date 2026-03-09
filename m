Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C936895F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086442; cv=none; b=ngjge4ytnMDzvM5RzC4LC5sdF+1yuRIFPzBezt6q4LTSivVzABxcRn/EH+0FzA88gPGgik1+NYvZPfYOVJsAWO1f7XKLfdXvNUMWweCOYSBDQ6ZWkVoteScy0DcqcshgfswfQlXtpZtUTnOCy14KmFlyh3M5+11BJ9utaRrn494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086442; c=relaxed/simple;
	bh=zBTs9brgISV8XgiqAinMb+sQTfubhTPVIw7CiF1kjcU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJSSuSyu/a2NyBgwy0hUOJF5LfHK4dHA3wlKI/08ANCDx03SxkmmcAyQlR+CZwZXgjsj6o7YCn3OtAsFGY5xreoi+EdjF33Icbe7aP5a8o8VNiaDaYl5FAeWot9qYSbPQ3skQ+mkMaVjkMDxqzY5F7cL1035qY4V33aUQP91KFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Optx9PI0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Optx9PI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9V+YCrxPIg4vwIKqGn3LRnyND1/p3vLF+4oSDjIOXg=;
	b=Optx9PI0uQ42vyJqKVAEkSdn99u3wcV4aFrE1NI1iQN+ww11NjLQ7ubwGysayKvGz7x4ad
	E7T3JXa2dtpKG+pblzVe9kisQX0KHEjHoeTnrXsFXwl78Van9iC0rQYaGjF97HHMwI0zG0
	zIJlvuseVO+KgQ8vBMw4zHYQvXvTp1w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-QyS64AaDMNyWJEaDzgUNPw-1; Mon,
 09 Mar 2026 16:00:33 -0400
X-MC-Unique: QyS64AaDMNyWJEaDzgUNPw-1
X-Mimecast-MFC-AGG-ID: QyS64AaDMNyWJEaDzgUNPw_1773086430
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10E5718005BA;
	Mon,  9 Mar 2026 20:00:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48B9A3000223;
	Mon,  9 Mar 2026 20:00:25 +0000 (UTC)
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
Subject: [PATCH v4 18/18] rtla/utils: Fix loop condition in PID validation
Date: Mon,  9 Mar 2026 16:46:31 -0300
Message-ID: <20260309195040.1019085-19-wander@redhat.com>
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

The procfs_is_workload_pid() function iterates through a directory
entry name to validate if it represents a process ID. The loop
condition checks if the pointer t_name is non-NULL, but since
incrementing a pointer never makes it NULL, this condition is always
true within the loop's context. Although the inner isdigit() check
catches the NUL terminator and breaks out of the loop, the condition
is semantically misleading and not idiomatic for C string processing.

Correct the loop condition from checking the pointer (t_name) to
checking the character it points to (*t_name). This ensures the loop
terminates when the NUL terminator is reached, aligning with standard
C string iteration practices. While the original code functioned
correctly due to the existing character validation, this change
improves code clarity and maintainability.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index bcc5b5d383d8b..16aa59c90bdb2 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -311,7 +311,7 @@ static int procfs_is_workload_pid(const char *comm_prefix, struct dirent *proc_e
 		return 0;
 
 	/* check if the string is a pid */
-	for (t_name = proc_entry->d_name; t_name; t_name++) {
+	for (t_name = proc_entry->d_name; *t_name; t_name++) {
 		if (!isdigit(*t_name))
 			break;
 	}
-- 
2.53.0

