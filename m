Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777697;
	b=NoGohgS0DL4Bi7MB5A67M5YdtK8KGAXx38Aja2MEacyQiz9fEXPXyiZwQ4jx/6lu8lqV
	 mpukzyEebq7pJ9c6ooBaxoBWN2ko+155BrEOTIKzrdHqZ1p3w+r2sOzZsON4aVTcVd1ZB
	 z94Z33+wngjBnuPDEBb/5j5PNle1TjwTZbbMG4ktjriPW551n26UK9mDy9SSyqYmgibb9
	 gXdytqpyREBtnYr8UG4Gnnw7RIi4ZpHJEf841wmEua2yHv06Z0gX0HFXeuOM/1uQyF6Bf
	 yC43OlcWpH3HOpJSbvPlzWXfESY+BjINoLZawBqcLy5Oqi0Ieo3KbgT9nO/3O1BcAag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U+TujgQ1BSv/6MjNJRe3WggEHkX9fvK2a6kRHkLOphI=;
	b=g4KQX2h+gx4Zt/NVc9Rp9N1K4hEI1KLHfRhC/glDVegfl0pwU79pQTkiXZR8z/6BDnkZ
	 I2rpJoJL3oWNSuOgy/9qbK95G5wwrojZob2Oq273iCsg44pqUhhjLfE+8wTJFKiONMDsy
	 qeIYmmo4NIeYbsKnM69pZMSWCVv5IySCfGH/C4dYdxitotgc4OPeJBQ1hwA9hKlkNh3q0
	 m0idNYVg3DZKJE6vA1Bo3I7vFAo4NmHuOXfqrTA1iWJFhDFEdtlcE8NR+CBW6vr+TEkyC
	 bMF/7xgmdcDUrOTvvOo2igW/wcsfq8x5k6bEjInCXaVXOxVHfmHNs3Up6DvdLhSeGVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=agEhoXKQ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDE606A329
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35FDE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=agEhoXKQ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so2915495e9.3
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 13:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794777695; x=1795382495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+TujgQ1BSv/6MjNJRe3WggEHkX9fvK2a6kRHkLOphI=;
        b=agEhoXKQZko8bWKNlYxvZnSuZxTEFOAB6dprNXg3wBYx1g+Ln8WIwf64vbZs/XcPON
         0/QhMLpasTuzhFHeo2IeqL71xMbjbhWyUYmFw7eXnGCKieUdV3jr3VwLzkL89cSULzMB
         xAvKL6ck0ocm9TP4QAEy8ka5xvnobcyDJ/jRdS/TLdB/oLEFdQ+iiGgSOOmZepsfkYgO
         DVh8+4lCkqX8Vopm2PCo+FoTW7JhKM5cHIbSPA5fWhJAK02mwBR6AomTb/JGDc8S+xo6
         A4wlSMc3Qxz18C/gZ6OW3d3yJHpIFgPY9uvsP2VlxtWYVPLc9BnPdg6CEmcmdGzqNWv0
         uCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794777695; x=1795382495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+TujgQ1BSv/6MjNJRe3WggEHkX9fvK2a6kRHkLOphI=;
        b=FG1Daqrz+YFMIB6UObOLXAqdhHKfx7Fk9rrOqUB8NoQTG0d07etLqnLOHfEI7xqhDw
         raHN00zhn9Sw45qsniNU4RTc3OmRFML+EvVufS9crx+hydH53r2bN6l0I4G+qv/24ysT
         VpTVRBJU+Y1BY0DVGwEbeyNX6yZDVthlAwAGIepeapRDYzuMhQfZJBlKsVe7nvm5dgEv
         zUIqh3tjbHTDKJDch8zqz5OlPIeFvFbINUtooZnItxfzmAtveEQ1rjLZLEGN+hHhQfQq
         Ww4BNYF1VRNwU+4VFoco0V0A4LOXFCEAhqriq1ugkNn3rWHH5CK4T2MUuCrsZgfDOedp
         ZIrQ==
X-Forwarded-Encrypted: i=1; AL+hErFW3ZHUBy49twMuqIixwvCSMrIN3LUB3YENyhw5btqiyjTDRF/JYKKfpqUsesPNHdtWOs0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lmpq5kxeCb6WbWM6OsDkQIcpIQcmBwzftdFeCb+wFJdo4KpEc
	/CiritCH8+VlJboH+jHW9ZQHeSyVGLNwwSgHImN0PjNMK1DzcnqxdcRO
X-Gm-Gg: AYBFou1Qlov8x+9oaaGBxjToO+f9BEn0rwQVnjStbe8dYRzc/xbeq6RwzAQ2BePwiNZ
	dARVbfxK/7Rmp9tFvWMrkRSBluWiDxRhdkAJeg57gZG+9uABzOJuoH2v4iAAY2308fN0vIjG66F
	9mLe2zPDoHho++bbeLMTmQ3XPQc4f90bB2O8ICZBfP3pmtjdsT/wpxt+42f77QXnVLZYvUMaBl5
	Tz/I/MVwZNCbhKm9btIg9KHPdXjhhndVWkCAvbTzhoG5uH0c+jPDDx2vY0/rXoXJVN8N4zU2EE2
	NGBaWaY+qMcCXn4+QqTBd+38lla/a5eR2vCk5VPBHq+tFyhR/k/YUj8Q+biqThKRDfKiuNG4t6L
	rnoNDVRzI+9w4eDpKF9N14XytCLpuy98rD96FWcyuy8gQFlIfsL7pw4rpu5J1LoDw14swRWoO3r
	/7ChT+BDuGQIgj42r8sMFkmKE/a9baI8nvFsBUj+z5HBBwflUFbbIGlcXrOdWgQxuuSU/KsUpGn
	VuMlb2STnH3RJ+AyUm58zlPPNvP/LtLSFD+d4J8lOkBDMRmhVe7xhWPyAxm4E6xAYi+pwnz2xPH
	1+7a3/mvIi+Ngw15DgZov8Og1iOqQW9SZYj8SWO4tabiO8z9PS5D6eFkcFt2WUtbB02l9G6r
X-Received: by 2002:a05:600d:644d:20b0:4a1:b027:99ef with SMTP id 5b1f17b1804b1-4bb55a3f05cmr146093485e9.2.1794777695431;
        Sun, 15 Nov 2026 13:21:35 -0800 (PST)
Received: from Nuel20.localdomain ([105.112.221.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55a0ffcdsm217726975e9.0.2026.11.15.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:21:34 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: kuba@kernel.org,
	tianyi@cloudflare.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: [PATCH] selftests: net: veth: propagate channel-check failures to exit status
Date: Sun, 15 Nov 2026 22:21:16 +0100
Message-ID: <20261115212117.48496-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chk_channels() reports mismatches with a "fail" line but never sets
ret, so the script exits 0 even when channel counts are wrong. Every
other check helper in the file (__chk_flag, chk_xdp_feature, chk_gro)
sets ret=1 on failure, and all chk_channels() call sites expect the
check to pass. Set ret=1 on mismatch.

Fixes: c017800af5c71 ("selftests: net: veth: test peer ndo-xmit after GRO toggle while down")
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/testing/selftests/net/veth.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 64c2a5a59821d..5c1dbe1516bb4 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -130,6 +130,7 @@ chk_channels() {
 		echo " ok "
 	else
 		echo " fail rx:$rx:$cur_rx tx:$tx:$cur_tx combined:n/a:$cur_combined"
+		ret=1
 	fi
 }
 
-- 
2.43.0

