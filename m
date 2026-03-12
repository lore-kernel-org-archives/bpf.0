Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A473BFE5A
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314815; cv=none; b=ANNxQD/XYWTT6HzP3pERj6X5/DKE6qJNYlB6qV897Aa0StAhTdB4ExHJUkzglBFsCfQCVgFO4uMK9cW5ykSJqzU3a9ldPAiN8zV/7jfQBSagBY0TdecZmAjzWtgmH48C//K1qdTA2Mcef+EFe0uIjShaJ1dPAFwCMdH3TNXpHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314815; c=relaxed/simple;
	bh=hONjoKW8lbcK4m/nBCw35qbraUZ1h35kUAkT77FBWNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs+feK9ca/KwA4RPhTco1xc0DO2bfQ5Lg/RiaCCI4K7CLRtJJMuhDcopBHI7N2nsnsgEG8mpcOhQv91Lg/uLgRo4GL+KU9lUjHlYqjzl/g0ahhs7JqB7dgnTvDuW+jQP257KlbAmgpwF00tRXtvvFbMhDr25HFU2MxiEiQVspMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH6C8T69; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH6C8T69"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso398916a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773314814; x=1773919614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnrUOtkQUjiIiZv+j9+wciHEC5qTOsTWvu4EDvG8L08=;
        b=aH6C8T69vJPpiAnLeT3tH9UWjRYvsXvJ4Sd+s73Gto8dp+fEMMxYZP7gn9eX1ciO0Y
         CzN1h4+1bYolwEey8PO2LnRJGDJo15xZ5dYcMQR+/hgwM1biH+OybJPLDRnHWxI4wC/Y
         6+ozeebj3Yvcg127opJPtsZ+iALuG8PXgCLmfSp0B3Ou3nKS2jR1XDcvmGi96LSTe1uQ
         BfYENYxk8P7OUHsOQMmpMP+1xRRsCv4g/Wkqin3BOESsFRyOldBkNvHvquvSXMceFJaH
         zAzNTEYN7UAmXnTAVBaBMHzpZFx/VBzOjg7qgbBkPPlzz1h5HHyhEXWUld3pJud4JFO0
         Hg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773314814; x=1773919614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fnrUOtkQUjiIiZv+j9+wciHEC5qTOsTWvu4EDvG8L08=;
        b=FqoRSKsfWxiiTTcacCofg+bDgGE4yDK5hJKrZNaNo0cQzxmgq+ARcNBusTi8bABXCA
         C9jsha/njS5xKLfo6SOWek/ThPl5srkPUQ4vobTMcfxqbqcfRp+XnVVfv7WFqiTvJ+Ne
         qS8D8EmzkP31MkBjeMXRYRLFYqMziG2q1DRNhmmXY95iwWB/Idh6cFOTpZYIKNNzAD/B
         1kCbRoKPQB9BgyYQpNGgGl+MdUSeMcpUMnqdxjA7AcYbG/NYKrar7MeIsFX2AuE6U5cI
         2BtJiXCEbYMs1cuoepXtLRbT5ej9ISUu/dsaRAQaETd3zNh6RAFnPDoltzBBjzdouoNB
         BAdw==
X-Gm-Message-State: AOJu0YzeYJCxQ/HEd6DZhv+WoeKdRjnP5mYY2ifYLvadjmgjCuAj7oNQ
	GXbgbki+colIOh1mNP7SRUGfimYxQ9quGUALpAF2ErhyOCetlKkUMlSRZjUdKP8pISU=
X-Gm-Gg: ATEYQzyCHj/4faei6HwfWH0sq3uCcfuPTaDPXM6asGz5VlDnVCMj9ar823XfhtRZCy6
	oOv/jcres+YAS+2aRuTDbev0XOSds4bKHG8GAfA2s5i1pqhcB8d4jHpSmx/HUfzInq0Mowqt8li
	2eBuN9dMmeUBrH5QEilp84n01aD+suS6UnFSdEuyVWopdknFNjVRL8Z4B07jMKmuZllDRSikZ1i
	yqlTlDsqYJgrN/TnXSX7htwRbYidNzkQRRlyOf6SBzJrVu4psY0Ta1/hMGRKZ59rVFupnVNbrIr
	3X6UeAbuw5kvgpoDYquXsyF4XPLmlmXGMtL0dh7q/tCoKzR/wijZfH90RPW0cwtOlzTPwVELnYx
	C46qisMllgkA+5ebgCgMyYHANWTcB8ZPWo0+RKRqqV8tQQycvpHgTqWbKNfTR2KjnvGJsTQFtBb
	4zgoPhB/zYBUpf2EOnaSl9vIg5+rwoblz9sGzaJbgF850jIMJUjDgM6gVlI1dSYg0wIT6ZYKsnG
	MZk1RG0Sg==
X-Received: by 2002:a17:90b:1f85:b0:359:9cb8:db5 with SMTP id 98e67ed59e1d1-35a012cb5b9mr5192713a91.26.1773314813662;
        Thu, 12 Mar 2026 04:26:53 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a03005f7fsm5220579a91.15.2026.03.12.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:26:53 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
Date: Thu, 12 Mar 2026 22:26:42 +1100
Message-ID: <20260312112643.22659-2-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312112643.22659-1-danjwade95@gmail.com>
References: <20260312112643.22659-1-danjwade95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
source operand is a constant.  When dst has signed range [-1, 0], it
forks the verifier state: the pushed path gets dst = 0, the current
path gets dst = -1.

For BPF_AND this is correct: 0 & K == 0.
For BPF_OR this is wrong:    0 | K == K, not 0.

The pushed path therefore tracks dst as 0 when the runtime value is K,
producing an exploitable verifier/runtime divergence that allows
out-of-bounds map access.

Fix this by passing env->insn_idx (instead of env->insn_idx + 1) to
push_stack(), so the pushed path re-executes the ALU instruction with
dst = 0 and naturally computes the correct result for any opcode.

Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the verifier")
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
v2: Use push_stack(env, env->insn_idx, ...) to re-execute the insn
    on the pushed path instead of passing opcode (Eduard Zingerman)

 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9e2380327..68fa308520 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14206,7 +14206,7 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	else
 		return 0;
 
-	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+	branch = push_stack(env, env->insn_idx, env->insn_idx, false);
 	if (IS_ERR(branch))
 		return PTR_ERR(branch);
 
-- 
2.43.0

