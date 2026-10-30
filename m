Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334712;
	b=NpJywrWfAXir+BIoJKnEg2S/mnTP0c1eThCZIftXJwXDHutjigx3+l/25vybcvLoI722
	 mOfh2aK6QaaU9ap4yWb/yZ3yeNs5PX6DvFjy5/UP9TurzfM5NBV7KyAB+Dckba2wIUUQG
	 y2RBspxLe6rIiUg+9wrrEASOHvBsv6IHJVst7CjHnwXKd9rCDfmvH1hA4x75KAxI+C88E
	 YDrmFQeRWY1MX7+v0q4V4lXFp8UNpB0/V9xU+vNnCqyJLFlMSPHANWHBZAEB6HQd9vUNf
	 XG1VZdtIfIqEB0cYxoZHAjl91CTFxEoIe4ZfNNFgc+44G7SuoYksP1ieRfHaK6Wzm1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bMdKaLnci5rE3Vyxt1ztOm4nlJPbyxipNoi6qOdT6zs=;
	b=CvOgAIBJAtpQzx6hgBG3yAy55ucQhHFLFafw0ef7+/xMEyCW3W9fDpK79uY9KAmOzKLf
	 BYE3IbITXcXclNevR6HPNxvcZfaoNQvtoKyab8RSVk6665UezfK8GcuNscuRbNuZKzVY6
	 43ufd3toEd/pONM7TMuNeb28VBj5DZcANrcMNS4ygMhPODx7vUHzMsjWGQwx+HLx/oyTv
	 7KkDBYHxJOlVFL9d28FCgfCyq7DHeTVdTeewcXwfwg+u76wJU4+MRlyJlbLeeRNxyLZdO
	 OMb8L0AedH9TRLNDgL9wxBvXSWRj8avErxdhGhQIs0uKXC73HTACuCHS+srM7OKUWHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lSEH1gbN;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F08606A334
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F08606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weiwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lSEH1gbN
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e869e00005so5915425ad.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793334711; x=1793939511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMdKaLnci5rE3Vyxt1ztOm4nlJPbyxipNoi6qOdT6zs=;
        b=lSEH1gbNP3ZVkTl4v2zJcvBd3Y394pd5Rf9aUUUw3bNnmBItW5OHVYUPZkuZ404dHz
         aB5UQblxmNl1PR+UBp+OWoZKtdNYc0iCrFmxbtJw3q8v9oRXUtqmMevl92R9ZKwIapkC
         heTOI14FQ+TdF/ZfG7EypqtcXQU4HxbK01XZtpXiEJl1XWHjj8kDnLD2P8xw/yTf87xl
         0JACiTgl9dRYLn1mBQ+3nrQ/jkE14+f6wTEs7F5tV43CQ3l9vqqC1kCmiN4h7hPMAt4d
         jPnntgwydj5T53bvcB5wV/4vr2X5m8A4ytDMkpBSuQM0sAYeD2P/Sl5dMvC2p1w+UhZ9
         yqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334711; x=1793939511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMdKaLnci5rE3Vyxt1ztOm4nlJPbyxipNoi6qOdT6zs=;
        b=kMVNM2g1hJNBuOro8fAe3xSgWuA7b7Zek2iakx8e3iN8gZBSv0z5AdHwRZUXQvtU2v
         RLFSDwookPXzzN+twzFgpS5Q7zt8VU8OJaMpjBEnltYpQ/SkCQOV2tNHJUuTjf+MBgub
         sHFJpLwY0nhylhcQlLrZeU6tiaN14mIzPSaW2ERP+ogmlxMY96jNeq4PhQaEHj9rfMJM
         nkpzvpVuBLPw1Nm37wsjlZDCcJpYQ7FCpIgERQzK2VqceP62iVqluhZOFbNduptFeiBA
         NwIJjkVT0wVxFeqKoQx+cnuI0f14BjZ6QA7A63HNJvbJckiI2HjkI05VEPUgo7rizbdw
         R6lA==
X-Forwarded-Encrypted: i=1; AKwUvByyzQybAaBttqZe2MKrdIlL/uIBvUx5uMF+Bmj9SMbCPZAqRvPLoLnm0LdCiazAKaRUOLE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUX9YrRvWR7SxJQQ0Xhdds8BbzL4SI+2XGCZLe9LElCBwN4fpI
	k3vg/h32W38SyHBdg1cvqLC/4db04brsXVTGOXdaHiFE2pIfTwoOwmQQGfSOSvaQ9dmqGu7khF0
	0t5EFvA==
X-Received: from plkg13.prod.google.com ([2002:a17:903:19cd:b0:2e8:1f84:7c18])
 (user=weiwan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c27:b0:2e9:460e:ca57
 with SMTP id d9443c01a7336-2eb36426e0bmr13063885ad.15.1793334711324; Thu, 29
 Oct 2026 21:31:51 -0700 (PDT)
Date: Fri, 30 Oct 2026 04:31:45 +0000
In-Reply-To: <20261030043145.2185700-1-weiwan@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030043145.2185700-1-weiwan@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030043145.2185700-3-weiwan@google.com>
Subject: [PATCH net v2 2/2] selftests/net: psp: test bidirectional data transfer
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
2.56.0.317.g454f8302e1-goog

