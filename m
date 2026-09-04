Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7C4D8D8F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533671; cv=none; b=SqLFAvpDUDeYlxPG1SDNgss8zYelPvC7tHXq+L5/aSkQH/IgqnlNqpUXTXYUpSMNYyY7jbOmD0uq7qfSrULM2/xzN+WlJnoopzwDionl6pcN2ImpL7nKBdk+28Dx6FGV6vgr2EH66nrlaGav2QU8/7Q/AlVlVRJDzDNlEYt30CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533671; c=relaxed/simple;
	bh=MpokLl5CyyQMTIasgPBtHRcPtVgy8CVCZmAYa4Qjsxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjFKenLk/JUuyH9TWAItdbj6o7LFylS6X548ESM3fCXMVt4xt/e/WLJ9OOeiyvuTjqdoccYXjgOHpaLv9n1+Au1rVHd7aYwHaKJJiYJIB0kQqVHoZ6OpNlp8ssIJK29A0ycL1gwStcuBAqqq/vADw5vmClv8pES9Sq0YSpNLUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckVNCvRM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckVNCvRM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48444ec4fe2so705309f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533667; x=1789138467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TWn588bvPgkOg4s+MpXI1REAHLgHCTvpnRnhLr6d9ks=;
        b=ckVNCvRMf9fz/rUVaoVnVLEBzt9Ewiihhn/eMLivyTnUAAtw/k4pgzGYWslnvW4aSD
         3bNaZDVUdnqhQ+/X6Fv7PQ6M54JGY//hLtO8CBmmgToS9hLMq4yBmeOgKbNWelRO6ZxV
         N936rpgIExv7uTld6eomtDVA81/tfQX9vJZ8jmHsgGKScMl9iLeI8c9gYxENwHq03Sao
         RgF9tBrzhaDfydESFNNEhWbFP8fjyYljty3STRX4APgsvAutcCY3DyZedA3p5aYS55+T
         zzg7cdPNGBek7/atx7TN23zig47o0HiqU8qxlhfmsIy0uYP3B88KnpK7vsCUgLZQD1xk
         X16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533667; x=1789138467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TWn588bvPgkOg4s+MpXI1REAHLgHCTvpnRnhLr6d9ks=;
        b=OVixZILEosF122NE24MEIS67TEHOUveZzDsbWAb+Y4+Fwd4GIbFldSk8uC5y3JZA/P
         Fv0zCFoAb5hv+fd6CiBC0aOF8zBTc/T85TZ6E6eznVSErfpWHXFt3cC5Tt9j5SUk/hFW
         nUTsGG2omHwLBa9kP7FMQWT4IJfmID/RugMaNjkkC2BQtaqXCdvFXdeuibEYnAd+gzdG
         +1vo2PoSlJY7AQx6YNPHJGOCFplJKEImwVkqXRg1lfHVGrYKqzD8CDHGrFRM/Scxqk0T
         GF9cgQ+G8J+xPL2ux/DlGfVklIfnCupTF6ySwC2k0XrtKMKb6b4yFo5Rt2r1Vv9sJYw3
         V3tw==
X-Gm-Message-State: AFuF++k7Vp6RxqatnsTD3jFu4sVzR4MxEEHHdJ/I5cg93f6+rweGzEll
	+5Bcq+202Q+LGukr3h5n2Pe8tjto0OeZnesFYT5/QR1kQfyVG71EOa5TCFoVXmCIhsM=
X-Gm-Gg: AYBFou2nEeY3Zv6VlXLxtDfoqpIVeJ/XXh3lmWHDBfD0vqaidTGxB0AhZhDMNW/O1f2
	ToeOYBp8pC8LGubIJ23ppfYmReSdZyRX4Z2LrnX1aQYYoB/z/1/IpSdESUSSSHhM3NaGvW7xAq5
	qLkUgvTD3g5IhaUNpHMGtDYBa1T5/h5OcWdX/7lzhd0T2950yVai9JOiEySDcfS0qOWG7YLJIOK
	IAA6ihQgT+b2ZD0LlyZnCMdfZKOJ8xas3I5jrDff6OP43vbos5b/7T0EuOTDzJiVutxnvFZAswG
	j38vRO9vGPxZpQjmDisNpwCc5F7b8CUeh2C+pR2/B/4/a/IoCqItBw/O/QcMNzb+SbiO7WrQiqz
	dNyM4SeKDEEQ6KpCwZjBndEV/NQdA3P6nUEV02iJRXGYu5L7v5V4pOJoFpISiOJ+bUlHfuD5MSw
	mtsYRnbks8XI6FL2/dMYtRWFl4RtRcs7A0zYwb7maiFSCiP3UQTZke6LgdyKOfMwWSgidvRvurV
	A==
