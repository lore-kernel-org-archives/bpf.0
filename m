Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C86395DA4
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036642; cv=none; b=F7cPPnykWXqTS/g7dugaMb9+iGzhBuqVRkHihp0ZRFWfS9aVIWvwYB1/loqsuvLAFdgKztB40Zx6TbdLQguKkEuUR7mojgm/Rw4as/2GC3wsWJysUXpq9v37hzXKiGfXMMFmW7AGxZlGFsx15TyD7++VHZ2G3SsRgqSofaFAMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036642; c=relaxed/simple;
	bh=ZprYJsSMHdGR9K5nIlQQixUTbPGQMdJCxpgkM58qS8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhYFaIng2/9ntL8aI4cZ2LZmozEF64rTn74O8wyDvYtRDfOGjW+h8jgXU/a2BSBirNGjYTNUgSYT5prjvJ+CITrLilMB6c2P6QIxlnh/pqX33VeS+9iOygpHvauEQQORR0hIjlTjICGVzFwmVGS2UQhDH8ZoyT2aWYDIOSOcXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZHcg3On; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZHcg3On"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-482f454be5bso10457435e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772036639; x=1772641439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuxOeVZHZHP7JWYvR8p5y3EHpzPr7hqoIRt9AQZI+Tg=;
        b=GZHcg3OnUG/lVuNk9K8YdiWwN6ncThayHgJmehdKWfyU7eo+erGGhVLUfgyAJjTcve
         lUGDu70ClGobm+PloG8RfQgduwTyCZ5aN3oazGMUU7o9e9mz/5oPLKipdBzfy4GrIOpu
         xJvZWVqlYtYFwjuQ9sbHZM+o4GLVriILSO69xvOBqMunzu98DJLxswD5pdtxi7gCE0NE
         Lc7ySKLg2UD2Gk3DBoMNEIr1sc5h2ISYdS23OqyZQwmsjj7HBAZDtOQejwqlU+yavYSk
         MhHif5Xl/yCyl+XKA8qeMz35xTM8We+KP6bC4T4cSHZewBSwSZ5PxGDqCeEbOyjtVCHR
         y9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036639; x=1772641439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PuxOeVZHZHP7JWYvR8p5y3EHpzPr7hqoIRt9AQZI+Tg=;
        b=Jcu7CV8ZiTvYLyxIUpvqPZJuNQsTr2mEAYFzxat3yn+438JUxXFwMGPgok7bxX96uy
         S7T9DgZVMQGjwKTQKwsQwxd8FcIr3ooVCFJ+IPGoBOWPy0hYJf6KaLurJH2hgewwuThp
         GJap7lmat7xxNyP6lrdUhPK5zDvItk5v4RRc+Lt+ezkIvTPIc0VIsZuQomazURH6aaIv
         IdBkSexlLo01MZ3Cwkh+utLuca4bS4cQXzeV0R5mSu9N3iKhbALSJYDNJ06Qx7Vd3zcq
         InNrAEExZm7lC8DIS58ZCgIjLjXtdCz8LRef9EeuCSL9XqAf+2tC3PW94Il4o0dG1rvz
         Ky1w==
X-Gm-Message-State: AOJu0YwdXueLIMtwc/QHi3Kus0x2cDWtX0wX4u4N6wLfoW/FbZ2RpbjN
	qKP6i0JScfEJa3ETo+7fqSfrT4gPnZcBxQ3eOQPNkIh3qBuUVBVwTS8ulyDt2kFgYaQ=
X-Gm-Gg: ATEYQzzT/sFYHGEdPl0OwmrrQmdvyOvKFNmYJQOu55vhyohQ4dNypb3EtBGqPJ6CRwu
	ViENTccWRi69UsCNjGnB3ixLsDOyRa2sI2yf2knKqZbDBRydo8wiwoxeIssZDsMfYsYYbdmuo8w
	fJOBrMiCysLwvnmYkbGd/WbhfAEBpZMdvakxEOmnVeU8jjGaxRbD/T9/XjsGRc6FayH2JP53bIS
	kuFfF2tJqAQEvBBjbv8GduTx4fgA06il7fnjKQ0Aed188YGzWuiYtgj2n46hqBioC9d+mgS39O7
	JhFdWtFKaK2Wtf0dcMcnBpP7gJ5Cnt4+Kt8XJouTc6VEws44Kg6pJ/n+NCEUeflra1QypQgV3Ra
	m3nJ6yaRP+Q8yg5SBBccgWesK3mLIpS9EpJ23Dplp1k8kdNNahC0DvdCX6Uenr9FD7/azMLcQM8
	oKVLrpYyZbtkre8bU7YA==
X-Received: by 2002:a05:600c:1c08:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-483bd749127mr75055875e9.12.1772036639256;
        Wed, 25 Feb 2026 08:23:59 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:58::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398a09aad0sm10494085f8f.2.2026.02.25.08.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:23:58 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Feb 2026 08:23:52 -0800
Subject: [PATCH bpf-next v2 4/6] bpf: Allow sleepable programs for
 BPF_TRACE_RAW_TP attach type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-sleepable_tracepoints-v2-4-0330dafd650f@meta.com>
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772036632; l=1272;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=478yvWZpKFRfSoOUshSkf/kllPet0TGtLFS+pZb/WMU=;
 b=Go2c0R6irXuso0EYxWOYGucIzDUnAMR/p6mbJG854OTyrlTggs2pJF9Bt4lWtmrSmADfxAZax
 VfOPJf+uz11A6MH/+W4wnxLCzD6dIRX7BkaG+CbI9qPcPGHPFBH8CFB
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add BPF_TRACE_RAW_TP to the set of tracing program attach types
that can be loaded as sleepable in can_be_sleepable(). The actual
enforcement that the target tracepoint supports sleepable execution
(i.e., is faultable) is deferred to attach time, since the target
tracepoint is not known at program load time.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1153a828ce8d..9ec80596ff1d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25199,6 +25199,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -25228,7 +25229,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_ops, and raw_tp programs can be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.47.3

