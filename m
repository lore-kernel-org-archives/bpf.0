Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64F3FE35F
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380260; cv=none; b=lmOFIljxAz9v5/k3HUa9kjCEtfeRcuXs3LNs2ig9dbILKGZLoWd2aBuWt5wn2WAiKmYRV6yDKLY9/5qcP3zdqNIfVUEbfxS+avMvZtcNlcmI4Qr1gEcn89H9+fQqzG+PnQfdGhktWhspPI6YPj8RekEon81XVmA4vPmdERCc3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380260; c=relaxed/simple;
	bh=NWSf/BFzbgbgWUKwXp35PZz9dmXpR9qjJiaJQa2uzVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QR7CqOl89eO7IaTgA5Dvq6VAYUkjjsJFzuSywP4YAALP0bdDnCbsb1BFCTUWIfyyXw2OSB0QNizLT3zUPpCTJh2YQewf4aoYraTv+hWoTPLd+Fh/9VOUVLZr/b/jLjHp4LqwBzq2X8IwchkvlMEgKMQykbtc2e4iM3pzSl20q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaJu4rwQ; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaJu4rwQ"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so1074800fac.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380258; x=1792985058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/BxRK4PUDB2ek3xhfb9PwSjtR7+rFj/bTjbadDEoVY=;
        b=aaJu4rwQiqVQEVHEXp3B8wAArBMDXGJQIVnEHZdA64Du6I4o1zbhIqMDNLR3yswQB5
         dkrNpxfELwHtVQDEWhKO7VFuRCfy5ENnrOq7FmRbypQXy/Y7JQ7gYnMsP5GtYo869n0T
         3IGKv1Nx7AHlmx0gwlZzUuY7QDcR1I1WTweKZLOScGJYpjMBSXTHVsZOZ3x87sZXvUVK
         9Kmgy7oE4sjGguJ7nzoxxtjFCnTc3NQKS1e9VjOdcu2t6KBwFOLFvjipoIFFsn472sYi
         /AdGI6kn17p+ld+NeK9NHP7sEcCw+8ozudcORt2JJny7lwq885xg+WhBuYiowGbWlRo6
         mdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380258; x=1792985058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/BxRK4PUDB2ek3xhfb9PwSjtR7+rFj/bTjbadDEoVY=;
        b=wgzm70H0CTDGm3xS7jWtmYi+GCr39318qtRncUOWYisQVHRA2Z6pmZva14GVcRT81C
         x3YbOHEDjk1nq5QJDwsJDgRAitf6BlpNvDP1+N6mIjqDY4o+g78U37eJaf3PVHq6fm9O
         33qSLmwOT0wqyOJ0gPsEOKVn5nFy2YplfWb6+emVXBbd09oowuiEpcXYhPOB5kjTyneE
         F6E0OVhKPxABrUWzd7j3O450IATHZ7zbQp+ET8KNm8aDrbYGL4cYn0uHS2fH1b60nucg
         BKjOhTjQ69x3vGzXRyoLLUcJq+6Yjr6g1Qy9pQKFQA1h0TmDqgWUHJ0IDVKaLTw7KAD3
         DCBg==
X-Gm-Message-State: AFq9FYIHdo0N8reRLOoPhwp0Xt6kedm1xmJf4By6dRwoyfCCIu7WqpZ9
	77G69TNTtt60xzBnu2LsLl/EyKxpTYYSZ+JFLP5wPiS/nbIwhFDq/DXk3IyxhiuzjXc=
X-Gm-Gg: AYBFou2b8BJfcrhUv8iD0Ly5toVjCTPYtdG2f/nI8yEBc0dddO+3PPqAB6t26Z4/5G+
	/UxPdx/ae79fyheeBn/RCH9YbAg66QEDpas66iBfPamvesUtkPU4iv3KbeUH6jxGkBvGL+U9oa1
	1qyj/mACJF3rQuq0p8NZbn8tIOKfepfJZg4RZTAZTTCHa8LXUMNYi4Vd3aY6N1QibnCz3wctlC1
	0VP30Km0TW8hp7kT5cMo9E2ay8cuAdCXEvJcxI3ZF4RnfkjSR/JHAZ8Yix/x2eZeaSRpVFzOpA2
	QMl4DPR3PG6RWoXMOpgrq8inn0GAnXT9Wi6ffZUVWe3EplWhihdmuxhAKttBCggxjXBPnepcerD
	y5vsIfKbjVza7ZGb0Yh2nfRhXzMqB1zDdWftMQ4mPAMydM6bAWF9/B7KYnvBg2dCyAtSPayktkE
	BaTGcsv31cZ0LR41DgU7qJUuoFIBz7dFfPPAn0WKGHi6+fkAMBYJuBTPNgk04vUyGBuhmJeNNmb
	dfC01cPmCXHZySf9GRKMRTHqrnCNSOmimzHfE7YNRaBeAvssH1IzCtbFqU8sebAaZILcwZGQkp7
	Oab8k68=
