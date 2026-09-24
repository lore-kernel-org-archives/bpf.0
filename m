Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471B47534D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267521; cv=none; b=lIjO55+Sa+FnIBbBEMbfHWyL2wlWsNiClSvNHOTd4UIIMkc1+I8KWm2IFzboZnD98n/IYFPCvPFWD07/qjwBgoz+RhXDgW3pljJxkl9SPJs/s1aOqdQ0EBas8ChjHYnEerq6UUOPHHNdgz8axRAToWGLxmOtKw1g7lokjZ7QtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267521; c=relaxed/simple;
	bh=GW7GMDBQ5Qken6g1nF56AQpuH8eRYs5NQwIqnMqlH60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/LWtuB2KMZVaQR7GvLrX/K0ZK6M4pmJBZW1LSlmgYDUxlBuzyKY+Oe43AFecMU8A/deyuHRFqEtKe9w2lAtES9Bqrk1H+cRElVSUiWwbP0Ogg6Cthb6rkaETa2RutALvBhayBpF5OKG/Awfx8xovFCglkegvJIzRsj6OSXKu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxuoHo4r; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxuoHo4r"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe4ca1052so99545e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267518; x=1790872318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ghZRCdQuXk2lzUzZs1aPjhJu769WxQwHh1zxmSDhl0=;
        b=cxuoHo4r2QJvVL+VZdWgWmPChOkzKIl0VdYfETQoOMKIOQDq93G5RPzLcpPeDvtug8
         4youY1Wv0KwlzIUseSzV0au34iJFVvs7Y7R0g0VWG3L0yVSkoJgoIhqu0pnAlIdn8dZW
         LEp5S95W8Bi5wXNUAvYFVcpOr0OTD7LSn5awTZGLiwJKtEpMbgia8jukPLOMAlAF9F58
         +xpowrioHI8gJ5G2CpKKdPqr8NgJRL63dgn+VGMAsU6Eb03hssZU+dQ2qSQM+/ut7O3p
         nwop+LD7WlNY5riHdlF8K+MmPxkiv1cUrJKKg+DmkgHZSd8v0UEY6JFyZAws0W5Jx4sT
         Qm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267518; x=1790872318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ghZRCdQuXk2lzUzZs1aPjhJu769WxQwHh1zxmSDhl0=;
        b=NtqQnUOLBxk7uVXlRd/7b6wz4ADbLNjvDtbmmoUeMwFw9HLE5BYmAi5ncFMZksCFZr
         zIgk/8nyxZxRidn/1Xt6VfLBiNp/n/4jTLf4GgK5f0+2YCypPejnENNG5JhBZ9lQKaB4
         lU/+0+HkOGJDfLmxdPRuK4iQAR6v+D2gG4ghn9VrbMuqUuSGwFIpIztxlWxpbt14458u
         uAMXBcK+mZf0Gdacq6zTJd5Y4cPlofG7NPRKvVN/+huLZrmsjwbmcmkn4JILA355ZJep
         CGAPYiNXtjYPxBaA7uW5RU3V3cEXH0W17daiA6grLx5GRUUgrEwueqi5cYtSr8dc+TdB
         UY+Q==
X-Gm-Message-State: AFuF++n1R3HmAIzcwNzdmVHpdknc4UfK5geKmSdHYpBkRCFxWD0U5JX4
	TAZJk0bxct/gXvjj34DRjtL1dhl7S7v7rvaL56+zlxwzFV7FWeuq2UYemsZx04Rj
X-Gm-Gg: AYBFou2qb4nTLkdy50znqKQWfSzoj21yOpdzGyYvwnsSpfxPexIhtFfjWgMwCjbIOLa
	cTf3diUFgpmKwxmKsPD5Fjcbz9Ynu9zJNexbkKwDW8+w101VkSJrx5/55RFQEGqwpNYyhPAh1vW
	uXFwiFiV7Hwb533pk1XYUFxENBTl6PIYSMybehqqsISf0m/JZOHKvbbeKpWJ6s/kqO4k9d5IyUw
	OT0iEKaYXHmjAMIhd7zUXQZ2sfy+Zl9rwY8LbceVfKECclRM5GQH8ejklHh+oqiODixZuXhsyAe
	AEw+R8t9j5Olxc/tlIaruD1UzGdlvR8Cc7FUyl25xcJKxQ4g0VzKwLX6ZSDkNVh/pc60U3qpqAZ
	Emjj3OqG6FWnz5qUBXpgkImLBUCvdjgGaRUJL03G4ipE8G2bnl0ambv3t5AolYJjnnjWDfQvKyF
	OWoJzayT9q7kTRDEaUf9kmuIc2OzGeVGyWhgQIqx8hEA0K62JvzO5/5WFOweI5lbwRmmx+7109R
	W6obC8DXNOc+uG2MDG6Odpau9GW+GbOSVIrEW9R4KnWf1CeRWpVKNH8qxg/HfHuYZC0AykOn/cB
	rXU7rd1X7mh3UgGiOrqa4hp1eHKDZ1mCHGB7JQ==
X-Received: by 2002:a05:600c:630c:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49fe66eb254mr52531045e9.17.1790267517484;
        Thu, 24 Sep 2026 09:31:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee915f3dsm150665e9.1.2026.09.24.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:31:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/18] bpf: Treat unknown-size stack reads as reaching the frame top
Date: Thu, 24 Sep 2026 18:31:20 +0200
Message-ID: <20260924163144.1945455-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=memxor@gmail.com; h=from:subject; bh=GW7GMDBQ5Qken6g1nF56AQpuH8eRYs5NQwIqnMqlH60=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur7yvjaxbaJxdbV8en1YQvFS7kV4hZsf8r98NP+Z8sl 6rM+Pmto5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABO5EcLIsFTkcA7ToVv1Bw6J 7WIv1lDPFP2gOttRd+GLDbIeu6XcJjD8r7uQ3K1143PK1aVvHq0Vei5V8r7g1w6l22V7LDUmhD6 bzgwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When the size of a helper or kfunc memory argument is not a constant on
the path, the stack liveness analysis is told the call reads
MAX_BPF_STACK bytes starting at the pointer's offset. Clipped at the
top of the frame this covers everything from the offset upwards, which
is the intent, but only as long as no frame is deeper than
MAX_BPF_STACK bytes.

Return the "unknown" marker instead, which the liveness analysis already
turns into a read of every slot between the offset and the frame top,
independent of how deep the frame is.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6e2db8e5de2a..8b7f2c283e5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14352,11 +14352,11 @@ s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn
 			}
 			/*
 			 * Size arg is const on each path but differs across merged
-			 * paths. MAX_BPF_STACK is a safe upper bound for reads.
+			 * paths. Reads may extend anywhere up to the frame top.
 			 */
 			if (full_write)
 				return 0;
-			return MAX_BPF_STACK;
+			return S64_MIN;
 		}
 		return S64_MIN;
 	case ARG_PTR_TO_DYNPTR:
@@ -14442,7 +14442,8 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 			size = (s64)aux->const_reg_vals[size_reg];
 			goto out;
 		}
-		return MAX_BPF_STACK;
+		/* Unknown size: the read may extend anywhere up to the frame top. */
+		return S64_MIN;
 	}
 
 	/* fixed-size pointed-to type: resolve via BTF */
-- 
2.53.0

