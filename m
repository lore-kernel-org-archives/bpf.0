Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB23DBD43
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843451; cv=none; b=j0jW/Qzq+f7q/2Je0x6xY0ig0TVCh8h0abstr/JHAZklgC64U/MQ49hO+dEMIVAJS9E00+VMisa2/Bs0m+yh+ivS92cdLykwlXLBgsyTlLcXghnbLJRXL969IRLsrUH8mP8P8077226nUBAAm5SPK1QInSRZoXhcxVrAuG/ouuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843451; c=relaxed/simple;
	bh=qPXI7YPTmUKpStE6fm8di0boystY87ZA0kTJF8QXJ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqQz6HQPrUuSRf0LnkZohVe1nuh7/l4ZwsWjtu8CZULSl8ZzoYmsyEvi/nTBRwzg4Ph9XunzxdUvZpJc3jeE4yl+Vb4OEvK3FtWqOeB/yW8jwwygTWkjrkyyKJTenJQ7g8DzFf33wDBVO7TB9buUk9ySJaG2ixr9D43wq4ECyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsSliIRe; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsSliIRe"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so7866580f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773843448; x=1774448248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGFXe0XrDXFVwHGvsgCIqTOlVVluXByUL6lncWYywBc=;
        b=UsSliIRe+gvXOBkzrlQuSgRHbQBcTo9sMm0wvXejzUxbXlTKIl48oEok81ZrQczBUH
         TI0xwNgb6ayHVz8/ahG4gK6gxoluDcJ+BXWb0/YlIejr+Qc6xcJD+s4xmh0217iLK2qx
         tYv5q9SckDZUdIs47IK3WpKpXi7eHHVNeSrn+3DSRqjHBbO8Wjqcy0w1ovGpFTRClgz3
         0ZpbUU12+BenipzUwlPadbQsaPGFgc692wQzN2fUhcFxq4Sr5KKrhDTJ5FZBMCxRWcxq
         4kXtMkzr2sHi5ybQVUXIXKwfkcsFPx3qEVO3c0vhsUtShj/+6iQ6FOSzIVHSjMnxyULG
         zGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843448; x=1774448248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGFXe0XrDXFVwHGvsgCIqTOlVVluXByUL6lncWYywBc=;
        b=Jc9pdgbFIo5wtRvczAHntaHxXkNhcWjd2bWAw035vidRbeA55CnJbuWvWejy678+oj
         13KnIa/I/BaH2P2SC1mCpddwwhnn+7DOz9pwQHX4M063u5kuzdNEk9sEBhyapq6QE42A
         jxXcdaLL5SI6eFADFCqDLNwwarVUFGimp6O9G/T5WPDPDjJmQ1Va0+Nht0JIvsyjfc4S
         RB3m6HblQbPNekovNoFbB5p3jpSZAJmDpK4NTBvuFxJCYp/4jKbI5bEZUDYEtcOxJeS3
         yDv9MX0SvhFWg9faxKQnCtcnt2yH6SaWGLnYxewIPX3Puo2lMYOur439rmZd3wWc4h4O
         wztg==
X-Gm-Message-State: AOJu0Yw+/uPpmkT+KusU0BQxcyMXt0I2UwaeSJGZl4p+VuXjXPdpRjWg
	JeLa5stvCxgMiM6Rl5yuATAX7nmDT/cS+GunFy3nhrbY1Mul22FrLBHYinZJ+GY=
X-Gm-Gg: ATEYQzxcjZTWR196acRhcF5aRHSYMnT/12Lax68U+BpKkoIWs+apE/kroZNVFaugCxu
	1YJUwsRhK98NisgRx2S30aI4W6dAQDmLbRqyPmmCqJ5h1FgITS2RaIOBwn9ewG0qNKPe8wmYp/i
	VCfkwXIrTih6rjBHbGmu5v2GVUxqdNYtsSxngFkTH3F3n+P4lvc8/Q+Lr1wqyzKDTKYXCNIrV6n
	SmhOOngd67WpxKZFppVHJeMT0p5J4RttXprv0apvR3KMSPBgeqNI8uEA0mihFD5NY0qQNMVVW5r
	YhCoE5O1KxYzN3lap/Y8JxO2HpeDC7QDe36rdxfDurDFnJ97uQqPi49HHinxvPl6TDRIQkjp1EK
	pQtCrD4qvWXBCFkYfi8YAI+f4xvhhFPQk2OrR4M5DRJGpqlCKnsD5r8ByhNamuGmXdbx3tiiiwe
	Huw/ywCWJWl4bzdw==
X-Received: by 2002:a05:6000:250e:b0:43b:3f2d:7d3c with SMTP id ffacd0b85a97d-43b527a4661mr6088368f8f.2.1773843447648;
        Wed, 18 Mar 2026 07:17:27 -0700 (PDT)
Received: from jacks ([197.38.173.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892290sm7734121f8f.20.2026.03.18.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:17:27 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	Ibrahim Zein <zeroxjacks@gmail.com>
Subject: [PATCH 1/2] bpf/btf: fix u32 subtraction overflow in btf_sec_info_cmp
Date: Wed, 18 Mar 2026 10:17:19 -0400
Message-ID: <20260318141720.1894502-1-zeroxjacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function btf_sec_info_cmp() uses direct subtraction
of u32 values cast to int, which can produce incorrect results due
to integer overflow when values exceed 0x7FFFFFFF.

Replace with explicit comparisons to guarantee correct behavior
across all u32 value ranges.

Reported-by: Ibrahim Zein <zeroxjacks@gmail.com>
Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
---
 kernel/bpf/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a..5b3e1af 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5548,7 +5548,11 @@ static int btf_sec_info_cmp(const void *a, const void *b)
 	const struct btf_sec_info *x = a;
 	const struct btf_sec_info *y = b;
 
-	return (int)(x->off - y->off) ? : (int)(x->len - y->len);
+	if (x->off != y->off)
+		return x->off < y->off ? -1 : 1;
+	if (x->len != y->len)
+		return x->len < y->len ? -1 : 1;
+	return 0;
 }
 
 static int btf_check_sec_info(struct btf_verifier_env *env,
-- 
2.51.0

