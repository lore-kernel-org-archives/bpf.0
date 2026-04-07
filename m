Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024A37CD53
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592157; cv=none; b=uORaBE7eb4ptXYylOhuQU6qwiVE7YoWjTVvlDzY2M5t/cacpA6pWWwvbkPUA3viXBqPjkoKWfNW6nNVl4c2KpMuCEKjlCTeEWsy1mJOfefuNLZB0puOYFTTPzU6bSGjtBahyk7eMSyyNK+jYGCUiXlWPku+6+hkbULdMXWmkdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592157; c=relaxed/simple;
	bh=969N04GJ63B6j3UvBpT8Xq+THHPJF5melGvVjbfv/jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koQnrbJ3HPlfI4rizqaL8fT1xVsG9+gCc/cGAccCCKSnFoJssGa20+k+Uod0Ne49qArVJ7KJyIEJyEf5ITui1OiaSOb8wunNcpDdzs7OlqLcXQZBX6HnSAF48fdW1onAf6g5wrkD4MAejve6AFvERkuuD/pTh2mLqKrkdS1KOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spWqyiDj; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spWqyiDj"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65006c99d38so5987188d50.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592155; x=1776196955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh9HwIL+CvvpNMQ+fa0HjatniWcHatd9mVcMTjGbHyI=;
        b=spWqyiDjKcQ76GvS9Qi99Hn61LwzbS++wKhAPzlridqIFzKfA1ld25/YXV89n4mg22
         xmzPYZf9KjaoFVvry1OHp0MjGXcgHO8L+9LGXczqji417tU5ebWeluzX1ao2Vi0Cmjuq
         4t5WCv/a5mBZyjLy5jNzVvc5MLqUbsFRwWwF03E4g17tGkZpZGtSmxp48dw4dlROoE7y
         qtDwWJjaRnYVM6cKu5rgmCHRAlQfPtgPqpJ7Bku1ML4XOEqRh28YhG8qG2LF2b9UloOv
         esMDjao0zUfe41Dm27hlrCUL/cJhuh0Mk3RXdAzZYEIZneuK8xxcNmrgubNDox51uhfB
         RUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592155; x=1776196955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kh9HwIL+CvvpNMQ+fa0HjatniWcHatd9mVcMTjGbHyI=;
        b=WYuS+EBB53HPEEa5API0ZQ6jZYd54fmywGHFMdsFAcZvTnWSwU7IaOX7CAhbEN5mFS
         C4B/h8GndTkT53XRMopoLrEjbqF4ELUpaOZkkPXKzaxDfZf2ucbB32xgzkmWbvL/9tkh
         XkQ2palwUsXmRYUAFgYDeYIan76isR0WO/VXgvEVH9FUivJyGw7q4heK0B3HbD25wdNB
         6Lf5GCyTZmO4yxP9D0u38rJxHHpD68fHj6bhO5hdZ5FN8D0vOvsxItuC5H+IxkuZPtNs
         ALlJjBX8RxoHq35xnWR1D5lHS704ykJFSLoy6nK59TLI/pqp0f+go0gGhww4gkkUVqXb
         85iA==
X-Forwarded-Encrypted: i=1; AJvYcCWKOtl5wfcwRzffvxmmSYCFSOJnRZmHNZE/s881kAVqJcpVsAeWA2QPs/H7tzz1rzctvek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMlls19nhQ6Jmm6AdQxrgMkr7pXM7jicHgtCPbe1v1Og4A54E
	7oNB6MbEDNPoDCvu6HUNuMH0VPGxYRzgXv9pFG7ben62KpTvNOr9BUVa
X-Gm-Gg: AeBDievSC44TQz1KIkLGAb3PpZAMCHqg7ekx4LWzjZKb7/4KVWXxMTHCmJ3p8vnPEJv
	YF7Q189fnmTRUByAjQ1M42tB5uVow7B3ygZ5AkamKm7vyR7SvOco7cCFwJzMhYpmU04HNve8z1X
	NHHtgyQGrpli+Zq8Uz4fjuPQCi56bWk/PqfGAM1biYiM3/iAJHmWQ1EphvBm4a/up/K+Rgo4Hl6
	62OTT17g2VYggdxihf897eAINvZPty6ZUIvCqckpRGTupdJ3mwG7UINVgu3sT4s2b3fV6DEP2kz
	E4QFGLrrGvEBHd4MBcM2ZPNET2uwdAp47gLDzdHNCdEfVP2ynqbIPPPPoxt9HYdRQatGUBkwgmn
	XerqzMbonX6Un3SgNng0yWhnXVFRTWvjdONgy5d43eCAfnTLQPTC/nUiBYSiuAM4oM2vycQBVps
	4PzZUBVSt+Z97vJQyIECS6TKoDG6wBE1ktQEc6GAPcPQQRbp9nL7PbVJmx4+iq/HrUsbtQgj7W
X-Received: by 2002:a05:690e:4812:b0:64e:c641:d06b with SMTP id 956f58d0204a3-6504869ce58mr13854064d50.6.1775592155586;
        Tue, 07 Apr 2026 13:02:35 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:35 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 11/20] selftests/bpf: Add Landlock kfunc declarations
Date: Tue,  7 Apr 2026 16:01:33 -0400
Message-ID: <20260407200157.3874806-12-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the Landlock kfuncs to the BPF selftests.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 7dad01439391..00f2b337a232 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -79,6 +79,26 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
+struct bpf_landlock_ruleset;
+/*
+ * Description
+ *  Put a Landlock ruleset obtained from a Landlock ruleset map lookup.
+ */
+
+void bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
+	__ksym __weak;
+/*
+ * Description
+ *  Modifies the credential of the passed binary parameters to enforce the
+ *  provided landlock ruleset on the new credentials. The ruleset should
+ *  have been obtained from a Landlock ruleset map lookup.
+ * Returns
+ *  Error code same as those returned by landlock_restrict_self
+ */
+int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+		const struct bpf_landlock_ruleset *ruleset,
+		__u32 flags) __ksym __weak;
+
 struct dentry;
 /* Description
  *  Returns xattr of a dentry
-- 
2.53.0

