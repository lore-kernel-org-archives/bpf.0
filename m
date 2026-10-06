Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091452459C5
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246042; cv=none; b=ONA/4p8M6lTDXjJij3L6DTkF+70LSi7LG+FMMEkUKT2IyR3yyEikiYYIbPlWc7toElMVjT1jiZ+WU/AOsxuaz4FQoQGTpRKSkwszKId0xt9pwB4/23W/77V+VzzBOOrS7OUXwz9uK3RemGf61YLsUr//GgsfamwF7g5UZPod9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246042; c=relaxed/simple;
	bh=y13XcqrXalvPlyqorK5jhgilk8EVXf5xHNq9KHtHVwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+Zxk6+wv28em/ygLUtKPj7FyhqGXjsOPQpj6vWlo+n42aPPLTXsU0ZF3kSGFZgKH2tIPe2h6gRysxoYqglY0J+MqMPIbYiKjDfhsnAheC1XU8urquc52incFqkSHxMyhpx/eyeR5/kV6ZCGBd4At512Ie+PP72t4MEMXx6k7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6In4wK3; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6In4wK3"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8ab4b4f3d6eso8187257b3.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246040; x=1791850840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvPSFgeEpLGLZYk/CFPoDi6u2PEbfv8+Riz8KF6NXE8=;
        b=f6In4wK31khh7gR7nKf2NLpHJ5j0hMSZQntP6prmgra1EnOaaALBJ000wWm//logde
         2MJDXyO5Lj4pFD2ggilYnI8XJAYOyDFVk2lbO8s3Lme/tq1mqQD1AvGDsp5oi09HzGlR
         pWMNB4MxYL+SZGQ/E9pHrvqHf3F06kKoQtRPAbomXP1aw0o9gUzDOyHuqCraPbttfo1C
         hWaODzLeVzCJvcO4OWivKsLkI4C0oE991grBUQbhQq0ZVpTRwpKEgAGIokFAYXcSF6uL
         zTshD+lMGuM6X6EnRkeHloGwgTpJ1r0KuDxgwCgdh77OfweeKLcY0Xgm1c3J6+PRzHOu
         Muuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246040; x=1791850840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OvPSFgeEpLGLZYk/CFPoDi6u2PEbfv8+Riz8KF6NXE8=;
        b=QpJXY2oJ02EU4X3hT04nHitoqkM7hKK3Os6tnXEUPQXeOVrloYeHX+l3j8GRQT9Qvc
         fDbtGMXW8GHtFAQybqzECQ4/N/pB/EScv2ZDOHhL38R9Yf+gsIR2eoudtScx4D6x5dML
         eSlVQzleXgc4o5IblV8FUNW1bhfKHQ21/tAAszeYAZjKzarG+LrHef3jVI8PXs0WJUgS
         kiKqOlX8KYX8ieUo87RXYZEWrCYtxzPlO9mpHSu3gqF1jUojhU4/g4IDL8kylgua2mbR
         hMAMxOFKDD6t+zY68eygG1gv8HcGyTGmQVJL1pOQZY6pbbXqjnDYJP5Csjy/a5IuQ1SP
         2vBg==
X-Forwarded-Encrypted: i=1; AKwUvBxq83c9CDuyxloR8JsrkiH43JGoAVsCvtDBLTcSc4mca2cKQ46OaLOBJNINxLtRPh8dLxM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJBrrGYUrkPGQYlaoDy+eyyIRkXy7U7ExljErGebppNu46z3vx
	K/MRQFduwMvS8cVrKKRVUA3GpxFk81RJAn6iYbm5ij9Fkry5zu7mW0T/
X-Gm-Gg: AYBFou35Zg75JenGXb/Uc+iB80J6YqobUeW1A4LPG/2J3I8vbMmeiTL1kF/bpMRlPhw
	DqlP+uqdOj57hmr4JKABo+ucCdqtgoKhHo9Fc1YWxusyup83dg3QJ4X9C4bgMI0n/eMP1lWpA82
	5AQHA8a1arCPVP8IEUPjOze8UxLoThS9QuhjfmbUKOWANCJt7Glhe6ZXWdMZsTOcjZ+CSnFd8Ak
	FAqTUo2Xrlf9+pp9a+jzWPupAb1q9h7NBwCnb3dSaw9b7kzmfbffeOL4kLRm5tHppPs1ay6GloW
	Jj/b0s5fk35sTiM1PN4u/pQeT0lxUwYChMe9qhkGyh7CE/imfT9xyqvfWGcDEhCDvHJ5Qt1fjKl
	xjnOVIpVxuxRk+cJaNBkq2e9yxo6Uyr52kLG2R/aYOJWRBAqAsuWqjWBZ+4ssHAm9sNqzxnEXQ7
	ncgxOpnJMEwszhBSTzEmWjpu+d3LkRNBz8B0OhnnOrDsfE8ojlZCuGLzELr056Hlp7A4OE2m4G4
	A==
X-Received: by 2002:a05:690c:5809:b0:873:5c6b:a327 with SMTP id 00721157ae682-8af71ff15a8mr3855077b3.33.1791246039798;
        Mon, 05 Oct 2026 17:20:39 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:39 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH bpf-next 04/12] bpf: mark struct path trusted
Date: Mon,  5 Oct 2026 20:20:11 -0400
Message-ID: <20261006002020.2890858-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006002020.2890858-1-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Walking a trusted struct path yields a trusted dentry - a live path
never carries a NULL dentry - so BPF programs can use it with kfuncs
that require trusted arguments.

Signed-off-by: Song Liu <song@kernel.org>
[justin: carried only the verifier.c hunk of the original patch,
 trusted instead of trusted-or-null]
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fd3c0206bd67..24ec4b037de7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6300,6 +6300,10 @@ BTF_TYPE_SAFE_TRUSTED(struct scx_sub_detach_args) {
 	struct sched_ext_ops *ops;
 };
 
+BTF_TYPE_SAFE_TRUSTED(struct path) {
+	struct dentry *dentry;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
@@ -6352,6 +6356,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_cpu_release_args));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_sub_attach_args));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_sub_detach_args));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct path));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
-- 
2.55.0

