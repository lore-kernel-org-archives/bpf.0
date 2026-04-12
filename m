Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23E346E5D
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775973857; cv=none; b=rgqt5g9mbUQF1xOysdUwGHEV0pYkttq/5v+keVyMjKzTZeU23NHVJxbKtruKFVwkSNXHI18JnWqC3sXfoLTgw785nAwDC57GlymKcjZK97sRSJDqvyYCllg3CjMLdsk3SpcykszRTe2lfklpGV5zW/lWhwfArtHD6UPsRYMRW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775973857; c=relaxed/simple;
	bh=HkcF/gdsFf7bZ+yj2OkU1FINpafuDEY/gnd/Z5PA6es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olylsaPdj/QC/7NqR7Mo4oV8bJ6KHWf9F75gBmqyDSEXFK3kwzTNLndajbBjOiMaQtte/hfmk0YHvsKEUwWs0/gyt9WdaCXNNEeYd7Iug4gV6CQzszKWPWbuQadSx9YjGBAt6geIHnLrMby643V2qcB+qiZUJ4oNRfTwLJILbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu3vxHGY; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu3vxHGY"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82f28e0ac23so227400b3a.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 23:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775973856; x=1776578656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y7uM2hTZN+vzJGI+23DWwA0Rsh8MoapnFXCJYwKTPw=;
        b=mu3vxHGYosOfo0RF3tlE0ccRr9HyXhzA/bIjEDlIkKtz4RlbbhIv2zjH+m7yqqmvoH
         6YiCLhKobAkCZUEPWy8c20AzFULEU9g9NmOpH2NOdRlNKBUOMKxcVMQ7JaFiDDZuaKix
         biyAUOWQG0Ik88GbhO+zAq2UgqcFacMcWb4CM4vmfHt/xCzrbouTnyvsXSBlh96+80cA
         JlRcgzDA2iilVSUZy39Y6IF98SCioySJtBjNSycmwySoBHyHyuZ1PzkA58etZe1Cnpu0
         sbEC71EWayHlkL7Ri2B9pL1p6bx8tC1YAc8bzK3iC27Amj67It06rFbWEXEkyP74OruG
         FiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775973856; x=1776578656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4y7uM2hTZN+vzJGI+23DWwA0Rsh8MoapnFXCJYwKTPw=;
        b=UeostbBBhkIC9+zBvo/9U6XahWD48vZzzF650L0KX2RDRhNptqT8V2liYqr468k1sY
         4xOYCVtNww5sKDRHEb3npNQf7ShENlhqyfhi8Din0MFDMnNWnduEz0pOu68Qh32G7Dvu
         tcR0Uai3sx9e5kIq8oezZr6GIPGDo28f/u8ik6RViSht+WBXLm8y8ziTLZApF0nUk2Y2
         mkkXj6r+lQfhXnFA7TEZTyAkz7ycWgKe3evN9mJcGcV+Ntw+83W0h6lc1njKQ9JbkfM3
         UATEAdGPCkiPZYjnbP8X5Q0xd+cTua/9zy58KUtG6jK/sdHAutZcD/qApF9Lul1xKbg8
         oD5A==
X-Forwarded-Encrypted: i=1; AJvYcCUc7Ovlv55grdpN3aoVZbO/QuHlSo6En2mwKJdUyROIaBr9gqZjBLLm8RG3BubYZnDv6JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykVmN9jtEc4Z19NJMy1G6XJtK9KYNkeCwI/cb9TPaCk7V0yPD4
	8R25LBspjqG6m/B4t1TuiLE4/L8nSGZPuGer9382i2gEah2yFJkJwiQ+
