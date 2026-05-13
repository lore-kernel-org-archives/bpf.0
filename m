Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6783B7B7F
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700895; cv=none; b=Sw2kwyCe27jrfdwsNXdJ/ebGTdx7TcE+RDL8sNbZJpeibomkVVTDFFAyL+wILn20+EZ4BtKo61syC/bbu9/PbrZJRBxxBpgSZM+I9tgJeMtNzNjnv+MHw6kbw0uV713GjBX+PNkbv6sem6eMVk/EUiFpAmo6ApIIUO6ryiH6GYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700895; c=relaxed/simple;
	bh=Y9AgaNKzbi50Cdst9/QmsCQAUOboAw+fAPpCVgHQNHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THBZk75VUiRmv9R3xmncDuJv0D94YCCeWwO8rZvfDRFv/WMcmUdF3Qpo03yTnK3fIIPmeYFsQjwv69hLNBK8D9ukOv2rxl/JAAAkT2FgdxVNJD2plaulIE96TkEjqn0/PBt71YCzPIxqrqKRQpxyOV6AkjwPNS/FqQYA0ibekhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P087ceJF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P087ceJF"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44c350a5b87so4511977f8f.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700892; x=1779305692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsU03lYTM/RXSXlVeN63h9XyzTBMSciFuDaNAzXFfVo=;
        b=P087ceJFLmu9QQFfcIJQZlZyIT3qkLgMxbxjh8/EJi5I1/uaDv9IBvEC/YqPpiBOJn
         7UqL0dKlw1ReSaLsBkdOVo4S+DKMaSjRf6JvesRlr+OxF0Sg43W9Vgj0PsGWOsiaNV9F
         C2Wj19IUuJl5UBrBbJeVVHdNDIIu2QWsbhFkHV2zyw4aQ754nlg8wrC4g4OUAmr+p+gJ
         /+mQleSg2TZFh5IhOINt4liglI2sfMX8MZTcgYkv4aLDZyrfCRgx8vluaUg2q9q2hYfo
         P0upbtQV/ADQYLY5zvGI5bZTzYQNLjmTrAr+cBwSK5MglW7HFRfWjYBbesLOG0R9/34E
         2lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700892; x=1779305692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsU03lYTM/RXSXlVeN63h9XyzTBMSciFuDaNAzXFfVo=;
        b=lQ/pU/1ty40wf55D16BETRJ+cyEvVxwFvsu2nyoskEpYPQZCViVJpgGmRpxuP5JCP4
         UAqYjj/zGpY+TPL2jxLb1uCd4yt39abnS5+zkdFGdH7O38rX9w+t24aoZ0w6JA3QrXWe
         qg+ljlc9yUfEjWLrVSMmppQOuZDpMpR65WI2gYOylANiEmtKfnE02m42OcuJbE1zuETL
         mhN+xyen6gx4rTYfFzYtEPPhS3K97Qcvugf/6Rt0rdAISubYYbQ6YGyjqet806MezoTj
         aqW2fcbKQ/hIYZAbq5nAD+evtvgr5ndR2fVjwaQIwGGxHy7COYuncy3OZf/GOe9FZMTw
         eBxQ==
X-Gm-Message-State: AOJu0YyrihZRkLRc/ioQZPQEtW2U60dRnnvcHGjEX2lrEOcaBWp3B5ex
	YMARgfIyIe8pm+jq7TuxCy68tFZDZfy7/NksDG4iGsG7pyEUS1kCKomuPDepag==
