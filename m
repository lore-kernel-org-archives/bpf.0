Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76C3A3E9A
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829056; cv=none; b=AI2eGrtXwsyL/nz0FMDxET0DmHkWmDCCeefTlo2+AHMtUQpCpvzGEaSd9Dmxkofd1yomN2Sl1YNV0lOWjqItmo6JGhEyfBrYbZW7Q789MlmWKpAGhEZXQQn0sleByxPNH8hUu+ypDMxS7HPAStMOPyg334fv/x1aFaTlhmReFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829056; c=relaxed/simple;
	bh=zre60K07SneaVEDnlumeqWETssPMwhdZUrCSxPquNPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XfMWE0YRQD7iCstP4xBB/MU6TKob1Ukwyor9X1KnPwKIwjAXMGVGkz9k7efi03YXr5IsGfbIFXOpePlgRuU/rtVLo5ShEBkyUNVqJLLoWl+vB6o/SRxrULYcGgLy7WHikd0fphZDn17/j5OrbxKm2GsEbaj2rt9z1tegmLb+iI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSnd1dRp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSnd1dRp"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82fcd0aa2dbso702444b3a.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829055; x=1777433855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1Miu0qXqAhnqzY+X70yibbH5j2Y+ZT2djf8HDzTjHI=;
        b=BSnd1dRpq0jT98gWfP71yw6v716PXltpko85Nf6e2chbC4k3CckVzi8ScYrkOv4QGu
         OYRYFoRFsBooTlz01zGHIiT31gyCn8L8dPjYHwKNGIwUCe9isiy2ULouj3fOzTF/QHxD
         yeEJ/SQqrEHJ8iGKL707zhsDlClBTmvFe3LF1E84B3N9m18HP0hXzzD387SOvrCq9wC/
         z3YSi/Tni+49WBxVXLVDfsxa1ploKP1Sqwr9xFFaeif0/v4nSZGCcElkYTBkKvlHOyyj
         9UIbcCpOEpYOShyTksooGOh+nYu+LpLaYQnNHfzAO0NvgTa3ysJSfCeP7s//okp417Kj
         Nixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829055; x=1777433855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1Miu0qXqAhnqzY+X70yibbH5j2Y+ZT2djf8HDzTjHI=;
        b=DQLPGtD76YxQSBXACu2sToILEpJOPfAEZL1pQWSShKHN5IzXXDHidGWzpfk+24n4VQ
         6yCyUETXCjOIFlqF7VKY7YRtoK49Lb3aJbL1JtbMsSWUitYHMV7yGTeGD0et/rmck3IS
         EizbzODgNr3qn7/k60ezkEgLJqx5NJr6Z3f0E6Hsv6CNXTrSCZq/fsI1KXo1AsFjfMai
         +Rfb79kDeUgyTt43qIb5c3zI9dxWNAjjybeC+EiI4OcEvK2FUHIesIWsHvjoaoeAMI4S
         H4KpvRCrBlap6cXizk+qQuu7MCAWESrOua0kJZNDcMMcv4H6+QgL0zUe9VAUItasj3h7
         9DZA==
X-Gm-Message-State: AOJu0YxgQLaSVU7lPB1MXmsD3tnKZ8QhecZDHIkOGkn3lPLHAYxs2QCz
	gXsdGPAH0w5jFSvI9WCodV8xrwvPwjmOc+2ezIaRvn7SuFh12K7BWSHg
X-Gm-Gg: AeBDievbztnrnUcRxjQRqs4lBb05AtEA4i/fgd4I3MiYC3iTWpfvt9cReMrVXAzbzUT
	DgNBnabWl/I1vXdHvR9Uv0bRmaQ8juXRQmS01lnfKPlXN+XER30hY8YPXhnABECUqt5ymrYTfsX
	qf43k2RNowQ4uw99oHj2jEqfudkZFKCse0LpOpJ4DLK0/aUWTodidrDfwBSjzmUeiArLlZqn/hj
	ZBlW6G0zwohfZKrmQppf4JYmUnoWyLT74PNOaIByn8I6mzxLOEttjbURMicRsRVlqcFGBm1eRZU
	7ButF963OXYk+0d640NZEKIP6V8VnAntX7gKxVIARJfCcP40n+KaFpf50Lc2K7HWLiBnK1w9i8d
	yP6yqISO11euALfbVpXa0QiVHKN8AO0QvzP/fFMcDXC8Sao+2Xo+OEqP5uMfg+7wyl2lRfxzJgQ
	PtYeoqymPeNNB2y4QILWgrFj09CQ9c82HJAHd/UZzzN6alnkC/S7tR6hEVp160vlm5cvTQ4j9xQ
	pOVH2hR
X-Received: by 2002:a05:6a00:2d88:b0:829:6f7d:3086 with SMTP id d2e1a72fcca58-82f8b3aff42mr18281441b3a.11.1776829054634;
        Tue, 21 Apr 2026 20:37:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
Date: Wed, 22 Apr 2026 11:36:50 +0800
Message-Id: <20260422033650.68457-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
uintptr_t cast:

    skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);

On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
mode the chunk offset is encoded in bits 48-63 of the descriptor
address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
lost entirely. The completion queue then returns a truncated address to
userspace, making buffer recycling impossible.

Since we hear no one is using AF_XDP on 32-bit arch, we decided to
strictly stop supporting it at compile time.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
index 71af2febe72a..819aa5795f50 100644
--- a/net/xdp/Kconfig
+++ b/net/xdp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config XDP_SOCKETS
 	bool "XDP sockets"
-	depends on BPF_SYSCALL
+	depends on BPF_SYSCALL && 64BIT
 	default n
 	help
 	  XDP sockets allows a channel between XDP programs and
-- 
2.41.3

