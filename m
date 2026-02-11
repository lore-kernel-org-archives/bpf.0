Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1F836B06C
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814669; cv=none; b=Lu/DGogCjM0szYdJNd9v8QdW3H80fZbcxn9oKgJRSGlNb4j3zMOasfwyHX14nyykX8ZJ5qab8fMJ8j0RSdEt4QHXIx6Q2vb4MNAm/na26vztOo/OBA3mZPJ7PmoZevZhyPwTQjHOP+RWIQeVDAYDR8/ThUF73hCCAA0YVFcnouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814669; c=relaxed/simple;
	bh=hCVSHo9DQGfxm2r1+JG9k4GYwgUeT8hz5Nu8FnCJYIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Waj9K8tmLE+x5DGAuR1dRP7cg+4BZR1EtvXEi+WzXeLOi0eunINz6kaMaOpMHSRcXQKcZ1f65reIJvUHHFx2aoIdvKIv7mWAyU1izHjA4Bd7zio6iIzJMgmuvrDj77IyxZDr/VLG4xC6BZ1nE0unXfMVDLwo19Hh1OBZu0m+gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoj7hFRN; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoj7hFRN"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-823081bb15fso2672823b3a.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 04:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770814667; x=1771419467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TtYZ5EC3dCtBT+uwBuJa6C5l//iYphnHtWsOZ40juE=;
        b=Hoj7hFRNGBZYhz4I25fS2BFRaWmQanTXW2Ax9MCL3ooK+hrwj8VK+ZQoMmdYAZ/T19
         cIW9+2wqltp0MYyjy9sgzZO7KYEYFgqALHzfJRTJ5Y8mf6tYe1S7kqJfLm8LupH/EN/6
         DgQUYiYAeH4cka6oDZSJhtHMQrAVRb4brzq/vVeIENZBKwcb+tPGnTGbJOG48U6a14xj
         PqFTtmXAq9TN/LXpqX+L/8Q46JToue0igEoYbJksN8Fq6X1HajnCdOYxwTFBDpMWtCsF
         DWC4HOq18c/tBF7vIq2WcG0C5XUdvzj3IPg8WYM7xpBQqcCgjWQzfq6gaX4I1AAYUZm8
         j3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814667; x=1771419467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TtYZ5EC3dCtBT+uwBuJa6C5l//iYphnHtWsOZ40juE=;
        b=AlpG4vR6r/eVTaVgpXVrf/5P11nQ1RUyc46R7nWe3eIEVqC5Yt5AgdBacY+oxgYbgV
         zxoVZVhb4q6xm0UxvXowspLORWs1l7ezCMgh4Fyj5YI5oSU2lgz9YTzJddi/6luL+vXy
         7fYMUTBenePFyHJ21/ZnXLFe1s+F0KHTQ60WHjbuVvZ5e9mzK9EhgZz5t6gF/RX2syNI
         Uwm7h/3LL/5xDc0EknJsQXIZwIw3iFRO3MHRiZZLQrTMdBbUHXEEC65q8ibXbxifuTDW
         LvXqHDL57/FxivOxo7YcD53iow92aW7ZDC0P9xYSYGcS517QUHYiM3FSn524DKX6cLp6
         +Gew==
X-Forwarded-Encrypted: i=1; AJvYcCX0OiwG6oKm2CilaienTOkKaLOg8BqaWAUuYANZ0u54d2tV0dr/EA5gGd3TmuMAri1M3OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvT/tKOLvaiUaC7sOAmU5W4gV1+OLeXnEXb1DsbWvY31I4h6T
	/l431MwsuMQyt2xNSOi7vySgNr5PgGowWphkutidMBQWgpiBOxS2kFa6
