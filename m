Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983798;
	b=c9CxPYzYVUQOIQzHnVLz6iH6O7xBAWcXjEwCWEhn4gskaojYt5pLbvHE20esoTBUk/cn
	 1KfV31WDL949mG/yyKJSyS9+n+eljXomxSq2TgV62RLWn1YzVe7MZ7IJVHihKWrWnkPjW
	 K0Di0yyqoTIDMyxj+MArFFcTh4rvQ1CFmixL8PBBGTIbF2iLCKI3V5byAOimf3RYqUGjM
	 1QuhciNqiDVdvC+rFuwCdHMzyDc6701wWI4sxowRLFCCy2lNLjFsK3PMWZn7aw0zzQLvn
	 PaY4ZLwk3oIO7O6KndGxJIO/ZO85jiAKz4koZ22OpxKvFalk/MshzilvVpt44MoFwMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+92ktm3QHdCHdyz+QrLzLVEzYuLZZIUcrgNW2L3cgz0=;
	b=VqpjUIBfqcdBcquNOY24pg4m5WiQEK026HdRuKQ694Q4/fG6yYwupFAasu6n8eeQVuGg
	 e2eO18T+GKIbmxvEaSqX8qg/2aBuQ3GQSAVXnvsgMLzchpFNEgyfG/SVgyA9vSkkT3L+B
	 lD0AIa8MKco4MnW4YfkT3EI3UfgoT60Oi/2M3xvAT/luAA9jSosBCg4473oGXCgcasWSM
	 23h6qIJzlqNqe45GLN4/goNIgq5xkFu1YtPIUbxoztaSMND9UFyoEpqBPtO+TOqTdSuLO
	 TJoW3bFd1P8nW7Y6scRSz+NMFUwwpfpk9ZxLZg7o9DK6e613/l3jzSCvvxwV97zxQOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jpMlDEMy;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49561606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49561606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jpMlDEMy
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1041097b3a.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983798; x=1793588598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+92ktm3QHdCHdyz+QrLzLVEzYuLZZIUcrgNW2L3cgz0=;
        b=jpMlDEMy/TaqJzq7lz4J93Bp5RPDO8IaMWqjwr82uDPpVIyzcpSeENJMXp6lE9ZMnG
         LFpGVQIi27LcM4T59J1Om5SRPidFQkvPYG6oz+J4tfdbE/9I379QCsOtgjzxutsQmI+6
         pHa/GFM/oFhK/x2kvZTskqOWxqnbVRweCoqlTePTmkWjHL5vpAWqF1v/vHfSeZHqi91O
         oqJw89txYA0q1ekNTxen60gejiFZIAYziu0XKRv9l3oUd4+4FzfHLMSYh6b3iNAmKpBl
         KCRUv6u3d+0/KqEIaEcBvXvTxh8xrz2hONHuO2KBfCwUIhNhk6ooph53yAkRh7Ajtgb9
         oDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983798; x=1793588598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+92ktm3QHdCHdyz+QrLzLVEzYuLZZIUcrgNW2L3cgz0=;
        b=vbOFDJo2yq8+fRiMPUidYyvtjGpakSBA1mnRiSnkUcrIf61SH2j/vj5ShIRzLWIBXP
         TZNN3ASDY32rZFXioOiwUg0UJYMLQNOaMKLuOsxQP5UcAkcPrbdroNiXgViPlYI6FEAY
         PHepkVRMSoxj6khw+M4jJJj/H4fmadATfZfpBOmx+8xDQDjqccVhgy4BgDDB88Ie8hTO
         SQXrWmnhQG9UYhl79m4/LHPM82hqg6Y2xgu2cDPhvbewObDOzXtIvVysRFtUQkGi75nD
         UBi0fcV70QuGDT6Tmd6wejGCO95NcRSZAVTuk9wlFP/Ul1liQ8eZ8xfydVMMqshRq+Al
         Gm0A==
