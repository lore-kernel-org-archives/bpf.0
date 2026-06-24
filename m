Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463C175A9A
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325189; cv=none; b=SkyR+RYzM8kPB3cU927E6+bD+dGyptz9rGgIvEaa0/lQ57bXLhAQqJvsDV7a6v0CN8OFful1gmjrv5iuV6nTocX2poAQ6J0z7NsDTalv6oTcxcL+7/G8OilKgn8VNw6VpP9k+HJYt+UK0+e6AJ/YdIOClrm12irbthZLwY21j9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325189; c=relaxed/simple;
	bh=RFKxHKwD+gMRDuk4YvEb41bHdl9pkWHKVKluZA6t0Mw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XwD3kFt8DfnQdBdDd02S19jy3nOvQ95Ib0FfQ6joBpQacgrf2nvb1kx4K9xMwf/elm4zbp6i1MFB9f5LJidD1C58B4ZN8Gr0M9uI4OI1bxa44IPJmsjjpf+g2EN3lPi5OYhA3U0waZYgML+tBSMzYVUXfDAEttHsa+zroXCA6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxKoDyr1; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxKoDyr1"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c0b4bdbe23cso11312866b.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782325186; x=1782929986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vX79rzquT66j3Hhp3dWwnzeUFqVjw98FHkyqz5+YNF0=;
        b=jxKoDyr11Q3eUGOkRzC5p6C1vaEz8i5NOygkBjfVfTx5brmbiW2pNe0vWK7GZ6ylAB
         n+V1kGwOYyBe5A+/M6hJZZISiUiWgrzLgXsgYWkjAl0/74fGlnZhdqxoRBezE8Nda5m8
         +MCmBRI+M5IifJP6ZFXlb1c0RAKM0kIUt7PiCNAw4ewF6Gz11hG6yyKSEr7kFMKg3vus
         2sBpd4HcnA+EqsLRbH2tnsCsyg8z8HHX4oUG0RCWUQcHfcrayR9Er6KD0n8ZTfZ1kQmU
         t6XkIkKEv3p7V9KIxbQOhq7djP42Xuhcb9c1xJSnjr7N5OzMihcPJ4pBt8bHPHGHmIex
         evLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782325186; x=1782929986;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX79rzquT66j3Hhp3dWwnzeUFqVjw98FHkyqz5+YNF0=;
        b=EUpSUBMf+i/Nfd9+HQLFPnn/WXxG5w3k5zcNd3Bi5ByqGX3q2Slnv/Dz3EbFqaniCc
         Fn11xyLC/WrpNB3EV42BqX+ZaRl0cchniDt/kR3QLwFPJnlL+AdM+ONr6stQ3HpDzn1j
         Zsl0KfLl6xdNGgwQHuRiK5Xf8oCDtXIUQmfC9XRSSGqo53vbthdtMmFQ86gn18ohL/uI
         TBIce6ehEjmCbsaWqeua8BXX7w8h7+V3qU0Z4pfG30o1WyFSvJlGWlC5Xx6cLTtT08Bo
         yeFqE3RfpD8Rp+cnFWQ0S+kTmeL7HkTKzvPcCWLKzUbzIHNSjhXCUGTV0VuL2MvAnFyB
         kr1w==
X-Forwarded-Encrypted: i=1; AFNElJ+rmZH9GvOTfUTjAXU86xjUWVkqESeOMJ2h+2GwVNXNYrsFpzWrvPEp4lQX76y53LSWCG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5BYWdBVovOP9VlN8hhQG6Hx+osr6FfMKNPG2lrwQ0iU2ig2rB
	FqDRikRm0BFltgoJzjgjMOxYIn9+95WFa/HbaobicfbkTOmy9Ad+r958grX0A/SV8JvD1BayHXG
	VhjZ1l0pvpM7BiBQJ8g==
X-Received: from ejbme6.prod.google.com ([2002:a17:906:aec6:b0:beb:e0ab:b990])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d1b:b0:c11:3fc9:ef68 with SMTP id a640c23a62f3a-c11f8d1e1camr97722166b.8.1782325186150;
 Wed, 24 Jun 2026 11:19:46 -0700 (PDT)
