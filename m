Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27897264614
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776213027; cv=none; b=JBteSi8p256sUIbGkso2YMFT443VJBkP2x1Jai2Gkttym2NpP+vPNXodiv/gaP3RmLODM7Wwymz00nA89zZ+piSLuRcWS73YDVSsMAuCfczj6WdNVGs7ci+7JucoHpfd3IVdD2gt1zEsR7X7b9nbfIegy82z8zkBAa4SCRsGXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776213027; c=relaxed/simple;
	bh=pggxb5klrCa31iAHEsZWCNSyt4ephJB6XKes0lC1k6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFwnrv1/KqjteXQCA0LB+f0NH9/PQw7mbcjcV/SPTnyBznnynqVwAl8k3taGmqjg06PhK+Prder7aRGRyDwBK7+u+txNvFTlaPnewK4Gax6GPf7az8E9SN4wcQzXM8vyOkxbxyl8QvTYthQKrQXyRnegOSqWpvMLH7DigZLvNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCvx2NpE; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCvx2NpE"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c565476d7so4128017c88.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776213025; x=1776817825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zru8FySz5AhiaWwf6Upr4P1h7py/Mu2zPj3hDHMgLYM=;
        b=YCvx2NpE0qYj5vaxpntbV1AO1PX73/SogHZgLAYfvImyvVMouIPBf8RD9zkynNn0Tc
         7ARo1642yb9Z6ykr87e62LkcE5NxipurikJzULNWZQVTu/ZAzjHfuXls/BGVuVJvt+tr
         W5TZx8LH9ULqONVwNYtBfQFZCprjw3xoDC8zJJsWKIZNDmMy/ZyJm2xfn/5hJQ04G1IS
         gmxVcWgLCFEm9jMnZ9WbcXubu/o3cAhb4bFZdSL+LR3bxiqc+SWg+A5PequKRQH9GGlZ
         7YF4/ZxGCVQz0s+7dMBkcWBtlhorma9XAHYl6ISwDMAOVWNLxsBM71kqhVlHigAZK7vV
         wEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776213025; x=1776817825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zru8FySz5AhiaWwf6Upr4P1h7py/Mu2zPj3hDHMgLYM=;
        b=s2P1cOUT0l8Yn9UGNODYTyrivKoXGnpPruenAUAFkUFjT/hfEm8DYkw0ylIXDpfZwp
         K1qSFZtR1RL1epulPIM6X/utPUPH2I2I+Est0qS4AylBqk4tWs3wo4hnOs4lxsZ4vOP1
         m1+Ztora2mNRcCk9B9GQv9tsfhwdgs2YZog29j60DbkyLAdWofxfObZHTzHLq1OZoHV+
         AvozbhuiQhmyUj1eOxSWp67uJKpxd9Em+OrVKA1YAAKXAFlOKfSG9UPrS1sUgTbOG72X
         QdSn8+kYaVdOUE4OTeNmoDwpzivZp3E/EJdDYB/pgPb9dKeaQNhRn/MXxnGxd2waizCF
         D1lQ==
X-Gm-Message-State: AOJu0Yxh3dFXLae/W3anHMhKUekJqNpmozI9VHD9sBPhgkLhJe/Zo3sZ
	FQP5Pjw0oCDFVJkEDhwg6S+EELHc4fP9ls77lSdUnFKiqZLi1q76tXR9aRYSE7kA
X-Gm-Gg: AeBDieuCrbgfLVF/Yi0d5rQakBZcZoJK3a3huAmS8SmbYtFJ2YRy0zf4wg0KqUl+XiU
	cYy84nxnKg5Te3HoFdQ3A/G05jZi+eVCk9SIxuGVGn/aBI/84mYfckEJk4Cgcb6X8DQT0zLmdTT
	3Kg49lUmIDWihH5Ns+otJ6op85U0dfJ8X4irv3ABwhQxfaWZ6puw6mi85ePs6wfKODiGFbjgf0Y
	zjJtdcdg4Wk50GMhLixRiIRawubtwqFsR5u+xQUyjH1x04DqAVzzI+CmCWGVIgBBx3mZoy+oVWf
	jPpl3nuf0UpC/+YMt8TYoVcxw/qpnrKQVi3JpRTykV1P1urF6FiE7VcHSEWsJuW5ne9aySdZB1L
	uynTm7MctO5VPZjv4kvNfKTIyXUNeBcLS70H1YPWxokYvtAUqNKRc4ssPZ3riv9jM05H46N1Crp
	ln+zbYbRKI/7U2lOc9IfEwM6Mb/jBdBIEnHxAj8ByO+qLxvVpFxKiJ20YAB9wCwR0+Y6raNDyyk
	DkP
X-Received: by 2002:a05:7022:3d08:b0:11b:ec5f:1c37 with SMTP id a92af1059eb24-12c34ecf745mr10878011c88.18.1776213025019;
        Tue, 14 Apr 2026 17:30:25 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::d8d4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84813sm299140eec.18.2026.04.14.17.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:30:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ctao@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: copy BPF token from main program to subprograms
Date: Tue, 14 Apr 2026 17:30:12 -0700
Message-ID: <20260414-subprog-token-fix-v2-1-59146c31f6f1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414-subprog-token-fix-v2-0-59146c31f6f1@gmail.com>
References: <20260414-subprog-token-fix-v2-0-59146c31f6f1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

bpf_jit_subprogs() copies various fields from the main program's aux to
each subprogram's aux, but omits the BPF token. This causes
bpf_prog_kallsyms_add() to fail for subprograms loaded via BPF token,
as bpf_token_capable() falls back to capable() in init_user_ns when
token is NULL.

Copy prog->aux->token to func[i]->aux->token so that subprograms
inherit the same capability delegation as the main program.

Fixes: d79a35497547 ("bpf: Consistently use BPF token throughout BPF verifier logic")
Signed-off-by: Tao Chen <ctao@meta.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/fixups.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 67c9b28767e1..dd00a680e4ea 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1110,6 +1110,7 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
 

-- 
2.53.0
