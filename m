Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446971;
	b=Jt3vnmkrqcU/Rozktq+uNtrsG7HKdihNYSZw1hMmXvoDumDjl3w9vHPiL0S/xiNTnGgr
	 FT4whk0IakUma1FMTUGbqVBY5SDB44FU3Xpq8dpW2B0N7ah+aJQivZ6fJuBXXRcfzM5hz
	 qxczQnAr58Sr4WVQP1cJhUO04Urt1xCAfO2fLpA26tazxLnNHUlRP9jOJtdP1p+UVVQ2i
	 qB4b22H3xP5cH7iES2IhZqZwi2tDxbhKwtCG6eIkiVpjcnDYKO7MHnbGJfU+s73jSOIpD
	 WJY2cPNxPN9cMkBSG2/xhy+H5a1fh6M0K8JxF1l5cZGHRaokyK6iXUuyUExVYlyGM1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Gg4z8zGYPV+aYRQRgAT4Ld8Ry8+v6ja8hMnQq1tbnmg=;
	b=LgvU/WgpC5yW7J9xN1QWbMY0Pulv1/M3MpmsmDdgwo6XeC1pJvC3CY+PgAWxT7e/d/7W
	 eP7BgCl7VU2E6LTuc213sPa/6nhvqPxoUAWUGclpefBJ/JVXIHwenvAfdJpuMy0ZjT6q+
	 nEipbOLFvREPLfLVWQxrfRonY+dqXq62hr8i3HUZVL9oEIHhKCDMN3eukMPnaKw5F9FOe
	 M+SHf/DJNxA+9lL66h6NsQ7fglbK+cFkIPQUxJScRgdotLhmwJOqyVyPv8DeyUCSEgM3S
	 xD/06dwsaPeHkf75mjPKGcTXrX1OEJqjOfPc6YqfwehGHHR65b89F7JyxDptEyZ+ekA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=notym0Rr;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7B606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D7B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=notym0Rr
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4877837890fso1906962fac.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446970; x=1796051770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gg4z8zGYPV+aYRQRgAT4Ld8Ry8+v6ja8hMnQq1tbnmg=;
        b=notym0RrAl2ovBSwOYI9wlYcIo8ohN2uGsNU0xAPH7J2tDjuiIOkz0nHe6zW6M5WkE
         8R/Et+NX8oHOxYIGwonCWOc2Rz5KASZIjG6b/JgAN/tyXugA2F+RDNHJYxzf0NY31gBA
         CMxKuj99QQVhjE5lbf/AoTIRz0MUSPMfIJ3qRxErxLsQC1RZVx4ygY7WvB8jNB4+eNZD
         ctJn6TOp1wvkTY1+JcXA7+iHlfbU0DNyvOOHZWvmqJfh8FQoyn/F6WDs564nybvk9WoS
         SaP9kWAKeWbNahOnbEv/Gx/mWULp4vlXZEa03sPXn0W9WPq6OdMgfJKmr2hwr+ZP58We
         CC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446970; x=1796051770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gg4z8zGYPV+aYRQRgAT4Ld8Ry8+v6ja8hMnQq1tbnmg=;
        b=xWva6+xAXCZz5cWyia38f5O1vDeghI9IDVSGur+LeXWBfbwwTNxIcaWLYlV3CSKKS6
         /bttIw2Fe8mjxYnSdtfE2zpIe36F/N5UoC8XecY4YrBaFp6dG0Qp16Lx5UAgyvrZZvCR
         I/UPQx2Prs5RJ5VvQjBkyV9MDvJNZcxa14f3jnyEEMNS7rduZptIlADSUw6/v0d1jz8H
         0Niq1qw3w1QuvDnv95QYjgfRXX3ndBLHBarp19Qdc/Xq8npT+3DEoiW/z1ZkMdjdemTP
         mfU03xSwxvK4c2LIeHLSyo8ctKQqRczKSF111CgIia5mA0bUhQPyC063vYgO/atP6Fxh
         44/Q==
