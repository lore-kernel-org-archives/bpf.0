Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5B351C3D
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540990; cv=none; b=IH5/r6eohDAMk1kH71IHO3r4H0JTAxnPKRh62aWqBLSBzafqpkpesEPojoLaIc5GJiB7b/3j0uVca7b58eW5N++WxZLIrfqmxCJeZnJ49rZ3fQdwslkGmRPmaAu/bxV6lAKg0DXkhCvPbcs9SSekYETVbqfojaHxRBeRHWucvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540990; c=relaxed/simple;
	bh=QYK8WLkDehn0NGcwyXwvNHYq73sWHci4bNTcehdMdWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZhR+1QeEeksUILeQs4mGknfrrNaR3ld0mnxnwckeNwPVRzWLL8xNXZTd4+ALzQNWtgBFkse/LVpjtL5+eE4BG7HKJaz2qRUDTxB9ga5KV9VeOh0RAa/+bUwNcYpvpA+T9QpG1nerDrdqinuuqNpOX/NQghZGP9Bb0mtBhfwVb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/ZfGRJy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/ZfGRJy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf27856f9cso16070775ad.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785540989; x=1786145789; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0SaMYRu6wc8EGbj4CgxV89pDWL6LLqMsE1gsbynFtMc=;
        b=k/ZfGRJyUZSsbA5z3z3wPDVHIlRl/kBaonJQP7y2I5m6cmLXvmz47a3h1IWj/sH771
         RHdXUhyptyZ63A/d6ftaHdvR+IfWeQIkPGs5/viRHnqrf10YbwSI66KvKLlmzMtie6un
         LRDJLQ+wcQcKijclP3Fm8GmWAnSYxe1Ihr8HHmfVrNY3lfqKAfC4blnZDpLvO5Bwm59+
         kriMG7w+TxZNSLmcifqSi2tYuKTZhISZ7HGvvKCZxDhugmIK7zU60BD6103iJZin2A/m
         xzEQYaLrzEa+vBSIdXJJHR0FxFsZcI+TLLiw01UeK0pR4dl75znSCDQeOOaAtTlrwAfy
         WOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540989; x=1786145789;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0SaMYRu6wc8EGbj4CgxV89pDWL6LLqMsE1gsbynFtMc=;
        b=Ont6yTDIv22VKsUwSXZMOk96eKSsUF+JqFVN7hc7CFlmzcTeKJAgsBWvFGsudRsiCO
         o5PzJdoawfLhhw64MDu2Ewktr1T5s21IEX1UB+Ku+k+aFUNjr9Vg3QSnGvGQveNKi43U
         AhPo2XkmgEITbvgmELYgU0hKISaeihg/q0DY1lhz2seBER37JqsS0z3/sB5n4b1nIWJQ
         4C96mSaI/VEDrkIJvYRzYt1WdOGEtO33CX0dOaG++z10XQmoGCcUhC/W+XQ9qwtuGSU+
         vTJxqzUp30Jyujcu49tgIPVOq400dHow1ZMyQPC12Vewgsd5M9L3VxUI4jvaicK7FtcZ
         qxoA==
X-Forwarded-Encrypted: i=1; AHgh+RraQgnMuen9mhhejgUguyaQF5b7tHZVLv3MQhlIa21skYtfTtQMlUlHPuRiIhXRqd+7UxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7eOqGlUl49b8i+xu8ZSmnZ4bwoPC3Dju4l6/mFNEDlICTSww
	zVH5ijVsfAF5UKPt2qFjpnmaZkwbi/9QNIdx61/ax8RrZF5g9onggrRE
X-Gm-Gg: AR+sD129LcLFqVaY74SeaYCstHc8kQm4dxEmx1dP0CkNSgPeI0jWAg06Y0gI9+pY7bk
	Szy/oLCAkBMUNUmn0mjhtlsoaa5yXNKsP2sdi9Fwy/3i0Wh7AFvUrtvoHCHZDODywPFXiE2CpeY
	facvteir0jb+5BAW1e/ToPtIywjRA6Ckb8B5aqXmBppMEg5edOxEXlAAC+ynqMLU9nXHfcvh3vw
	/vaRXH9IL421kB0FSMFweikTTUlbo24fgtYK/8Ficsl0uxeEzzwLcNY/CkTx3Be4cZ3knFMdYB2
	E4SMq9nPj0J8vvvQ5WCYz4rOi+1QSm581jwOMRd3SvwmY3uuaUzsKh8nbDxkWJFw9c+x5+kXXkL
	xjBQxzuwez+7o1cETDcJ9j4WFjsp3pQ+nhxWkFbeVnOhJ04cqA5zoyNauEHkNh3+iftbSoEsJ+R
	jvA55X2l9efmvizyCrqxxYsLzpIJtxNyqqhkDCOWpzPrmWzEvjlIArfwXcJKddQJ6xltThUGbS8
	zTdLUI=
X-Received: by 2002:a17:903:fa6:b0:2cc:85a7:36ee with SMTP id d9443c01a7336-2d052462dc8mr17339815ad.32.1785540988695;
        Fri, 31 Jul 2026 16:36:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b120d98sm11355105ad.59.2026.07.31.16.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:36:28 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 31 Jul 2026 16:36:23 -0700
Subject: [PATCH net-next] selftests: drv-net: enable devmem TCP in the test
 config
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
X-B4-Tracking: v=1; b=H4sIAHYxbWoC/x3MWwqDMBAF0K2E++1AfNCWbKX0Q/SOHaixZIII4
 t4LPQs4J5zF6EjhROFubltGCm0TML3HvFBsRgroYneL974V50crvbrM3FeuMm1ZbREd9DH0GjW
 OM5qAb6Ha8Z+fyKySeVS8rusHlaTij3MAAAA=
X-Change-ID: 20260731-selftests-devmem-config-f4f843f0f0ad
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

The config fragment already sets CONFIG_UDMABUF=y, but kconfig silently
drops it. UDMABUF/NET_DEVMEM both depend on DMA_SHARED_BUFFER, which we
can't enable directly, so we need to enable a config that selects it. We
use SYNC_FILE for that purpose here.

Additionally, we flip on CONFIG_NET_DEVMEM as well.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index ed8642b68094..d89a9ba17655 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -15,11 +15,13 @@ CONFIG_IPV6_SIT=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
+CONFIG_NET_DEVMEM=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NET_IPIP=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_SYNC_FILE=y
 CONFIG_UDMABUF=y
 CONFIG_USER_NS=y
 CONFIG_VXLAN=y

---
base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
change-id: 20260731-selftests-devmem-config-f4f843f0f0ad

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

