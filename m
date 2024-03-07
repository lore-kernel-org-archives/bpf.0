Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A93DDB8
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781159; cv=none; b=hdVOHUD+l2RsQN8zUN7tYl2v00Q0CS0itL0OyIAYqxbF7Cp8H3X9yhE3DjsBwM3DhThBFwuxh2I38H6sCwEM0YvZGYg8SwIoPwHLbqYDWlCmPCYDD5M5BC5Lcw0BVArXEy8af9OQcEiHrrzxiPMcL3bqTWWhEeGVbykuLWDnmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781159; c=relaxed/simple;
	bh=BJ0IquS0vg1HErG7K8Oe9gg/mGzDJMqv3M4UBjKSkHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOsS6G+Y4Oy/u9BA30c2a5aR2Lam9KJ0kXdyhfrjQsmNdNOxy9QNSn5smFVVc4fN4ni5bbqtqjXcmgiozBakEILVvvJhkMc138YNaYAZ5oGZRQJd/baGZBF/O3zfUTP8mVXFSA7htpPH2ZUWykpaSYXhm7M4u83Wx6lxODy3h9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avjCZLyd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avjCZLyd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dd1d9daf02so2628625ad.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 19:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781157; x=1710385957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lClt+RKfEMg9EMmXAGqTAo5A/Mtjux5XjVv7JeOshxs=;
        b=avjCZLyd2h5SLBkcFCesx3q4rHpIYXId8CLpUnISOapM8NlQkTP+pLYs2v8/X0lXzZ
         p2QtiA4CiUINn9E95eV5PbahS9tvC4tg34HJcYN4myh+ZBEJ/fTPc0LpPcVgt0vNsKgP
         D+s3yWXIWCmLuiOVPAVT48TC/yXw+qYcP47vtVbjpn1emXlLw8Lxw2p8Hhx6TOkiK1ed
         2dv9zb5yYmpdKxlEggK/3fsQyGlAxAVLn5mY32T8QN9vFEisaQkjVt8/dNmOvWRlT5FV
         Up8kZR89sJruC7rzkOynpANUXG4ephGLotywdJepYI5BhMeVXcz/XmrEX21i6e/u3rXD
         31lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781157; x=1710385957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lClt+RKfEMg9EMmXAGqTAo5A/Mtjux5XjVv7JeOshxs=;
        b=UUKhIZQVYFYDqntj+qB6jL+oXEeUPI8prendufkJNA0k697Ij2jIuqj/9uhBbbY00g
         IurzpHW5bOy3r/GvG8rel2yuLWectihEBjIIXwpA0Ap+jGPluc6Iq0VQ1u9bekGciZ6i
         46YF1RuhQ+3G2dznnld+aVMPjLBx5olGdrX7ufIZbRLPh9OuStmcs2KfnY5aYeqlcq68
         qinswkevmEcp6deG2JJ2oinEJsqtExwimpU81kFjn8nn+6mE+AMfS1H68ciJ0Y1i0gib
         93jZXqVS0f/mPWQmaxQrDaQTeey8hm7O9CEykQzwqu4aBzC5K11nzZnIEpYmucRLE91N
         VKJw==
X-Gm-Message-State: AOJu0YxPqh9hlUk64uGNRO8LnZqTePT2htLdJkGvesdE9Mz/+aLZNYAW
	bRy1lhHmB9x97p0IiEcbUc6Q4kZA92x8f8kMsT8KK8VajKSill/789WNIamZ
X-Google-Smtp-Source: AGHT+IG6Wvw6mIXKrPcBpu4RZzBxZ4uELt1F+bm8X3C78H8o9Xcud6ZtjDP1saARS5H24a8+pJFO0A==
X-Received: by 2002:a17:902:b48f:b0:1db:68d5:6281 with SMTP id y15-20020a170902b48f00b001db68d56281mr6590433plr.35.1709781156779;
        Wed, 06 Mar 2024 19:12:36 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:dd40])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b001db5ca97817sm13321129plk.68.2024.03.06.19.12.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 19:12:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 1/6] bpf: Allow kfuncs return 'void *'
Date: Wed,  6 Mar 2024 19:12:23 -0800
Message-Id: <20240307031228.42896-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
References: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Recognize return of 'void *' from kfunc as returning unknown scalar.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ee86e4d7d5fc..9c2a36b1373b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12364,6 +12364,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					meta.func_name);
 				return -EFAULT;
 			}
+		} else if (btf_type_is_void(ptr_type)) {
+			/* kfunc returning 'void *' is equivalent to returning scalar */
+			mark_reg_unknown(env, regs, BPF_REG_0);
 		} else if (!__btf_type_is_struct(ptr_type)) {
 			if (!meta.r0_size) {
 				__u32 sz;
-- 
2.43.0

