Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623044;
	b=gF9F6qDH+TaUCqvQRo1ueXpogtyXvBe1h31i/ebV2gvWS93uuLSuI9IxBZuE+Bii6a8y
	 oW/ituXbERCECz06aE3FY8yd7ph1Md6//seTG//C7dCrOjYBk2lo8+0zRIQ8ldHSrkqvE
	 Az5YPBN8xmvSk1G5s59c9sLAItaKtvlZmgK6kPiCGg/iY28QxTsarW9orHkDL5E/1A+/d
	 2fphXyl30Rikz9TCm+u4xsIhT9GcwD+v7kuSIPY68EHGByPOTd7uxwc1aDiTm+gqmK6xP
	 gPOdFXV/69JPwqN8DQe6XQmyO1syVhTW/X3E3GRqdvmPUBRZ81s3UnvXukJJyuxU9zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=8yGgdG3MuTUgBN2IlwGn1nZkRcdu7c0DJVMNgsIQLTs=;
	b=u1r/IxHQnSVc0oX+SoDNphRAkkb6cwFwsvL7lSeJzzagJpEZ44KGZ0zwGKAycUzLgkTD
	 ceGokuxYgKO0kOCAblYhvjaZP6oxvd0ElX7sITtWq7vV6+M+hlkK4K/+irhVwgRBq2zN2
	 KJgdU+xLrgl2SX5iNCBs7RaOD6BA0tgFbabmlGomEw4p2g63IhI6lKkQDH0bSrCO0dOV7
	 vWOQwTlKLkfsuEDoHUIQRheiTue1UnZuUAeWP1Wmux+qkPJnc9H/q48jfDUu8t6M8Hy9q
	 KxXFUP884YQQC49pySVeqtcG6H5mHy26vqmhbUAT+y9sGWZa2eKOFITAu3T/Nn2LrUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOoSOkIu;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94603606A334
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94603606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOoSOkIu
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so5404678c88.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623044; x=1794227844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8yGgdG3MuTUgBN2IlwGn1nZkRcdu7c0DJVMNgsIQLTs=;
        b=GOoSOkIuby+zJ+pcXZDwDkR/Nxf9MBeqs/4E1GhaH0/jXxzlb1TOan8oTVifidcaD4
         20IQiOHxKTyNlO1vLS2jf4UCq0esA9+3smJJX824cnVNTgTVW6Z7riIFdCW6fq/44sTd
         NRIqrG9j9aMuDD/rdYH1NvHifYY2Glsh7UmhK4s5vpqEK6WbEg9XXdLqiioiNeaFGAIJ
         S6GgXgkSFha5wibG7ycUOTuZ0BwCxt07FTOwakhHFyJxzzmXaaZKF4k29n38IVTm+FnB
         YkLT7u58R3zKGSCMFRDbGR3fX+LUWd2UHPMC6ESCvhHHQm527TrBDQPDGE5aOC0mXzCl
         ysQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623044; x=1794227844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8yGgdG3MuTUgBN2IlwGn1nZkRcdu7c0DJVMNgsIQLTs=;
        b=hap0WfS7q06GI57DYIc5EdMRyl5ywRTjsqPny3Gul8QQuHkr7bY/wM9qVNxB9luHrQ
         t5TJBNFbDJxbfHOG0WSXsFmLhvdY2EMWFfEqlRHYCTPpiIRgy5LO1pkINrI6txiNVD0m
         U3CRlAU0Cd7/0s9ffN8dEjGV8Sjc1Hta3sFTf5m+q1uRnNVG0RgId0nknglJuhAa2FQH
         siStR6aih2q1hnQsEYGsMwvgzascXuSw1mrDuazz3cc3d2zSk6yVN165sCbLWnkMJ/iM
         RkYfd0IpdKe880KDJ9127r3l9nAyS9cfjhIeiiORva6o+oONhC/HF13gvtToDHF1cfTV
         a7/Q==
