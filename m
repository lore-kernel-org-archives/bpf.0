Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2D44E045
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079958; cv=none; b=O14a1xme2wXqR9nt9cj18TEUzNxFdb7WysTkZMV9hu5LIVcwM7FHlIJb6vhAP+/R269EtIK7ZAbyykh/ZKg5RSUrbW5tj3PtehsG0pjBe6iSxZgHv0rVQd8Te0bXftTqaBMhezDo7zt/6S9Cf54TUPhbDDzrDcOpkYgknLygOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079958; c=relaxed/simple;
	bh=0POFkFFNVrMQryzUbD4UqQY6UMBhMrSFwGrGEgIC7C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fuz/ax89CyFZ86Dckgw2tlgj+7xZRRMHeOLhbcLruufIYogRcNTHs79q4sMZ9B+JlAO/EKhkoEDvsMKKwWFnXkhAEg+UeCf6dXyjHjj5FyrSkME8vxXNiSmKJDx6J/RzU0mkgC61oi+HKwAuf892fwnUzcHaCq7mZhMQlwjxak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3i/mXBN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3i/mXBN"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso50152645e9.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778079956; x=1778684756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0J3rpayuOKrnwwnnzbYMFwFi/582KvjsLozbp5uBHU=;
        b=M3i/mXBNHF59CI3HdxL12hxHYheWoaqY7G5J7rH4m4WIzIo8HKCiseKSSdUi46Wah9
         jzBKByQvq9JmZkAIIY97TR+uk6EmsOMkEQL1QNpeEIMjMzndttYPth0QYWXb/2k+9kil
         9j9W/2vTtXIVDv/FROpLsvTxUmJxGR76m7FhS70vUd+Tnl+936KbHMX2hPOq6kKuIQt2
         9KnoFp5zTMrA+LETrbMlxEu7nN14KWgjWIEXxV7xC4XwDQe1VLFNxH5g3WHR9HEekqQ7
         bJeSqRAut09PgZmFVhGyY/XrByuchEQFe9IAY1omZYjiMJ/MGe/mE6+6ZyfKamZbxMMi
         vp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079956; x=1778684756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C0J3rpayuOKrnwwnnzbYMFwFi/582KvjsLozbp5uBHU=;
        b=Np4WA9rWrMfLS6nUBKV+VeGvphGqWDYrkyjB8wpQVzXnoMiIA3Tgq+kVnhqq8dZIJt
         HLXecFjlaKEtvyetmotiYsI1/41ihMmZtP6eMpVd0LaQk5UkX0qlFpDgiv5ofDkzJznN
         kFSQq5IFzeeKgW40eeror1gs+uN0ETsRNBPZvZ7uGRbaI7L57lVey7lGrdgoW9VrhiBw
         4ohJhUtjtouvqCfjjni35PUTVnt0zRTGghBBl29xGuJTYIXPrMCIiyEiR9/poq5pfiyx
         ciPlBxCvnHVPlGTLBVMh1GCQbGeV9Ugid1506ECCtF3ne2DXgu7O4XHTAmCRg3ewLYUx
         aYLw==
X-Forwarded-Encrypted: i=1; AFNElJ+K3S0wz7gBw3N0CAUHwfpcJ3lM6uxYy1e11dv8e1u0GNYRnxqTGux1alSyeHqeZRSCHcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKikV11DLyXDzGds8IwX1IfySyDCiroQnsVgOQy8qmTOnyOXcC
	nifHGsHL4FdrT01acbKVy/sLZObPFYZUHBUY1tXTgU/RyEpMl2aEC+hD