X-Gm-Gg: AZuq6aIM9V7eR/LpPqvIodZi8Nrl/eHVcGMJP2xxG7sRWHodYe6HqBgOo+LfjAMunoS
	ndLfKeKiKpU2GreEMwP3HiC4eIqzhV9ckM3/ALkmwzfzsOGwW5TGyIopoh4pCF27sc7PVj5WoCS
	3OxxN8pKWeMMdB1+xxFSPTkziuofp49crRzC7QVixZbRZwrEmxFSPV38f0U6W0q6uY4dpeVjPl5
	hLmDWL9tghzEeoX2JVTgvU321oo9hbJ3SauEbcASzTW6otU5jUCgfYXBGq0n/Cu2Dn1LIhOudMN
	rvbnOBYqY+ZUpg7G2oDOygI9obiiwb7lU6QwAdKMOeka8xYUz3SYaRfogJXXx2lKN+Dil2sPM6e
	jPaJHHSO3q3pLgwFUWnUsJttcOCbusT3EURRnhnP7SoGWrted0p8r3XkX5BnzGFlnHhJPkr56qA
	qcf9+Bww57kvrXjIkZ9KRB
X-Received: by 2002:a05:6a21:4612:b0:38e:7422:ac83 with SMTP id adf61e73a8af0-3942e35ffe9mr2443996637.10.1770814667430;
        Wed, 11 Feb 2026 04:57:47 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e1969f314sm2198284a12.8.2026.02.11.04.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:57:47 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: skip compat check for session kfuncs
Date: Wed, 11 Feb 2026 20:57:37 +0800
Message-ID: <20260211125737.1315848-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function prototype of bpf_session_{cookie,is_return} is changed in
the commit 8fe4dc4f6456 ("bpf: change prototype of
bpf_session_{cookie,is_return}"), which is not friendly to the old kernel,
as the libbpf will fail on the compatible checking.

Therefore, let's skip the checking of bpf_session_{cookie,is_return} in
libbpf, and just let the kernel do the checking.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/lib/bpf/libbpf.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..71bdd1c1ac39 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8557,6 +8557,12 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
 	return id;
 }
 
+static bool kfunc_skip_compat_check(const char *name)
+{
+	return name && (strcmp(name, "bpf_session_cookie") == 0 ||
+			strcmp(name, "bpf_session_is_return") == 0);
+}
+
 static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
 					       struct extern_desc *ext)
 {
@@ -8617,12 +8623,13 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 	struct module_btf *mod_btf = NULL;
 	const struct btf_type *kern_func;
 	struct btf *kern_btf = NULL;
+	const char *kfunc_name;
 	int ret;
 
 	local_func_proto_id = ext->ksym.type_id;
 
-	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
-				    &mod_btf);
+	kfunc_name = ext->essent_name ?: ext->name;
+	kfunc_id = find_ksym_btf_id(obj, kfunc_name, BTF_KIND_FUNC, &kern_btf, &mod_btf);
 	if (kfunc_id < 0) {
 		if (kfunc_id == -ESRCH && ext->is_weak)
 			return 0;
@@ -8634,16 +8641,18 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 	kern_func = btf__type_by_id(kern_btf, kfunc_id);
 	kfunc_proto_id = kern_func->type;
 
-	ret = bpf_core_types_are_compat(obj->btf, local_func_proto_id,
-					kern_btf, kfunc_proto_id);
-	if (ret <= 0) {
-		if (ext->is_weak)
-			return 0;
+	if (!kfunc_skip_compat_check(kfunc_name)) {
+		ret = bpf_core_types_are_compat(obj->btf, local_func_proto_id,
+						kern_btf, kfunc_proto_id);
+		if (ret <= 0) {
+			if (ext->is_weak)
+				return 0;
 
-		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [%d]\n",
-			ext->name, local_func_proto_id,
-			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
-		return -EINVAL;
+			pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [%d]\n",
+				ext->name, local_func_proto_id,
+				mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
+			return -EINVAL;
+		}
 	}
 
 	/* set index for module BTF fd in fd_array, if unset */
-- 
2.53.0

