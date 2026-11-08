Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794116388;
	b=FVaLxc+rFXyhxJkr15vFQY2wZ5tdXKRS3X9yFWQQjsYwfB7beZUeLHhU+/1V/Z41xKje
	 Gz3MSiFjt3oypJ+UPO1kS01kXYf98P/AWY5jEuCdR2aDtXDKbuhI7Stsbf6hmsJ5mLfjH
	 +rTDjUCsr+4IivuKtNcbR9qfVfjUP6HtrB1migDlrledZsmmykjZnXAo8VGePRLm/YvIB
	 lMlJoZ+tIp6MlsifZDIxx5nvyOZWoqpGSvTNVyZx+Z0GoUTvRhh0/bjpJW1XA1MFVULyD
	 Poa3uTdjnEWldEIg5WvO9iS75jQxpK3YRlj+tx54NI8zCGPZOIb9pjtU2clv50glFzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794116388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FKnVt4te0M62Z5AO9LqCSCjwr/RLD6gXzKx35s1e+eM=;
	b=U0kUhsAX9s1HwdnCzbiINamEM3LYFo8goZbEuh0Iq6ccZ/DR62/oolzory7fM5Dio5gh
	 VYPB/iMeA0pcdtpw4zaSi4RxVuZOi8Re0wp08d7ppszvFSsR+XTgSL5Wb55LNOyAgx4c9
	 wh62OREAcwQihFuEdrveraGR8FcHTF8D/DNL9liRvG6DrZo9PCBx0Rleb0Eu+uejkvjis
	 2HoycGAjhnkmn1LSW+DwxO7YWCNKBNUJfdHbDcdp/O2RVe72fS1x4AIBbSk1A81Sv7b1Z
	 Nx9qv26ZfXRHC7u9vNgmKy9yXh4lP8YPmJtAR+cSjuhtBfVSCT/6E/kAxhXdVVC3c/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nJTiO0K8;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380F606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 05:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B380F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nJTiO0K8
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e985106c0cso1481395ad.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 21:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794116387; x=1794721187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKnVt4te0M62Z5AO9LqCSCjwr/RLD6gXzKx35s1e+eM=;
        b=nJTiO0K8SBDObxXhMreN+pDgSQciOEt4HCVUIYUV+A6tzefTrQkuO7QK9FieE8Ero5
         0BUuPMUtoyx1QRK+t6yBvBk+PokviIYScF2uHqnroVVyYnG85ANtVbZWLCDqILgKY95S
         5k46o6fpF6HxtQFrzWkuE8mTqNMB79pp07OlfcVZYWGj1Gb1/Cxtde/ybJvjgDXYDWr1
         SqldhUwXC7Rc0CKRlSRapjJqv12HD6HZJuJfjAFg+lPZkZToDE3i2PNj2UjDhjEc24Ar
         Fi+E9MGk9y3Z10EBmnhDSn9qGH4lFwevcuirymQGKi5M1o4g4WKjqSuUIUwdR/W2QQpU
         /oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794116387; x=1794721187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKnVt4te0M62Z5AO9LqCSCjwr/RLD6gXzKx35s1e+eM=;
        b=zh+YTbcM/os1YR9JiLn1+HsAYjAVw0wbKoK0FuJGuIEAjs0ky7kzP/zRl8TiUnJtKG
         HWJi7vS5nWDVlGx07ojhw3tAFwqNTNiYFNaQP5LynlE4GscDrG2rsWwlXbEtGZ+y3Qes
         O+/dDmfyEvXiGSp3r/DxW/XYXF3RF+dOFn+VPOdPbcbqrp7MGGsTI2MG2vQFQ/7NBDdv
         FHwWMcb17++B1vGpEudg/tcKbVsLas/ZJuEuFSpIRDJlIJhA4/qmWaOQAub3O/kuuyZb
         UnzppIAE2q5wC1xybtdi728TVFEDq1hvvVHzzKtGnmAkDJ9pdlNZmj2DWxNR7RnGVkCA
         FHdg==
X-Gm-Message-State: APuU4Z8VbJVA/L6jghi8orzx/vQtg+rv6wf3SEIK+bDHJC2QdWlHpZX7
	H/GufjjtYMxGvAiww23RsjU3C/wT2Qq7mP/h3iFA24cxaj/5fKOeOu8QvCbVXA==
X-Gm-Gg: AYBFou2XmjL6uogKJFpahpxnu8Ak62EjNFVJxtvpn3Fzpki5ZpTjU6hK7JwqtGrgGIC
	vQOeCMZb/de4yVNxW+nrh2hSfu7zNET00ejPKCKq7aFZbMSaSdAwWP7glu1R/BDL2MxyQNKUrn1
	7iWc3HKYziQbdLeXRIfCPz4jsXS5ufBfSQxQcZ5cJLdwf7YIAWeSn70dL8wJU9TUCRctxJw1Cys
	E8xPGzE9NwvdjJg52gdaK9DSwzZR12Yvsjnq0krH1dew0VfEBoj7GYskNqtnzvXIWPoWoR+Kax6
	Uj1YThsyTIcsoe54lxGiERCZgUSrmS72mGQ8QUN/KWssG1XfgEwqNM2/85EFd6UXLNk6ldQ5DQP
	iA1B5A5egXvRkCowXZa7E+gxdTii6ZK5PgL6QAKT0oGqcoQS6ZoDQi8GQPj6lGdVp/XbP5hD+W3
	I4BcgzUIUV+Wnt6/z7AwL4OHpg9n7iqdaNAU/Vq80oqHHqGgbm/xwOzevs5UEuN4Q4p4ZsJSVFS
	nC1DyHxCz+mLAmqGxcN99R2VcUV9vLuXg4rhOM6rbl/G11P23qP2keO7zkWGdVk9q5DQZjhmJMl
	3Gn2Kw0BjS8vDU6nU7n9lG8K8z/8/zf/19Swbgw/FiXMBf3LNfBdBQcovafXBtE4rOA2EOFpSCK
	eix7zq5EKm6VFOGr8c4O6ViCSO/pb4Filz+BpXtuC+xUK75/nR6rJaxL8x4DujbLU+gkJivTRkA
	==
