Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF72AD0E
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721945; cv=none; b=XDxyzUNnqWlXB/zY3ItTKLpcWz4vdBsx/dTOwUv+dMMyn03QJPi0vZntryrg+q+oDUR6r/DHuFiGyT/jwC9TcGmvDN3lQFyIWocwQPVwg2Y55Vr8uRwEn5BIKsTcy8VGrjziBj9JuQvgBPyyZdktuiCDV4+bGAfDr2YZuOpBdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721945; c=relaxed/simple;
	bh=G+Gb9raI3k69bKdJDWiSzbs64l3Ub9N6DUOBU+P4+qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzPN4pjJSuIfwvGqfPX8TE27TqlnHTcml7/n8x36vigNfn7QXUOQSDXwJxUV3TI0z7SL98+4seH80rLXQ7n4eXD151RZ3pVJ7UdFCSqIA+O7j7Nn6xxcHc5wLjSeHlEl3x/O7w8tm6lXxmNnGSXnbDgPHcYUkHn2MFi5M8CPPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBqvRybC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBqvRybC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so8573058a12.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721941; x=1710326741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr9F8RUG1nG10Rr3cII66qRWYW8JOv0GcLrRadN8seU=;
        b=eBqvRybCoCCQPG6Kcm01uubvm9GdSjRWH4/CvzUbMmvpY+myBbCCI/UKRe4GbW+nGw
         HUWsF5teOh3PRUPTBvnO2ZLaYHekma0sWoes7ksSnw8DoR8lk1wbAyZBnfM/cVNwGLjZ
         lLyk8/9kBFxyiPyr5b3kmaimo1eWdYHA82jH9qQBCRw9pPcm8WLVTX/SIGQmWpnj4EvF
         PbaE5MyZK/lxstzBS6Cl/lP5k1ltJ8kxge0iFoXm7EYvhY0N5azcVHLj/4khATlDn5L9
         smYSh+0JuknV6oZzQFjz0/3WZAX0y/iQry0VLL7nvNPQMTo8XZdplvwEhUDxLOWj9GVf
         k1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721941; x=1710326741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jr9F8RUG1nG10Rr3cII66qRWYW8JOv0GcLrRadN8seU=;
        b=ZSgUfRn0l1gvgrK3/Vbmxx2yDQlbgeAZAkOKrE5z7Fv7h4opsn66KrAwlmYGTsUK/a
         oG3pxckMjg9j+S82g+wGc/BEpkNMqMLKfqMmMUbpt2C6bWoiD+ebo+GF9jVyLtl8AELw
         OJRgC7074x6SL5NcwN+nkEQKraSfI95P0O7VVP5D6Dm6wPGZKnHsaRWfKlE2pNJpFZcZ
         MCPSDaZ6WNLquw9x3Bw6hcrASHNO3Z0itOJyc8qm45JlRLQj36F4H2fZuSASZ5K8AofD
         ABOL+vFU2PZJ2pK6ufiMj+HevJuf/EA5vHWS0fjifvw0c1BZ6HCkVMJods6ye05C0Ite
         qGaw==
X-Gm-Message-State: AOJu0YyRGxpIGF6MRlMIeQf1TENrAQjDoE8I8a8RL+MtH2vGpxgSMCBV
	j1yNtX31rwkoQho1d4osawvPFipRmVwxzBxCwHERCtgVa4zfWtDZa/3bUABf
X-Google-Smtp-Source: AGHT+IFhQ1SMEB51ezlARdw9jdpeNxDwxMJLX/g+pgSHUKCFm3d3SMLrIQeOQmvhgrlYvBnFmg4KTQ==
X-Received: by 2002:a17:906:d156:b0:a3f:2d9c:c66b with SMTP id br22-20020a170906d15600b00a3f2d9cc66bmr10626804ejb.22.1709721941384;
        Wed, 06 Mar 2024 02:45:41 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:41 -0800 (PST)
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
Subject: [PATCH bpf-next v4 01/15] libbpf: allow version suffixes (___smth) for struct_ops types
Date: Wed,  6 Mar 2024 12:45:15 +0200
Message-ID: <20240306104529.6453-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E.g. allow the following struct_ops definitions:

    struct bpf_testmod_ops___v1 { int (*test)(void); };
    struct bpf_testmod_ops___v2 { int (*test)(void); };

    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v1 a = { .test = ... }
    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v2 b = { .test = ... }

Where both bpf_testmod_ops__v1 and bpf_testmod_ops__v2 would be
resolved as 'struct bpf_testmod_ops' from kernel BTF.

Acked-by: David Vernet <void@manifault.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6c2979f1b471..e2a4c409980b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -948,7 +948,7 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind);
 
 static int
-find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
+find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 			   struct module_btf **mod_btf,
 			   const struct btf_type **type, __u32 *type_id,
 			   const struct btf_type **vtype, __u32 *vtype_id,
@@ -958,8 +958,12 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
 	const struct btf_member *kern_data_member;
 	struct btf *btf;
 	__s32 kern_vtype_id, kern_type_id;
+	char tname[256];
 	__u32 i;
 
+	snprintf(tname, sizeof(tname), "%.*s",
+		 (int)bpf_core_essential_name_len(tname_raw), tname_raw);
+
 	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
 					&btf, mod_btf);
 	if (kern_type_id < 0) {
-- 
2.43.0

