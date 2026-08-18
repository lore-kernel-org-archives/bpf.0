Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511403CB2DC
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074986; cv=none; b=takJxakeAtXe8IIwhUcJjSYfcTc91hMaCU9PFHl/G5FLflDXaNvKHbzF2+UF1BRIjxNDfxkOH7zZeHKbPRddSRv26saKF8TMK0jzDEv8JE+805E7gShGw5BNdYihD6B8Mjm4esN+rklpq+M4X9BkeRE4bMeviQeACk0eRVWp9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074986; c=relaxed/simple;
	bh=jdih85vIaDm1WR10xO6ndaR9LyFS/Bqn6efFH0k0+pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxEQgCxvddk55TYPAWlM2KfCu2X2Ghv8mn2xwzyrWXaKwh08BezwbfGoHuY6eBD/IyBHAFiro+4CYc8MiXzdUWEG+rhcbYwBBMAjkW4J3O3gwI1zRN3BcntwcgKveh3lMLXCbkRFhQLwxBTaxNSHEsWNMUE9301ktkMt4RWEm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCyrv1Ip; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCyrv1Ip"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b966dd74so589525e9.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787074982; x=1787679782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ImxPVs7wW436U1dwrS4Ni5rkXml8A2eZz8xdfOEDl4=;
        b=kCyrv1Ipge+n7OsMekEan7o4iPohmZzad0yqmJ5VbJZXIWT+hYeC6j0dnSmQjfai6B
         0+N9mZmNi0FQWuCBl5d6enNU0Qy41EmQEDNXD0xISwIYWZdQTZNr/Rdj3EupmiJyI2Sp
         WmtFSeiqoF4xxKCYapMGJ/FBO8u1kPkILrXmA8pr56EOEdKoynLWmRhnbvAGFcCOitS4
         vf1qAWa6Vv2lPpjs4w6bVcjjbcSOtXC5egWF/FTQACJDfTp/3oP4eRoYeiumA74kcdku
         lWm+XYbdKrFTelu8CuWePsuJ5r7Y+zLW4/NmeTol/H/uf54v4SZ0ztFqQTFCi+0x+Jji
         +LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787074982; x=1787679782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ImxPVs7wW436U1dwrS4Ni5rkXml8A2eZz8xdfOEDl4=;
        b=hyq/Tn2C7Z0OURmeIdIN92hle2H6Hw4L016Gypdr1AC1sbnBREsa8TMCTMGUCqDRH2
         JKkz0+bi5qRjcpWoRQQBa5ihJvy8Q+TFfH2yGjZ8SJ4BIki1KGNR/UIhRR74QqmzFjj3
         stkb36O7mdZQmNDOVUBx5Dv+cXZN/DP2vzIfTU1fj5naM2ttocjf+cEAm3gx8lTA1Hc9
         y2LogLWJ9tS12yVchbiwo3LFQu78Gj0UWlQSuP6mGS+oXtrSvfVHWUj+u/xC+5pVb5zN
         uWbTzL6wS0b1A9uxWAgbK9fBQPhxh03kT8uaMtpy/1hQ0ee+YVJZx8z8rYeOvk/EdUCX
         lqsg==
X-Gm-Message-State: AOJu0YxSM56LlWQWtDvAaO1nGl9TFsn+kNTlaqm1csIVW8SbKQUeqj+n
	L7Dom0GuwmJH2ube4+fugzuDxQgxlxRGv61VCpDZ9UwobUsHGvZx0K1brfg0IHwVERs=
X-Gm-Gg: AR+sD10hDwCEIS7EIh/wGD0BY/IAZRPW1xwd8ApIkBTlRfHwajSPtabqOfnoe9IM1g+
	hs83MyUWoxmkQnyjtkk8W6lwFPJoIeQesF1kuoXEl2LtdXukpcPAKqRtu7Hr4701hPJHeX1pmJo
	Gj85M//A8enX7aK1aHW3+K/7MxkJcjF7SDO7l2AM0jhu+sAd1ux/FLWDlOUOyI+r4is25A0tWtj
	OL9y++piniSwMkKA3bR9f2havyex/BBcwdBnImSA/18Cd4nb5HfyV0WmmalxV1kLjSKOzOS6P+u
	unDAY0rjl+jH0KBVCm7EQbSdKiKSzd6mcl6VVJ1yYKGTWt25Ywns3FtArOXHSN8uA4iQaoWq/Ng
	HF76sJb1b0y1Vo+Q5ZlKV8SfU62ku03Dsy80CVGn91sX91Mtyery4YOIXmtAYNUpT2mUOPlpTHh
	Y2DVotg2GgUofoB4N45O8rFfXYaboBk/R+ZDnBToTIcMLU9E6+m3Lw5Cl9cPNL
X-Received: by 2002:a05:600c:3485:b0:499:8758:8cb4 with SMTP id 5b1f17b1804b1-49987935eecmr586444765e9.5.1787074982255;
        Tue, 18 Aug 2026 10:43:02 -0700 (PDT)
Received: from runham-think ([141.5.46.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a5684e06sm41678945e9.1.2026.08.18.10.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 10:43:01 -0700 (PDT)
From: MahnurA <s.mahnur.a@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: netdev@vger.kernel.org,
	andrii@kernel.org,
	MahnurA <s.mahnur.a@gmail.com>
Subject: [PATCH bpf] bpf: Fix NULL pointer dereference in bpf_sock_from_file
Date: Tue, 18 Aug 2026 19:42:53 +0200
Message-ID: <20260818174253.492196-1-s.mahnur.a@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sock_from_file should not dereference a NULL file pointer.
KASAN detects a null-ptr-deref when eBPF tracing
fentry/fexit programs are attached to points such as
__mmap_region and file_map_prot_check kernel functions. This can
result in a NULL file pointer flowing from context to the helper.

A minimal check before dereferencing can fix this.

Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_NET")
Signed-off-by: MahnurA <s.mahnur.a@gmail.com>
---
 net/core/filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 16845987b244..7c3caae4bafc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
 
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
-	return (unsigned long)sock_from_file(file);
+	if (file)
+		return (unsigned long)sock_from_file(file);
+
+	return (unsigned long)NULL;
 }
 
 BTF_ID_LIST(bpf_sock_from_file_btf_ids)
-- 
2.53.0