X-Gm-Gg: Acq92OGQMWGAMPxgTU6OJ6uj4Gxkk1BtocuwEGjfHTmtqJaZXTwQ5zWWQmenB7VXRnO
	p7cC9rum2wMlZpOg4Q0MQDUBQCx/6Za6o60d8O8VROqxAssRXLBrApIplOpNIbSoxkGhbifjNfk
	1qZgNi1cpq12mWWLtR88kwX3E5pciLJOvzEjxSo0H7NuN6m247gx4VKcTHe8oob6OORgHug/TbE
	zfl/c8EF3Ynu9lDOWWdD0TPVqAsigWBzCXq0gk2PGrB+POphkUrhfVXiYv7q5G0sI8WSdmG855Z
	nbi+PN7VeeuCXsYKAEdPJ3GgBQwLlk/NBbAbhWgRikU9LCE0ET4kk/Jix/dRzaHU9TFaNTMwaLL
	uPmtaqPx5WpU4bMLKuwx8nohwFoK2sIBex+RGN87afpBwO1Nc+78BSFtmpwvNKsHHr7Sn7lc4af
	2fIZWPn9DKJlfXxGSe2gTVJevCFURtVlVefnoqSywI7gm98abYqPCaORaMWaZamr6KN4BxIW9+j
	ggPAiXdeikqrZ+TEai5uc1jhlEnTajpCmC2cLjT1TvcCIqlH/Ki8o+C0PfI4mG8c2JBtZWc6YXI
	fHQO+DDsXEYG5EBPqrmcoFs7mshTiWUAjUXcKxemucFTHOoEDQAXVA==
X-Received: by 2002:adf:e9cb:0:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-45d3aa38071mr3200866f8f.33.1778700892181;
        Wed, 13 May 2026 12:34:52 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm966109f8f.28.2026.05.13.12.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:34:51 -0700 (PDT)
Date: Wed, 13 May 2026 21:34:50 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Report maximum combined stack depth
Message-ID: <d3d23a0410f87f116f3bbaa98a815dbae113bda2.1778700777.git.paul.chaignon@gmail.com>
References: <cover.1778700777.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778700777.git.paul.chaignon@gmail.com>

We've hit the 512 bytes limit on stack depth a few times in Cilium
recently. As a result, we started reporting in CI our current maximum
stack depth across all configurations for each BPF program.

Unfortunately, that is not trivial to compute in userspace. The
verifier reports the stack depths of individual subprogs at the end of
the logs. However the maximum combined stack depth also depends on the
callgraph of those subprogs (the max combined stack depth is the height
of the callgraph weighted by per-subprog stack depths). We can compute
a callgraph in userspace from the loaded instructions, but it often
doesn't match the verifier's own callgraph because of dead code
elimination. Our current approach relies on dumping the BPF_LOG_LEVEL2
logs, but this feels overkill considering the verifier already has the
information we need.

The patch lets the verifier dump the maximum combined stack depth in
the logs, on the same line as the per-subprog stack depths:

    stack depth 16+256 max 272

The per-subprog stack depths and the new max stack depth are not
directly comparable. The former is sometimes updated during fixups,
while the latter is not. As a result, even with a single subprog, we
may end up with two slightly different values. The aim of the new max
value is to be closest to what is actually enforced by the verifier.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/verifier.c        | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c15a4c26a43b..b051671c7239 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -952,6 +952,8 @@ struct bpf_verifier_env {
 	u32 prev_insn_processed, insn_processed;
 	/* number of jmps, calls, exits analyzed so far */
 	u32 prev_jmps_processed, jmps_processed;
+	/* maximum combined stack depth */
+	u32 max_stack_depth;
 	/* total verification time */
 	u64 verification_time;
 	/* maximum number of verifier states kept in 'branching' instructions */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0e654ef01ae0..ae92223d1106 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5038,6 +5038,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	}
 
 	if (subprog[idx].priv_stack_mode == PRIV_STACK_ADAPTIVE) {
+		if (subprog_depth > env->max_stack_depth)
+			env->max_stack_depth = subprog_depth;
 		if (subprog_depth > MAX_BPF_STACK) {
 			verbose(env, "stack size of subprog %d is %d. Too large\n",
 				idx, subprog_depth);
@@ -5045,6 +5047,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		}
 	} else {
 		depth += subprog_depth;
+		if (depth > env->max_stack_depth)
+			env->max_stack_depth = depth;
 		if (depth > MAX_BPF_STACK) {
 			total = 0;
 			for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
@@ -18289,7 +18293,7 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
 		for (i = 1; i < subprog_cnt; i++)
 			verbose(env, "+%d", env->subprog_info[i].stack_depth);
-		verbose(env, "\n");
+		verbose(env, " max %d\n", env->max_stack_depth);
 		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
 		for (i = 1; i < subprog_cnt; i++)
 			if (bpf_subprog_is_global(env, i))
-- 
2.43.0

