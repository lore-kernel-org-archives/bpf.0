Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AF311979
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022884; cv=none; b=m4w4WRAANZq/NAXrejA6LZh5DtIStrfdvUcGdhWlry6WRBi/XKgMo+Req/toCHgA7wwVXpfXdPB4dUYV5+tuQz3P6cGgqKAbj/8O8NSgY/IRb+dqt2G93Sg8qGJWLhwusVgzgUAzm8eyGz7rAChhuEQfMbXvhi1aLaQY913Gb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022884; c=relaxed/simple;
	bh=sWh4qRJW5wuJPUJ9xDpga/kqSm/hNDUxwTBOVpO7yLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9oSFOcpJnLhYvRzjIfpVR3Wl6Rscg8uNGQNG0MvPVyMNthf2EhVQ0w5xbGdQ8lTs3qMzcMqxlk7nb68noXvytk6J9ALXdDNwPCBw7z/VTI71Vxt162zgr+qdXmhzETJU0k1RK7mg/aSvePp1UHTWGVgaQSNBt/rNIr9USSsucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5DyN+K/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5DyN+K/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a78e381fc1so19641985ad.3
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 01:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770022882; x=1770627682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMhSx+6lEu+8jKPgVw5bypgKSiK+gEAAE/MS9cV7FQc=;
        b=K5DyN+K/ykuG0nMpJdIqx3TXUKG1DU0NSoItf7Lh0wuFTUOnAQY7yfVrD76ZzZg8yc
         n0A/SwYqISxuNCNMJ1/A5ru+OQUdjWCxrBijUodkr79r9+/4mZnrWmGIs6kJttOrhjM7
         71qhhu9z0RR9HExXV3K70oDlZ45sbldnimrPgtHMCEUuB522QresnBeG2kFI4DzTGqji
         NRm4KsYSQ24sMPIULrTDofKTBzKY3wgFLz9X4kjPaIiFiDScvG3PbwKuaHlMRc4YjUF7
         nA2w6tnSrpuX/vXVK2MiXfaRaJJUH42dYIrIu8gCkNpGjTVA2N24s0pHECtVG3btuR0R
         WIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770022882; x=1770627682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sMhSx+6lEu+8jKPgVw5bypgKSiK+gEAAE/MS9cV7FQc=;
        b=cMReAjagf1Wn5Vty0kUr8BfdnAAJ/hiDX3A5GzC5me5D83Vq0000ntlNCMUZxKzJe/
         1oBHzW9qJLrmOrYYbLh+cdn4SdcM1BhsvhBMCdX51Y+/7t9lr4bcDhaZvMrp8mIWIGCO
         UizJEy/kHF+DtQslqp9B5xms9hYuGLJPEmFYtkpnVMz07xg3AN4tBpK7s6hPNSB5heNI
         S3lrzPaPaGOUh7aPtmDrpEFzLCs9+jW/MxC0pV4sslfXEnWN2yZBmCW1E8XfjeTMB562
         mDpTpb0Ghyl3J5j9WDSq8qM7Y8tLC4xBngidfoxWdTw2Bzoh776teJrqX7PbrkdVcHI0
         WYzw==
X-Forwarded-Encrypted: i=1; AJvYcCUpKuoMl7pAmnP2wVawW57sX3C9uMhl/ydChauaAEwaTm0ZOgLLSaLiJ2N/nUS1LVfkBH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbag1wyw6NJzSGi71ihvbjSuxaDsXKM/h3I6sM00VnOdqmfKF
	L4V1zwunRFw4wS5gnhAOBAuPq9HOZb7uXqGl67vX5o8XaNvKwlHLyDya
X-Gm-Gg: AZuq6aK3Soojq2bnMRCiuPLvpkamDqSiNFlSkT2YL1AP01P5VRFNPZvjjy+4uanO8fI
	VZrXw/mgd3YGphJsQrHc+WG+SaIzegSW8ocSW/fByVDbrVxseCQHUSewZXMEycwnNpZGWfXZV3o
	kIsSduToMQWX4gtcoTHd7DqsSqLCUIGeRZ9UrhbLGVMnQRi7/FAhbRt5Tir9ERu6sGzEWM3zhRl
	/DYIGnOfFF1hYfUpwgi/1DCys96VnevVzQNNmqaJ16A2mrGZY2MJjxX6sRAmeMgQscv8OBYX9kv
	QjyINh9o1HX9qCBgHK82MwLcTh8ZwlvMLtpVkksDOhCyhj3dmp4PXuXLOmpgHF5Uiz3xa8epxwn
	sv9/EILz0N2lImhzf319buk/UMRbZlawmMwdTslgInmOFmOz5UP12dXEQWC0KKdmjpsqLPdt22v
	DvnA+S3VIukJZiLmid6iEhOxc63hSs+EBLc4jWxIfE0rOgccnyIj59
X-Received: by 2002:a17:903:f85:b0:2a7:77ce:d75d with SMTP id d9443c01a7336-2a8d9a7b20emr99363765ad.61.1770022882405;
        Mon, 02 Feb 2026 01:01:22 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414f1esm139167635ad.24.2026.02.02.01.01.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 01:01:22 -0800 (PST)
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
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v4 2/3] bpf/verifier: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
Date: Mon,  2 Feb 2026 17:00:50 +0800
Message-ID: <20260202090051.87802-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202090051.87802-1-pilgrimtao@gmail.com>
References: <20260202090051.87802-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

When traversing an rbtree using bpf_rbtree_left/right, if bpf_kptr_xchg
is used to access the __kptr pointer contained in a node, it currently
requires first removing the node with bpf_rbtree_remove and clearing the
NON_OWN_REF flag, then re-adding the node to the original rbtree with
bpf_rbtree_add after usage. This process significantly degrades rbtree
traversal performance. The patch enables accessing __kptr pointers with
the NON_OWN_REF flag set while holding the lock, eliminating the need
for this remove-read-readd sequence.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
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

