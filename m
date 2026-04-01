Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7536B042
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027284; cv=none; b=S3tCaB/+zmcG4mXe3Wo6bRRE92UOgQ8lUwo0mfevwZud3d6q8W+oovalwg9FUMpvv8ij7Ej4Nz3c1OsIw3HrxLtHc9gW20Ol45Cya/BaWDvTAN3CA6yRfc3q55X3Nn2KBf5UUm5YxXLNGDT+g4KqHQybmEr3lf4UapYi6HGQdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027284; c=relaxed/simple;
	bh=kRJsrOOhJwypsGQeh0t77eM4spvDtzgMI09Db6pLmhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUkXoJxvhU5e0eNmxMlPfk9mL4ntJ5wNsuSuzvqoqlC2+GzPTU5d1MA8B6bPiOOrdYxdWb+BiDmU/O5xPf5+GJgHSXpj0dJ65fz0cSIiSFrcd8YYLZq4aAxt56AHdJSlJ6p92OW9lSQ7D1/spYsnOsbVBmEnu4XCKvCNGzg6M9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EQjH692r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EQjH692r"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso55572425e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 00:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775027280; x=1775632080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq5bYodbB5WenNka0ORppBTIQzpNw7WJ1K+vBmPhvzs=;
        b=EQjH692rxDyuj82HitC6JMRIM8afQoQVXKNYxJDD6C0Va0sd+pqIPjXjeuD0JoKpHv
         NzGiDAhiYcSuWtRHaAVnCRM2y28Qag1RBr/GDcTX9e40CIS/LFKkicSU0PylzK3YIZsI
         355x+Ea4wjYpXoA/n0QObzpx5X2Zj/czaGqbxEZYacpilHLiQ6A7tk1D5WWJhaOAz8xN
         BDxWzxQDAv/NUA6bx9da35S/oFIGuJGM1QsS9/NMf405reLbOV6EY+kVtCnjmJ4u8S+1
         zgbp5KPEjEC5FYBRS3yLqkofPh7s5kGHhyCKNwPtXN4GvqhZPdFaIgMgxte9RRx3srU2
         PfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027280; x=1775632080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jq5bYodbB5WenNka0ORppBTIQzpNw7WJ1K+vBmPhvzs=;
        b=FLkhOOURcL0ejZQSAH2JrFKLYzXrOxcxXfJNFIKEo22AW7D31KEXEHUDqoELW1CXts
         I8vfiGqqP3MzicTfhOgPmMbySaoXZEx3C5o5C8abRD/AstK/wq44HmtujNKWdNmluCOi
         BZd4PPhEUC3W5xcCjde5BQhbUeP1CWGb+T8th2s/BwqKQZl5JtRyq7QH18Y/wF93pgjt
         yf0gUnJIyN9vw5+dVUgrmPzNOzVD9xKPVIhNWKyXIB0LUNbIA4+TWYTrnRKuKmNTAp3n
         EXYA23ZVrnIPW604WMcT/Kpu/Oq9rfh9bC6Yq9ErWpYfbFvHjWUev/jKEk6StAljczvt
         hr7A==
X-Gm-Message-State: AOJu0YwbAq34avK8pagvnDIf2nGAdl+XGQAXzZnWF1GoIhyh7+4SqZB4
	TnjH3juetrvJ/NuudzXyyiQ9iohNAH1i+Aa/765ktNJ+VrEfvz81uPXVLT/Bd1SYpkoRzmYtSWy
	o+L47j8o=
X-Gm-Gg: ATEYQzyMJ5DpEZyidbfUWEorsVKLRgcFSq1FOatqF7zNyQph9QzQQQcA7519vnjNGCo
	9w1fTEQUDqWGfoJJwz403pAAd00wSUg5oCvaVyLAc3YccHE3WyylHVKIWf2hiYDIXtaXotS7CfM
	yOKEiE6ruEoxDjM1zx+pCw5bM4EkQnW60KULUiRSLdD8/XEdy847OBDxqZ9H7ik/FyWMKLsw3pT
	XwDJ+FB9L31z8lxQK5dxGFweMQRZ5Y0EskIYW2NbRkKd4fxaSy6Ix4r/Y+sHwyLElSqRe7egeBd
	Vkc/roH+crLYi1UdBQE+4HneLoss/46i5ORTC+9bIvNl0zRNhdt2MF9R2CHNnRy6I5V3FSMb2jb
	lkyiym5PfTbdFEe6tH6wCb3dL9wtYUxjHO11iYKHyppT1AaojVoDzmWnkSjAiwSvVpZvakdPdbr
	jOJ7Jp1VWHk7dx6ZU2z5vwXsU54RktZRv3JIhE2L97g+s8BqqAHfWSDP+Y
X-Received: by 2002:a05:600c:4e4b:b0:485:439b:683f with SMTP id 5b1f17b1804b1-48883595da7mr42337065e9.20.1775027279770;
        Wed, 01 Apr 2026 00:07:59 -0700 (PDT)
Received: from f16.suse.cz ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a887e3sm15355778e0c.18.2026.04.01.00.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:59 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 1/3] libbpf: use direct error codes for kprobe/uprobe attach
Date: Wed,  1 Apr 2026 16:05:02 +0900
Message-ID: <20260401070738.122709-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401070738.122709-1-hoyeon.lee@suse.com>
References: <20260401070738.122709-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_event_open_probe() and perf_event_{k,u}probe_open_legacy() helpers
are returning negative error codes directly on failure. This commit
changes bpf_program__attach_{k,u}probe_opts() to use those return
values directly instead of reading -errno again.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..536c19c14d21 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11835,7 +11835,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 						    offset, -1 /* pid */);
 	}
 	if (pfd < 0) {
-		err = -errno;
+		err = pfd;
 		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
 			func_name, offset,
@@ -12825,7 +12825,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 						    binary_path, func_offset, pid);
 	}
 	if (pfd < 0) {
-		err = -errno;
+		err = pfd;
 		pr_warn("prog '%s': failed to create %s '%s:0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "uretprobe" : "uprobe",
 			binary_path, func_offset,
-- 
2.52.0

