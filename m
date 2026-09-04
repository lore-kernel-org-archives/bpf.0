Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E993F660F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511417; cv=none; b=QZK/ssSv82W4G8AXU6CwITXmnObavfBAAhQKH6q+Z40s2LLd3GCdjIIjrFn6U+jueRemRIFj+cGhPiin3eRpYvfrJwRmm+eO69omVxMhgfVGTgIvYAgu8+uNo0PwBBumAmvDdE/FInYj3Ox17BvpSUZrzt6KumJCLX4xqygoqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511417; c=relaxed/simple;
	bh=G+mdTUEGAA7xgXEbrkxxlO3xp4/Jk0J+MKGwOR8O2kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFizzwXAssY7W7K4x9mqCjdnRrwWKWhYECEVEWef3vLC/1A7i+47Ru2/gUGmbkdApl4DPmftVvULkP73Hhq9/3yXd7dsEFLvef1hX6dBsHwuDRCxMwG4DKr442gshH635nv3xf1c9ZTJNGkDs9Zn/AsytQcS2hLwlr+r3AvOfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozqQzF0a; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozqQzF0a"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-48586861639so500829f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511408; x=1789116208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilTIJSDOzbohGvPfWloWUC6lqM/w4si9TaieoULKGr8=;
        b=ozqQzF0ahlJDt3pHFYhCO1bGWr1eOG+rkZyl1OwcwdIA8tgG6O5EH9GIpOX+m2Wm+6
         Mc9WBp9ZO35enko1VOjj19E6MfcjADlg/6XcnH0THo3LJIzyPnoMchEkqU59FYpEWoyC
         VlcT+Lk9dkaNyF8rWxMxyVoy1OTWjuGFLm/hUmHxMFC1i67fmzk2rw2NXl9Osl0gkUkb
         WCxbXuTdeJQVhTRL7fp6i9ZU4Od6qgCYyUgoNRA4bucVyBLHgx1uTuQbUlRQjfv3Aa/k
         XufVwP5A8H65oYNgq1i2zrMzYkjuFu/A0vjsTuy3Sc14Y8EdzVwDg4+fHRwvQALmqCcx
         OCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511408; x=1789116208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilTIJSDOzbohGvPfWloWUC6lqM/w4si9TaieoULKGr8=;
        b=eUI3P+ePqYyj7WQKm7oSa0gtTv5ElLu7Nn0jG1TmcrDIPETO1zzLjHuB4d3qw3zaRJ
         wSODg6nWjxk6s6l4wUSuNCPXYfnkzFrBnj81H7YPrq/Q68HBIu/NShFkQ3EJZaO7TO8U
         ZLYHmxs4TzwyXwqOyrODl5ihh/UhRvwzD6AsdffSmAvklUQLyxeKVYT6hYBSJ0Nkk8qt
         oo0novaSWaxNX08taC7qXbJ3Xaa0attLhCDGs9uoyYmTarH7J08MueBGWopeeSSFg2zo
         JmkvW9AEfBDsVGz0VLDZd2ykft7ITZyRaMpQXa3QpDot+OOQtEKreJVQg3Pg7dlfFi7B
         b4hA==
X-Gm-Message-State: AFuF++lYzTDs6GUxGpJAnyOXkTBZvTEc7ZDhavRzZxCzlXTBosQkQkYA
	vxJjphKElrYyHelarYWEBK5Bu1aQhmxL8abBPSuK422xuvAnDu2Q/DVMZM+DWP2C
X-Gm-Gg: AYBFou0789oR/ysZRi0E62LA1hA05nS3HlcP9ImKmdDBYFErercPpHcE6RKyRQ6cQLM
	sJe6WbJmQt7dJpv5E8qlVPW2XO76wvpn77Z5S82+pvl1wGIoc1LM7JVUh+eg1AAn1L5763kdhOE
	mo2yjIU8/X0DeAaPHlJy8a3pbmSyFNb+z9/TJbjezpwjdiTLqiCkdDZvIt3j5kwoJeUhjFwHuAP
	WfGosplmm9QPdK/ecezhs44bxsIYtHH73XbntGObd5qagKeC6I1wBW3cmzeAB+WDkToPmj6iRuL
	gJFLn4Ndzgay9sCs0Hws0CXnHHR8gp7oI10u1vgi9yiZ1l0c6ChfxwLVaD8FabQuYhIL0mXSQ7b
	CC5fMnGJPvlWLPPH4XYq6cgq7tmpPLyOl8QxhIFeU+2wRJqchYWB9VC4hRDkyeN3KyavEWtMfSV
	v6jBxB7Og0eL5Rb0wNJXGJ0dC1UK8i5kc1SmyqXjW4VYiK5ltWlvn4xiUcHib0vgF99LwFsvEYB
	kxOUQ7+MiTTVRv2+Q+Mj4j9hAU2WHfnEcErD03sRb1UvYH+vbYokBT8zvZpQeJsaWvnVzC37lqf
	LXyLO2nCaj+RSYmPayyBojEaB5k=
X-Received: by 2002:a05:6000:992:b0:485:8413:5272 with SMTP id ffacd0b85a97d-48584135473mr8809305f8f.26.1788511408127;
        Fri, 04 Sep 2026 01:43:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ac2b4cdsm3238147f8f.16.2026.09.04.01.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/8] bpf: Require MEM_PERCPU for percpu kptr stores
Date: Fri,  4 Sep 2026 10:43:14 +0200
Message-ID: <20260904084325.52250-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
References: <20260904084325.52250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; i=memxor@gmail.com; h=from:subject; bh=G+mdTUEGAA7xgXEbrkxxlO3xp4/Jk0J+MKGwOR8O2kQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWywTjjKRo/8S/0ly3a/jXbyrf8MKW+/iu3Gs+JiH7G 5RZMx92lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIT1jH8ZuNLXls8+Yv8Vevc ekH7iolRa55/2vfD89CF489mMlV/72f4Z778sB+fiPyhQ6ILmZ+1ZW1kaV0oW/7wAcPvgM7dCxe qMAEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

map_kptr_match_type() treats perm_flags as the set of register type flags
that a kptr field permits. Adding MEM_PERCPU to that set for
BPF_KPTR_PERCPU does not require the source register to carry it, however.
The subset test consequently accepts both a plain bpf_obj_new() allocation
and a referenced kernel pointer into a __percpu_kptr map field.

Loads from the field are always marked MEM_PERCPU. Consumers then treat the
stored value as the cookie returned by bpf_percpu_obj_new(): per-CPU pointer
helpers relocate it, and map teardown selects the per-CPU free path. A plain
allocation can therefore provide an arbitrary kernel read/write, while a
kernel pointer can be relocated into an invalid address or sent through a
missing destructor.

Require the source MEM_PERCPU flag to match the destination field kind.
This preserves valid bpf_percpu_obj_new() stores and rejects both the
program-BTF and kernel-BTF variants.

Fixes: 36d8bdf75a93 ("bpf: Add alloc/xchg/direct_access support for local percpu kptr")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d7dd0befbd10..68353aa61fa1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4488,6 +4488,13 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	if (type_flag(reg->type) & ~perm_flags)
 		goto bad_type;
 
+	/*
+	 * A BPF_KPTR_PERCPU field is read back as MEM_PERCPU, so the value
+	 * stored in it must carry the same flag.
+	 */
+	if ((kptr_field->type == BPF_KPTR_PERCPU) != !!(reg->type & MEM_PERCPU))
+		goto bad_type;
+
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
 	reg_name = btf_type_name(reg->btf, reg->btf_id);
 
-- 
2.53.0

