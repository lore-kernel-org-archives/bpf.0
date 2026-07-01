Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534AE394EAD
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933735; cv=none; b=i87M152muadB711p5nMu6/kOMkvMxQwZ/7+5N24SW9BuYZwzLLdZMXL4db7Z2OdzdS5p5ZGBWgc5atmRzqpNWh9R1wekZoqlrqvgeFnxjYuKYtk4t1N/SqSSzaukAbSSPPpai1THeKWINrFnoRkQFGzL6pNWeK5Z+hfx5bYCH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933735; c=relaxed/simple;
	bh=JhnW51DmCRFybSnLbK3Q4pdM6DCF2s30FmXO1t7q5aQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jmC3oFlnWYkHG/hNcSaO6XTnD+k7cA6S2bfnhqzzXrn0WZDgCQ3t3RtU5xAoKWlnEDRE5WB5+AUyISGG8sd9oE0eZsOWGQBvJXQp+8zx1Zc9t1JjmthWJVMRZGk31XNLfcuKP1BliU3BoPZvtfuPWDNSm435+gNEbeN9JojCBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1uxoo+B; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1uxoo+B"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8478e9c4bd2so986547b3a.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782933733; x=1783538533; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujCabrnr2B8RujS0oeOv8POuubqI2CZlXpFMlH3f0oQ=;
        b=v1uxoo+Bu6qbzhYAaSfNZ9UgnocuaokAhFDh0jwe5kXWbV2zZsU14FNP817/TIZ04w
         fBYBmq2mjVOcrvFTQZ5rogBdwtQjRvC3MlnTcQ4VClp96LvvJKUuCWZOFqnqAlFBAXQ4
         uVBDgHtulnPHPx8PdTP8vDU5nCb9zTp/jhnmpemBdT5Vgdvw3DcwK/z8x5HEc3IAJ71Q
         s7nz9ghy1lSg4Av7qX9zPsq7kosKtYtxOG1f2CDH52WGTL1YvCxB9PHcpepSqPCEPkeS
         r5JQvg7bQKKi8Sv7hDQ8CYcoQ7yBTppN0UKX2M4pMWTw5xvfQ4jLpI0EoPaN426Lu0zp
         mPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933733; x=1783538533;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujCabrnr2B8RujS0oeOv8POuubqI2CZlXpFMlH3f0oQ=;
        b=bq98YOvRX/i3K3hBzgpRkIJqo664NMwl1xRjcVPM9/OVsSpBVfmxgUcYXBAy5YPGgt
         evskv7S/Ik7uZB/HhIv/s7VUR4+uFHLgKdg43h9mVSKjZjC8aS++NeYl35T36oalSYc6
         T9DLk0fAkxVKUMNL59cT3O/4Sf+qmNZx0+GQocv5qYQ0KdITk5amW6JxAwqGytG0b6zH
         fJujq63wyzwNhUt9Oxdz/oBtv25NZQMuqbb2JMLf5wamrjniPEcPssZeL5qwYa5yvzU9
         6oM1eXKhqxjyc9SDwV0KB52Cy2XIcYyROWEa1cbs+iTfzkO3UCNrvnrwpMODENovvoRo
         g6fA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6yezUc86+EjTi8zemgQJCJQroKOkHDPl51vzSdjRkRxkl5hyFNbS0YBhwTJ2m/gq+WxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2d4PoclzaAxWXr1VetnQbYf+taBZS8wZ4Cge2qjBjuFv4W/Ns
	vP/grCoh22Q+IRDkLyEsVSxwT0ws60glArgTv0AWX08IBH24rMedntV52Wy8s2alCt5y+2yjO5Z
	I0KdBuI8lDNZPAb7gRQ==
X-Received: from pfbjw34.prod.google.com ([2002:a05:6a00:92a2:b0:847:90c9:183f])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d43:b0:845:e4d6:bd2b with SMTP id d2e1a72fcca58-847c519386emr1793601b3a.48.1782933732340;
 Wed, 01 Jul 2026 12:22:12 -0700 (PDT)
Date: Wed,  1 Jul 2026 12:22:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701192210.2997769-1-tjmercier@google.com>
Subject: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
From: "T.J. Mercier" <tjmercier@google.com>
To: kraxel@redhat.com, vivek.kasireddy@intel.com, kuba@kernel.org, 
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Write permissions on the /dev/udmabuf device file are not required to
issue ioctls and allocate udmabufs. Applications should be opening this
file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]

Users are pointing to these selftests as examples of how use udmabuf,
and encountering permission errors on systems where write permissions
are not available on /dev/udmabuf. Apply the principle of least
privilege to selftests which use udmabuf by removing the write access
mode from drivers/dma-buf/udmabuf.c and drivers/net/hw/ncdevmem.c.

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

base-commit: fbb7ad31ab376c5101b2ac7205fad0344fd2de60
-- 
2.55.0.rc0.799.gd6f94ed593-goog

