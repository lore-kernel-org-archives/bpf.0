Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F2F3909B3
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879621; cv=none; b=eU7qeW3yzCsKUPTeco2WwT+ZTYUglEmN4NZaTq6GshVNEfLoLga33fbdqV7MdLIl5YBq4c6s3EbEYu/ILEQ2AhsP21OgmfJ6Wro/zAB3kJHS15O4o01ya7zQjO5DVpHV3V5I4+sZEfk0x6mKOStGDqzRwnmFE+4PTfNRmORKcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879621; c=relaxed/simple;
	bh=sm1K5UHAtNhDz1p1BAacdMph+aF7Bwu+Mdeg5EnJjpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKmYkZrQatDh+TGWkHOJfYcl5yWCocDBbc6kj5SxCOQ8ekcJr5f/6Gt3+6EBb7dtcuL1citEr0TpUbuauBbioBSBdPYLzG9Cvg6P8YYPWJoStLtNsgh0gKK2ITi/AUuT9JY6sp0BfB9xDgjb+retU4xrW5+5o0w3dZ+M8Z0ZFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu/QdD68; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu/QdD68"
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-6dd3bb640bcso125070eaf.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879619; x=1792484419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZGOfKkJg39bEwxfPH0tf0DFU3XCuxlFShlp72UXVns=;
        b=Cu/QdD68+GAcwIGgEg4aRadIas72+EsxVo8mtRUF/Nk/5USje76TMcnygBl6ZFUeDl
         8xJTfbwWiBudiLgHbkhEJbmGrseSTBv2ngQbdGxJvWIf9zSNjE4aSxamZRe13OohyqVn
         efI9PJJuKjT2xstQDUhe6I5EYidyG5QR6Xp74GG+DsyyOWxh93O2v/UzYHguZAcBqfG1
         a8IcT5RrYkFB0DkF1lU2yC/sSIuD8DBvCY5nAgwt4Mss2AMdreJWgfbVnCl1bfCnq+HE
         NNIKXuQycTJu9sfXw+T+fgYlN/LFfrv9XRRmHGnKAdZi0x3fXmnMYjPlIcGKm9c2qJOW
         FvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879619; x=1792484419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZGOfKkJg39bEwxfPH0tf0DFU3XCuxlFShlp72UXVns=;
        b=F2bzxz49gyUCCzOOXRK0SGH0PxZ7naWICeoxBM1e+OPFlrowgctZY4HQI4tmx0FNRL
         XrRF2VJ9yx7KnphDlXonsaDkEnKJhqjBV2zCyP1kpoWfxPgbUftMZb5yV7OeidSD9WUw
         1bUwhfiBolJS5ZKHvg6oyZQs4G5uUqz9fo97EYDe+yvQTd1SQnUAC8zUMk5Je88VWKP9
         2kdI1ga51MvIi7LLHsJJ8TRQ1GoxKCA3H5lWe7DKsZP2HzwklPv0u8jFjkGBnNO3JIgo
         yNwecSfQGlW/KziWSukdz1gnFHPpc8YWzruTuX2n6epHTyPbo+1FHGmj6ZIuf/vZLYlH
         xyOA==
X-Gm-Message-State: AFq9FYJVLxvS0O28O388TpvN9y3fRxSFdY3sgZIXrePkdhqYx5r4bTF5
	0xjDctZcNhtPjl5okBSRW/IctQa+4U04dtNvFkZiE7w9Rhmhp3Girl+ppJqGo/7m5jE=
X-Gm-Gg: AYBFou0v25kmIzc+SPMOVsGjt9x+vQYCxBFQsRUoyC2Ve2ol/oKDeHF5sKBA8BEtQu4
	aMtm33Gd9LfY1KGA5/M6KIUzwV97sF/Ymtq+KbuEb6XPflyVqz7rSHMYwL0YOAANTjR1g4mkfow
	31qb5GhcdT3jJd99/M4/YpjHUbQ7o/WbkI+PjTnH9DYsaCTd34v7vWmjyd5PwMjKdbyhEq3CYmF
	lepwtjFoeis5Vf6lZsrHNENKcT+G804dv6jkzCtXqGLuD5rMREm2uweofCBNtTlrm/A34yvdThr
	NjlBuoTqlWyniXrRaR9cxQYqNSGjsETk2P99AcmgaX9NrJKExT5Yj86X2FAk/fwBySuXsjRNqtC
	yVTrgTlMO+5eBKriTQtIEsZDB00Gqv28QqVv1GaqkK8gyijzgyPfLprlRvGPLbBVbAOctqSlKKq
	534D+rgQY6hDTMNunh5m4mMPL1y5HWudrv5KPOoAsolF0KWEhLLk39MmjTB9ESZmLGk6OCo9kUP
	Wlaf3y7vgG1Hw5WV7spgeE+R4tCGJeLYY7iKHhI88ACNcR6nt9NnctejvFa2Ps6qGzdmDGTh0u+
	OvsMew==
X-Received: by 2002:a05:6820:82c:b0:6f9:f85:aea4 with SMTP id 006d021491bc7-6f90f85feb4mr1526723eaf.33.1791879618793;
        Tue, 13 Oct 2026 01:20:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f6d6796c54sm4037770eaf.2.2026.10.13.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 01/13] libbpf: Keep the fd_array fill index out of bpf_program__clone()
Date: Tue, 13 Oct 2026 10:19:56 +0200
Message-ID: <20261013082012.1107446-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; h=from:subject; bh=sm1K5UHAtNhDz1p1BAacdMph+aF7Bwu+Mdeg5EnJjpQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy3nivTdt2D+oCPy0z6p7uirjhLwsT9nxl30M/Bwli2Ov eu3tKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwES0lzMyMHzdJbX7sMBhN00ds5aNXd NO8r/KS67hb4i8sY2tceLJWYwMl28zVctMNlr3SYnB1eJnsz9vQNyeTXNXb/1ktVOG/1ANOwA=
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
Cc: Mykyta Yatsenko <yatsenko@meta.com>
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