X-Received: by 2002:a17:90b:1b0d:b0:3ab:2d46:1dd2 with SMTP id 98e67ed59e1d1-3b12d1002c5mr552860a91.6.1794116386724;
        Sat, 07 Nov 2026 21:39:46 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101c28791sm3607738a91.3.2026.11.07.21.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 21:39:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Take the end of the verifier log out and append it later
Date: Sun,  8 Nov 2026 05:39:36 +0000
Message-ID: <20261108053937.4134138-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
References: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

When a prog is rejected the log ends with the basic block that fails and
the message. How the verifier got to that block can be told only then,
and a reader wants it in front of the block:

  the way to the block            printed last
  the block, the message          printed first

The block is not going to be verified again to print it again. The kernel
has no copy of the text either: the log is in the buffer of the user.

bpf_vlog_stash() reads back what was written since a position and moves
the log back to it. bpf_vlog_unstash() appends that text to what was
written in between.

A buffer that is too small holds a part of the text: a rolling one has
lost the start, a fixed one the end. There may be no buffer at all. What
is not there is counted. So log_true_size, -ENOSPC and the bytes in the
buffer are those of a log that was written in the final order, whatever
the size of the buffer.

The stash is never larger than the buffer, which may have 1G. When memory
is short the allocation has to fail and not to call the OOM killer:
__GFP_RETRY_MAYFAIL. The log is left as it is then.

The text is not looked at. If another thread has changed it the caller
gets these bytes back, cut at a zero byte.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  9 +++++++
 kernel/bpf/log.c             | 47 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 656ed55b96ec..15619edc8f03 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1417,6 +1417,15 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
 		  char __user *log_buf, u32 log_size);
 void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
+
+/* The end of the log, taken out of it by bpf_vlog_stash() */
+struct bpf_vlog_stash {
+	char *buf;
+	u64 len, lost_start, lost_end;
+};
+
+int bpf_vlog_stash(struct bpf_verifier_log *log, u64 pos, struct bpf_vlog_stash *stash);
+void bpf_vlog_unstash(struct bpf_verifier_log *log, struct bpf_vlog_stash *stash);
 int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual);
 
 __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 1253118dfd05..84659a757b43 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -177,6 +177,53 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 		log->ubuf = NULL;
 }
 
+/*
+ * Take what was written since @pos out of the log. bpf_vlog_unstash() appends it to what is
+ * written in between. The text is in the buffer of the user and nowhere else. What the buffer
+ * doesn't hold, the start of the text if it's rolling and the end if it's fixed, is counted.
+ */
+int bpf_vlog_stash(struct bpf_verifier_log *log, u64 pos, struct bpf_vlog_stash *stash)
+{
+	u64 from = max(pos, log->start_pos), to = log->end_pos, i;
+	u32 off, n;
+
+	if (!log->ubuf)
+		from = to;
+	else if (log->level & BPF_LOG_FIXED)
+		to = clamp(log->len_total - 1ULL, from, to);
+	stash->lost_start = from - pos;
+	stash->lost_end = log->end_pos - to;
+	stash->len = to - from;
+	/* as large as the buffer at worst: fail before the OOM killer is called */
+	stash->buf = kvzalloc(stash->len, GFP_KERNEL_ACCOUNT | __GFP_NOWARN | __GFP_RETRY_MAYFAIL);
+	if (!stash->buf)
+		return -ENOMEM;
+	/* two pieces if it wraps around */
+	for (i = from; i < to && log->ubuf; i += n) {
+		div_u64_rem(i, log->len_total, &off);
+		n = min(to - i, log->len_total - off);
+		if (copy_from_user(stash->buf + (i - from), log->ubuf + off, n))
+			log->ubuf = NULL;
+	}
+	bpf_vlog_reset(log, pos);
+	return 0;
+}
+
+void bpf_vlog_unstash(struct bpf_verifier_log *log, struct bpf_vlog_stash *stash)
+{
+	u64 i, n;
+
+	log->end_pos += stash->lost_start;
+	for (i = 0; i < stash->len; i += n) {
+		n = min(stash->len - i, sizeof(log->kbuf) - 1);
+		bpf_log(log, "%.*s", (int)n, stash->buf + i);
+		cond_resched();
+	}
+	log->end_pos += stash->lost_end;
+	bpf_vlog_update_len_max(log, 1);
+	kvfree(stash->buf);
+}
+
 static void bpf_vlog_reverse_kbuf(char *buf, int len)
 {
 	int i, j;
-- 
2.55.0

