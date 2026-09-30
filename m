Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B01406804
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796729; cv=none; b=AGqfIGTpy0rS5RK1RJ7YtIh6FzoG844ZUnsOnUA4s1eXHHVoaKsT73MJNvTOSKJYoct+pa7ZR7vF7BmJFjshducA7M0/MOiARqV+wtxnbHkPNEyAiBeV2FKY+HYwA/1pSgsVVfNlm7aX5pe/GdpJZEPbOQV21Qu6XgdXXp0i/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796729; c=relaxed/simple;
	bh=EaOdzo9YU8oavY1QTzxygnaMq8oMJfxQPY9WaI6D3LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkZAOWpDXd95L3ZNeFB5O30xPw4p75SqRX+NAckggvTG+8bnD6NUsZuajAr+AzTYsA0J/ZBXiC1iDbHyLibmy96WW6RDS31YDmhT3BEihIQXZ/NNaUFZoEDKgPY8pAnPqj9Mv+NWy1EcKvMdbHBjImuBpNnCoCaSBagci3/3Mx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5+eppaw; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5+eppaw"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e25400so2387443b3a.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796727; x=1791401527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQ5QKVjHzxMwXEocrjUP4F9tL0XlyEJnUrzJJy7fQPI=;
        b=d5+eppaw+ITJ7DYqOcOa8Qxz9zxLuQZzJempuWwGBVXvMR5/TkznWe40FSmh/IJ+r0
         QbIXRO7yG+0O+5MFbqNH9Cx7tqk+8DJh4BsOokuY+8MsWdH/TkSpcdmFq2XaWi/Yj1G8
         sI3wug439rQeyv5kfAIn+FEODPyJU/HcADy1N/yCTnsAFFEnNxNs9G1M0ZkPb7Y/FLrm
         1JqVdVTBSoKnCK92sBi9H62GaA4QPGbhVdf10Na9jq/DX8fG8CIJxnHCQXpesl3P34wO
         q5cNsK0Yfj2I9QSQiWtxaN+Htf5yMMpTNgN/A1ZakxGvB/tpZTwsONjc0fJnOv3RSNLk
         do0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796727; x=1791401527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQ5QKVjHzxMwXEocrjUP4F9tL0XlyEJnUrzJJy7fQPI=;
        b=uTycLFgimUmCIr0AdixkA+FD8MkPoSanFaH/lCdU0HAz5nLsbj9dXbXVhWyrHDSOf1
         jjUXdEo/nheF3fZe94XlDq6K0tpcf9IQU13xfO66HdUvDo6fNmKurrYnbhhHx89GP3md
         qzd+2XVjFH5BQFNziVjkShbSHUzBlBYlfblXXn8kIlmJ1ekhFoyWXqPDsoLmiROu9nUR
         IiIZDG0K4yJiN7EiqI911SL+S0Pb6Hc3w9rd+2UsxJtW0Pqs2DdaX07TuJu1Zc63+VI9
         x2UrnRWQhHktnZWVLNasIm/2dVQ3wUQwV55ti+5McLZP07D5V6Myhgx6iOzJmEWdNzZy
         cFeA==
X-Gm-Message-State: AFuF++mU6zx9QZQ2nrD5RRaHClmc0Pp2xxdY2PwkxynoE/DWRIiapKA3
	iQQcfP6NNEJvdNe9rQ5rZ/f7degQ7RYFDSLY58rvBbYmV84Dbdw5L8Sgv46AOD6n