X-Gm-Message-State: APuU4Z9FDwp/IP7sO/9AYTSWrn88sYosniVwEqtaFnriRFkvCWf5JjGm
	NzGY0wyhGmmgTT/CQiA0yEdd1uDW0op2MkARvS+Pfizbj2mwcvIuq2q2NhmzyH3QXig=
X-Gm-Gg: AZFdTZfkxX8VEhQMAoEgljI3RKIa9yF7jSMJiqoTsHVR2Jr1QwHr7N9n/vgoYxop+o7
	SWvodcbXY2HWKydU7eK/fo1jWAYBpX7AsfrZo6fNbMM8G7dZ2/2QJr9B/dhPnsbtuivrOTp1KYA
	/168Hvkg+lG+lV/oOdkgblGuXA125O7zfweuDg8tnPLnkJm84A0wJljOga8OqesW9wwElSJ/Mc+
	5Qy6n6XbrrUjYK8pCnNHOfpGnXYdbR2lZwf6ieIJMTjZMt1wt7Xp7AkJrSmDLIVziBSgFBSqCaI
	8UM7pJNzcO69uB3V/G2qi6PujxsGTes7cSGzqx7Kx3B0HDlhySGjF3MOL0tqlboLkISttCOMJjK
	dzgoknoP0oMAQyJ5GxpDU4nE8gHBTyV8Wu/F1GyHeox67Vh0Lwq8tgHi5RgOFlgni67wxZGaK/+
	IxPuE3nlX1TXsIaQ9dxGlbw/SVL0ZLACM6mM+UN4yA5j/xcEpnYEIFc0k2OGBKknuo2S518r/Jg
	BMh3jagI9nyuUh+7chlwFA8sxwC8LZuG4TBYCmOT5NykK3OltxdQ/lbqBAIN7K+vm9yuKRlVmYO
	DwI8PvAd3f7z5Dr0gWY=
X-Received: by 2002:a05:6870:5b99:b0:48f:e24e:6b6d with SMTP id 586e51a60fabf-4bc86dcd701mr10760036fac.62.1795446969729;
        Mon, 23 Nov 2026 07:16:09 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d766sm10971373fac.2.2026.11.23.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:09 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:45 -0800
Subject: [PATCH bpf-next v2 05/13] bpf: Size new local storage objects for
 the inline area
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sls_f1-v2-5-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=1686;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=e+UdwIy4/JW7xaJWoLm2jz7ASvFB3oEou2YdnUjxn70=;
 b=bRuBCEaf7ghFICselFVPuRU+KGaY380MIFfmMQf4e8WrGl0w+AsPEc9TJU1A7F3rsZCdHxDlX
 3mfPf3shZSNA9NumKlkpOH0gbI7EJddWoHEmXOZcG7bTg04LYJ2DEU4
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A storage object must have room for the slots of the inline maps of its
owner type. Make a new object as big as the end of the last used slot.
The size of an object does not change after that, so the slots that an
object holds stay at fixed places.

No map can have a slot yet, so all objects keep the size of the struct.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/bpf_local_storage.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index eed6f18bf52a..072807a1245f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -525,6 +525,17 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
 	return 0;
 }
 
+/*
+ * Once an inline map exists, a new object gets an inline area up to the end
+ * of the last slot, also for other maps. Its size does not change.
+ */
+static u32 bpf_local_storage_obj_size(struct bpf_local_storage_map *smap)
+{
+	u32 end = max(READ_ONCE(smap->cache->inline_end), smap->inline_end);
+
+	return end ? kmalloc_size_roundup(end) : sizeof(struct bpf_local_storage);
+}
+
 int bpf_local_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
 			    struct bpf_local_storage_elem *first_selem)
@@ -532,7 +543,7 @@ int bpf_local_storage_alloc(void *owner,
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
 	struct bpf_local_storage_map_bucket *b;
-	u32 size = sizeof(*storage);
+	u32 size = bpf_local_storage_obj_size(smap);
 	unsigned long flags;
 	int err;
 

-- 
2.53.1-Meta

