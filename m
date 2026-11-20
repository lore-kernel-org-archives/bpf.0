Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207815;
	b=kjdTyrFDWgOlLU8PjDOGGMpllLwEbHS4KB4qjLXF8p3Tc7VEWusRgML52/powqlcUpYa
	 Pc/I1jrGd24a2QMAhORXdg452nZDxMqxB4PzDlL6YFywLhtGI0P4L6AtwqnMcMzWkbyzT
	 gs2NdrD6dFhASC3CtOpvJGrMErUl/PDik3b19lemhEPbLAIUhKunMCtTthXcWR48vhsOY
	 WC1NX6wHE/P7kl+YWL0FvZ/QFj99Kkv136Ul6YV+slPjE+WxPaAeE0FzTGCW1HapXwz9b
	 fruydxga0KByL73Re+b8t7UpH5I2DhhVKSZtzfHpBKF2e4zFCtq24fuSe+DPCP4+r9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VHhYUKMyk2skIzUV7qKnMaNdt/Dw8aweDzCRE44Kyo4=;
	b=oIV+ElI+swsPWzWRYdqSzomE+3KfTa6fIOKeAl/zXWcnOvzEF9GBrTIL7UjBFxrE1Dzi
	 i9MDobUFKbHAioz6D5ecIw136i4Llle92Eoznt0BjBtoN6ziOdtLx9elX2i4JDuo3sfhD
	 xdqGZygO4QeACmkMBxQk0qpKYZW9lV2cYwflrSPWy+Te1/VxSb6fluon5+93DV7Y0Nx0D
	 yHYIzGXGhU/+ZQuaXim3RaGk0Wg606izZUD3prsczEgJRMezJXlO+BaVFVR2eofvIKM+S
	 J2DNOoBmRoWbscz824dvjX8kQ9RhkH5Bo5gxKkttScUC2TPk5O8JOfSjUBE3vTFQEYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fVq05S/i";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CAA606A69E
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88CAA606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fVq05S/i
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so890911b3a.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207809; x=1795812609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHhYUKMyk2skIzUV7qKnMaNdt/Dw8aweDzCRE44Kyo4=;
        b=fVq05S/iQAz9cZIMj9SVMxyukLrUWPVo8wdKG7su4H+s2vC3h/IUYGr1vOen3Wm7/Z
         qaoMVn9Ds8+o6MudW9EhWHQeq203QElH4n6acanCeTFlCSVZCebhV4CM3OjkOjUKV+2K
         5+klbER28nXcpT/qEUcdRFOimtiuFGQv23l40f7P8MLZR3gJ+R4Jg11G+bQW/rWqztaG
         aruQ76+u22l+vVkvrGoPU8ummuvRWK6IKwbvGTCbcDhbBG3v+t+n3MQ9EDGuV1fqgqPg
         QkwTtLGNOfhM3M6JtlQipIZgxiDYjZu30w56wWqQx/5UYPS8aJNyVboka5jUJZUEdbv5
         pz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207809; x=1795812609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHhYUKMyk2skIzUV7qKnMaNdt/Dw8aweDzCRE44Kyo4=;
        b=XOfVU4S654vES/9Ef+qnwdf3dJExyEIE48vlx97MLYt+mm4wghZuGUJURn8fNwkFeq
         5oruBBI+cRrIzVgGXKG2VRq3FAHkpVZOqSsQWwyrG8h18knJiL1oy+zuAapLjpx4PWS8
         DOI0J7Cb0R/CS7+N0P/EMPVYSd5om9Yzcj3cmsua4LAjOWDvnFaLoCwC0kqpwe/EW1WH
         OJgr4loutPuuUEj3oNVc4Q1wwyrY0wO88WJNE5LPxI8DTWKaz6FwRbxEbI0YSKWq82F/
         VEfQVGynMPDy9NzZux4RMZ3b7Ke/Pdkns5vjIF8wiUlauo+0v6sg9QLb0Pj6Zso5yZxW
         o5PQ==
