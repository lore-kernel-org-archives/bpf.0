Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767786;
	b=X4kIM5c3UDW84HGO0epQm642ocj6dc61dcuVdNusvefU97soFJnqVGOmsfePu74N5YM2
	 IqfxLyAjpslspxZZpjL6gNqTr9plX/lUDEAmDRQMFFuJMoiVqgaUGsA5/L9TQX5FTpGUW
	 oVzpVRmubFPtZQDb6PTxd/EZv+KS4QFokSfKfhi8wcPevON1jkH97PgJ89CamaqSJ2w5V
	 PsHIv2OV/0wTMfvFpiQa89i9BmfsMzG1603hGoA8Xe3SZ32+ZxyXRH0V7Fcug4y2GmzN+
	 ljxOFL02u9SCvUulYCJ1Z9eNRjm4bW05IFSWU9OPn5qVlyCNl4cCZmgpDuWAy9a+Faw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5srU9KuoWXxcaypVXkLK2x8NeJjOnkNpyrYYVuLHB/c=;
	b=lZEjJ7HhIwYBhdii2R5B9vSAb6WbBqGdNf1cHBB01OsI+ZZ4siUWsMTb2fgDUFwFtCFk
	 Zy9tcZvfYMbnyfktxIupaLHIuDaRyTEy0KvdNqN8+rjr41UsK3uJ0AGhsrxbh5Zy3RgPn
	 mSgZHrbHrz97IbTdkyhP/w00zmL99BvCsiGYmTb4b96kxW2BO0r0ytmSX8XAxm2VHhm+q
	 ga5Ya1srBjuklCi7LX5ZAR7e065TwyuhU1edoljUenKvD2o+QfOTf9Jqf8my944WnS6vD
	 fGmptZ2mjBYx6OjiLPY17DE709lKl3X99o4qLv7LYU90/I38+fkImk1prvYGgEDPfVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XnB5Tpve;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B88606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 15:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B88606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XnB5Tpve
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9e53d011eso7126415ad.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767785; x=1793372585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5srU9KuoWXxcaypVXkLK2x8NeJjOnkNpyrYYVuLHB/c=;
        b=XnB5TpvegB8gTIsvo3NCu6W79oBOOYJO/KlXAR0HcdSifqCBdiU4ZlzEZ8l0iPSNnh
         wzxfyt8pTzwRbZebEtIpil7emjXJOnakSS6ravvdak5QDsY83JAJzFSUd0sE0FFyhwjk
         Ranwt6RZL/aF0Hg+DnpyUc/f5ol6tTZJZj0zo9yO+dn/1iZS5WGy61ebuJgwM95g07C/
         jHXKjapxP/oE58UxqZ4gUa8rtUaOuXxpOar6gSRu8EwwqEHO4tNst6SyAeBUp7Nhr7N2
         XjhcA8nUvMkC+V6EVrZ9MZN6pih52ooLaBhEjwWoEeNOiyWd8Ur5/w1h94Nmo3cKECy5
         Qu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767785; x=1793372585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5srU9KuoWXxcaypVXkLK2x8NeJjOnkNpyrYYVuLHB/c=;
        b=TXEL2+0JZJoV3UblNyklzM/F54H6PAuIvYZcpVrjmw0LOoOX1fdbK3uOk0pRDgB2+u
         wFM4Ompq98b7RRVZYTT6oJMxXxd1nn22aB+KKkmRTjQ1J3u6jD0hSr97ffE4VV7Mm/+z
         ZzWGsaBmVRKvJGQ5UduJM848OUC/7KK1j6E692zGSNow2PYdVWRJ/Iuio5/uHibe3A2D
         4VtsHrZpBAxxMUYz3and7ujdYyiQZJTy5GNybnjnhH39R0H1IG7RdzSf7C2OKPLnurVt
         5nEYcXbvPLZ36OeQvh+6HVZxUgP11+/PYwFoep7l3wDtww6mFwCioYZXuiQNHxw+boQB
         rRTg==
X-Gm-Message-State: AFq9FYL9gwLILyWav5IjdTlxeBFl3NGFCT2XT1L9gCacv9Lh0TG86Ozp
	1Kc4li28epTrBFm2RM1wDiam5VIwn+fT5gsZECVvLqPTqhPLLF8ISSFCWjevIQ==
