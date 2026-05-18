Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EF29B795
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116156; cv=none; b=LxX7WQPzD00bmuSGnB9lB0bjrGRYKdmy1pDePDsx3EGTOKJLhq2mULhwIVmZse333LszDooDWnnX7CkD7iSt65cUEyoa0M33lAYJTng0v3wOui2PtP3290bTKudvU9L+2DxaMae1/KFYCh51hOQ9jEmCGnd9OoSeCfOpPZsY19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116156; c=relaxed/simple;
	bh=jU32sRYAampJ/AxzWYHsInO3pypPZWbjn6UgYtcB5uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJZ73NfZH8I+eviF9PWZjP4pWwLP3wX2RqRCuWnokfZzG2Uyr2I058EYhWEY01bb1V2WcET8tFhG+EzKLAuTvzCGZz9mfTZ6+8E3dBKzaIpRrgjFxl32ltVrmSsi1GPZtft7SPxNL8CSGHfsMlZA5GckxgbZbXcpU8AU+FuzhU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZgML7De+; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZgML7De+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779116152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZ9pGaJgcvAYuZq+EY3vbtim0GdS1hYwFfNMO482RPw=;
	b=ZgML7De+IVipfNqpdsYegZ5AGnzGW77FemBci1bdABfkhjPlIgQfAUrLcsSg5+fNckz5Ig
	9K0O31/yvWNT1SGbRV76geBnABkpQ1E9g8VR3rL5dhlRyGvLbGVLGse9A2ycKrzs/dMpIE
	gTrURGjbaPjSpKX5HkWtJtMxdL1RnOY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/5] bpf: Check tail zero of bpf_common_attr using offsetofend
Date: Mon, 18 May 2026 22:54:42 +0800
Message-ID: <20260518145446.6794-2-leon.hwang@linux.dev>
In-Reply-To: <20260518145446.6794-1-leon.hwang@linux.dev>
References: <20260518145446.6794-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because of the 8-byte alignment, the compiler will pad struct
bpf_common_attr to 24 bytes. That said, sizeof(attr_common) is 24 instead
of 20.

When check tail zero using sizeof(attr_common) in
bpf_check_uarg_tail_zero(), there will be 4 bytes that won't be checked.

To also check the padding 4 bytes, replace sizeof(attr_common) with
offsetofend(struct bpf_common_attr, log_true_size).

Fixes: f28771c0691b ("bpf: Extend BPF syscall with common attributes support")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6600e126fbfb..83de8fb9b9aa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6278,7 +6278,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 
 	memset(&attr_common, 0, sizeof(attr_common));
 	if (cmd & BPF_COMMON_ATTRS) {
-		err = bpf_check_uarg_tail_zero(uattr_common, sizeof(attr_common), size_common);
+		err = bpf_check_uarg_tail_zero(uattr_common,
+					       offsetofend(struct bpf_common_attr, log_true_size),
+					       size_common);
 		if (err)
 			return err;
 
-- 
2.54.0

