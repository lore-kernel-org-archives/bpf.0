Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE772F3621
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085666; cv=none; b=SP38OE/7rCg9gr93qz4pw85q0XESdC8XiczeIM6WoV/moER2/U6IcV4bE3JQ3+yHU6hcLeWHJJgVRj/A0kbgYOb3Ode5goDPGkTmbvMShqwo6W1JgIOQskRbt1kTp5jnNTCJrFuHJFlklB/LuZ+8cc/h3afeJCrfRvMIOh3iuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085666; c=relaxed/simple;
	bh=iDp5mMQgomUSRM/dl6unR+hbY+tl/eiQXHNaSYMScqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHdudB+mDCU57w2FdwgKume84XktKFKTHD8RHzlFnxaEG9VB47Co/vJ+sDoFMnE5d3pmo/n1sWiuDhR/AvRGcHupNfdAJQlXD+Jk+OCNXCmCiW0ofy1enRKCupeMLnCzWX6OGP7IC3qg2GHIoKjPrVzF2gHqV8lfaVG9dBRWYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsQEScCG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsQEScCG"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f5381d168so5215200b3a.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 18:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085664; x=1770690464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlSRLcIcWpZcJLzhBXNRpZvhO9QHJ8h5Vtb0I9fjCFA=;
        b=AsQEScCGz7dVyq6v6YvPhz8lXT35fZ/6g2l1/gVB+qLERMh884EDlP9YfhWqrbTyJV
         5N7zL1TRuh8JI9VqBCk8W7TqZVfdSKpVO/YAdEmgS4NxDg/bR9McyP/Bl+BU9NlBKpQP
         it/q1WPAGfi4sx7BObReo/zwVMVfbtOLQyz/3eu3ireV/9Akc1UKMjsTAkat800xMpIL
         iycVV44QgULIYbEppljzQtR3Qhs9RLCxcwmquVEm+KRD8L27F15Ul8w2gNROs1C+CmAu
         L1kkIwH1y47wQsaI7WbQYgAo/GcVBE81pZHE/FXoeznTVkqnbnbf4AuMvabqlMwg309+
         cQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085664; x=1770690464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UlSRLcIcWpZcJLzhBXNRpZvhO9QHJ8h5Vtb0I9fjCFA=;
        b=PS3C9PWa7ob1QL7Q0oFJa3NxBkGwdpgKXMfFGT86OHwJLcY22rWp5xWEVG+PaRSSU8
         QiFeessfIgCPl+YAIXmkGNVQeXK0aYt3Z9qCd58r9Qo6Ebo1QuO43tjQjLKYgnJXhbZi
         0IYmhfz/dQ0weiIeHJVLoYemZQD+Fyzw9mg4NEps9DV5PbAK9128PRl2iOw76xgPXjP3
         gabAphv2WoF+q2986cOcSoU5Mc6Joevq6ddugiHA65FHcnperR6vKoJAjHxENQL+1PR9
         D875NW6BrXPHVEDNvfOBi4zA/ADgXXtFNzLeyw4rvbdjpKX7KdwOTHhcRWam6TQq28lz
         S1UA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wNwmX7iJDIc4N8FTPh9WZEMvYcX6pC56Wlq/IJqUYUFA/2pmjPy2sQiUiZ2hL9Rh7f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1y9YZsjVhwNeobrQHK8hoAx9NWAMMpMz1cpo/r9KCKNUy7s+
	POVMk9VcIpuY1XFbA7QS8SIrKoEaHr4eNB9kiwtRVh1idlYt6U4XS1Hi
X-Gm-Gg: AZuq6aI+8yK40GyrgEOLRJJWqceoyLICPH4qhdY3Ac313MEHFPxepaqK2kyCn7zvr+s
	F039cMUOPkl/U4VMTnjEkWgigoLMkDE6/KuABTqJtXy03J6RyryKiiDHVhVb62QwBxBSMq4zyaF
	hAia5z0uRJ2mrf+km/CiLQVlb+r8rONCUhZO3NrI8INoAK7ICUSCghI86PO6wFkTRZFHL3JWMW9
	qlN8EmCGFOca6bMf7ESZrzRJ79wQ5FHzTNSk8+aEjAplPk4R0irJixAjb4DhKuk3ApUoVnPG2om
	V5x1qDevsWRPZTckcGnXpjRzyunjRteGwImcnPI3v5Bxs8Yu62m5gcn/RERpxFHNASMMu8g5ZZV
	oQ7eRJNSfZzvo3lh3JmJSV9LX7CE0Qt9FrXcj8T4tGDQvluAraP9tVrtxyvn7gYX7HGLPTYRgxP
	s0HFsc+Cv7HxBYuND2rkGRXtTG/XLqtIRvfsC3AY1Bzg==
X-Received: by 2002:a05:6a00:4144:b0:81f:3eda:9d65 with SMTP id d2e1a72fcca58-823ab673221mr11716726b3a.18.1770085664078;
        Mon, 02 Feb 2026 18:27:44 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b58f38sm17803073b3a.24.2026.02.02.18.27.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 18:27:43 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yangfeng@kylinos.cn,
	alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chengkaitao Com <chengkaitao@kylinos.cn>
Subject: [PATCH v5 2/3] bpf/verifier: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
Date: Tue,  3 Feb 2026 10:27:11 +0800
Message-ID: <20260203022712.99347-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203022712.99347-1-pilgrimtao@gmail.com>
References: <20260203022712.99347-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao Com <chengkaitao@kylinos.cn>

When traversing an rbtree using bpf_rbtree_left/right, if bpf_kptr_xchg
is used to access the __kptr pointer contained in a node, it currently
requires first removing the node with bpf_rbtree_remove and clearing the
NON_OWN_REF flag, then re-adding the node to the original rbtree with
bpf_rbtree_add after usage. This process significantly degrades rbtree
traversal performance. The patch enables accessing __kptr pointers with
the NON_OWN_REF flag set while holding the lock, eliminating the need
for this remove-read-readd sequence.

Signed-off-by: Chengkaitao Com <chengkaitao@kylinos.cn>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 05a6a6606b6c..bb3ff4bbb3a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9260,7 +9260,8 @@ static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE }
 static const struct bpf_reg_types kptr_xchg_dest_types = {
 	.types = {
 		PTR_TO_MAP_VALUE,
-		PTR_TO_BTF_ID | MEM_ALLOC
+		PTR_TO_BTF_ID | MEM_ALLOC,
+		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF
 	}
 };
 static const struct bpf_reg_types dynptr_types = {
@@ -9420,6 +9421,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	}
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
 		    meta->func_id != BPF_FUNC_kptr_xchg) {
 			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
-- 
2.50.1 (Apple Git-155)

