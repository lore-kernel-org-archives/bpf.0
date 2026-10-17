Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178A49A3B6
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278655; cv=none; b=MqO96clxYN+zaA5jT3lTzRsAzm7zrQoHusy2bXkNcE0erTDHZOAH1GXBCZnfhld+NgISY7RvFgBIVfG2My1zRhxU09nRFNHGlGqqI77bJ07YOzhkeKxOv3wTrLRMUwFmhz7ZD1yeNJDIi/3eZwDeXZoQaSrgbj7nqy4hdRPV7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278655; c=relaxed/simple;
	bh=n25qWipew+4ebjieIpn2a5MAXY2Y/8jyxPyWF4llA3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXC7trKbCtoOVTK5Dt3wN063sNToDsYGQgLJm7sOMwLDeIu5V7GOMm58ZQLi4MuRZhFYVYdkyYx7fOlKrbLjt5dztEadh7zuOVJPQwSI1bG04F+1zSWmi6+AEyspr0N5KHnuSkJ1/tkzDBZyX7+uH8EJnFyaBf/vUhmSaCWGB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzD6cyDR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzD6cyDR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so4533595ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278654; x=1792883454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IzV/0tEaaU21+ZcEQk198/kyK+GPae1czMKYtlXuTtE=;
        b=bzD6cyDRGXmKoV63Gth3h1lEtMsr4VHdDIKZ00E9VonSqbOLQJhUomiS+frhkHzXUc
         LREXB/5h6EBWTvAo+xdo5yqpMSYgjmOVkkOKBSQ2sN+vNMYCQbuhg8DwJQ9kK+VcMMtB
         RH/ydQ8LsZpGg1SFS8I/GdnQSy7x7z7x4HAb+ua9RxFKnKTtES7WroRQagxPBzTIJRdg
         fuxEfA5rooAxq0CX9FbYZF1t9MuUQ6z6aU3SUSdybLyhGNnAyhKKbQadooH5nIFp0MIm
         +++67Z2LTHYNKl1iJCU/eWcOAk5AYm2ADT4mk/4XS1d173Gwr1wQJxQLK/pLFkP9EH36
         GGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278654; x=1792883454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IzV/0tEaaU21+ZcEQk198/kyK+GPae1czMKYtlXuTtE=;
        b=2y11xol3G+fJISWk/j2ZWmbb4qgl4IYPtBz0gQX1YLaOEp+QBbQBsyt72q6qJGY5di
         701AxxvCcrFZ325TcTO1wtkw2JXvUdIGNKbz8SZWgruLNlDCHKy8AI/NCS6OzprKiEmz
         5bCxfd9Q8JXbJWXRSelKsbAsETjM9N2FNJ4NXU1NtUDVvIhPl+FclOGcfwkR9ik8Y0MJ
         uVqxXDCvtSlpJHTAOIt4MxN1cRPcL8rJaDW90VfNwFzOmxMJCNajL2k6PTPZL8lUNVfv
         rvQ27fHhMY1U1Mpt3Tcdlf5GQjN9n3K6N+VFdR47HPlmo2lw1NC5f/+7EjQqtbth41ai
         Pqjw==
X-Gm-Message-State: AFq9FYLDgK9YZ8Rf/qwjtYMpL15RGpMJ/2i//cEInGtd2rrx4qzT9ihC
	zrGZnM7wohNBEyG37wu+/oO6niTFLX7JnweMHuWxBngZXGFEetd5E8D8JJbZwQ==
X-Gm-Gg: AYBFou0pMmdwk/kQL6Z2C4iOUPkSRVm+oQBtNsfu3t/X8Cu4dDSc0CL8b47nKIDYj9W
	Ns6GfoCRpTDBWI1FH+vrhH3anGrX7Zx98132Aky4vbwWei9pSXHkS6vbx6P+U5cMyEti08IEcfU
	mIPVEuNPwzEuy1neEGYCCeoSGDV5V0pYH4WpYniguSCAOrxY64r1ybEmUBFj3h56HYdbGjaRPpJ
	WVbtSF/BYwQubPI40RY2wPSIrGOSkmLEA2YPsphrWMW/xelxpkqt1JHnu6bKyk/78qwkpBEEaj7
	Aq3u2PhQsn5MIByw684CHgaY+LBo6czQAm9JTTIBCMK1HGfO3Gc7aqpWbQy8OK4B4ciyytzDbWd
	IgzypWJVdj01CrvFxnf0VyEQAdkNDcyixKyX2SNUukB77WldXP9M+13fW0LaiyXA+8wqXIug0/C
	C278Zecfchn7CZNl2DuTWOW0TLneuC2X4kgw0OHxTV+MGBZIkp34vZxNRQSjwA6Vtq+Vy+xKh3b
	zNIFdpM1eLvVtT+YIhL67mx2b8xj8Uhm8gT4F0YYwdt87vscJWmeRPY85G98RsJRLsyG/uGSnyF
	0kx1aRAVqQhb9yrvNZG3cRvISimMfkt/tYoJ8pDqkXusAbbpPiPa1yc=
X-Received: by 2002:a17:903:2446:b0:2e9:5ed2:c394 with SMTP id d9443c01a7336-2e9a6c28552mr34777265ad.44.1792278653326;
        Sat, 17 Oct 2026 16:10:53 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8aad3dsm24001285ad.64.2026.10.17.16.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 10/16] bpf: Don't take a dynptr argument for a local dynptr
Date: Sat, 17 Oct 2026 23:09:44 +0000
Message-ID: <20261017230950.802052-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A global function is verified on its own. A dynptr which it gets as an
argument is assumed to be of type BPF_DYNPTR_TYPE_LOCAL, but the callers
may pass one of any type, that of an skb for example.

The type decides whether a write through the dynptr invalidates packet
pointers, and whether a slice of it is invalidated together with them.
Inside of the function neither happens. It can take a packet pointer from
its context argument, or a slice from the dynptr, write through the dynptr
and go on using the pointer, although the write may have reallocated the
head of the skb.

Assume the type of an skb dynptr instead. Nothing becomes forbidden for the
dynptr itself, and a clone inherits the caution. The dynptr which the
callback of bpf_user_ringbuf_drain() gets is known to be local, and stays
so.

Fixes: a64bfe618665 ("bpf: add support for passing dynptr pointer to global subprog")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 597302cf7086..338376492647 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21589,8 +21589,12 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 				reg->type = SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
 			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
-				/* assume unspecial LOCAL dynptr type */
-				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, 0);
+				/*
+				 * The callers may hand in a dynptr of any type.
+				 * Take it for that of an skb, so that a write
+				 * through it and its slices are treated with care.
+				 */
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_SKB, true, ++env->id_gen, 0);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
 				reg->type |= arg->arg_type &
-- 
2.55.0

