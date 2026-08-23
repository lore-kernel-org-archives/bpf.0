Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD5361651
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513528; cv=none; b=ZbEJfzP16gpGqOlvL99KLsTyKDnORvTHljBkUhgqNM3PdonFqWNV+RsB0Sr1gn9XWd9vD/HW0CKTzWy5FPnZljAm42yPNDCFLGl8fqcH7IMvmd6Shx8VtaOXU6G5PS6VcitHhZmwA+Ut0Oamlubb4O7meF6z1EPggPZf97oviDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513528; c=relaxed/simple;
	bh=0KCANcUaU5iAxqaTywqahr59y0EC3KLBF9VSnRiLjKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVkYrgH/9syb+2Xl4sKhjUqEDB1nnIpAsB9F8R1fIxXpn7VUiQOO8I1VzPB8jDaJw6ubyYNEaRr9UhkHB2+2rg4hF0devxc4i3iuMTA3HjSdnFU8c9ovinId+6fEcjbx5IJ4qCPiu3BE3tppGNSWZCNTEAtkdwOzWgv1txg3YO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4ujOBRr; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4ujOBRr"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15f8dd6f18so223895266b.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787513525; x=1788118325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bglxbS1Ov+rMgOsqRk1FTClWvuMDMvH9vsOFXb3GkIU=;
        b=d4ujOBRriXVcArz35sbloWlDrXLxaxgo2e3DlwxcLv2+kSLndNx2iAfpVlErSC7cg3
         ZXFOM9+f5Cu+bx3AIvGWB/aGjsFpp/HTjaalcZPSysFEs4rrZJmJRLzrwuVBsYBeOkSY
         o/X2g0yPp27hEnlYRhIgrb7L9nZcsjsVm9Btnk0vOUwPlJIfgyspGjCUPzUUKzlYCm39
         bv/b9vwn7I7SEohnIzfXzI31B+ULVOniT8YNd02uFbRAns2fEG1sSbREtDCPQsOXcQUS
         NhaRcK3VmuvpaMQbwwuWkzLBtJJnbq1Wc2ss7rjn3mSTVvsyj1E+7MeCLu6b8ckZN1Sf
         TuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787513525; x=1788118325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bglxbS1Ov+rMgOsqRk1FTClWvuMDMvH9vsOFXb3GkIU=;
        b=EIy+Dr4yo2YwKXKNC8j+dwP8QSUDix3U3bzJX5S2QyhTDmbzaM7BMjawbVE7WzrnP3
         SZ05ZMu3dDqRq0a2rLLpFMxJHhkF4AyQLJg6LzU9NIL5slzv64FfY1Hgh3wdwypAdNQb
         V+i21+zg1ntyBU8H9RGdYpbrtN3q6RVEPsRWq+jereCc/n/s101Cvu+ealC4PvpKClYp
         LtPhcuTnjJBvbwoTByfAtrJXx5dQjHsHhWkJnXIRY3siKDDHB/6yu4zSJGN/zs+EZP1n
         uVbiUor3UE3PWNLVPOC7tDF/DXDAeOGXxx6qBor/pX75yobKTPC7kWI6Mjgw6WBD31vJ
         KIyg==
X-Gm-Message-State: AFuF++laEgJjITDsD8j5oHKjYZBat6580kRgfEuw6IY8ZiwAxuYPr3lO
	JwkJpGgDneadTo1Q6Bxo2TpMGdkWhhvKqu5ssArDGrjf948LsoB5EE1+766olNTU
X-Gm-Gg: AR+sD1019nY0PotoWb8p9Z98xvsWd73mdpFkmz2zHmeTfX4E8LzlXLWa09qOstBXqJV
	Ose0HNQDHCjpEoxW5VMdlTtnYJ5SvfT7GdnvYQWw3UhqgA0nOim9WEuQNnvRwKQ7yWmaNqHgVnv
	YA99QO179YYV2JL3yKZgFDRaQtKaou0H85XJll4ToUI/nG8aCiE57D6C9Z4dvSKSKKILxecLh47
	7UYJRfMY/neZjzPQlD0z/6ZgCLta5c1tw8vIeQ9tAytoJ4V2P8HuKuekSWEr5pAekS2qDwvmEGe
	9mhpqpNVw8AnUxULPZ3wYfXB8SjN5lYBBdXQ2YExAyLk4ti0hAS6IWGbOdpU5NpHtNvNrrtGRNM
	bGh4iwY8Qxlo7NaegK2YeV1/g1j727fUsOVGm9BVXkcP2+Tz4BUK6lgv5bkVB/EwUsYVQuZj22B
	56QSfeVw0uhThlSJFQ/BwlICbNOuDk34n0/AAbfoV6LALKr46Nkjn2P0bqx6YosE5WwCL4fNLmS
	vJ4XNB/XR/XlXg76dqD0JGLuRJoPDvY4ZdRAuC34uGA30i3KJjC14Js63kBAgnUZFW1b0RmAdHU
	l4sddIwg7u4XvmcfRBkWM4hWVOw=
X-Received: by 2002:a17:907:3e20:b0:c15:f005:63fb with SMTP id a640c23a62f3a-c2491c28536mr1739534266b.3.1787513525385;
        Sun, 23 Aug 2026 12:32:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm822160266b.27.2026.08.23.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:32:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Reject oversized stream read buffers
Date: Sun, 23 Aug 2026 21:32:00 +0200
Message-ID: <20260823193202.2389715-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823193202.2389715-1-memxor@gmail.com>
References: <20260823193202.2389715-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2102; i=memxor@gmail.com; h=from:subject; bh=0KCANcUaU5iAxqaTywqahr59y0EC3KLBF9VSnRiLjKQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavba37RtjkKsx9N8uzIXTL/1vmWQ4e39Vh/V5M2uP3yH 7vpFMd5HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiIxitGhktSv+PlZvvcsIrI Sn38xeUTt3rVumcaO3e6zXZ5d+PDDh6GP7z7+Z+9evnv33Gmt6Ybdx/kShRf8fCp7US7xVvcurg 7VvMDAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BPF_PROG_STREAM_READ_BY_FD exposes stream_buf_len as a u32, but the
internal stream reader accepts an int. Values above INT_MAX therefore
become negative before bpf_stream_read(), producing negative consumption
lengths. The generic usercopy size check prevents the oversized copy, but
emits a warning and reports EFAULT for an unchecked argument.

Change bpf_prog_stream_read() to accept u32 and reject values that the
signed reader cannot represent.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/stream.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ffa5626411ac..717436698ec3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4101,7 +4101,7 @@ void bpf_put_buffers(void);
 
 void bpf_prog_stream_init(struct bpf_prog *prog);
 void bpf_prog_stream_free(struct bpf_prog *prog);
-int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, int len);
+int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, u32 len);
 void bpf_stream_stage_init(struct bpf_stream_stage *ss);
 void bpf_stream_stage_free(struct bpf_stream_stage *ss);
 __printf(2, 3)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 7a5c3ac8676b..2b80a0599865 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -203,13 +203,15 @@ static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 	return ret ? ret : len - rem_len;
 }
 
-int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, int len)
+int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, u32 len)
 {
 	struct bpf_stream *stream;
 
 	stream = bpf_stream_get(stream_id, prog->aux);
 	if (!stream)
 		return -ENOENT;
+	if (len > INT_MAX)
+		return -EINVAL;
 	return bpf_stream_read(stream, buf, len);
 }
 
-- 
2.53.0

