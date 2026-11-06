Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989213;
	b=Coph9FAHlm2FRMUD31j2de2clHUPYBK74xA1L1jqorRVNwZgF7QIDPi7/86KNIeQARlr
	 24Y1zMVuCdgr664+nn+Jg+HGRWomJJQd/dOBi2nHyMix8kCKAWIxYwQjTglI5Z8iaMnwg
	 5Y/e8DPREPA0ugnLuv9uoItViVUWzhrQ8B5bmPiS+3sfiWsgyMUdVdbWtdBidHdPjSANs
	 JHLotgJ4Go/lZ3jqiceDLg8wEXDkVGXiW67iyc/OA/PseIA8KJX/2ntcM1arekoIY2fvO
	 cJjgQLXI9J9T9NSclhmrVGy8J2LM9Yd6FDHBcmlblqOiTkyQsLlwj/U1+bBTPxVSxeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=H159Xsa5W2BfDgkwuWPP8unE3udyJHNIucLctlJNBk4=;
	b=3WieZobSdRhAh4Gc5znlcU1sJyqOu/IruQoZ1+u/orKIuIuO7EKpP72uL1PVOpf19Thl
	 ihdrRUkGlkAI155VDAQx6SLkgrzFBA3YOXFPe1nydfuClkGSqWgPsbtTTDt0lkMQmw3d4
	 r3Yx7QahQZP9MBV+ylH/xXfsfOQJ9XbLFH4S4J2qhiA5VT2/lzrYl2GERTjLxm1RaxIkp
	 WIZcv2Ces8rweqRKi5tsqAPAGqtYEOeHV9hdL+qxGNlqMZIYMfaHrfufD5V+r19zqQ0kE
	 tEZ87fKKfglCp6Bz8ouD1WcT1EGiSaCfKNTW2vJr/S8b8Jxgq/sdY5ZOTRpWCOvnygg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jf8lg6tR;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F0606D810
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 18:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 610F0606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jf8lg6tR
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eb2437d752so14121295ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793989213; x=1794594013; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H159Xsa5W2BfDgkwuWPP8unE3udyJHNIucLctlJNBk4=;
        b=jf8lg6tRKj8Cf4mSHKweKXugKQRn/iIxaNqq6B2eYUTaHtOB+9f3Qgi0Cnq33bENp8
         freiKyov0PE6W9ME/vD8QynoxV55wnYeeq292+F9py7yM5yujU/Pg4BX3Z/nwab12EdP
         yAccXoL7um3wnzJqeeXgLiCEsrke3j/9EQELBhZRbNwoLROj6qHrHyX6zu3u8SNaKMp9
         rF/OHvbF16/r9g6cZuZpGjC+5BV7wE4crWydLJNgaOn1vB3W4w2+o0/yZtsDmLObTGLt
         e8GS9h6ZMkz4Zj0Q/Dim89H33Lab/SvI35oIkF4Ilc7duScABKwvNiuuiXYi7pnCTCUj
         l2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989213; x=1794594013;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H159Xsa5W2BfDgkwuWPP8unE3udyJHNIucLctlJNBk4=;
        b=JJZ22nUFKXrlLQhEeFUP/C9e6pghAyTDgtzzk83SfqEaErOHm9wXAnG+SIDEfgHgW0
         KCfso9T2OtR4qFdH153OcdZFuibzT7FP4vw9pYAMzAQhCkjO/m535n+tcNQGq1E07AtI
         mR8IcA51B4A7M6oY8Uy4eaws/V7e2IsPbzmn1kwa/VgOglwj9lz14X9y9ZYVnTQQFlRs
         Dci+8kV9KjnUSPrXH7PtnXqn+K9wJvrcExvEHnXoY2ya3wXumTOt6/XKE+EcakpOJBjy
         v7gsEswCLUc83cqfgU7Q/DM0noHn6M4pv6QX++AtWtw9N3jir6ZEPus0Cr13haS4o7hY
         bWJg==
X-Forwarded-Encrypted: i=1; AL+hErGddLNQ4xSDyCEwaltyQMoqwkIjgkj4xU5SzpAd7ihwcR7cqiomV9C/iqtF44W3AgkA17s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oGAjUMjTUkshla44m/2Vx7oobdTBv+Pg5zOXRyl0RNcxt5ycz
	JLVxVdEPwN+mGhGS2DsWLqgpm83Hycjo7sHiRjUgfAHZQvWd1qJgyoDbajITFRwiKWfOd5nIVHA
	bag+m7g==
X-Received: from plfn14.prod.google.com ([2002:a17:902:e54e:b0:2ea:874c:627b])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f541:b0:2e2:c283:354f
 with SMTP id d9443c01a7336-2ed41854318mr39247615ad.28.1793989212559; Fri, 06
 Nov 2026 10:20:12 -0800 (PST)
Date: Fri,  6 Nov 2026 18:20:07 +0000
In-Reply-To: <20261106182007.374660-1-weiwan@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106182007.374660-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106182007.374660-3-weiwan@google.com>
Subject: [PATCH net v3 2/2] selftests/net: psp: test bidirectional data transfer
From: Wei Wang <weiwan@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"

_data_basic_send() and _data_basic_send_netkit_psp_assoc() currently
only verify unidirectional data transmission from the test socket to
psp_responder. As a result, they do not exercise the receive path for
PSP-encrypted TCP data segments arriving at the test socket (such as
packets redirected across a netkit interface associated via dev-assoc,
which relies on SKB_EXT_PSP surviving packet scrubbing).

Use the existing "data echo" command in psp_responder to verify that the
test socket can also receive PSP-encrypted data from the peer in both
_data_basic_send() and _data_basic_send_netkit_psp_assoc().

Signed-off-by: Wei Wang <weiwan@google.com>
---
 tools/testing/selftests/drivers/net/psp.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 473500901879..c114d2245135 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -120,6 +120,26 @@ def _check_data_rx(cfg, exp_len):
     ksft_eq(read_len, exp_len)
 
 
+def _recv_careful(s, target, timeout=2):
+    """Read exactly target bytes, tolerating short reads"""
+    data = b''
+    end = time.monotonic() + timeout
+    while time.monotonic() < end:
+        try:
+            data += s.recv(target - len(data), socket.MSG_DONTWAIT)
+            if len(data) == target:
+                return data
+        except BlockingIOError:
+            time.sleep(0.001)
+    raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")
+
+
+def _req_echo(cfg, s):
+    """Ask the peer to echo, and check the reply arrives intact"""
+    _send_with_ack(cfg, b'data echo\0')
+    ksft_eq(_recv_careful(s, 5), b'echo\0')
+
+
 def _check_data_outq(s, exp_len, force_wait=False):
     outq = 0
     for _ in range(10):
@@ -478,6 +498,7 @@ def _data_basic_send(cfg, version, ipver):
 
     data_len = _send_careful(cfg, s, 100)
     _check_data_rx(cfg, data_len)
+    _req_echo(cfg, s)
     _close_psp_conn(cfg, s)
 
 
@@ -726,6 +747,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
 
         data_len = _send_careful(cfg, sock, 100)
         _check_data_rx(cfg, data_len)
+        _req_echo(cfg, sock)
         _close_psp_conn(cfg, sock)
 
 
-- 
2.56.0.455.g6c5a503b38-goog