X-Gm-Message-State: APuU4Z+q2u2KtjkBEfoZCRYqdHEAMzMvykjvfFxkKEyX9myRms4ibv7x
	V1zyikOOM2cbhDgzgIi+l8EmsYTbY5jTgjMX2IYMVXmGWDjns/H8kARbMxCIUw==
X-Gm-Gg: AZFdTZdhBsh7jEiuAvjqU7KIVlSAuqpWaj+dQDm4lqepOqxzCRZJMGxtFMu+vbd/8Dp
	TtkxvoLBxdUTaC/Y07MDzqmzD+0KCGHri0CYAN8yodd0++FSRmaHdeAdhk0z9jUSiRY3Q9/WkMU
	8y4meTsYUddoEyVSpp18qOSRhWEYqkfePO9pNZ8L8MeBQjFBEukt1jRO7i21qGxXP2dFMWrMKZx
	pQei8pa+bTYhgAIJF3qSprZxprqq2rXyCufGdrNYBy+LjS6iWoFhYSlxe/KZRLy/w7f1ZDqI+xp
	qe0XIfRPLQG0JyCD1MfL+WCt4okcDl3JxswCBwXvGw6i0vpC3z0cjw2F+2Or4hr/JhFDU56oDco
	Z2Q5zA8nA5B8LzvAN3UjlcKyY51BYSnOkIwZtrIssv5ztJfEsLoAkMW0F1eAWaXcJmmZrJErEck
	BxaofLe8hdw2es/stWuf1csCLhbui/QSCSuhcSlTv92sYEPnaCkO/xNgbhYJFUPgsNmzL28/98S
	vSvNTc7n02F7M8mHPU8ryMwae0WeQ3KktPTGHSkykC1sT1aueYxrcSqe68I2QO2ukQM4uUdThkr
	4NfczyJmfDxWcAnQ7hHaT1VJiVKV3tFjwpLP7Gfix999kR7IADcMt7Qt2nz4jPdb8iH36FEYUQU
	TdzDsRmB5PmGCF1oakv0224n5CiEv4EA1k8p280875yynOCsm+823oG9Kmcl8xKC7zV0cDoBVnL
	hEYBCaVaI2kyhliVi7PD4=
X-Received: by 2002:a05:6a00:b90:b0:8b6:ca80:1ade with SMTP id d2e1a72fcca58-8c7dea69446mr3723438b3a.48.1795207808782;
        Fri, 20 Nov 2026 12:50:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872951febsm1967603b3a.14.2026.11.20.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:50:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 01/49] bpf: Look for bpf_clone_redirect() once in check_recursion()
Date: Fri, 20 Nov 2026 20:49:09 +0000
Message-ID: <20261120204959.614908-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

check_recursion() scans all insns of the program for each recursive
subprog. There is no limit on subprogs now. So the cost is subprogs x
insns, and no signal ends that loop. Scan once.

  100000 static subprogs of 4 insns in one cycle    BPF_PROG_LOAD
  before                                            34 s
  after                                             11 s

Fixes: f7e93aa4a34f ("bpf: Remove BPF_MAX_SUBPROGS")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 39f1c6eb113..64ad953bbff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5485,6 +5485,7 @@ static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog);
  */
 static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
 {
+	bool reenters = bpf_prog_reenters_datapath(env->prog);
 	int j, s;
 
 	for_each_marked_subprog(cg, s, CG_LIVE) {
@@ -5506,7 +5507,7 @@ static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *
 				return -EINVAL;
 			}
 			/* It runs on top of its own frames. The half of the stack is not enough. */
-			if (bpf_prog_reenters_datapath(env->prog)) {
+			if (reenters) {
 				verbose(env, "recursive %s() in a program that calls bpf_clone_redirect()\n",
 					bpf_subprog_name(env, s));
 				return -EINVAL;
-- 
2.55.0

