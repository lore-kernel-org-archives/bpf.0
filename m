Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DA39281F
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779382; cv=none; b=Yb7VOhe8SOPbC3BTH1G/XOty/lVVnUN32N5PT399EDxDRmm27QffjDIN7NrWe5DN+IIWa3b19Ih4qltU/dMKp2GNbzqDBa3mAeqEFpyb8+0oAtCsoxtPhNKUb0z/5flqzegEUulRC0fcrlv1VwwOBx1dES+49BmX0m8Gf/a6+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779382; c=relaxed/simple;
	bh=EDyBqkyN5bDm600u/I66EqsZzueKCojlerqIBUvyphs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ik4hY/FnwVG6gVyBmlM4HJ4ye33Iz5Pc4iRwCQalNM+bOJNO1KAdjFPxYLXnqCZ8CN0oKdeVOlB8vPPNKp6z5aZGqqiAX7P1X8CNiqIBAik1DAcRQO6Rn/zJ83dnktdgtj9P3cQUP7ufnNDkgg7byONUJREJcTMrAbHcuWPicFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbNE0fqG; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbNE0fqG"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d55b97f358so5678148a34.3
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779379; x=1779384179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK6Hgo3Ntm+Mk5vI9D7ReSoIcT5DoQh4kA5KdiywL8c=;
        b=EbNE0fqGgztfEhlDW8IO7XoiGkpsuYndZ6xw/l+/6KOaeGXducdM7IGPNHTwgx9Uyc
         IOnE3akvzeLJ/calq8q0VCT9+GIrxnoigU88AI5AqSKI7DkJOIyRAC0dym5wt8gQkuLn
         vYvkpL8oPwe1alB7ptzJD6B+WPBFT3G0ThHplSa7rZAHgkmGdWx1HWlx5ct6s+a6Pb+f
         pWBeolusN/C7fbIYzE/OrN10SjNljgi6j9FcGmD/zGXOxpDi2n41GKGXD5jrLoaGy6A8
         IDc21bQ3Rlh6YVmQ5Q8ytHLLq3jU2NLB/rFJ645f9dpU9cEpvvVP5lbyj+fPvBiJ9DSb
         NHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779379; x=1779384179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fK6Hgo3Ntm+Mk5vI9D7ReSoIcT5DoQh4kA5KdiywL8c=;
        b=JfI/1GkeSbzjg2vCF/qPNbFvhG80fa0ZfptLDen5xwMjOSUGM1RD/R/CA89x3L2NtM
         TmFCVlsxLQtp8cuTzan4LUz3V4YZUBWa7ig6j+l7LeKmXMb04VoB6BXvgpsL9+2AS5IJ
         yxiPZZ+OvqIBVL0t5F0uzE6zYLUDk3pRceqjrLg57JrPtHUnHoaXXtHKL6eVm0obqoeg
         r4cyrV07CODDuEem7cbBW0j0COfR2liYIDb6lXW9C/UVxL6PGh/DNCeWogl/tyav25T4
         vrAATfz19TNxxKU6hR4ly9Eg/BA+uG7G0bk/RqRim3sFH72YJGhZrsC99Y0H0y93nWGf
         Vysg==
X-Forwarded-Encrypted: i=1; AFNElJ/InMuP9Zam+D9YCb/rPTdiuMuVWqG9SUi7hQgtwhgRTikt7PkE1wLSXazx7GM73TZNssY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCthmGUaMPWjR/Hsl9+u5wUuw1kArjp4pDeOj0eLjGcGn9vE9
	z8FWhqdD405wLFodhFYFqyiC64up+txfNfXxjDr5dgXDpkJMZJKI+omB
