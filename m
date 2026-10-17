Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5C3793DE
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200642; cv=none; b=aTrY7T3Sltr4MBWBYIPKc5vNyqvzTwc5ibsUwKNlhgPnz6L0vdHwf00dPCSdNU5a8HHagY8tK/Gd/XEMUoGDO1Zk4Cc00Y2F+RiUUBA9nEZ8OZo8q8zdHqmiug4oXsXocylreGAZCPnP1TrpJmeJpPkCb8Irpzi6a6rTE2yRlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200642; c=relaxed/simple;
	bh=1vipa/BUWLt7FxSSWIAQxQD1mC5GvojWAIA5QQzic0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efZEHdlYYtXxrHVbnj1mIk+n1Fm/5/PQxyiS3U8Zgjud9+PMQSkpwzB28eO2SIwZkJjQauzZeygWyrIGcTeH939qYmvyfx5RNrSKetZudsMpG/XvBEW7aYO92G7crPWN5HXsXlI/OX9YKv48OkY3eQSvHwx24yv3vpFaw3ewPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THQ80jbx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THQ80jbx"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so242595a12.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200641; x=1792805441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmpNB1WJ0gNH4EFaRbOnrMQM/lEdyqJ32Z6JUH8YZaE=;
        b=THQ80jbxmrWQUGABHabjqzQfQUYGVWZBO6zpHYB2QHSMA7TStkIWAAFP8G2gS6JCQX
         x9Y/u/HsHNHNSDoOqiD8UJw1fhU4xEpdvHKIjpsBHofYeRHHOIARCT/2Z2T3oReATIj0
         +kG4/wo0xp440UnVwR7nlWGv7exHcRP4VHrANUr5EU8gslbdiccVUCn6TkEeL2xW593g
         zryTGDxe8rpwSfXDfb0Fuj+w8JalrH9cjM6rHnMjC9LAyFplhGyepRzBjf4mzlf+nHmR
         kGhqG6D0KEh6MllYo5IqudwCBQ4arZx7Nk+HiQ8mvr31qkcfPXs1pzzxp9B4MfhuLVbi
         FR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200641; x=1792805441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmpNB1WJ0gNH4EFaRbOnrMQM/lEdyqJ32Z6JUH8YZaE=;
        b=kYmaDUjUcMVzvC0NkhhNjKqOLUN0IWGUiW2WtCBQgkuGmVffVmvBwKXnvgtaurB3UI
         QW8FkIfhMX365y5ciaKmXukAtmEKNHxu5a+btRgO/2U3uSFZ5ecX2odmAN9yZSUTm0ez
         GUpUJIcRJ9Rrs9xSxpFQ2Xm/vl3zRu9rKBR+UuHMqkpZZoGsjMiuaGimftukN+oKWVZ/
         vOGCjqtoFX4jPRqrwZuhpqv/tU9BbnrEdna0I3JNlovd7N+vV8yR1Og3jQZKtiPjU5km
         /Zwt2ILuQCF2F9aZEoDFKE5ZD9lIui5CuEevkJ3ky+YUYT5RbgaNdtJv74vNdi7Hzt4d
         WQnw==
X-Gm-Message-State: AFq9FYLb8RM5H3pNVJ4n2exe9/0ojpQlc9TSaxeNaKjlgfjAnOjOIRyQ
	7wt9Jp8kqfWDe8FJIGXUoZIyRzG9FgodQLTK8yNI2E5s9K0mUaOGEfVsso0RD9F0
X-Gm-Gg: AYBFou1y8MWpIXsYFM+OQBxl2xtfkH6tEa2zXeDFToBj32IX9sFS7mmA2hEt8En0mPF
	5rOBwF5Qu06enUMYTcB98Q9s8O+cf4CoHXO1tDAqskvZSgSjr0ByWFKyTsmbDhKFTiCskT+GNXR
	nxtk+n5rB2kkDFBXkW99OOOb7PX0LndsA1lboLrlvvUGOjlT6bry2a++ADXrando/dcHb0LwAXs
	RmGAqwyPQbXhCNX+pTibZTZm4BJnKg9iKAHEcy0f694X4RRw3tSabxV5fxa4+FhoJcRTKt4OtY3
	MEGk9txURbp3M2Nu+qDsIrOQRijfIpSBEvqYEsZSIeqDeyvOfwGOpHDSDJd7sN5CATr4bPuxkxz
	ug3Yn3xaC3r7UxCXzLXlgXeOrceJeCxOBR2sDb3DWAaWELbqUROKw1Yhj3T+f046iP5hC4i3xjL
	Z27kD9KX8Js5Xkm1u45tguERM2YUGHluRy+RNbXE+Tq3yMjYqZNpGpKY2hUzbvI8DOiG3PPjeYs
	U8U3Nmv6aaIyBDJSSFm5kY7eALOlG6j+chX2kDrDLwWheXjCaJCGzjKTy435zlHkw6Rgjl28pEq
	ijNsEr4pYozLaxAcubqn1Z3MmLVvaQLEuhoCsGxfR4Y=
X-Received: by 2002:a17:90b:264a:b0:3ab:5758:3757 with SMTP id 98e67ed59e1d1-3acef578121mr1187337a91.61.1792200640519;
        Fri, 16 Oct 2026 18:30:40 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1e1esm6264686a91.1.2026.10.16.18.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:30:39 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 25/38] bpf: Don't take an extension for an iterator program
Date: Sat, 17 Oct 2026 01:24:38 +0000
Message-ID: <20261017012451.364800-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
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

