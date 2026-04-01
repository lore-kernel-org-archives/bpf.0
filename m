Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43730FF36
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053888; cv=none; b=IVf+keVM6MsUtIBZHfGhdQG1Bm1ab/SbZ/MJu2/vyUCdZGNFrENsvBfcGiYsnqFZXjew/6iWyXI/qYaI4i2SvPwwMstMmMwvdko6cyAsyI5CmorxVUlULB34a7alvZIb0rTtRtHPku7nkOBni7FQJwoKwPgUVIjSFeWSBm674X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053888; c=relaxed/simple;
	bh=8T68ciFzv9ByAxgjyQbrWL6zyFvUylJ8zF5UcucRsJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQi1fi/VSot+y3qQNeQe4pJOHXI/T9BY/upoZq83JAyvSXnfY1g0iorh5RMIyLJGmnfOCVib4sf91ONwG2+1CUqqjKX/bIg0p0QjxRX3Z8nEEdIXgnokIobQkNuow1dPiWKrvXpvJin18nkPkZE/QWkHoakv+q64S4Tp6tVnTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NyAEPi7k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NyAEPi7k"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b980785a0bfso984665566b.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775053885; x=1775658685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kk0t0a+MKlgW0hq41owgJBjPy6XE8mL2ApTeI5SbiM=;
        b=NyAEPi7koFJ+0CM+TEGQtashimklFhPnd5Qwf+tnZ1AmWiahXInDZFGMvReMjV2+ej
         PZDwnk1H8guZt3Q744zEye68uELkXQhVcbD4l6gcrcxXpQ+wKJiZePQKUmQPq2g80LwY
         vWbCLrxyTmAYkKQYagLBO6XDnYyDbviPU0wBOdEV4jEVelAXVG4AEOZ6VdVPuIltRenO
         EPBODQVA83f6ivKUX3eBlMh9OgG9yVGUULOGlQ42N8Ttn14R9ZzK6Wt9i5NYH2cRVbyw
         13hYmOf7XEgU2UHWCj8LIj8kmTF5aSa4z8ZUfWcjGDVZjJN28I59JQTkcoEKIWP4cD2N
         RI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053885; x=1775658685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3kk0t0a+MKlgW0hq41owgJBjPy6XE8mL2ApTeI5SbiM=;
        b=M5Ixfe7TzQEC7Uv0YFTGGqvevxBaozbAwNuLf5G8GpUSDUyZsuNsgHugrR8xat5A5z
         unw3chZwHXaqyrNqN2I67WMa+gPZPS5Wf5W7fNo+WDQESKo5NUILLaqWYecK2ne4cukH
         12gVrXrYQufELz6QCJqjf1i7CdPL+atgfdxSqgSkTK3GulpvSxDPULts+v0nTg7A916l
         XcfmvD7y8oQrXOzGy2cTYtI29CQCFPoIUlR28d7A6pv5NUj0tv206KmjNyp3EQtoi0iI
         C6pZU6hKfuZgU/Bu6sTOtOLB75X4SHeFzXKsLbnn4Pcmr/CZzXAiW8F73x2mehiycXCo
         VIAw==
X-Gm-Message-State: AOJu0YznBOH1/DSjHN5z0SDGGA7Bve9LDbrP3vQJgKA7Lx6h+ipa/lrO
	XGz49uQalGhaTDcTD9TX++mAK8DgMlio6UhM1S4onXwZKrAnil/LQ37nExsrHIB0rn1CBct1DiI
	H4QfGHnU=
X-Gm-Gg: ATEYQzwOH76iDwlTHFXRR+e4emYooEutBbYAACXMxZ/6AQOPI4k4UHHe6yFchrP0D1S
	xMo2vPNMmNo9AKZVV4IXGcdXbqA1NEgIMuZgc7qZOufFSUJrhZrtONWblCCj73NxXQHVdPOMn8J
	Qc33eaRL1F9OdTG9SyYD2UukwYGLUbL4YI0LWHodveA9AWO33zgoqZZjaJVnbB+xwoEPIWqq8fl
	H3zdrdZcIfkRherERvWKuIYB2ziAzGBE93yk+1j6ftjKNI0frFTrWHDZeL8rqmBRbpucii42CBy
	7dcxu56ptVlOwuhvNxk2c7FXVCLHYd61XAGTMuN0OQs+yCjgyCDYbpYUqZ30aA/fRYJB7YV9Wxr
	iEWIeVtY5gXEkjmfd3W3ClzzeTC4QSYzM87pvdg0/sum7RMojnMGD3ngPiyMRBqVk4LNT8uyooP
	/5/fbZAF96KcwhmQ9MKhMNqfUxuld+Fegobl98HRYVvlCj/meh191yuI6+683aVA==
X-Received: by 2002:a17:906:4709:b0:b98:6a8f:7916 with SMTP id a640c23a62f3a-b9c1390270bmr211946166b.15.1775053885105;
        Wed, 01 Apr 2026 07:31:25 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm199047295ad.48.2026.04.01.07.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:31:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 1/3] libbpf: use direct error codes for kprobe/uprobe attach
Date: Wed,  1 Apr 2026 23:29:29 +0900
Message-ID: <20260401143116.185049-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401143116.185049-1-hoyeon.lee@suse.com>
References: <20260401143116.185049-1-hoyeon.lee@suse.com>
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
values directly instead of re-reading possibly changed errno.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
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

