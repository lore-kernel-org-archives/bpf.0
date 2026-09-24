Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E31DE8AE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219475; cv=none; b=owqEie6fSZLNJK6Q1+r33/rZoj+4naIwU20de/IDnrVBT7r3qvNkytykBL68g8UP0218QPNtqy5fs5fq0izpWb5GJjTz5sosNfMyz871UeVLLrrlIVe8s0U+Go3N9Wsnk3DOdjmUmpFpEkJx2HieJk7rMU7U8KMt/A78kotabUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219475; c=relaxed/simple;
	bh=g/CZ8J+slL2plzqI7l1I5EcurgKvrCurxZPRPJ4i5b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdowlw0MKjRVrJ/jTd+egYaciqk7SYeC+CHNYNDF5uBftdGDvuyuiwgiRmMYW0a1mqQ7yEn5qzVwXFkBQEpakkhO4b+3+zG61ogAuVwElGuLenIw3bbB5cCV2GbDGW+ynV4CHsnV0tbSTGd+wpFoji4QbX570OFMtjRoNZxGS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIRwxKrj; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIRwxKrj"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so906461a12.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219473; x=1790824273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+qeOkqrcNbzWdVqWwOHYGaeVLiZO4wz0VWyKPOY7xZk=;
        b=DIRwxKrjlIp1kO4KhAQz6mQws/VsekLPdYcvHS0dWPzpYwzrzOLdEv+b+rUtz5VG+z
         2X3lHyKLOZajYIc7rNPVydB0dCliAaBKvQEJOkZLZAuqwXwj7bX4FoGhFtscR9Sq07xs
         hfu8i4s+uh56HRcbzPLb7Wj5un1SRa7WkaAz+575ZoT7izOwMEId+lCAMAvhYkzyKDKJ
         ReXBRzzlSMy8ZuKb1FZpO9iIMidVVY/xa4IB7szjD7+fySbaBEF9a+u25upRGrgEdE0o
         zrELhqGZbn2b3Ydf+yhuZPnzjMGQDqBCRj4ADNj5l1iC5FhjygW2LyjgRq0e68nxtQow
         OoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219473; x=1790824273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+qeOkqrcNbzWdVqWwOHYGaeVLiZO4wz0VWyKPOY7xZk=;
        b=FM0uxpnqkgTrW6v7MxLHPFmfxBjq46Y0CyU1f+GDFQHZ0X1FsW4dbqrXfpZgMxCfKO
         XhgKjhAwtwrJQCXGiPCjAXK3YNBakOusp/im2WcSqY9JXvAY/nmUW/l6QvEMnPlayZO8
         sRJOW83X9BisIwbE8A7VW7PEoI3z8hsG3TAwC8Jwx7ztvsnEZQW/pPFVnJpH34R+FScn
         MaOx2WNeKS+e4nAEbjDObsqr2VJxeFoy/vsLWpgGhk1roiSK6m8KqRmMtxZhNrXw8Rm1
         OiUad3xzdMlIULnov6nKtRZe0Vu/jDKV86/u0faUVG9eGXVtnWQ38ESqjqF2KApNlslD
         n7fg==
X-Gm-Message-State: AFuF++kcvnYynccVbEz2/WO/nmbv/pAmb5tGHU2e8lETsrx6bVetwfwb
	rw9OU3dq7Q0qqxDPcEQO2LPwUPAypr3QxuImgSTESw2JLyq/lJUVlFlSJWpGOw==
X-Gm-Gg: AYBFou09TQaElQPftI67fcgxI0GsWHB6LEp/BDwRjI11vZEtBy/71ToRNd0Bq3pfbcX
	UVPlorklVU1aL5I6u/ncU7ITLaYSa6TQZSx+fdYdM3xJGdN3dDdglsNz9uA/NPCj0ua1EuuSI6W
	J13tf7oouDBZGQh8TowFLXnk9GefBHORmotfX4oWtPDjentGLsGGhwT5iUFDHAii8c/7louRjCo
	TcuhjgxqJOrq7Fd/HWOJIeIsqwgoPnacpkNZmj0Xh6hhXJZntdZJP4jsqptvqVO6sghR3N5TD26
	7ajTp/wBypwlrBl0Qy2yGzDW01g7ycS2eoh+hX0Aw8b1/07IYtTPL+zFyOcvSdSWfEzSCpxKXow
	g5UTikiovBNH1SPiqfGsFdmEbtMBXuBHC82qAa8PtUECbfUWe8vtlj7rzT78VxRn+eA2ydJxr47
	1hd5RlFjmwozhaS+nP58i5tHk3sIIvbTpVgXPS4cfDuu0oP7+6BeId3sKPHgdHa/XzRqVncORxQ
	6cCNJ2XLW2SgHlfCmLIJIJHelNWqfDM7PIZ/UtEI9mmsRwk/0hMTvqtSN+2nKlhBJiJPN5b+AGA
	mfBYPhZa4GS0ywRYn5WOGq5fH2eVSyjaa96HcUnnKro=
X-Received: by 2002:a17:90b:2b83:b0:39e:6c6a:208f with SMTP id 98e67ed59e1d1-3a09896d0aamr934155a91.48.1790219473151;
        Wed, 23 Sep 2026 20:11:13 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c7435sm2033035a91.11.2026.09.23.20.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:12 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 08/17] bpf, arm64: Add JIT support for callx
Date: Thu, 24 Sep 2026 03:10:33 +0000
Message-ID: <20260924031042.1690890-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Emit callx as BLR to the register with the address of the subprog and
move x0 into BPF_REG_0 like after a direct call.

That's what a direct call of a subprog out of BL range is JITed into
already. bpf functions start with BTI JC. The arguments are in x0-x7 and
on the stack. Tail call counter ptr and private stack ptr are in callee
saved x26 and x27.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 6c04fee46876..9544b2f483e5 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1789,6 +1789,17 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit(A64_MOV(1, r0, A64_R(0)), ctx);
 		break;
 	}
+	/* indirect call of a bpf subprog, dst holds its address */
+	case BPF_JMP | BPF_CALL | BPF_X:
+		/*
+		 * It's the same as a direct call of a subprog that is out of
+		 * range of BL: the subprog starts with BTI JC, the arguments
+		 * are in place, and the registers that hold the tail call
+		 * counter and the private stack are callee saved.
+		 */
+		emit(A64_BLR(dst), ctx);
+		emit(A64_MOV(1, bpf2a64[BPF_REG_0], A64_R(0)), ctx);
+		break;
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
 		if (emit_bpf_tail_call(ctx))
@@ -2485,6 +2496,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+bool bpf_jit_supports_callx(void)
+{
+	return true;
+}
+
 static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
 			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
-- 
2.55.0