X-Gm-Gg: AYBFou39ylQFVqw5MrQwrmAh7HgeMni9i4xieUAGwBey9O0q3wviGLhccMMpurkZA11
	eC5x5x/HxuNPi0FUpvaeZMDPX5TvRoB68E9guHiT5XlkDFjX/rVmTR7xB4FfqCJAUXx+jww9E5F
	0+NEU6Tj5nzAPJmMlUDApDnO/ZwWGRs7RG/kQunew+lYz60d4g8fMZcDm5SHTzw0yjHwdVN4P5p
	lC+Oa7mZr8NE30/uK4sitT63MvcXvo/WeVQ9aa/puQEvwPoKaqN4UbTw/mT9aFy7wxMZUE/hUPI
	J3w6tEL3T6cQweIqu9QIXgdtHQQFI8D9hBBVV0M7aE/37GdJM1jbZf03xCNsjvStebd+mhZW9hv
	U5Gb09vMg13/lVxCaT7NIssBx64gXlPJhUo6C+QFbn1QGuZRO1HoIOvODJIel7ctl928TkglScV
	+Y/zkk4MQyElFIeoDMAfoFypuZWpWd0Pk5+fYxARFwKOo5snfpUGBM9r+OtYuDu4emsVZtFGtO3
	EqHKheUJHD9OAjtCj9dd0Q613CH52H/xP1AQdsWi63bxuzp5jbeoLFZMIzAp7u6QgAtBvdtmumz
	4dPXoULKlC1znLIcMXlX7v2kpzIIfXpKbCcNS4A02HRJr/Ma3qTlaVnefPQxkNiAQ08DUiw1m2c
	ttYNdSAZD0KFfXIYt0fI3flDa
X-Received: by 2002:a17:902:cec8:b0:2e8:4066:d247 with SMTP id d9443c01a7336-2ea7cfdd92dmr23755465ad.33.1792767784917;
        Fri, 23 Oct 2026 08:03:04 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea947307a4sm1383545ad.22.2026.10.23.08.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] bpf: Don't re-sort subprog_info[] for every new subprogram
Date: Fri, 23 Oct 2026 15:03:02 +0000
Message-ID: <20261023150302.4097865-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

add_subprog() appends new subprog to env->subprog_info[] and calls sort()
on the whole array, though only the last entry can be out of order.
Move subprogs that start after the new one up by one entry instead.
'start' is unique, so the order of the array doesn't change. The new entry
can land in a used slot, so initialize all of it.

add_subprog() returns the index of the new subprog instead of the last
one. The callers check for error only.

It's a trivial prep for rust-bpf [1] that bumps BPF_MAX_SUBPROGS to 1024.
Rust crates have more than 256 functions that are not inlined.

Time in add_subprogs() when veristat loads sched_ext schedulers from scx
repo, 8 cpu VM, usec:

                 subprogs  before  after
 arena_selftest       101     386     27
 lavd_enqueue          52      96     16
 lavd_dispatch         48      78     11

[1] https://github.com/4ast/rust-bpf

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d2056218..676566f80d97 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2605,12 +2605,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	return &elem->st;
 }
 
-static int cmp_subprogs(const void *a, const void *b)
-{
-	return ((struct bpf_subprog_info *)a)->start -
-	       ((struct bpf_subprog_info *)b)->start;
-}
-
 /* Find subprogram that contains instruction at 'off' */
 struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off)
 {
@@ -2645,26 +2639,29 @@ int bpf_find_subprog(struct bpf_verifier_env *env, int off)
 
 static int add_subprog(struct bpf_verifier_env *env, int off)
 {
+	struct bpf_subprog_info *subprog = env->subprog_info;
 	int insn_cnt = env->prog->len;
-	int ret;
+	int i;
 
 	if (off >= insn_cnt || off < 0) {
 		verbose(env, "call to invalid destination\n");
 		return -EINVAL;
 	}
-	ret = bpf_find_subprog(env, off);
-	if (ret >= 0)
-		return ret;
+	i = bpf_find_subprog(env, off);
+	if (i >= 0)
+		return i;
 	if (env->subprog_cnt >= BPF_MAX_SUBPROGS) {
 		verbose(env, "too many subprograms\n");
 		return -E2BIG;
 	}
-	/* determine subprog starts. The end is one before the next starts */
-	env->subprog_info[env->subprog_cnt].exit_idx = U32_MAX;
-	env->subprog_info[env->subprog_cnt++].start = off;
-	sort(env->subprog_info, env->subprog_cnt,
-	     sizeof(env->subprog_info[0]), cmp_subprogs, NULL);
-	return env->subprog_cnt - 1;
+	/*
+	 * Determine subprog starts. The end is one before the next starts.
+	 * The array stays sorted: subprogs that start after 'off' move up.
+	 */
+	for (i = env->subprog_cnt++; i > 0 && subprog[i - 1].start > off; i--)
+		subprog[i] = subprog[i - 1];
+	subprog[i] = (struct bpf_subprog_info){ .start = off, .exit_idx = U32_MAX };
+	return i;
 }
 
 static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)

base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.55.0

