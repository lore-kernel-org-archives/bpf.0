Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19162836E
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779552033; cv=none; b=aXKpmyI1h6G/qT3Fdj3s7zOYCAwYmZZ5u/xziJM5qx8lkLx2e+OJNBdeH3ANWqQm83dVUn5RtmIBF68KC7RdJ4S0K8A8FAeisQrFMG/q8ddJ2qRhYZPXNdGbyihjVC2YMHXSYDvy/yUngOe2S93D4Uwz/7GYKyBXoVpdR6MVttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779552033; c=relaxed/simple;
	bh=D/x8usnB5ajIhBy2PeUrrXP7yx/0Jn19puJ4vENcs6w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YSC+iwv/PnV1+wzY5Tfe7FL+jBoUTQznsfXR9P5u418d1TClCZ9sjktPR+qR2vBSOqIJK7Iz6oXRdULlQeIGXfUqoJvv4rZld9m9EJGAIW0y0sRg2buI60hzHZdzffRiLmNf+CDHmjhP5UolEhpqAhRtDuujSjJxJQLC+a5WAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XLzVWfyV; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XLzVWfyV"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-911796e9885so773824985a.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779552031; x=1780156831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FWD7BWDYZBw/gKocdgdJ5q9U2RLUzktkAiTp++3aV34=;
        b=XLzVWfyVUMwSpnKLdHx5faGFeCarIYsQTcZEQiTwN3YdsMw6BvuKa8q6QymdMajT99
         fR78me0olx+bxj6cMuHaluHl1WMAONxSQkG3TMwKnsB+AUVsRy9KZRsUCXyAMVWFH5nm
         rNhn2602+AZzvzn8Z20IuQ4ELayNim91eLDyk3IeH7EVX+H7l8lbus+KRlDgdDd6mVnD
         vQDt5QHiMIy1iksQCWWnVkLpy5qs8Wmy06x4PZC9qPsVtC9kToFeljnfduhq5P+P2jm9
         mIE18kNJn4eJ/dWSr+CRsCV4v6mJf9jWeZMs4BsoMxwgMaOWG49FBg3kzlLFTKeLPBAU
         Tu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779552031; x=1780156831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWD7BWDYZBw/gKocdgdJ5q9U2RLUzktkAiTp++3aV34=;
        b=EnTujdlHigUeZefNUm+ahs1igjP2B7Ae7lTRzIRi63ulLp1szDy+ePymAGuE9JTxlV
         WPsG0RGaoASQsJpNz/WDNDkATBhU/+janpP4Dq0FxJp5CcHQRSRpvTwgy3Kw3AYGHklt
         epjjc4bvHfgeSul1xJuNS+TOpm96pw8wyyt8omr80M9WZN5ma9YGXT5D3gLQjjmBXxEP
         avcAyV2CamV0JAAPT1bxBWqzomIQIqONUhByGf56w1TN/McQvqc3RpHbeKYgIJDw5jOT
         GuR/7Ue+o4IUvojjnVEbrhxl6q7BLjHH0+aDHmAKNV5J9cHUWAuL99XmRCvu2Hk7EghM
         anHg==
X-Gm-Message-State: AOJu0YxbyEUyZmyQbAcK7PRDWY4TrDf41h6TZ2y5aoh+XbR/yuL077Yg
	koWUIRAMFaSls3wh7S8I6ffie8bdkr0j6ibMoPv29kCh3X1CYpF3PVGbTO/AalMxqCVopnPev1h
	Sd6RiPm94
