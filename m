Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702669;
	b=Wjn0LUXg0UCCs/gplFtc9OemAd5FPEGXgsQV/o+B3z+ghDDAXMYicEFOxsuq5j68yXKp
	 +aE03vBdmrvhPZrdAsudsNTG08YwZPxtkwKnTP1FhbWoCCYv9BxhyyRkY1K9aZSLMr0ek
	 zzhOP06Jmyw5b0K6EF+q4NG4wgAkqZJdQcTqA9JoxJO3NzEyUk5+7VZQZKrZuq3m3atme
	 S3SBfNXjFLDFOjqCTbXcyxJ+q3QaBVdT3I2T+2KYfLm2t84TTXeNDbp0GV/NYOa8j13Nn
	 5J41YbGfHXhJxmQWC0mmWkC7xH8O/TCNsUMMNvYxx2A7EUag1d7f3a6iIc0kzz2drjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z6ykgrkMMyBAUInCD16Y+ATkC5Q4k9ui4oYvrlEbxh0=;
	b=LY8n0elp9PDD+jDh15rTqWaIzrlYQkVWjt8oHCLxup07dlJEjz1GSzd805Mih0B/ezBh
	 +PoJ0NqjuVf6gd5aezarn7PYACVoBp5DXFci8NflwaOPZ3FL6DKlEoamoTDaJmQEScB69
	 HNlWWzSLeb3OxyrWSzn4lN92QdB3As4JuPT3eAH+7OgUpe41X13kXZl0xNowFFuT6qb5z
	 atOuNdOyDlm2RedLlUWk4isjJHnezEdRCHdbF5ibdPMYd6Zc6UW71/IyxLQHSaKMtlVMQ
	 Nl//3cYYWbTXE8t6SCTuyuedpMaDKrcVhr/FCYVhQiVvQ0q7dJKkLZIv5eYF6lBl59g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gd9uqDMM;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D68606A332
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D68606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gd9uqDMM
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso55308695e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702668; x=1796307468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6ykgrkMMyBAUInCD16Y+ATkC5Q4k9ui4oYvrlEbxh0=;
        b=Gd9uqDMMOe5Ar5udezuvxwOWIOsuYuvdbnmtszEVMRimGFT6zNSuXIxw0F26fOrlI2
         QNAxyZjEywID0h0Jrkrz1VY8USt8+cx+b96ksH3KXkJXcTJA+nZYFbSlhMEmtasxzLsA
         fkFJpSnsGC/wIVBmQE/0PAvEUEES8DKZJ9991cl3Tz9xaicV3WGiNPUFKDhQ0QhvwD5S
         ASsZeq9WgHtuF+OXZonjtUXKphkMZ90pl177hPiCaac6l/0CtUfpC1FwTiEsGUYZqtI0
         dp6Yf3EkkeeuY/+N82l8qASsQttgaRuWBBS97fOBHb1D2qnym3g4v1TeVD7gDRMFKF86
         1vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702668; x=1796307468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z6ykgrkMMyBAUInCD16Y+ATkC5Q4k9ui4oYvrlEbxh0=;
        b=fHYFv4OjYK8spaT/LhXN+2gIqjVxoXQqqC7DJ8M77I+LFEQBzz1TzHy2tR3PRFjAaR
         SaOeGY7MmeatJ+4A/NK1bIdZ13qUyHpAD7vrwS0muBy7Wj7DdOHxC4wSiCRVr/I0Hv/g
         0KDt2fmLCG2cb6q43Xa98fGzvQ5fG0tkmRaFEH2qmnk1VeaGmZ27HTr0XE+8nZ8Umzn0
         R8JSat36Or185Ugphibm6z4DJIqeh70qWh/rulMA5SOoo+8a0Z+yOZ//BQor2clFiXcJ
         yZys3KXNLsqSXUU7rHRet6aoXcG668NIzAeRhu93YyOTbxwZIaoYHai8YVfQrr3uNt9v
         Vhxw==
