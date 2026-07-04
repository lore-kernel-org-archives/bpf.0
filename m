Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99533176238
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181579; cv=none; b=uTwaUv6PRzFil2CDQtkalqyCGnDCvsGhBT5oWPYXYIdEMbrKgZHdMLNA4ThmZCIJOc3FPlvEBCu9w7d8Xw+2PetBtNK4hDVlfAzS0tJalcwKzw6Vi95u32fQU8tD24JR/MD2pagqIQJHd+fsC/8WtBvLp03FZVVOXRDUvWHMkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181579; c=relaxed/simple;
	bh=15YSkLAkQCti5IzcfCpgR1ie8/bhUE9zxOgts1ol0qQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h/2cJcIEGwrI7dbx6CzearHuasaXC6PtIyp4+lHkYhafMInUjw5b9ZbKdpmUhK4Cvsty/+P2+lcCrwquucCSrC6Wgd3JAe7W23XoZmBmaL33Hs7UukoFTkuQVHITG4hOZ4o+ccsfF/QqH0PtReRppSL+YvG3O0mQGud7lmTtkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDO1FfoQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDO1FfoQ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f236418so894347b3a.1
        for <bpf@vger.kernel.org>; Sat, 04 Jul 2026 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783181578; x=1783786378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVfJZz8SjrFuy7zkpM4CK8nsRN5F1mP1tDE3AslmNig=;
        b=jDO1FfoQoWl63oe7sQHDR9oAmG9ONvd0B/WM+i8SLvmyEc8wdBoIceTZbVwCXrRegL
         7at93vxFF7c36HD/Hze9aWa5qX5cjrdsJdPtxEsy0JJb8gj5MW/K3xtiY0XQnfSUASmi
         mx/y1PAbGWAWX5+b5elURf7b7fVzD6JgDJbWsEBebe10/62PdUY3fxXFQcfy+fo7q/Ql
         nkAHarHdeq1+FfG613E7rmXg4SmF8VueVbVasmbqCSfcaG7zrTMGCYkaJCibSuvLZ8eq
         SD2d/KILw6ukW/IfNZmgHqA/Ds6Ek0kbUGfCSjF+jS3qm0eONDr08VJ1saIEmvHoe4xO
         G4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783181578; x=1783786378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kVfJZz8SjrFuy7zkpM4CK8nsRN5F1mP1tDE3AslmNig=;
        b=bii/o2Sn55mlOPhEljexTcWjTTcM/MDnOJjW9OKMJGBryPOukdTTtzu1PArdQZwH9Q
         zdLepxfPxPbLtNCbgEO4ib83m9p5lKi6AyAHuHZnNIaAiwvTpsjqypJnGJgqI7Z4UtOL
         cEZWdlFWk24OK45rEQrztQ2M/AxRadrEOcxcunG/y8QiWrnI6WHXLqQnFBYrg3y7ASHY
         kWltt9SzJ+S0NYxcH1J4SyFK9UKChXIkWa1uxNse1VyCxTUTzwmaef7RrGdEVPhmN8tl
         Yus5qPiJBoCAPiR/Yjsdxq2e16wP0fqOsc7KAYEEPrEKtzsJmhulpqHWWs+SDnQDqMWc
         s6Zw==
X-Forwarded-Encrypted: i=1; AHgh+Rp38211fdId5uf9xYCSmQdas+asB4W1D6Do86VamenBaSMfXho+bqOpV09u2srDw3HQ8RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjXtTBdE8v/v+FYKtnaXBV0qP+8y+S3qqzQPWW49kF/bzOsj2
	9K8b4i4cRyu3NElpM0BRUoWa/EHyuD5LtemNjKJbE1BMD1299/mUvI/V
X-Gm-Gg: AfdE7cnMHZ/RcnUmyrIN5lPA9m9N0R5ECpFIagfEcDEbsOv0bcedbj/AbYKNX41B6bq
	7tOsILFvprrbrkVGKN5DDuDqRlQPYvz7Mt8UvdzEJxRtqsdm2qmpZCb10jKQJrvYcqIicGGd23m
	glm5Pao1Z2IPxZn1bXn8ZT3VQ10+qTlRdf839Pg9Se4kESxW340Pq3AXGvs8ER0PBfOTIOtzjon
	IAdvsnHaEDJ2m1dUWr3gatiHEHTxVkltRb/lIV9y5uS29hOLhGHZDrYoq7rFpi4oN2aLIgC/hzn
	jR8j6xqqNVNPOuQ0sMJVQnyIm/8ExCR5+xLamMa8YK8UUIbDxyt4wOA/emE2aPmnCwcjKnN2blS
	kJ38A0tGhsZb3nxdr+lUSX+43Fgqq66ArlYjbPtzz/lSMdDIQlQPTOmfMiBZe/Enw+DBgRlOnPS
	rz1YFI5w==
X-Received: by 2002:a05:6a00:2789:b0:845:e703:e with SMTP id d2e1a72fcca58-847f6dd4a7fmr3713537b3a.19.1783181577928;
        Sat, 04 Jul 2026 09:12:57 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6162esm1391522b3a.11.2026.07.04.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:12:56 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] HID: bpf: Fix signedness bug in hid_bpf_hw_request
Date: Sun,  5 Jul 2026 00:07:02 +0800
Message-ID: <20260704160703.156298-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_bpf_hw_request() clamps the return value of hid_hw_raw_request() to
the size of the caller supplied buffer before copying data back to the
BPF buffer.

However, ret is signed while size is unsigned. If hid_hw_raw_request()
returns a negative error code, the comparison promotes ret to size_t.
This makes the negative value look like a very large positive value, so
the error is clamped to size. The following memcpy() then treats the
failed request as a successful transfer and copies stale data back to
the caller.

Only clamp positive return values. This preserves negative error codes
while still preventing oversized successful returns from overflowing the
caller supplied buffer.

Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d0130658091b..b13f911e5944 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -446,7 +446,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
 
-	if (ret > size)
+	if (ret > 0 && ret > size)
 		ret = size;
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
-- 
2.43.0

