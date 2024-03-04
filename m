Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9193C28
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592745; cv=none; b=r7WeP8DioWmf2eC8Tx0Q+IQ9SBScHG2Vu/t0qu8Bo6MNSkcGoNntZvlfVo7Dfj9t0rUAz2H4hWP1751ZUHiTgbo5etcCRjSB/q74B40DHR3w5Ul7bpfIXHG2w2SaGgWth/QYdnw36sX6zGZFJQ7d8Nv229xlE14N2At4hO/B3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592745; c=relaxed/simple;
	bh=mRYN8GtA6AeeXnAhta3PiFUwUUHqt9j+YgCCrPA4m70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOWn+DlhUbshvlu2/Vab7jai6GL1zpNTyPRiWzUrio9ide/jq9Zuym8tv83EbNtI31YnWEzpqQje/zsgQvp8YcoXsD5Xb2bs+EVaUeIvMYrVF1MChNkmiq6u2p+wWpdClPPyxOjSRm6XdkglU0p1+C4IDFnLZjmAh/x2noDmLaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCXopT6c; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCXopT6c"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a452877ddcaso217444366b.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592742; x=1710197542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STdOP0ZXMuxwmEzVVyhK+2jyJZme+i5PFKTMGolq9lE=;
        b=gCXopT6cdMVBtxx4c2qFmiH7lXvGOPtXx065lAepqYC3HE2Ctgid3SuCos/ftYOYdb
         lbV4XWYIMSHFs1f6ZWdcCzjBmgCEvW++oP87LN64muhbHe6+Sf3kiz7B0neXSqW/bi0q
         wvG2a/iviJy4PrG1if4xuLOm6/URBxghawU8vNqFS9nRQyDTqe1qa2Lz84MxD54ezw1f
         M+kUQd4VnUGJnm62VxBt2cc5xi5EGFRQf7B6R6KAY6hrhT9TXMR5GLTAsZzQSo5ESvWZ
         RhfXC2ycRQc+9gUAdEKgl0QImBG0bvZSJQb3sJqb/QJGrOOIfn4fHdcrtzhd2pDaE3QN
         xOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592742; x=1710197542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STdOP0ZXMuxwmEzVVyhK+2jyJZme+i5PFKTMGolq9lE=;
        b=GnGJ9BIDVPvf6b4y94FCEJ6QDhniu82ocNRZPdtghskvmoL4pzZ9hv19P8iGd5Zjwk
         bFOhzdGtWVZ2ubDAsCI+1V/OLrzA1w+dVc8g+aWJSOe3YfcmwVGivFWFNv8F7KghsMko
         OjC+XtNr2FOotgPmGUnUXrnm13UAPrS7YM6NHzkmRhG/UPH4vNS7Z6l5Pq8B3U5Q3rmG
         Y9QemLOTKxltBr5ZKMhSJrTLb7ssBPVSCh1lmEWJYM6n2ddLc+U4F7MyD7HCEid6LNRo
         UEe8kqGNGFzdpp938IFFU9B6cUt0RVq27ATVi6FPpLVXYEnEA/z2X/6F29MIdxrmg+RY
         1qqQ==
X-Gm-Message-State: AOJu0YwdHcT6P7kPCqA3mrio/pqP/rXjBOZI3RfV7uYBqi7VG3VBpOmE
	yDAWix/IJNBDNWzh5pN7Ae7DDOnmrKu4NyD7Jqz3MBRq4oznjall12ncOLjm
X-Google-Smtp-Source: AGHT+IFR8DWddPzI2l5n/KP3S6eobXIampEjq1SkwvT4O2uz/4X0jrlho2bGgB/BGveskieouWwdsw==
X-Received: by 2002:a17:906:a450:b0:a45:a797:75ab with SMTP id cb16-20020a170906a45000b00a45a79775abmr60391ejb.3.1709592741834;
        Mon, 04 Mar 2024 14:52:21 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:21 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 11/15] libbpf: struct_ops in SEC("?.struct_ops") and SEC("?.struct_ops.link")
Date: Tue,  5 Mar 2024 00:51:52 +0200
Message-ID: <20240304225156.24765-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow using two new section names for struct_ops maps:
- SEC("?.struct_ops")
- SEC("?.struct_ops.link")

To specify maps that have bpf_map->autocreate == false after open.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ef3902e65db..c0212244bdf7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -497,6 +497,8 @@ struct bpf_struct_ops {
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
+#define OPT_STRUCT_OPS_SEC "?.struct_ops"
+#define OPT_STRUCT_OPS_LINK_SEC "?.struct_ops.link"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -1324,6 +1326,15 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 			return -ENOMEM;
 		map->btf_value_type_id = type_id;
 
+		/* Follow same convention as for programs autoload:
+		 * SEC("?.struct_ops") means map is not created by default.
+		 */
+		if (sec_name[0] == '?') {
+			map->autocreate = false;
+			/* from now on forget there was ? in section name */
+			sec_name++;
+		}
+
 		map->def.type = BPF_MAP_TYPE_STRUCT_OPS;
 		map->def.key_size = sizeof(int);
 		map->def.value_size = type->size;
@@ -3688,7 +3699,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
 			} else if (strcmp(name, STRUCT_OPS_SEC) == 0 ||
-				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
+				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0 ||
+				   strcmp(name, OPT_STRUCT_OPS_SEC) == 0 ||
+				   strcmp(name, OPT_STRUCT_OPS_LINK_SEC) == 0) {
 				sec_desc->sec_type = SEC_ST_OPS;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
@@ -3708,6 +3721,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
+			    strcmp(name, ".rel" OPT_STRUCT_OPS_SEC) &&
+			    strcmp(name, ".rel" OPT_STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
-- 
2.43.0

