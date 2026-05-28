Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB24028CC
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990473; cv=none; b=KMFGI51lhwQIumGsZwu53uJQHTFhGLx5AxLFxL/7dK2IItg/CdSnGpwkKcp/zgBvmU1wlg9L6yMZTlhTUsBR78OC0P+IA8f1pF9a+UQ06ioGDOJCFhA2gUtlTz5JAkXdPm8ZRGXH3RL6cnDlHC+Ve6JKwLRQxYaIgIEDUiA9GZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990473; c=relaxed/simple;
	bh=ga1aB17ntL79MOPRtpxzjO6aLV18ItfeLCRtlyiaiAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAPryEaj0MaU/5glLIy3DBYTdRJoou8Rd1GEyivTMWQuryxLTNYl4U44twjjjjJ8XpoiZx1dI99Dtas9J46/svYw+gYb7beM70M6BWKUm2SQm32v1j9py6GojuZKN9eMgbZijBnwg8ktFZ6gTAMNan7zB+byhMhFze+URgLWS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpRy8ayl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpRy8ayl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4906238c62eso44816005e9.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990467; x=1780595267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vimfmm1FBkLbHULTqa6OxnSjhwN21YXtlrUewdCK/TA=;
        b=UpRy8ayltZFcNUTGhIfT1bsHyxeqL5LWXGuDdFzh942mydFBioapYocYVQcvxqjgjI
         aJDVx5YDXCTjScUpY3hBuVwKh/uBGMs/QLDW0g4Rfp8xF9b6w3crGfFCYtzlalIgrCE4
         0MFZcruDpcYe2x8o3slhgGXK33s4mj0u6mjbR+Kf/r17ugICaGiQtlf0mWU+jEYoEjFZ
         hXT6PKMWK2f8CxETPyXFLPlnJvheln8VHqmTtWVRwqfHiDlk18Yde+3pGGjRL2SEvomX
         WYojWiU68pPfeVO2Y2789l1WIi9EpCx3qZO38lExVYXvdQe797AYTnZSZebkF9jkQ4AO
         Scfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990467; x=1780595267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vimfmm1FBkLbHULTqa6OxnSjhwN21YXtlrUewdCK/TA=;
        b=SpL6A4DjearW5pLbE+6Roy3udsmdRP7paLnqLY0ZWgV4DjuzIm8SKQ4rdPf6yr++s9
         Lxk3YL3VCl/0B5KStHJ2RTi9TtLogOFkaK3yZB3MK6VPlHkcXxwBoEskILqiwNg80qCH
         1vonN3VxGJyKG3O7+4Zulm8IVdCRBgxJmzQYQ0V//AyVL5ObXb1H/vHzM3oQzT226gVB
         KRlVC/lgHjpewVe7ERWkJE5lE0hBGbmDQynXQB4wLw0MvLUzPsiqC4kOJdvCO/uRgBQ2
         SSbzXsn7MMdihpNt6axGAScXpHKF5QdWcyzdt8AHaN0qD53QX7xtsSf0jGtJuUiDgrwh
         raUw==
X-Gm-Message-State: AOJu0YyWTib8MdiI0rHOIY6D8RFyjADqGBAJ7ESLeLiRrpJExdLHIENB
	6vMxYXeQl4SX7RbLhyLVW8bzkGE+ew/IyGjcQbCcYUg6m30nB5UwHaLjyAd253qH
X-Gm-Gg: Acq92OFhQwKQlo6oWiDpUa7m30u9Xv4r2nwUFogsXs8KIQ3LZCVNAztwoPGmlgf+UDO
	z0TOF21NSYm1TK8SV4L8rw1atLaneNZOMvCmlEq5lTP1x5WRJ9MDXk2L+ICxeHMwrzK3VOGahJK
	mUuLj2yzT/cmBvp03FI9cAM080+GKlg9iz7/c76kJLvd1DckAEpNWMjsOtgyqfcFOBbG74ivejs
	85fQXvNyfxl0W6THe/Rtf8QLRyP9iaVodeE78Ioi5YcG83xDZoSFaD3FdtrTWg1R/2Cdj+DseyJ
	Z9+Dz+OJf9Un2AJUgcmJ6ec9Rb7+YW/rqTnq8wvmZgYu6z2SLfW+nPR3vFYaHi4aDix+wV9v+Pr
	FaHGSYgeJzROwNag9TaaZjJhiaQqx/EBOOayEVZe4A9EkAgpBbTMh0oLfHq1cQSvuV6G0JZjvj5
	ymSqGzbLq5hA==
X-Received: by 2002:a05:600c:3b08:b0:490:7dfd:f7c2 with SMTP id 5b1f17b1804b1-4907dfdf7femr149166535e9.11.1779990466702;
        Thu, 28 May 2026 10:47:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909a23daf5sm1017295e9.3.2026.05.28.10.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:46 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 10:47:18 -0700
Subject: [PATCH bpf-next v5 07/11] libbpf: Support resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rhash-v5-7-7205191b6c57@meta.com>
References: <20260528-rhash-v5-0-7205191b6c57@meta.com>
In-Reply-To: <20260528-rhash-v5-0-7205191b6c57@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=1419;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=eiArZpQjhMU2X8BztxYH8ee3r0EFLa9BsZJ65DtQqCs=;
 b=nnPSS1S2zLUTh6wRGJI2GkARiZDuA3Xy7KoZfu+69ShrjqZ5/hR9iujzaKT5/zm/q/IFGTlSl
 1MZ0ev4gAdvD2bnQE3f8pnFU+jWIMLSkF8es5aNtrQpvblWaJKtrht4
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add BPF_MAP_TYPE_RHASH to libbpf's map type name table and feature
probing so that libbpf-based tools can create and identify resizable
hash maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ab2071fdd3e8..1354bcbc8b30 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -192,6 +192,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
 	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
+	[BPF_MAP_TYPE_RHASH]			= "rhash",
 };
 
 static const char * const prog_type_name[] = {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index b70d9637ecf5..e40819465ddc 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -309,6 +309,9 @@ static int probe_map_create(enum bpf_map_type map_type)
 		value_size	= sizeof(__u64);
 		opts.map_flags	= BPF_F_NO_PREALLOC;
 		break;
+	case BPF_MAP_TYPE_RHASH:
+		opts.map_flags	= BPF_F_NO_PREALLOC;
+		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
 	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		key_size	= sizeof(struct bpf_cgroup_storage_key);

-- 
2.53.0-Meta

