Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342269;
	b=cIPme21PHJUEg857ZCvBltDEkkbtPCGlSQOXSz7uTnoRS3hRgLxhRb2EzcbUNCfhzNIr
	 eIJC6LD8ei9wZBMvIab7mBKMGKUy13jXQcbfKNIudRLQKAbQChMTx4+DwrFDfscJ2AZCv
	 3xH9OrgWbKm26ZNdfJV8aHZj2t2TYtiZGMbT2/yHZTv6R1j20XRHa6AztqUAFJaKAvSRH
	 V99ZSqnOZGb/miGeL3jjHLaij2jxNXAN/gck6VRmUHq7FTGy4TvH572m2wiCWyZQhVj/L
	 u0UKPZo3oB3jrppJKtKM2OMp6TserZ6zjGobZD6pvwq3WTWwVAX9dx+xMo04KQmpoYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NNWkhMM9mRV69+bDPtzO7ZmhT8HSmB461wMg2BUz4JA=;
	b=pGZa9ie/70cQD+wAIJNEppcXPSjvwofzAmjJgW0aaFbCG+bv9e0/p7NAdpMwUPqeFuqZ
	 rIJaVOUW+RKfbkAusfw15nydH8u0ItbIr0p7kv0fpGpsmgbHSl0Cch4SE/gbxD6pNmdBI
	 ORvWKPgQdZagq8tpXoT+L34aAkXWY9s9zKTGeus7yL91mQKnxl+s0XtCja2MJghvbUHys
	 VF3Nf1+kFO3t50rfka8H5+/jgqp+lPpVFr400J/bLagplOhGilz6e+jov8jVzZWMgPXpb
	 0QbrTQMGJDQKxh/8up7IgL6qdx6/Iwcyq8JZSEuKoCMCzj+4ZhwDnqk+nXzNxw06XpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jcqBjeP9;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296ED60A260B
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 20:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 296ED60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jcqBjeP9
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so4876651eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1794342268; x=1794947068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNWkhMM9mRV69+bDPtzO7ZmhT8HSmB461wMg2BUz4JA=;
        b=jcqBjeP9L1xp1JklGYM0b1vT5HG9543QwujHEfMVyjAPCMy1Z6a2WjLK/Tl762SFJi
         UfnBKtuHG7xIgvrcmWziQRbrx3Rl1pipPKXO3jAvVYOuhTQKXa2xyePhgc4jFBdyGKJV
         0OveURAQ+4+DKhtsqgMTu+6eiAg5d3BIrjSN4zl8G6KMfMYX5zo9p94MxmLBvOVFsjat
         FFEeM3SLOz7sUsMavU/8NkBT/oDHo1q+OEuEgBY5m1b8YIWPzvPr9EZWFUkvsmeruKGp
         RdTI4f0y9C5oqjnmTfd+7FvunT0vn04W+FqOHN0fvZf8UAAhYAx3SKfSg8Jit5ew2VTt
         +WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342268; x=1794947068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NNWkhMM9mRV69+bDPtzO7ZmhT8HSmB461wMg2BUz4JA=;
        b=IlMuccry4NYeuPaWG58Zsc4SgkXeJtsVTtoPprBlB8nhc1wXpuCsUgsROCu3XT6HZo
         P1CxZjlhQaAMFOoEDFBQhnkm0Z0QJQVydIHgbgxqaWxSUEdLZ9bCaoUMq/5Vrufz6d+I
         G+6RUzyWErkANESi1BvAWDZZwURyITZLh/DozORVSsLcbgyThsaDUPwv6H8RA6oDPHEr
         LuC7gL0rp9nvO5+OYmJ+e3B30zkWG8CYHuKevkU1/xi72YPxYgsfp+rv4RXhAZH8+bq0
         93pH2mPWMxocPtbEvtFNeWmYc/5llq3rLQByrF1L9DLYAeZK1pq0XQynosGVHqkPD2c3
         WBRA==
X-Forwarded-Encrypted: i=1; AL+hErFN7tgCex5iVr7N7JOB/vrqKqz6E1kyFIEC30QY8OP8ZXXCxIRGgkZ4nz842OSr8/44gYk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WkaabpuLM5nfmUpn2YxqxsgJ3/DuijEJsm/oJi7GHKLmNA4ov
	6PxIor7LegMuf5YMIMx390KzwjdQu//4ctkoqj4QS0qPmaQukvVonIF+YGr25mGvNkGV
X-Gm-Gg: AYBFou3MjaGvr0YZaicBoOUnTYqIg/gkzeQG5ZkNdu6wztaQyx8YNWkB4rLbvACgbyx
	chwPJbVIbWo1TW9BWT0qFM+YzUu3+epO9iL1HvIGGx3KSO7KJvSPcrX5+ItuMDB/Tgon54j78R+
	4BWNx5VyZwxpMNEiJ2Mq+h/hg4sd6PFeT8NIxgJVULXPRF0m3fEEa5wLgDkjgKgcqS0bBHqnvnD
	RHbiwwXYNdtJJlMcghN0TFOoAm255XziUAdrco6Tdm+3+tBH7Zl3iW2CDefxPLr/Nwd0EkxMmlA
	z5f62ewK+LAXnYg8VJcaTlA2fyC0kVuxsAGuA4Etcw0aJtTHl/XqnMvcfce67FeFBCZvc+yhH31
	0tcFsXOcydry8EToUctE4yVPcbX3zDIr77QeW6r+qpUdXS8wKVjvjGHIQOsBuWmJwd+0uybojl7
	/9z1H4fZzMxZzjgIepTkSTAzO74IahRRn1qOhZzadDzAK0xLhHO8IVcjT3hmtJxYIjnNXgxTNBT
	B8W+XYTLfYb9FToyytyXXjAWzDv77bmgImzk2BbxNXQ7Bmuu6zFSpZBZcuSysufbf3Z1IyLmtDn
	5kaVYBHmhhIFK3mxU4qJuLTWf8AjtKpObjHjHT0k8qlvA35xbNIiahOdBzwvFbKJ7aqa+0WmLLC
	HvNfoYDRUIm0qlvuZK85UjsP3g9d5ZeeDCLxJ79NPijiojoF5LBNaNg==
X-Received: by 2002:a05:7301:488f:b0:376:2859:5b2f with SMTP id 5a478bee46e88-3768675d705mr516619eec.25.1794342268101;
        Tue, 10 Nov 2026 12:24:28 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:147:2742:6545:702a:2431:7dca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm10076615eec.21.2026.11.10.12.24.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 12:24:27 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Kees Cook <kees@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>
Subject: [RFC PATCH v3 6/6] MAINTAINERS: add an entry for the Kernel Assurance Plane
Date: Wed, 11 Nov 2026 01:52:46 +0530
Message-ID: <20261110202246.274-7-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202246.274-1-harisudhan@armoriq.io>
References: <20261110202246.274-1-harisudhan@armoriq.io>
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

Add the KAP maintainers and the files they look after.

Assisted-by: Claude
Co-developed-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047a..0946d15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14118,6 +14118,16 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-keene*
 
+KERNEL ASSURANCE PLANE (KAP)
+M:	Ketan Bhardwaj <ketan@armoriq.io>
+M:	HARIHARA SUDHAN. R <harisudhan@armoriq.io>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+F:	Documentation/ABI/testing/securityfs-kap
+F:	Documentation/security/kap.rst
+F:	include/linux/kap.h
+F:	security/kap/
+
 KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
-- 
2.53.0

