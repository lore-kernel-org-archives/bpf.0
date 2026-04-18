Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30033DEFC
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488230; cv=none; b=HpGt9JVpNIlQ42L89a4kHI2ObXCKlDuQluYv/PeNsyDjmBZ5vWW3MVaAVixnpTYPCH7nGzJkZO4WDvQ8Fzgl7NlIP/slMtHrGT2Vq8eFOwiiK6FwfVhvZ7tcGcwRsIyBBAXs4+jqemiDpDBiIZSLOMhOQMHS8ydtOXUlZtmhkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488230; c=relaxed/simple;
	bh=PO+dYX/F8E6E3r4GYYIN8Sci3WTYu9lNvD2ARzd+ONY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tF55FZfJ/1YnjUpgr1JqYBSXE3L4ZAGn59GrV1EUsFribpbn5iiBVxnTxEU7BVZzAZ57P0oUwr9HOnE4ufqocsXXSCoqzPBdu73aDCR7Nm/gl5n+D/RdJq6w+jFB4WUb3ZB4Tb5p0qVryW8mJPtDwVkm9cLcPuLky+T9OskrDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI4VE0Jx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI4VE0Jx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so1432163a91.3
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488228; x=1777093028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QXV8vxINpWlyXocdw7x8mtClIUb+GRxRnLWTH5Veis4=;
        b=bI4VE0JxCvpuRU4axQDDFlFgQYa3tX+P8BNfDQvA3K5jvQS4zIfOvy9lcb0ldUszj6
         8JvP6dVN1akbeiju+NZTE8zHMyfpsmqAa1Ry7mnZJUByCLVFL8NodbTTQuyzqw6wTLy3
         cufzm6wLGfoW1Du+PfSAcIEtrdz4xbUzUUSA8GkpkTNArp7SwD0YtFLiu8GVE59CI2FB
         f+QqqWZzz8oDQCYP2udytGFQ6r7KiQpUaVgM2s5sjozRHYEI0zPDpuJWhWsZp7dalNGz
         //D0laylsCnkPYCKmozTFVUsxFdmkEPfVTLv+f2QXrrwKkgZAaqnXfqbISl2XlBWbH6a
         Rz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488228; x=1777093028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXV8vxINpWlyXocdw7x8mtClIUb+GRxRnLWTH5Veis4=;
        b=SCF084Qkfn31Vpi3vPwDC+DxIjHNkQQC+ruY8+1OTYf4lpXW3BphLOkM33nnypIR7i
         Ogfwli9mMgHHgoCkRzRMfNTwsNHHd1/49stkRSTArVnLdTd7pNAmxtiUIbJ9kzXRj5eD
         1ZYT3O6nVsHA0WrcdqDzHmXh4cG1ld9MlKiMi7UV8T2PHyjvBGLMIPwv/2Ev3vL/6Z8c
         OMOfd1AKJ+TuBGMFhLgK+L4MtyzdRG7UwfgXldXu3GuiUpPEQI1PthAZzrIGVRvFZOrc
         USFCv8s7pnCFkMoGP9WQO3MsMQumddbp/zR4kVshgZWtwE2tbvOmKOUl0Bf8SHGQDNyg
         aLgQ==
X-Gm-Message-State: AOJu0YzZ1V8STLIQ+VgvOPjaxxQWjPPZGSRoCcXMjc0WlVidvWcdnc63
	5f2VIlhKVwoLR2ckX9cY/FbDYCmZgiyQhAl4yEUR+ywXZGbgrEEPx0FX
X-Gm-Gg: AeBDieuESbPzguP6cdlimdwW+hUjZhJwBeQIE43RFk/+nnRE3ShEjcW3xAx2kX3BGF9
	qOlgF4gFxln4M/4o75GPYrlumDy+eLsIren8PM9kENXvUsBtTmUiLq7ozBbVDVxIAYVFXzmyMhs
	FXyCFiB2m/0s5OUFmN4YeB2oawcbYFjYCyEScep4W1DpsET4qzpQsgMZ3Nr4+PDmhL4WqrdyUms
	lWTge3YF3tPKDM8DdZPZ/Wk2WbDYHptEHqZ1wViaXIAgnimy1sWR9914rrC4KXbm+W9MR6Y83/w
	Zy8K2OpGHe3OdRmbR8dYyPy/jpld/AS9fAfOBvh5D4oCyN2i7Z9dAifUrVN4r9u3LZQBSwpG31i
	qWNK/AOxgNAxAC7UZpC51zSRfm1EZHIq8RScNHvK9zWx5G1954eyYP2QQhhcfSiAiZFt1YO7ZHu
	qRd9+rSQ1ky/BxMAL/cHge1THP8W+BXgavDGuQhr+4MIHiGFqBnj85RdEWV0heQjt8dupu7eqQg
	SWFnis5mw==
X-Received: by 2002:a17:90a:d607:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-361402339f2mr5898880a91.0.1776488227780;
        Fri, 17 Apr 2026 21:57:07 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:07 -0700 (PDT)
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
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 0/4] xsk: fix bugs around xsk skb allocation
Date: Sat, 18 Apr 2026 12:56:40 +0800
Message-Id: <20260418045644.28612-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

There are four extremely rare issues around xsk_build_skb(). Two of them
were founded by Sashiko[1].

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/

Jason Xing (4):
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb()  free_err path

 net/xdp/xsk.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

-- 
2.41.3

