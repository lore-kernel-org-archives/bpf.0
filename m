Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77556392C3D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278600; cv=none; b=PqFDt4OSPSx/PFIQRUxZcO2nqeU1QMbi0QJi8Zvs3zf1niRkxPXL0pVjEXjcHX0yzKXjgsmEx5Ma+R3tAOYHLTQXMMz1cwl/62uU4CVes0JiTeIdQCgT9fNH62AH9gOkdkgKnL0jI30Grmblf2c1GwafObk/GB37kNJ5myKOIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278600; c=relaxed/simple;
	bh=awWBK4a3xR3vB3av3xGBaHNywJ3FmPOen0TQff8G8Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mbd+hWOlSsJ3T8h/vEVHiqB18cydfw6w4Np9cG2/D5q/zZWAxZKNH01D0UAF3MIWm8z1vM6U/oOBiPFEDaiD3scimr+MY2CfuNmK/HdSsLKt6OPg4ODK6UiU8O1+HnZAx0mSJevvHyGIVb1gGTBcGm3+goh8qxYepw+eqppDA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7HmpF+6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7HmpF+6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e96502e447so6842815ad.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278599; x=1792883399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0iYmBZzXNp6oFXjUccGY2IFIlJ5vdBC7N0kBwXZc2zQ=;
        b=T7HmpF+6tmZG/muwJlPi3ks7mY9rpWHdZo+7mOLPRCTG8kCts+Po6tnTNrEY+j2yFv
         /2W1YzBzBFrRoGleoFWrwahxKlTvpYGMtJZSuGyX+ICZKnvQ/1SO2RJumw6DzEsPqPZF
         hliPS2WfjtMynm9T6hDIZfwXrj6vs1mVTOP+M5mNn6TVK4RvGFVtWsCDZ0/LFOEH3ttk
         Y9ZrbV2A8ANADQWOf5X3fZGGFubjsLFQhAYAku2BZnRLknBXFxOSIOLRQ/HDwHpvrEqu
         FEY0GYAJkrvlpKPsi6gkcv4h4WmHW1RmrnT5g5Pf0KmTj59xzehO55Gkiw0WfKsrUqx3
         NXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278599; x=1792883399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0iYmBZzXNp6oFXjUccGY2IFIlJ5vdBC7N0kBwXZc2zQ=;
        b=lQ4jLG7D0yjMVK+syltyRk0CJvPnM2hfa2kEGCG9wfYhU38r2sj5ijkEehwhp+Gzwq
         xeP7kEYSdORncC7P0lVfGVJxR8PfOKNxZ70PRd9YZoU6kwjfepniuTol+tBCwoZ+dTt5
         v+xDh72ij1dD8SWG0tkIx4xS8GA4+Ow/aP63tKFqWMmpkntsTsJR4g7VTUCwEcdhOc/l
         hvCCqOXV3KoXWyiY6JcxbR2g/I/Xm7APs9VaaeNMK7vWUZScLKLJvIVjBxtChCczsALX
         jbhLjksKhnfXXwFkLlqU2HVRPmmSbAMDTs7gaomvK5qjj79IGy5JkU5YM/kWKxocdT6f
         bwiQ==
X-Gm-Message-State: AFq9FYIoaTo8HHYOV2r6NvDqAWoie93jVJTfp+UgFJtoxbR69KzGLH3c
	RPIJVN7tnXS2KuwsDQSRv6WQp8nPp4tCqtCHBEz6lHl1I1ewwN9FCmW/2VWL8w==
X-Gm-Gg: AYBFou1VqmNWUtZFTF34yDjPaHxgFCaB4arqIYN+M+mjFEqrSEV/+sfFG1qjJdeDiBT
	s9IhxWiexY8LVxXhMMUkmbuKM507hqtqoXR32D55YmAkOvFO9YIP1rDQYTW427llTxxIXr9HB68
	XSskqBi/U1ENno1AetSaJni5U/f/iRqm6bu3ulK3rF3XZ5w4WVYQSag4g8AXtbL0M9sCqAN8FrY
	9qmrF0+6xZfbYsTxyM5+9f6msLvLJ3kD4zJp9lg3lK2A6rai478eOrPM0t0ZbheyzKaQlxOh/AW
	FthPar71adDNWApimAM8NujhFrN2rLSoPsXhRER5l4N//FtSVJCe4Q0SgbZjEiSVZWiOIoPPR9T
	nx3S7tbmrIVaC7IupCJ5mpCQAihAvmNVERUQvMIgJlSb6OhXIkDtwdA1o3ntYJmCYk2tml0RaaI
	rFO9+2Wvz/gSuXLNGF+1ISCPhsZ65L8DQ4Cuwzf04qXxVZHaxJSOvzeR2CbwUFAiT72HuhBHCr/
	p9IZeHbgJG3qPn14IXSh1bElkTrtLxA4Co8sbHZX3n/eePydZWsIbZ+9LOIrLKcSkWidZvH0+8n
	IvoF3BB7nGQ0io0TweO5xisPzFzk8eg/rR8qWqeIrkk=
X-Received: by 2002:a17:903:f84:b0:2e8:1f8a:9113 with SMTP id d9443c01a7336-2e9a6f58265mr33530565ad.40.1792278598776;
        Sat, 17 Oct 2026 16:09:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b35eesm23390485ad.73.2026.10.17.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:09:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 01/16] bpf: Don't take a program with a target program for an iterator
Date: Sat, 17 Oct 2026 23:09:35 +0000
Message-ID: <20261017230950.802052-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_iter_prog_supported() goes by the name of the attach function.  Commit
7cc639dc45c5 ("bpf: Don't take an extension for an iterator program")
keeps out extensions, for which that is the name of a function of another
program.  A tracing program with BPF_TRACE_ITER that is loaded with
attach_prog_fd gets there as well: unlike for BPF_TRACE_RAW_TP,
bpf_check_attach_target() does not mind the target program.

If the function is called like that of an iterator target, bpf_iter_bpf_map
for example, its id in the BTF of the program is cached as the id of the
target, even if the load fails later.  Programs of that target which are
loaded already cannot be attached any more.  And the program itself can be
attached as an iterator of that target, with a context that the verifier
has taken from the prototype of that function:

  BUG: KASAN: stack-out-of-bounds in bpf_prog_66d4234e2e50f5b6_ts26_forged+0x12a/0x20b
  Read of size 8 at addr ffffc90000d9fc48 by task ts26/104

Refuse every program that has a target program.  That covers extensions.

Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/bpf_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 5fd376bd210b..de4334bfee5d 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -352,10 +352,10 @@ int bpf_iter_prog_supported(struct bpf_prog *prog)
 	int prefix_len = strlen(prefix);
 
 	/*
-	 * The attach function of an extension is a subprogram of the iterator
-	 * program that it extends, whatever its name is.
+	 * The attach function of a program that has a target program is a
+	 * function of that program, whatever its name is.
 	 */
-	if (prog->type == BPF_PROG_TYPE_EXT)
+	if (prog->aux->dst_prog)
 		return -EINVAL;
 
 	if (strncmp(attach_fname, prefix, prefix_len))
-- 
2.55.0

