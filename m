Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7636605D
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019401; cv=none; b=GMMqXZXc+ah1SX2+WsZRa9fXcbubvrk6xJ4XtlAfkbERvrg+oU6qUh5CsEDvA4odxq/aT98AsiXeU15S1RZPKMpXRVD3PF27h3UL3HojdEJv5CXOM1A+oc4FhZ+vhRbzEKhkPkO5jtTNK5qXETwfKHVuVXoFzs8qwYn/pv0aXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019401; c=relaxed/simple;
	bh=QdNRFe0vIqkka4xbbVpTimo0ga8a86tcP8wKsinRgWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBDfeJrsRMb3Ee0262MoFhFiXTTL3llLoRJwjYyCeyFoJLGoUZGf5gptM35bH5zk84qYUVJVQdLjjE1kP44hT+fXTAb8F5M5au51xVw8wuHQLk86sWyV3Bn3+v+L1wrqtUzuR8UxnM0WS2Z6fGgbHRyv5y8Z2YFwh3ibizFK50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPARQQF3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPARQQF3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bd2c147abaso82023785ad.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019392; x=1780624192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlP5n46PN41L6jV72akk3EQSHatEAlv9HooAnPxWzak=;
        b=oPARQQF3/3WRBn+7e7KDPOGGRjbFpEi9o2xZ6O07RlOZyx9ixZpA85uUy/AwH3tLhN
         92K2UC4XlCRqz4FJU/zsCryq7LEVrjnS1wafgN/5KY1yRuR3cPzSM8+x2JSx05JPNFAo
         3VlqRjGhZeO4uy5i4lUJclBfsRBx1g5KaBlueKvMN1IoyCcOdQB3ZACIqrVJ4O16kTYp
         YEZsN9ZWb2kdNZbV3VZCLNMK82Q1RzAE3zmS7TV8SKFIs5YnQT86KaHK3wMRsVYZeCs4
         5tSdMWSK9fqKGFEjbZpQQzmjfA4g/WagIkv4EqzERXyGCBW9LizHgSoE08R4SEhR3QVY
         mrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019392; x=1780624192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlP5n46PN41L6jV72akk3EQSHatEAlv9HooAnPxWzak=;
        b=QH4YvkBUihevp2XYsydjCLvEbRDEf2rYCz8BKXXlQxDXcrNwztR2D6EFwIOsfKB4o+
         i+PMeulgKlKXAKd85qRCSThUNpc0icMZ8H4JAJYbtHm9dtbcwo/N9SvhA+GEVKi+DaPf
         8mEnh3MrH8m3Nuu2kbwyoXhPiHONbIGVmgMUVfpjvco5eNYI44lMt9JlZEYzKvaX+CbS
         o3s2Tl9DuGPAzqv7GppL3XHkb1NrZSqf2LskvihqSuxeY0DTovrLBGVNLJdDwJV4mCP9
         M+ATuO5zRAK31u5uY/GhFr5WTi9d6DMqzcW1yuMc2SQmDuaIMRgEujWDBxTfiel7ytFo
         whPw==
X-Gm-Message-State: AOJu0YyWEHkER334Sl3Bj/z88/H1I7sAk3z7CWdNaNPnNKuBNzRaC+6u
	DPp7ddco8Cdq42Fo/+T830CPm/Qw9W/i3lOKs0G5q1kxhEIrQy2hC24MumaMUA==
X-Gm-Gg: Acq92OGsjB7YeHvLQ/BK6yz0/b3ocqBakq0WvURSvFoj2rkAOH5F+tdvkmpzoPlpGG1
	PbxMustHAfs3Nq6TQYXxSMjt44U5ScJAir1yRNCBc6RBiE/YUWOpYIOPhWKLxcO7Bj/Fu+ZaVzp
	YHyUdfRereVTWpQBGbZWm77uvSu3fna2kdSBi7h6ehNvKnAKAnp5yRdRPbs83zDYm6hUmzZzFN3
	L0XNRDGv57O8JYb5ipbPB0sYgjQF4wx5jGFTPPBrN6frhJWfvsy7noUkkCD5Kn5JFSYQ1js9trZ
	yl7Oz7M7c5qLS3IZ8oPC5knjO3AUkXIeL/h+XLPaAm4yt5FIBS/6KNMatEHhqaHpOMw1+xuBmUD
	Xwwwl3Ri2ukA1o47tFltgz1neHPFKoOv+PaIQzFB7qChx441Kls1GqhlHAkw1tzI9oYnGFLByOU
	luoNDLhTh8BFZmUb6mUpxSV18=
X-Received: by 2002:a17:902:f54c:b0:2bd:7ff4:ab0b with SMTP id d9443c01a7336-2bf20cec053mr11149765ad.39.1780019392139;
        Thu, 28 May 2026 18:49:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a0fea7sm856715ad.29.2026.05.28.18.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 12/13] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Thu, 28 May 2026 18:49:35 -0700
Message-ID: <20260529014936.2811085-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File dynptr and slice should be invalidated when the parent file's
reference is dropped in the program. Without the verifier tracking
dyntpr's parent referenced object, the dynptr would continute to be
incorrectly used even if the underlying file is being tear down or gone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 0739620dea8a..d5fae5e4cf9a 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
 	bpf_dynptr_file_discard(&dynptr);
 	return 0;
 }
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char buf[64];
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_slice_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char *data;
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	data = bpf_dynptr_data(&dynptr, 0, 1);
+	if (!data)
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	*data = 'x';
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
-- 
2.53.0-Meta

