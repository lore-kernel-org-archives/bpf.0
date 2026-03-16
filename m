Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE3372B47
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700167; cv=none; b=HhZtGC1qAw12/FSxZALMMB4yUVp3HcMI0uvsX6Pa/WjnunwYrLbAEsMPedORY7X/zHsGlZ3V73yf4CftBfaaCsJWv7n2oeOjOVJsL3KOLfKgWRAo8AQY6oEDtQGAeNY84kHqKKLV72nYjXTN9315gyJOaZQYrLCm5rasl2mMBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700167; c=relaxed/simple;
	bh=jyNxYmx5UB2XwVBzrPIt/v521XrQK8jWoaatFoXioqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epJV1GkmK3/6GZJdbWJdbKiSAEDlkZuMMGIUqQgIqZLpkZP62SM8HTV5SNnbpFBBzrsVPAx7r51+/PGE5/yIxpeX20s/4OeNA4O0FOp91gRfbyP3taY62ndiNFW76NSrIDfpanZVUizyLuUz0TUs1h9O3SRjoJdiMkzOPdQWEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMn9rRFa; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMn9rRFa"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79495b1aaa7so47108047b3.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700163; x=1774304963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omed2F+AqWiwSMzDcFuf7st7hlR6TZL1wyoNIJPdTr0=;
        b=XMn9rRFal8dlvd7EaX0AqXe5plw4ois8LmhTEgSEDmwkYClkt+Pd9SFtojlgWOBOm/
         tucB/NyVFiglUhpi/tqaiY8JATMVWzzp80oERakv557SKHU0pTOeEn/KkrIMFi2qWj8l
         tPfai8Z9vngm80FYz3ni50W3vdoQ1cZ3tq1loIZSb9/myJJdvMOwJSKICCTFA8+RXKFc
         fa2Gb7USJGm6RbR/bRz2xUBEN33yOkpHfq75+EK1jAyh5XaXOLJM7K6gy3QM+BNHiXO3
         I9Wj9fvGATzEPyflcEALH4rhjtiEgS5g1R1Zgfh99A2UiNjBcIAEq+KHn5wTC0j92Qrm
         fBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700163; x=1774304963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=omed2F+AqWiwSMzDcFuf7st7hlR6TZL1wyoNIJPdTr0=;
        b=jHmn/KedAzoA1WiOweMTbClFhpyA6XiE1ou/JSrA3022MoER+393H/P4uY1crWtJxp
         hRiHGW3d9QgRN79kqSOv7UdNNz9rfDNwbgSdsuJFiwhHYbBqg/XJ/9B2MECTd5Wa9Tn1
         e+5YR16hgCDYmPduEtakPFu8PDitwTf9NWIi/iR+Fn2OYfHuE0ibEC3LnXamkuqKrU/k
         tamR36qtl9qC5OOlHo5VNvCcN75pn4rLAR21J1OnHctvZNiFM3KBvNyAojjUxhfrOYQu
         cJJOdK9o4RA11Sk/sChA50/3XGFq7ROjbJnLgVdo/3fg/gPBNUtQrGWpUN15LMEy0pX1
         hvuw==
X-Forwarded-Encrypted: i=1; AJvYcCU2xK+ix4u3LySdVpYmJL0RhHL01HkegK3pCwK0fK3w+bky2PMGQY0sFuj213RSNd3XWvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgk5V+jioct6bg9w3PyclxF996/IitnpM/k9bfTWRKeRUDkuB6
	iev6KCjHhnWqrd4lk/AzC9lnXw6kcnH44dMSr643djO26sz4oA7S9XIk
X-Gm-Gg: ATEYQzxw+ecsnyRBOPKe7NrAVMQORsZ1pcuGcUr1tGSwWJ0j6ULI1SwxGP3Tc3mKFIa
	2VTieIhotwa9hY4dRjiQV0g0i97pB9qT9M2Sd9wJAm2oFxhfqtoQfQ7hfdDAYRhAvHs5YFKcrr3
	3urMAXSBoP55r93Jhb1iiqdNa8GYdjMhW46ypwjD5IP+YdLKu7Aldi6mLEw1BG24oJIVpiGuHIv
	ITfuiQtwQSPAKQHuJUjRwYHPM11j6fib8kvKgJt9F1NvMT4TkdQeM3G3vW1QvyA0Pw7F8304c62
	MdBlMhME6VjF8s4Z79/KsuRmWKe3y9TQ6qNKj31CRSkfL+PiBQ+Nu6FUtCR7GYWe5ACQIIRTeZN
	fuz8dpRldjIR0GRhG+UkPy/lmnBUegT0sfm3OjpnFrOzxWmV6u13gl4ellQJMpDhJdPMi7WgA97
	C8vJGxkOi6ehliXe+Qf4UbKg==
X-Received: by 2002:a05:690c:81:b0:79a:3a79:a4b5 with SMTP id 00721157ae682-79a3a79b4eamr90331507b3.11.1773700162705;
        Mon, 16 Mar 2026 15:29:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm92905497b3.10.2026.03.16.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:13 -0700
Subject: [PATCH net-next 2/6] selftests: drv-net: extract _find_bss_map_id
 helper in NetDrvContEnv
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-2-b53c8cd72b23@meta.com>
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

Factor out a _find_bss_map_id() helper from _attach_bpf() so it can be
reused by other BPF attachment methods. This will be used by subsequent
patches in this series that add support for netkit devmem TX testing.

No functional change to existing tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index ccff345fe1c1..08e90448f48d 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -467,6 +467,15 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return (bpf['pref'], bpf['options']['prog']['id'])
         raise Exception("Failed to get BPF prog ID")
 
+    def _find_bss_map_id(self, prog_id):
+        """Find the .bss map ID for a loaded BPF program."""
+        prog_info = bpftool(f"prog show id {prog_id}", json=True)
+        for map_id in prog_info.get("map_ids", []):
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name", "").endswith("bss"):
+                return map_id
+        raise Exception(f"Failed to find .bss map for prog {prog_id}")
+
     def _attach_bpf(self):
         bpf_obj = self.test_dir / "nk_forward.bpf.o"
         if not bpf_obj.exists():
@@ -478,17 +487,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._tc_attached = True
 
         (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
-        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
-        map_ids = prog_info.get("map_ids", [])
-
-        bss_map_id = None
-        for map_id in map_ids:
-            map_info = bpftool(f"map show id {map_id}", json=True)
-            if map_info.get("name").endswith("bss"):
-                bss_map_id = map_id
-
-        if bss_map_id is None:
-            raise Exception("Failed to find .bss map")
+        bss_map_id = self._find_bss_map_id(self._bpf_prog_id)
 
         ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
         ipv6_bytes = ipv6_addr.packed

-- 
2.52.0