X-Gm-Message-State: AFq9FYJd+O2wvp7LtfPsD7idtRReenxDGTy3tuJrYRLEdIWudnp1EuCn
	sgo5ULYF44HXJ9TMYzOY+pRlDyP+6WJPFm20nsY189SlbL00B6oA06PfiU1WBQ==
X-Gm-Gg: AYBFou2KN8ihgNELKcHoQDH4RRsRLYgjVqmAW5U/GRPIsVQo18b5wTPqN75AXjCKBmH
	pmes9gI0QymK+yqLd18SRdi4OJnzMDuEfY6XHqVepXpx8a/TT+mc3l7ygIdmg1lcQRCL1pFKoj0
	bLOZEGc0FIfat/eBuTTlzj0t/VYv6+NxviPkF5cz9E9ahd/Pzp5tL54u0BDO+H598XYdQoNhDSk
	16/+afo6fHv+HIqzTVIptkFLcJDKHrC9RKH1iOG3PIe/YxFKFZsXato56WSEN6R9ewdSJ6KttN/
	pE2Beo0EgBcPEBSn/HJS50ljxlYwU4mBJv6JZVI6mYVVzM8l0tstf40VvTI9y+kfgbX7w8kQN9S
	UIQOZofH31e9IGnimW0Wox2F0ro/NzJ7MkAoSqIWqhkOo4kIC66zw5nWonhpBQWrde0hVVE7gsH
	Blszt5+cbtWYs7PG/CFiA9jWTLS3odrcDpJ1jwkYuCg10kc98LHrbmIOmnTa0Q0I2accCvnPk5x
	cIwYvg2yN42LbiVxVflFeYq0xlxo1jQwmnQnr3vi4OKqQLcv0D4hNUd5FIY6YwAQsZ6KpCrzoyl
	c7CtbDK6JEkVYFosmels9xp9X7UUiIcCfNVGigcUp+Tgwe5FRkkcFzOzm3F6ues4WRUo8cSQJ+M
	PV9vzSCLMgcvNkm8s4/KUUw3A
X-Received: by 2002:a05:6300:6bc9:b0:3e0:df81:23e8 with SMTP id adf61e73a8af0-3e7bfa1ef2emr4248338637.24.1792983797493;
        Sun, 25 Oct 2026 20:03:17 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc46482sm1021566a12.11.2026.10.25.20.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:17 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 36/81] bpf: Helpers don't write through ARG_ANYTHING
Date: Mon, 26 Oct 2026 02:58:57 +0000
Message-ID: <20261026025943.404450-37-alexei.starovoitov@gmail.com>
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

A loop can keep its counter in a stack slot. Scalar evolution calculates
how many times such a loop runs only if no insn in the loop can write to
the slot through a pointer. For a call of a helper,
bpf_helper_stack_access_bytes() tells what the helper does through each
argument. For an argument type that it does not list, it assumes a read and
a write of any size. ARG_ANYTHING is such a type.

strobemeta_nounroll1 calls bpf_probe_read_user_str() in a loop. r3 is the
address to read from, and its type is ARG_ANYTHING. The liveness analysis
cannot tell if r3 points to the stack. Thus it assumes that the call can
write to all stack slots. One of them is the counter of the outer loop:

  loop header at 239, can't compute iterations count

ARG_ANYTHING is a number that the prog selects freely, and the verifier
does not check it. Thus no helper writes to kernel memory through it.
bpf_probe_write_user() writes to user space only.

Clear may_write for ARG_ANYTHING. Only scalar evolution uses may_write.
Keep may_read, because bpf_probe_read_kernel() can read the slot.

  loop header at 239, header_count is 13

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f2bae1c2305..4752a4619035 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15088,6 +15088,14 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
 		 * analyzed separately.
 		 */
 		return (struct arg_access_info) {};
+	case ARG_ANYTHING:
+		/*
+		 * A number that the program is free to choose. bpf_probe_read_kernel() and
+		 * the like may read what it points to. Nothing in the kernel is written
+		 * through it: bpf_probe_write_user() takes addresses of user space only.
+		 */
+		info.may_write = false;
+		return info;
 	default:
 		return info;
 	}
-- 
2.55.0

