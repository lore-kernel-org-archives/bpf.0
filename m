Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DB4457D3
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519481; cv=none; b=WE/tPUfWiunmGNwPrd4GxSNtP8IcVg/DzaMu/Te8qaz67xGVfzm47t1f5hzxlR0BAjrfkWXwdbUlw1g+NjXac+2GAiEpeS8myDBlm8ynbVctpzOlDVl76GHo4LvqIYJ8+basxXIPyM4N4IA/MO3UMHcBjwYNkskYoeYIGXzfIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519481; c=relaxed/simple;
	bh=1+oyirIC/p4rEsI0bgGWNd1dWOerQsHgGhQ9QynJmYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2s+l8Z/B10ao+PcDreIwtL0lhfsMFyKZaXhx8SDhPUaaiAYJn0nUwJnWNN3f32GE0SNT9m3uaDmJFbSCL+C/BdogaGtnrl7nGIRXa4mTx74NoaJ24vUg25EhNHZuiFOCL/8Qr3GU/7+DlxA+R+zTYjFK7yIZpxUkDYFrGe0snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwgPz4fq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwgPz4fq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d91ff7d9acso7736515ad.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519479; x=1789124279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFdByt8yz5YNwoEGXt4FrpqsQt50qHUpKvAHd82Y4lc=;
        b=OwgPz4fqwFV5Zhm/Wvxmpgu6q66EuI8dUqCGfOOsc6Mw4wfYwq576l9fNGlOwVTaBr
         fJZOymp40rYBn6U37oelrOBmxw8mSArzjm/fCdIgSY+0fhG8l/FjFR/vd/j2o921liDK
         uLt0lFCejPKZxUmyLsFUb8vDhZjkgqLN82dM9pTvbCM3Vq6VBSEkNedORo13NqTVzhqS
         dmtczTWxVkIGFrWSHYYOKJ8n82YRRP0U7XWD6FcEn7Sn78oShxGk/DeZXWd2t55dBc/m
         WO6rtcJ/iQ+5oYA0AnnISQv5RNds3X1N+40FjIL9ChuyQwghndVVoTZsWoXQC+Nkyhc/
         DeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519479; x=1789124279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GFdByt8yz5YNwoEGXt4FrpqsQt50qHUpKvAHd82Y4lc=;
        b=BWMZbfb6j7iAPfmWys83hoteFPu1q3iCxlwO1r5lrMrlZ2YqaaL85e3BiVL5VeNyo7
         a5jJsA232OzjSgCflTvk/McSvejHyo8HzM+lM3X2ioKPYAs/rs2X+Yf6rcFV6uCYXZhR
         rO2d0zC4LnDO4dUzDPXCNo6siGrPRnnabeHDACnD8liXtqxRZLYuSJ6+bSTlex+d40QK
         78cq2r5j19mwcyDLhtqH5vMySZjUITSjtmSqyG8u5fK15k4CuYVGjpbejIvxkhv0tvXu
         dIHowjBQmzquzmKjVJvBVlLGmOGUiuVJqZQOx5BRipxa93vxD98V/CBXMTDXIqBrOcFp
         tQHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxD7hIw61D1Q3vepSfDl+QH7TLCGf6FRa7sFes30Ns4QfsX00/0nQ0Alr1XxjbsUU33C1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++n8zBsZGl/iTO6VIKJ6e1AENPCc2qS/kp3f0tsEhZUTGFUv1X9F
	oFEnl/0dPtGEtPkM/Njxo7x7Nevo5U6+taR6fh+cwq8QREwIS0wQ8XBD
X-Gm-Gg: AYBFou04lS6Efw+TIdRTMhwaLIAxJWAvQAXMEtahkPRYk/Cp5SeqSC0jGIdSuo0yFaj
	RVFVIB2jtvz9FH88CT90Zitro1Dq42S/JSLW2K+ontaKSf57C63G2wWjdq+KTO5W88elK9QFw2B
	QNmxJUM7cygx3889ZIpevxL2syoVRXB7AoI8lmpnPEwcKcANHQ2gBHoADnsIRlSbk+MLnKW6oUE
	2idPaj++iNlcZiEKeQGwdjKpWDRq6q5dM7DQBUAWjBJzhO1UJQIOEvSi+6/iM3SdgJtj4C0aCbb
	wr8miKK9DcYFVn9gg6QSLTd1J7Z9UqkAghHGu5LHIJI0SqeVBjSoxfLPfe1RVhpxsaxzw5RviQT
	gwigmpHurxE/nxeUNj9nbMuEzhSkJVjRV21CSD3DNpUt+T7sApHoVamGkfLKmJKFNvvmys6J1aL
	jVVWKIikAZx1QrBxAaaiEoj6kKoIji6U5QVuBuPPNzkGJFckmPJuJo3QY0z97M6TcSXWBM+TiTZ
	11pSiYS9K6YOOzo7mOuLd+7xIM=
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39b2624f0f4mr7984015a91.23.1788519479286;
        Fri, 04 Sep 2026 03:57:59 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:57:58 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/7] bpf: fix typos in comments
Date: Fri,  4 Sep 2026 16:27:32 +0530
Message-ID: <20260904105743.39799-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105743.39799-1-hemanth.selam@gmail.com>
References: <20260904105743.39799-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/linux/filter.h       | 4 ++--
 kernel/bpf/reuseport_array.c | 2 +-
 kernel/bpf/stream.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4a9bc6a848f2..0a067c2e923d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -147,7 +147,7 @@ struct ctl_table_header;
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	BPF_ALU32_IMM_OFF(OP, DST, IMM, 0)
 
-/* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
+/* Endianness conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
 
 #define BPF_ENDIAN(TYPE, DST, LEN)				\
 	((struct bpf_insn) {					\
@@ -1029,7 +1029,7 @@ static inline u8 *bpf_skb_cb(const struct sk_buff *skb)
 	 *
 	 * In some socket filter cases, the cb unfortunately needs to be
 	 * saved/restored so that protocol specific skb->cb[] data won't
-	 * be lost. In any case, due to unpriviledged eBPF programs
+	 * be lost. In any case, due to unprivileged eBPF programs
 	 * attached to sockets, we need to clear the bpf_skb_cb() area
 	 * to not leak previous contents to user space.
 	 */
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 49b8e5a0c6b4..4de08abfd94e 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -207,7 +207,7 @@ reuseport_array_update_check(const struct reuseport_array *array,
 		return -ENOTSUPP;
 
 	/*
-	 * sk must be hashed (i.e. listening in the TCP case or binded
+	 * sk must be hashed (i.e. listening in the TCP case or bound
 	 * in the UDP case) and
 	 * it must also be a SO_REUSEPORT sk (i.e. reuse cannot be NULL).
 	 *
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index be9ce98e9469..54f5be1289d2 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -24,7 +24,7 @@ static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
 	/*
 	 * Length denotes the amount of data to be written as part of stream element,
 	 * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
-	 * accomodate, therefore deny allocations that won't fit into them.
+	 * accommodate, therefore deny allocations that won't fit into them.
 	 */
 	if (len < 0 || len > max_len)
 		return NULL;
-- 
2.48.1

