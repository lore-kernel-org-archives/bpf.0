Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4EC45BD57
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073197; cv=none; b=SIRAyj7CBhHpOSJ1cG+p+ydNWmCyGkdKUJfklbh01xrtfjumsSK5hXdl3MskCFbGfSG+oi9qnaqvN4wU4uY9rAlLvbqJ2sXV1ccQf8svMcrj/d9qxCY6vwmKSriq1bj789ru7UnlXFixUtzbFNI8m3BvH5+BQtQdGPc58+SSIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073197; c=relaxed/simple;
	bh=hulDqSV2SB4fX0ColyCIR2/NnCfHNTPhNUt9R5c3/bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVAJqslaeEKhX+2rz/uP/TBgOj9/fBUU1FdBaosyko+PpaxI75fmb1skfnMI2gmu0HBzo0iXIAB2KbIDV3Cu2H8Y0VixIfDTWlzBhku6LwtzSV2PXc+7QXaBfrsQBEYk+2vxTUWCYuMxWn1Ceup+bgSsUfg/DQuylUOsZHBanoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrhjmf6K; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrhjmf6K"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso49571815e9.0
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073195; x=1778677995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5Ukbjpxg2+Ma4qNPzHoY6d0WoOM53MZUoO3D33Lgrg=;
        b=nrhjmf6K3cjsIQv0pvd+1oNAvXYOhjF0gwRTSJKNe+7cjseCSGNoUn07OxswOMwydq
         jxCoHDJEemzpZvAV2qvnzXa6HH/Xb7/aueI2UtL0gUlRWqDmTjl48a2h8bxtfFZLvt+7
         cnhxVTsPOxTyIWPhJULe2PMqiRdqFZtAZkMWMznjiPCLCfbq6jWHjk0ZziJMAZ5KcHwM
         4pKGi+5JKnOua2UspSGGmnn1fMEghnMZFQiLcmnvVlAY4XBXZXRC1UcaFRLBK3EWdmT/
         6R3h4BIgY71G7gL/L5LtiMnSjPs/rsRwjlqN6IJrFVUMCTEmkviOe+n7sVfO34ZK/vhK
         /Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073195; x=1778677995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5Ukbjpxg2+Ma4qNPzHoY6d0WoOM53MZUoO3D33Lgrg=;
        b=NF3H+X5fcvhAX2J23/Zo7ckreVHqeA8Cw26BMYaXBiqqu+ZogJDz/v8OXo6DCU/4o3
         flYPKATCixc1Ygajs/eUUpKPsCmbnuJX0MgxmH6d0fXo2bBDHaPlpJSKD4XVMGxU1yrt
         28xRiAyAmqBBBCTszH+F1HbS5nLrZn89xYWng4U+b004z53RJbElIv5f7ku+5PIEERSV
         eNPPJVmI9l1KyI+6spuWDkBLXR5Q9REbFmieYSrvgKSYoRjpwtDMNQRzyw4oMak1ovPq
         6R4qeFWN8iKU8gUb8apETB6g47NSQIKrhjKknzyX1OFaWdeKf8yGhUjj4y6IqF+jo/Pq
         G/eQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PhM+3IaVvTfs+DLwMgTFzShxJRwQ4+ze4e84e8P42q1JPJHRqCDSTqW6A6CGGeLmD3NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhMNbiFC4HCuW22c22JybslbWS1sQqohtZPW6+QtXqTrD9Hqv
	lgregpmBZ8Uxo1Gx0vGdxTU/csqcW2lgJ6q7DzwapT/4FKd9nzynisiQ
X-Gm-Gg: AeBDietH7UUQHd7NB5dU51HGKhfF9maqJVZPj09s7yDVGxfSzRF79s8cTBG/44LG7tY
	sNlJ9HmLPxFPUJzgFJuKOdgtreT9AkjP8oIGQggVTSQV8X+XBe42gepT4ac0HFmeHU1bHl7cfOZ
	XSCbWRDsDqYdf+MAlfBwR2COSFo4h0+MjGG6MESdE5B+m1VAb/A51cOFLxyx3lkn4SHm241PkSh
	vSdxuJBn+ojH26mYl6Tz1MQqqmkfFXuLmLWv/qWd0PRgv+cT0uiXfKcOhODVjMb1RuNViI54LMH
	rF70hXMWDWNTFx4lRHHyeTOZnIbmYA4H3mDkSZVMbjCCyL+4VEQHFxWmA24rcRZOL91RRTJesrw
	ghqVPG431UUExVDK6VgQeiTO3hdeLd/KOaQWrg7tNGnQNBOLWDvtrJt/DJlqZfHqgen40xLXWtl
	+p1H0+UhRekF2ToeQO4CB4APFSDjCnXrbQBrHIC+ZzQuHjpSU1yGap1SEDgw+X3p2y+C7pKgTZZ
	K/1xC3xWMvzh9Kxo+0g6pAS2hNKEOmmxOnuscjl2vIqFeBCFoflxBja9zD/Rcur2V6RIlqMcHo2
	TQ==
X-Received: by 2002:a05:600c:a118:b0:489:a4:e578 with SMTP id 5b1f17b1804b1-48e51f32870mr42622655e9.14.1778073194420;
        Wed, 06 May 2026 06:13:14 -0700 (PDT)
Received: from paul-Precision-5770.rd.francetelecom.fr (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53907a00sm43582655e9.12.2026.05.06.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:13:14 -0700 (PDT)
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
Cc: "Stanislav Fomichev" <sdf@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH v2 1/2] bpf: render CGROUP_LSM_NUM configurable as a KConfig
Date: Wed,  6 May 2026 15:12:56 +0200
Message-ID: <20260506131257.713895-2-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506131257.713895-1-paulhoussel2@gmail.com>
References: <20260506131257.713895-1-paulhoussel2@gmail.com>
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
 kernel/bpf/Kconfig              | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index eb3de35734f0..7f51598aa8fe 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -101,4 +101,17 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config CGROUP_LSM_NUM
+	int "Maximum number of per-cgroup LSM hooks"
+	depends on BPF_LSM
+	depends on CGROUP_BPF
+	range 0 300
+	default 10
+	help
+	  Maximum number of concurrently attachable per-cgroup LSM hooks.
+	  Increasing this value increases the size of the cgroup_lsm_atype
+	  structure.
+
+	  If you are unsure, leave the default value.
+
 endmenu # "BPF subsystem"
-- 
2.54.0

