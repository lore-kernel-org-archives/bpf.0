Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031C2F1FEC
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379038; cv=none; b=ZFCZOkn38yrixrzN4nKKnqJif59o0JcSQVUMdByGmzgybRRlMipTlfGT4sOAdAd7EIE7pvLkqv7rLa0NB+CR6WrWgFTPKFWVz9Q+ZUY7uhrbsrj2SooWNsEdMAUaC/3jiyYZ756olLgPg02swo4/fDLLMJ+yWE9w1HCWjvSP/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379038; c=relaxed/simple;
	bh=9nOAOlTOisYqwwOSi9e2cqiUB9PWtP5arUyayXtety0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3haLcTIoMDaeAjmZxGBwijqOwsMf7FC0DSeBFoGY2hN9U4unrLPdSABmU1o56LSqw9mxMHW+ZqC2xAgAYvqK3JC3D8PSLObwc+++WNtEOHQ2e0wecbGNxYmPHGuwrus9WTCzm1LUNi6EFiOZD7D/bqb5NZj5ML268AgEyxK3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWw2EsDx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWw2EsDx"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so5058381f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379036; x=1774983836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LunrNXy2Z2HN5//xXICP0dSach9pKoHpWQJL2mrgD+o=;
        b=sWw2EsDxtIxiYeiiQ35nh7xwPSIE6ADW1DOH+xMzZ9/B/5Vqdv8Q8mJ1gyfDHsdqG5
         lyCy0uOxxrY5Jj7S0Yt5mQm/mp+dXbFLdZY8Yvi52Sha5ANtm0AGmj658zwnbcF79pwG
         a0+SkCGWdoIaVV9CYwpwkEvqckRPul2xDJzE+PJUw86gKI/45Tk79UDBl5lWl0ry33ka
         f+b9HlZESsPz5FyYDsTDYzmnpub5TRQIJA4HohATPL7LeOjgSQJLCptU6x56tsfN/hF0
         BAlJQ6E9nGwYhVeuWkfnAdbOMYwspJAKZTgpWqxVGzJzI5VwN4GwrdhGfeXb0ntBaana
         xbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379036; x=1774983836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LunrNXy2Z2HN5//xXICP0dSach9pKoHpWQJL2mrgD+o=;
        b=BYzLmOJZtTTO8WSxuPEvT9hhKRbj0bOdLVKHHE6HJAye8h2rOaMxBcHwOok0OMhaxa
         rzvHMdRmcJU43JgpKOWDJ988iSzZzk1SiPdDvBsbHDwC+yJ1NS+pqKQgOnY2AOGRf3D8
         7KBpk4u54UvuFzTYWlUnpZ8rhzrT6DPFwdZUgDTYVxEc7V3fc8zBgT9b8kBdBfOWFkse
         tS7fV9/0JnN6+kbhf52byo2hyTOFB+EDB+++4vJpe8K723FU52UtDYU5rhNMRKO/jiTF
         2ZMhBxsADoyEaBiVPqHTEM7+568WAEAP1j8uWIVAKhvFHKahZkTdbtxEJT+LOLO0e2/0
         8JzQ==
X-Gm-Message-State: AOJu0YxXoVr8u6nQKtS+xK6qon0+E4ISWR/g4XYySp7orvI5VEqN9ct7
	B4jWsuC3wOFEYvYtBkOZbNguNfXhvlOIg9bGK0D14snQ9+OcGqcoEnos
X-Gm-Gg: ATEYQzw3DA5e57H1t/FxI6yjKPpHG71Ymb9yYwzdUnN9hIdhQUhS9x3KF6bV5r7Zk6A
	ksRA6lRidNjH+zhoeVcH8VMV7vDSafFv4gtYGZLoIirprlLvXKFjn0foEwbMg79ilPBveIOAGbn
	Q1AwXT6Gjq0nATshefHyvXGiBqEEUirPx3XF6r90u+XKTUcbyLYc33XVV9O2XgvO3aB8e91l0N5
	7cPUevJsxNyHfiEjLqTjD6g/CrYzpSfM+uS/gHsU3Krqkfc2z1EkAMRKXRH+FQtpfUznS7qlkeK
	I+52U3ebGtaQPtETi5fvkgoV212W3KPVC1yU7PeG9t47U0JIwiLF+U/m60n3A4kYTeB1sFPRNbf
	jKlW21xBlUwKgP2PNE4sM+9YEGfSGamVUS4D900rkqmsQehSP8uW0AuCaEQlFDG61Bl8eHYIYJT
	ghYGti//k07CPrvIGyj9htK9I=
X-Received: by 2002:a05:600c:5296:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-4871605a92dmr13518095e9.19.1774379035660;
        Tue, 24 Mar 2026 12:03:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871661ec65sm4693805e9.3.2026.03.24.12.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:03:55 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 24 Mar 2026 12:03:42 -0700
Subject: [PATCH bpf-next v6 4/6] bpf: Verifier support for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-sleepable_tracepoints-v6-4-81bab3a43f25@meta.com>
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
In-Reply-To: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774379027; l=3358;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=d+hTYccHRDSzAvFALs2kdiRPOgGLqMJVSwu4/FZvIDI=;
 b=62Hynp4w0MqkqapRl8LQfXK1PFIKVljwFqM16HAtpyzb/WTwsKuZHYyOzNxgpHqPNH8ZRf3m4
 vkKbOH9JjbQC9xVtIxbN4kOoo2sXvfnjwr8ZVDrUP8xkVmBymJHu5NS
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Allow BPF_PROG_TYPE_RAW_TRACEPOINT, BPF_PROG_TYPE_TRACEPOINT, and
BPF_TRACE_RAW_TP (tp_btf) programs to be sleepable by adding them
to can_be_sleepable().

For BTF-based raw tracepoints (tp_btf), add a load-time check in
bpf_check_attach_target() that rejects sleepable programs attaching
to non-faultable tracepoints with a descriptive error message.

For classic raw tracepoints (raw_tp), add an attach-time check in
bpf_raw_tp_link_attach() that rejects sleepable programs on
non-faultable tracepoints. The attach-time check is needed because
the tracepoint name is not known at load time for classic raw_tp.

The attach-time check for classic tracepoints (tp) in
__perf_event_set_bpf_prog() was added in the previous patch.

Replace the verbose error message that enumerates allowed program
types with a generic "Program of this type cannot be sleepable"
message, since the list of sleepable-capable types keeps growing.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/syscall.c  |  5 +++++
 kernel/bpf/verifier.c | 13 +++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..bc19f6cdf752 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4261,6 +4261,11 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 	if (!btp)
 		return -ENOENT;
 
+	if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
+		bpf_put_raw_tracepoint(btp);
+		return -EINVAL;
+	}
+
 	link = kzalloc_obj(*link, GFP_USER);
 	if (!link) {
 		err = -ENOMEM;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c18f4268de..a4836f564cb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25255,6 +25255,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		btp = bpf_get_raw_tracepoint(tname);
 		if (!btp)
 			return -EINVAL;
+		if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
+			bpf_log(log, "Sleepable program cannot attach to non-faultable tracepoint %s\n",
+				tname);
+			bpf_put_raw_tracepoint(btp);
+			return -EINVAL;
+		}
 		fname = kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NULL,
 					trace_symbol);
 		bpf_put_raw_tracepoint(btp);
@@ -25471,6 +25477,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -25478,7 +25485,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
+	       prog->type == BPF_PROG_TYPE_TRACEPOINT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -25500,7 +25509,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Program of this type cannot be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.52.0

