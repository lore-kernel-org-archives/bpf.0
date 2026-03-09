Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733636AB7C
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086154; cv=none; b=ArsgiI55MEBesRHYz/vCZxdVhcc+kMvOkqZkjtPHHw+iA95vU4CdmIQJL15c+36jWjbh+AnZmAEkIbY+hJRbwRHrcG675c+RgYXxoc/pHTrEbFqDBudgSYOWPv1i+/SiEPt+fS0ddoOq6RdGtgNrihHdDj3f26UjXZieIS0pGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086154; c=relaxed/simple;
	bh=FNVT5zSJOzSfkK+hd75vebev3RSQTiamiFc2BlURPb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8aVzkmcut4qGc9LjDqHD+X7kwIjCK7DlItkAFEXtAUjPeIjBkcUEscqG10AXVoV7jw80bP88dV+/GvgiyccAqCF7DTZrRbiolSp4xirFW+Thz29lxhEBWd+yarzOCajdlA5mlFAAYukwlZH52p9pG/Okz1NcGIV32gvWP3Brqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAghOlKg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAghOlKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1AFDLErX9LNpKT+XvkRE76AHcJ+4sy6d+WZlsVLdxE=;
	b=CAghOlKgIx+zMKZPXFt+NslnWODR5zC8byOGcNL4SKLVDHn6XW3Ogg8Nk6jLZBqi7NV0b6
	JBAqOt2EsXsw5cgPBc6GRnwY2cPq7xyIV6zH/wrRBGby19S3/UJtOZXkwE1rUbt+IFNVmt
	QumVe13d40cLW2GeDEs3NehAijQKA8E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-ceMMqbTiP9SAFtulxvo-XA-1; Mon,
 09 Mar 2026 15:55:49 -0400
X-MC-Unique: ceMMqbTiP9SAFtulxvo-XA-1
X-Mimecast-MFC-AGG-ID: ceMMqbTiP9SAFtulxvo-XA_1773086147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EDBA1956060;
	Mon,  9 Mar 2026 19:55:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBB1930001A2;
	Mon,  9 Mar 2026 19:55:41 +0000 (UTC)
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
Subject: [PATCH v4 02/18] rtla: Use strdup() to simplify code
Date: Mon,  9 Mar 2026 16:46:15 -0300
Message-ID: <20260309195040.1019085-3-wander@redhat.com>
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

The actions_add_trace_output() and actions_add_shell() functions were
using calloc() followed by strcpy() to allocate and copy a string.
This can be simplified by using strdup(), which allocates memory and
copies the string in a single step.

Replace the calloc() and strcpy() calls with strdup(), making the
code more concise and readable.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 22b8283a183f3..0ac42ffd734a3 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -69,8 +69,7 @@ actions_add_trace_output(struct actions *self, const char *trace_output)
 
 	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
-	action->trace_output = calloc_fatal(strlen(trace_output) + 1, sizeof(char));
-	strcpy(action->trace_output, trace_output);
+	action->trace_output = strdup_fatal(trace_output);
 }
 
 /*
@@ -97,8 +96,7 @@ actions_add_shell(struct actions *self, const char *command)
 
 	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
-	action->command = calloc_fatal(strlen(command) + 1, sizeof(char));
-	strcpy(action->command, command);
+	action->command = strdup_fatal(command);
 }
 
 /*
-- 
2.53.0

