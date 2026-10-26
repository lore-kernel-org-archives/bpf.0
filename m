Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983821;
	b=sbbSVVxc6LWZfPfAaH9DPWMybjpap0cnpRuBkSAKh2nNadAp8vtKWG4rxMW86xTYFE/j
	 dO+YTbX9AhEx4eIoLKUIc8g1D/X+7cNCg5FWHdVLhycOFyr9RX3ZywOcsy0yDhxsdjFDb
	 31GDABxsQritWNoefI9icq3KAX2pXLZU31jQQSrUgQuVKukwtcOWVVWxGH6a4ZOSXrVuU
	 8CZvVT1auv0ZBYnOEVaSvbq9jyywBha6Hje2KI/qzVZdH5tgtVxft/hAjUgEndGcABkeG
	 ecDyXxjdEc9wRHEFsP/N9fTzbejpUdD7CDIjdtmni4zTyYIVAjZI91RREHyYnCwaClg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pirFUQ2uvQV6yfU8pjNlD4rrzkH+q666nK/vMnQaHC8=;
	b=PEYnqe3lj7QSxpdyCRkcHVcGXI7m7wtZOwyF+8nQLqU935Yi1sxUkuBWk3RFN57mxErS
	 887Ia0aYYQVT/PRK1+NqdoKFdiGvLOTFEJD1F3Snnln3wLSxnj8Gqyy5kLof2N2AqaOJU
	 ReMgxZKT4txfzgLjyXNuCL1zG8/ukp6UcqM3hXacEqqDGnj/TIhrFjSspEfw62RSuhrtF
	 B1QkMqH3sHmvZaG6z4N9lfD8dpKQhONZMtJZxTVKZ2TTyyVv/vTTR5u1KBh2YD8JK8SpB
	 uctFUVSKdwncwCh7+QFU3TILmACve7UeGuD8Sp9sVp/V9NLlsdWy+b/bpT6m42RmazA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C3q9PhhE;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2D606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F2D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C3q9PhhE
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab98332238so1299166a91.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983821; x=1793588621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pirFUQ2uvQV6yfU8pjNlD4rrzkH+q666nK/vMnQaHC8=;
        b=C3q9PhhEmXWG1PrIvCnsxWjxh6qqMQc6BOwQhSCrdGaEDz2+xhrO2mk0KAZuwi2XtL
         9jJXbl1zLz7Bz6/Qm05w6Voc4nash9+f2VYi+rwgtio2HOcNH/YbFKzApajXXUw2f2qn
         nAlcfX46Z2iCx1baUwLYiXii6YJyPRZ44h//HqwgbHXGMq3dNR2/dMMqGtpzp8TNC2CK
         akGGpFePgPE1b4NeFOaSVFcn9IGC4Yb6oIEpQc8fLEmzd1jwUt6tXyPdqkomrTL+miTe
         RjoKMP1mMAGsOmbtC79nHFl3iK6uVA76s/+S+rM/1cb2ObExUJzTNWf0iZBap6GAbi6G
         zDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983821; x=1793588621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pirFUQ2uvQV6yfU8pjNlD4rrzkH+q666nK/vMnQaHC8=;
        b=F179kfmKc+VotjT5nsLNP8K6AA3m02uR/sI08Gu6QX6uaLV3KgnikaIZydmG5UCT6c
         eOcLHm+oIiMEc/qJQeuwvqIpXhr7uaoxoB/Z5SifWwRKlAr3dnCx1HY7wWRQHnFdfG42
         3GTfz4jE0HnTe9Nwhaq5TdHQKWTs7U3GgE7duc8RmMFr5CTNh5xqVVeznlhfTIe0YS9n
         Q705t0p28uelz7Qm0W7meBBX78y08/TF+dIMe6e5OqCzRJUtIf0HtBIxGZ4qcfz5ZldZ
         aSTRlEKCOltVoKeI4ZH7aEoJzkjmXxhgR5CiKdBT9MefzKhNT5vKjihX6oeiXPMofecm
         V9zg==
X-Gm-Message-State: AFq9FYKlBFalaLtIykTlrrzOnKXlAd0UMdT3UC5XvgU3ec9I6gW6oCha
	Z2hQS3cF5d36M7XAiqMrpXhK/ypv4Op6ETlVn7DeNhUcPWog+pB2jceeku67Yg==
