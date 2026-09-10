Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966184CCDC4
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057123; cv=none; b=iCV0GTqOo+pW2+cAyquZGe9N7vUhFvuV3qm1890o6BIkTYSThCx4AQgID63QvbxF8qLlJIWqj8foenr+3Xc5rHZVxAaq0z3i+98c5BdKCuFU87CeIGjIOLVgxIY3anmfTdLVgfor0l9s87yWG/4o3OcFKzS1ddQjZhja6/IlKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057123; c=relaxed/simple;
	bh=aAZFucMOJ7/GL1ufGTFJzyWEmjStboys/FukU0gQmJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN70HhIagAACadAYHRL3KvDpFBMWA+/gpSNrKcenYR6SEuEk1y83Y+6wGmmOak/oE4PeKhE+flX4g66Dm56C6DbkzHHyHWjeTpiwULXhqa1rOQDMQP2mNrGe/Ms5Nht1v3nnvImv43DUX2hhiFZtreHeTqjA0Wmf+Ryj5T/ssk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=jWww2dxo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="jWww2dxo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so2421505a91.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789057121; x=1789661921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muqL+n5pc5dgTfrd8eYbfZcJF/aWvClhjFuvc+tBE1U=;
        b=jWww2dxoJwiTucs+/oo0uxsUgtCfOWWzBfknU6xhO9ypXko/4pQbmsWibBnoGSTmL7
         JZOC0zt9HCdFDcJGgO9nKDKgXrYZGWWllWXbVqSb81dmjM51T7HIvTDaRtA5bxpaZz4O
         TI/eItEBs++JZpFYMNPh49zZER8E1FI07K4JqkDOJ2KgfuSna1OtmnITUzWREPxqfdlS
         hlVYaIoSR4QYzZtOnJH2blWmXubzHWBgSFtiCGidJxa1e3IZDIOrWXg+r/5mmv2t2i/q
         6BS8+hxmdMGRNa9yf/zKArtglcjbY4mP9yZCJWWNkN//RVsXVJJR+04hoHFczU+pY11Z
         M3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057121; x=1789661921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muqL+n5pc5dgTfrd8eYbfZcJF/aWvClhjFuvc+tBE1U=;
        b=A2hmhPqVqSoTd7JAY1aWfmNGvw+7TCoVG4VOTwdfpqyouRByZwInIWAWa+z9Q0FdyQ
         FzGK0f8DJXO9eq8RrhOh/2giaOPUResZs/l7ifg6JOKN+RUWTsOXox9GqM/K2Aj3DSox
         biLb6/8JR297xHiilPjK9sg8PI8F/mqe62dHic2tAcTS5J6Rm2/MpFRa8lDC9P2zTPtv
         7H/okqvCavFR8BNGHQTGUHr2EnVsxxI14TxbZcv9QuTItw8WcKjysELxeI+K4bldB/oB
         45cX/qNiB+HwWxYajUBAE5Ml2GRBWwhYDs3RMzkxo/e2cB5crpHMLO1VM3q+3WLkmw5D
         Ywmw==
X-Forwarded-Encrypted: i=1; AKwUvBxvFyQ4O5F3F4Z7eP6jQpEC/rRRQXZH0ZcticAUzIb7YcoEimTASa4GYDRThg9HEcHt0yM=@vger.kernel.org
X-Gm-Message-State: AFuF++nc9KqDOjyhw2rgcyts6TKRCcINyBfUXul0uAryjeYMCkmUPUlr
	O31nGL2goLyvNz5itdE8pKsRolLfcuQFUnisrjY6sXZVagbkvtuba/KkpnTHRublv5ib
X-Gm-Gg: AYBFou2xvoRobHLTRbNnxOBEN4xgt/D5+UQ24D5BN3GRKadCKiYv8l25wwnIt/EzXa1
	B1RzEeQm9LUhiLXByUJheQ+++mST4VZQNCHEWE3dVOivEoyOI6roCWxT0CVCB9uWuF923F2jdN8
	gkpkSDHjRJCmqIwFbueYpylmBfSisgjunS9vPqqFCrjy9zhTUuHdyex+tGwcQhiUfZ9z99eEFod
	ec+0fhpKkWKq8y1/rqrZ+ZwDpsBlqfXQRphHj4E7hquwx7yIPnCuvKFtBQlsLl8KHy2Y3f/qpL6
	UP5B19vkSisXdfSn9tS+Ym7LRsnsw3o0mjj0BXLohTDd5B8m0VVV3NiTX0k0+ML63kKhvIBhl1F
	8iGMt9oaAjYEpB/ayPnYGXnrjglSum0FjNDlVkHydxWDsKhEG6wj1DIFsJRbRbX+AOi39RQ3Rm6
	koyfdvnHts/TAPm9azQrFDDdSlQOAHgns5J5f4dq4wXr7Rmxr8dLWjd9Lm+l2/wBTFKhGnMd0sc
	7YnBT8=
X-Received: by 2002:a17:90a:d005:b0:398:a2ed:7b5c with SMTP id 98e67ed59e1d1-39bac4571c4mr22077077a91.24.1789057120727;
        Thu, 10 Sep 2026 09:18:40 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-339770f0489sm24262327eec.8.2026.09.10.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:18:40 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jonathan.lemon@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH bpf 1/1] xsk: use a 32-bit compare in xsk_map_gen_lookup
Date: Fri, 11 Sep 2026 00:18:24 +0800
Message-ID: <7d2cb8e8dfaa9eb8fdff85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789056660.git.zhilinz@nebusec.ai>
References: <cover.1789056660.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xsk_map_gen_lookup() loads a u32 key and compares it with max_entries
using BPF_JMP_IMM. BPF immediates are sign-extended to 64 bits, so a
max_entries value of 0x80000000 or higher becomes a threshold larger
than every zero-extended 32-bit key. An out-of-range index then skips
the bounds check and the generated lookup reads past xsk_map[].

Compare with BPF_JMP32_IMM so the check stays in 32-bit unsigned range.

Fixes: e65650f291ee ("bpf: Implement map_gen_lookup() callback for XSKMAP")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/xdp/xskmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 3bff346308d0f..bf00d6463c191 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -124,7 +124,7 @@ static int xsk_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	struct bpf_insn *insn = insn_buf;
 
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
-	*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
+	*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 5);
 	*insn++ = BPF_ALU64_IMM(BPF_LSH, ret, ilog2(sizeof(struct xsk_sock *)));
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, mp, offsetof(struct xsk_map, xsk_map));
 	*insn++ = BPF_ALU64_REG(BPF_ADD, ret, mp);
-- 
2.43.0

