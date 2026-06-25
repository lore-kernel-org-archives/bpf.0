Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83D2E7394
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411365; cv=none; b=FmgV5PkHUpoujsLlJ4no4WsjtvxaSOkQZGYIlycQ5Zox4k/6x3QAU4K6PyCkzu3T6Acw0k7LZWNvGFem+/01AK6D9mkBfBBG4aGtFCq7KUVTS9wWUDPy+KhVLfFmgQIJmeD08hwQJsxNig+jVGICKZsmIxGENxXcWZ+itHHgBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411365; c=relaxed/simple;
	bh=R4zMRsC5dgEt3GQ1wY+GOgTcL+mtlusQkycwEbXBb0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VmdpX1wsEjQbSeemKIw9sBL+RI9k1NGlHX3NkdTUtxivzNVno6o+/qOBvwHqJyiYf7Qu96FBC7oT62Oryr4/cIJ3vbt2eOwfqdG7m1bOn0Y7qgJBsqfLYarADgX54FgWu2vkK6hXXvZtEH7WO94xlAOxNyPT3WN7undCnSnJqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYvgCGwt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYvgCGwt"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c856470fe9fso88830a12.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782411364; x=1783016164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hbt4jAxuO3yIsMnFSQ/zOto2meD/sUjo/A+mTkmLM7Y=;
        b=uYvgCGwt85R1MSPJg9ffGwiyALwqY/ladzGbWwfSFILpgyLHrrkfcuTXzGLzTTnnd3
         Hk+wYStyrKokFa7eGH6722hearuTQVLF6uY9fHVMOi0b2X1nnAFBQcqZYhQzMgTzKnIe
         0qrVQadYPxE9YkBcKqD0Po8aNZMdiUYfBXr72TM3LGvoCp1Lf0ehQPx/gbLDQRjRA2M7
         V4nlN0jC22keZCOHTcnE3yjKoQaNf5XfYUtGMWjY8xcSDWFm5C40kUVwPGlH2yMdbNx6
         unlIguNHENRUahx7hMGGh2v/Ts63ehEwRvJ0TtXPb93vc9oUw6UXrSMYs0VhOFCPss6F
         g4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411364; x=1783016164;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hbt4jAxuO3yIsMnFSQ/zOto2meD/sUjo/A+mTkmLM7Y=;
        b=Hp33l+Ifz6Q3DW1RmAiEDb4/C80ZyykqXmrtJK+BR12pXGbQdweHz95vFD9NF4M5PS
         5HC8l9b+q43CYmAe0kkKZWolJ+xsa+Py5CQNH2edn/B38yk1zfL5PYqrwtgcYUqkZCga
         WTd6chOzrRm4s26cJ1LTkWPQgw4c8dDHiH+1AffuRjA+fogVDBWK4Q+ryAoadJyLX8Vf
         8UO04zMStUYYNnh2ZQdQLNS7nvk82uQeFsjepKpEPrA+B0113BU44JpJTamqtYL5ITuR
         g8pJSPV//dVtYa23sxZj43/LD2A1WXQ1hZeh9q3DjWX2if23jkmhiBLVI/ql/Fxw2ay8
         15lw==
X-Forwarded-Encrypted: i=1; AHgh+RpiTHVSlr0AB6jE+OliEFOr9QRqOxaNuP5xaLS/agEI+TstxQKP7vWanjr1ZcPfaPbWYCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoweQrsJH0LVScqFnidKQYjJiFt9VyMOsHIUiMgzoeXYeRh6C
	AaU/TSKWXRY6l7Y18UUVoTMeUbvUeCXPIEqKV1P//UOWaA49CupgtlgVgnUBnI2+LLadhYWk4A4
	3j12hRai78/pmUQ/C6g==
X-Received: from pjqa10.prod.google.com ([2002:a17:90a:a50a:b0:36b:a5eb:cb3c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3509:b0:36b:b1f4:e0ac with SMTP id 98e67ed59e1d1-37dfa25191amr3459010a91.14.1782411363681;
 Thu, 25 Jun 2026 11:16:03 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:15:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625181557.1086105-1-tjmercier@google.com>
Subject: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
From: "T.J. Mercier" <tjmercier@google.com>
To: kraxel@redhat.com, vivek.kasireddy@intel.com, 
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Write permissions on the /dev/udmabuf device file are not required to
issue ioctls and allocate udmabufs. Applications should be opening this
file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]

Remove the write access mode from the drivers/dma-buf/udmabuf.c and
drivers/net/hw/ncdevmem.c selftests.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 2 +-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index d78aec662586..ced0b95c876c 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -140,7 +140,7 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 	ksft_set_plan(7);
 
-	devfd = open("/dev/udmabuf", O_RDWR);
+	devfd = open("/dev/udmabuf", O_RDONLY);
 	if (devfd < 0) {
 		ksft_print_msg(
 			"%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index e098d6534c3c..8114a29692fd 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -149,7 +149,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 
 	ctx->size = size;
 
-	ctx->devfd = open("/dev/udmabuf", O_RDWR);
+	ctx->devfd = open("/dev/udmabuf", O_RDONLY);
 	if (ctx->devfd < 0) {
 		pr_err("[skip,no-udmabuf: Unable to access DMA buffer device file]");
 		goto err_free_ctx;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

