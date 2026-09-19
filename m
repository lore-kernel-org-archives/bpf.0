Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22D36F911
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839940; cv=none; b=fdKDzkkaT7ZUxvXQ2GB47TFC3t4XRfjXtMHf1Y05z5UmMqBh6KyrCPUxX5UkMiDWmFTMLfPR72/FKMqSYSYGlxfmTRQPoQ96kWjUznVd4h1sD2Kum1sCBZ0wuWi97TDxSO5hDwGs0ZeSBHaZZUeXdqxBUgP/ilNDo9ALcspCLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839940; c=relaxed/simple;
	bh=F1HWSGz3U0kWWAZ7mzfJy+fCde0t5UpLTXKYOZhUHYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRl+hdZ+RPmWcEkfJqN8y0Y8bpkzWVv7CiY4yHe/VesjU4R2HFjEgJvpwjlAHPUfzV6MNHtMCZhU2F0n4GXzhCgDYb1rNaEdf5EwkSDPU4VpKsE3kfxVEY6CEQ1/RWvmOzw+spvwC03pXC4AVCiHz6av9JZm6x9HVFqE9xFzflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljmelfy5; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljmelfy5"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so790372a12.3
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789839938; x=1790444738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w13p09vQ1xPtpT2gPYEZ5b/f1eI2PdcpNfAfK3i3t3E=;
        b=ljmelfy5DIL6wAulm4NTI1vay4nba/2FKRsfb2aSrJSNWMImRfPOafCI/jwf/kAL1x
         zFnpkqXT29y1dkf0KX+7iQql6Vqyyk4g2RnmeAQg9DqSd2KUxTSED6s1DtjtER5yMP3W
         uW9OR56g55OeAwnrx7l5DFlN1paiyUUFyRz2k7iL0B2DsxeKwkklOBkSet37sg3kto+t
         JpiqowRuZzZ+3bo6mK0o3+SA6Jd0jcrLwDNjplSacoGzdRqPS2Ijr0wnwEIYxM46tmoF
         ujD99MZakE4c7jxHNk098gonYPsS0bhnsdFnolmsbqblGvgUlEQbw692MjwEwV1y6thM
         zVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789839938; x=1790444738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w13p09vQ1xPtpT2gPYEZ5b/f1eI2PdcpNfAfK3i3t3E=;
        b=ZT8Kmxu/w4zYHZDNczcYBa/3yoRJROackJlbwqWHHTDf21Yv76Qjfwlj1eJzBJLYd7
         MWiv3hEayWtEgTDAcH6qdv46S56ybt1ZOkn+99X28NPSLyQv0iRMmNyfRf65VthHT+wp
         iJYCcy17R9VX5xQp4NmI9aZiezleMN3UZ5HpdOxJem0KYhrSXPBtB8N7oXhGAL7C8/1p
         BYlg71QEXCIy1i3PPTx+9cdvaFFbj6p2DYS356MjhMZxNsLRsMCaO10bgIhLInoQZNeE
         LPzbVYzZZvnj/YtvKnvgEJ3WTkQO5FRDYEGN7AXfHySSL6ngguwXMcw6Jxz0UFaPLlWe
         tkoQ==
X-Gm-Message-State: AFuF++lxV2uqy/kIZdVsDD26k7nsAJ7WEl9GjeFPgwCWooAIeHI2OV0s
	neNjTXTNLWj/s274QBl8+KMMDuIHbbR8sPKuxP0pQE60SoI+9ZvzBAvCEGspHsWvB4g=
X-Gm-Gg: AYBFou2OfcyAdbnEcPftVe7/NSwLoXnXCrIrrD+zYUUdrOGc8WRWCJFRn9ilQYhFf77
	oRrteW6lgednRjc/F1wpM2/1gH7H4lHaVc1MBaJDF/kLVW7bcbeb/RspKeTI6K5Qohfgg84A/D/
	bXwooY+5Y4y/Z/McXKTC/WjMBdEdUnuwSUXmjl+JLzw+5t5w+pPEY/kfxNxvnP7GxOBNgno9nvw
	pC7SfMlKnSw/ZmKNBBNpZPZ0IrtF5SeWgE5uyEDgQZEooX6Fx+WvkVM8dbURszoTHgZK3LbSgEH
	oBtEvlBhpvkXk0inekqsNE6idZHgReLCyu1GaM+DwvXBPy5bTYp7kVMbB/mcizGnlAidgqD5bxD
	mb/xBaF6TjmCmglApAm50b+MjKGmu3swRemYgSxnoq2MXoRWwGDetkDArULZngjoIEvBf7fLyun
	Gy+WIiA62GqOZRBih9C24LcuQtdEn6BwQc1AFUrFLw46b9ApNpBoRk3Sr7WeZJzrajURNaLgpBD
	tM7BvT5YN1V6KftcIKqGSKAk9j+HX5Z3kgQVU/lhuJ1fYAE
X-Received: by 2002:a05:6a21:7481:b0:3cc:3d08:da2b with SMTP id adf61e73a8af0-3dd8c2f6ab9mr9917888637.15.1789839938360;
        Sat, 19 Sep 2026 10:45:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:51:102d:5562:18f8:11da:acda])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32f17d77sm7915983eec.3.2026.09.19.10.45.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 10:45:38 -0700 (PDT)
From: Abhinav Madake <abhinavmadake@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Abhinav Madake <abhinavmadake@gmail.com>
Subject: [PATCH bpf-next v2] libbpf: Check for unknown type ID in btf__align_of()
Date: Sat, 19 Sep 2026 23:15:32 +0530
Message-ID: <20260919174532.25407-1-abhinavmadake@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260919164229.95154-1-abhinavmadake@gmail.com>
References: <20260919164229.95154-1-abhinavmadake@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf__align_of() passes the result of btf__type_by_id() to btf_kind()
without a NULL check, so an unknown type ID crashes. Parsed BTF cannot
hit this since btf_sanity_check() rejects dangling references, but BTF
built with btf__add_*() can, as those only check the ID range.

Return 0 with errno set to EINVAL, like the unsupported-kind case.

Link: https://github.com/libbpf/libbpf/issues/983
Signed-off-by: Abhinav Madake <abhinavmadake@gmail.com>
---
v2: return 0 with errno instead of -EINVAL, callers test for 0.

 tools/lib/bpf/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 908bd3442..6bfbc7a65 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -986,8 +986,12 @@ done:
 int btf__align_of(const struct btf *btf, __u32 id)
 {
 	const struct btf_type *t = btf__type_by_id(btf, id);
-	__u16 kind = btf_kind(t);
+	__u16 kind;
 
+	if (!t)
+		return errno = EINVAL, 0;
+
+	kind = btf_kind(t);
 	switch (kind) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
-- 
2.47.0

