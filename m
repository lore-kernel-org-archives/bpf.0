Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0D3FBB50
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684556; cv=none; b=mIbNK/VD85bfepNlLSnre+BrOh8lmZRRZlvodkeTlsoVR3KgDZe94rekyfLb/rfns2bDKztrHsmAwOYliCw8yXvmbWAQ1NCMoamxmZEObRgYmdqU5EZwxG2oM+9xXUPoAPGULWW1FVySvAkLzIiUfQWF9q0UjydWBsys80umwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684556; c=relaxed/simple;
	bh=bdDero+XyXIqJKT2CcYDDlJxAtQ+MlH1wwcGYYvKqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw6/qvTKhYfrADyqffPNFFxrnczHX8zW5OoX3FhQZStvOMeM4cPPIYCi0y8iB3vgWKDtz8OTUeBhpR+LUyacJM2IFvZadQLN2lFBegKK/AuyVozoanGSEtnB++yAeKuugkBP3Laxz5gdo3j6jodWB6Shs6auGPWNNSkTYvm1wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE2po7YG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE2po7YG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso16488795ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684555; x=1781289355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCQYih7Qu6X9/MRoiGqCVzcGjRebs+PoxLmTpVbEJQw=;
        b=LE2po7YGuv7kVfch2jy1Fg9WIwTZRQZuQ4udv7xX0jTjMtSaPY7L8DAfv9Ifs6lKW4
         EYRNhWW3yR/qOWYnVeDzmaeEmxD9Y+XHWUHOaTf2znZs20nBflEXNaDR5UHvhN2Rz7B6
         0K3AAFtCafO7rAUkUbqy2cGWv8dJC3u1wKxN+FhFAowB294me3+CWJXzg/6OV3U5a0Cl
         XLk+82JNW7+WK/vhuxSNsWWbuxFnC74awk9ju660xhvHqOHiSCqZAE2WPCXuD40tJuXs
         DacHKJa/tXlrhPLaEx8uUoZzGQdNHzOgTHh9UjPgcKCs2ClQ22bv/wNBWklSYSE8H7A+
         0zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684555; x=1781289355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCQYih7Qu6X9/MRoiGqCVzcGjRebs+PoxLmTpVbEJQw=;
        b=mRIv/OB4BdKaIn57zG3T8SBGT7yQr7+MuEvaYIbzrH9FOUAitIaIwsKqI97TmOBolJ
         72GM/rPajVE8PbqIh2gmGEovpCNeLaiJs1ZOi0h3CX/56w7SfwpQf8vp72VNc+zAm4cI
         sM52tFjHX7CeHf0SImZThJH8lyj1YctkVCMxKFYv5fVbTRb2TPp69to7IYfsUD7tuKwR
         Iqqwjqw5vJmWamCONzobWKP7FMQ2bLkv1d7AV/ND0BCeB3T4i6MhjFMaK26LBaawNcMN
         Rj2avYs5p9+5D1w6t50wUJMce1ZyIllIunLFsJEshSF8MazrYI2ybAo/lQoTcoxGJ+Ch
         ReBQ==
X-Gm-Message-State: AOJu0Yy6zSA4EhM3GwOTR0gvpc9wcJSBCK5KnDSpDwdWi1B8aX9V8pD+
	rTwin+Cc6vKLxynwtgsl45MmIwpGakmfdflM51oXjXT8+8ETL5TNag1ih8MjKg==
X-Gm-Gg: Acq92OHGSXBfxKIbx95Wf/OagiezFVrUVLbJEv/FryHYrgcb/y3VLlWJhaDhvJgJnON
	Rc1DcC1QsS7RPK3L/YIBw2dX1y7B4+nXIpienMptiNwS4kst8OlaETT+tUEC5mhiaCJVLrRfXoR
	+ZBs5zRHZNC8VE+Hn9mnjHHo0ViuYgT8XOhiYljzVW9gel0F2yswExKojb+aU2vU3wI0XjEgdyT
	VFVOGZK+FxzO1ePL/XCKyoYPKLNAmZ01Oyz2Jq9QoxNzvBbvTy3gmrfg81jEG6OyLduLVfZ5Z+p
	ZzlgzumFIWnosMpJTAF9lw0Ef59fRvqLc6/XET45ldHD2n5n55Tq4FV8389Ax/5+j+bODUCMiDq
	8GZYr1iNvOvqUCgG12IidV34joeEQH/jN4rV5aw3hB5GXkq/AjtHp31XjnZ1NVwNwaeXO69B8oO
	Ct6gdPg1qVADIO0lExt5xw8ZyT
X-Received: by 2002:a17:902:ecc3:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2c1e8339808mr52702625ad.33.1780684554636;
        Fri, 05 Jun 2026 11:35:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm142698675ad.9.2026.06.05.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:54 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/5] bpf: Check acquire_reference() error for "__ref" struct_ops arguments
Date: Fri,  5 Jun 2026 11:35:48 -0700
Message-ID: <20260605183551.969144-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When acquiring references for struct_ops program arguments tagged with
"__ref", the return value of acquire_reference() was stored directly
into u32 ctx_arg_info[i].ref_id without checking for failure.
acquire_reference() returns -ENOMEM when acquire_reference_state() fails
to allocate, so the error was silently stored as a ref_id instead of
aborting verification. Fix it by checking the return.

Fixes: a687df2008f6 ("bpf: Support getting referenced kptr from struct_ops argument")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6446db9628ae..2a18b8aba14d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18362,9 +18362,15 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	/* Acquire references for struct_ops program arguments tagged with "__ref" */
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
-		for (i = 0; i < aux->ctx_arg_info_size; i++)
-			aux->ctx_arg_info[i].ref_id = aux->ctx_arg_info[i].refcounted ?
-						      acquire_reference(env, 0, 0) : 0;
+		for (i = 0; i < aux->ctx_arg_info_size; i++) {
+			int id;
+
+			id = aux->ctx_arg_info[i].refcounted ? acquire_reference(env, 0, 0) : 0;
+			if (id < 0)
+				return id;
+
+			aux->ctx_arg_info[i].ref_id = id;
+		}
 	}
 
 	ret = do_check(env);
-- 
2.53.0-Meta

