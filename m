Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752E263C8C
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789092; cv=none; b=YPc/QzAoqfca6WaEGQvdW9FsHg8I1OCmNiAn6PcmhbAWQB/9J5MfH/FS86fVfdUjmx+2xWBXG0vCXuQGSS967s3FRj+WAL+24Zkqz/1KbjJn1NlDhZcABCIvrvVoXpim4vSQql4HDv94lnmb3lgIFYflI82wbJqN6/uqfQLuiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789092; c=relaxed/simple;
	bh=RmUFSBR2TFEOr9r28j+ua/GSxcZ/l4VV4V62muJRX4I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjlc6p09uvjL9hPJ3fQpt2C9uZSin8l+NX4nbWjjddBodxmNcUUytIqnSeGtJgkkG1q1noVkYVdqlPwU+oH1xaeScKoD2HNizjP0Jx/4D7OAr4mX9SxeGDMwQDka6uf04TMzDCmlej5RhTn2m1cOd80rVEig/jm9FEcj+7BCZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=none smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=mIbeqfC1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="mIbeqfC1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacf197759so4807645ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 23:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1784789089; x=1785393889; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNKdmmZeplb5mz0RXlAfiJHX22Smld4VcbFrlxCnERQ=;
        b=mIbeqfC12kfSswlfsFmG+M3VTASFOxUrgJocKEoPmngjDhlvbD7xy++25gAhnG1p8Y
         BWgbOP6VMvev5IHtgtIp3kccoxOdfYB1uJyZIVqHUY67fPFrv7nbX7NVjB8HA3zbgPXp
         ChONC5XJyVBwfYtgDpzksN4WjyAiV/izm7XqAIzjIbQxVH9El2bFKF0B2Ja0W39bjSrY
         HIfu7lrovSMfbhEU3YRRxv5WsQs+fyUBGQYCt/Z3O2C3obNW4hHG/Ayp7cNpEirDDE7x
         zPkFtkEwvJLc+0Xoa7eKhUdmkkWMmIgQJOsQVPbt2heZ0t8dpY+0wRKTCEr4YsaL/uF0
         /PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784789089; x=1785393889;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNKdmmZeplb5mz0RXlAfiJHX22Smld4VcbFrlxCnERQ=;
        b=kRF7JW9QXN7t1wwnIodblYTMA82Xz1tDFd1UZ+28ofh9mAYCPogLCHf2gIgJLb03xT
         xohHalSPBkq1lct4pa7UvDJvOXBqI6UcyF8Nvn463kqnHC1XLoSR0IkdGXUp0aBRJSiD
         bfqCYVG8WaTdXUP0/6tkHXiF3yYeTqJ7/4w8PA5iBxNOcK2/gCxwcxL+eFIKC+H8DF8B
         qL42+dkecpSyU3kz17cZASzN/2nJA4X3vLKigfZeKsUEytKz0pL5SEB3YwiXY7eIjbEJ
         f/WLx4BzQjaddOyHth7lG4cL8Ib5rMSnPXk0U5gMbm1qwyHz21YJ3NZ/nwzP8D6zWEbZ
         N2FA==
X-Gm-Message-State: AOJu0YwTGZGxeC3GlD4Bn2lwdr5RP4Q0mybIdPZzp5G32Nf2JrUv7o2y
	/Nbtk2tjrqJGaSrPUJ/hfTi1iZGmZIAuLpfkYuQjIET7afEtbFK840Xo5P8TOZjRtBggQlTqg81
	FNbB3kw==
X-Gm-Gg: AR+sD10QVeZO++JMJjlpe/8rXtxrPoVB0DVgkeYiTBNfQox8S90cnNDb4QpQzGV3Lhm
	Utufv2LgJGuFjxDJJPfHXYyaBobE+NqqaqLInuMAntztUUGTS0o4yiHUe/z/J/msh7lIC0uA0s8
	1QE76cTGMX+7rCG4lYLwy4mkMBzi46K04EsazoMYuxVBfAwbwSuQVrujmVXyI/JpmMrFY9LD+y4
	hziwsG4pgMN3PTnMfCIzHfddLSBiAZZ7xP3vcdPsH8+rooKQD/AYeeWIWRGTDobNT7F4poWVaB0
	TezW6Gm7EDF/BMv0A6wqDS2WY08aD8VhEysppP4nVMHHarGOIEkCmL63mSU+PcEntsOPZ7K6p8l
	SfCd2VI5wZKhawOPiyxTbBYKxXYYlOd2y13XMzRUg5pLN0iYegAG/I9MK3LbWd3Lm7elZn1mV0G
	jEgvIMHZsA6Z2HGSIb/5jaRm3+B+qAgoMEYra2+iFwmDitaOKkPlYP+9TruQRNLABuD6zjja/hG
	F4swnkHtznEtAp/1KtP8Dx/uDTDwjDhthCvqKRSY98WmLzclIDzg3mq
X-Received: by 2002:a17:903:fa4:b0:2c9:97a9:2098 with SMTP id d9443c01a7336-2cfa74d260amr23881895ad.44.1784789089544;
        Wed, 22 Jul 2026 23:44:49 -0700 (PDT)
Received: from 169.254.72.157 (ec2-13-202-78-74.ap-south-1.compute.amazonaws.com. [13.202.78.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147d47960dsm15534578eec.0.2026.07.22.23.44.48
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:44:49 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: bpf@vger.kernel.org
Subject:
 [PATCH v3] libbpf: initialize btf_ext out-parameter early in btf_parse_elf()
Date: Thu, 23 Jul 2026 12:14:46 +0530
Message-ID: <178478908698.2.4018643732078767322@digiscrypt.com>
In-Reply-To: <alTie0_4pu-T5Bik@krava>
References: <alTie0_4pu-T5Bik@krava>
X-CodeOps-Marker: 656e5c8b5f1a4468b3da1d465ce40d42
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

btf_parse_elf() only stores to *btf_ext once it reaches the .BTF.ext
parsing step.  If the function fails before that point (open() aside,
e.g. elf_begin() failure, missing .BTF section, or a malformed .BTF /
.BTF.base section), the cleanup path still runs

	if (btf_ext)
		btf_ext__free(*btf_ext);

and reads a value that was never written.  A caller that passes an
uninitialized pointer, e.g.

	struct btf_ext *ext;
	btf = btf__parse_elf(path, &ext);

ends up with btf_ext__free() operating on stack garbage, which can
crash or corrupt the heap.  Current in-tree callers happen to
NULL-initialize their pointer, but the API contract should not rely
on that.

Initialize *btf_ext to NULL on entry so every exit path leaves the
out-parameter in a defined state.

Note that the similar initialization in btf_parse() is intentionally
kept: btf_parse() returns without ever calling btf_parse_elf() when
btf_parse_raw() succeeds (raw BTF file, no .BTF.ext) or fails with an
error other than -EPROTO, so its own initialization is what defines
*btf_ext for btf__parse() callers on those paths.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
 tools/lib/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 823bce8951..cabe8286f0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1453,6 +1453,9 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	int err = 0, fd = -1;
 	Elf *elf = NULL;
 
+	if (btf_ext)
+		*btf_ext = NULL;
+
 	if (elf_version(EV_CURRENT) == EV_NONE) {
 		pr_warn("failed to init libelf for %s\n", path);
 		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);
