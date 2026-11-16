Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808627;
	b=D6yR2pg/sK5nKGJj8eC0ri3vNEROnEGvbKrW/v2n8SbBBqrhkzDhEfzvkmrtKOHMIPGY
	 X4xz/jSRVhI1SbFZiQcRzCmW3dqN3vAF2HX8okBsZ4poCDpYmFtIi08TCUqpvGTcgCNuU
	 YbZqsoOf4IVXnfr8LIc8OhKBxRh6pSSO7U4d6im41qIU8RgOZRZ9FcAkKjArMh77U2E9w
	 7iId2GJnry5TbsElwJOfd1GsFfi9XmLuMD5l2ATCuz09selJX574EArAffQlIcbvKClnZ
	 CrHsioO9EUElO4T1G8CfBTu7IRkCr+pRgjZVxGn0hrryzWBDBQFvlZZswI1/BaBH5hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5cc9MrK3LHDg2VgyYBlB89Rlidb+17QqXfhNgqaLqRU=;
	b=biwjeyemgkAzbNRybvfFU9oCyp7Zp+S6PdXqYFyy2tRlYnML4lQBJ7/kmu5yYLPNxD25
	 2Ce435P5Z4bV7pDsNwE4EmKjHjSqt3aphL5nJoj8KuJftxMRdxYaXw8eCBNqKDdRq9trr
	 cAn1UvApi0BRxie4j8nqmXBa4s5LmXNmO8cQ7oXV/dl9muY7Lo+JB/UOPheXnSJeuy2X4
	 RheCs0IJiBomgk8KSaVYjEZUcsCgecDOr1GQS+pNCIzLxMfCOkaRjTEvBDr/ltMezYtS5
	 +aUo9l1gM2rIqF9eZn63o1WsCDR7cNL0t+cR3F+8oVC6bH7hufRIQKE32lPMGpR5myA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEJwNAdW;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA2606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDDA2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEJwNAdW
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so1147881b3a.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808626; x=1795413426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cc9MrK3LHDg2VgyYBlB89Rlidb+17QqXfhNgqaLqRU=;
        b=YEJwNAdWIKWpoZaKtklDWBfTzitNs6UeOc2OvC7qgXWZEfMjrQRHfTEWy9gOgDUoOA
         gPbz0eXiVXL/N2/FVw7GqizH1O1f9lpr04HB8xe9o+nDzfAuf4HMGgZ7Eldyd0b8KimZ
         dRutYfV7TJ2fozjiwWT23DGBFX0Mqelr8edzPL9y89kk4G/Myu4CwtsELrHKnWXjx2ZI
         DLi9ERM7BrkAdJBcOuiRLmIQvCiRMbiEe2XdU5jqg8r7BKwcMGEppjsR2dd/vo6n4fNV
         WQH5Fih+gj18XO2hZYMi93X3A4U52EVv5MyR4wNfTEmz1kQlQlzLdBH5zJKUypGFW4Z4
         k5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808626; x=1795413426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cc9MrK3LHDg2VgyYBlB89Rlidb+17QqXfhNgqaLqRU=;
        b=dGCWl6E2Bepk9IeSNBqcOlhtIF9KJ4vlEVBBPaAaJpVCn4j0UNgz0uFUBoTWrlDYL4
         NYbqtDLESO6EEa4nZBhFZkIMDf5GrKyV2YlCyFJl6CYoduqQ6d5zPhtJ85PpXwLtjZVq
         k/amDWfObXfeO/KvOCM4Y7//7PIBZEv5V1toP3E6vn/A0kbzUD3UrnpgeJUYSnhxiPvf
         tfsKEO8fq5J8inYq/mmpEqHPpj0D7jJhf0H27slO1siBqjQOb8fvbzQO1i2c3Zp4SbeK
         /C7mkWUFOXpaBV/ynCKvNoGn3sAeprM7GHvorwEqPIG9eg/tc7KsRvKUKTjdxQUI07QH
         mt0g==
X-Gm-Message-State: APuU4Z8939+BZ2iOE7j/GX04mb4HDSNgkVJ27xIfJk8N153wOJi9tBX5
	55I4Dq6wTsyydoTPXiCa3bV3s3V9EmFe7XumFLc9hOWNMnfRn+cyzGkUQakqxg==
X-Gm-Gg: AYBFou1hsmlWDkT57bQ5tHceK56n+WFq0rrmgLz/3dxN/19cJM1kycgUBrMkzjMemhH
	xj4IHZUQYlJY4Pz9Jx9RGg8lJecNFE3ZkFHzEZhEAL3L8zJRP1ZH3l9U97vNJX2XPrF/npEDEkH
	+jNWosccEqd4a+/bwmM7kk5qarw29/kZJNclByF8kMsXUdUefkN9zk5bJvla7amPNoibEk5DS9f
	9M22VHNrt3aByEjlLPs6W0ijjj/m3Fk2L4p499j0AFZmBrITG2G4fuws743oe7/TJTmfst70dbT
	hZNM9uVLpg1MU9kSDgKi6ft+Z9C3v9ZBaZ4lqjHtXuITLbClnJ+uRXjgCSOuc3N8sWKghUox0nv
	Ou6AnKHh2KhQDOC1q7hJ6/B4xzR4UDVeFEnUDXhu/m8CjtFcUs9tgxQUfEwoHTqIT/V5iqceKkA
	w+6Cil9MC/HXjp5JXwXjZY8HSOLMJINcbH2/sLZColjt8sN4pWuRqERNlyuiDoJsvRXaIvamIDh
	Ipkw/O55xrLM/ozS0TcjuopA3R4QOJy/8hVHG3Krvqxm2B8otsMeEEisV5l4Vvhvz3REmdxKbSE
	b9RcKg2Jp9hMPI/SRnlhAM85+Fnq4nunCc/N8MotZcT1oLWOZS5GT5xvHYl6oK0cm8C8VXvIyEd
	Dcbz6neABF/QddbVVCoC7CCyAlNSTJpHEIwfSKvt4jf2SXRCVBEsZGMztMbXJS1/zgj7gkt5nEA
	==
X-Received: by 2002:a05:6a21:1398:b0:3f9:ffde:7cb5 with SMTP id adf61e73a8af0-3f9ffde821amr4279167637.86.1794808625915;
        Sun, 15 Nov 2026 21:57:05 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2054bfbsm3389244b3a.38.2026.11.15.21.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:57:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 04/21] bpf: Do not inline bpf_loop() when its callback is dead code
Date: Mon, 16 Nov 2026 05:56:21 +0000
Message-ID: <20261116055638.4171529-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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

The main pass does not enter the callback of bpf_loop(0, cb). When cb
comes from a table of functions, nothing keeps it and it is removed. The
inlined loop still has 'call cb'. The call goes to the next function, or
the load fails with 'verifier bug: No program to jit'.

Leave the call of the helper. It does not look at cb.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 8d1dd0770711..d1eecb95545f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -3610,8 +3610,12 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 		struct bpf_loop_inline_state *inline_state =
 			&env->insn_aux_data[i].loop_inline_state;
 
-		/* the callback that takes a stack in arena is not for a call from the program */
+		/*
+		 * The callback that takes a stack in arena is not for a call from the program.
+		 * The callback of a loop without iterations is dead code, it goes away.
+		 */
 		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline &&
+		    env->insn_aux_data[subprogs[inline_state->callback_subprogno].start].seen &&
 		    !subprogs[inline_state->callback_subprogno].arena_stack_entry) {
 			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
 			err = inline_bpf_loop(env, i,
-- 
2.55.0