Date: Wed, 24 Jun 2026 18:19:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALwfPGoC/3WNyw6CMBREf4V07TW35c3K/zAs2nKBRqSkNY2G8
 O8W4sKFLs9MzszKPDlDnjXJyhwF442dI4hTwvQo54HAdJGZQFFgIQSopYfJ32iC3jzJg5Z9x2W
 VdqQFi9bi6CiidG0jj8Y/rHsdB4Hv6f+twIFDqbGWPK9yJbPLYO0w0Vnb+779EdPfYo0FosqQS q2+xXbbtjdF7AjJ6AAAAA==
X-Change-Id: 20260622-bpf-lskel-fixes-cafd1a83dec2
X-Mailer: b4 0.14.3
Message-ID: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com>
Subject: [PATCH v2] bpf: allow BPF_LOG_KERNEL from kernel space
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Giuliano Procida <gprocida@google.com>, Matthias Maennich <maennich@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Neill Kapron <nkapron@google.com>
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

This patch modifies bpf_verifier_log_attr_valid() to accept
BPF_LOG_KERNEL unconditionally. To prevent userspace from exploiting
this to spam the kernel log, the patch enforces a strict privilege
check at the syscall boundary points (btf_parse, bpf_log_attr_init,
bpf_log_attr_create_vlog), ensuring BPF_LOG_KERNEL is only permitted
when uattr.is_kernel is true.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Giuliano Procida <gprocida@google.com>
Cc: Matthias Maennich <maennich@google.com>
Cc: Tiffany Yang <ynaffit@google.com>
Cc: Neill Kapron <nkapron@google.com>
Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

--- Changes in v2:
- Refactored BPF_LOG_KERNEL validation to check uattr.is_kernel at
  syscall boundary points (btf_parse, bpf_log_attr_init, etc.) rather
  than plumbing an is_kernel boolean through the verifier log
  initialization functions.
- Link to v1:
  https://lore.kernel.org/r/20260623-bpf-lskel-fixes-v1-1-90600b40e7cb@google.com
---
 kernel/bpf/btf.c |  3 +++
 kernel/bpf/log.c | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15ae7c43f594..4a0c18112ad3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5919,6 +5919,9 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	if (attr->btf_size > BTF_MAX_SIZE)
 		return ERR_PTR(-E2BIG);
 
+	if (attr_log->level == BPF_LOG_KERNEL && !uattr.is_kernel)
+		return ERR_PTR(-EINVAL);
+
 	env = kzalloc_obj(*env, GFP_KERNEL | __GFP_NOWARN);
 	if (!env)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index b740fa73ee26..25a9f8340980 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -21,6 +21,15 @@ static bool bpf_verifier_log_attr_valid(u32 log_level, char __user *log_buf, u32
 	/* log buf without log_level is meaningless */
 	if (log_buf && log_level == 0)
 		return false;
+
+	/* BPF_LOG_KERNEL is an exclusive internal mode, not a bit flag.
+	 * It must be checked via strict equality to prevent it from being
+	 * combined with userspace flags, which would cause the verifier
+	 * to fallback to userspace logging and copy_to_user() failures.
+	 */
+	if (log_level == BPF_LOG_KERNEL)
+		return true;
+
 	if (log_level & ~BPF_LOG_MASK)
 		return false;
 	if (log_size > UINT_MAX >> 2)
@@ -831,6 +840,11 @@ int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_size, u32 l
 	char __user *ubuf_common = u64_to_user_ptr(common->log_buf);
 	char __user *ubuf = u64_to_user_ptr(log_buf);
 
+	if (common->log_level == BPF_LOG_KERNEL && !uattr_common.is_kernel)
+		return -EINVAL;
+	if (log_level == BPF_LOG_KERNEL && !uattr.is_kernel)
+		return -EINVAL;
+
 	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, common->log_size) ||
 	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
 		return -EINVAL;
@@ -873,6 +887,9 @@ struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *attr_log,
 	if (!size)
 		return NULL;
 
+	if (common->log_level == BPF_LOG_KERNEL && !uattr.is_kernel)
+		return ERR_PTR(-EINVAL);
+
 	log = kzalloc_obj(*log, GFP_KERNEL);
 	if (!log)
 		return ERR_PTR(-ENOMEM);

---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260622-bpf-lskel-fixes-cafd1a83dec2

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

