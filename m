Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1B366553
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039655; cv=none; b=Kgzc2Ax5QiZi75rc4oW5gJPRQ6of6o7Zbw41yvwArEg33seIOwhV16o7oaA0iCCKGVHhuL4f3u2Qiyq36csqCsj8swq30zuS90BJO8H7x+gTBdgmGUh1/fvhv8KCwiwv2rpBom8K4zz4JdmahWo8fJQjyMq7GjKOaJ5q0hGNTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039655; c=relaxed/simple;
	bh=UxZ4dNzxpFuwiaN+nzSK3Uno9ucZEH+Vpxp5QB85qwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fiy6b6RWTS+ZOQAj/8H5OhiNV62pofm/QemFrYcCaqPYayI4rTVonpO+hlt9h7UVQNDxAdrL9nV97lDJIaYEV9+97qz4sN/W5kEAjPGAa93YLZnPKlFoILHaeqeoIii2n4ma1ePDJqmQGdE2EAnt9ba2QBlqMjmqvJw1nefomlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMeZSJ3B; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMeZSJ3B"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so3672753b3a.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039653; x=1790644453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PiffWWn7gdhi0Mff/aLIANmktLU2HcVqFnN6z3rTnng=;
        b=bMeZSJ3BN56jhftggtUYtJHPbXmI7qvpJlR/Zi9SefNErtFmgicBvlmN84geFHMRHt
         vXDgt1Vh5wtoeAnPAzCUovt34NNrKAv5gABYfQieesSBPU6VTKJ1z2Fuy3W+wiDLZ2oU
         IIrutCHtHz9s58DB+FOSXDoe81qBIj1TTeNPkGux0aeHA+mw4vqk5xH1tqbI1/nTnFRC
         olaJbOtQ3AiNXYR9eL2xm4f6k3Bc2QKahxDNYC1ulRvgQ7BcSkdyAheKFMvmJpA4vgkp
         IJH6NU/LqIF1BU/fuXf/CcWhbDx5VuQvd7TMl/uVyzLtbcSDvhMR4yTVrRkBDvHYWd6i
         JXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039653; x=1790644453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PiffWWn7gdhi0Mff/aLIANmktLU2HcVqFnN6z3rTnng=;
        b=J/cHonDh5s50yp3aLBJY76KqUOYA4RkF8GUcn2oRqb6qesfi3fFtfHOc30n76n/7AK
         RlupsVLMLerOabfqKN+HoP4bWO9MAG76F5trBc+I45zZufcl+XakPAERaxRxXqwVHPqb
         yp0YeUFDwzBPGLkfjQWY/0qodQmQ2be9ikSJERG0AHPFnszVj03nlxG6FKPEEDKu1DjA
         JhHjIGCXrhKi2lwv7h3WP03MCp6Ek85eL7tYGF1B7b1gU68EajC2Q3AOQ0Pu59hUldnA
         Qjdf/U3w28kUriRHj3NhFtMvw+Zolcvft7PV9ZoVxHmfVCe+MCeiYR0XKzxNSI9FlVsT
         k3aA==
X-Gm-Message-State: AFuF++kLX6sWF43E/v50TZ1aUCDs0FGNCcRnkEVjzmaGPkyqW+oz/fgt
	bierZ99tCqedWSKiiBlj3yRTCsSCWGxd27Hlv3VjDRDBgfiI0yJWXaLTgQtXYA==
X-Gm-Gg: AYBFou0gUJ5y6cy2WpVRY16gehTkbLFmB8xRjx5KIYnWgx2IajW0rjnHG5Qj867Hwrb
	OTKzM1mGTltaNrcZMFbgClvL3uxyqF+pzpav8Ta2dlDHDM40+lEweW0XgPNUD1hgDHkIWlC46hU
	GSuauxmHLI9UVeSjR9ybHTaeLT+KcZRZ5IQQgVnOLMVhV7V9P/Kn/b1MuAHIsgliMCcYNRNIGkl
	LIHHgShcoU0UetGQvBuIxH400JPR5mkhMuCTNjHBhGMPox68T/agNmw5y6PLlzzzQbrQEvpXWl/
	g8TQ6HhBi5zEmXB1nrnfza/yatDmzWU+jqL/drHdpg/tmb0jmJZwtoNLmVbHnp6cPj4wj+ODd2i
	kD/8Z7bCYf3WqzXrvRctCSZyB8MBt3Jd87jWpy6hzEWcyETBNkUujhhd46/4M9TqhSSL18qYN8L
	s3WWtESD9gWrXqv1tN827RCvJY4ok5jr0NTZ8ogRB+cq3rw3gxFuCnDZAWOEIxF24BCJPRnD3lK
	kDo9Lv0jC96MN19GbFNPka8kMGP8Sk2MMu5i9xHcDj/CyVvTgBzJju+5MXcTkqjxHUu7+sxI8W7
	PdvZLgJ1LdYn6/VTLjiR+S75gFonKSwkZAmuK5Wt00A=
X-Received: by 2002:a05:6a00:4acb:b0:86b:b06a:d3ad with SMTP id d2e1a72fcca58-874de006208mr14984889b3a.23.1790039652749;
        Mon, 21 Sep 2026 18:14:12 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c32cb7fbcsm51354b3a.42.2026.09.21.18.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:14:12 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 13/17] libbpf: Treat .data.rel.ro as read-only data
Date: Tue, 22 Sep 2026 01:13:19 +0000
Message-ID: <20260922011323.1298619-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

PIC code keeps constants with pointers, e.g. vtables, in .data.rel.ro
instead of .rodata. Nothing writes there after relocation.
libbpf treats every .data* section as writable, while the kernel looks
for pointers to functions in frozen read-only maps only.

Make .data.rel.ro and .data.rel.ro.* maps read-only and frozen like
.rodata and collect pointers to functions there.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9538a21f0db4..b5c580ec02bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -544,6 +544,7 @@ struct bpf_struct_ops {
 #define PERCPU_SEC ".percpu"
 #define BSS_SEC ".bss"
 #define RODATA_SEC ".rodata"
+#define DATA_REL_RO_SEC ".data.rel.ro"
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
@@ -4061,6 +4062,17 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				err = bpf_object__add_programs(obj, data, name, idx);
 				if (err)
 					return err;
+			} else if (strcmp(name, DATA_REL_RO_SEC) == 0 ||
+				   str_has_pfx(name, DATA_REL_RO_SEC ".")) {
+				/*
+				 * Constants with pointers in them, e.g. vtables,
+				 * that position independent code keeps here to
+				 * have them relocated. There is nothing that
+				 * writes to it after that.
+				 */
+				sec_desc->sec_type = SEC_RODATA;
+				sec_desc->shdr = sh;
+				sec_desc->data = data;
 			} else if (strcmp(name, DATA_SEC) == 0 ||
 				   str_has_pfx(name, DATA_SEC ".")) {
 				sec_desc->sec_type = SEC_DATA;
@@ -4113,6 +4125,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" RODATA_SEC) &&
 			    !str_has_pfx(name, ".rel" RODATA_SEC ".") &&
+			    strcmp(name, ".rel" DATA_REL_RO_SEC) &&
+			    !str_has_pfx(name, ".rel" DATA_REL_RO_SEC ".") &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
-- 
2.55.0

