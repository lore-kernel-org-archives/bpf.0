Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E52F12C6
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060800; cv=none; b=Qf50gDR1O1Q2RI7sbUhreqAb9gQGyKJfQvjUk1m5abje+ZTkrC6oJL5AGegFHko7im84kIKbBEStDJvjCFU/tWyKDBOyj2iE8cEuHpLJR1TyAAVokiFUBPiwEGGZwluuNUMWBwuIS1fgXMNOzhN1wjywHdnP45TWTDdkz/8V/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060800; c=relaxed/simple;
	bh=cUkcX8+IY22VCTUnPiyF3l8qkvZh2L4EpohVQKTadPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpBdyUSjZHqJNdPkYVl4TyRLqiqn5U7r0HC4eeN0aLeNacdLxMKfR8EJRpxeA17tXJYVB6fG8mRdX0bNRmhrt5Yek1hS8gp4nGGtjwNNOM6RjaJc5xOA/LQe9iwQCHJr44UOcWvrLw5vG4pzoaHMLqlUNhYGiVUbCSWMFk+kteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wUJ3SO/N; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wUJ3SO/N"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c07bc2ad13so366504985a.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770060798; x=1770665598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2ufobzpR3if75CONQwtLb69fNhmnD3Jc5fQ0rfAai8=;
        b=wUJ3SO/Nbnd4WH1lCmlme1VEshw9rq+8aybHkEzOc7QCXXDcdFeu4Kzb7m25aWThD9
         1zyCiMQRwj7d6tXczAyhj6anPQvlzm9EBIFUD2vETmNwe5aGd9zEhFucuBtlBKKx6dY4
         sOB/6PGUf0Oyt42CAFfGjApnErF6quZWYNqI9cEzSUAGJbClsY6iMa6AnTVa0DLDzL1i
         eqqR0p6QoK0pUbQdZJVYbUzQYA1Rw8jK268RBuIEzzdikr0AhMA00LCp918pRL0QUFgK
         u+/TqY0lqt2MwN/IjY5z8cumr3STifer2/E2HBrVH0+Sw8tIc58VlA9QL7Wdw7FXcz+b
         zQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060798; x=1770665598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2ufobzpR3if75CONQwtLb69fNhmnD3Jc5fQ0rfAai8=;
        b=j8cGSxLa/mNurdZH6fUEtJu78l8dCw+L22RMLqv3Q3a1OLbZJixJ0rQb949rmF2yln
         vLMlB+dvsdkZaCIgo2iSgFjOqj6DojsUSK1gvBAzcrLm6SsvX1uCQtFY/PDQohVplh9N
         vWNPt/8Z3EO4iEzCUlgbc8U3iVtShtFaXsG6TBcBn5Uix/FpzTX4m2E+SA6tjHQOnmu1
         eGy5c0BsVkqgDtmk++eBDHoxnxbUmvVBbYwVVqMLPZN10wfg0SDkl12T+tSMzjJw3SQz
         pL6PJr/3Lv4RfdtHKnZKiqHV9L7qZdg8xa0V8uvtfD1dL6au0YeK7mXTFxKQexBauXne
         ip5w==
X-Gm-Message-State: AOJu0YyLk57JXJiSnFW7kM3iDtCZzkCev6oU5P68HrxD+XHbRdb9JfU+
	VZYFI4WWW1Rl/vtvaSQv/qDrmBm10A2X3KJx3Z7TwY93ZCDcMT+EveNGKi236MB/WRrnIbyVYil
	VZE0I
X-Gm-Gg: AZuq6aKq8g6Mwo1EK6EQSB2A84JQQ37Yp6tX44fPqf7eS2LbdS0Lc+VNYoBLgplTJCg
	gZ6soB3pXLH+122Rbx/tki4hqoMXOpSpDsBjbXg4mNUzp+nXxbMDNhaWsXl7B26FhEKerENRqjG
	jM4vlByqsZ/LrPZj3nUcF/796r7pYQN+qTbQ17UtfNPiJSv3wifEKwLrBUNWIfAFQvWclcqc3Sv
	Tx1NA4GVtsT+u0V/ge+ucwHGIRQ5QxgZkQO1cZQURbxU/xO3qc+yCrps14a6bLWArJBVL9cF19U
	AJqtPbsDfhcHiFofqd4t8G20gK5yrkTdcNm1pc0lZiU80iZBXLpK298g/iwDuFdSeN3dYAM6vfH
	Q6dchRFYvhWbd4DcA5VmGmdtaSJeWXzOShmufia/hkqL6RK5MSOl0tr0sz85JAZrePeLEv9BEse
	CoL1PXlzcFtQ==
X-Received: by 2002:a05:622a:1351:b0:4ec:fdaa:b31e with SMTP id d75a77b69052e-505d219fc06mr199013931cf.32.1770060797732;
        Mon, 02 Feb 2026 11:33:17 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745d7a9sm111971941cf.5.2026.02.02.11.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:33:17 -0800 (PST)
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
	Emil Tsalapatis <etsal@meta.com>,
	"Emil Tsalapatis (Meta)" <emil@etsalapatis.com>
Subject: [PATCH 3/4] bpf: Allow BPF stream kfuncs while holding a lock
Date: Mon,  2 Feb 2026 14:33:10 -0500
Message-ID: <20260202193311.446717-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260202193311.446717-1-emil@etsalapatis.com>
References: <20260202193311.446717-1-emil@etsalapatis.com>
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
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

