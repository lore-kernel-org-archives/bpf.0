Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABB3DAAB6
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167294; cv=none; b=ZfRJ3ant+cTT7CMpwEEFVux8/gE9GMNm763dIDIeLBCegBiKN1nJ0BnefBCGMchNdicdFzmAV/Egl8VU207SSptBMfcOCVetbFGdrXCDONm7FmSyaVgpjck5dsoli9Qk3pgWnqknzeKUk3crP8YKgkc5Op+LfnKdrQvm2bmKtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167294; c=relaxed/simple;
	bh=tMK+rhnH9c6uPCT5UekXLsRXMQc1quMUh3HQmjUsB00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q209SLwSRIDQVEbHWhgy7TKclEb4/McYiK6iWlaOxj+MgrGXDKlcx5mQYlGnk1JuI3sj7lGLRXjFGnJHdMncfyI3+TP7CBMhZV2YXDWsuNOxzPDJX22SytIPRvA9VdsXoAHegKr78gpURPhbZkuAj7rqXGgIyNXpZ0cwLuaIZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoeVcr3P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoeVcr3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnKaODZGqlYN5mbvfy8Z28vyw8EwegzzHDVkYNnOU+o=;
	b=NoeVcr3P5QZgSa8C0xSFpbH3yUjrGjAkjyZFKfj727C9s69B2+/ryTWW/0eEHHanRE4NOK
	855VvBVKKgw77OiC3Eq7hkBZzSHdOGQWKJqfqOgVpSxyZHh2coozkInRjNbbUvvEksosEL
	9+1ZPFDFVaVKQP1tNO3o2UbZ2+y7Qio=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-6QsakI4GMUeTsUGdKBeXzQ-1; Mon,
 31 Aug 2026 05:08:08 -0400
X-MC-Unique: 6QsakI4GMUeTsUGdKBeXzQ-1
X-Mimecast-MFC-AGG-ID: 6QsakI4GMUeTsUGdKBeXzQ_1788167286
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D20B618301B7;
	Mon, 31 Aug 2026 09:08:06 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8314180034F;
	Mon, 31 Aug 2026 09:08:03 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 17/20] tools/rv: Define CONFIG_X86_64 statically for BPF monitors
Date: Mon, 31 Aug 2026 11:05:21 +0200
Message-ID: <20260831090524.106845-18-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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
 tools/verification/rv/src/bpf_monitor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
index 7e24a71dfac7..d2d1d90bbf73 100644
--- a/tools/verification/rv/src/bpf_monitor.c
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -505,6 +505,12 @@ static struct bpf_object *open_bpf_monitor(const char *monitor_name, const char
 
 	LIBBPF_OPTS(bpf_object_open_opts, opts,
 		.pin_root_path = BPF_PIN_BASE_PATH,
+		/* Define statically as arch is known, Kconfig may not be available */
+#ifdef __x86_64__
+		.kconfig = "CONFIG_X86_64=y\n",
+#else
+		.kconfig = "CONFIG_X86_64=n\n",
+#endif
 	);
 
 	if (!path) {
-- 
2.55.0