X-Gm-Gg: Acq92OFdgpTULuVYGNJIB2ePPbzB1AnK0euhzMZ1s5C1d7XmjhCbWrYyoeIzK6f3cvw
	xOlBEaiX34sZI/XzkqihVfCnwSiZZ+98Y9Cvfzq9rwvR33qYLgsHDF88xqAfRg0KxesBnmuFDtG
	hi2jZ2/A/Ujrv9guAnjw/+P0FnA7YUwRdic7dMBA6zooEK2OvBnRxX8w7TZxYWBhNcFn8DMyZBJ
	g7R1ZP39vEI2v6jjQUZdB5DxrbNzFO9g0qhP7qMW5wbneHyOMhd5ZoZER72gcpY636HVLjziB66
	peb4cP70gq3AEQafAvp7V4Sr1nPTjwHTk8PKD0WCEtl53/aIz/XWiY6odAy9122jFre/b7Qf5xZ
	t5+Stx0LZodnSMb9n5yHqaguObsQwZBWmLIYagLks+Hk4ZSR+EvsLAcqhELp2kOE00WPzx3wyBo
	+Hf0RhtFxAaQxmr8a3tAS4oA==
X-Received: by 2002:a05:6820:81c7:b0:69b:8c73:e921 with SMTP id 006d021491bc7-69c942ef1femr249405eaf.20.1778779379501;
        Thu, 14 May 2026 10:22:59 -0700 (PDT)
Received: from localhost ([2a03:2880:f812:6b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc1e7bc7sm2229037fac.7.2026.05.14.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:59 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:35 -0700
Subject: [PATCH net-next v5 8/8] selftests: drv-net: add netkit devmem
 tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-tcp-dm-netkit-v5-8-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
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
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
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
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add nk_devmem.py with four tests for TCP devmem through a netkit device.

These tests are just duplicates of the original devmem tests, with some
adjusted parameters such as telling ncdevmem to avoid device setup
(since it only has access to netkit, not a phys device).

Each test uses NetDrvContEnv with primary_rx_redirect=True to set up the
BPF redirect program on the primary netkit interface, then calls a
shared run_*() helper which probes for devmem support and configures
the NIC (HDS, RSS, queue lease) before driving the test. NIC state is
restored per-test via defer() callbacks registered inside the helper.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v5:
- Move require_devmem() inside test functions so ksft_run() reports it
  as a SKIP (Sashiko).
- Drop the inaccurate "mirroring the nk_qlease.py pattern" claim from
  v4 (Sashiko).

Changes in v4:
- Call configure_nic()/cleanup_nic() once around ksft_run() rather than
  relying on per-test configuration inside the run_* helpers.

Changes in v3:
- Reorder os.path expressions
- Drop @ksft_disruptive from check_nk_rx_hds to mirror the original
  check_rx_hds in devmem.py

Changes in v2:
- Add nk_devmem.py to TEST_PROGS in Makefile (Sashiko)
---
 tools/testing/selftests/drivers/net/hw/Makefile    |  1 +
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 46 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 5e49d7bffced..c7a1206880ea 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -35,6 +35,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_devmem.py \
 	nk_netns.py \
 	nk_qlease.py \
 	ntuple.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
new file mode 100755
index 000000000000..300ed2a70ab4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Test devmem TCP with netkit."""
+
+import os
+from devmem_lib import setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds
+from lib.py import ksft_run, ksft_exit, ksft_disruptive
+from lib.py import NetDrvContEnv
+
+
+@ksft_disruptive
+def check_nk_rx(cfg) -> None:
+    """Run the devmem RX test through netkit."""
+    run_rx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx(cfg) -> None:
+    """Run the devmem TX test through netkit."""
+    run_tx(cfg)
+
+
+@ksft_disruptive
+def check_nk_tx_chunks(cfg) -> None:
+    """Run the devmem TX chunking test through netkit."""
+    run_tx_chunks(cfg)
+
+
+def check_nk_rx_hds(cfg) -> None:
+    """Run the HDS test through netkit."""
+    run_rx_hds(cfg)
+
+
+def main() -> None:
+    """Run the netkit devmem test cases."""
+    with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
+        setup_test(cfg,
+                   os.path.join(os.path.dirname(os.path.abspath(__file__)),
+                                "ncdevmem"))
+        ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks,
+                  check_nk_rx_hds], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.53.0-Meta

