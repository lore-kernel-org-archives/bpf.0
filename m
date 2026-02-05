Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA235D5FF
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274944; cv=none; b=MQsC9eBXwz6Vjx5UodAcIpfHGBDXoCwQ3P+1THiXOd0CFEK9fPAL7kxuNv81/6qMDZdmBmAqGssgZ64xHa/5wj5F/CDZbQslaggn9l4Ic5WxfaNFdLTtt2946xmtR/pqvaalJXKjaIPb9us3n7w65v2T/BgBXyZg0ZJabwl2sK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274944; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caoo9iq0BHCfRrX6hBDRi5chA+QA+IfOOoHZCT8ID3GDsgbBCHO6PtLLCJ8KtTFWzmhr5oEfNxzhBmlPew0wJu8qjq3W+DcmEZTeoJWXrgBBaZG2xwUnTLIDRKoWMcKOe0abc+hWq0yo0POHx9hNqwB5fAykGyfCs5K6BVMM7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcGiwmNp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcGiwmNp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82310b74496so299595b3a.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274943; x=1770879743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=LcGiwmNpLLMOqVK3PAxbVWuV+cBzwsZ/KZwXXE+HEtZI6S6VnIFMqlmNihPnm/UGw2
         f11OF1w96HFHl5XeMZ/PjCVpvmsci80+BmfaJkSG2pXHzmVkmuxdu3H3i8sbt4oAoL8e
         AZoc3OtSXFU9g41qCd7Wh2bftqzXM5NUY1FfbVTMxmoLFgdXfcbXvTnvjsAd/3gsbosv
         9eZrLQdsGJn0vsdcTr3HtscLwxNG/3+DaWm4h/WTNtdvCsLPZQFGMNOFRHtlkgQQVkMw
         EVk5Uv3Kto433W7e+VeiD9LFeMKRsAiGRGJ4Bao6whTodvgTu5NL+dvIM51ZpSUKWY9G
         OFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274943; x=1770879743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=Zj/VywYYtQjU1WA0qMVMwDApHhSGLeC3mkqYyoCoZPx6VGpPNOk/DBPtx0fa7MuW/W
         KYZal8nhuDvkBVvEDXcoR2fken8Lq1JhZlEauxDNoQheu9WtsAozUXYpj4yEE1wHMutI
         krLNitu2CwOVeXSkXVZ0asTTG4lZ8BMtWwXZib/crN/CZ0LTUq4XSLkV5TURS6W6m/Wa
         gCCnyplkKR1o9MFA5d35mUYsLQXCO/2xistd7YD6k+gTe+HOLXHJkDY9/U/piE/C+dDd
         6jJnasiNBZ69eGCx5osBNyTfdwelpfXrIzlOV9AXSAz/J27yyucXKI1Q6+PIUgr58ZL6
         q5Ww==
X-Gm-Message-State: AOJu0YyLMuA9Y4vEieIW8G5Dqw9cdGsoYxuuOla/nsO7838J3KXhtvp4
	TeJenxui9q+UApVJX1hUBcaeb2qLJEaO9E9/11diho46OSlRaZIbPvLiwOJxDg==
X-Gm-Gg: AZuq6aL+VzIrL70okvkSgff01uMjn+5KTW8fQjYQfVaEwxxtUvGOOJGcAtdoJyBrLn7
	tYFyQCRX2/QSGrYqphibeZBkNXaCuCBiocGJOfshiH6tqRJtcisqa1ymnssNQUDSBkAjPW/Dv07
	XFfgeTKNkvhUm6I0GpT9JUW6D9jxviRIPm8z4r8h9x+i+dkrA67mFgsI4SaYg50gd3+cB1BCBnD
	nDuxjFx/WdKjCXebmLbSQvIXKnY6JSwkcGJj/8H4v3MDCwaoAsW0hT7b3HDKJeBnVBdAJMNisQF
	/XHHTw/QmD7Cz2OLgn97fS620j1lWcf/NlvaCk7jtrqAh5T9WN0kbwmuwThhMJh/TlriXSnZrZs
	JnHZw1i+cgRMkYpbFWPl70PBSUFe8kCYmtM/lBSgAaLiKShhus+3ynzdVdUBbG+KvPkytf5OQUo
	qI
X-Received: by 2002:a05:6a00:1949:b0:822:30e:d15f with SMTP id d2e1a72fcca58-8241c1ad117mr5121907b3a.6.1770274943191;
        Wed, 04 Feb 2026 23:02:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4ba97dsm5254454b3a.68.2026.02.04.23.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:22 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 12/17] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Wed,  4 Feb 2026 23:02:01 -0800
Message-ID: <20260205070208.186382-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check sk_omem_alloc when the caller of bpf_local_storage_destroy()
returns. bpf_local_storage_destroy() now returns the memory to uncharge
to the caller instead of directly uncharge. Therefore, in the
sk_storage_omem_uncharge, check sk_omem_alloc when bpf_sk_storage_free()
returns instead of bpf_local_storage_destroy().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c   | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 46d6eb2a3b17..c8f4815c8dfb 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-void *local_storage_ptr = NULL;
 void *sk_ptr = NULL;
 int cookie_found = 0;
 __u64 cookie = 0;
@@ -19,21 +18,17 @@ struct {
 	__type(value, int);
 } sk_storage SEC(".maps");
 
-SEC("fexit/bpf_local_storage_destroy")
-int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
+SEC("fexit/bpf_sk_storage_free")
+int BPF_PROG(bpf_sk_storage_free, struct sock *sk)
 {
-	struct sock *sk;
-
-	if (local_storage_ptr != local_storage)
+	if (sk_ptr != sk)
 		return 0;
 
-	sk = bpf_core_cast(sk_ptr, struct sock);
 	if (sk->sk_cookie.counter != cookie)
 		return 0;
 
 	cookie_found++;
 	omem = sk->sk_omem_alloc.counter;
-	local_storage_ptr = NULL;
 
 	return 0;
 }
@@ -50,7 +45,6 @@ int BPF_PROG(inet6_sock_destruct, struct sock *sk)
 	if (value && *value == 0xdeadbeef) {
 		cookie_found++;
 		sk_ptr = sk;
-		local_storage_ptr = sk->sk_bpf_storage;
 	}
 
 	return 0;
-- 
2.47.3

