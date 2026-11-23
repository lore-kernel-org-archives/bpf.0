Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463151;
	b=V9wA/AA9EVGFQaiJrlRBGTiI80GZTekyd7dyU1UHrcEePitMHGG0XzdOvc7BDp3kEOuD
	 dvYTwhW81seFZ+1wKXnCL5TgShvJEiRcY8FJ9bTBiUIpxP6e0tKCS1FNCAoBUvSxnZJ7Q
	 5QDvWhz1XtioKGgIf4cwhPmdUwBxDnl2MO2vmGL6Z6BIwyM7lExuyXGf4QvE0QHDfLoYW
	 Fhg5EQaHVfqxgVClqLwRZFrfxKSXczB073Z/xxyvAwK+u/ZFaOmlclltAVlJolZI5gYfq
	 M/tcsr3Skm7dY1Gmw6nvq6hMdVyjqc8fdu3lB1BTirWKvf5U9MrAYWbZBiXCgQNIklg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=QRk9jGCH9SqcVB+JDEpuaayjYm5ZQivk5REOIhhydmw=;
	b=Ha55jhbTzRnLmlG5/NbHxcrQwYskIncE4QMK7LAL4Oc4GcDpKz2sA5styU9i5RjE2fNG
	 rc1RNnME64xPI/iuaRdqtiOsUlAGTaq0E1kmcqkVVUXkOtwiczpb45MvJw8AtxQYRYRmN
	 JUzDRhg7qb2DHoW2U/AEf/RaXaaGeUn/yu9OmVMNus7YUC8u3+ax9grTGG+61spVbVFqX
	 mN3ls44zeCtkHaCxtH0WBX64Szx8RzQLiKGx8mwkH+ilLtKutYUr93JAGvhjn2qsW4KwK
	 p4MoRgseTG835z6gOga6E/x08jJ4zdzGRjDHfqMcSrV5ckuN69SwsmA7k3KeE+om57Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMM2+Vzu;
	arc=none smtp.remote-ip=74.125.225.64
Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F65606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F65606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMM2+Vzu
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4a3da0fc008so1072926f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 11:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463150; x=1796067950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QRk9jGCH9SqcVB+JDEpuaayjYm5ZQivk5REOIhhydmw=;
        b=mMM2+VzuDH2kdBskpxSqnvKqjSZ907SJoukp4gORoBh98Plly52uLYjTicWwgGvQLv
         6bdrF5KJJ9u+QZ3vA+iYuX0BrOjcF8w7U3TSmP+zqSUTFYvOABkdq3GQLZ6PoO2JxEsN
         v9h/m+6lA3L9YoJpjOy/5uVnFPeFWzPtPICRWd3HNw286lCGtZSsalorCX3XqYYOAxrd
         6OBejy64zO/tBWnLxQ1uK93y09B7fGeaT4CXFad2nEgAOy7SxrH+iRzHi5Hq+91OiQWm
         N0+onAXkMIW99PEBbR/KrRepJm35MoHjQ+qPJtWe2eB/NSMSEFD2eSsWWH4Rdz9CK4oH
         e2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463150; x=1796067950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRk9jGCH9SqcVB+JDEpuaayjYm5ZQivk5REOIhhydmw=;
        b=faDrFd1PTw8ECxZQyDxRymZwweaBV8ljKieeWiCjFhLI8eLtDMC/9QoDA3V+UBb2eG
         MdKPmLsKTj+6670mrSwIn0KsycWn64rK0Ri4oa15VyqZX8RO5zZCpW2+rD2vg+qjgi0o
         +9+Yc0371YR2ZX0uOEFxsYI4LM7D0Kd170tslq3V5+kDUMspBTP5jjKP6cfM+7AYQyIH
         ecGhNjxVOHED8gc+CibOl2meTllOwQyzhWtQmW9/Nacluv/LTCP8BVxbjd6dAwnoHC4W
         boGy6MENve+QeTSBk5UkBp7iS3Y7vtVr2tJNdFg7F6Ry2eTTfeFzrR9V2W5ppnFHk1Yh
         Ht/w==
X-Gm-Message-State: APuU4Z+W0y8N2zdFqx+EVE79tO5SHW5dS+ewNYZrQtXf09XJw1vtusa9
	LqFTp5Up/6R/JABnaCHb4cXMsjcloSmzMrlqzl00DvcFuHrpeQSFUOKVbQ1ZFc/BSyE=
