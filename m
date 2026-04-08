Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A151F37D3
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618101; cv=none; b=gDKmPSlj/poxhzBDm8ooaVDTJJhdrlhSwwtv1/HPAv8Qy5P+6U6xFqYWu3DvA00oo3rYTNB0ltBBAIiD2tlQDGXd4eRVfksGtuWAqrnXEAj0JIfLMRapyc1+AvkH9od9gzVp9cgWAgoCNsJynAz5W5YlemPE0JFqrDOxa9UIA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618101; c=relaxed/simple;
	bh=xvRDs4nil5H4XJ4t+U3YBtLt6EFVmw09a6l1VrdGqZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TREIn1HUQFgxg+dVbNO5WPzKFqCU8xY83QCFUKtSB9dhw9aRRaoJQeEDy5NifLRJydK0QUrhBFjKdoUJo5Or15Lx5Dl8OZd8zFocXy+E/E7vZ2DLf2ihnJFcwXW5/R52fdSJ/6ILKB//t5tG0lJ5oY4WfOxtI1fAM3doYc2XHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajTmBbfa; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajTmBbfa"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3163087a91.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775618100; x=1776222900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96Y+6n6rZkJFMlrS+a863ywsRaIr1kQQ346rVbuJ2wo=;
        b=ajTmBbfaP0yNfqai9iOCZa4iLvdk5IQCgLUSkiQYqPO9ih6jvIHgEVeSNk2HfhgPsM
         Y7wVdUj9ynAFCcAjpK1PSa1OwxLdb1rZZ6ixA/qCi+QSZwvaNfLbOi6xMmLdMuiV2w+X
         6qSegblSGwlQ7btlEJQ+HDNzG8pnDthHA7ToXsftxgMmwaBQS0Gw0xjMIe4SsYY4eyNd
         BsSef3XSKIdbydzIjh1FSjVY9eIAi/KAG9J9m+g5jchGDoymsEHI+xkDbApPpBS8fRLr
         fF5W4WmFYn1GCPpNFmi6zIAetHnLHpmInYE62qDWzQpi5kIzRG9k2Tx+JYBzc7W3gbZl
         YgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775618100; x=1776222900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96Y+6n6rZkJFMlrS+a863ywsRaIr1kQQ346rVbuJ2wo=;
        b=JPiB+C+pvKnAF8EFz2+yUU3QwLjZFAaGMRV0/9mPglZCa/PQbYSSdUfROVH3baWFs3
         EFDW0dRZbl5VEozCx7VMnW1hjJ1vd53YAT3sxM3SvG/4kiQroC9VKhvyotP6U42Rj3AT
         lLtTly6RG+YlccxGERhcAOE82oKyLGZCjBidYCFagAu40lIa0mAei26sS7V+A5Q/mrNI
         UPzIrt+NULChT3bUvxAv73FS+OVYIbm+Hoqm4McK8oMk05btYyAPspu4SDsxSkbV0oyP
         TXz5Vi1VmPhSxOyXDR0UWuRAwfCZp9GMA0MsRuCTF6UOk++v+9JrAtyGActXvf1E/f3D
         yeRA==
X-Forwarded-Encrypted: i=1; AJvYcCXJk7M2jjW/E2/rpt2+q4EEJS+DHsb88ZNdWbyGre2mFBZNtIJ6oE55y1+iCLmJdhPdjPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvoDCkKQkUehQw4M+XptO1WcFdySJcGbLBN9W145+Nx8e9FUQ
	QKZUnu+hL0IO02ZwGFCsztrE9fuGmfmPM4Yruk8rhcnJv64SISXWq9ee
X-Gm-Gg: AeBDieutUIvOLMwOAC02560LQfjeIeHsjm3KCdiPW8BCYhIFfEKgol3MEHtu7KoDkLk
	reLgXj6yUMTTE9zJeJ61CfdTYYl34uAbfswDAGykvdTXxO4e9vBW2kqqH0zneUb5N/B4s/nyQ/q
	ian3A97FVNKlKDJ5fDf6hwKGDAhyumXGMrdA7QiyTK/v/SLS7iFJupZajI5y4sWgRZrF0yjafZS
	EhzT0P/HYvtFxxm/C5UtC7LY6nr86AsYBRjwgMGlXL0FlBiyppukPk2VLZwuF/6DZp+baJ39bW0
	0X1ENBSa27cuSzOX9vrmER7zoPSTmRbVj10XFp/SGJSaLREeaalTDjyoJ4k4yjgdAm1ORvIDJ5F
	rvVS5x0hcZDgrPmlxLnUkuKLa/u5FeOY3dV+wJ3wtgGIt63ihT0YEPvoNEtoXQ0KtxkhVBLcMi6
	JCkoYrefqAHvAAtZpQ7140
X-Received: by 2002:a17:90b:38c5:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35de6840775mr18498561a91.2.1775618099873;
        Tue, 07 Apr 2026 20:14:59 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm23506913a91.0.2026.04.07.20.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:14:59 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 3/3] bpftool: add missing fsession to the usage and docs of bpftool
Date: Wed,  8 Apr 2026 11:14:16 +0800
Message-ID: <20260408031416.266229-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408031416.266229-1-dongml2@chinatelecom.cn>
References: <20260408031416.266229-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the fsession attach type to the usage of bpftool in do_help().
Meanwhile, add it to the bash-completion and bpftool-prog.rst too.

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

