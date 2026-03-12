Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AC3FF88F
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340708; cv=none; b=hrtO4ChFwfqfWAA8bLo2sWD5xZv892SlJtWa+4Nacd8+YatHV91HxT74cZQ/O37qg/U/RqY6aRbG+hO+1A7Uluv6iVa4hcS7M0A4D08/+URwTAQSBNKAAZENaWmv3YGy3er9EfehkZGfAMvXaMWrcyf6th9c5AdiBDn3Gp3UnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340708; c=relaxed/simple;
	bh=hLkQy7+v7sIoeOptbeXzEKr0KhHSdLM8ZkXMOp0ID+w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rth/iIwS3AnKZdEpCXOVg5j+tOe1hY9Att1Tbzd73xq3KE4bYRLIqlNVqD+yvGebh8ga+fUUuA5GUUtIQFcIajDq54Z4RMdE5zSCwZ+aLoQB/by4EtxXU4wCX+Uy4DqHsZE3gB6J0rpgIytNifFvqy2fGCwDS9xEhqVKRWoBobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZopyF8z; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZopyF8z"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128d0b690feso21066527c88.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773340706; x=1773945506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KT+Cg/BPmj/SMGun4ECKceTmOYFTBDuXe563CTI88nQ=;
        b=xZopyF8ztcZGLBzhd6n67x7WlHA9l54zKAi4yc2lcRXqJOho0H9UQ21OwsTbyz5yqD
         +4wXgNbkKENEiXiyc1fk+sY+/QkIZOtHTDCxQXCVxPjHHDqkTpxAF3roQ057fHfSq1PD
         hh+cuCdoIE9CwrbCF2i0XW4lKCH9O/UZqOwbYq5oTBQ+/zXQRe8hADEkSof0hWMAcvVZ
         9e5jV6bWvnaLweCAXK9XCd015naLrBrLE8Qt8JWvI4aZIeJRi1Jt7SKWd7ujl4SU+38P
         meMuf7iZotBqLaEjELqi07AZtzcvCqoae2jn3/5hIILFVjndE/I9+GpkQ8zKRC8QadzL
         6KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773340706; x=1773945506;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KT+Cg/BPmj/SMGun4ECKceTmOYFTBDuXe563CTI88nQ=;
        b=Aji6eX221ELjq/e3hc8HbzmKbZg1ypFYt28SUNZggOX2nKvOhPusO/FqVNNnzb+Ooy
         YiIt25JRxkBv7SfBgoLb4+KKa3wj3TlBvUmO3fFMIjdrkII+yFyQWIcT4+gsD8mJkj49
         dAxFHlqyj9vKray6c8q+Zwafcg3crV3ueJdWgMxba1+0tM2x/CGn2FlkoXEdDAXv1Y9h
         B/ae/47sCXwYSN4OAyEJP7NVvjLIzqDHu3SAMqTWFf+CFB5yM4e1PxlTFaQd+NWvcvtQ
         sulanS30V2ZUB1IjWxTj0UTRVrI93OFfHh60lmDNWkpVoWycZsFRnntd2jsGWXj41nNL
         sG9w==
X-Forwarded-Encrypted: i=1; AJvYcCUzonda3TrPQVINc9Bv4nnQsOMFRNGmB7Sd3J6uW0o3bxC/hO1Jcmu7T8+p+FfmW8JL4EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeoEyo98X8gAdSg0fMivOgGT3NvEPE8F0W1lB7CUPW0t3QjDJT
	L1tzwGmXcS3Z3SLvMzvmvjRAUcXvHGdmwUE5YQQyhggkeBuKTH4TeI4G5ne8ox5azwrd2pR1NeG
	ab9EkovSGFgVNnA==
X-Received: from dlbrx15.prod.google.com ([2002:a05:7022:170f:b0:128:d24b:8ac7])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:925:b0:124:8d5c:e46d with SMTP id a92af1059eb24-128f3e373d2mr259512c88.43.1773340705709;
 Thu, 12 Mar 2026 11:38:25 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:38:17 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.880.g73c4285caa-goog
Message-ID: <20260312183818.2721750-1-cmllamas@google.com>
Subject: [PATCH] bpf, btf: switch CONFIG_CFI_CLANG to CONFIG_CFI
From: Carlos Llamas <cmllamas@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	"open list:BPF [BTF]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

This was renamed in commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG
to CONFIG_CFI") as it is now a compiler-agnostic option. Using the wrong
name results in the code getting compiled out. Meaning the CFI failures
for btf_dtor_kfunc_t would still trigger.

Fixes: 99fde4d06261 ("bpf, btf: Enforce destructor kfunc type with CFI")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..84665f76a3c6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9003,7 +9003,7 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
 
-		if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+		if (IS_ENABLED(CONFIG_CFI)) {
 			/* Ensure the destructor kfunc type matches btf_dtor_kfunc_t */
 			t = btf_type_by_id(btf, t->type);
 			if (!btf_type_is_void(t))
-- 
2.53.0.880.g73c4285caa-goog

