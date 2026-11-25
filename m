Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625261;
	b=j5O823F3rUGsh6HPgXypDM5b0tBUDVIMSTX4VTJ10cPMmBilnSNu/HL+MBSwPw5zWd28
	 sRJdR53qJZ4EbfULfU3lz7JBcnHzJooABo50jVmuXy/zUSnSMO6sGqkDNKNEo9xSCcQLc
	 dO6W3eHGH+RLNF5SKl6O6OSrp/PT79oglULE6TRYv0QXILS5VMg8quj2M8LqWGKCZn5JD
	 Ez2SQDGJTR9Vk0NwLOTxKVN/mbeZpVxmy+/8OVllj4eJVILn0u5TjNe73FRnPQr+uvZQ0
	 ++P77p7FcOy8+dicscceROowRLPz1QrwR9U18vSBB/AlmcL/NnEZ/34tVvd+ujR2tfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
	b=MfR4On8KLUhHp6++2x+MeiliKpEoRtWmzhpQzCaHABZqPEmuAy7C80aJZjyQTuMcUlh4
	 isG4I4Pr4GqVRPS6nVNKDsQqLb1CvqWtGqtOLhipKsHU/HYz3Xk4V2IuKrqTN/lka1iiz
	 ziNmiBdeSEvz3KPwdOq1UcvPCUP8bN87F3+87Xf/dXIGBuyVUGdd0PSqVufAX26Dv00La
	 2WcPMZ/Tb5uNdcqh3b4ptI2q9m5gOrWTGIaOQ0JIE9XwQrArSR3tjQQFz8+ZqhdJb/Qyj
	 43qmTr1VtwcU7hfpCtWPXMmk6B9vU/StPnkEXsdl3YeU4n8lR1Cj73s56OK8tcun5Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rB4+0FqZ;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F6606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E53F6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rB4+0FqZ
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04bea9a93so53039155ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795625260; x=1796230060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
        b=rB4+0FqZ1CZz21tsa67voyk2x6NXgq81CuBWayyF4UYmvBgatYBVaNcj/3ozmZ/iiM
         Da08/9XHKbYf1SubiB0vnwwEfpk0cUM6dbMszpNggH1KM4iTht9Y2Qycao7aHdIFLIKO
         weAIxXq1I4sRGtOJxXW6XFU1Pw5oqUyb1tCMu+Ks6RdklZBC+nzotf/WNkFKsIIP6tuW
         OPAGrBEDHx/2Gu/lquPrKXhMrcQ7fanP0jl1JoF0T7kOJ1o6zExCytCUu+WanrH6GsCi
         z2AxidbqRuqhFKtm8Q1IWm3dnCt8cAQGcfSJx5r2wEdC1HmXbDPeSnpuFWgG1WWF2lCb
         e18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625260; x=1796230060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
        b=ARMnzBgKx04pxy72CQn1g7JoopJbMiysjDb5iSl0cwGNOelY+1yB5PQh9YJxf3JmED
         W/yE+RkypunjUH6T241U7DBzrXhXOTd+fwOH+J0yXQ2sFXuQ0zszEtPN3MgDGPSvaod1
         WuGHq8BlvhommxTBg1pS9dG0i8ebechmZ+d7dJqaopcT+14z1fZ1kISwuK+qPGu7N+8m
         HhbTbT5RhhNkrvTUevzeSR3dauMNZbBV8FiCr3rKlzUaTELS9u62iCTVXvkDqC+bZ8g/
         PfO8nWH/WshHX/S5DW3FAYRSREkV0oCPKcg41fvfXQbWtqtqPRyrpZNuSmOm9RyJsedE
         5G5w==
X-Forwarded-Encrypted: i=1; AL+hErGmI0vr58YlGufei7ymbOLq8Fv66izJMyeU87+BBuaQvSzkz6cRVN1Xbx/05bwBz8Rgros=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KUWUdzIABptFHbsQqZLrfUBbLCZ3FO+4se1aYNIa98rgLopyp
	tki2vDCv+eZxGU8RrLheM3rPaCIM0qeemoWlG91+X4xBcuY794ETbHU6
X-Gm-Gg: AZFdTZdNDbknBPtceBBM3IuiD9gelfD3A3TK6/U91HdKMkxWh4yOsdjyuyQjVJsWvqN
	uQcpCB/hAGYza39H0lt+rU3ST1RWhsDh3FALwYHn4HBqrIEwketE8IRdygP/sDjvBpuLkpxeyKY
	m4pKCvY0LbxPyBGKGoL6I7FYHVtF61x5bQ9CXh3coU/PUzkYb+FU9g+SFSysvuu3djgXmYrQUiX
	3FDbQZHL3GwJOMAP8phnrgxCyGT0NfNFw2NBX489jFt4VnPdvFCXqXuI4R0AqnDqfQV4LTKR22t
	TGA6Lvx3KhigabpSgXG6s/uw+qodHgZHVXesEvYAjHrTukjRFJx2ZuQp73ctRsrleLzsAW3sgVt
	x8XzZxATNc9FrHhRyKucVfsY+bAKymuZK75Z3D/1MiwqPhqchRTp6CaEFevsXYkqFFwuZK7awKU
	meVszcnqKi4CANzwxlgNGWvQ5YLZn29b9QEuoNbfLQRV6GDBuTxHX8Y1ZcLMisRJ6m+B2Y5MSYs
	X6mbaRc+81//bjexrimmgOFrqE5qUqsB/JWg2C9iy1oXNAcio7SHpJ0JWTIFPhJG//AoKyvnNwo
	Tq2I1ZxAVQDwkhLmInrbLL24IlBTTSmUaBpK0LhnnXcOYsUkNgTwJGjs1RzizK2C
X-Received: by 2002:a17:902:ce85:b0:2f0:3e44:4761 with SMTP id d9443c01a7336-2f03f25e801mr192769945ad.54.1795625260030;
        Wed, 25 Nov 2026 08:47:40 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dcbe3sm89876535ad.28.2026.11.25.08.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:47:39 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Shen Yongchao <grayhat@foxmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: bpf: fix use-after-free in hid_bpf_reg()
Date: Wed, 25 Nov 2026 16:47:18 +0000
Message-ID: <20261125164728.24914-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

hid_bpf_reg() keeps the reference from hid_get_device() in ops->hdev
and adds ops to prog_list. After prog_list_lock is dropped, a concurrent
hid_destroy_device() can put that reference and free the device. With
hid_rdesc_fixup set, hid_bpf_reconnect() then runs on a freed device:

  BUG: KASAN: use-after-free in device_reprobe+0x111/0x1c0
  Call Trace:
   device_reprobe+0x111/0x1c0
   hid_bpf_reg+0x3ce/0x420
   bpf_struct_ops_link_create+0x39b/0x4e0
   __sys_bpf+0xaca/0xc30

Hold an extra device reference until hid_bpf_reg() returns.

Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index c90b68956cb3..e2512bd6e6b2 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -198,6 +198,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 		return PTR_ERR(hdev);
 
 	ops->hdev = hdev;
+	get_device(&hdev->dev);
 
 	mutex_lock(&hdev->bpf.prog_list_lock);
 
@@ -239,6 +240,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 		hid_bpf_reconnect(hdev);
 	}
 
+	put_device(&hdev->dev);
 	return err;
 }
 
-- 
2.56.1