X-Gm-Gg: Acq92OEFfkZmjLhhml/y4AYM4wjP0XyVVHPyUI1L4gyEbwgVc1JlPrpTosdgTcpm9xv
	xythNFFWkQLcxCQt6cL6WdplGmHJKav3paicm0X8rAif21ByVz10Q9iTfvHr6CP7BDP7Yep/Chn
	eAeHWxgv7pnE3+GRnDiCFyUxAxz7BWwsePbWbNiIsJEWep4LVZ6Ern1h3LooNe/hOx2DzG/ucz7
	3hq/fqs7dRJx1NEABl8ujS2kbFbHDlgA38ft2QC3QSAZ7Wj59fxTAH1/IVHD5JIJoG1Pgr2p+bT
	A8XNL4wI8G2nB7oTI3JJa8mDoZE6CuEWYmLK+4PANxmvAz7hEXwLNm0WtrbhT1EIs8YnCHYG8r0
	+hqPEmdj4xE/zErljWW/uzoOwkh3Kc1fkTM8f1rwplPHOwJC/NN7A/tz1GeF6Cfjvv4cpVu4Rvh
	c2m8wo2DBPtWHEWDakjAsa2zuZnUHW4Vev7A+s5WvYVImB3jC/XJMPejxYu+E=
X-Received: by 2002:a05:620a:4511:b0:911:7100:86b2 with SMTP id af79cd13be357-914a23a292cmr1625172385a.22.1779552030566;
        Sat, 23 May 2026 09:00:30 -0700 (PDT)
Received: from localhost (h7.113.131.40.static.ip.windstream.net. [40.131.113.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb906fb3sm429773885a.19.2026.05.23.09.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:00:29 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
Date: Sat, 23 May 2026 12:00:26 -0400
Message-ID: <20260523160025.16363-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=paul@paul-moore.com; h=from:subject; bh=D/x8usnB5ajIhBy2PeUrrXP7yx/0Jn19puJ4vENcs6w=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqEc8ZgAKD0VJTH0uL4NBeAbLYbYm8H58uih3JN ohWO/MMflCJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCahHPGQAKCRDqIPLalzeJ c6qKD/90S40zZWZS8w7kqtjvvhazaPuufM/d7pvzKsx6KFwVlyRdi9VPTPUVJB9AoSSCa5ondr7 agjLNvwsxWQ6jn2VGv3YQTYtKX6Aj50dJO9ZxKMsA/LnCio8opHg6nuxyHqprZhMrxQeRMyfSEq fWwbG9i1wQDNe8Sc+3xP7TgXyHkX0VnFzwhxSQ5oCJo+opb5nPWMb4ZNwj1EvaHfs3LVTJEUmA/ xP6ORZDh19Ywa30Lbtke1ibwPB9908Vrqzposr6EfqR7chcupPEevYBuRfkfSYKcoPev9JaO6Fd GVAmQ73r2JwjZMd3309QQB6vg2cgu0NWALYqgPGrDZktvkfhPro+dhbNPyKyrSQmudAgtqbBuzT 02GBENtqU4azqYz0FnS+6xc9IqD42qV5MF8p1AhBMnLwf18ZEsTKFhMpYWnv74EvVXzUIBVyUna fnGaaY0yalj3z6evqCfkKfL4TkqqwGx4FyPXQv5jEsPSCTg7gyJ6L/QXJAra3/S/QvCLiKjVxD/ QNEO+ta2iTM5BXuI2IusU3pp5VQ9YVzX84A2jq6n0cqG0NH/svJ2OceESsQQ8xP2q/aadJdNc/o /oZBE9isDkKtAVfgsb8kV/LnUfJAj56/kmzOkL7EfSXyGFMM0G+oias5PkAU2TLiMOdMbUx5yd3 Gpxe1OQuncv9Mmw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

If security_bpf_prog_load() fails there is no need to call into
security_bpf_prog_free() as the LSM will handle the cleanup of any partial
LSM state before returning to the caller with an error.  Thankfully this
isn't an issue with any of the existing code as the LSMs which currently
provide BPF hook callback implementations don't allocate any internal
state, but this is something we want to fix for potential future users.

Cc: bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 kernel/bpf/syscall.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a3c0214ca934..ac07280098e9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3076,7 +3076,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 	err = security_bpf_prog_load(prog, attr, token, uattr.is_kernel);
 	if (err)
-		goto free_prog_sec;
+		goto free_prog;
 
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr, uattr_size);
@@ -3122,8 +3122,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	__bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
 	return err;
 
-free_prog_sec:
-	security_bpf_prog_free(prog);
 free_prog:
 	free_uid(prog->aux->user);
 	if (prog->aux->attach_btf)
-- 
2.54.0

