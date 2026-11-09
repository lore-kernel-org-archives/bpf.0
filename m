Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253661;
	b=v6wTRYrBaQYjVqRI9IKYFQDrD66zO/c9Hyw01WtFeGLf0mNOkgCqqlQIE0M845RbdLrG
	 /8OK8s7/DP2zcRxMZHqvuNDRME0WyhVXcUYNtoWoVmrQLOcQOvuRqCr87up0IgHAIYvZU
	 JZbpVJz5j5FwDhNoSNaON2sveEp9RrmocZGRHqDRwUocRaUqZ2e1P5hu2Z0wFZqruYx8w
	 RLLnbrl7n50dTyDkHNTg31VAmxZSemsdQyWo7cquXz38Cccc7C3zO2KPnykBGCUT5sed5
	 Ure47PXBOYPFco7ESvcZEEv3n+zLtmxkwRU9UrsTmWvGbz2dZXpPo0S6Z/Ccepu+wng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=0zxpl6DdVTMwJc2uXon23RrZSAOJzayhuFJpYVewKqI=;
	b=KpZ6izHf1xJsp3i5194tYfCi/X5lUGPnyq6BYo0zKS3Wgjm57MtW3p2HtqqW/eOryZ3c
	 iuldRtfV3SFDSH2wW1/Rd7pkVJORuk/oJaKfAFwfiF/7THa23NJKcbugGGxPteIu1YOsB
	 0lnG1Cn0BwlRtEN5R9bCEijUJUE+i+5tHyceC8/AVlkyHiiAMWUXb4uFRZpvtwsWD6XfQ
	 wa+qHt7hMSq4RbDXo/dz0XWm37qGVPir2Omcmyffy5n+rBVG8CREtaAx4jV/Z7YjAxKVW
	 1w4kUCK7OswPTB+07TpSSCRB2GMlQLQNNzdX6DUxVOzaFbg/iLMHS+LvqOq8SLCEQpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XIHX8Jiv;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF48606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF48606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XIHX8Jiv
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4901ac93584so671429f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253659; x=1794858459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zxpl6DdVTMwJc2uXon23RrZSAOJzayhuFJpYVewKqI=;
        b=XIHX8JivsFcKquuHCmYKZ7N8W3Vp4HjuMsTlEZZ0Er+8HL7WTochQ2Nxhw2rd5rU/Y
         TkRcQJcQYYz4Y3V+bk9/llkWvnzTBcNnF0zJ4uibO0L24/ouTrBNYP/kgaPPEAqIwXSR
         YVT+MMd7caAWLPOD0kKmojTQ/Df68vTFg+m3P03mwIFBj4SrTV+f3+AxRB/qjPDXRYdo
         hEqDTi3JdqyHBnuS69yHy+WecRMXR5zjtexjDO6vuZi34P4BdjHAqcU01WtHwhlc7Ux8
         o/w59OQBohdQws+uVfd+KjGK5ojID1PrMam7hNhgn9pgqGr/YLyWIDmPKq+6dJHWpYgd
         9iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253659; x=1794858459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zxpl6DdVTMwJc2uXon23RrZSAOJzayhuFJpYVewKqI=;
        b=UVglmx+VYWrjI4dnk6rwEn9qxJkEyUp5k3/wNPPXOi49DMI3WSILDkqpN1i1D1/D3K
         oyxt3T5Gor5lLTPiNJh9VHqZK3VA7bY2+2pbLBus6aE8nIIHBvic4uKrxtMe5JBIq33q
         AWp0x5St2tXKQm7pCZxeRLo+NJZMal9jrEdbeRuo2iHn6a3M3bdHw85/qWi2ft0J8qlk
         ZWb93OQQX3upGDWlw9r6uET2CKfpoYASFL2StnZXVid8Kheap8akwB7drV61TPB2bCOp
         8b2yA9gh1khPGMowlDgzX0M87B1Q9Tb/1xAa2kPft7IZvX4I1x3RQOBATnXYO1xz+qLP
         ybEQ==
X-Gm-Message-State: APuU4Z/JjOfViy0CGdzNEIrRX6xq+6HEB4uFlnPbC5yFp/MHk9a4pSVV
	u+zyPzhHrqISZL0612zMfTYjF/d6yDDDaCAky2KHPsxmyWMX5paeKpzYIduaj+mq
