Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901133;
	b=Y2eOfRQhCFxvHBAFklZABz1y00ofKcNyBx+Yr/fCPcdHiHLXSkEYkPfmtMXvPQDqsRH6
	 XU5pWG9/8FEd3UmFAdxrosVMzwqRxTEQtdfaGPEpRscmOpr3bZBXfPLdHJUctr/JBCPLv
	 3yh4Z377T7gD8nFTZbfBZEOK9mGe0q29111HDsZqRqFaKt7f50tgdSJjMdqV0W4SKjfvm
	 LqUkntHUJO2WkhqTnQF3P0yxk0YcwFqu90OWwldhhy2u4BNf0YhWTFqDb08mK0Jcl96dB
	 hpWxl67dMGJlKmi+I8QQ3w4yFOyY4Hw0tUkDb+zxYLNy/Wsyi+IfHKB7sSaEooal6kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gTPwTs6KQ9y0OogJsarYNN8wQnpNX/uHSQbAgmpcfg8=;
	b=vFKHru93RB/vvDiKHU7uuTFJ2i8fURl3f3LUjTuHC8EZsC+IYtEws4KnR4NwOpW2QvUR
	 jjwZLaCVSCChhcPUZnjov2n6/m0ZyWFARYb4rhDTrAKdegxt0Xfalc5ejnvpumprHIuIG
	 DtiPAQuOMGGSCdwjmSLp0S4rlMyxUPVsL5bO/YzUwjL5pLM4aVISJMWH1kUgpzrkFKuVQ
	 mYyAya/PXzQC70iIJYj5ft8dfqj5wYL0fQ7BssjzL8W5hY4HOj1buA1u1syXT5Ld8Gd84
	 r1isySg0mhWzKmuXmpUx6XEsskrcytfCeAS3ui2UvMRLie9Q8eDLHEaRdG1UB60EUcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WruFuch8;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B01606A33E
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 04:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B01606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WruFuch8
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so2001079b3a.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 21:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792901132; x=1793505932; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTPwTs6KQ9y0OogJsarYNN8wQnpNX/uHSQbAgmpcfg8=;
        b=WruFuch8yfURzb8ZGFIy5pQuDQ0rbwdUz8UzGedqewcmOlonpl+TOvKkBhHCS8k7zx
         QbbfksQH3++GId6saBoRpRwOtzWEtX6yya4XyH7zRfW4znWbi+Q6wbCwCu+HvfT+/oKa
         f0hgXQ+kVNIdVUPgt6H528AxLSEoLJsjnCiGSjrqwSNnUW3DvSvSQUhb/pK44zMMW8ys
         IU1zTOsnm/isPBN2KEbK7VvbwTpV1hE9bKnRPuVQCWg2TcEvKIk/jy2iJKswN6mOKNv9
         08xshmL2GCo1FzaG8S91+IEuypW7MhOx//Z2sjjDb8PiuxjMeKILtghCGZ0KoUs1yqsZ
         hrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901132; x=1793505932;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTPwTs6KQ9y0OogJsarYNN8wQnpNX/uHSQbAgmpcfg8=;
        b=YoPZPM6IBqPsFn3WXhCMwPDCeOv8R6WxFGGDtCMZAnjIK9bvrDVkfzZrLFEkbBLTHi
         XteZ1zKgO4vmIQmP/ft5Nb6DtfGRQTcshQ6TO82BzvyHoW9eGbo4SuHMIUjbmRLxPEh3
         /4jwduL2u+fxV8Zh02pRVeWy8/HZJqkWHej0vQkEXdC8mnbRAfT7QRczRIozw7uG8YyO
         ilG2IOTf+8sn97giBLSUlpDZV0xVE1r9j4rnF1XwVZokJVVz9nsztwPzqq/W7FjWjUbS
         eoz5ekvMvgbWYeJSSvAIc4Fyd2V/WF+pHtJ4zWzkt4F6pG0Xq4Pg4F4micIjVQrOmzYo
         HTnA==
X-Forwarded-Encrypted: i=1; AKwUvBw2IGcq8W8wjlPpM3jeu663gTwPtRO7GkpOGUvlRgOh0iuNQE7251VDc0iP546ytSQL2zM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKR1kY8jXA7ZJWnsU7qasDe6Lp8ANH3i+mcJGTnxoZ/k+FTuDJl
	FczolM0doUjS+8DmMsV0njqJn+hXOslygvA8lH/cDDqL7/1mZJAgbpO1VGH575m731BB2+pfA9+
	ufYiOzQ==
X-Received: from pfbeb23.prod.google.com ([2002:a05:6a00:4c97:b0:894:b24f:9540])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b56:b0:89c:6036:c63
 with SMTP id d2e1a72fcca58-8a366d7a4e4mr2631352b3a.32.1792901131466; Sat, 24
 Oct 2026 21:05:31 -0700 (PDT)
Date: Sun, 25 Oct 2026 04:05:23 +0000
In-Reply-To: <20261025040523.678027-1-weiwan@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025040523.678027-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025040523.678027-3-weiwan@google.com>
Subject: [PATCH net 2/2] selftests/net: psp: test bidirectional data transfer
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
packets redirected across a netkit interface associated via dev-assoc).

Use the existing "data echo" command in psp_responder to verify that the
test socket can also receive PSP-encrypted data from the peer in both
_data_basic_send() and _data_basic_send_netkit_psp_assoc().

Signed-off-by: Wei Wang <weiwan@google.com>
---
 tools/testing/selftests/drivers/net/psp.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 473500901879..e507951b440b 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -120,6 +120,12 @@ def _check_data_rx(cfg, exp_len):
     ksft_eq(read_len, exp_len)
 
 
+def _check_data_echo(cfg, s):
+    _send_with_ack(cfg, b'data echo\0')
+    s.settimeout(1.0)
+    ksft_eq(s.recv(5), b'echo\0')
+
+
 def _check_data_outq(s, exp_len, force_wait=False):
     outq = 0
     for _ in range(10):
@@ -478,6 +484,7 @@ def _data_basic_send(cfg, version, ipver):
 
     data_len = _send_careful(cfg, s, 100)
     _check_data_rx(cfg, data_len)
+    _check_data_echo(cfg, s)
     _close_psp_conn(cfg, s)
 
 
@@ -726,6 +733,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
 
         data_len = _send_careful(cfg, sock, 100)
         _check_data_rx(cfg, data_len)
+        _check_data_echo(cfg, sock)
         _close_psp_conn(cfg, sock)
 
 
-- 
2.56.0.257.gf7497c7d27-goog

