Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141439D6EF
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518541; cv=none; b=qMUUHowH7J8pTHvhi8lJR8XLKcLtJylkxanD5C6r5DrAiYdz6hqNyZrCBxqdYOx7vWohv1XEVNLNHnzCCzhTFIci91NWEA38hdIL5qe1b/HvS5WVHqfQMqoppJZldjuTmvSUPFeaCSvTtX1jiF2nIA4vPaVMamVOTqoNy+LEvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518541; c=relaxed/simple;
	bh=f+Ixpx9vt8plQS8nKl/CwNCzxmJBu5fWha9ThVbtA1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS1fjTPX5Ky3WDiNiL12RFjFsfdbTw6dhR4AzeJnLhdsl/u213yd3Km+thMPmVHt5YuK65IwsuZid2VRdOjThSGCoxrr+jEP3Ko8uS4KW4aKlJYI7j3TuL7ijAWRpaEx+2jZ/HS562B6NAYHkVcfrxhxhySMqeCkvaD7/Vg73/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1UJx5vC; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1UJx5vC"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so4651655e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518535; x=1789123335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hKuIp5vGxSfgn6Yu6jugz4qoBC9P45ZL3onT4fVoM4=;
        b=X1UJx5vCPMTyD6UNBPejor0wzhXH7456x6kg+KT1pdJbkudSU0XtDDsb0TFdOI4A+l
         Pu509UiMi5fVGyhAnD9zaYvK4ZdSD2pl/idaQbozLLf4Tl3ckvU2FUPAALApSzZolNrQ
         6avd5WLIguHqzQSZuwZIqh7U5nKy33vjMm79zMDHt0uQFGUzraF0v6sZn2rebGlPC/AC
         O/krAh63LP5keIAn1awEBdSUQCglosT+Qd7Jyh4Dz47TQgiolZKC3bjrJqUbzWfBrQ8k
         tAiLxhWU3L9aZEHnD9KCNuDmmc4vPVLT5JvnjWBxU7amVCmHE5h+c/bWAm0Mm0LimYaC
         2PHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518535; x=1789123335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+hKuIp5vGxSfgn6Yu6jugz4qoBC9P45ZL3onT4fVoM4=;
        b=TQz1Ni8VLN+XK5J+FzsSq8iOPvSDF/fUkIFJGBOfSZbLQig78pcoLkpaoh0blAl1Fo
         zdXm1z0Qh4PvLsJzqoeNa6TFDCRZLn4P3btEN/mZiT1UpylFAl8+cQl0eUjWHSPKl6L1
         Shsnw0eDNYzS3VbP91owitRK238IfI/wJnHLQqO551BWn59P0UZeNsDne+YReMdSmX6M
         F7nMe0piFjhNqDCb+7L92pNNUvKHBeZ5hImgjYfwAVgO8tH/0WFNCeICq+KJwfR5znZG
         EU+1gcLhInAglj0UJyjqsEH7ljUK+L1UHtFY8atuly3oSWK9JXZnSZ2asxVWLolFPHax
         +4zw==
X-Gm-Message-State: AFuF++lpYHvPSi4Z3dBwUKcfur/c+yhtzi6uYfTxW+5oJUCvMySpZls5
	sWDZIb3lHII66vfJQ2VyczVol/O/3kjtGPTnUVzRGrGmU2GS9OjMfrxU0DwjLjp0
X-Gm-Gg: AYBFou0M64NfNvZB/zYagiC8NNVaZk8J6iJBZIin5neSF6/TfW5GUX7ljeKG4Vjib/k
	SCpQiklcgNykjtSds47gd/ZOwbNQQU7fP9tHMJ1S53ZWaXtwvVugpVgQD/+IzzO1EgK4Et//URi
	ZwQU1cRK76/xZzWbb9ma2vag2gxtA8CO11pe+utmavLDs+F59JL8PTl0bggtsn0/kGjwW2H9Hvs
	AUc7JpqzwrKgenRmrUlZbHdohqt+zMCmXoFopq5enYNHBWWzDHECIfETP0eQPH+gb7UOSC3LmzB
	CIs8otjKUeASJXSFFOcDUSljBlxuLBY0Q3Ail1m1cdmr8oII/vxR1kIB0x3hxwFn2+fRkEo388W
	9mqRT7OjQOU5ZFUByWTC/xjt/AmM/XxEaXlxZvGwNTKIILr1ROysM9mXVVaSKYh6Jf7AIb4zCzM
	H9Z9b/2Qcgq6FKcBspQP2T7Kd2iC+K9/GwEKtQH1kpiLYkn/aAbccu+qcMx/Ly0VFYDapArxvOx
	tfJ4iNjQTgEzVZDOm3wE4iFiW79mauzN5pBw52LRhTkdqAdvFe17rGDwUY5GmqO4RWQ6Z3cq0q8
	9O0Q17w+8TjllZOqZ99nZXgW/OMS814cIGOR0g==
X-Received: by 2002:a05:600c:c173:b0:49c:fc6c:be18 with SMTP id 5b1f17b1804b1-49cfc6cc0b8mr23836645e9.30.1788518535523;
        Fri, 04 Sep 2026 03:42:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm131672625e9.0.2026.09.04.03.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Yuan Chen <chenyuan@kylinos.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/8] bpf: Preserve special fields in recycled rhtab elements
Date: Fri,  4 Sep 2026 12:41:52 +0200
Message-ID: <20260904104203.345917-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=memxor@gmail.com; h=from:subject; bh=CLt23zByuqgnJoJUsvSGvSYp+xpqp39ZtrQMQ4ZYR48=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/DNx9ZeXZEVfkM6uL7mrs3nbMgvVHyLpTVtlm3//z ZXZLfaio5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNJ/Mfw37P1hX6+6iEluyb1 j7MmHtd655EvyzX9lO2tybOaNz21Osfwz2T+9aIvK2QPXud5fKxVyfjV1p//S3sbMqPj/u+ZzBu pzgYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Yuan Chen <chenyuan@kylinos.cn>

rhtab_map_update_elem() initializes special fields after obtaining an
element from bpf_mem_cache_alloc(). The allocator can return a fresh,
zeroed unit, or recycle one from its RCU-pending lists before the
registered destructor has run.

A BPF program can retain a map-value pointer after deleting its element
and initialize and arm a timer through that pointer. If the deleted unit
is recycled, check_and_init_map_value() clears the only pointer to the
timer. Neither a later deletion nor rhtab_mem_dtor() can then cancel it,
and the callback can run with its key and value pointing into freed memory.

Do not reinitialize special fields on insertion. Fresh allocator units are
already zeroed. For recycled units, the special fields are ownership state
that must remain visible to the eventual destructor. copy_map_value()
already skips those fields, matching the non-preallocated hash-map path and
the lifecycle established by commit 275c30bcee66 ("bpf: Don't reinit map
value in prealloc_lru_pop").

Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
[ kkd: Split out the fix and rewrote the commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index e89fde188389..527cc5716ee8 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3070,7 +3070,6 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
-	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
-- 
2.53.0