X-Gm-Gg: AeBDieuTaGats9RC+mWlI79xMf607G7Qt2iImJMBFDc65AR6HJJoWfxwywE0Awa4QqC
	32mo0NqCuBlK15FSnUsgF6q5B+PGAkEBthdbdvAyqBYLjcWC+ql+LBpdoWCMl+6liUgdQoKIJRf
	2JMUECr4u/k3wIXCvQCxTpNpbHc2HN8OD/vW5atyDSO+MkcTcpgN4ZXAZ/QD/kzDgj15IHTLBl7
	84qWe9kRFvf+eqx5oNL85OKIHQmtqQU/COj4seSdiM+OhXE60qQiqY6JPcpcG0oVZWhNAwWm8Xd
	Bk9tFMloOgR4u4O1LFzs7kI/XSKMiL+ROo2KjZbxo1YFB7/JjiWXuLsabl4hOtPBit82ocOIk3B
	CwCHgSax1nE374GGfZqzF/kFcLBqIjRKezT6yIq0jkOtGA1YoJnmd7bRD5Vcx9edkwJNKmRbF7H
	3//hl001TD4oBYnY66+76Ly6e+K9Hf3fIMKdA1kTK7GUNO7neNmNEp+gnHotOTjXNCoV6o3hKLF
	hsERTq0bV/zeoQy+G2ltvIm6DOWCPMAIfMBXaOa
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr65494075e9.4.1778079955640;
        Wed, 06 May 2026 08:05:55 -0700 (PDT)
Received: from paul-Precision-5770 (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5312de76sm18382985e9.21.2026.05.06.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:05:55 -0700 (PDT)
From: Paul Houssel <paulhoussel2@gmail.com>
To: paul.houssel@orange.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Paul Houssel <paulhoussel2@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Florian Westphal <fw@strlen.de>,
	"T.J. Mercier" <tjmercier@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	"Paul Chaignon" <paul.chaignon@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "Stanislav Fomichev" <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH v3 1/2] bpf: render CGROUP_LSM_NUM configurable as a KConfig
Date: Wed,  6 May 2026 17:05:46 +0200
Message-ID: <20260506150547.767315-2-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506150547.767315-1-paulhoussel2@gmail.com>
References: <20260506150547.767315-1-paulhoussel2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In include/linux/bpf-cgroup-defs.h, CGROUP_LSM_NUM defines the maximum
number of BPF_PROG_TYPE_LSM programs that can be simultaneously attached
using the `BPF_LSM_CGROUP` attachment type. We set the value to the newly
introduced `CONFIG_CGROUP_LSM_NUM` Kconfig option, allowing users and
distributions to tune this limit at build time rather than relying on a
hardcoded value.

The option ranges from 0 to 300 and defaults to 10, preserving the
existing behaviour. There are currently 273 LSM hooks but this number is
subject to change. I coudn't find a MACRO counting the sum of LSM
interfaces and therefore arbitrarily set the threshold to 300. I am open
to suggestions on how to set this limit dynamically or not.

Signed-off-by: Paul Houssel <paulhoussel2@gmail.com>
---
 include/linux/bpf-cgroup-defs.h |  2 +-
 kernel/bpf/Kconfig              | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index c9e6b26abab6..9ab5ca3dbaba 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -12,7 +12,7 @@ struct bpf_prog_array;
 
 #ifdef CONFIG_BPF_LSM
 /* Maximum number of concurrently attachable per-cgroup LSM hooks. */
-#define CGROUP_LSM_NUM 10
+#define CGROUP_LSM_NUM CONFIG_CGROUP_LSM_NUM
 #else
 #define CGROUP_LSM_NUM 0
 #endif
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..050af0b72651 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -101,4 +101,23 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config CGROUP_LSM_NUM
+	int "Maximum number of per-cgroup LSM hooks"
+	depends on BPF_LSM
+	depends on CGROUP_BPF
+	range 0 300
+	default 10
+	help
+	  Maximum number of concurrently attachable per-cgroup LSM hooks.
+	  Increasing this value has two memory costs:
+		- 8 bytes per added hook (due to growing
+		cgroup_lsm_atype[] array in kernel/bpf/cgroup.c)
+
+		- 25 bytes per added hook, because each hook adds a value to
+		MAX_CGROUP_BPF_ATTACH_TYPE and thus increases the
+		effective, progs, flags and revisions arrays in struct
+		cgroup_bpf
+
+	  If you are unsure, leave the default value.
+
 endmenu # "BPF subsystem"
-- 
2.54.0