X-Gm-Gg: AYBFou1atuiL7bNPWhpmqNjbuPwIyFPKjZ0VnBK1CYjHTi3Mx+RnRBB33Z2+7c1XHsF
	WO9hhIzD8+mN2mLj/AAPbusQG9hzcszi0J9QQWdHuOPs6iTbFfsWPu5FecpwZ4WK8QK/N9E5sBo
	3fB+4nixJgaIvqu1tYSJd2ASUn5qVPBE4pq1HlHIyH7lm2k6raGvmdO9GXvGP3h+hxGEfwkOYBZ
	hAaieAA1IJBegWXcNqKys0Y2qOil12iNvRRLrXysCswD6VBYtbU4wer6/m8quJYacARNLSiyjFC
	Zh9scSnVKnejy2/xq9djR/ggJTyTx+HEve532c3bak0A4LeVjTveuxbSNnG3R5iIEWI3azkMENs
	O7JpbElDjoE0PsoZ4p9Kx1kuyW22nWlBbLhSR+gfhZTr1h2xzmEKBtkw9serVF1674T28rEeE0+
	V4BwYyBvEX8tpBNbOIlysGnxuW2VLX3rMKV+7ZdvmwPJT/jpR3olzy0QuNOJMHcLb+Qm7IbiFev
	KcPkzCU8dcrvSRtJx7GQhOfpGRB9mPivFbE8END04sv0QYGxOkanQqefYKqHJrk6TD6Veb3a3bN
	hqsPhb3npEuv1f5DY8XC0uaRP8sj5b6yA3x2vHibnYI=
X-Received: by 2002:a05:6a00:4206:b0:868:e6d3:fc18 with SMTP id d2e1a72fcca58-8874ab8ab8amr1910593b3a.15.1790796726826;
        Wed, 30 Sep 2026 12:32:06 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88815996882sm98961b3a.8.2026.09.30.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:32:06 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 12/14] libbpf: Keep format strings of bpf_printk() in .rodata.str
Date: Wed, 30 Sep 2026 19:31:25 +0000
Message-ID: <20260930193127.2181684-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_printk(), BPF_SNPRINTF(), BPF_SEQ_PRINTF() and bpf_stream_printk()
copy the format into a static const array, which the compiler puts into
.rodata. When global data of the object is in arena .rodata is there
too and the helper doesn't take the format:

  R1 type=scalar expected=fp, pkt, pkt_meta, map_key, map_value, mem,
  ringbuf_mem, buf, trusted_ptr_, ctx

String literals are in .rodata.str1.1, which libbpf keeps in a read-only
map. No compiler flag moves a named array there. Put the arrays into
.rodata.str with a section attribute.

An object that uses the macros gets one more map, .rodata.str.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9d160b5b9c0e..b37b727ef216 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -248,13 +248,21 @@ enum libbpf_tristate {
 #define ___bpf_fill(arr, args...) \
 	___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
 
+/*
+ * Format strings are in a section of their own. When global data of the object
+ * is in arena (the object has .arena.data section) libbpf keeps .rodata.str*
+ * sections in read-only maps, which is where helpers and kfuncs take strings
+ * from.
+ */
+#define ___bpf_fmt_sec __attribute__((section(".rodata.str")))
+
 /*
  * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
  * in a structure.
  */
 #define BPF_SEQ_PRINTF(seq, fmt, args...)			\
 ({								\
-	static const char ___fmt[] = fmt;			\
+	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -272,7 +280,7 @@ enum libbpf_tristate {
  */
 #define BPF_SNPRINTF(out, out_size, fmt, args...)		\
 ({								\
-	static const char ___fmt[] = fmt;			\
+	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -287,7 +295,7 @@ enum libbpf_tristate {
 #ifdef BPF_NO_GLOBAL_DATA
 #define BPF_PRINTK_FMT_MOD
 #else
-#define BPF_PRINTK_FMT_MOD static const
+#define BPF_PRINTK_FMT_MOD static const ___bpf_fmt_sec
 #endif
 
 #define __bpf_printk(fmt, ...)				\
@@ -303,7 +311,7 @@ enum libbpf_tristate {
  */
 #define __bpf_vprintk(fmt, args...)				\
 ({								\
-	static const char ___fmt[] = fmt;			\
+	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -317,7 +325,7 @@ enum libbpf_tristate {
 
 #define bpf_stream_printk(stream_id, fmt, args...)					\
 ({											\
-	static const char ___fmt[] = fmt;						\
+	static const char ___fmt[] ___bpf_fmt_sec = fmt;				\
 	unsigned long long ___param[___bpf_narg(args)];					\
 											\
 	_Pragma("GCC diagnostic push")							\
-- 
2.55.0

