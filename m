Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361167;
	b=Z9kbMwQyfskdbJBLguxvpAVX0IqcWcgSu+0nCkjsj/o7j2SDzx9+/sKoTP7eQG2U2btU
	 5b3gwpLLLNzF0to/KyPd7pn9bEcBo7Vm/LHCQcKVSkeViGrYr79bcwuDVAUaXN8eU6Wpw
	 G9Eopi3elBjscQ9t3XFCMwB1bEdbQqY7GrKk25OchHAf9JLc2s2hEis0DiZYlqakGz22Y
	 +B1eSxDw3UV72C/R8nZdhCg6mVrQI44EGswypD6aigYpLKz+mp3deVZBRyW3McO++bagB
	 4giRi8tooJucY4NXFTZTyR3UNre7eBUKfl2urd1qWu1ZPSz2vQAsPLFg8DqG7m4g6Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=MLCHeRLnz6TqJOVgI/l/YrG6flGSfAttWQ6QR1FofSE=;
	b=k6QVtntmk0lhqx6xPbRmXipVvx537GJHlFHrHw+atCtTr0t/SkaUvWBHZhyKtL668bwf
	 nEwGlgRwcqjs4rs7WK9z42Q6t8dzhVmkCsSkPdEYze6RoOdSVnr1FN+TopZIJhSktEqBJ
	 V9wdU46HN8F996MdqNp2z+wdnaLcTXWPuxSnLevrriY7Q2zU9UiD0F1nxMGtkrIZVnQ51
	 xs1Dl05RCXgmptRwtou3L9wRkOEvRgGwhhcee+bVL6hCaMqkAGFUNgjYxfHcWbUX2bKyN
	 tRkETRQ1pcMZLd1vxA5MZE7DCvVRGXAPkQr3crVuc3z7z7XqVkrCCrlCWRlZn4+aJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPDkh6m+;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AC606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1AC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPDkh6m+
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-18cdcfc05ffso750696c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361166; x=1793965966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLCHeRLnz6TqJOVgI/l/YrG6flGSfAttWQ6QR1FofSE=;
        b=YPDkh6m+oAJvbeTzt33kgmOmHciaaeSywRmJEgVL4G/ARJI6ESMCQhZmyforfI0eLE
         XmnBGIkk0YINe7wGPQ6GjT6IZ0kFw8P9s0fd3abtkw+Na1/ly6jyaNRIwKoriQ1/UnnX
         xnUaAilxXi/DMTuTL6NjRLMT4qGXZsnCpAfVZ1gl3LpHj8el4Uua6MKD1q72uVT40xNK
         JgOmVC0sADYusRbRcsZ3TL7hNlGOH/mtQJlA0SSI7+a+hNqzAyGtC20dUdX4J+sEi09u
         0CshUJo2fmklnIiSBFGsbI7erDAWWq/HeUv83aCBrXCrL/2IEvwiKxGyMmosWUHrwG7Q
         Ndyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361166; x=1793965966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLCHeRLnz6TqJOVgI/l/YrG6flGSfAttWQ6QR1FofSE=;
        b=fqWoCLF5ZPlEksQYEUR2dxeTuQIhYaHq2ExNvPDfYo2Ztg1GdIqySS04JWrMKbUHL8
         e6j0ipr7Bbc0CNDRLL3B87Y884VmsQSPRw+ngWXMKpL4LFzrJsckEgKVmcLOgkNpM9wy
         19nr0Ufk+DeJEstYdxjSbZntiAVTr6QVqQ3337/JD63d581qmyD7VaCEq0zW1KlGJArh
         aeCjRSTeEKyeVjqr9IBEMaiTfPer2S/X+ERTsCjcV6h6wfi0j3Eq8OLmB0qTudWc9TUA
         X76//k6WhaS/e2bWbFid+h0e6EmP3FgPzR7fQ1Jm6Cc2mSJywpLdkAmNm/HRun7nAQVH
         0m6Q==
X-Gm-Message-State: AFq9FYKrA5SHnt0pYtvSeoFlvdiL7aRqQfDV3uDmOETa+mSaOW7jUKDA
	/aPAVDd8PJRIh2fjBMO6tp3DHGq99eV+h3zPhtVh4XpWk2RmtV5+pVV8
X-Gm-Gg: AYBFou2WNkQ4Oa44ZT8ryTvqJ9gYo5ap18LyU4grEbx7ICL0aBhLw0KXTIGnYCvgvFW
	DNsISR9Hs6mLPrI9WJK3+16o/SROanqMuXH6JwpbtHXIAzsAVtPzRsvp5FMXu7uTqU2uZZqEqOj
	xTBvQ64ZNTIkfYGlg8tls2u6a0Ki3UEysKh5wKicRSZEnZamE4VHmy5Vd7fjSUp3HqCqq4HkBYZ
	yLnLolRkyTZucRhTLxcpfthrmZDPnTYmfsvPxOwYZE7/2te6LlfZtn+sKELcCd1J1Jocw6oVIGE
	hHTD3MNq1xKSSfWYdqz5fpvh9z1hoZ0XhipCP42OQPRUIDZd6yRCJqtzVdSsSvs22SiC+63+s9h
	LzPrAgqmMauG2LHp/25pevofYOXGnuPDZ693ChxMnvPFhcCfr5rDWcp1+h2hPkh6q97/GMzKk/Z
	durLeyc0kayQQ1yJjdqFefoDXx38uF6XOd9TgxCece6FyjxxmYRfNvCmwAxXBo6yZq49RXHinsX
	e9onyNGCyalPOruuhm760O73yiwQxQ+Nar4a/Sz2k4p3mt/lelHQrXOr7VPCIx643tK+YyMBgLU
	prD9tzGXu0m38cIPF1YgH/CZ
X-Received: by 2002:a05:7022:3f04:b0:19f:527d:96da with SMTP id a92af1059eb24-1ac5da7b145mr2871629c88.33.1793361166266;
        Fri, 30 Oct 2026 04:52:46 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:52:45 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:53 -0400
Subject: [PATCH bpf-next v2 08/22] bpf: Remove dead code through the patch
 list
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
Message-Id: <20261030-bpf-verifier-patch-batch-v2-8-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_opt_remove_dead_code() removes every range of instructions that the
verifier never reached with verifier_remove_insns().

Each removal moves the tail of the program and of its aux data and
walks all of it, so a program with many unreached ranges pays
O(prog->len) for each of them.

Queue the removal of each unreached instruction with
bpf_patch_list_del() and commit them once.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 1a1a374a076b1..95f4fe5d607e6 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1018,21 +1018,14 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 	keep_funcs_with_addr_taken(env);
 
 	for (i = 0; i < insn_cnt; i++) {
-		int j;
-
-		j = 0;
-		while (i + j < insn_cnt && !aux_data[i + j].seen)
-			j++;
-		if (!j)
+		if (aux_data[i].seen)
 			continue;
-
-		err = verifier_remove_insns(env, i, j);
+		err = bpf_patch_list_del(env, i);
 		if (err)
 			return err;
-		insn_cnt = env->prog->len;
 	}
 
-	return 0;
+	return bpf_patch_list_commit(env);
 }
 
 int bpf_opt_remove_nops(struct bpf_verifier_env *env)

-- 
2.43.0

