Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A331E844
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510617; cv=none; b=lHaPi0hKstWM4riLlIQWxJUq6AOS4g5iejQwzUOfITpn40G82k2NeUOAMrML7S4X3hhL8On5CjI7p4Fz1XVGtkjPouhfLgqFm9ltkSo/dvqgMLKDatCkI55c96YZUBzzQJtTuywHPFd17FO0Q04Xn8rkAMlx/FlxY1Yrxt96dBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510617; c=relaxed/simple;
	bh=om+GUUwBH6ToUbY7jlQ4dCRdnqUsjvHMbCMe/jqcWHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kv50xZ6rYxRTfAuJvJYiu+d9wlaBptJ7N6EJMeIM3dIdLNO76+972bRpIaz3delsxzbFTuBOGya6eHVhbHVjqyXHOMf2cMFErlPsHO7vdtbrC0DL0lR3rBj4gXLPkb2aTtf8uGcw6uDHXNQR2ly95Y1HSjdedUfNPkKUdQ1205g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYnRVJgf; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYnRVJgf"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33e6279a1d7so3949663eec.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 18:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510614; x=1792115414; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lV+huXTZ0xAteNiAHITrqOnDsRbJzozwdaHfD5FZYMc=;
        b=RYnRVJgfmZjR0MfiaMShD93coy7/vpnP9Kd6hqtIK6bvlvCSltZ7cug/e8SlSzOpZO
         GyRSBH9Hy1GCJIQHRsZ13AQyK9eHmxPjW9HwD/boqfIVFo3iM3KLdnnyBK9m9xh4bURM
         vNhmWsEjRXI2sF0g2DTgtKdU77W6zhaquANGicZWQKv71DWn+WurZxMZkxDtjuRQw4si
         BbvLIPmf+whfcKdWsx1ZVA2KqI8dtGf54DjkwGoCsXUcbnkMGX+bXfqnbk+L/aIDqtom
         xbcEXhefFJmzPNMJESF7aDeRm0I8q9REJKmkPioKs3j7DHWvbtiabSGh1B2m+G6mn27q
         SArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510614; x=1792115414;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lV+huXTZ0xAteNiAHITrqOnDsRbJzozwdaHfD5FZYMc=;
        b=Sl+p6eTbYtYRIeK+xsXg56TBSCbKpmGp+WV0R2FuVGn8ZNwoaP+XHjyeb8lTwIGRiH
         ElmqGLDb38iBx7C9DImovcACDuhGD8RF8OVTGUyjCgmK3oiFrEPNjgPcd3XwV9hDwhPf
         SefIiLG/EjTxPXTiPnlFo1xm9OzFyiOu6II6XG+U9UxdU40jewFN5My16hMYkHYS6PIZ
         Mw962/1kiGr3bERcCJLWv82VKqy93cYJGEMug4m7LKTUzQHmgEplu9A/7bzMzKuc5F77
         qyRo6Mn9PkOftvVeJMVUm50NRaCNDMcpaP1kFv2x9agEx6juY4XEKwJaAqGmmig0BoEu
         47ww==
X-Gm-Message-State: AFuF++l+2ObfTeEfU9WP1hyDgwZsPpknWigKz8KG2TdL6fW3gGshdejL
	o3XNaQ2B6357uI/ygaikBShX402GX+hH8AjEmmL51Fyglc5U0Tm8cNRI
X-Gm-Gg: AYBFou33XDxjgOD2dFlx/4pdyEkCGRXPYF01ebkJTQiupXiAiVJv43JOQnwySgqlLPJ
	Rm4MmlhKf4k3V/QKBdsm6w4DNjoIZvQAPCJhOdaWyhslc7oBcyo8gU+Ou8NExobbVrYZS/2jzKu
	QjZuEvUlseVMbhiBW/Jvsq9SVpMdSLZEQYCug163+kPvoGOCQ/q7G9gL/Y+38dYaCcPkgrLLzGY
	FpL/BHTnXDuajcjntxtklTb45eS2yR+vero31JwUmgS7J5ibCjNh1HKzmBmulzjCpf6mEo0Dz8W
	YeX2n4AUOGv3zQkVN8DskKm6L9Sj2Yf76rZwn0SiO7amOtjNLEIphTuCwbSiiN2ZFyXtEsrlJk7
	jTqe2yp0EW1zR2LC6PLnt7B3OWz6UF8Luo/sXMcVKsqa/CpvSYGZK2C4BjbpnOgYvLR0R9aQrfH
	pHbQD7rj2mz2TPqaUmeqGaBCqGKYQowFrFQm8zYYeloztORvUlWaKzox4rsMAUcCszqQ==
X-Received: by 2002:a05:701b:4588:20b0:151:ceb3:e0f2 with SMTP id a92af1059eb24-16a64aa0fc5mr502094c88.38.1791510613961;
        Thu, 08 Oct 2026 18:50:13 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm2015555eec.27.2026.10.08.18.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:50:12 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 09:50:07 +0800
Subject: [PATCH bpf-next] selftests/bpf: Run tc_edt serially
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-tc-edt-serial-v1-1-f72e045f2465@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE5IyGoC/x3M0QqDMAxA0V+RPC/QirrprwwfuppsAanSBBHEf
 7fu8cLlHKCUhRSG6oBMm6gsqYR/VBB/IX0JZSoNtas771yPSjMbqSl+VkaLSJPhjYQZ+9i1gZ+
 eX00LRVgzsex//Q33nmg3GM/zApVBAT13AAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

tc_edt shapes the traffic of a TCP connection between two netns to
5Mbps with a BPF program, and checks that the rate it measures from the
userspace sender and receiver is within 2% of the target.

The measured time includes the time the sender and the receiver take to
run. When test_progs runs other tests in parallel, the sender and the
receiver compete with those for the CPUs, the transfer takes longer,
and the measured rate falls outside of the 2% margin.

Make tc_edt a serial test.

Fixes: b0f82e7ab6fb ("selftests/bpf: integrate test_tc_edt into test_progs")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_tc_edt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
index 462512fb191f1..1e82d88c987a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
@@ -127,7 +127,7 @@ static void run_test(void)
 		  "rate error is lower than threshold");
 }
 
-void test_tc_edt(void)
+void serial_test_tc_edt(void)
 {
 	struct test_tc_edt *skel;
 

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261009-selftests-bpf-tc-edt-serial-9c65af71f845

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

