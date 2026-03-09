Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0A413226
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086259; cv=none; b=U4zrR4XaSRm2sT1q5UmAKYZ9EdFXWvAJGsjMptLpQWvQh5MqS17ilzytKhnxRnl/pNhgAmNAcwT4LC2cNAjIrYxQxLgb5fmSl/TR4T8f76umayLT035oLvU6kJ+cxLyums1YfslwpybcBivsM2rxo627FackIjDUihaUklD1+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086259; c=relaxed/simple;
	bh=8TFHIE5dNF7Z28ZUMjjGUnP63BDq64UYTQHL6hzQnKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDyPuqXaUv3BXmuwi7KeuuQ4Wief/Z5McD2867L6AZbD6hOTwdL6gSpYdmy8dACwf83seRqzuMfNdzrTvlBYTLxLwaAulUJC+FpmEiwior7xLCiGdKkRkgE8HrdxFy6sceWQ5BX7yVflVrg6FzCWVE+UMEcelZvSvoEsNLTcou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYvBOkEz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYvBOkEz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Il3Krob+nGyCDOWEKlqe2ZH6ODKvfSQlcgWeOunjik=;
	b=LYvBOkEzGzlHbNorNvryNV2UUCLUnNJMMWYkssnpywVbviEz7y5dyWAnqxaRWwb/TJF5dq
	eiLxyZvSHnp/DO/AJka3rDTZ0BNRJmIRBjvOGaVcvX+w/gll+Vb3VbWX9+lSmcJVpAyPio
	5Zyg72lFbPDnyZpkgMd1xVxnmnk6kq4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-s36_sr11PoGm6MWiKCfvmg-1; Mon,
 09 Mar 2026 15:57:34 -0400
X-MC-Unique: s36_sr11PoGm6MWiKCfvmg-1
X-Mimecast-MFC-AGG-ID: s36_sr11PoGm6MWiKCfvmg_1773086253
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F7E1195605F;
	Mon,  9 Mar 2026 19:57:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66C8A30001A2;
	Mon,  9 Mar 2026 19:57:28 +0000 (UTC)
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
Subject: [PATCH v4 08/18] rtla/timerlat: Add bounds check for softirq vector
Date: Mon,  9 Mar 2026 16:46:21 -0300
Message-ID: <20260309195040.1019085-9-wander@redhat.com>
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

Add bounds checking when accessing the softirq_name array using the
vector value from kernel trace data. The vector field from the
osnoise:softirq_noise event is used directly as an array index without
validation, which could cause an out-of-bounds read if the kernel
provides an unexpected vector value.

The softirq_name array contains 10 elements corresponding to the
standard Linux softirq vectors. While the kernel should only provide
valid vector values in the range 0-9, defensive programming requires
validating untrusted input before using it as an array index. If an
out-of-range vector is encountered, display the word UNKNOWN instead
of attempting to read beyond the array bounds.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat_aa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 30ef56d644f9c..bc421637cc19b 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -417,8 +417,8 @@ static int timerlat_aa_softirq_handler(struct trace_seq *s, struct tep_record *r
 	taa_data->thread_softirq_sum += duration;
 
 	trace_seq_printf(taa_data->softirqs_seq, "  %24s:%-3llu %.*s %9.2f us\n",
-			 softirq_name[vector], vector,
-			 24, spaces,
+			 vector < ARRAY_SIZE(softirq_name) ? softirq_name[vector] : "UNKNOWN",
+			 vector, 24, spaces,
 			 ns_to_usf(duration));
 	return 0;
 }
-- 
2.53.0

