Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698100;
	b=ThwOhUS0/geDNk1qfaYbiEQiG6qTVtv93AUCcOEcFKs1xim19eOJ5JmbuW/ZO+ocBKF5
	 GDNmcibIylKjL34pjlsO6PHR2BzRTzvfEjamZTL9nascsCRZR+EVhvtWGBUJQCwvle9TG
	 Pdq1qGhuj4nw7TJjXc0Psdg0RmV1Puul7FMSKzHloBA0z5kX5j5d5qKOTmF0R6aNmBo9q
	 PybcdtXZXa+cB5bqbWhH7NFfOQDnwJ7XbJKJFcPWR1dHRxqSAVtwO/U33uH3pMpBFyGpY
	 jZSGkz8dE0L7CA6UkjmeOJZODGjJhPPe+mcHWUz5kl14ZhvWTJp2UMZILN0Lq09x8Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698100;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=k8Cv/59D5sljUP7KuQcbi4TP82IHvLoL6JhsgTdaF2M=;
	b=w5kiONBUTyRIkOf0UQyqD9hYKmTIe/SJc0JLP3D0AxW1GQvu/wuCUX/9/ytpKgsdg4za
	 yqoWTnogrJ7/T6VC3Oy4Efvqv5GYKo6a8amkq2e3pVO/OEIwlSCpLpFJG3z+96mvJekfh
	 ZuHK+3L8f8/E8bosz3/KFuz5eKrq5lpeLMDgVjXZSZLtjx/9khomzl/KJO0n3ysyj/4/z
	 DB9nZImAc9d9Slddb7R0IcDqE5B5jd/CCO9onPGKEvRNYkHKoauuIqzQn0eq3osiW3R3j
	 dPNuFgMuEat7lLDJohfz7Q8Kl74uMe9lywg0pQvntrNpXQFppj+GDB9se1S4Q9IEs4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EVxcNT1t;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51432606A33B
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51432606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EVxcNT1t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8Cv/59D5sljUP7KuQcbi4TP82IHvLoL6JhsgTdaF2M=;
	b=EVxcNT1tt67QDYkYfs3GPEwCH7f0PKaujDsqJdfSWIZcHAbKIr+ueyxMclbx8pUmDFZvsA
	dBOtFRjbDLDIxJWxGb1dVgiUWanov5BZyf2CXq/6i3qX5+6ecfus57FTky5j51D0j8eA+v
	busd2XQeouiPpn4S5sCY5undBl6STZk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-PyOkHxZiMGaCrOan8oV33A-1; Thu,
 26 Nov 2026 13:01:35 +0000
X-MC-Unique: PyOkHxZiMGaCrOan8oV33A-1
X-Mimecast-MFC-AGG-ID: PyOkHxZiMGaCrOan8oV33A_1795698093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEC4B1955EA9;
	Thu, 26 Nov 2026 13:01:33 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3E32180054C;
	Thu, 26 Nov 2026 13:01:29 +0000 (UTC)
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
Subject: [PATCH v3 14/18] tools/rv: Define CONFIG_X86_64 statically for BPF monitors
Date: Thu, 26 Nov 2026 14:00:00 +0100
Message-ID: <20261126130004.127155-15-gmonaco@redhat.com>
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

BPF atomic macros require CONFIG_X86_64 to determine barrier
instructions. Reading this from the system Kconfig can fail if the
configuration is missing or in an unexpected location, causing the
loading phase to fail.

Since the rv tool is compiled for the target architecture, the
architecture is known at compile-time. Define the CONFIG_X86_64 value
statically via the libbpf open options to bypass Kconfig dependency and
ensure reliable loading.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/bpf_monitor.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
index 5c9c4d9b4835..1ff76a4ffb68 100644
--- a/tools/verification/rv/src/bpf_monitor.c
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -460,6 +460,12 @@ static int get_nr_cpu_ids(void)
 	return strtol(sep ? sep + 1 : buf, NULL, 10) + 1;
 }
 
+#ifdef __x86_64__
+#define X86_64 'y'
+#else
+#define X86_64 'n'
+#endif
+
 /*
  * open_bpf_monitor - open and load a BPF monitor object from a file path
  *
@@ -476,8 +482,8 @@ static struct bpf_object *open_bpf_monitor(const char *path, struct bpf_monitor_
 		return NULL;
 	}
 	/* Define statically what is known, Kconfig may not be available. */
-	snprintf(kconfig, sizeof(kconfig), "CONFIG_NR_CPUS=%d\n",
-		 nproc);
+	snprintf(kconfig, sizeof(kconfig), "CONFIG_NR_CPUS=%d\nCONFIG_X86_64=%c\n",
+		 nproc, X86_64);
 
 	LIBBPF_OPTS(bpf_object_open_opts, opts,
 		.object_name = ctx->monitor_name,
-- 
2.56.1

