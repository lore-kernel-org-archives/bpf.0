Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CA3A1686
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845476; cv=none; b=kpDBsQ+B8mu07zdWOhzUrOrewSMeTdV2v437LW0F2n9DdGTQ2nyaWttYZxWn1g98SKXmePO2Z9EA2O3yB3JPa0Vq675ukeUzUsMTZayiJrXFXjVBb5eOTrHDBUbWWqgofkSX2PrQEvEzxeKqwdnJL96Zb1BWYpYPedsFvU2mhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845476; c=relaxed/simple;
	bh=unyplOxnmBY+FeDh4xvpkzWjWCnDg1vUEu6Y0rfVp/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtGQhoQuC+XxJ+IDTdrurQK+/saFwuaJPGTi4DDRXXZd7d8iG6bafvJXicSg4FZFiv6kxnyJushFesDNYX9TZdMWWUHYVaQNevRvSmGXVQYmUc5WVpTH02VGpJaLS+ebY7R0eO7SM1rLS6sCFJblmuc2RiXZVUlEi2ue89JLeyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtFv2Tu9; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtFv2Tu9"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so9781175e9.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845473; x=1787450273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BtVZzW8chWntt6wiZjpaBxWTnniOGDQ0XPhpp4gCCqM=;
        b=NtFv2Tu9feLquC4rFRYGQQEXBtOsy4HjYcuA2mUTm+H9m96Gg7p0mbAdX7K3k7u0Mz
         12busqSdDuhCO7MJB2QyJ3yFItwwSO0JpxJShNWRtt8y3RVh1alDn/19YqlDYY7OGLeP
         DUOWCHjGNK7eoG4T9F5ABJYZ60TtLwqpyER0nU9ImcdxewbMi/BHUPc2scz+CuJ19+/S
         zjCEVchQPBCWFOooxPvXdXcA1J8m+U6uZ3wDRlKMmVPJVtf0n1nmBO1CmvReohTOpXOL
         YACWi/QSlKwtQ7/fE7kGBBm74o9qQcWytpyfnP0kanT58DgwP7b3MA5K7R8Se44e8AVH
         yfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845473; x=1787450273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BtVZzW8chWntt6wiZjpaBxWTnniOGDQ0XPhpp4gCCqM=;
        b=hGo5No37kS0NnCbjqqWbtuoreHDL6XB4ILRrokIXHhUCGOnkwtUwNGCVFqU7iZwV8F
         qo8YBnupi6fzP46M1w2/VA1/vahAtYTtnl4Vu0/qYSjl3WHHCJmHCXzWzKdcqy601jD0
         5E4NV+q2unTz7XCkcsxfAN3PQF0+z5dDOQH+yhT+TgFBQenTZMkEud3hWELbCr2GFNgT
         V1uHA5F2Ofzjq98NdT4OirolmsHsBoHJ7AHdrwgxLVXUNTgdwzAkebKJHDipfVZmxMhO
         ihnBnm7zp+yOjZRQ811/nn5NHxCQKCT6MEcTutAbk0XGc1dW+vpoFSZfHs35SgyHzz1s
         qiEQ==
X-Gm-Message-State: AOJu0YzTedjwULlk21R4s5KCh+Lu0CiKj+lOuuLiZfrd5BvpqA6n0exb
	hU4yVPEIlrl/icqL308ag7x6gKAK6NWSYUVT43qLxwwnX4y16FPT8HHihpsqtTbJ
X-Gm-Gg: AR+sD10buTidLG7OBpFYELt0hdZwFYME/kDcWoBVzyNKc89GX1HA5aZrktoc74p+NzN
	WCbhs6JskYtxIofvjrYOpM/z9oXktqW5PpQV1Ekbc2RCncb7dzhumVTmyBWOhxPW4ukfU3LrooH
	zx16DK3qrJgUJh7qGsKplfbucF7Xdbp4OO3tJVWcuR0qLEhY/9ytnsWnisAfEw33d+DqdwfMyrN
	Csa6zT0zc8+odS0JKJiELJR+1HuGWE+FcOhLXbP9HEsaY6pAvaAUYlOxcu0d9dwwUYTdUc6QmHi
	lEGpfagLdWhYpkrxTxpVnfRu0Vv+J+pLNnNMCgFPoBT1DQy3XPM4oQHX0xba8xFJQOndZN7JK5u
	NnqkNhEMNZBVMB4ok3FnuE+tNbNLEIE9JEBimjTGzWCTE4Nc1LAtFet26zS7B8amKvoUVPV2whx
	JXCcygJLkvg3YPYnZkHj91tKexZxsJiQO90a06jqDNIPD7c4v7OfcaVxdaZNw1N1eRpRq69MIxC
	tBl7osIYbQqiqrpE+u5nyvs01RAozEo3YClMBALvMcL28eQ1IKaaMf4Dk6d9bfEvSpHfG4B96Cb
	qvTnbIwyRIdg/QhFvlXYacj5L0c=
X-Received: by 2002:a05:600c:5613:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49987937672mr160108355e9.5.1786845473289;
        Sat, 15 Aug 2026 18:57:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ed6dsm5269545e9.8.2026.08.15.18.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/14] bpf: Drop dead spill diagnostic condition
Date: Sun, 16 Aug 2026 03:57:32 +0200
Message-ID: <20260816015746.2632990-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=memxor@gmail.com; h=from:subject; bh=unyplOxnmBY+FeDh4xvpkzWjWCnDg1vUEu6Y0rfVp/A=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQvTPLr/r6p+0XiifN5gQ860rjKHs8dfky9sWKrEvU FQJene+o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5vZLhf+lsjl7zE6aVOz37 pv3pN8mrvu7IHP8uxWdZwvTfL2Vnb2FkaLEMMGqd97srd/bvj6XbpyqkvfY/O9EjNfLwrNPN313 qWAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

diag_record_mod() appears to allow identical spill events to be suppressed,
but diag_mod_keeps_lineage() only accepts register write events. The spill
producer also supplies a stack target and an explicit origin, so a spill can
never satisfy this conjunction.

Restrict the condition to writes to reflect the filter's actual contract and
avoid suggesting that it applies to spills.

Link: https://lore.kernel.org/bpf/48e6f021b89562f68850fe21ef8c78719819b04cf9c4e4f50bc791937d37ace8@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 33b7d9e8e2c3..37ed22a764e0 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1531,8 +1531,7 @@ static void diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 	} else if (diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin)) {
 		event.mod.origin_valid = true;
 	}
-	if (old_reg && new_reg &&
-	    (reason == BPF_DIAG_MOD_WRITE || reason == BPF_DIAG_MOD_SPILL) &&
+	if (old_reg && new_reg && reason == BPF_DIAG_MOD_WRITE &&
 	    !memcmp(&event.mod.old, &event.mod.new, sizeof(event.mod.old)) &&
 	    !event.mod.origin_valid &&
 	    diag_mod_keeps_lineage(env, &event))
-- 
2.53.0

