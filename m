Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E830E0F1
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050285; cv=none; b=o4xgNJm39fgWX8Ti5wCeC68fMU6dxxyMr/92n87f7BPwIPs0BueCCCdeT0dva7IpmVpilhCTurf5BxRTHkNwJ0Nr7SiMWzc8GpSBoI5II9geaXTY3zIL9aETZUssL7bIpzx2vkSmrS5MAfwcjH0IgeNPmxRNUYRn8OV2ZIoUsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050285; c=relaxed/simple;
	bh=Rgu892ClGz8u9r3sLpO2pXXlmpB2fJ6rfL3JjWq0PlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLgboiQEeXXeEqlQ+C/tQMLelol8AHqqqe+0S7qurTlMis6SwgJYZYxm6hiP8++9lH9M6funjeU0FMpz/+xp9fnaLQoM5HyaVYakHifpAVZJIAtEr6kJEZFo+rUbinkaiet7jWXHdiTMKjDcKh7bzBu42/jtMcYqV9ILUdWAZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRJ2Ov9H; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRJ2Ov9H"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d146705b4so19843295e9.3
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050283; x=1778655083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmcz91A+q1chxpcdNA1/d0+Ln0Rl1gOT3ZutJp+xmLI=;
        b=KRJ2Ov9H2DELBOtOXh1IlaKrKyuQhc6OKyOBDwD46P5ULrwhrW8gJtbfatKZLv/KKB
         /QHhl5WRaLDMCP0ubD+NuKu/hCermPjPLS2qRlvns3VoWCQ1oQ6bUZ0EIZhUh0iFaDyP
         +wp+kJ31PhMfRdxxYWBc447zKmkN31b/Ypkdchdxd4/lX9oj0U7O0ufLukg6/wvfawa+
         vd7T5gfi/NIrUF/7v5nyICZgko8z2qglxoJR/ioPsOJ1NcjQSPk97LF/MzjaNP/fv/6V
         roq0CbDHLKBUQv0kuDq6OZVT6MuOaUTu4J69Erc5pL7cy7Ae4mLJ+o/8hmwnL3HNTpFw
         c1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050283; x=1778655083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmcz91A+q1chxpcdNA1/d0+Ln0Rl1gOT3ZutJp+xmLI=;
        b=A+wPq8QzTT7NvnKAWB50Ti8yS+m2Vgmvuftu+JdJ5gWD8WLurjFw8BdT+y8yNX/vMT
         Q8QnLYsnYl2I1hnyuFZVBIhmP+98lSi8ECFFOzfBX4HAj3Oa5+4hhneAyds7OItsbzki
         0plzNRSsARCu+7E4MqSBM1cyi4Aszd/DRXt+SvY5JmiD2WeK1yJo6rc6ogd5Mz8m/VGG
         ze3xZvuM3YDXSXydSJ0tTsM411HtI3IavhfT/UbXuIdEvqi1d+3XGSTC05+uEj49bzmw
         QKlec7OkbDNKdLq1x/7MtUHxRcMWG7x9LLVkcJkxaJtdVx6qkV3haP4xZOi51UOJf9o9
         suGw==
X-Gm-Message-State: AOJu0YwhBLQGhga9wKOHxJsGphH3FG2EGjSTZ74MbNNf6YkpuxSkyczH
	U7xG0ODXhdyHs3WUU4LXeQKywUfmh46kw+7Ys0Y/TtbPsqn6HqKpN2g/
X-Gm-Gg: AeBDieudBPGE/arCwZZ8n/Kfunp1voJR7n+GLoQlCW5zAYhernC4o/f/+fOktHXXUjc
	nQYqW3Q3XyzHJkZNUFVRS2IhO/JLnQVN9LRQQSS+qXRROu/gJIAq682NduGHAq06aLxifamP1EW
	87ek32fO5jVvcKti/jN0k/PdLhe20i94mej6Y8rzfGxNcZacZ/slZ0U9Fg0k6CdvT9WJZVcuNdy
	bJVLyMLo3LT5HcuwPj7KEOmBc+XpinY7pJfi9plMd2KFrHAZ/Awu08kFglNv+4CLuocC9SpQjnJ
	/YvYsyt5hYGc8udEnj78W1gLmF99C/dPDr8EqUuFUXtmD9HboEAtL3gMtfDkFTM+s+deTMwn0Ea
	11gkReKNGAKuizBmKCTAjuZL0zCUVNOKVZyhFXZIkB4IhAS8nV+fc47xRuRg9oA/Rd+B3wF7dKi
	ttP6UWZvw7LIUZJ7xz7f8WA7wmV5GxiPQgpYBJgHAfb89402twNuVjtGHEtEqIHarievPMtSfUn
	DYl0FMuJUX/YKAM3lQIuZbSIUe5zO8atLy7abUvCAlefC4UItg=
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr32206415e9.17.1778050282613;
        Tue, 05 May 2026 23:51:22 -0700 (PDT)
Received: from paul-Precision-5770 (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aca14sm23526775e9.7.2026.05.05.23.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 23:51:21 -0700 (PDT)
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
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH 1/2] bpf: render CGROUP_LSM_NUM configurable as a KConfig
Date: Wed,  6 May 2026 08:50:47 +0200
Message-ID: <20260506065048.592474-2-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506065048.592474-1-paulhoussel2@gmail.com>
References: <20260506065048.592474-1-paulhoussel2@gmail.com>
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

---

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
2.53.0