X-Gm-Gg: AYBFou0WpdLVRpa/kN4fQ+1pGaUbV0NJw4D2ms+y532ZEyayEwY/9napJSggPYoFBrC
	Lno0K6H+dfSUxXnCvihRheIKydY9JIZaUwHLQ/do9kfZcA0SLbacq/LLHQPaKyw5UonbosVEaP1
	E8QhiMdyaAzYhLGSPwK558SQI6TWu1H1MMclMnMg7hHVMVLNBPN2JLBdgCADVMHQkseS9KPXMph
	4kSsf9sjTaTHUsREn9H9/QgiSGskaNepsPXhvbKiuqjtnlREUQrnKC3k3NNdZG5RqcJOX8gEILI
	gOkCDqSZy8fvDoJ1u/PQRVVzAzTaQKk5DastE9UZdEXGziet5Hn+/qq/zil4MapMsN2g+Fcc1a8
	u7VDp/xEDUhLqBqNiv7KMgupgShL9r02H8Kbdz+cMvu+9NkAyjS6eKDBALUBiZH5gBVUdqqsLKt
	S7ZYRqhR3jR1dhj6nrOfHFuHABGjfydor+b1fz/sNSeIxSf9IGkhgaXpoiIb8NA6LqQImO9eUC5
	SLd6vD5NR+NWgERApTkGKzpyHsAu8FW/6/ZYqlndciapV6pqzYeZJF/wu+MPMjaeUhSpfA1NCh8
	7cwWBcoc0AFCg8uZDdxxPbZWxyy/4/l1V6me0HdYA0NOTktp7JvY/SH/TqRFK+3cAVroyhUIhZj
	7UQbPO11WjOgq4FEgtCo5ikbpj9SwCitNmHUz+5cpv6fsPfjxvn/dxWPsLrsYESaHefPm
X-Received: by 2002:a05:6000:186e:b0:491:49c2:3b3 with SMTP id ffacd0b85a97d-49830b97c51mr911170f8f.51.1794253659370;
        Mon, 09 Nov 2026 11:47:39 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835859246sm786922f8f.20.2026.11.09.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:47:38 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/6] libbpf: Reject overwrite callback use
Date: Mon,  9 Nov 2026 20:47:29 +0100
Message-ID: <626df9a9eafa8758824d5a5a8ae0285d9e90c258.1794253561.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794253561.git.memxor@gmail.com>
References: <cover.1794253561.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=memxor@gmail.com; h=from:subject:message-id; bh=QXVLsKOseyYH9dABleytyAxOPG4C4EW8Uw4waELt8iw=; b=kA0DAAoWRy03e2NUL4MByyZiAGryIvuhG6petmzLGzN03sK3JWifq/v201VELtmteOeMc+qHN Yh1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmryIvsACgkQRy03e2NUL4OFDwD+JQGY 3y6XhWwWCF6Bk1gAZULcd87trdAXiVoCrx3bRwAA/i+2jVDLe3Wejpj2dicF7iWPIf9IP99UTm8 tfAOjTd8K
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tamir Duberstein <tamird@kernel.org>

BPF_F_RB_OVERWRITE can advance overwrite_pos past consumer_pos.
Callback traversal does not read overwrite_pos, so after the producer
laps the consumer it can treat overwritten data as a record header.

An earlier proposal [0] copied the readable window before invoking
callbacks. Review concluded that callbacks are a poor fit because
copying penalizes zero-copy users and the API cannot report skipped
records.

Record the map flag and reject callback consumption with -EOPNOTSUPP.

Link: https://lore.kernel.org/bpf/CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com
Fixes: feeaf1346f80 ("bpf: Add overwrite mode for BPF ring buffer")
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.h  | 1 +
 tools/lib/bpf/ringbuf.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 1c45648fa578..49f1120f4021 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1541,6 +1541,7 @@ struct ring_buffer;
 struct ring;
 struct user_ring_buffer;
 
+/* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
 
 struct ring_buffer_opts {
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index b7fde7d0a0fd..78fcb3df243f 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -30,6 +30,7 @@ struct ring {
 	unsigned long *producer_pos;
 	unsigned long mask;
 	int map_fd;
+	bool overwrite;
 };
 
 struct ring_buffer {
@@ -118,6 +119,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	r->sample_cb = sample_cb;
 	r->ctx = ctx;
 	r->mask = info.max_entries - 1;
+	r->overwrite = info.map_flags & BPF_F_RB_OVERWRITE;
 
 	/* Map writable consumer page */
 	tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
@@ -233,6 +235,8 @@ static inline int roundup_len(__u32 len)
 
 static int ringbuf_validate(const struct ring *r)
 {
+	if (unlikely(r->overwrite))
+		return -EOPNOTSUPP;
 	if (unlikely(!r->sample_cb))
 		return -EINVAL;
 	return 0;
-- 
2.53.0

