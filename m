Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C931B123
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141888; cv=none; b=txzfyZAjNGbelueyoZ2C3GlCOQCmOjyc0kyMp4A2wD+o2iFRiXzmFOLjJkymiatFIty9yW7Kd7M8+AZnAFljUV8nePx3Pz4OEkWo05YC3kh1JaOcmV1ObGneLk/ZN5w4gwrcfPs94t4K2OXB1k5G6r1mWq1VfkdZRGW9dwoN5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141888; c=relaxed/simple;
	bh=hMzeBTEJLEiYo56GsDXIp46jvdpyhOOAnCvCUyFVyjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n34/cfqar5QLskN3W+iQSppQlx7uAunOjxJYUQZgdbDSAhdR54RCHudwava8p69jtlJBxDF/a1Qtq9ukNpKq6TEbgxCkeRnrDSV2ZeLETITFQ/ZDiReb2/tbTJGKlygRpfh0NHsscIBem5Gia8eSUZCKdpZPNPy37YADeP9xDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=PtAN3ZEX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="PtAN3ZEX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6d76b9145so638965685a.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770141885; x=1770746685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaiEkcUh+ojAU8l6RgYAI8/eRP/IcL3qagF3E1r78mo=;
        b=PtAN3ZEXHU9tkWS+ucW8nhI/ONffxVsRhBKClyycIgPIod5Os3n00lRrkoN5lluniz
         bMia8flXswc/yssZ+mNfGL+Ff+WZVI3MCbuOeqWUlJpbSrdNdemEtblYmUGU+N0LcGud
         ZbW2Y85+6uzW+WKfpj5y8z81A7am/ZQ85l+8cJLwQbUesri67WH4r5j8PHCyWBjwDQmg
         RqIiOFYR2mW20RTmuRSYisnOsEu+Ok8yp3v3JvXs68441lafkRoIBdTQ/IuXXifNi5Wl
         kTwJiAyyCfv4NxmSuENUuek6c2y8jppnoBOuwHSt82Vd7uv3lS1QE80hxejj6AmAQiev
         UlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141885; x=1770746685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaiEkcUh+ojAU8l6RgYAI8/eRP/IcL3qagF3E1r78mo=;
        b=FV/pLbyUxFmqngZyCK5Oj0uQj6uDcRPVHlXsUEUEm9dxSEaiwDsHAC3lX+WYc3FgZx
         A3/EToJQtMW5tMzS9wvVok67nmBI8GD6xMMojBLyAKRMg3EJasoVhTW0GNk1O16bwEN7
         v2fxrphFnTQ600BxQ8zHox72trd+qNRKOSbb845yb774XyhieR/vyjFMqt5iuIO+xq+C
         1fK5k3xeTa8jHmnKJl+PxNSoJFtvV+zdYXckcCrlOeBgcxy6e77I9iOGtXpdhgXnzOTK
         0U8E7mayfNXXer7DkQ3FzRjxMZxl8TzSi06KKEEtncuzNxdDc+g6yhp9efZ4tkyOX/zr
         IdYA==
X-Gm-Message-State: AOJu0YyrhLonVgUbpP0FGLQvSjJtAqRXjCRmXJrbYDcFZPCSQ2swp/kP
	+4EfIt2BH9MA3zsaoNUJTfyZKegjjfxHn1YuEEl74hgalTc+b1TC28kE2yG0bEUcdsA4UWoywpx
	DsshU
X-Gm-Gg: AZuq6aLXzUKfXb4yrehtHANu78pcR0/nndlnZF8875a8V4+JCe2Yrx3dKb51qvHaUCj
	p+CsfWfzFGzTCPqjXWIWV/j/fJsOv8F+qhdAV17+x17lL7DdkRSd5PnrxV0SDiSYkWta78kzFZd
	TUHuIs3nML/8RePik+T726x686/ep8Egr+FIAszaRfZjR6JI5K+fEJ1eZXYc/NVlTsXQECiuuhr
	eR/ebrDXflWbBY0peBlkNbcDjtI29DeVF8SpM/OzBcPGVTQH4MxUZe+pJ/Y+CNrCrneAlp4Vdvl
	PiKJiUPmLOlebii8kj7LDw+BXM10v6M92jRaBs34lQe+TohoHD9vpNJKbNSQm13BpPDji8yJYua
	LYDfoFqFKDeXOVZ4cTLydmJim7NBt8cTYCHPMBiUq7IfhkRxK3cHviNyCcaGnNXhkfKFaxbCJ7e
	M5qqMS1saXLQ==
X-Received: by 2002:a05:620a:25cb:b0:8b1:728f:952e with SMTP id af79cd13be357-8ca2f845196mr63651485a.31.1770141884799;
        Tue, 03 Feb 2026 10:04:44 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa8144csm20469185a.14.2026.02.03.10.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:04:44 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 3/4] bpf: Allow BPF stream kfuncs while holding a lock
Date: Tue,  3 Feb 2026 13:04:23 -0500
Message-ID: <20260203180424.14057-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203180424.14057-1-emil@etsalapatis.com>
References: <20260203180424.14057-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF stream kfuncs bpf_stream_vprintk and bpf_stream_print_stack
do not sleep and so are safe to call while holding a lock. Amend
the verifier to allow that.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b62b6d57175..90811fb39974 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12438,6 +12438,8 @@ enum special_kfunc_type {
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
 	KF_bpf_session_is_return,
+	KF_bpf_stream_vprintk,
+	KF_bpf_stream_print_stack,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12516,6 +12518,8 @@ BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
 BTF_ID(func, bpf_session_is_return)
+BTF_ID(func, bpf_stream_vprintk)
+BTF_ID(func, bpf_stream_print_stack)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12960,10 +12964,17 @@ static bool is_bpf_arena_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_arena_reserve_pages];
 }
 
+static bool is_bpf_stream_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_stream_vprintk] ||
+	       btf_id == special_kfunc_list[KF_bpf_stream_print_stack];
+}
+
 static bool kfunc_spin_allowed(u32 btf_id)
 {
 	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
-	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id);
+	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id) ||
+	       is_bpf_stream_kfunc(btf_id);
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
-- 
2.49.0

