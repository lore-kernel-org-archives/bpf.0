Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084738AC9E
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416137; cv=none; b=ZQJohZhFtSJnZrrF+pBGukDvFf9rRCWTh5GB+y2UbpMdRLzVZA0s8Fh/75ziFKCiw6KZnHYlQPzYPcZYqym/Twqtkx3FUv2KZ9FGyMhsjN4zGBe2IkHl2QoS0d3BrWe7XFTinyB3jCAIC+VL5YMP7EAUtlshu1SrlRysGXUNflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416137; c=relaxed/simple;
	bh=vzUUg5dUyzpvG2rKRSov0XZCUJEJWBan5Kd7XHmSVMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0tZr8iLae123pSSHWOF3CefwHpyQ4KbEc83KSkbxguRc+CiG+PKz68n4+0c48MO+0QyWxE7oNGMn62UkdDAWtyCniPrxkw08X4Kf3V7DDw6A0Y7CtWL3IwJumHSdymvoYnZ3p3IuhetOue6ylmI+PEFWjCKPRzRrABTl+C2OPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9zpQ80s; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9zpQ80s"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79ee5037d44so5603127b3.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416134; x=1778020934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LWnUfnbOgtmJXE6gI2zxE0u23Zp9z86buEnIjkZCpw=;
        b=i9zpQ80se0Jlxr9Ek7vx74wnKI3t49CkgH9GRtaRn61bW/xP4d0r3b8BP0dtNHh9UJ
         0t1ZLXuzCeY/o/6tIKtYh6BJfydOT9oHLHeJMhTkERl14A7yZ1oiRKbzUtdlFAYY6oD2
         7CGfmY9EP+PxdfnX4SBNfc2EmprinvWNN7sZzWKAg7EeDGI2nlMoLhKLH2K9XxweuLSo
         O0zusU2GY+Xh+xDyR3qdLwA/MFuYGT6OLH+P6QcS7XVfVIdiqjteEYX6HpDAX+7nBAgC
         2GLsscizSa53j1jAZ9GcVwvOdAR9AGW2sBQgkoUUdeoLHjEgOeXidFuSW88JOxZir5NF
         i3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416134; x=1778020934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7LWnUfnbOgtmJXE6gI2zxE0u23Zp9z86buEnIjkZCpw=;
        b=qf+sfEsaLydGPv7siTlRWljikkjn8oRIMetCjtryaygLBUcbBvVOGOBsd10akVTux/
         TpK5GNaRzteOheetbjnWBrrFPkCxDc4rIP9v0keBZq8Ad+i6KFvxdUb1WxqAMSw/6Rg7
         hvsbWIDeQDPKlcgz1jmcAPuyHikTtFBWFGfI20+DqGnxeh0wuNPzospQLYfd+3wjS/i8
         uVeTdZvoso9u3xuWax2Tt5atZJXsqO0B5R+yLn8avvNWvltaENtKsLvJ1kbuhv6RRJVn
         Yhrg89edw7SkMgkISui4wiFr3YqR6+IukxxmzUeAbo5T/X+Rf7OQm7oKZmv0AfyrFswJ
         YDjA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZmhREchwGO4nmY3cwaxz3UNoCQvLnEtdTWCJdN4y+0bTzbg99QaaEmAkIlnoHrJMIOt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdYa9nqgjhucgmqFcX7LF3LJ3TZcxF2mpi6swQUVKX6v+eICa
	aOFO/cKT10v1ksm0thoaCxTFjFziNpGA5NTEWJRJO9zuBphmKbKwHBxT
X-Gm-Gg: AeBDieucbK6d+Wioi/O1ibIGe8cIxdm0YCl0H5yJ8928FnY4gv2+ncJExfAA5Si7fSu
	WMEog53KphjdlOcwbkfOqRZAxITKvfcHrpMoDMIo0ciPFA9FNYvkVuOHY1LfUspF25dIPmO+T8Q
	ELfKS+GKYu434Ol8CjLOgJ6kFw9gAAYkT+jismPRljDeTzFXeUF50htufxEPM7nfa+TQj2DrmU/
	gEq2Qdln17E4i3kSmfDiTpA6c36Cr7tm2rQcSRDa9CpR9RgJg6GiU1dosSTICmZA/8tK63s6CRZ
	AQZCIafoPf9y3e4XFB/8rI1YS4xjFHNGVQFNaqvahCgyDkNGJSl81Annc0dd300ogEpUhYwzekn
	o2PInw8Kl/PrJ+c7YMFu12YAsiwfQ6o48wHDQa9V2i71TmzWq1OZ1ZTtBskOpat5U7tklcLK2I2
	Gs0fOceO9LWHaIKi+WioG40bYTahbhZMGo
X-Received: by 2002:a05:690c:6d84:b0:7b3:b0a6:2c6b with SMTP id 00721157ae682-7bd241aec69mr6798867b3.20.1777416134516;
        Tue, 28 Apr 2026 15:42:14 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:19::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd252ca6b9sm4764757b3.19.2026.04.28.15.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:00 -0700
Subject: [PATCH net-next 03/11] gve: convert netmem_tx from bool to
 NETMEM_TX_DMA enum
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-3-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Now that netmem_tx is a multi-mode enum (NETMEM_TX_NONE, NETMEM_TX_DMA,
NETMEM_TX_NO_DMA), set it to NETMEM_TX_DMA to indicate this driver
supports DMA-capable netmem TX.

No functional change.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 424d973c97f2..dd2b8f087163 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2894,7 +2894,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_wq;
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
-		dev->netmem_tx = true;
+		dev->netmem_tx = NETMEM_TX_DMA;
 
 	err = register_netdev(dev);
 	if (err)

-- 
2.52.0

