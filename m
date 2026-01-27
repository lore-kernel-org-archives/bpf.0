Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF83254BB
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537793; cv=none; b=PC34OdSEv8Ib+3dPwkrthnSaffjV1cCbtHD53nsYBsnIEyZshqp/Zvoxq9gNr6Vq4PTpKWHzEehHwTXMBAC3cAxvSvJw6BfHbvNtIuR3Gu06XCDErWBWobeARc1MIINk8RqVDlnbEhCki8IYh1FqKU9+3prY+Hp5YDQ5N/uFW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537793; c=relaxed/simple;
	bh=wzKiGmkMfcQerF4zaNxCkHDDB/3CFSlVH4v6RpPmL/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDj6R91zYZKrdouYXrC/mKHu3N+tmKB7+g/btKkRE3s31b0K8a9pPPVkgOFv64pKM6kLDCzWxSmsEgBRcPlAQVdPrM0c3FUUQsL3hTtDEp8hGiCHGeTkIok5zZKVdgtrSaO1wfFTpVHsSxSd70g3tnEXWdhopXaNpRV+I0Jsdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=VVgBzINw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="VVgBzINw"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-502a2370e4fso47327341cf.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537787; x=1770142587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/3N8OPgk+fTgPlXQIgpKIF84TLh4DX7ZuhUv0KfwIc=;
        b=VVgBzINwaL9+9gShdmz3pmTe+lDEuhN1/UCYEQjtFfGZLFvO4IPOUvcyryWbiQf+py
         efo4bdcKgxfcKMw5l1G5VYO2fx7LjDE0BreIDHeSbz3m5kgucLkc6WxKrxRxhzHrGO/J
         hd5AWYeSXBmTDs5TZo0oRbEaaLHIab3kY0FvgzzgxsXh6SSsecNDBCuY07fjZTEAXkMW
         vYCIWpjJeeyhnALjIVh+Uy2rMLIFHEau6D3NC3zFBlp5PJlJLp4eLWibOS9tqfOPeonx
         Wl5cuNxpBAMSlUFgGaT8vhWc9SzQ+SLuvKPCIdw4R5bOmutQ+qxrzbb7ijyh04YhQRuH
         3QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537787; x=1770142587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/3N8OPgk+fTgPlXQIgpKIF84TLh4DX7ZuhUv0KfwIc=;
        b=VlFnsGbdcdtWhzOenKn+O4qhBNoGLCEjBZz9EphfIcjAnsvdnPWwFsNONXrb6vMJim
         KI53Eb4pvL0uSjh+kdWqsVr9WYnmht1fqZ/shehsDaK9eoe8Vn2wwrilX6zYaVw/FlVN
         AmCCQ9gmwNtzGmxskKU0aev9hLYfpEwsvhxHVP52aETlDvZkh/drYu1zBx6xd7ri0a/l
         HY/as+poQYYvDABnrVlzaaRkPAGvTSV5s8lxaVfTxOk7taBPM72Ex2iVdByEwrWgsCt/
         jlxUi0elTbE/7YZL+tmDJXQPVW3QhCmbg6m83cboG0P6su9GViX2TVQR7iltbYqa65tS
         S/sg==
X-Gm-Message-State: AOJu0YyAf5nDGhGtL05wZIVI2Z+ZoP0dLtGJ6czhDVIz8HugPJ4eSSiy
	pA+ohSiyBpwQ74V8xbg4BhdRY5ob9rt6eaDRkz7+Q0mPwhxz9Gd0JkFNmvHMGL9vNdIoSScfaZI
	Emh+n
X-Gm-Gg: AZuq6aI3sVWUJ14VOxDi4lkojICgD95S3F/sE2ebPNyZa+rAwBBSqNFNx6WVSZkuqSJ
	f6iOA1hM/oor3D/l4iGSG26/jJ2jIOwLfUOqwnyNFCOvawOIJkYJJDuvYCnPXvvYqa9/uMlX6W+
	h1wio4HyiPwn8oNkLh6Wa3N1HCxPVUBiKa06QZMFV2A4z49sz2ixrChgdpErwToB1uhJzp8TZzq
	kOxFELQfsnXMIn75YlE4u5tSxYXAG3E3XVZUw+dtEBEpfgsl7fJS6dxWULJCO/ml9pz61aI68Gu
	uYA8BlMhntdXaT5nl3d8w3kCHs6d/yaxIeVgaNqPE69GbcEfM3ZhEm4HuPiOyEJtTI3nQg44hAU
	zdAiAipNbPHGY8wWsL2d+TvTpjOPNN2VE0j1cF+PaXKx6+UcVaYdQOuPy7bJTBhSn1S3fWph1h+
	1i7Tdv5MEpcg==
X-Received: by 2002:ac8:5801:0:b0:501:47f8:982d with SMTP id d75a77b69052e-5032fa00f9fmr31697441cf.52.1769537787194;
        Tue, 27 Jan 2026 10:16:27 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:26 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 02/13] bpf: Allow BPF stream kfuncs while holding a lock
Date: Tue, 27 Jan 2026 13:15:58 -0500
Message-ID: <20260127181610.86376-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

The BPF stream kfuncs bpf_stream_vprintk and bpf_stream_print_stack
do not sleep and so are safe to call while holding a lock. Amend
the verifier to allow that.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2f2650db9fd..b7970537eb41 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12485,6 +12485,8 @@ enum special_kfunc_type {
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
 	KF_bpf_session_is_return,
+	KF_bpf_stream_vprintk,
+	KF_bpf_stream_print_stack,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12563,6 +12565,8 @@ BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
 BTF_ID(func, bpf_session_is_return)
+BTF_ID(func, bpf_stream_vprintk)
+BTF_ID(func, bpf_stream_print_stack)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -13007,10 +13011,17 @@ static bool is_bpf_arena_kfunc(u32 btf_id)
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

