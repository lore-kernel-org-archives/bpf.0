Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CE3B19BA
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255228; cv=none; b=WuBf8i/MvFFd8Uli9V4scxv5T2wqJtH1hm9G+Qykglm+Sl4vOghvg01WmVcGM3t7yHgvJUlF4Z3OU/8xFrP0tRXBNDfFgwYFgSBOlZuRAdpDL7vfBKNU0pRWBUrBRZAmzf7bBy5FEYO5QcwW1CaQD2i1ZricHztMpRUfaLFHwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255228; c=relaxed/simple;
	bh=1vipa/BUWLt7FxSSWIAQxQD1mC5GvojWAIA5QQzic0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaKiTfQUQt31VLA4it1SQDNLBCM2m6qO+K/qzvdfcD9/iQxCbpFS83aKIsK0FeWcCEXTmRen6km+LlPFh8HgLJDw4NRUREiYwq729RsHFqCpbbN+NM5ofvzY3lLQ5KQClhjHVCY41wEN7ysL0ztAWhXDPS9W1qwuhtJi2tGJNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieKJj3eo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieKJj3eo"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e946155442so6443875ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255226; x=1792860026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmpNB1WJ0gNH4EFaRbOnrMQM/lEdyqJ32Z6JUH8YZaE=;
        b=ieKJj3eoFcYuI1MLB/6HSHDlkK2tCkToFVT3RBbpoULeAXtUyyW7sOpvy5Am2TEzCg
         GqJJDsvmWKR59o/nDxxKFsQ0YWuNjw0bPw8t0uEn6AJ4Hbrj0sT8dFcQJu5qp7e96Ahi
         XtcdGmMnSds9hRXDYZsxO0E7L/TMpBQ6gIx4B9ko0FgJsM7WWEROTVxgcWebuglTLVhs
         gsd/S+w+fHf4qMlMRYgqDdOqq1jOltLs6LHA/Vmkr4+q5n+6JYyUT6sQLQrDIJmoHax3
         r+SBv38PgQmuh91DWoOxg7fWypfc0kWtbM/0RPOoKA9UFBnuLndMCKbsH9pa1RKW1drQ
         K2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255226; x=1792860026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmpNB1WJ0gNH4EFaRbOnrMQM/lEdyqJ32Z6JUH8YZaE=;
        b=1uMLEuKWa3UCu17m/5bEuOr9W1f0t73X//23bfXmBFbPa4TkdxyCee9zIdir/wtBgt
         rNNyykN36+KbR9Agbv+8gha+kB6G8N5h6cpVQy2WKTq9MGbiwpd2r4ZE6dLU8zsX1zsu
         nfOWwzbR/mA2t9WVvBhFPZRCYhd/4v/SWo7oTSagVnbIaFBzY136PheiMbRzhF0Dp4f+
         sNrRpNOQ/KjFE5pYiuQLqvmLglsb41uVYTEgy1Wq+XvRx9gXqyJIlv2olI+qYfHcohf8
         GHfTRJ/EP0wE21/+retSPHJvh2jhuj7AIRIstFew8k9v1PJnRy5Mb/R9D3J37g4YwhWw
         WG1w==
X-Gm-Message-State: AFq9FYIRbgY8JA70FFfR88bRRPf3BLwg/43dCVVFc+1tMNuDe7hY23UF
	zdNAUYGyB0vAC/d3IUWc2cNAIFF2YR6vgYyvtP4u0R8KMiODlLK+4nnXuO377Q==
X-Gm-Gg: AYBFou0fhx2N/wY2R2SLuzYcmqK3iqrtvoL7/j1O+ELZfxm78za+JIk4iKepQlYOVGE
	5LiMBmEyMAXvKcM3/JsmvAvaedaYJ1eS2yAOAOKf5qK3CQzQOe0dhESlP3F920xgCJBSor/eU4A
	jWfblcdJOkCIDpMFjYko8Rfuf+oCCdlqNy8rHfXfmJFZ8JDVlU6O1FmrMiRdTBo2ZcXaxcX5tuu
	loRTwIw4+iuExzCGFyEGc+y4kCa5G7G0rvcWDVB2EfI6Nc16JxT8t2rhWpy2k8VmU09H1MvDaVK
	bLqYYDQGlbmT/JDE7cRJpF3Mp23bWRu3JoRMQTGAvPmNZeNmNZiiXZfbs1tzvxPUaUClR4HND2p
	ekTcY4EiVIXVPuIx1GDg/bUN7QqjGbOYCRhMY0Hjj/YHZsbqeVgVglq30+OcxImZbsX7tioo3up
	ilQ4f0H2vWYBMiZ1nCGZdIg4ldS3ia2YjJeHAEK5nT+RDRXHx51FNvv72ZZzNM7ksgaetzHDaQg
	S7+V6nvbIC15XkKpQ7mxaHxyHorvTMxFs8D+FxJTO9OJdPqtk/dKNpahHpCZeSVrr3GBlN4ifM3
	NbkPkcFrPcX99bft3jQlwKmkdVOUfpA2ErNjnx0Z/47oQGjLoZX3Cw==
X-Received: by 2002:a17:903:19c7:b0:2e9:5772:9ab2 with SMTP id d9443c01a7336-2e9a6f5876emr29025655ad.41.1792255226030;
        Sat, 17 Oct 2026 09:40:26 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804ea9sm22325235ad.13.2026.10.17.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 26/43] bpf: Don't take an extension for an iterator program
Date: Sat, 17 Oct 2026 16:37:28 +0000
Message-ID: <20261017163745.3341787-27-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

An extension inherits the expected_attach_type of the program it extends.
If that is BPF_TRACE_ITER, check_attach_btf_id() hands the extension to
bpf_iter_prog_supported(), which goes by the name of the attach function.
For an extension that is the name of the subprogram it replaces, so the
load fails with -EINVAL, unless that subprogram is called like the function
of a target, bpf_iter_bpf_map_elem for example.

Then the extension gets the context of that target.  If the subprogram
has as many arguments, it can use the key and the value as buffers, but
how far it reaches is noted in the extension, where the test of the
iterator link does not look: it reads and writes behind the elements of
the map.  And the id of the subprogram in the BTF of the program is cached
as the id of the target, so that programs of that target which are loaded
already cannot be attached.

Refuse all extensions here.

Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/bpf_iter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 4668c1696a08..5fd376bd210b 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -351,6 +351,13 @@ int bpf_iter_prog_supported(struct bpf_prog *prog)
 	const char *prefix = BPF_ITER_FUNC_PREFIX;
 	int prefix_len = strlen(prefix);
 
+	/*
+	 * The attach function of an extension is a subprogram of the iterator
+	 * program that it extends, whatever its name is.
+	 */
+	if (prog->type == BPF_PROG_TYPE_EXT)
+		return -EINVAL;
+
 	if (strncmp(attach_fname, prefix, prefix_len))
 		return -EINVAL;
 
-- 
2.55.0

