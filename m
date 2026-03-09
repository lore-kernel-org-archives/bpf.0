Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49352413224
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086278; cv=none; b=TdsgJ1FJuwRRpL7dMCY7Qj+OBpAXiRQMVEjnE3zwnHlonRKAiB/KaymlcMd9erfy4bNrGomzdLKUmnysdKD3Ke2v+hORMdM90LC0NmqhHMB/OZFydWyXpQZStnpN1Sctp2FTR5VXqXIubeWikXSJ7ciKVnSqClIDvM7suIFFYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086278; c=relaxed/simple;
	bh=mRl0IxsR1q1GxgKiAsi6SUeZCXOxDnqktWmMY+i39gM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry/rWGo6rvULzP3dQulk/h2KLAEh7ZHzOkRXIw/0qGjmFTjFl9RpB5lbwTeF4zMAN2JT7niQ9zC84Pwg6sR+eEq38qxxZGsQ3fzhcBAy8oVDvZ/Ip9Uyxx8mfkfS9GkB+WmSD8p3uUvewOoV1ik7z1OsTEERM85OZ9D8ZVe4g6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCnhYLRu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCnhYLRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GM16FbcQc7+wGJbfXKPKvR16dE3/ETsumBQfweUSBWc=;
	b=dCnhYLRuvSdHms8G++6tTsQsslfQ1AxuAQwHLGjFxyVdiCuWWKt4U773zLwhXrkB1kzO3W
	FwxuCuap67laqRcvpKGFTqe8AKWo+hw63LDee/ZIjPTCy9JK8xA4llG+/NVX4nwcT3CSGI
	adZxGPPpBAyu7fQX0EBDEhiXWyBClLg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-sp2rBLBMOd-tDBvNcTQNVQ-1; Mon,
 09 Mar 2026 15:57:53 -0400
X-MC-Unique: sp2rBLBMOd-tDBvNcTQNVQ-1
X-Mimecast-MFC-AGG-ID: sp2rBLBMOd-tDBvNcTQNVQ_1773086271
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 950BB195608A;
	Mon,  9 Mar 2026 19:57:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02FFD30001A2;
	Mon,  9 Mar 2026 19:57:45 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 09/18] rtla: Handle pthread_create() failure properly
Date: Mon,  9 Mar 2026 16:46:22 -0300
Message-ID: <20260309195040.1019085-10-wander@redhat.com>
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

Add proper error handling when pthread_create() fails to create the
timerlat user-space dispatcher thread. Previously, the code only logged
an error message but continued execution, which could lead to undefined
behavior when the tool later expects the thread to be running.

When pthread_create() returns an error, the function now jumps to the
out_trace error path to properly clean up resources and exit. This
ensures consistent error handling and prevents the tool from running
in an invalid state without the required user-space thread.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index cbc207fa58707..73906065e7772 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -303,8 +303,10 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 		params->user.cgroup_name = params->cgroup_name;
 
 		retval = pthread_create(&user_thread, NULL, timerlat_u_dispatcher, &params->user);
-		if (retval)
+		if (retval) {
 			err_msg("Error creating timerlat user-space threads\n");
+			goto out_trace;
+		}
 	}
 
 	retval = ops->enable(tool);
-- 
2.53.0

