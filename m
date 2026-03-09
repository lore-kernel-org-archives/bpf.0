Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF163413225
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086366; cv=none; b=XH+h71WAxohVP1ppOU1i6nHFTGkHHXUymLQW1m9QLLcQBJlw4t4fzasx3X5rhlSfHYSnfgcIHd6Dq8/U6IHgphx93EgtwvW/axelIK8pnHhaLxHV/exDFUflNLjcthJgmAfwS+ZdaAEsz67rWxu5s+o6Z4U+WcfLsGAEd8WxKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086366; c=relaxed/simple;
	bh=fg5z2+qe9wyG/Hf1+Ta4lurRlNZxB/n9wfYQjvyek5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFx6cOp/jcqmdgQAk6W31xDgbC+bsZAmPNYlLSnOR/8q4eVnLTqgomTax4D8EI37Xe6tF24wclDzGj5UJusohHY6n0biwhwmJ9A9uppxLZfMRI31JNzYYY/FfKJeDg/bskIuvI8QlmUCH+Q4X2hszRxV/vMVpRXqOqy9QazxYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wox3YPWz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wox3YPWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xISGNj8SaU6nn8k+kl4N6Sj6+gFLEndGrAKZOLGnLE=;
	b=Wox3YPWztgdD8bdSvLj4xRgyPdT9sdyNQovXgXeLoKDk6A9Wu8KFyy3HoANrGzu4WPI8rr
	B1AOwocY2dQrTuEL+yBjEjo0PE+E5O2d+j5yCHpwL20K02yB49aQ6OGmQ03q/8szbdT9tl
	DcgaecHfYmc46pth10FaXVudgYtV2D0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-nwjDyO0GOi6XrTqi4Y1vHQ-1; Mon,
 09 Mar 2026 15:59:21 -0400
X-MC-Unique: nwjDyO0GOi6XrTqi4Y1vHQ-1
X-Mimecast-MFC-AGG-ID: nwjDyO0GOi6XrTqi4Y1vHQ_1773086359
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BEC61800464;
	Mon,  9 Mar 2026 19:59:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3C4230001A2;
	Mon,  9 Mar 2026 19:59:14 +0000 (UTC)
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
Subject: [PATCH v4 14/18] rtla/timerlat: Simplify RTLA_NO_BPF environment variable check
Date: Mon,  9 Mar 2026 16:46:27 -0300
Message-ID: <20260309195040.1019085-15-wander@redhat.com>
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

The code that checks the RTLA_NO_BPF environment variable calls
getenv() twice and uses strncmp() with a length of 2 to compare
against the single-character string "1". This is inefficient and
the comparison length is unnecessarily long.

Store the result of getenv() in a local variable to avoid the
redundant call, and replace strncmp() with strncmp_static() for
the exact match comparison. This follows the same pattern
established in recent commits that improved string comparison
consistency throughout the rtla codebase.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 84577daadd668..91f15f86e78d4 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -28,12 +28,13 @@ int
 timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
 	int retval;
+	const char *const rtla_no_bpf = getenv("RTLA_NO_BPF");
 
 	/*
 	 * Try to enable BPF, unless disabled explicitly.
 	 * If BPF enablement fails, fall back to tracefs mode.
 	 */
-	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
+	if (rtla_no_bpf && strncmp_static(rtla_no_bpf, "1") == 0) {
 		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
 		params->mode = TRACING_MODE_TRACEFS;
 	} else if (!tep_find_event_by_name(tool->trace.tep, "osnoise", "timerlat_sample")) {
-- 
2.53.0

