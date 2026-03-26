Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353933A6EE0
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557823; cv=none; b=kEPNtIlwH0b2f/xUqp35fz9HNNjHS2n27Evluh83yVISmQRK7JlzxCJPXcys1L1DM/7dUuXk3Yg5lXVx6nd+yh8FOVJ+HDsjuam8lpvBnj9wZCg27gZ7ug4CPeDF5J1sL786SYi8NEbwAbz6wg/bi0xpSdEVUDd1nG2icB5azeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557823; c=relaxed/simple;
	bh=egOiypsJwjF8/djFU7mQxlppV2Rai+dGuGmpTuFy1W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRRGoBBV6lvpDJUr2q8AF5T/CkKo1EqS5cla3PY03UhkzVkAUqBMetRUm/D3dMtuizhJV9Atd/OtnA/N00zL7Cr/Y2dwPbewkdD8gK0bPjrKxsLo/VCldN0SoULMhO+/5wRwtx9abkTezo30UnjWH6UdEpKn8huES6EhUHL677M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k55tI3hk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k55tI3hk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7412b07f22so1153356a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557821; x=1775162621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ig5sdFszUgYcFHRRqi6hTRlPGGoN0upuWT6iWptjeag=;
        b=k55tI3hkB/gLrtGUwhFxDVOwPnH1TMdWh2RVsGiFj6cut1/4jPJAvik323Ycb0DYUN
         6X8+Gw3lbecJLxKoGVADAdUGjv6TUNXSvE6FoD+NtLTHHGytGLC+yNRqxRnPucYFkP2t
         P5VXbMInXrrepTQJVb19RETCBz16lHFe68sBdSEnVh75MaZG0DX5H13YjcmpK8Axn4vs
         EFxh3uCr5QFUzGKDC8HqoK6TUrxn/mQUuJ2V/9l0U6BsDEJiPJ0TJVTDXhUGlsJRCpFZ
         FeR4FYnM3+TIG0AgWjRdeIPhrNRcM745Buvo5ct+vNvyti6xmwi8J9vc9KBD6EN0afuZ
         DDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557821; x=1775162621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig5sdFszUgYcFHRRqi6hTRlPGGoN0upuWT6iWptjeag=;
        b=G+BWwDxWCO7aY8AG/gEMOLhiVFzM/bXedmeTp3bCkGG/rEeMa3FiH9iDFEEmwyERZX
         Rv4s+QjPC8gYxe5SLk72vJOzgt2+XsrE4Qad2qnoYOWLKEWLvVI80Ljk//mYHVBv7Jw4
         AJyQ4MKiAgh4AmVE8b1c1OqNlze4Dedav2ZfbF1ZsLoJ7pl2udOzqP9Fl7am1Dbk+5hS
         blIO0n5V/1ecIZXCEoW8JG1/TeDTlfpRL7gWga2xE89kYIT6HR/DA3LX+DaVCjrrSd/+
         Pf7OV/g6alqJVsVlfP6mD0sI/Xztlnq8yciTl4szcP3JNnBJa2D1RBBf1UfyJUEBArpw
         XDlg==
X-Gm-Message-State: AOJu0YzC6ZIAHQTSnQb8cj8jBHM0qC5CT9LFKT/V0/DZv/8oX2tIvPmG
	Q9MQO7DleIOxgBEGyYdau9DaTSgHz/g6dmLTk+iLjSfcq1byzQLNnYB0ENib8A==
X-Gm-Gg: ATEYQzyGM3sIcJQBee41O5GNxyssY46QvfM8S84l3bKlHHKXsUfR4654MT83lH9DE9c
	EpN2VUybkwK8jSYZan8CQuMmTfZiT3SE8r/IeLEVh/WkbXISCE1V2Ak/cWw1A4q6PyxuJM4Rrtc
	X0ofpj/mTZyfgx2vEHaTqdAr1pW/7Sq6/FJrN2oXz125bghy/EwKFNdGyqBYJrPCHpkC4x7cMG5
	tBYFNxF9ji4wfdT2PHpv3kV4fh+HNHA80fIsxsTJgkancVqfn1SqafWXuzzieEmHukheBqw/FvR
	xzwGJNEx01yPmmRQ9909mVxyKuyan3+aT4R1sp0F4170ukA6/sTMR8k6iRkrOGeBSrTZ+Hxvbvb
	D1p0u/J7QZeWaSImg26X9MPcMor8LUv2Q1L+1OzMvtQ1wu71v7lrLddNanB1Y/S6v/c4g3qsRA+
	GEoIwWjXIv5xflIWtclK5BFfTdDOJ75jhI8gQi1GvFMLVsSRla4wVjJZJAYD7NUzlmSMWZNbbus
	kI=
