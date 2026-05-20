Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E93CBE71
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270051; cv=none; b=S0KlBirYgj7njZEbD66e2WRPJX2jlnsQVzqL+b8fHWYe4BQ6E8bLZoeqc8A5iN6u2DaWuAlw3rgdeDQL0DLJfqVGzWz62io8ejjLjVpryxMYsKNQ/EqVNj3/4fwGJidIXu78TSm12dxSDEXerFR2VcLJobgcmfz5SAYP2BKgfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270051; c=relaxed/simple;
	bh=lKom9UTw1WehL2PBXSRisw+Lkyc8BEm/Zjtk+6IGJrU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m0vjN5Tw2svxUKqc8AOCp+VOmGUfVWi7CPoz6yhaL9u8AiBs0JhRfHbYyWSismCjmJ0L737DHUIGuqavfhrFwp3+Hwj+ONNujl+RW+q8AV5GuW2xLUlIDz3dhNOn9fKKox6Kb2K02YPyvWqqdFH5tmIM8DNEVEaQJPksHjbaCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvDrpbCO; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvDrpbCO"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bd09ec46507so428307966b.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779270046; x=1779874846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9g8XT+Bh4N5cFmthEloiR2bFLHwmyEYitwYQWyR1h7U=;
        b=OvDrpbCOdDR/nIGLrVPasb05k6bTOggrPn+q8oxqKk41etMZQTsCqHyHNLYLnjvLLq
         btI3U79TJY1RFM0hbGRowa4frdEvwrHOcn2EY+3y39eA7dKGx4nzeywuTHR1m1aqrlRd
         vMtmVnCPdfFLv0I1t/nSbsonSk5cCnQcCif4kFQspsAY2SZ5vRgtK3h91KkLo2EC0Y9Q
         VJPKFiAdV55KxYDmjP98r3uW/oUwL+o047zhSPLB9re+pVO4y8mnWjDHWfgh3mG7FGHC
         ztDyyoh//JrTgi9/Cw7wBHz5tOAED1GwVJKD+FNeGzGAa6nmWndWqt7bivFPn3kv1ONM
         nOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779270046; x=1779874846;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g8XT+Bh4N5cFmthEloiR2bFLHwmyEYitwYQWyR1h7U=;
        b=s5kQYumV2ZaugvUifOOTKqsLOZeVFYXs+AzP08BRTrFi4gXS2DCyVLeLvkqhIji492
         WtR9ZywuMDLuO8pBdk9k/iDcktOouqGZ5c3gxHwwyqN9BFSkvCVUP3lmnCMnZjiiEZKh
         3s5CaIoRSe8/E3iigbexfWzZfn3xvWOxAO5kTNwSbdxoRePb6VqyX/yglZ8rehsM9DEO
         GcFAJYEZ5eW+yuNu1z+lzJPq9jrFEIGtLPOYZ9aIcj8Ws5ckXm/ANg+HGQHsmagJ7IBU
         JASLbycbdXyIwLOrDyRdvmcMpvx+8HV1rapgTc/qqn44XVszrT9UvmayUak1B6/3nT4c
         Lujw==
X-Gm-Message-State: AOJu0Ywa3zMsND1/8L6YCBRCVw4tZdHTSWDd2gKE0fLWkIKYGZHXqBWj
	7jp0s+1cJYOQxqnWOYrkon+5fo5wZ420R9wwcprjtNoPgUx8LA9gjt4HG/4g4gEnxsyUZm0z754
	Pa+6JpKZHXPUn+0tq7g==
X-Received: from ejcdt4.prod.google.com ([2002:a17:907:7284:b0:bcb:43e0:b835])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a807:b0:bd4:f854:27b5 with SMTP id a640c23a62f3a-bd5177da46bmr1444350366b.9.1779270045541;
 Wed, 20 May 2026 02:40:45 -0700 (PDT)
Date: Wed, 20 May 2026 09:40:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJuBDWoC/x2MWwqAIBAArxL7ndDLXleJkLCt9kfFtSikuyd9z
 sBMBEZPyDBmETxexGRNgjLPQB+L2VHQmhiqomoLWQ6Cgz91UNax2tGo8DirNrqFHFZZd02vUSO k2nlM+j9P8/t+boSY4mkAAAA=
X-Change-Id: 20260519-struct_ops_gen_typo_fix-59d53748cece
X-Mailer: b4 0.14.3
Message-ID: <20260520-struct_ops_gen_typo_fix-v1-1-4dee3771da46@google.com>
Subject: [PATCH] bpftool: fix typo in struct_ops map FD generation for light skeleton
From: Siddharth Nayyar <sidnayyar@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com, 
	maennich@google.com, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

When generating light skeletons for BPF programs containing struct_ops
maps, bpftool incorrectly outputs a stray literal 't' instead of a tab
character for the map file descriptor member in the links structure.
This causes a compilation error when the generated light skeleton is
used.

Correct the format string by replacing 't' with '\t'.

Fixes: 08ac454e258e ("libbpf: Auto-attach struct_ops BPF maps in BPF skeleton")
Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/bpf/bpftool/gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2f9e10752e28..d6040b52d4e1 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1399,7 +1399,7 @@ static int do_skeleton(int argc, char **argv)
 				continue;
 
 			if (use_loader)
-				printf("t\tint %s_fd;\n", ident);
+				printf("\t\tint %s_fd;\n", ident);
 			else
 				printf("\t\tstruct bpf_link *%s;\n", ident);
 		}

---
base-commit: c6e99c10fd9855082568cbd71bb2cc5dc90eda53
change-id: 20260519-struct_ops_gen_typo_fix-59d53748cece

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

