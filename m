Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345642088F
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455497; cv=none; b=LHS/l5E2AETTU4sAHLgrZm2Yo1LMy2KiG60D+pYWr/lmRc6vD/ucNhswrxBVk8q7eMah8PNURnE5cRC7Vdqt6ntOy8pCtoFtN/9+MxoIhLuqmAMtieOWyIfnqDc0tDMbdr6DuaznjCnDObHk8TcYeGeaxFM4eqgRAqoNXcIsl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455497; c=relaxed/simple;
	bh=YvlbfEr42VgvDbDrD2oUGfJsl6AwqqIX692YUd9nhjQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nZDUXzWi+t1D7+zhJMbLmbglzaCv4g+IRR5KLQoi2GxSBS3ZmPkhgm0f+bSftEuR5A6ysDCrUDfhU+/0gnSLxy1xsg+/T7WTZOIN+yhn9Jg2SrRLYMjRMmRYLSoWE/IpDiNO+a7WCjOiGyr0ls9mIiWw6ehKP6w8RsnDbkgym/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=pass smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=mUYg9iLE; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="mUYg9iLE"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30f1c5dc047so20383eec.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1783455496; x=1784060296; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3YJuYaQ7M4UXYxxtI/b9rrGfHYQ+qlrA3fBcJCd5BE=;
        b=mUYg9iLE2wycNy3q38Kbe7gUNKziJ5EdZJQ3h2amAaXrwwc3s5F2xiC86/kw93CdFM
         37owFuToYSWgb3xnAx2Y3jX+bax3Pv4Ez3gCQaAA+6dMLu/Y5MXD95Ni3AjRQS9nTJy3
         X2dSimHWYDTd7It9/MBvAUUsxUk0zpah/cC3HC1QlIfxEtxIy1cv1DEsuER5mA/AV548
         sBIbbGz9JHJ5yYqHsyix1RHO7oqB/l+K5aGddZw2wViGOb5pd2Q9aXcKKQCdh8nzYnW0
         5N0hLWzWqYOpXtxeCZUxvO3fL+DzGAP1lTZ1JgcLBP7m7ZXVujvQiyyHlIpdLViE0YTP
         GBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455496; x=1784060296;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s3YJuYaQ7M4UXYxxtI/b9rrGfHYQ+qlrA3fBcJCd5BE=;
        b=kPilYcNjctCMqa81rxQ0hur+B8YVRDQ80gw4F6KyvYnqQp14iGJYNPQYTMm3UUpSgj
         FoWT1GjqCP0A5PM9/vsU4VclieAAxZEi2OxOuA0rmMtupS37m3/ARtadrRPl7eGWPuNN
         xgO57MT0waKayi81uusNOrPN/DyAxdWKPmrCCLrhmOiGjAZrGmkYttVvwKuWJxP4p9+P
         LfPAzWK6rC35EbMzaA+MCRD9XuBYqBANDZIOR3cVlkuPrTD+NQGBsEZc/zliWjfk+R10
         NippGXwsTIydWg3iDFn/jNQeFI4tlS7+wz3mFsgi6B84qwqNXb5DhgO2jCurVfJzncUK
         zzOg==
X-Gm-Message-State: AOJu0YxvB6XIi2quYqSG01mHdIzkQb8d6uXVnm3/Sp5A7e8qip5aP6gi
	qJDLNtYeTXhf1xeCBaHGUTqoxHSObjUVfsEbR/yKzDOPaMBCl9qeUA9+plE8UJI2lE4RrqlEvU+
	vmxvvN0037ig=
X-Gm-Gg: AfdE7cnqPR84h1+UFs1+6IZCJT3arcOiU9Wmet7oOAZaRvCgzVhhMMdyHSZqAWhAewK
	L61saApJKkrgRYCxDNbvoPO/q7d/vndS7sbuRbP5C+BDOmiG1fI4/gIP4217+mpbrS4ajY26mQ/
	SSIGMHCXZxNN7ph13sfMuA4x8+oZKhvfMKNTWCpo/YO6s83Q1TAuWLoO0m6SlJ0g6xssrwtxDsm
	mBlTmBpDobznaJEZtcSCQDhFrUVTXJK/RAifzpVzoUyeZ+x6KL4FSXl8ryE6o4vtt/tgbmLzf0u
	VKHYnMVoO1NzjkZ0JThINtp443J9R+NjT0zuvmDEptXmK7r/SDJoqyYwiFLKYt78Yy/z6sYx1KA
	VOZxzAlcJB0cCYftCBe75ww+7PvrpxP8O0PcfzFW1DZcm2XL8Eu4EiC0BIJuwEBU8aVZ/bsHPB0
	dl5yvZx2j3rBN782HUaY2GpyRvO83XMBcWEaIvO1OtnqnF52Byx0+fkQd4wCtyFcC1J1kpp8hal
	EzzHRwrocaxBDmeJsjDE88w4pgJAR2yggrMGEtF6MEY5aIsX9qTZo2UpvlOHm/mRHz2APyNiPyz
	JpDaAGJSfkr9f1u9dqOKIg/QACyxFQ==
X-Received: by 2002:a05:7300:f691:b0:30c:ab4d:3826 with SMTP id 5a478bee46e88-3116bc93ad9mr72611eec.40.1783455495656;
        Tue, 07 Jul 2026 13:18:15 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2401:4900:62a5:8e1:38ee:5908:64f2:589])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm12227799eec.31.2026.07.07.13.18.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:18:15 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: bpf@vger.kernel.org
Subject:
 [PATCH] libbpf: fix double-free of distilled base BTF on .BTF.ext parse error
Date: Wed, 08 Jul 2026 01:48:11 +0530
Message-ID: <178345549172.94179.7948304165383170781@digiscrypt.com>
X-CodeOps-Marker: d4ecb6eaf12f476582e9a327d30c69be
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

When btf_parse_elf() is called without a caller-supplied base_btf (i.e.
via the public btf__parse_elf()) and the object file carries a .BTF.base
(distilled base) section, a dist_base_btf object is created and used as
the base of the split BTF built from the .BTF section.  Because base_btf
is NULL, the relocation block that would otherwise free and clear
dist_base_btf is skipped, and ownership of dist_base_btf is instead
transferred to the split btf by setting btf->owns_base = true.

That ownership transfer was performed before the fallible btf_ext__new()
call that parses the .BTF.ext section.  If .BTF.ext is malformed,
btf_ext__new() fails and the function jumps to the error path, which
frees dist_base_btf directly and then frees btf.  Since owns_base is
already set, btf__free(btf) also frees btf->base_btf, which is the same
dist_base_btf object.  The result is a use-after-free read followed by a
double free of the base BTF, driven entirely by a crafted object file
(a .BTF + .BTF.base + malformed .BTF.ext combination) passed to
btf__parse_elf(), as used by bpftool, pahole and similar tools.

Transfer ownership only after .BTF.ext has been parsed successfully, so
that any earlier failure leaves dist_base_btf owned solely by the local
cleanup path and it is freed exactly once.

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 823bce8951..35695f33c6 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1506,9 +1506,6 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 		dist_base_btf = NULL;
 	}
 
-	if (dist_base_btf)
-		btf->owns_base = true;
-
 	switch (gelf_getclass(elf)) {
 	case ELFCLASS32:
 		btf__set_pointer_size(btf, 4);
@@ -1530,6 +1527,9 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	} else if (btf_ext) {
 		*btf_ext = NULL;
 	}
+
+	if (dist_base_btf)
+		btf->owns_base = true;
 done:
 	if (elf)
 		elf_end(elf);