X-Gm-Message-State: AFq9FYIyJEOBkORxEWXi7fWU/BHKmsZWEXG4yZXGl8aD31hcY/QPN5kC
	1C4wr/GDYEm06ILUhvvPUoLqSL/a4DH8Fr0zfcr9p+ajE2AQJhTKMPvt
X-Gm-Gg: AYBFou3qr8vlrf6n9ggSBQcQEgVB2VmznTowfRHtH89pnEW/q75P0Qdzs8/5nibhmmR
	TLVFMOEfP2X17Uj3rt2jpvPIA0u9Jr50mCzXFeoDgkWpZH3q0oXgNb6rSQswLb5S3fbwQcf/1PE
	LjNpnxrVi1jfsUkpaw+ogLzbvwTy+0sQSGUwm75lbE4JJlKJa1cy85Q3kwB0z/V7UpSZ3YWjnhd
	eEu5al4fVTpLAmUvO0Onv24hXjusmfnlHiLhmtroihwcc4qrvJM7BWHU8paFZtoruemOpCfkU08
	zn8B/Yva5gRFiQOuD9SnZGrDbnu2O8hH0Dde+SD1byLOwErxWhwgejLfulmFZzqPVmLS+1XLSdz
	YQwCQKPXdwstZ8OsvwxW1N2sji56OjFruCvwxCyMPw8KM1ho0AwOvx/s3LH0AvOA3Qfjg3DVAMB
	I7CwMMjGtEmUrYdPKxumXJf+Tq4BQ/78HsMQGkIYOlYLBpcYWFUUekqa+zvmXrrJBNnXl2vAo+c
	HLhE1Gaph7oI8R0kMMID/A5pYiihLke+LsSIVuXN74dDvl4GAE56tCvnXo5ymx8QVWuzzbwCR5K
	EuBvrTKqkA1DRy9cwbaG0RBO
X-Received: by 2002:a05:693c:41da:10b0:36a:1cc2:45d5 with SMTP id 5a478bee46e88-36a423ca2e9mr15639313eec.26.1793623043663;
        Mon, 02 Nov 2026 04:37:23 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm36326095eec.6.2026.11.02.04.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:37:23 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 07:37:03 -0500
Subject: [PATCH bpf-next 3/5] bpf: Finalize the verifier log after the
 runtime is selected
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bpf-blind-nops-fixes-v1-3-844300e42cdb@gmail.com>
References: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
In-Reply-To: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, 
 Henriette Herzog <henriette.herzog@rub.de>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_check() finalizes the log, which reports its size in log_true_size,
and selects the runtime of the prog after that. For a prog of one
function, selecting the runtime blinds the constants.

Blinding can log "insn %d cannot be patched due to 16-bit range". The
message lands in the buffer, but log_true_size doesn't count it: with a
stats-only log, log_true_size is 219 while the log takes 264 bytes. A
caller that sizes the buffer from log_true_size loses the message.

Finalize the log after __bpf_prog_select_runtime().

Fixes: d9ef13f72711 ("bpf: Pass bpf_verifier_env to JIT")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 935b163f81e4b..974dc571eff05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24112,11 +24112,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	print_verification_stats(env);
 	env->prog->aux->verified_insns = env->insn_processed;
 
-	/* preserve original error even if log finalization is successful */
-	err = bpf_log_attr_finalize(attr_log, &env->log);
-	if (err)
-		ret = err;
-
 	if (ret)
 		goto err_release_maps;
 
@@ -24167,6 +24162,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->prog = __bpf_prog_select_runtime(env, env->prog, &ret);
 
 err_release_maps:
+	/*
+	 * Finalize the log after the runtime is selected, which blinds the
+	 * constants of a prog of one function and can log an error. Preserve
+	 * the original error even if log finalization is successful.
+	 */
+	err = bpf_log_attr_finalize(attr_log, &env->log);
+	if (err)
+		ret = err;
 	if (ret)
 		release_insn_arrays(env);
 	if (!env->prog->aux->used_maps)

-- 
2.43.0

