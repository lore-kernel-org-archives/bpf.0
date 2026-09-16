Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECC047ECDD
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593703; cv=none; b=glpglWqBzAgxejLBEG7fZG6isA7snGb8Ewd9SyedrE7aqL9HG2iKYwWEmvAO4l6hSWlT+6TPUQpjKruTBG4zh+uNAlqi1mgXTE4N5wYAkQa0pZ9AtTKKynKN+/JtII9Ss/aN0BmW+bplU8zKLQU1lcfyppicFYnQGzHk+PwrQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593703; c=relaxed/simple;
	bh=J6DLyFJwVFLZc4nxdNn2lz7nxCbemOUYpTK/01sXfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/TpGZJ2kFsJN+vnWJC235mJ0VDBOqoWlAuymXPt59OKjqHdtN/ldLFKwv0hi6enwpNahMs9yk8SWmAqGDtaM87PtWAqDW34EW/s9iEESeIjmAmJzKgFegzIoYIY33q9bs64dTTWAvxksQqb1tgnSC3D5Rn8VFP83q2EnNmJ5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwwH0/sp; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwwH0/sp"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499c930cb9cso442535e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593680; x=1790198480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3kpIJNizqxB2qWInAAS+MYGZhpffsKBqS99TtmYKIpY=;
        b=qwwH0/spillY3XbTY5N7meDUaLYnRvuW+Lf6AAi8FfhVHOnreLTJZLbdknLobHwU2T
         kXqgChx5/XSstApPCaaV+nzWhmp8Gd3A2oUj7YsT9yzyNpcc0qU6Xp/vYHCsav0IOoTX
         eMPLkArdntyT+D44m/GHK7U3bvQ0vbin5MwUrRvNy5uGbHTjt4H/KlY9IF85yefmlBgj
         HY541B9iL4h6eyAuL+qdFB8LZA86vbg6pJqwcVLGXct3TkzrLh0VKF3PYSHNE+3hE69W
         CU5tbAFwnLsGopOC+WugclJb4nQAzpjTkPdFjUdKXSj3MXuH9eJYROY2bd12BXAuQTJe
         vC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593680; x=1790198480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3kpIJNizqxB2qWInAAS+MYGZhpffsKBqS99TtmYKIpY=;
        b=t1bon2d7yAfsmCURvfm63hYTp6UahrLY4IsvaDEd5wpg2F6A4Cqz4/ja4YpL96KPgi
         BTCm9Mf5TK8BszceSiC8YvOgYeehf8m/7RYuEBwA2kor1S4GwQLBmdAJm4M7RLaEgVer
         jJ1ABYZj+orS7K8xYKs1BpfAg/oYx25TWWPqKc1KSJZufB8f2+n8sptdixcjGIe0V/pb
         TiJ9x+ZdC8hBVNvkd61cjVbk6M/Zn0+qM9DvQr0ekifU1hIzRZ48zZoOo24ocpGbbGjE
         Bg7+bmVcB3ibCKZEZtO9h1v9j3JYz86QzQ19qihJia5IDUr0Snb8aKq4sBrA8Ut5+GAw
         F+Xw==
X-Gm-Message-State: AFuF++nRYS3Rk52gCqzbbX6MUaL43UpZU/h41Wq+wbyarRFTfGZX4bTK
	TVR+iil19su8BsFH57Ra1uyH34B08BZ54Tdb7qOvEwgWlWatQh5dC+Zfgiqa+0P2
X-Gm-Gg: AYBFou0gS0Xi6ksyt77a4DgTh0bjjncBykliiY5i9+ufPt/2+7sVO4P04ScdsI9v0or
	EvGLB3mCfG7BfGHtrAL9IiIU6Na523QKCinAH7iTYUauw4NpLAJQLgV7VzD4RyzWAnRIRU17PrL
	Xr2gGphkYBMMWeP+VZTv59SA8jZtSKYSAaOzZzZdHtEwLan5V/QpzaQP3TFKzr1w569F0nHhVwH
	4qu8Y+TF6wzKI/8UHK0qK8ZLkujl8XNZMbk7kqMuNMzV/RINguWtyDrJpYr+Ths2I4Q/N1gcihr
	HW92CCO01qu53QF71XPj7bjItnQQkSUo/n/7z46rzLKmOaE4MVYYuAgXifKxk1qbBXpkI4mdwQ+
	DzdC5zvJagrt3ASgW5fuFkex8OllELU81jvkG0DkwwlG3XZFPF0GR99SnMjeWm66OmFkLzG1uo2
	1sek5j93/37Rl5xMX5EHVDu6f3fvRNoCwjOANDiJgli4mq7c9tPUvMxzM57ZKZxf9fKmREH88QC
	bQHWLGf2wWMXWxcR/+P6M4PIwCfQr+YAERpfASWr75Xpt6Fw33Im8Dp38FAlYqzi3uoB5eX/75K
	3iFP1zqOmkKTWMF4lC9XXEEVRJ0lo2TP6jN0gf1emGyg2jEs
X-Received: by 2002:a05:600c:8b61:b0:49e:6891:27a8 with SMTP id 5b1f17b1804b1-49eb732e411mr45732175e9.25.1789593680487;
        Wed, 16 Sep 2026 14:21:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm19043185e9.13.2026.09.16.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 10/10] libbpf: Reject truncated ldimm64 CO-RE relocations
Date: Wed, 16 Sep 2026 23:20:57 +0200
Message-ID: <20260916212102.597335-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=memxor@gmail.com; h=from:subject; bh=J6DLyFJwVFLZc4nxdNn2lz7nxCbemOUYpTK/01sXfDQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h4KdwpTHfzQiP3/V1pXe+MV3QcqzB9vPu/NZ3P+5t deWoWxJRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACaSOIHhn1rZj6J8R++uXTGz vt4+yy16tqXslte/57HJLVt3zNrlPIeR4fAElnxXc83JNid2NBUJH2R+e1bM8VyXedGChkm7vu0 4xwEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

CO-RE relocation of an ldimm64 instruction operates on two instruction
slots. A malformed BPF ELF can end a function after the first slot and
attach a CO-RE relocation to it. libbpf allocates the instruction array
according to the function symbol size, so the shared relocation code would
then access beyond the allocation.

Reject a terminal ldimm64 in libbpf's relocation loop, where the program
length is available, before resolving or applying the relocation. Both
resolved and unresolved relocations validate the absent second slot, and
unresolved relocation poisoning would additionally write past the array.

The in-kernel caller is protected by the verifier's early instruction-stream
check before it applies CO-RE relocations.

Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/20260914140852.03DA21F0089B@smtp.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..bfa64ae6c94d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6206,6 +6206,13 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 				return -EINVAL;
 			insn = &prog->insns[insn_idx];
 
+			if (is_ldimm64_insn(insn) && (size_t)insn_idx + 1 >= prog->insns_cnt) {
+				pr_warn("prog '%s': relo #%d: insn #%d (LDIMM64) is truncated\n",
+					prog->name, i, insn_idx);
+				err = -EINVAL;
+				goto out;
+			}
+
 			err = record_relo_core(prog, rec, insn_idx);
 			if (err) {
 				pr_warn("prog '%s': relo #%d: failed to record relocation: %s\n",
-- 
2.53.0

