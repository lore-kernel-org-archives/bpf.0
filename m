Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06C369981
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765764; cv=none; b=URv5Xin1ZInZA1aoz5y+xaDAuYeUDjesTcVq22XZJp8MOd46IxqUFRpg4/00RtSmW4QNg4UFmcVG9/HsYB7O5B5smnsqYHAAAblHLlCyVFndbQDJqOCHMvxEBrLMpZBFnZxy6jsroz/Eweffb6yiNbTWoJXH/2DsJOupj6BvXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765764; c=relaxed/simple;
	bh=C7axTqlfG7G60pyOuUF1uiUEUeTK5RHQa1CPBOejIRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nXiTAVFmTJ2A8rZ5Rbz2IxTuASItGAKpSsWaEUoBcInrmRw4byFIPMzkmyWL6wf0ruzRYQHa9Tadh6ANEzWdtYfldzy+oweRpn6EVc/dmvIScAHY+AVApjzm0UeTtUQdwxNQm38+kwepJIUqi8WYuTQSJMiKiYQoJ9hYuR4+2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXGvD/Ll; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXGvD/Ll"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899fb030812so72394026d6.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765761; x=1773370561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/AP8E5XJ8w2KlHUFhUy/yfE7lKK41Envqr5bM2GWuI=;
        b=fXGvD/Ll7AxC9vmLryJ5ME+a/FVh/B+m0Lq/4rdF6eoj2dApNRPe/04TZAyLFxNq0Y
         618o0W30k8dPpoM67IrTbBuMrITIyvwWfTPopUu0kHOnZnIs1VI2whjWBusb0QwJkmVj
         Ut+wPWHGZxUk9zOxl+XY9xTDb+zz5i3gDsIUohWbRlNpQoj5btojlxtZBUoP1sscaaEA
         FnwOq0q3PuqCnRgrjp5OB1IvZpKUt6RchXIwtBGyOa74Eo1CHX5DYFGdZzBSgRbWH0ZJ
         WoYhS2CN1yPO1r61pk5CPl3R4MFdIrTwHQ+O9tZlYMqj6ByCsVXIZp7sTkkzsy39QqEA
         LQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765761; x=1773370561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/AP8E5XJ8w2KlHUFhUy/yfE7lKK41Envqr5bM2GWuI=;
        b=SWWHYZyC//5OY1Xk/8RXF/7NjvrFdCsKd4dHnkdYiSW0MlghSTOCl4Mj4yTARsUFm5
         13RPd/SH+Ionvni6LJTXJLZTwAiTzlG2+nYMqu5C2d7c0YYa+jVV57mHm13MzWbe9T21
         xDt2D6EsBKpC4febbH/prQgWAWQ/Y8/bpqvmaUiut1q93qf/hc5yhH011AZYICC5LPOQ
         tMsoH+Bc19lUMmEo90AIWc2FAr2uGeekFaxWaQphRQYIG9rx2LiAuAVq72KrlXiChScI
         XasaxQp7deu/7rS2Ih32rMIEly8PWKCG3SEB3FEiEzOMrCkUD1CIViEwDDO9hy+pCe/J
         Vq5Q==
X-Gm-Message-State: AOJu0Yx08LBrQA6j06lRGg0dQDkTixT4FD40XUzBCQQPoouoxFfQ0cr0
	wAQJnBtRNXgIr6+PJN49B3dq+Hbxht5DHouIRBUV4MSW0NvDdIectEhkK8xj4D8d
X-Gm-Gg: ATEYQzzBSgzRB8ryn8nwcxcKAFrqfMg53WxT0ckttd9yaahXv6mm99kkc/1Zo0lEr2f
	3mcqzpfak0+MazisDN8NU3TBIrdYspkY/9Y3yG3iAgGcDSpFNi+YbBETPBSIeHXhsBYmDHoqvi3
	p1ujc/5+bWQiWGPl8Sm22iuTPQPqKFIf1tLcnzgXn0YWNHAPyhbEeq3ngIZSb+NWl4I1SWkX0ha
	vciN2AS4IPJCHO013TG/agIaeKT1N4fRq6HP6p1b7yq1ViwlA1RVTWOBUK76ktSMiC4/XY0u6Kw
	Aal0FoXgPP3TGVRRjj/WH0Ow9GvF42g2s/+r8WglmufwU4ATm1UsNkTfd6wNejB3WZcoC8M8KH+
	ekmYxGWfeIGtY/Fa2ud4TaMzvDU8JwibnWgAABEs7+dtM5a4XgBRY2NNFTP5NHCunobeA3CuNgx
	zEWwd4BVdaOmuP0C1Ol6uxcHDqi/g0TL/CfxrT59+P79Ai
X-Received: by 2002:ad4:5ae1:0:b0:899:e567:f04d with SMTP id 6a1803df08f44-89a30a1edb9mr7482576d6.11.1772765761025;
        Thu, 05 Mar 2026 18:56:01 -0800 (PST)
Received: from 192-222-50-213.tail19a0b.ts.net ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140d9edsm1628806d6.7.2026.03.05.18.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:56:00 -0800 (PST)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v1 0/2] bpf: Fix abs(INT_MIN) undefined behavior in interpreter sdiv/smod
Date: Fri,  6 Mar 2026 02:55:58 +0000
Message-Id: <20260306025600.870163-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF interpreter's signed 32-bit division and modulo handlers use
abs() on s32 operands, which is undefined for S32_MIN. This causes
the interpreter to compute wrong results, creating a mismatch with
the verifier's range tracking.

For example, INT_MIN / 2 returns 0x40000000 instead of the correct
0xC0000000. The verifier tracks the correct range, so a crafted BPF
program can exploit the mismatch for out-of-bounds map value access
(confirmed by KASAN).

Patch 1 introduces __safe_abs32() which handles S32_MIN correctly
and replaces all 8 abs((s32)...) call sites.

Patch 2 adds selftests covering sdiv32 and smod32 with INT_MIN
dividend to prevent regression.

Jenny Guanni Qu (2):
  bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
  selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend

 kernel/bpf/core.c                             | 22 ++++---
 .../selftests/bpf/progs/verifier_sdiv.c       | 58 +++++++++++++++++++
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.34.1
