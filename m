Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1931409635
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021953; cv=none; b=OqKCyauOuuQM6LAPDkxwMGACE7tIVq9jT0yurMYkINdhzneZ0n5VW3PggAioj21ZNO1tOjeNTNsRIOqfNDmLwbXmmpjQGXeDhx2yIqqT3YJlr91zL9uaQqhQhMS3IbERJs/GRdIAinRzSNB158iOMcj/Wn2FRgFsv2msDCAubPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021953; c=relaxed/simple;
	bh=mfnEbSScsujRwoxasSxyWdhvlmzfSWWEe+mMVO63fwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4do5q5y3c4LhyDXmiqiEhRnNlZVU4XmeHIpnvPxmxGhi5iEKMwHQtTjVB60AwOOu8pE02cos6U7aO3VxR/fBT0gJDkYbPDB0mUx+CdT1e8F2Dyc+ej9fSSesdZP/kqEhH2Bddoa0bMe8EevPvSIKimw2xWWYBQJOMAAKp/5Ck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajw33idr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajw33idr"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfa429aa6so4879091cf.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784021950; x=1784626750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wL+dQXVVG1jrwdjXyQWY9fUn4W24MWcB/WCkDuLFzik=;
        b=Ajw33idrKx2wBknLRObepsEF2PyiQ5p/GpEFEudsDvoqMAiujy5gWefUB/St074/X5
         9rF0RzZy2qCl3dlktddBqoI0e0kSXOPtrEVLuaNQef+p48ZMm+Xm3MFN+bnzsZcrbUXu
         EQFPC2uE5kotDPwJOmjPM3ieuaHpW198N9d4YM+59/JgRBVtShihMyMq033aMDBAX/0a
         pFobB7xmEetSo2Eb6iUkfLMkXyzF4tSCejdJXhEWGqvVGpLhXcqwZstXvhIJcIRelAK8
         9kdVdYq0aa/QQNX1Bw2fI+rcTbnf/WenW30eRlQcqgPJWvhDeTS2cniXfepkKsj4U8EY
         G0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021950; x=1784626750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wL+dQXVVG1jrwdjXyQWY9fUn4W24MWcB/WCkDuLFzik=;
        b=TW/mMYNEYfAwjEHQbpBsbncD1t3Fly+nOwPkYrj6m4OUaguPoF+OGyyuPaOLYQXOJi
         rNqv3teqmpqfS3VKV/2iCm+tRNU32K7bpwuDdY+eEzfQfbW91yB1bLzySm0unzIUZiZc
         lcoAcp+3YHWp+RWk9urtM7LBCJTKTJv/xGA/JwwMZhCEBbIV/laxHkV1XkQVfNKNdxAa
         SPp8uqxoa0KZqAOinK7ZiqoKhQg/rE0WUd3UotU8Z97ke9gCWV7QvtjspM1h42FKYGdL
         QMwrbuZlyrENBKom55nWkEBATuS19eKgoMS9genvlGN8sbKDH17QYy+scxuqR4QSWknG
         a94Q==
X-Gm-Message-State: AOJu0YxCl0XE5lf9xgj8CosM8BYfjZMaqOd0UUmMbZUrZ3Qkoqu2+nvS
	snd3cw2wgYjSYQiycn+1/vqsCmGbdDlkJgIapfn9sKfplzEwTFhRl97UYjWXjMpOOCo=
X-Gm-Gg: AfdE7cls2lIjj1idsLxyvZSVpPFtMqqfGXhdHPm/6IDcxYT/iYsmWwA1JhvwRvb1fdO
	bnOt4h9nQR/HqaUXV5ZijvW5swBntfWnW35JSQ3e9VXJQ+IwVoQ1yWnv6ltj7h5A8CS7vWMhsky
	cII8BzX/nfVTEKlfshU/To45F+GlgizeD8cDmV78BkVVDtX6MhBz2BJFHrsApCSLDFJaDu+byid
	AlB1DXTazZeMA776OWATu4s2GAYpCEyrwuRrgxuKZzqhdl3g1pxpwPnRupfUAZKoxxlm4f3fIMw
	E+oJ0MqRMhabYusp4aZ7kK5AWCZVNKJXAaoVQshDRS45T2r3ETjPZ35NyuND23Y3XY5LuGiPGVW
	sdjs1aEgebqdqBsS4EVTV1F1Z2TEdzNCuYxq/mzb++Hwbrtrq/0DJeX6YB48ZdC14zFk57ZkSWn
	/Am8bIO2dPDDw01ddmBv1/gdBGhew8w0Nw6r3j4iY4rlapY8xF+ALBg5ibw9GOsh44GwpEtTyM
X-Received: by 2002:a05:622a:1e07:b0:51c:4f35:81b8 with SMTP id d75a77b69052e-51cbf73e524mr120889981cf.7.1784021949680;
        Tue, 14 Jul 2026 02:39:09 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacf2a75sm111460511cf.13.2026.07.14.02.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:39:09 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Matt Mullins <mmullins@mmlx.us>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v5 1/2] bpf: Reject negative const offsets for buffer pointers
Date: Tue, 14 Jul 2026 02:38:45 -0700
Message-ID: <20260714093846.18159-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
accesses, but it currently accepts a constant negative offset produced by
pointer arithmetic.

Commit 022ac0750883 ("bpf: use reg->var_off instead of reg->off for
pointers") moved constant pointer offsets from reg->off to reg->var_off.
However, __check_buffer_access() continued to check only the instruction
offset. An access with reg->var_off equal to -8 and an instruction offset
of zero therefore passes verification.

For writable raw tracepoints, the access end is also calculated from the
unsigned reg->var_off.value. An eight-byte access starting at -8 wraps
the calculated end to zero, allowing the program to load and attach
without increasing max_tp_access.

After ensuring that reg->var_off is constant, calculate the effective
access start using signed arithmetic and reject it when it is negative.
Use the validated start to calculate the access end for both
PTR_TO_TP_BUFFER and PTR_TO_BUF.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org # 5.2.0
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6515d4d3c003..9f1333676365 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5326,14 +5326,11 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 argno_t argno, int off, int size)
+				 argno_t argno, int off, int size,
+				 u32 *access_end)
 {
-	if (off < 0) {
-		verbose(env,
-			"%s invalid %s buffer access: off=%d, size=%d\n",
-			reg_arg_name(env, argno), buf_info, off, size);
-		return -EACCES;
-	}
+	s64 start;
+
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5344,6 +5341,15 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	start = (s64)reg->var_off.value + off;
+	if (start < 0) {
+		verbose(env,
+			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, (s64)reg->var_off.value);
+		return -EACCES;
+	}
+
+	*access_end = start + size;
 	return 0;
 }
 
@@ -5351,14 +5357,14 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  argno_t argno, int off, int size)
 {
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size);
+	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
-					    env->prog->aux->max_tp_access);
+	env->prog->aux->max_tp_access = max(access_end, env->prog->aux->max_tp_access);
 
 	return 0;
 }
@@ -5370,13 +5376,14 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       u32 *max_access)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, buf_info, reg, argno, off, size);
+	err = __check_buffer_access(env, buf_info, reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	*max_access = max(reg->var_off.value + off + size, *max_access);
+	*max_access = max(access_end, *max_access);
 
 	return 0;
 }
-- 
2.43.0