X-Gm-Gg: AYBFou3hlTfTzGAXFUI7T5H0UO4aB6vFQrbIBa66f54T8MAaWAUQlrLllznftS7zl7x
	JHp1PZhkuzMU3dSmVkqfZwodUW2yJR/Sc9w9Ip1EG2S49CSxfp8/bpefa1JyNuO/c4/wvPDvDV+
	ddaxbyxj7S/pq14abyzAlzfVJXA24ZCz6IE57cq85xcffNhnztoeKqYjTKuWnCtqnZdEvKdBmTq
	DC2chRcKKS/dBSrJFV6iwkAQg968ZP/Wr8hgkOY+UWGreIOMuKyDWJ9wAHeTxnQ7Vmas7gLMaQB
	TDrqVXKv/i39GLaiPaX8kx+XKVp+uoBLSODEYYqtSzO0Iqq7csJkiGjzuJErVMpk+RjhPGaLAO2
	Ti5FrVrZPjTOfoKp10RGiZj/GYRL2RTYIiKnUnmv8XkDSEJYPGYUsb8+vTJ1YzkvuLBvSTrAO4g
	8i3NkcpYZ8TfI+OF6ma46yomjqxUwWwR/EU+q9K5EsFaw5aLVEL/h8XgQWuCHb6HRLiQrFdwOl6
	l+QrnHLYtkTn2CJlXuyCO9LwbTZNIpdndaFBbhaneP8ImeYf8O4NDkx3VZREHDfSnL7vK+aXbVD
	4WaP2a/+NzGzQOvK8lJpIcF1/fouHgGNP4IC8i4ITqA1e8MV49Sux4GQbospOuubEubATZQTTGa
	Bkppa3XQCJXpB+cUWGEGIOwwM
X-Received: by 2002:a17:90b:17c9:b0:3ab:9f89:e1b3 with SMTP id 98e67ed59e1d1-3adeafc1f30mr4557987a91.40.1792983820673;
        Sun, 25 Oct 2026 20:03:40 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm6551469a91.6.2026.10.25.20.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 40/81] bpf: Keep the range of a packet pointer when a number >= 0 is added
Date: Mon, 26 Oct 2026 02:59:01 +0000
Message-ID: <20261026025943.404450-41-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

After a prog compares 'pkt + 54' with pkt_end, the verifier knows that
54 bytes are in the packet. It keeps this number in the pointer as the
range (r=54 in the log). The range stays when the prog adds a constant to
the pointer. But the verifier clears the range when the prog adds a scalar
that is not a constant, although the scalar has an upper bound:

  if (pkt + 54 > pkt_end || off > 38)
          return 0;
  *(u64 *)(pkt + off)     rejected: pkt has r=54, the sum has r=0

A prog with 'off = c ? 38 : 22' loads only because the verifier follows the
two paths separately, and each path adds a constant.
"bpf: Add join of verifier states" makes one state from the two, with
off=[22,38]. Then the verifier rejects this prog too.

Keep the range when the scalar cannot be negative. The verifier accepts a
load if umax + insn->off + size <= range, where umax is the largest offset
of the pointer. Thus it accepts range - umax bytes after the pointer. A
scalar in [0, N] adds N to umax, and it moves the pointer by N at most:

  pkt                 pkt + off         pkt + 38        pkt + 54
  |                   |                 |               |
                      the sum           its umax        its range
                      |<-- 16 bytes ->|                     accepted
                      |<------- 54 - off bytes -------->|   in the packet

The verifier accepts 54 - 38 bytes after the sum. 54 - off bytes are in the
packet, and off <= 38.

This is correct only if umax of the sum is exactly the sum of the two umax.
reg_bounds_sync() can make umax smaller because of var_off. Commit
b88822d2584f ("bpf: Fix packet range of pointers sharing an id") skips
reg_bounds_sync() for a packet pointer that has a range, thus also for the
sum.

The sum gets a new id, as before. Thus a comparison of the sum with pkt_end
does not change the range of pkt.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4752a4619035..8f5aa77e4ecc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16546,12 +16546,16 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			if (!known)
 				dst_reg->id = ++env->id_gen;
 			/*
-			 * Clear range for unknown addends since we can't know
-			 * where the pkt pointer ended up. Also clear AT_PKT_END /
-			 * BEYOND_PKT_END from prior comparison as any pointer
-			 * arithmetic invalidates them.
+			 * The range is what umax of the pointer may get to, see
+			 * check_packet_access(). umax of the addend was added to it
+			 * and the pointer moved by that much at most, so the range
+			 * holds. Clear it if the addend may be negative: umax says
+			 * nothing then, or if nothing is left of it. Also clear
+			 * AT_PKT_END / BEYOND_PKT_END from prior comparison as any
+			 * pointer arithmetic invalidates them.
 			 */
-			if (!known || dst_reg->range < 0)
+			if (dst_reg->range < 0 ||
+			    (!known && (smin_val < 0 || reg_umax(dst_reg) >= dst_reg->range)))
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
 		break;
-- 
2.55.0

