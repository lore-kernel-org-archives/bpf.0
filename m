Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2E4F30C0
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107704; cv=none; b=N+f7kOa1x7xhj7EFtvpIIECpvEYWbpHTLzjkLYf+4qwNa/7xPe9nxeRSi3BiLCRVU7E6qtTBgds2lHhLkv2xnthQ/YjRpQvW0E6fYlRUpiBnLbrLsEVG7EsU354Ouoiwm1H5+pHpBmYq5t3l2HiMQ6qHg3gSvOmmhVaUnNbSgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107704; c=relaxed/simple;
	bh=NWSf/BFzbgbgWUKwXp35PZz9dmXpR9qjJiaJQa2uzVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKoiMW08IcxEV5w3jiQnGSXrFLKBQ7gXIbWZug3l1jjudk65HFsUEQ+NdMEb8HWHXSEPg4tRtz4pDa2poYWYIA590R7Px9t6hcW/9wx6bP4R7AttP9FOGV+cvPsgcu6yBiobZIP82hWI3RfFbFwURLehU6Giu0el97naENO0QsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1XAZEzX; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1XAZEzX"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-4e4a4d77e5bso359365b6e.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107702; x=1792712502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/BxRK4PUDB2ek3xhfb9PwSjtR7+rFj/bTjbadDEoVY=;
        b=j1XAZEzX8Geg5RmP83cCF4fI9VbgNFHaq6j7KBQRDNZqud+0sSEJOl61Eya0sWkLYo
         zI3Os91d9iHWTC9gNnJ9J2r9XB3BBx/x3Bb1gxAs2ne2KVmDImXt2f/K69JqE1Y2Jwaf
         tldP1ssT9FDfWFIIxnvApJFC3DwPFle90j3poeXEBPpkyaT1WF+TcdRVVaOL8fl7wVFS
         mm82+PjBvnpaIdTiNoVrDTKNO/doCIISY95cU36v0RxqCrOcm9WuFUfFmCPbVdahcDx9
         dL/Y2XC+3eg+MAVJoB68XJ7VAP6iARSuqhNpxe8JJH+G7hjx90EsCwfiE+pftwFEUuuQ
         8+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107702; x=1792712502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/BxRK4PUDB2ek3xhfb9PwSjtR7+rFj/bTjbadDEoVY=;
        b=1IHJz3jozLNkcpBIIzFwDqrm+CbO53nR+71c19JW5nB/gstgg+r4dhBgtcLB7jMSVj
         F2k/eCjFoidtIT9Ihaoih5fT4Hw/nUJPfqdZao2FRNdatTg5NhU0rB1gDDCZ/DfIHOAC
         pD9bXePUH5gjBoY1580cJS90ajftY1QCLLvuMUFwDOGdsNv6EEdlTYzkFzDMZcYD3KUl
         Ng8kd2Jp+86z+deNjlA7pHWGgub3XhxuQoovIXCRdcYy5b3iQqoXFZLwvIGlV0YpWSyh
         ZRncesP6seBjpm/iwlekn+81QqAXgJUeNh8+oEF95Q0t83C+/bKLgjz6JvFoO18sieSu
         f4iw==
X-Gm-Message-State: AFq9FYIA9zI5U+b0Dzcou5GokVSlKJnmsqjL4VrN4/gKJzD9thhkOXeF
	Iq2DLUiogSlCPGVF4szy7Z/NBstGUukrQeemrme8m/k6u8CYWB+yI3DMvzkjmsybIOU=
X-Gm-Gg: AYBFou2c6Yo3Q5JdNQodj+/RZYhMmZp0YzsQvOWdIcR2hi9mnz32jlGU5CVHwmpgHfw
	SHNH/7JeDu9brOruqnObErU7IvGUR4YJwydfAn5BM0zfRMCryv31m0kqBbcddcwAEeDpv9tZQr4
	KcBIJeNrhTb5gbTY7AtXVWK+1bQ5sJwe2IukD9mnwgq2jY2n4YzNCOUT8j7I0cvN2M/2yRrbVoV
	6bgG41++DDKfsJKWlnJeEf5JXzgxWWv2dvdUyjqjBSPAzQyfgJSdRJOYsjO73d0IeL41GHwPwF+
	kTokOYRJIVEUva9tlt7ameUHcqUVHmgDBh/OwOjQnHVC6+IIbvJcE4tR3TT3v5/QTQQRPZKfwxI
	d99rMsX/93UIrpfoC7j0Midyvov8othWNEu54JYvziyC5fmOix0g1TP4xtPxxu82S6ux+p9uzAQ
	Aa0P8IKdDw/l3IOXbOD5cROo5L0HoezygH2L8eCBIMWLAmQMG63e44O5rXPTiVQMGo4GcOJMWB9
	qXBLvVBXbq1h1U+XnNx1NcpM5ueeXWu5HoGw62k1KUjspiIYz9EdLme7tvPQGyyaLfIysLlJ7KN
	2Act91RYNzMoNXY=
X-Received: by 2002:a05:6808:130f:b0:4b8:4703:db8b with SMTP id 5614622812f47-536fd2c5b64mr1072856b6e.20.1792107701657;
        Thu, 15 Oct 2026 16:41:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388d8ab165sm251175b6e.11.2026.10.15.16.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 03/15] libbpf: Keep the fd_array fill index out of bpf_program__clone()
Date: Fri, 16 Oct 2026 01:41:09 +0200
Message-ID: <20261015234125.3152346-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536; h=from:subject; bh=NWSf/BFzbgbgWUKwXp35PZz9dmXpR9qjJiaJQa2uzVU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3Ct+K/+qKTv36d1L+pS8zcmq/d3f2SFdK+QfbrjRs+dV 744XHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIbgtGhkYtKe1X+8413ph8bMpplk m3crU9TzZ+3XJZ+jw/L+PuiZcYGY64CJTvqVxr86mG/TyP28REY4fTh+czPrm8Ks+L7ezac/wA
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

