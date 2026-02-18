Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0922EBB99
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388979; cv=none; b=F3XfmubvtzSAqvbe5mIJYmQ8gL8P8d6AkevM1MNA4vHxgt/nH8y8Im05/UO4g6177GP6RItFDuutf6Ske5JfK7S7Thi9DqMyLcq8ay8D4v5hp/bLr4tDEZxJeIyDNsI2hb648/0iM3wQT99paCUi6zSRD5W12uEYfvPhyRNkeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388979; c=relaxed/simple;
	bh=dhvoDsSh7tHUJR13TIhX9yNmWVj8+ijL2aeiCvX8TbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qh9TdtaR0MC60h9p+evgzxHcGelMgwcrfOY6ORBhcBj2Wlw9gPA+8l/AApbE2x4MCqdOem5i5TlQrFYB+S3+eAteiEET15LP+7ll/OX0kAlIqv5RJL6E7JnIpHcK9cFYUAl9h1ZFKgFuN2Dde5+SW9+w5RBzOk0PACldoVKlt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1Dbwot5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1Dbwot5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab46931cf1so2939715ad.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 20:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771388978; x=1771993778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvzlN98l7/BarHSO/majX6xw5/psg69bWsbBzuUD8gg=;
        b=B1Dbwot5Lr0a9OnjCsmRGbs6P48d771jwb6vrPlSrBXpO8HdEpVzr5IF2FmN9uCNmL
         oqZoGkEEXibQPdc5EZQLxLDgDPJp4VmDHWOhVKo+bdJ30GUVqik1I6VqsiRn4dbJsH+b
         PPpI6Wca2fPzQ2KifDVQHCiTxn8fWvzdDLuvGBiMWCivMaKg/5tODs1vuJepZSCq+8YK
         OipWI5cmcslx3Qz8RyhGeev3nDxwOCBdMCs7+V3Mt+49EXYnNQFFuLjyi+Hpcgg5EVJk
         WtN5bjtXp1WOVclhUm51+REi0d50tY7Xm8NeUTsUoRNtyyYRJrFeqDsUfCmSljDoXtAQ
         Iuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771388978; x=1771993778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvzlN98l7/BarHSO/majX6xw5/psg69bWsbBzuUD8gg=;
        b=YjVu96dwy6cS8S0MWg5oL9NhhGrGTWLrAnbnHWPH8k1Itp2QN/w6FOhPV4hdP1rIRH
         oofUUJ9ofl1U9zRnawOqzThgYSJfI8OCpYZ1oxPYJ31Kk9hK78dkJuLnodLLwOI7wkM4
         5mBrOnoINgdA/8Wkg5qDH6cksV2V0AdB6bUCgprhr3E383TepJi3E37mtZD2c9TYu0Fe
         rxxBcrNh+/Xw6JMLhX84RY3FLC8BVdG44b8/lAn/u5OXxVPl4bryWpMYBZ/wxm3QNRoA
         Tlcc8Ufb2DbXL3rN9XM7U6xkKx8U6RWPsHKE0tP3Mt2bf8qMsfkE16iA9+cjNZa+FBZQ
         5JEA==
X-Gm-Message-State: AOJu0Yw/yFEYMJOnos3Vy0rsUtl/vkrUp1q3eHMeG920AMaSyW/Qitet
	x5QjYGUn8YdIIzlPschKYfBn/fiYC0CiVgTUuLqOZYYvqrv79aif2QLcCDUMOKyR
X-Gm-Gg: AZuq6aL2NqruCQMW6Dib3SripuYJLxwOFsZHDpjTG7N8zRaqEsOKex/sY+naOqmgmWl
	tOOreEIIA3gihYFukiQLtvkgFMrHNgs2Nm0wpt78WqTQmSKVXsKhoBj0Webfg70CVeF5haqLlFr
	C/5aKwb7OlGNVd2ssnYam4ywXwjGqcjC366Mby5sMOV1yjSGZum/bd+I7w29KRyYfUBap2ukX4Y
	Ohe/m2LnvnKQ8+HlWcy5P4kl/V6KEajykMbDbDHVgAUmhJ6j3veoTUNoGkcZ42kmdPXxNUMSA1k
	r4DZ4nVZo0dyMNALcSQG9zAs0/tS5MrKnAkUN+6dmvVoHxG11dLcsSAPX/Ox5hwqyc8R533mknq
	xy+RXHiUCy345XJ4a13ljYs09x+FIhLDK+Cdll/3bsWOT+MZS9aC0HL8QsEKOKHq8hIoRu7Pitq
	2ce3NlYWSzGd24kLgmGI2RG3L+ufNKgqui+q1USkrrdVuZ1E/XA+ifwP2fjZ3JES6Ce/cN0AB5s
	RZCdi+A8dOH3/M/Ko4aydkFqK4HHg==
X-Received: by 2002:a17:903:2c05:b0:2aa:e3d1:1430 with SMTP id d9443c01a7336-2ad50c3d06dmr5488015ad.23.1771388977806;
        Tue, 17 Feb 2026 20:29:37 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:c906:adbd:f506:1dbc:e3f3:e38e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaeb759sm105165865ad.83.2026.02.17.20.29.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 20:29:37 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH v3] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
Date: Wed, 18 Feb 2026 09:59:24 +0530
Message-Id: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_map_bpf_prog_run_xdp() handles XDP_PASS, XDP_REDIRECT, and
XDP_DROP but is missing an XDP_ABORTED case. Without it, XDP_ABORTED
falls into the default case which logs a misleading "invalid XDP
action" warning instead of tracing the abort via trace_xdp_exception().

Add the missing XDP_ABORTED case with trace_xdp_exception(), matching
the handling already present in the skb path (cpu_map_bpf_prog_run_skb),
devmap (dev_map_bpf_prog_run), and the generic XDP path (do_xdp_generic).

Also pass xdpf->dev_rx instead of NULL to bpf_warn_invalid_xdp_action()
in the default case, so the warning includes the actual device name.
This aligns with the generic XDP path in net/core/dev.c which already
passes the real device.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
Changes in v3:
- Dropped unrelated queue_index changes that were accidentally
  included in v2

Changes in v2:
- Pass xdpf->dev_rx to bpf_warn_invalid_xdp_action() instead of NULL
  (Jakub Kicinski)
---
 kernel/bpf/cpumap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..39959bf542f9 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -221,7 +221,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 			}
 			break;
 		default:
-			bpf_warn_invalid_xdp_action(NULL, rcpu->prog, act);
+			bpf_warn_invalid_xdp_action(xdpf->dev_rx, rcpu->prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(xdpf->dev_rx, rcpu->prog, act);
 			fallthrough;
 		case XDP_DROP:
 			xdp_return_frame(xdpf);
-- 
2.39.5 (Apple Git-154)