X-Received: by 2002:a17:902:d4cb:b0:2b0:6ba2:3d78 with SMTP id d9443c01a7336-2b0c48136a4mr28286055ad.3.1774557821400;
        Thu, 26 Mar 2026 13:43:41 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc90d2cdsm46885085ad.75.2026.03.26.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:43:41 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sched-ext@lists.linux.dev,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] libbpf: resolve versioned kfuncs by exact name before essential-name lookup
Date: Fri, 27 Mar 2026 04:43:35 +0800
Message-ID: <20260326204335.3756885-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some kfuncs use KF_IMPLICIT_ARGS and export both a base name (where
the verifier strips the implicit aux parameter from the prototype) and
a versioned name with additional user-visible parameters (e.g.
scx_bpf_dsq_move_to_local vs scx_bpf_dsq_move_to_local___v2).

When a BPF program declares a weak __ksym with a flavor suffix such as
func___v2, libbpf strips the suffix to obtain the essential name and
looks up the base entry first.  For KF_IMPLICIT_ARGS kfuncs the base
entry has fewer parameters (aux was stripped); the prototype
compatibility check against the versioned declaration (which has the
extra user parameter) then fails, and libbpf leaves the weak symbol
unresolved even though a perfectly-matching versioned kernel entry exists.

Fix by trying an exact-name lookup first when the symbol has an
essential name (i.e. it has a flavor suffix).  If the exact name is
found in kernel BTF and its prototype is compatible, use it directly.
Only fall through to the essential-name lookup when the exact name is
absent or incompatible.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/lib/bpf/libbpf.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..80e495aebe68 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8630,6 +8630,40 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 
 	local_func_proto_id = ext->ksym.type_id;
 
+	/*
+	 * For kfuncs with a flavor suffix (e.g. "func___v2"), first try the
+	 * exact name.  If the exact name exists in kernel BTF and its
+	 * prototype is compatible, use it directly.  This is necessary for
+	 * KF_IMPLICIT_ARGS kfuncs that export both a base name (with the
+	 * implicit aux parameter stripped) and a versioned name with extra
+	 * parameters: the essential-name lookup would find the base entry
+	 * (fewer params) and fail the compat check, leaving the weak symbol
+	 * unresolved even though the versioned kernel entry is a perfect
+	 * match.
+	 */
+	if (ext->essent_name) {
+		struct module_btf *exact_mod_btf = NULL;
+		struct btf *exact_btf = NULL;
+		int exact_id;
+
+		exact_id = find_ksym_btf_id(obj, ext->name, BTF_KIND_FUNC,
+					    &exact_btf, &exact_mod_btf);
+		if (exact_id >= 0) {
+			kern_func = btf__type_by_id(exact_btf, exact_id);
+			kfunc_proto_id = kern_func->type;
+			ret = bpf_core_types_are_compat(obj->btf,
+							local_func_proto_id,
+							exact_btf,
+							kfunc_proto_id);
+			if (ret > 0) {
+				kern_btf = exact_btf;
+				mod_btf = exact_mod_btf;
+				kfunc_id = exact_id;
+				goto found;
+			}
+		}
+	}
+
 	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
 				    &mod_btf);
 	if (kfunc_id < 0) {
@@ -8655,6 +8689,7 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 		return -EINVAL;
 	}
 
+found:
 	/* set index for module BTF fd in fd_array, if unset */
 	if (mod_btf && !mod_btf->fd_array_idx) {
 		/* insn->off is s16 */
-- 
2.43.0

