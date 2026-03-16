Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C31374E6D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700171; cv=none; b=pqh3yjBDNSm4P7Win2WHtra2VhNx5F0gTetJWbfavxoSUj7jELE371tftOXoPmqAYCmfkwNtjFUDG+mntPG7CG3RB3A3JHTYrUOqfLfcKEIOyTIsQa5SzFc8wfJ4NbBngTY4x7TcGxMol5yDg4nHThU/plO2GUtlVwlKV/hoyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700171; c=relaxed/simple;
	bh=QLmJCoIEgk7bY1Etv2KHuHMRxJlYbMdrmYRAb1O/174=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fs5I74ZBzV1iRbdGdQhmdMgthVUBh7/cOvBCtfqZADDlcqHM9BEVieo31ObXiGDylWVSyEZ1NiOcmW2fQM2UlosLR1DcuYhENH5kr+TRswgiEBRIQiv9NYtk/WWn3zx0uVfJqCOt5stpU0hPoHy4S+J0+6GhK353kekRwjLjBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU+4+DAK; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU+4+DAK"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a46260385so16817967b3.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700166; x=1774304966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGghREiBSn7MQCKj4TXr4KN+77lBvMCqoaCeBo9lJNY=;
        b=YU+4+DAKS0Xi1+S5LfgawBzAiOjfnQ1zadUoqKwnE3T0oo5zVn6j0chqDn4W514zX6
         IC7f0HDP/i5HIxgtJH44lVAe1THefFbTdXDB94DGKX2+FGi5NAjMUvYrDaMRocJfQ7Ua
         rcdkGczSUqXVgFN63quPo5fSowPBOzLFf4zUQWPv5eRYskXogfjkO+3ID5n+0ZciyBdU
         NWPflAKJ/hxEZjDKEn0p6zchzprqfIUm5EgK2kTqUmPG/ItIU5PGXMYYLa9JefgNsIQ4
         sbyMQdxlg8A5HK0E5Ku5Edg/z9DDrvH/95Yea0efpZ09SXHRBcAsw0uzfr1MvO1N4+4b
         uxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700166; x=1774304966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zGghREiBSn7MQCKj4TXr4KN+77lBvMCqoaCeBo9lJNY=;
        b=sof4jFbxryiXB2hI4AqiD9bqwa8+TdwZk5kJF84q4VfkdojjujfuiGNSFq6yDRe+AK
         yFqeGwtwO8h+0ZgnTre+V29kbZc0rqOczNNGoH0TN/Uh3Lsl3sJmLhi01M3MTfOv7YzJ
         J6iN5jwdy3xJ497p2ISnNPd2TyZlReER7WRSCMeO1EL0KaU8em30CofP30KvMCv/EEnd
         xpO/trk4V9Ov5Om9TDLb0/oz25Ni5/BDLyVp6J80e8JBEs/9wyxo+LJIeiSBBl00Alos
         7G1uPaCuBHkIpDi/auh96D++7+iKi8L9VvAEG/NCQjr05o/0/quwLlSgHBFbe7348Cez
         YaBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbsoEk39yPvOaqtwbi57R1NXZgLozVWWoGm00x6DYWZGLi8GMzH/6kYCH5/wWCz5Flh+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgKe4BGDGMsHPCiLTH4ZB9lTKK2kRCs7SSDlI0TjzgUD3DOmK
	QQMzj7lc9hoWRHZ+DY5lx0UnfpI4YnCH7WF6E/bhzIlfBHd/YeebJcMO
X-Gm-Gg: ATEYQzyKwKAYkWFPjhGbke4ousNGfmOvUgxVt23xc/mSeteyxHXgvTidKq2PskvtxEp
	OQRXV1j3x7djmoAbzn2OlwCKkMTRrGu4qYQbPFYbK8GoalR6TrQei3dX1x8lmvHJgP2FblfdV15
	prtoAtr+QH5SdBs3S/9XCN9hUQbE71zYyJ2N1JSSjaGpOhknsXK+662GSOOQeC0FTjKydSGcqGy
	JB0Cb+NOlApRg5LoXyI8xgIg4VbSRpbAKD5zS4i4vZsnBzJ8IcC90LvOif6Uv+u6PgwYTDgV7lA
	+TWaNIkdV1pSyf7WNj6jIvSiGMcRXu+j/IGie5Jih28TnivUTfuFACOKvFrAWZw2AxfzXWwD1Zw
	SDcnlqiAsBtL8IexBYbo5W5Bj3Rgv5xSVN/MydW8U+iojCYTmi+BokfmoIqo+QVy22prIa7FkWX
	lMAXBgeaZ72R49tRUH6Ka1dA==
X-Received: by 2002:a05:690c:f08:b0:796:6da9:bf97 with SMTP id 00721157ae682-79a1c1c002emr149829567b3.43.1773700165699;
        Mon, 16 Mar 2026 15:29:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917ee5757sm96813787b3.31.2026.03.16.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:25 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:17 -0700
Subject: [PATCH net-next 6/6] selftests: drv-net: add netkit devmem TX test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-6-b53c8cd72b23@meta.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Extend the netkit devmem selftest with a TX test case. The TX path uses
the primary RX redirect BPF program to redirect traffic from the primary
netkit ingress to the physical NIC via bpf_redirect_neigh().

The actual TX path looks like the following:

 TX Path
 -------

 Netkit Guest (netns)     Netkit Host          Physical NIC          Remote
      |                       |                     |                    |
      |--- TCP send --------->|                     |                    |
                              |--- BPF redirect --->|                    |
                                                    |---- transmit ----->|
						   dmabuf

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
index 0a66ff85db9d..0e3c5aab6423 100755
--- a/tools/testing/selftests/drivers/net/hw/nk_devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -89,14 +89,33 @@ def test_devmem(cfg) -> None:
     ksft_eq(ncdevmem_rx.ret, 0)
 
 
+def test_devmem_tx(cfg) -> None:
+    """Test devmem TX: send from netkit guest, receive on remote."""
+    configure_nic(cfg)
+
+    socat = f"socat -U - TCP6-LISTEN:{cfg.port},reuseaddr"
+    tx_cmd = (f"ip netns exec {cfg.netns.name} bash -c"
+              f" 'echo test_devmem_tx | {cfg.bin_local}"
+              f" -f {cfg._nk_guest_ifname} -s {cfg.remote_addr_v['6']}"
+              f" -p {cfg.port} -t 0 -q 1 -n'")
+
+    with bkg(socat, host=cfg.remote, exit_wait=True) as receiver:
+        wait_port_listen(cfg.port, proto="tcp", host=cfg.remote)
+        cmd(tx_cmd, shell=True)
+
+    ksft_eq(receiver.ret, 0)
+    ksft_eq(receiver.stdout.strip(), "test_devmem_tx")
+
+
 def main() -> None:
     """Run netkit devmem tests."""
-    with NetDrvContEnv(__file__, rxqueues=2) as cfg:
+    with NetDrvContEnv(__file__, rxqueues=2,
+                       primary_rx_redirect=True) as cfg:
         cfg.bin_local = path.abspath(
             path.dirname(__file__) + "/ncdevmem"
         )
         cfg.port = rand_port()
-        ksft_run([test_devmem], args=(cfg,))
+        ksft_run([test_devmem, test_devmem_tx], args=(cfg,))
     ksft_exit()
 
 

-- 
2.52.0