X-Gm-Gg: AeBDieuxg3HiTSWhc5SGtXXQ/oijEG8vuby8YQ4S2gZOyNzAosnaqk1hWHi9Nxkqmbg
	MVKoe2SYce+fSW04crcqtfXIt65bxwZaAgvG7Op3afhaH2YAYL9qNJQ2H5/OSQiibsDSxzGPHLX
	6fb6WdGkklF2FxQqcmoILB3lg0yzfThmETvtI4ve9tKroJn0j8qNSe2hRX3z5judPGlXOGIAFFk
	Zt8mPU2jCQKlpbvcMr4X7njZZaVgZQRHuiEJhbA500WJYdL33PUOxw6lMH6mEhQ5LQ4bKIyZFw4
	cXiQEyZAAMGVCe2nygJY4ilRz14fAsmLTLedpFAUO3U8BCFK+a5L8upRc/eK/Qz1hRwECZoXw14
	qenZohmwNsEZS/YOqSrESnBuGoTbLHq2mFsohnT4COe3sf66sLUbZ2+jJicxVNabNrjMwLsDRsr
	zO4DfICuBHYiIautcBzB7d
X-Received: by 2002:a05:6a00:4406:b0:821:810d:e0c2 with SMTP id d2e1a72fcca58-82dd8b5e932mr11080541b3a.26.1775973856158;
        Sat, 11 Apr 2026 23:04:16 -0700 (PDT)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b251esm7072645b3a.37.2026.04.11.23.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 23:04:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	emil@etsalapatis.com,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] bpftool: add missing fsession to the usage and docs of bpftool
Date: Sun, 12 Apr 2026 14:03:46 +0800
Message-ID: <20260412060346.142007-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412060346.142007-1-dongml2@chinatelecom.cn>
References: <20260412060346.142007-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the fsession attach type to the usage of bpftool in do_help().
Meanwhile, add it to the bash-completion and bpftool-prog.rst too.

Acked-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 2 +-
 tools/bpf/bpftool/bash-completion/bpftool        | 2 +-
 tools/bpf/bpftool/prog.c                         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 35aeeaf5f711..90fa2a48cc26 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -54,7 +54,7 @@ PROG COMMANDS
 |     **cgroup/sendmsg4** | **cgroup/sendmsg6** | **cgroup/sendmsg_unix** |
 |     **cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/recvmsg_unix** | **cgroup/sysctl** |
 |     **cgroup/getsockopt** | **cgroup/setsockopt** | **cgroup/sock_release** |
-|     **struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
+|     **struct_ops** | **fentry** | **fexit** | **fsession** | **freplace** | **sk_lookup**
 | }
 | *ATTACH_TYPE* := {
 |     **sk_msg_verdict** | **sk_skb_verdict** | **sk_skb_stream_verdict** |
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index babb0d4e9753..75cbcb512eba 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -501,7 +501,7 @@ _bpftool()
                                 cgroup/post_bind4 cgroup/post_bind6 \
                                 cgroup/sysctl cgroup/getsockopt \
                                 cgroup/setsockopt cgroup/sock_release struct_ops \
-                                fentry fexit freplace sk_lookup'
+                                fentry fexit fsession freplace sk_lookup'
                             COMPREPLY=( $( compgen -W "$BPFTOOL_PROG_LOAD_TYPES" -- "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 6daf19809ca4..a9f730d407a9 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2583,7 +2583,7 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/getsockname_unix | cgroup/sendmsg4 | cgroup/sendmsg6 |\n"
 		"                 cgroup/sendmsg_unix | cgroup/recvmsg4 | cgroup/recvmsg6 | cgroup/recvmsg_unix |\n"
 		"                 cgroup/getsockopt | cgroup/setsockopt | cgroup/sock_release |\n"
-		"                 struct_ops | fentry | fexit | freplace | sk_lookup }\n"
+		"                 struct_ops | fentry | fexit | fsession | freplace | sk_lookup }\n"
 		"       ATTACH_TYPE := { sk_msg_verdict | sk_skb_verdict | sk_skb_stream_verdict |\n"
 		"                        sk_skb_stream_parser | flow_dissector }\n"
 		"       METRIC := { cycles | instructions | l1d_loads | llc_misses | itlb_misses | dtlb_misses }\n"
-- 
2.53.0