X-Forwarded-Encrypted: i=1; AL+hErEMpK81RFFcQN8cFe+HCApPn88HBFPIT9P4CMUGr33Da6/XetIhjHGyMuot8AiijwYFizo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/0VbeKWmpsFbOHTFSAn3p5ZBerz/zPIe7hDUwdsp3nGl6rPEQ
	9u+kywkPaPKc973iHPWNjK7oCedWq//FcmXcUZzxxOD20lC3iqv1yfvm
X-Gm-Gg: AZFdTZcnP0VTGNSki/9KuXrPH8yrTSs6kGXVJCjY+B9O1W+2baRxgyTMBlDB7vTSTIF
	1aXYu5pW4wmf8WbOpR0/jqJ/BuzcqH3GBiGCbiDP8HumhdbBtEXu/ATraMBZM/jxwL1AaAZf0Zu
	zWrYrLc/vuCsPM/X9UlQFd2ueLidFgxtAGvBhrlPVSt0mlTxJB5TsUZbS2fnjzkN4t1J44WP2ny
	gH0uFFQLPpX1HavK6jCJ7EXuPQqDCv3+pAWSKAnJFCpWQj5nasYLDb0QjCmv8YXABcTSXxlCY26
	JGfMq07dzrJWPeCe9wiYKmC6TD6qjWojv1IV5mvb5/U9Zd2buHYR8fuahNvq/9bM+A05fKk4jyI
	cRkq+SNFoKZALeb0DWamKAen/EOIwCrKQKkLcQqQXuaEvriL5bx5J2fu+lLUTAFMS6uSYMgfuks
	X53Wer23fSKy5puWl1CdFRgmmbh86/pEDv7xGXPTtlCzPbMl0+nSMg0vxKERtrvzLfK64qGhAAp
	kOvw+BCpL4ZGiX4ui/peDk5cJPKoBQMRnpe8C+QGrp7WykWHWRJLUMK3GAwRb5etQrM30ONOxNj
	mTZAkiDhVxBsizdGuyoYanaFyViA4wPa4aBY5GZbyEIJO7ob
X-Received: by 2002:a05:600c:848d:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4bb88810b2dmr416202665e9.16.1795702667555;
        Thu, 26 Nov 2026 06:17:47 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm596496575e9.5.2026.11.26.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:17:47 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 5/7] resolve_btfids: Exclude bpf_*() and __bpf_*() of vmlinux
Date: Thu, 26 Nov 2026 14:29:11 +0000
Message-ID: <20261126142915.1106330-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
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

bpf_unlocked_sk_getsockopt() has no tag, but it passes optval, an
ARG_PTR_TO_UNINIT_MEM buffer, to __bpf_getsockopt(). That one clears
the buffer on an error. It takes no BPF type and is in net/core, so
it keeps its tag. After a skip the program reads its stack.
__bpf_skb_load_bytes() has the same memset() before -EFAULT.

Do not tag bpf_*() and __bpf_*() of vmlinux. This also covers
bpf_set_dentry_xattr_locked() and bpf_remove_dentry_xattr_locked(),
kfuncs without the "bpf_kfunc" tag: specialize_kfunc() calls them
instead of the kfuncs without _locked. The functions of modules keep
their tags, the selftests need bpf_testmod_retval_*().

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/resolve_btfids/fmodret.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index b425208702b4..d2d4db1ca3d5 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -105,6 +105,12 @@ static bool excluded_by_name(const char *name)
 	return false;
 }
 
+/* bpf_*() and __bpf_*() */
+static bool excluded_by_prefix(const char *name, bool vmlinux)
+{
+	return vmlinux && !strncmp(name + strspn(name, "_"), "bpf_", 4);
+}
+
 /* Find kfuncs and helpers */
 static bool *find_bpf_funcs(const struct btf *btf)
 {
@@ -310,6 +316,8 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 			continue;
 		if (excluded_by_name(name))
 			continue;
+		if (excluded_by_prefix(name, !base))
+			continue;
 		nr_scanned++;
 		err = scan_func(scan, func, &values);
 		if (err == -EINVAL) {
-- 
2.43.0

