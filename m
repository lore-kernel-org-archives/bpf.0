Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0B486406
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164279; cv=none; b=JgwCqWwo7F8dRFlvbKl//7POMl+B4PF/QIuha60+d5lmrA0TSU7S5/ZWBtE1CTFom3KC72wsaySAw+6ZbBQOCVPLy3rfkZevuirneQx8CVS9fpKVAFq1l59iVqPXHy0k9cMTF81flrDCBT5zvxU82Vwd5i1ErvdYPZwxhn5VJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164279; c=relaxed/simple;
	bh=y3pYyRIGDkYNnNMY5cXg9EvzkDiyIZ6zKjcBZE7/uhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlGOvnwz4CYfNGS9Zv8WJjP1D5+A0DzspNgqBCg2Sg+AVn9fFBMa9uwNPBtr6e0zXOIKJDJ1evF6AEF4gpvfKMDNEXN9/pW87K7cjKZ+R73w1lXseM+MZ9+Hyf3kkzkV79GAywQgNM2V2rk4GPTd6kHIchK4QcmdJskgBc6EgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQKC4wtp; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQKC4wtp"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-80587a80992so82314a34.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164274; x=1789769074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6D1ybLhZjpRjvJgolAFbhLRdt4Uc+0cM9T0q6Y9XfI=;
        b=aQKC4wtp0CcmA4snjFGIl8EmyaXgu6LfHGJGvLgg6/jVBfeNjVnKHirQDne4yo+kvu
         YdjsLOr9zHJp/fOrvap93us53QxT0Do/QAOx50FI3lpwq/4sS4uHrdhfeXvcYXRKE4FK
         kW8Hy5dt7Lvy8El/KIWzAagSkxA3yQWspn1tZVaYtq8ewZrsqW443xAHql5ZlM1jQapU
         6cpmd/Pn4cDIJESuy3+jpIJ5CVUpXqxy8kvSZA8+EAj/sHHrtZ3djgwnM61qJidv4OPc
         /kN79xhk1bwAhywtZ8uzG0parCufFw5ByyIHzNKxH/zi/y5C1VzE2GNOB8FqMEc6fpdo
         R2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164274; x=1789769074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6D1ybLhZjpRjvJgolAFbhLRdt4Uc+0cM9T0q6Y9XfI=;
        b=PvV6nI6zUVc3ZDwTKop1COjgyfyf68jmZ/6i2YQoaGfNHpLjbpQAeqKrgzOYV/xkZ7
         3cno9qKo38QhNwqYvrzloPAXAxCuL5+gao4E4BJoMZ2wEMVqtsYUYIj/Rbu2T53JGwe3
         U/Inst178t8MvBgxDwmG4iHil36kWZu77yEax8ltlNfcPteD3B0LoaC82gIvOhI+M6tC
         vtUGuaIR42K0GSxlIuN3Pd5fxSRS2MwoqhoVfAxGCz8zsxWl02mYl0LlpYscnhgDJLu/
         wwtWOHLCsDSicb5U1ZFDQRvJ5o+WPzvLDf3Yf+BbPAfwsk1/WFHhWrRm4KgacrPArN13
         aelQ==
X-Gm-Message-State: AFuF++nGlYLIT33NwxYTfuR1BkOXBwJYUtDcpgIhKIUSbWIDrSwFpL2w
	s9fwocQw+hDYgfMKGWS1wwYq4yT1exagMZ+mkSjhBmRGkISV0tNGGoW9+0/vxA==
X-Gm-Gg: AYBFou3mEvIt5nYFGJH7Dwe5BCJSpenHWfaAAgH7b/tmcLOhT1jA+iuZeR0IKDIj4Mp
	AL1prAuTl60hvzobQagjYSN3ycEPoU5nRA2rNNcssUwXnQPCdmw1mIs8kC/7m8zZ6sCa8KHtMHq
	60zWkx+s7mJnAJuEE5IMGQ+CmF6OJBsvnAxKAtsFLK1WTVcjXi6e4ImbKkvIuxFS9zIfPiV8G02
	lO4lWlZLgiyXrVfSZZmTvmlENRHM/SW+JLNZSFLr3us4jUDvrmDZ+U7geZwd9l9ehk/TvTxLSYH
	6jhvkO85gxwZ7fzguRrOzivAX3CF3Nd7Ozt096obCJnEECa6bTYALc3dBMKvATyhsNtprYBneEJ
	5yzl9UozULOynpzL3SLRmceNpuW0afEV3l0vgQogoX0PK/SH19NWMZAHhOz5n8wws079Np/S5g2
	piuaMC59wlBAE44MpRefZxFKT33ky3Hp8XqdgbLa75XxrHkxy7xoZqm/gonFfN4JuRb/CyZxW9
X-Received: by 2002:a05:6830:698c:b0:7fa:ac4f:77c with SMTP id 46e09a7af769-803ffea3670mr4776459a34.27.1789164273724;
        Fri, 11 Sep 2026 15:04:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5adf677sm4236824a34.4.2026.09.11.15.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:33 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 11/23] bpf: Set MEM_RCU when generating kfunc argument types
Date: Fri, 11 Sep 2026 15:04:03 -0700
Message-ID: <20260911220415.1396439-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BTF ID argument of a kfunc has to be referenced or trusted unless
the kfunc is KF_RCU, in which case an RCU-protected pointer is accepted
too. check_kfunc_args() reads that off meta->kfunc_flags on every
verification of the call, which is the last thing keeping the argument
policy of ARG_PTR_TO_BTF_ID out of the generated prototype.

Set MEM_RCU in get_kfunc_arg_type() for ARG_PTR_TO_BTF_ID arguments of
KF_RCU kfuncs, the way it already sets OBJ_RELEASE for release
arguments, and test the generated flag instead. MEM_RCU represents the
KF_RCU relaxation applied by the ARG_PTR_TO_BTF_ID trust check; other
argument kinds have their own provenance requirements.

No functional change intended.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c602007bf583..39f7f633b4d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12336,6 +12336,14 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (is_kfunc_release(meta) && arg == 0)
 		arg_type |= OBJ_RELEASE;
 
+	/*
+	 * A KF_RCU kfunc accepts an RCU-protected pointer where it would
+	 * otherwise demand a referenced or trusted one. Other argument kinds
+	 * have their own provenance requirements and must not inherit MEM_RCU.
+	 */
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID && is_kfunc_rcu(meta))
+		arg_type |= MEM_RCU;
+
 	return arg_type;
 }
 
@@ -13275,7 +13283,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			    reg2btf_ids[base_type(reg->type)]) {
 				if (!is_trusted_reg(env, reg) ||
 				    bpf_type_has_unsafe_modifiers(reg->type)) {
-					if (!is_kfunc_rcu(meta)) {
+					if (!(arg_type & MEM_RCU)) {
 						const char *expected_type;
 
 						expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
-- 
2.52.0

