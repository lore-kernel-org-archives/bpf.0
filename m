Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907637AA8B
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865887; cv=none; b=LkBVjF6rMni1SZixBPVzMw17uH7ONWprZ+hbW8kLPisaApSSc6t4X8hZZgRENSQa8oK3rM4AZua6hADPtb9Kqxf5ZtDuXmzBUYMBCtlp6lyEFaVLtEL/17e696tagBaafDXDpWlRhpJnwY6Fa4MCP0nbxf52xIFeq3iepwjDKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865887; c=relaxed/simple;
	bh=78mFUcjNUhU+/beghqjp/7We/0Zd0ZYpScLfFzhKku8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1/ItFiLhJ/t0kM+ce3XnE056DRViJbD0EEdaGhoDM9NONgEj7fgzHUsGcI1lTBeOjptcqmP87Z+Xq7gJL92//Gh5+bJbPQHTYNxM0jCH8SUsGfOxbn2R1Cmkoe8Ydz0yVvojaN9MP0BlvbdcONJUYfvW34+z42G2cIURDGGqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLCorju/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLCorju/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829a9c03780so1136278b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 22:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865885; x=1773470685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvUn/zlTI4nC36Csjw0hz3VgIHs5jPtoGtL/EDdDIEQ=;
        b=gLCorju/JcfDx48KQbpliV0/ksiZq9JQsu6FVX+ysJgx2bp1u7eoxBSY2IJ0ZN8vvy
         YFMvaWbBW5tAXVVsf8tlZDt1v5umB0bUSGy9UPK8fzHbQ0DJrwk5AGzwvaV26MlNUfVX
         n7GXuoVQ1JiXEwdeJfm7f2U7tflnGiSX/GPmZtQvOa9MPG10iUFCQAyaFDxC5IC64zK4
         mW1fH5o/ao1Le1nZFsBPJsVczxmDrHz1jUZkCVDd0c9MGWfkfQVdvWk5WAc7sioau7cG
         RJseB/1SYfwvmL01/vVZMVgnFokk8X0I6mvIUl3AgfVmwA1NOnAAkzqOWJEEBRGojb0d
         i5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865885; x=1773470685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvUn/zlTI4nC36Csjw0hz3VgIHs5jPtoGtL/EDdDIEQ=;
        b=EOMZ2XSr2AqtFEyQMEgHhy2DIqURrsntnvYWM636BsOpubtgHhD3fVxsglkA+2zXpL
         Q6CitVu2POYqYE6ooMe/Zvjl9mEQgPm4cgZe/4bm3AgJKxUWWn5Yp+KGff4myRCMkXws
         Z8I78S+79rnqxwUbVEIjxzRNyQnGx9EOpAfoB0mCMDpiZsKolow9lkEl5kdxm+jpkA2b
         w494hnkUilz1YMEyjOoDBNFfaMEAioN7czE/LqwxmnZiduv6UM2tZKlU3dlNrdov6tsV
         Xi19E+1M7qSvj0LrqMZaVluWU8IxVknvSCXYRwkSGdbMCZ9RL9qtEFsC5trDFGJkfVOo
         6onw==
X-Gm-Message-State: AOJu0YxQgIWHusGgEp0ANzX+Q2mMtbc/iSSri7xwTtgP314RrX4Wui51
	KpBmfyKTRGYrKxI9cTYSU6z3WsJkQ5Q35n2XTbj/+5QrU1cFckX/Zg4lTP59OQ==
X-Gm-Gg: ATEYQzx+rkQdz4qFhRXJZDbrDiVIlqvRRkBfF6IR0I8M2Nfez6zsV/mH4OnKrOgLQBF
	loGfkhHhP6ZnFkeZpJ872Zg4jt82rzJy7gFQtGjzPPDHd2CU37cZ1hb69Cb+Ob6e9wZa3lTYA4a
	KZrv28FLVC79k6PTDiwGGVZNrubIjA+2rlCLufFynU7ZWptT9mRTUhaN3bEwhSoAV2Cl0uP2UAz
	pkXMG5l9QClK3a0HN/Mk5UIu1MLgYj2bsPY7Gr/F42um4rrxkbjWvuHJCs7Dfq34Y6kzNsaVnDH
	XCo6C0USn1jVijZdolxi/PaZFHXWLsBVC3SaHdWEf/3XSYSCuFEEOhNjbHiOQZa6zFgYkQh1xTQ
	w0aXmZoOdo6dczRINoxwZOk8Ak6zrnzhQUCZUubIEUzGJVFYV+4CobTWy/NHFv6SxnytBWReZZJ
	VCtV4QAjhYWXXX
X-Received: by 2002:a05:6a00:4006:b0:81f:3cac:38a1 with SMTP id d2e1a72fcca58-829a2d6e529mr4224203b3a.6.1772865885305;
        Fri, 06 Mar 2026 22:44:45 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4656f36sm3463022b3a.14.2026.03.06.22.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:45 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 04/11] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Fri,  6 Mar 2026 22:44:32 -0800
Message-ID: <20260307064439.3247440-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign reg->id when getting referenced kptr from read program context
to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
referenced skb in qdisc programs using a new field reg->parent_id in
a later patch.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d52780962adb..ea10dd611df2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7754,8 +7754,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -7765,8 +7763,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
+					regs[value_regno].id = info.ref_obj_id;
 					regs[value_regno].ref_obj_id = info.ref_obj_id;
 				}
+				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
+					regs[value_regno].id = ++env->id_gen;
 			}
 			regs[value_regno].type = info.reg_type;
 		}
-- 
2.47.3

