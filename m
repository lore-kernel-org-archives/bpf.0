Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7972D739C
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228844; cv=none; b=RtD0dulkRXzcKi86b+CJ5admqY6TcXPsQSuh4c+ZgmVMRBYTRZN4AbeilBff4WCRHOFcgac6SwoHbeevutf9YH7pstK7r+h5X615y4gYMoOWf/hw/khuKAjVbnpm8K1XgC2Sci2QeDR3ebgzPn16yAauVbdP22slnozSDBtR6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228844; c=relaxed/simple;
	bh=4orO0kBbRGysRZb4FYdyVW/U4nlYAY4iwKrnckB+/Bs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=giMS0ztUgg4MCYw6cM4bcDamq5GIyDn3sAgjmJUKOxHlyz2iIULtXgumVlUr323RkkA4lvSH9UHmBdFZ3bDFQNNHc2TzgneDDJLfhWInACnYJ53H0vJcHkfzEweNP+c2eU43LQUkw53xJ9lpfdjTNlJCzVDGJ0MTsPDLKQwa6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCwnNmT7; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCwnNmT7"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45ef616db45so8465f8f.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782228841; x=1782833641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQXipYJwwAnz5pv6rxzKuPhxUsrLIL8tTRQ6WSQQphk=;
        b=ZCwnNmT7Do/auPnXbfTLi+TRJwqW0qPOyHfTPdG1CsxutwLJ2NYfRCRS4DrbpfZH9k
         mnRF1L+K7jODRvXLIDYYew0kT7bxQRwuDpA46ksrzYNd/d6PUsJU2bNoBhID2lr8ZV0F
         Ys/DfGy2A5QK0xxy4OSbGsP+oRCrPc52bNU+hysW/kA+mBXWkwM9fIofHJBQxtRYhxTe
         LjkK6c77o2f/C1ZVer5JjRzHRLCarxH1h25s8VnQVTW9UfKZVgK0anzLSxcp+hrD2YjA
         gei0Y73dYajSB1u/ZnY1C60IM+0lku7adWmiiMbQW78VRkcW/NkQ/eOkS2vGIoOkNer3
         7KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228841; x=1782833641;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQXipYJwwAnz5pv6rxzKuPhxUsrLIL8tTRQ6WSQQphk=;
        b=UbczV4E8o61YfCwJGLZZJNrd93Sa2L4jo9dES6XV8VV/dBECW2rw0kijxAB0knzgrK
         8nJaPhrVlu3gXVb20Ea9j9T3TX9VaoQXp3CrSOeAqN6tts7xgqBr5rOnutRQRjQDAimV
         NsRW2fKq6s8THIdYyVHm6lVzq+O+z/plnQlW6lbQe6Ub9wewvGw5//Eff5caoYO0wRpK
         MqUCFlb3D9JW1diK9AEhjiyvv+9nQv1z/u3O23BG8Lu0zgCmb/Emsg7JBj35vkUDijjp
         PmFSBFmSzmZLQ6KzX61fOmJ0hHmzhPEOok8i2UUHAwQxHa1qlx6uBKiCvYUurVlzchq4
         qF7A==
X-Gm-Message-State: AOJu0Yx02Xc24g6T9s1TJcEUPSrAzcrw93SmgGDW6ZY5rzIQT/a8uTJL
	ScqIkYJGTDl2O2scDDn2vNTtMqZ14oMJVPA203jgrKjMCXDwtVm/M6Bf1rrkEXJm5Gs0A0Oz/P8
	qncCwvhQWRKEeNwvJdQ==
X-Received: from wrvz1.prod.google.com ([2002:a5d:6541:0:b0:45f:60d0:5158])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4a1e:b0:452:273:5cd6 with SMTP id ffacd0b85a97d-46adafbd2c6mr5226828f8f.1.1782228841110;
 Tue, 23 Jun 2026 08:34:01 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:33:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGKnOmoC/3WNQQ7CIBREr9L8td8A2lq78h6mCwofSsTSgCGah
 ruL3bt8M3kzGySKjhIMzQaRsksuLBX4oQE1y8USOl0ZBBMd64TAaTXo04M8GvemhEoazWV/0qQ EVGuNtBdVuo+VZ5deIX72g8x/6f+tzJHjRbGr5G3fTvJ8syFYT0cVnjCWUr6VKP5TrwAAAA==
