Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4B4F30FF
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416138; cv=none; b=DmZzaIQP009NgeH62CJQgHhV8ZpCHCmAYBoOeS1zQvLaWfU8VEWaPUyNpjm/lySC9I0XwLla9wVzJI2W0KBlDekb1W4plolVDvtVn7IueMQzvnOZ6JlmKiSvLbjBMVNfNynYDmMiGPW5Xe90OmZ+xihT4esVeEZJfYPH5uYfP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416138; c=relaxed/simple;
	bh=NWSf/BFzbgbgWUKwXp35PZz9dmXpR9qjJiaJQa2uzVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/cjuhDdoIJnFsWJFjSaq8tcN78IIy2ycczvcsvWiaTCmF4T/MleTc22q/iLZW2i2gNsRdNPly7ekSEu/SMpYXGdMf5ehgqb8BR/w4ox7y0Y8LchnLwMGxUBU/LEvlmrGsV7NDbhJbJtcKdYjQLhJFvUQwyiFvWC2lFt03fcyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnxmVj9k; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnxmVj9k"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-49e545b61f6so787965fac.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416136; x=1793020936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/BxRK4PUDB2ek3xhfb9PwSjtR7+rFj/bTjbadDEoVY=;
        b=VnxmVj9kFHqiXtCtUP2lkEOWo7U00zVpPh9767ayb+X28rNeEgcScRdJDuIhKgIFS1
         jMRBXTx0fQ0syw4yLK7Hnt1dV4Sbly0NcPkXCQmGucX0dNchxm+eFFz72ECzuOczP+kz
         zMcoyxIY4FcBYcm2nWHxZ3HPmKLUS4ixnoymMflDnRnYHzF3RA2foxXqVSlAnUt+4+fg
         8e6jGFEQjpRBPPdaJbmhJJItCIv+ue4ROVUS1aleg+5RmtwsulMFhji/8biE7jATJSVl
         YHxmeLEy0CKsX+/0fO6gIe9Iyf9K41sOl/NDjasEKcWZ9JfI+q8Im7MeG3BC3WNx9jTC
         OBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416136; x=1793020936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/BxRK4PUDB2ek3xhfb9PwSjtR7+rFj/bTjbadDEoVY=;
        b=yTIF1ePt5u8aN0leSbggCKojEaeEWl6dw4+Zj3dmBOxpTVLdf7lzj5PTCGxHRpOLF2
         gYqd6uYyvEX43AipFcayXIN4Jbml0zjUjm7PgKMP9owEvvZ5CrrpmhiycDfcbZNfAc+K
         ED916n4BEzUjMODCNLCTYornKAOL4Nj+T2TzCulUYRemRCzk45xSEY0uVuIaD1z0bK9u
         XfAhnZ0oo13dsY47+GOV/udLoetDX0ozlthTceekvzDN5ZEEwyKlb0FjRWUxtGcCbc0t
         sn4r7vguUUy7Q4EEERHatVnEGqMFPk5t1QG6SPQfF9VHjGV6HaNrQpOnELj29bA2dqig
         3BQg==
X-Gm-Message-State: AFq9FYJ6+Nm/31yG6prSZn1pFKliLBBEIavFRYWAuegyqBUuaNKh+ri5
	HuFSRmG53tnXzPUtNLR11QD+bJY2vEpL+iyOQ0oB/jiFoMH6sA+A1D/2WE5JMnbN4Rg=
X-Gm-Gg: AYBFou2Xp18Jo3ODLLyE/SAR5ZoJ9zIl7H20Hvh7e7baro02DW4a1DMzMtaBFz40rOl
	Ohsh6dR66EmuAkY79fD9iqJ1ffr2f2i2GhS8TK7UDyndFAMkd/w+DAUk/hW976tNVaVZqZkraW7
	yQOA0C1Qz0/LEOZJxzcS+em39ru3rmojXVC6t3mSKomNGx+01rHVgu8Wm0gBdfS+Bo0+ZxUEkcr
	FA6AdfsbNF2eyYCao9knZEUdd0PIaswFzE2KqXCdIyWx0UCIBp2rOsb+sj/Xfg6vaG1eOUo4G69
	JSolkTcGpV6rzw401jFWmp8pMGwrEcQxI+HhmXQv1Xh7Kh1NrncqMJcJRo8oFC6EQcKDPRY0JB8
	Rj/IQg19IoqWaMq6SZgjfCbgSOMZb2wt6seLO3yZvocGphQy/fZ76SiRQ0mUVTBoyIeC6110Ufs
	Gs6XqKZTOvrCTTEJqzksqNIdI1o+gYHcX+ZxstfGGOtTqjzaC7kVDDLHcXTNpAnYmHIWl/cHjQ/
	rFGZRhJ2UkhPkZF899eZhgb7qrtT/8QO/3+CDVmXIpuymDOQmeLkmvR+67M4j1znkQtuAPldj63
	Vuw0YQ==
X-Received: by 2002:a05:6870:8188:b0:494:b8f4:9a3d with SMTP id 586e51a60fabf-4a757adec3dmr6585407fac.40.1792416135673;
        Mon, 19 Oct 2026 06:22:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b5b2e59sm8306348fac.3.2026.10.19.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 03/16] libbpf: Keep the fd_array fill index out of bpf_program__clone()
Date: Mon, 19 Oct 2026 15:21:45 +0200
Message-ID: <20261019132203.3034698-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536; h=from:subject; bh=NWSf/BFzbgbgWUKwXp35PZz9dmXpR9qjJiaJQa2uzVU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxBF+K/+qKTv36d1L+pS8zcmq/d3f2SFdK+QfbrjRs+dV 744XHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIo7kM/9NeS30w3fUqvEv7Tutx85 fuJ0TqxQqvXv2ydQNnQYQc63+Gv+Kfrq3KW/es7tAsRo2KJ8KL1maWeb1rCD6+XFdp1/vQiYwA
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

