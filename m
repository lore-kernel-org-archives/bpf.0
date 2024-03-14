Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365D17C60
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374496; cv=none; b=LFlwCjlZDruUdqgzUunHuAd31crAG2ninxaXa372wAwRv6uV43MSOKA29ivMj2p18t9xqcg/pvDg0w5ISrvPWQKZ9HALpbUM4u8zFbSPdMvKGK7OLK3U50hOYvAU6DsN9ikzv6rnwJ0Cu/ZvZBI/2hyI2lvdPaFPcwYyLfqnRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374496; c=relaxed/simple;
	bh=zch6jg6TeYEeOThCPOcwXNM0sqvzCzrXQe3UvsZx40E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbPHuoHMrEOrbY6712NwmjTpBVjnoRJWctBV7hS6kDCbcyIst6ajD/nYZUTHfyS67eRrtsTqxBh+MkAtBzAwHSqjksp3LcNu4BxdLurgPUuFgDM7e2MXb5pyrhjASvLIB2a9FZkFB7Gagy4Rb3OeSrS5iYqiy1FWKvKOb95aRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeBmTEqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeBmTEqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF454C433F1;
	Thu, 14 Mar 2024 00:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710374496;
	bh=zch6jg6TeYEeOThCPOcwXNM0sqvzCzrXQe3UvsZx40E=;
	h=From:To:Cc:Subject:Date:From;
	b=qeBmTEqhf5mDKFZp0JhtIG+A246kYsvWDNRiCTuS7G0f+t1RGU9cWchLlJputL2sn
	 v59iP9OqmfFbT0fsnhURtYzGsNp0Et5KkxF7tQRX71XwapSoSUaJiX9VD3jj9O9MQc
	 B9cdvzudK6mMlBt1ybkCxbMn9dOWaH0Om4mxBZGlnOMmXDvdw5BdlYnu8o4bDw4Gr9
	 uvNFeTd8nO9XMzSFg1ONb8r8l/ZppsJZ50DwjomI7PsDxmoEAUKlLfyStpkvYUWWyQ
	 tkPhLndbG9wQNoObjZmInnNvkz2/W4eyXVtKdLlIWjuO9khzJL0ZbRCH+OSpor3GZX
	 M49Djp54XV4GQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: preserve sleepable bit in subprog info
Date: Wed, 13 Mar 2024 17:01:27 -0700
Message-ID: <20240314000127.3881569-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy over main program's sleepable bit into subprog's info. This might
be important for, e.g., freplace cases.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63749ad5ac6b..7b208e5d38f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19158,6 +19158,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		if (bpf_prog_calc_tag(func[i]))
 			goto out_free;
 		func[i]->is_func = 1;
+		func[i]->sleepable = prog->sleepable;
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
-- 
2.43.0