X-Change-Id: 20260622-bpf-lskel-fixes-cafd1a83dec2
X-Mailer: b4 0.14.3
Message-ID: <20260623-bpf-lskel-fixes-v1-1-90600b40e7cb@google.com>
Subject: [PATCH] bpf: allow BPF_LOG_KERNEL from kernel space
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>, Matthias Maennich <maennich@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Neill Kapron <nkapron@google.com>, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

When loading a BPF program or BTF from kernel space (e.g. using a
light skeleton generated loader module), the kernel module may want
to output verifier logs to dmesg by setting attr->log_level =
BPF_LOG_KERNEL (16).

Currently, any attempt to do this through the standard syscall path
(kern_sys_bpf -> bpf_vlog_init) fails with -EINVAL because
bpf_verifier_log_attr_valid() rejects any log_level bit outside
BPF_LOG_MASK. This prevents in-kernel loaders from successfully
using BPF_LOG_KERNEL, causing silent failures if the BPF object
is rejected by the verifier.

This patch modifies bpf_vlog_init() to accept a new 'is_kernel'
boolean (propagated from uattr.is_kernel) and allows BPF_LOG_KERNEL
to pass the validation check strictly when invoked from kernel space.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/btf.c             |  3 ++-
 kernel/bpf/log.c             | 17 +++++++++++------
 kernel/bpf/verifier.c        |  3 ++-
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 39a851e690ec..eb9d2a556c0e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1059,7 +1059,7 @@ __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 			    const char *fmt, ...);
 int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
-		  char __user *log_buf, u32 log_size);
+		  char __user *log_buf, u32 log_size, bool is_kernel);
 void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
 int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15ae7c43f594..69ec32f99457 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5926,7 +5926,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	err = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
+	err = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size,
+			    uattr.is_kernel);
 	if (err)
 		goto errout_free;
 
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index b740fa73ee26..92584a314129 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -13,8 +13,12 @@
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
-static bool bpf_verifier_log_attr_valid(u32 log_level, char __user *log_buf, u32 log_size)
+static bool bpf_verifier_log_attr_valid(u32 log_level, char __user *log_buf, u32 log_size,
+					 bool is_kernel)
 {
+	if (log_level == BPF_LOG_KERNEL && is_kernel)
+		return true;
+
 	/* ubuf and len_total should both be specified (or not) together */
 	if (!!log_buf != !!log_size)
 		return false;
@@ -29,14 +33,14 @@ static bool bpf_verifier_log_attr_valid(u32 log_level, char __user *log_buf, u32
 }
 
 int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
-		  char __user *log_buf, u32 log_size)
+		  char __user *log_buf, u32 log_size, bool is_kernel)
 {
 	log->level = log_level;
 	log->ubuf = log_buf;
 	log->len_total = log_size;
 
 	/* log attributes have to be sane */
-	if (!bpf_verifier_log_attr_valid(log_level, log_buf, log_size))
+	if (!bpf_verifier_log_attr_valid(log_level, log_buf, log_size, is_kernel))
 		return -EINVAL;
 
 	return 0;
@@ -831,8 +835,9 @@ int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 l
 	char __user *ubuf_common = u64_to_user_ptr(common->log_buf);
 	char __user *ubuf = u64_to_user_ptr(log_buf);
 
-	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, common->log_size) ||
-	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
+	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common,
+					 common->log_size, uattr_common.is_kernel) ||
+	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size, uattr.is_kernel))
 		return -EINVAL;
 
 	if (ubuf && ubuf_common && (ubuf != ubuf_common || log_size != common->log_size ||
@@ -878,7 +883,7 @@ struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
 		return ERR_PTR(-ENOMEM);
 
 	err = bpf_vlog_init(log, common->log_level, u64_to_user_ptr(common->log_buf),
-			    common->log_size);
+			    common->log_size, uattr.is_kernel);
 	if (err) {
 		kfree(log);
 		return ERR_PTR(err);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281..9e76a02323e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19755,7 +19755,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
+	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size,
+			    uattr.is_kernel);
 	if (ret)
 		goto err_unlock;
 

---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260622-bpf-lskel-fixes-cafd1a83dec2

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