X-Received: by 2002:a05:6000:470a:b0:485:8101:dc40 with SMTP id ffacd0b85a97d-48587057037mr5818648f8f.9.1788533667239;
        Fri, 04 Sep 2026 07:54:27 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885cb03asm6802799f8f.37.2026.09.04.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:54:26 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v4 4/7] bpf: Allow reads through trusted-or-null BTF pointers
Date: Fri,  4 Sep 2026 17:53:37 +0300
Message-ID: <20260904145340.40212-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
References: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a trusted-or-null pointer
(i.e. PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL) has to be checked
for NULL before it can be dereferenced. Marking a field from
PTR_TO_BTF_ID typing to trusted-or-null can reject programs that
previously dereferenced the pointer directly. This is useful as we
need to mark new fields as trusted in order to pass those as arguments
to kfuncs.

Allow reads through pointers marked as
PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL without an explicit NULL
check. Treat these pointers as potentially faulting so the reads happen
through BPF_PROBE_MEM. If a read produces another BTF pointer, clear its
trusted flags and mark it as PTR_UNTRUSTED.

This applies only to reads. Other cases still require an explicit NULL
check. After such a check, the pointer retains PTR_TRUSTED and can be
used normally.

The unchecked read path has two consequences:

1. It uses BPF_PROBE_MEM, which is slower than a normal load. An
   explicit NULL check refines the pointer to PTR_TRUSTED and allows a
   normal load.

2. A faulting read returns zero, which is indistinguishable from a
   legitimately zero-valued field. Programs that need to distinguish
   those cases must check the pointer before reading the field.

The next patch updates current tests and also introduces more checks to
ensure this change does not break anything.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 include/linux/bpf_verifier.h |  9 ++++++++-
 kernel/bpf/verifier.c        | 12 +++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ae9f606539f4..d3d7254cc1f6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1326,6 +1326,11 @@ static inline bool bpf_is_ptr_to_mem_or_btf_id(enum bpf_reg_type type)
 	}
 }
 
+static inline bool bpf_is_trusted_or_null_btf_ptr(enum bpf_reg_type type)
+{
+	return type == (PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL);
+}
+
 static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
 {
 	/*
@@ -1333,7 +1338,9 @@ static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
 	 * protection, that is, the ones bpf_convert_ctx_accesses() has to
 	 * turn a BPF_LDX into a BPF_PROBE_MEM one for.
 	 */
-	return type == PTR_TO_BTF_ID || (type_flag(type) & PTR_UNTRUSTED);
+	return type == PTR_TO_BTF_ID ||
+	       (type_flag(type) & PTR_UNTRUSTED) ||
+	       bpf_is_trusted_or_null_btf_ptr(type);
 }
 
 static inline bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f585ceb2cd5..386401fe051d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6116,6 +6116,15 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
+	} else if (bpf_is_trusted_or_null_btf_ptr(reg->type)) {
+		/*
+		 * An unchecked load through a trusted-or-NULL pointer is
+		 * fault-protected. Any pointer derived from that load must be
+		 * untrusted, as a fault produces a NULL value.
+		 */
+		clear_trusted_flags(&flag);
+		flag |= PTR_UNTRUSTED;
+
 	} else if (type_flag(reg->type) & PTR_UNTRUSTED) {
 		/* If this is an untrusted pointer, all pointers formed by walking it
 		 * also inherit the untrusted flag.
@@ -6591,7 +6600,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) == PTR_TO_BTF_ID &&
-		   !type_may_be_null(reg->type)) {
+		   (!type_may_be_null(reg->type) ||
+		    (t == BPF_READ && bpf_is_trusted_or_null_btf_ptr(reg->type)))) {
 		err = check_ptr_to_btf_access(env, regs, reg, argno, off, size, t,
 					      value_regno);
 	} else if (reg->type == CONST_PTR_TO_MAP) {
-- 
2.55.0

