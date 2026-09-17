Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198714BD368
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643511; cv=none; b=u1WeH/jGNCVI2IeeBu4nepuQqQEws+PH+L35TG81i+A1jPDnRcfBA/XrpTt9vsqgjQbzdlLQLdsUPlvyJRINL7+eJB8BQpw0kRVSCg4V5G4aywT04OF8KfvS1sqHMP1Td1yXvJvkysR+l0asLs2dWRw22jR6J8LvMeY3FWzVHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643511; c=relaxed/simple;
	bh=u6A1booZqff9HZn1c6UG3ORSmFh2XZq7GxUxYIULqw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBzL93HoZY0LRrxAFdEXRB7ffovOPs2xSe6kHmSZ+TgLqa1JSa+hk+3LH4wmp3vaT+DL48yKtum/wQhSaxlAMuthD3M6nxdJRmSnZJLICmrqZGpzXzCrJGyd40M0Fk19fsYJT4t86bBM6AsLe9ACLhmysKNNu9I0nlpPzae2kzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITyPhL4q; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITyPhL4q"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so2907355e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643492; x=1790248292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HC2tCCvpccn+pRkVO68CBG2Pf/51+9f68zCb1h69W6w=;
        b=ITyPhL4qGntZgzGeHVd9VI90kFHFE6OrFQZQxnJxHb3Kc9Z/FUnSgxvH94rIZaDqqN
         pbnaKO4MYBggStKxKnUig03WvM0t6/UTLyKbgIlPUpSHQzIHG2/JAL5jNbDgnWNE6FSS
         cJqkoVwWPyYvyATIJElDqe4iR2lNoQi0kWmodEBtCgCcrh5KHULsCWxoRfREX3VnSjM0
         DHyGp9O2ysyxBuSfEq9mT6EjydcxqmlVHZsfebaGnbp8iVw6Sdzdo6Q8wJgdaFzrjRYc
         /BiUawvX2QPKtVhapFIG4vPcun/lMmTpGBaPNGciPI4ELF//JQQYTLfcHNEMPRIl/vhh
         aB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643492; x=1790248292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HC2tCCvpccn+pRkVO68CBG2Pf/51+9f68zCb1h69W6w=;
        b=VSJ+HrAhdBsGcjC3s3trHhEdCtxqBwT1949YpUmBFVIXKa8NAGzI2X5yX6Wcs+5xGC
         aABYy8KuwwiDCZllP/FGSpRbizsqAnwxOpRa0/M2VQTsudSMu/Bme2R+NMgUdmxIu3Xy
         Xlnui7RJwsctlva0mXHrXmDttfT74UtWbtdKeE+mxTL7f8/FvJjhD6iqWAbj1k/V9O+p
         eWSeMYeoQzjuQPKxZi9J4zvmTqi39N3+sYT8nAQuzmicSD95tiUNzvnqeeiUI3Wy693u
         o2xEMCnfDlRYLFQw+1o9rmQEe/A1Hib87FIal3qvWuHG94KyuSfWNZpB9aPgtk/wZL4C
         2IFw==
X-Gm-Message-State: AFuF++mY147iXyzFlruZ2sTK8iqIqOeWftDKDqMUC9cM2iApJVEZ1rIi
	ULx8LSmn5IfFds+EGCabLFKlCDzgJFPeQCg9iaBUGX6HQNycyyRJWUCdaslkaBMu
X-Gm-Gg: AYBFou3zro2aWc5rwjWjpRDaw1HoKmgN5CdWtlFST7ynSH9eoCxyxkAS/PsYdhn7CyA
	2y1wZuFTbOIaRA1lYcFyV5Ku7JfTV+bfcYgVBpyVDoXS9U7/z//T3TFRl0Zb3OvCbzd8cjrHv7P
	24MfuHJFs8s1M4gnLZclDGSQj473jBhQSUH6Oc4GSIs+f7pw58XFwVtOZY7ZQ2KTTwEFD7H11tZ
	amuQ59/eLG6nZ9osLgryDZq0i9m9ZuoJ4qMmWBl/ifRND7lcm0xQ7KuumbhWgKYoX5JetarEXDk
	QvZvfsIajcRQSp9lnnEFB27jjLxw+oGXmxwp1tGRNR5Y4mKTjfYa3GZD0HS94tqLfu/tDfj5NNk
	6lbnuDFroLZf7O/7O4rOBxwlbixWEYBvly07Jquc5ZjQyNezux+bjZOBomP8VKxlc+kOk0GYGrQ
	PMAbBjl6AyY4MqwW+dkTgYX75fP7Jh86RGaLffUJItrP3BNPYtLOlOr4SB/uOUk8o67z9WYfCw+
	oEQWwSUG6hXX507lbe2cyEZhfVaxJPoufEfEa6b90VGb5Dqr8fq2184p1QKNVnismGkvbv20Um5
	3ju0/v2pvHbFX7gzzk8iX623OldXi9HPkrBmDQ==
X-Received: by 2002:a05:600c:698c:b0:49e:79c5:ee93 with SMTP id 5b1f17b1804b1-49eb731eccbmr69649985e9.8.1789643491767;
        Thu, 17 Sep 2026 04:11:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd204c1asm65694795e9.4.2026.09.17.04.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v6 02/10] bpf: Preserve packet pointer class displacement in regsafe()
Date: Thu, 17 Sep 2026 13:11:14 +0200
Message-ID: <20260917111127.3780880-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=memxor@gmail.com; h=from:subject; bh=u6A1booZqff9HZn1c6UG3ORSmFh2XZq7GxUxYIULqw8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qUR3HfnJ9W8/9/d7nnXb92+hZdOr6pIrposVJRKvK ZvP/h7UUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlkzWZkeLTJN+REk3Ph7ts2 1XdCPugwX5v1aq9JXdSnNTpPVs7SjGVkOF2xXr81dH9xrBF3/AaB2h72IMt/+16+l7t1SUpu9lw dJgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regsafe() maps packet pointer IDs between states and checks that each
current register range is a subset of the corresponding explored
register range. It does not, however, preserve the displacement between
registers that share a packet pointer ID.

This is unsound because packet range is shared by ID. A bounds check on
one class member updates every member, and a later access can consume the
range through another member. Commit 022ac0750883 ("bpf: use reg->var_off
instead of reg->off for pointers") folded the fixed pointer offset into
r64 and removed the old off equality check, so two individually narrower
registers can prune even when their displacement has changed. The
explored path can then license an out-of-bounds packet access on the
pruned path.

Require matching range bases for packet pointers with an ID. Together
with the existing ID mapping, this preserves the displacement between
members of each packet-pointer class without adding per-ID state.
Packet pointers without an ID remain unaffected.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..6c88ad95b63b 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -635,6 +635,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* id relations must be preserved */
 		if (!check_ids(rold->id, rcur->id, idmap))
 			return false;
+		/* Preserve displacements between pointers sharing an ID. */
+		if (rold->id && rold->r64.base != rcur->r64.base)
+			return false;
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
-- 
2.53.0

