Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF5627E5
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350663; cv=none; b=Q29wSMa2gq642WugA23/9dvBtG1qvPLc1YCKw97H1yi1r7zF8eG7PCI++RMt8X/yb+l2rIxlAg9vCAtsAXwOuzRZ1tDvSmAHU18uxITzt9nbx1/c7DM/cpH4srqtuNKwXxuNo7UNZ+a2CnxfXhVfMCsaN1rsXx+wW43H8XFnsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350663; c=relaxed/simple;
	bh=COX/dutxMFtgdD2qShiWUCYf8rrcG91VNCH65Dn+Iyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NnnqiOTBgbVVcR6MPXp01ubosCnlxZ9d1syeld9rU3xnhaVqObE/54zs/qIU9rY/W1p/NgpTQurWVdVFdWMyqXjmamu3vsXogilS6ZribC4Q1FkX+HmDH+Q8xrgJnyuuogTcM5o+m5lKyXf6p2RKd5suKF5bguNP6VSAfqX9FV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WP0Pze/5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WP0Pze/5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e94c12cfaso8210f8f.3
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710350660; x=1710955460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RssB/TaUSBP145878SWmPyDLBDn7gY7D0hNqObZ/9Ns=;
        b=WP0Pze/5LjQTB1dEmSNlIL82PRKoKfTQm7mSza2V65Oe6+k7B9t7Eln9WWnr/KzOmz
         0X+HWMHeZQ1ul5Bf5UQh4ShQtq3G4DqQj7ugREQIExhz86u/vCcMGxfKmSCp6L12pp0d
         Io/3LT/NPy3/SIFXmjBxtZoC0hIPctyejTadptkz24VcgI6i9iALoeCEvLcqrwmEkPdD
         O327/DnxfytB4g4zukiTJycLKa5zOhrachG/RtAkVEX1FG4OcgsOXMJGil46jZiFmvft
         PvwEAHro+AVWGmqZ8tFpi/FB7QC/i3JdDWFxQHKFiLGKe/iZJrcCQ4/+Hwd165KdXbXo
         oARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350660; x=1710955460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RssB/TaUSBP145878SWmPyDLBDn7gY7D0hNqObZ/9Ns=;
        b=CnNnGkxiKLK/w/UgNt/jnQd/WCInt3HlIiGxFMlGz2D13HG7sqI3tOx2+mYLgBvlbm
         oQ+Y3p3fOc0KUNt7e6sdRO+3p8wcwznhlAOJ3YzuHdK3d+53zIU3xGNOZBhpBCnYr/+T
         cmYinGau2RPs7vQ7k2MhMdIfrrYD3Y111IZcUbHYbk6CkOnW5Fin9nZsNcJ++7stwixv
         0+K67ksQrVoonvY/6jtE8rdD70LWUPQMRJyH7hfMKMF8CnrBrgYwGD12p+ssFGK+pHD7
         j5Ue+6Rqo0ewSXH626ZQGefXNZExuUdZCOedfu9+AEpX5KKGYJmj+oFVc1qdy2k/gvMe
         ieAg==
X-Forwarded-Encrypted: i=1; AJvYcCW/yqdy1FwiXDI8deHDgXDLdCjWVMN1yJBZo4VXFBOc8+2ud6Lmt6JER6dZbImpkOtDsq6r8H3Mi6H6inkS6D0UwOIL
X-Gm-Message-State: AOJu0Yw6TDRBJv+0MdEw/7OTpp+DlO2vd3/TVHOPB0ouaclWczHFIBbX
	TxVnlCV3HY2+JlpD1VG9y7+9JdmnhfttQ4gHy7crgl/a2w4kcG3wigU3SFVUFmY=
X-Google-Smtp-Source: AGHT+IF0tWEJIwLhmFW78mMPAgi/vCrtOr8tt0tCfvZluY/jcLCxwBXPd44Cb4tggUzr+tdt+qjmdQ==
X-Received: by 2002:a5d:4489:0:b0:33e:7fbc:caea with SMTP id j9-20020a5d4489000000b0033e7fbccaeamr1973121wrq.34.1710350659720;
        Wed, 13 Mar 2024 10:24:19 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:4ac2:8d7d:13ad:ef01])
        by smtp.gmail.com with ESMTPSA id b17-20020a05600010d100b0033e03a6b1ecsm12129498wrx.18.2024.03.13.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:24:19 -0700 (PDT)
From: Quentin Monnet <quentin@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] Revert "libbpf: make uniform use of btf__fd() accessor inside libbpf"
Date: Wed, 13 Mar 2024 17:23:45 +0000
Message-Id: <20240313172345.75270-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit df7c3f7d3a3ddab31ca8cfa9b86a8729ec43fd2e.

There's no guarantee that obj->btf is non-NULL when passing it to
btf__fd(), and this function doesn't perform any check before
dereferencing its argument. As a consequence, this commit caused
segmentation faults in bpftool (for example) when trying to load
programs that come without BTF info.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index efab29b8935b..0f9a4d232468 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7343,7 +7343,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.prog_ifindex = prog->prog_ifindex;
 
 	/* specify func_info/line_info only if kernel supports them */
-	btf_fd = btf__fd(obj->btf);
+	btf_fd = bpf_object__btf_fd(obj);
 	if (btf_fd >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
 		load_attr.prog_btf_fd = btf_fd;
 		load_attr.func_info = prog->func_info;
-- 
2.34.1

