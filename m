Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433001D6DA9
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900262; cv=none; b=tOT0tbBg+7yPfbTqnzS9QfsNc6JafryoH64uVLlOzwfarv0c06SbvS+vZXBejBzMpXjUpKn+QTSC1R/tX8zlGDzRI384z9yr1gAelpkIfPdwe0Mstma3HjwmcipDkQCkCqCy0gZQDm8OCN8CQ2eOCkEpGP+5TuCRLRgGEfLzPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900262; c=relaxed/simple;
	bh=dO5ceCHRyFcG9tsPv/Uy5m+t2oSiu8qdhOWY0CG+Ixc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PLmP84cSkrVs3tie03cHW3DS9pJHOHIkJiDS6yV7/FecOQSujyBOx29ll/THVPa0bJVhA4udp4QUZEmk3CGvs6jOg1pp6ObpyjnvSR0vhxUBzv/kOlyKYxGI6wQAADnZowT+mlJyae13D37BcxIjLy/fF+O6DqWSe8wvBVEoaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRJs9z6H; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRJs9z6H"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2250011a12.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776900261; x=1777505061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=20Hp+mzF4LGGtn1pS9b/voWfhrJdUMGJ7yQHT8sztDA=;
        b=NRJs9z6HBoFQLyYKltpHme0KhSIixIB+dGngGianrnzGJhluQVZaqohv99ExsZZQun
         hhS37I8526O+xAbneFBEYWyyud2cI+THI41yitJYqTJ5fCR301N/dOkL0DRzdvJUCohF
         e4IYdxnPa75xRJhGXUUX2h1cF0CPa9M2quIC95lEF/5VoOgRzmRWy/r66Bw+BWgIk5A1
         jba19JLhlDgp3YBErJD1lRjhhpJgyWQrO08MMR/JrMsribAhRp/gm2w5dV5recPSxCq5
         u20euoo4U8T9XMNhEgDdsaR3dtiDwHITUTS8JwzFdcxi78pyKrBmbo9ZAA80yqHtvmXc
         hlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776900261; x=1777505061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20Hp+mzF4LGGtn1pS9b/voWfhrJdUMGJ7yQHT8sztDA=;
        b=NpwMT5vhZ2gqcp9u62c0EP4aPcaiC1DFTy6u6VUvkH3oQDWIncAY8NycKXMfieKtJq
         Sjg3245/TI7+ipiJA1akCt1vrAsmlfC1CLIAnRSAlyQj9p/FCXxqpSMnuiX57SXOzVS2
         GJOwGjIoBPattYSoK1xlos99vf9QOWIFQ1T1GxbSULrt+Drn61Yt47RKXfErmF5q6VRG
         dNevdSmPnp4i2uAfyYhxdVU7aey93EaWpkxRhIcSsluDeOorMWi3t35O9Vz8+jfWMOWq
         Ahe9WV78kZS2iV7THuL/xEmmj6eKRr64ZsC97Vf33RgordnyT5EMtGQYoIR+J3LkpGoJ
         DY6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+NUAm6ffYuHTlXzQneAK0cRc5dhvTBVUd4wmIq43X3TU6PJ7JEbaTLQmU2IDlB/Z6GngY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZXR1UOTn7LmJ7hSlS96QyfXJbdx9t/DnFwDwLJfMRjdZciv0
	3Sd2SbZumv6qo6MYfxhoJrJzpl4gZDZW2vQ7cgGH0CqVAItqxeMjRxab
X-Gm-Gg: AeBDiesRdppeqFhP6uL8YtoJtNygb7oz1wWZ8Yqd+MRYWZtLZvxl6wsnw1mIswZN1by
	HhmhXW6pVBJVvnt3MrvfReYQPMkvmsaPCYoZ6pxRG39CSGNLtImI3mdJb6vGz7xX5jHrCM4zbN+
	NAVWqX+u5BpN8/BqhOFe6scQXnYusOPV8tdhUbC8NFrRHn6tv6gkqlmwOvu/ElyDM9IE3Huv8CB
	E14IAR1Cmueyw80lnDtKygys1zQIFxxB1seHS4NTLPRV/qUwoV7fTIngp2DoHYn3MeyTQ2pseng
	1ujXGD4xR04lzGtrWMFye6b0TYISAjzkUkDON1aZzSLYPdioyJuCxxFoJYWs6dpiEECTSY2ipsD
	kGbtf1F9x8QRZRqPp8wa0xoSHVoy2rdhrS+nKW7eqsKyW7+KGX9rOXMBDvhYVjPKIwKol4Od//3
	7FfeMaZnprzSyM4Mvz5oC49HOuKynadsijw4mOaxni1RYk+0Sg1s6V
X-Received: by 2002:a05:6a20:2591:b0:398:c0ba:9ceb with SMTP id adf61e73a8af0-3a08d6eb0a9mr27188226637.12.1776900260501;
        Wed, 22 Apr 2026 16:24:20 -0700 (PDT)
Received: from VM-0-17-ubuntu.. ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f920e1sm13776248a12.2.2026.04.22.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:24:19 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
X-Google-Original-From: Hengqi Chen <chenhengqi@outlook.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	menglong8.dong@gmail.com
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 0/2] bpf: fsession support for LoongArch
Date: Thu, 23 Apr 2026 07:24:05 +0800
Message-Id: <20260422232407.3862942-1-chenhengqi@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengqi Chen <hengqi.chen@gmail.com>

This small set implements fsession support for LoongArch.

Patch 1 introduces a helper named emit_store_stack_imm64().
Patch 2 implements fsession support.

changelog:
v1->v2:
  * rebase against latest loongarch-next branch
  * drop patch 3, selftest is enabled by default
  * add Reviewed-by tag

Hengqi Chen (2):
  LoongArch: BPF: Introduce emit_store_stack_imm64() helper
  LoongArch: BPF: Add fsession support for trampolines

 arch/loongarch/net/bpf_jit.c | 99 ++++++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 20 deletions(-)

--
2.43.5