X-Received: by 2002:a05:6871:7c08:b0:475:e0a7:9f2e with SMTP id 586e51a60fabf-4a75796a9dbmr4708840fac.28.1792380258018;
        Sun, 18 Oct 2026 20:24:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b640adesm7470710fac.10.2026.10.18.20.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 03/16] libbpf: Keep the fd_array fill index out of bpf_program__clone()
Date: Mon, 19 Oct 2026 05:23:43 +0200
Message-ID: <20261019032401.2302823-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536; h=from:subject; bh=NWSf/BFzbgbgWUKwXp35PZz9dmXpR9qjJiaJQa2uzVU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqry6/lX/VlJ379O4lfUre5mTV/u7v7JCuFfIPN9zo2fOq d8eLjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkswYjQwPTBL+3a19rh3IyP9R4cy bZqvsfq21WZc3Ebe0S2i6+cxn++11VcNnvLSWTIvxr/0s+y3lTPyeX2l1b+lX8SP57b3NHNgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_program__clone() hands the kernel the fd_array of the object along
with obj->fd_array_cnt when the caller supplies neither. That counter is
not a count the kernel can use: it is the index of the next free slot
of an array built for the sparse fd_array API, where module BTF fds
start at slot 1 and slot 0 stays empty, since a kfunc insn with offset
0 names vmlinux BTF rather than a slot. A non-zero fd_array_cnt turns
the array into a continuous one, which the kernel resolves slot by
slot, and slot 0 holds 0. Cloning a program from an object that calls a
module kfunc thus fails with "fd 0 is not pointing to valid bpf_map or
btf", for every program of the object, which is what veristat runs into
on such an object. bpf_object__load() passes the array without a count.

Do the same in bpf_program__clone(), leaving the count to callers who
pass an array of their own, and rename the counter to fd_array_used so
that it no longer reads like the uapi field.

Fixes: 970bd2dced35 ("libbpf: Introduce bpf_program__clone()")
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb09ded90773..fcedb78abe00 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -794,7 +794,12 @@ struct bpf_object {
 
 	int *fd_array;
 	size_t fd_array_cap;
-	size_t fd_array_cnt;
+	/*
+	 * Slots handed out so far, slot 0 included. A kfunc insn names a module
+	 * BTF slot through its offset, slot 0 stands for vmlinux BTF and stays
+	 * empty, so the array goes to the kernel without a count.
+	 */
+	size_t fd_array_used;
 
 	struct usdt_manager *usdt_man;
 
@@ -9716,22 +9721,22 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 	/* set index for module BTF fd in fd_array, if unset */
 	if (mod_btf && !mod_btf->fd_array_idx) {
 		/* insn->off is s16 */
-		if (obj->fd_array_cnt == INT16_MAX) {
+		if (obj->fd_array_used == INT16_MAX) {
 			pr_warn("extern (func ksym) '%s': module BTF fd index %d too big to fit in bpf_insn offset\n",
 				ext->name, mod_btf->fd_array_idx);
 			return -E2BIG;
 		}
 		/* Cannot use index 0 for module BTF fd */
-		if (!obj->fd_array_cnt)
-			obj->fd_array_cnt = 1;
+		if (!obj->fd_array_used)
+			obj->fd_array_used = 1;
 
 		ret = libbpf_ensure_mem((void **)&obj->fd_array, &obj->fd_array_cap, sizeof(int),
-					obj->fd_array_cnt + 1);
+					obj->fd_array_used + 1);
 		if (ret)
 			return ret;
-		mod_btf->fd_array_idx = obj->fd_array_cnt;
+		mod_btf->fd_array_idx = obj->fd_array_used;
 		/* we assume module BTF FD is always >0 */
-		obj->fd_array[obj->fd_array_cnt++] = mod_btf->fd;
+		obj->fd_array[obj->fd_array_used++] = mod_btf->fd;
 	}
 
 	ext->is_set = true;
@@ -10940,7 +10945,7 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	attr.prog_ifindex = OPTS_GET(opts, prog_ifindex, 0) ?: prog->prog_ifindex;
 	attr.kern_version = OPTS_GET(opts, kern_version, 0) ?: obj->kern_version;
 	attr.fd_array = OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array;
-	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0) ?: obj->fd_array_cnt;
+	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
 	attr.token_fd = OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
 	if (attr.token_fd)
 		attr.prog_flags |= BPF_F_TOKEN_FD;
-- 
2.53.0-Meta