X-Gm-Gg: AZFdTZcBmtfaNeapwkXz6gY5AwX1Z3/EvIbsuKwC4wmLIV2y/RpddSlrcb1PGfN8DuN
	jqb1ULLAO26gJuuvQziZ1lymHsCvUn56hPK7dgIBIfgzN2y0ScggZDbMoJQvOIERFC14evmA1CZ
	pUZo27EXrZB+nZqbgEJTQC4cKsYHGU0pdQ8JRHARyIKV/Fbd/YGyhsKftxO6rnKuQ5ZszwuagtC
	t+wH1ORnA6gqxEK5j7ahngUPM8kPIU76rvjnPviFKEYxk9TvQGLDAo6NGikhlZHW0MQPAVC9qn8
	ySBmsP0mBVohyabNd+FnHqHKYJd8A6ZxVu063fnJcv+qUmEpV/OkeJoIeTjgZ0pS/7ObNzin3S3
	bl5xEO3s+6rpkjx5hkqdXluVQJv0qoypVajxCCtgE/xV3tgJK5nfKWaqEBICsYft5nreIq0Xko2
	Hv6AociNoGbjwssDZcRflD5N0aHdMG0peVjvI3l+3nYCghgksN/z5bKThQvBTY8cuo9gAFBYzvy
	wOBa/NEJ1WvcPB06HCj1K8GrTxqDEgmTeVf5TzW0Rw5zciMsTNOnra3LhHsbULdyWLoUJmdjYt/
	Jbu5yg/Vh9J9UucpT64Mq1qaB4I6M2n2T9icwpiHHrGPbrFxNZJOj0DWOlRPfmA3T+n5X50bc/k
	RC/5RpRQV9w+zxq4OZwbu0lT50UV2XoLFPzqX57IvwzqB+qCIHlmhfrdnLoaCn5SG6Mvp
X-Received: by 2002:a05:6000:4819:b0:4a3:a0f:ecf0 with SMTP id ffacd0b85a97d-4abb9edc730mr20292687f8f.55.1795463149684;
        Mon, 23 Nov 2026 11:45:49 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b205443sm25112206f8f.39.2026.11.23.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:45:49 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] bpf: net_sched: Let bpf_kfree_skb() run with irqs off
Date: Mon, 23 Nov 2026 20:45:48 +0100
Message-ID: <3450cf11dfeb468e1c6eb2102e4b679088f9581b.1795462791.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=memxor@gmail.com; h=from:subject:message-id; bh=0/d2oRQxAIuAo/Y7HfgrrnUnUOdlGA84o0VGWbYH0MI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlWkexKLflmU1MTmWOLQ+EZ+1+MfHmxldKK3bl7ao4/ c+37sCZjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExkRSHD//Tfk0JX1TXxhbU/ y9nnmzxTNv/qxFW/ryRJhBz4J/MpUYSRYWVljOHk2289xa9EKW/hXXZn/dr5BwuXJ9nmqxWt0zb xZgUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_kfree_skb() is also the destructor of an skb kptr. A destructor runs
wherever an object or a map value with such a field is freed. That can be
with irqs off, for example:

 - bpf_list_add() drops the new node when @prev is not in the list, while
   the program holds the bpf_spin_lock of the list, which keeps irqs off.
   The drop frees a node that has no other reference, with its fields.

 - bpf_local_storage_map_free() frees the fields of each value under the
   lock of its bucket, which bpf_selem_unlink_nofail() takes with
   raw_res_spin_lock_irqsave(). A qdisc program can keep an skb in task
   storage.

Currently bpf_kfree_skb() calls kfree_skb(), which is not made for that.
The destructor of the skb may enable softirqs, or take a lock that sleeps
on PREEMPT_RT.

Use dev_kfree_skb_any(). With irqs on it is kfree_skb(). With irqs off the
skb goes to the completion queue of the cpu, and NET_TX_SOFTIRQ frees it.

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ memxor: Name two places where the destructor runs with irqs off,
  bpf_list_add() and bpf_local_storage_map_free(). ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/sched/bpf_qdisc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5691c13781a8..e041383a848f 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -196,10 +196,13 @@ __bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
 
 /* bpf_kfree_skb - Release an skb's reference and drop it immediately.
  * @skb: The skb whose reference to be released and dropped.
+ *
+ * Also the destructor of an skb kptr, which runs wherever an object or a map
+ * value with such a field is freed: under a bpf_spin_lock too, with irqs off.
  */
 __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 {
-	kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 }
 
 __bpf_kfunc void bpf_kfree_skb_dtor(void *skb)

base-commit: 84afebd853437e44cb71f718be11d90e4c1a59dd
-- 
2.53.0

