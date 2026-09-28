Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079637F33E
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619264; cv=none; b=OG8vo7DWrsq8DDV+dgr4s3xhm0ByQin0GHmdntZkmYmMxmP1Ihxa6+xfRmznTG2pjh28qrhymRnJsifjNBMuW3NskE0JMZgPK2YWxx3AVYWweNIMn8FPbshHf+1kNkFYo/lPuvh+RR7n4V3i0fVafHTZx0VX29REls8s/sWSUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619264; c=relaxed/simple;
	bh=9RoBL69drdEYdWQkJCWaZbR7cZBFxHWqYDBkuoeh+uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz8aF9QvdcYWjS2ZKb76Vz71kF+mYqF8LkkJnmO5duK4vypwn/X8Gj8J+8p/TkVyDl8J311wIzBPLqG7/4Wqa1BZAVWwc+m544ayP8gOxNL4C0C8GSdkWIMBc71udB0iq9Etx347cYX6KxtUz8ApTJM3801jFZpMoO88Q/lg58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFAQ4Epd; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFAQ4Epd"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6d33d80855eso2339973eaf.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619262; x=1791224062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eyt+/rutlGFNMD5KZ+G4lrXG94eYQ4UhwaE1eUzrsAE=;
        b=KFAQ4EpdKl3JmPRC/UHTqX/v6fqqznaOblk/pHqWT6dOoU/Vn7cX2QuIFt9lyk3qP2
         RZF+V3e0D7oFqKtUsfoRD/6bcbhb8PMHA43IGyoTHuBjLa0YMa7CAM15RbybtMXQrE6m
         gbEobzw6bsIK5Zv0bkxeOxw2oj6CuKXUkVKUunABYBsKnMpf46rmYPpxT56Y3TXm69Sd
         X0nlO9+oULu24eebzh/XebVvD2uVhu9Ml/kyd9Ft3HiSo6mo0grOv5DcNZGXS8Y25XPC
         cCpZuUm4sfVyql0DWagDYOldfwhFbHfBy3PIBzig0Nj8riRPNzSyi8+nAwcXQbPIRTbf
         ER5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619262; x=1791224062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eyt+/rutlGFNMD5KZ+G4lrXG94eYQ4UhwaE1eUzrsAE=;
        b=ZmwtSURCQfFr5GeJtrFHHPWZG40QYK66yKS3wz6TXIEpjHuxmiUZ7sSKHafpwsp3Wq
         IeCpS7qHCs0PjWpv8VyDKO2lzbtDVsvcX1HW/Wyu99BSpx8zCv0VoiXG7AeIL70okpSN
         mB9L4ZzhvYBKi5r2CjAJAABNoQR8qfXobziby3JcF4Hi94kLbuBJ4MBgZK07Ypp3DTfA
         66l55SWecqn59KZftMrHgiStrYJb83ZoSUXdJB3HdLxoFkko3tJxBjEe+qFtmMyRwjmu
         4WOzcio44mRwUwXTDDD0xhCHo2CRAUvydQlULMRXPvv5hmgTd24T/GdCEyRm2Mjhq4Ck
         s0tw==
X-Gm-Message-State: AFuF++k2dcI5B7WXt5C4ph3tNXyShLBQYQXcwOXVjkEX25rpOBMBOcQy
	EjrsvBljnmRk1eKMizaaHmBx70rCAHxqPMYg8m86nYDDhJKXJYSyWYv3/u9AzQ==
X-Gm-Gg: AYBFou0bB9L3bsX0UDEjf9GtWMKsl/GqajfC0NpSertQjnI394pcj6Z4ZKN4DucvJXi
	Rx5MxEwp6TrdO6b5GV6AEr6xD1do2/BD/s5HB/9DHONHkjDr/xTWQ1Pj0yqZBlXUWavDgQj3Fk0
	QeLvUBkv30FMDTS7BuwYT2+z5xGUNhecGmTgAN28nzRSJU1ttYv79kt+W+Db+njILbde/mkjK+X
	v1Art9H6JVOr/k5Rzfsxfc6Xkjzvkty7CMqttJbD+J53Snf3CJstGFkgrP/TfEDqvJznxEljIkS
	x/7lxPq+TQSvliJfFA4UyrLZh7dplQzj/QEzd0Whj8fiXr1KMdmJJo1tGeBNYE/wMExgAOwzkvV
	qa0sHRZWQLpy8OEW/d+3IyAMwSxw5OgObn0zuYHnbuDhvTMkULuDLMZN4UlymKFpsNfn8WF2hUT
	0A6FuNzRIQcfAjOLwt/Tm7cxBikp3gVEQReohsEWIvoXoiiMPJ2e5Z/MVCOryR
X-Received: by 2002:a05:6820:162c:b0:6c9:80d8:a206 with SMTP id 006d021491bc7-6d4415b3f0emr13179317eaf.67.1790619261902;
        Mon, 28 Sep 2026 11:14:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d882dc49dbsm5880293eaf.9.2026.09.28.11.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:21 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/11] bpf: Check global subprog untrusted arguments in the common path
Date: Mon, 28 Sep 2026 11:14:07 -0700
Message-ID: <20260928181414.644158-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogram arguments tagged __arg_untrusted deliberately
accept any caller value. The callee is verified separately with a
read-only untrusted pointer, whose accesses use protected probe-read
instructions.

Keep the untrusted type in the canonical bpf_subprog_info used to
prepare the callee state. Represent it as ARG_IGNORE only in the
temporary bpf_func_proto used for call-site checking, then extend the
guarded check_func_arg() path to cover it.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 147473cf14f1..dd51df530e62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10805,9 +10805,18 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 
 	memset(proto, 0, sizeof(*proto));
 	for (arg = 0; arg < btf_type_vlen(func_proto); arg++) {
+		enum bpf_arg_type arg_type = sub->args[slot].arg_type;
 		const struct btf_type *t;
 
-		proto->arg_type[arg] = sub->args[slot].arg_type;
+		if (arg_type & PTR_UNTRUSTED) {
+			/*
+			 * An __arg_untrusted argument accepts any caller value. The
+			 * callee treats it as read-only and uses probe-read instructions
+			 * to protect against invalid memory access.
+			 */
+			arg_type = ARG_IGNORE;
+		}
+		proto->arg_type[arg] = arg_type;
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		slot += btf_arg_slots(t);
 	}
@@ -10870,16 +10879,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		nslots = btf_arg_slots(t);
 
-		if (arg_type == ARG_SCALAR) {
+		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
-		} else if (arg_type & PTR_UNTRUSTED) {
-			/*
-			 * Anything is allowed for untrusted arguments, as these are
-			 * read-only and probe read instructions would protect against
-			 * invalid memory access.
-			 */
 		} else if (arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_CTX);
 			if (ret < 0)
-- 
2.52.0

