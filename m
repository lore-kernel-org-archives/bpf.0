Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B683F58CE
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863301; cv=none; b=Le//mCKgHq1R0Em0fR30G1tusOA5kqkl2koXLU02TU4VbplkA/5X3RE9DWMnUlQuhaoIHt+ECpwiHNybonrOFaO179XPo2ZGjXNrakkSa8jWBQDi4jhchity2CT7eM1HvAmKYvwSUHOxk1V8nZ2IcZa5b5SBMpqCOrUWE6Kt+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863301; c=relaxed/simple;
	bh=TYh5H5FK67cM3RyT/EcJyqFe7cCfsGl3amyIj/1um6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlOeNTKtKpTORRejGNKkzX7ccr1lQuSbihEec+4Zl/Pzt4mcfkE/sxEA2PJ48W4XL7Nuk5wxzi5JDKfi7BRJ57pRGMfOe/3Uw8/gUwnf9o1UBnqgAlCtgk8Ev1s2s3G/tOW7ywpHpaYPmfbeNu8Te8XwePu81PhDyEtzvfuwZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKu8sc4x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKu8sc4x"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fe608cb92so5930745f8f.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863296; x=1779468096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BZtTgWJarhWGKiDqicgpgWq0ir+n4C3T28pxoXNooc=;
        b=GKu8sc4xms6TfDVjrCD8xUNCMU6jvHypBfbj5uZrqutvTEH6q8ZL0XDuSsfaGf999k
         hTTbBuuKOpta4sEdg6YuFsPICLaernWEpeSF2b4nf00OBtybkE0dVj2upQz1O6xXLoYI
         clQlBTYXfbd4c61g56m1hEMvJMDKlvIpM3goCX1kFVztXN48Iow9ddFqetxxrdQ3hfgM
         h224SZoscRbH4R66+eZK9gByKcyAtp92ZhiHpcQql2QVQkPbmKIVsmxVsV3Y4HNG5dFe
         VmRtTvKXwWJKfXMKnwqX0Rki2Z+ozb7iKXayuSndJiuZSrrIQHlf9NztvR6iKkKdL6jf
         qU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863296; x=1779468096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7BZtTgWJarhWGKiDqicgpgWq0ir+n4C3T28pxoXNooc=;
        b=bITtJLcozVWbF6fWmkD39IpztnlPgFfXngCpZgao5rp005uGibxp7/eRp02HSsgUqZ
         JVU8Ecr4F4JIHjx92HfuoNz1i2I9bO9efu5FAOETDubizOnORHrJi+yxBZk/HrkNF2GO
         GpcBTDCq+XJOZRbqAbkLb4baBPiEtZ0uCxr53prT3ujw5wue6rfVwfbRRNHhmf2FHCmZ
         MieUdnsb0+2ZV4ym2j3L9FZGVu6o9jKdNVwZi0B10wLuKzBdN3ClYCoI6EZ0ChN5oabn
         jLpaqALCusEYF6eGqdx4E4K7SLuRk6e6W09ne9dJKpvaSNAOnKBOtkwZSHEIpw9RTVc4
         cwtg==
X-Gm-Message-State: AOJu0YwuUAC8gE96CbmGvRifcZmCnd/1bQPiMd0aRUeu0IJu1WLUFSTl
	VZ5IDuwqqQfyhnNFwroS4ucJyxtsHtkxGaJrc+DgGb90lBd2gqEttT+hTnmO6AIQ
X-Gm-Gg: Acq92OHx/BJHdnh/CIG6WQFx7tGtFz4xM2xYx9H2+BOfhWr+4IeulQ5n97BXc6Q4V8p
	e8oMxy0GcpayVVKw0C7fwmHKhHj2lqWptArldBdk7wjTvNxYyoTHhR0zeBTdIzH/EoBaE5xFs8v
	156cBg84CVsUyfo8M0HRUQko3ATinh/M+E4y39YTyeCdLuxielEIEHU8ZGD59L8kXx59aXcgyvJ
	oehXVyPFFpdKAv5WZRELw5O6jPwn5cJvq1yUnMXMbIxn02q5x/FM6y0Fkt6MNEee3+aTgC+WH4g
	D7S6izgFO3rEtjRhrWOUMkLIBJZKls9nWlRDJFIWyCnWSOA5OzTWePTuqC0fU7Dj+2IU0y9yULU
	h7ccIjUj605wsUYtLU6auujF7aljb/4PFZCFbWFGIAiDy8pnD0To3OENS4RyZkEUvmxC6BmzZ3+
	xEADhOx5K54yxBag==
X-Received: by 2002:a05:6000:4007:b0:43d:1cec:4766 with SMTP id ffacd0b85a97d-45e5c5bf971mr6501447f8f.23.1778863295996;
        Fri, 15 May 2026 09:41:35 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:48::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm14667917f8f.3.2026.05.15.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:41:35 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 15 May 2026 09:41:01 -0700
Subject: [PATCH bpf-next 1/3] bpf: Export btf_get_module_btf() and
 btf_relocate_id()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-generic_tracepoint-v1-1-aa619fa94132@meta.com>
References: <20260515-generic_tracepoint-v1-0-aa619fa94132@meta.com>
In-Reply-To: <20260515-generic_tracepoint-v1-0-aa619fa94132@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778863293; l=2539;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=NIWCFO9BlrJMM8xctDo+1sOgxbgYwBN3s7DsfLZjN74=;
 b=eYA4Lj9C07D1qQIVbpYwVTZG1nNfHmzN4YFUH44Nqlxevt7If7DuOYhsL7AJzCrpIlLoCANby
 ze80IwwPgVeCYcCs+RyGDFlDz0pGkQuMQAiCrZ/t6K36+FhQYGSRBI+
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Make btf_get_module_btf() and btf_relocate_id() available outside
kernel/bpf/btf.c so the tracing core can look up module BTF and
translate ids stored by resolve_btfids (which are local to a
module's split BTF) into the runtime ids used by the kernel.

Used by the upcoming events/<sys>/<event>/btf_ids tracefs interface.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/btf.h | 2 ++
 kernel/bpf/btf.c    | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 240401d9b25b..273a93a3b2bd 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -235,6 +235,8 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p);
+struct btf *btf_get_module_btf(const struct module *module);
+__u32 btf_relocate_id(const struct btf *btf, __u32 id);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
 					       u32 id, u32 *res_id);
 const struct btf_type *btf_type_resolve_ptr(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 17d4ab0a8206..b92914dd224c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6429,12 +6429,13 @@ struct btf *btf_parse_vmlinux(void)
  * split BTF ids will need to be mapped to actual base/split ids for
  * BTF now that it has been relocated.
  */
-static __u32 btf_relocate_id(const struct btf *btf, __u32 id)
+__u32 btf_relocate_id(const struct btf *btf, __u32 id)
 {
 	if (!btf->base_btf || !btf->base_id_map)
 		return id;
 	return btf->base_id_map[id];
 }
+EXPORT_SYMBOL_GPL(btf_relocate_id);
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
@@ -8496,7 +8497,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
  */
-static struct btf *btf_get_module_btf(const struct module *module)
+struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
@@ -8525,6 +8526,7 @@ static struct btf *btf_get_module_btf(const struct module *module)
 
 	return btf;
 }
+EXPORT_SYMBOL_GPL(btf_get_module_btf);
 
 static int check_btf_kconfigs(const struct module *module, const char *feature)
 {

-- 
2.53.0-Meta

