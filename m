Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831C250BF2
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200664; cv=none; b=SPOSteaDNu3RrlcLXQp0p4wJ92Z6v64u+bn3Ie38WJFEdlCPphDiYuz8ahL6aaIjC531+PFziYSaNayPv6aeuvswYtLXljyKteJI/EcNu20Ij84CgwWP+UNMlAIsWbu+nMKjze7+hbC+aT/rRDHSjbwA0GNhlKR3HYKMkBP024c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200664; c=relaxed/simple;
	bh=4CNEN7wC8Pe/7XrtPhrG7zkTQrJox5iMYzUoLmJvEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXtZ6i+kEyG7CsKfl1k/epGvqZc3XdbVCWJpkgG2vfLS3+RKSxLpJDsRhF8vtOxaQvql0EoMur2GV6A0mV4wuXPORrQ/yqEnFz0zCob/ONAbJL6gVkSfLTDFyV81RINY3zFQwXxd6Q9qLzwzNzAcLrCTVXr/o6UvP+XwkcybKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQwdeTSQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQwdeTSQ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so402201a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200662; x=1792805462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNgrelxi6eEq7P7hlNUFtYxqdxmASU5JrfOLjioF/SE=;
        b=SQwdeTSQzRA22heA2SuxGQuMGMV+Jd66s4pBifNQbzYreWo70GJkixVzD7oc7Uycwu
         ogYmLgpu0D58vL24Q7Wi6wfZlYDfH2c0jMIRscG7do3NzAxsIixu6YHagt2x1I01G7QJ
         A5AcWlbyu2iEKXc4LnPyWhTDiLe8O8dNmNty3TttQVKFzQmrjQ33dBoSzVNxRL+qjfyD
         xmdD6KWjLotO8LCdche/8EZpckGhDohvezIazqINx42x/exTRoy9iQ8+iNe53Tn4t7/6
         k6qCF/GbW5YyHksAVr/LU3QTJi45beWcYN1fpJHYoKcTaXcbrtnLDDM4b0HMY7X6IwQr
         MxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200662; x=1792805462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNgrelxi6eEq7P7hlNUFtYxqdxmASU5JrfOLjioF/SE=;
        b=b2jVE8qc6LDguYlkV8j0cLJ4E6MxaxRb/U5jkfI2IHrjUEs564Xg5krhZyFnC3Enfj
         jsn8o55v2ZdiYMNlb01kBacmHfnQr3eXJJ5ZMwg5c4AVhlvWD+M8mzsMLYYaK/JFqbIW
         frJYVq5LVb1P0sUXfpmg1LQBzQL7Z2a8qocLxjDFc1jIHF6DKFWRiUDYgQA6tB+LzkF9
         brinj7531XWx5L8wb/zq8uzVqIDMd4ZX+c7FBCIe/ubP5BINb2yx4KyHiqB55OovdIQX
         PZF5ucLWpipZFpXB1jGBhheov1KpJuTLPeCyslhXAh9MX6HjClVn8JndS1JUVMiKzQ5U
         SyGA==
X-Gm-Message-State: AFq9FYIzeljZafocMtHylCyMT1FJKIun6rDKXPrdQ+70kuZLi57P5ZVO
	XvKO4N4Qm05a8Ir6BkxlgLoUFcwymcvqz0WVyhmBLJFB4R5ognUas2FGzJuiMO5O
X-Gm-Gg: AYBFou0si6tI2ixQFHsG/gQdg/h+cd65Kbsi5p1ftmFQQir3dydCjoEfPBpuXD+uo6h
	NjBe+R31cUYfQ0E4iVdaR8TYTp/h4SiQCluYyJ+JVuF3ST6dJQaim7K1Uk/S3DZcE1z/4JnHJgm
	rxpKjaKGUb18cutBwcfQGoODEegngmRYsLsktZKer8OTxaPQgPy6aO7+KAyfl/ItBroQEdxRmXF
	g0KSVshhRE4BFTmPN9QwF1/MKmpGO/gZDQNMg3Sfa1igrM1T/Z0h8oiXosGx4leh+EQt3/L8cj+
	LXY0PkMeoo556/fSS8Ww/kb7sdXD6mZ4JYCjVFRg/4AGnT63qKyfhK3QXCaRpSl7M5Ke+Wh/KOs
	caTHJkeuiDrB0q5wXJyo2Dr/W3Bf0OuUnp8+reyBHAQyfOw5ybVC7wtFoW8iWxnzTLVPuZZ3Qp9
	yZFF3pPG2K2LLKlcDZm1yyrabciIOZdRlvshSa8rgMZUKtafMzSPgTY+fAF39Kr+e1FKDA6fhqT
	+P5M7ayD+IXE+nixNx/4iJGzOD1Rbhh5HKnoJFYzqXmUvtT9DWdkQBtdj8NtkG5Jy9CbztCROLR
	NtylXhUz/GnOXBsOUe/LJS0bOaU218OjMhqM+GYmK3o=
X-Received: by 2002:a17:903:22c3:b0:2e9:9846:2da7 with SMTP id d9443c01a7336-2e9a68437f0mr16777425ad.5.1792200661870;
        Fri, 16 Oct 2026 18:31:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87993esm17107195ad.59.2026.10.16.18.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:31:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 26/38] bpf: Assume no bounds for a writable tp with tail calls
Date: Sat, 17 Oct 2026 01:24:39 +0000
Message-ID: <20261017012451.364800-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A writable raw tracepoint hands a buffer to the program.  The verifier
notes how far the program reaches into it, and bpf_probe_register() refuses
a program that reaches further than the tracepoint allows.  A program that
does not touch the buffer passes, and can tail-call one of its type that
reads and writes behind it.

Take a BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE program with a tail call to
reach as far as can be, as for the stack, the packet and the buffers of
iterators.  It cannot be attached any more.  Plain raw tracepoint programs,
for which the limit is zero, cannot get at the buffer, and a tail call
stays within one type: they are left alone.

Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 002c3935a8eb..fe59e3114d82 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2153,6 +2153,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
 			prog->aux->max_rdonly_access = U32_MAX;
 			prog->aux->max_rdwr_access = U32_MAX;
+			if (prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE)
+				prog->aux->max_tp_access = U32_MAX;
 
 			/* mark bpf_tail_call as different opcode to avoid
 			 * conditional branch in the interpreter for every normal
-- 
2.55.0

