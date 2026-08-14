Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1E3A7F7C
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744392; cv=none; b=lNaOs3ddkyDyPLAV38QACx3iNanQFbNesx7EUOtzg6dOaUEmdFkVmPrbp4tPJwFI/OFbGpgsbpdGXtr9dztSEWefGDnCIr0nEy33JiPdmr8211Ov1DqTvrZ+73Ta1P2Q+p/CMm4JDNXYHfZ5degttb7PoEPSxOSh7CroTKjxrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744392; c=relaxed/simple;
	bh=YBSQEqEmlHDxdm0P4EYkLzJ7pEl1unA2e9P2W/1HuKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4PEmHSCx6sV/jM2wNUiCS1EEXlflEJGMoizZG1Ou9vF2HFF1a2dg1ZFJEHZHmpOy2fxRpSxDwa/AYdX8SSKxiam13+Z+jgYNkI7o2CeerYpQVB3eJPuuR8CtCVKsnWLkKevk3/mMl/2NRnK1/FX7jBew8A7aT/vXHm0aPrSpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eYWk+x1z; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eYWk+x1z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mESqynhU62fsjvxDRQKPK/hNWNy1zvFIJ921s+EtIEA=; b=eYWk+x1zJvzrnLFQ7OyMnu+m8t
	fpRvjXXQ60Y1NyF5WRl118qZaDZZbw0u7znzX3ItmhnZNypYVkXzWdwaZHCnhKzzLS1Gr6vU7/Qlt
	ndpUl3KalJgvXf084rCeHnFoZ9J5gVgaljnQOQXasJUrRUl2i2TJRD24h41N/2yroNn1qoT/ecE08
	qTSlfoinxJwou1NMuxUKPe4HPhRPGJlNN8XAFC0vGxaKaZs+UOOgISQOL6NNqGRWlJjDGLHTMS72G
	CUIw8u11yDHjFLRfpOL/TJXhL+++jSwPPJ5tSZusd7sx18bDQGngSfbeW5Z307oSBZZBMe4o0jDG0
	993ZNbgA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wuzpm-000F93-1N;
	Fri, 14 Aug 2026 23:53:02 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 2/6] bpf: Treat a fault prone PTR_TO_MEM as a pointer type mismatch
Date: Fri, 14 Aug 2026 23:52:56 +0200
Message-ID: <20260814215301.709827-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814215301.709827-1-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28092/Fri Aug 14 08:27:02 2026)

reg_type_mismatch_ok() enumerates the pointer types which must not
silently share a BPF_LDX with a different one, since the type recorded
for the insn drives a rewrite in bpf_convert_ctx_accesses().

f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()") added
PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED as another type in need of one,
namely the BPF_PROBE_MEM rewrite, but did not add it there. Fix it by
adding the missing case to reg_type_mismatch_ok(), so that a PTR_TO_MEM
which may fault on deref is not mismatch ok anymore. The triage in
save_aux_ptr_type() then merges them.

Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - new patch to address PTR_TO_MEM case differently (Eduard)

 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a3d165e92175..2e6992569187 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16974,6 +16974,8 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type type)
 	case PTR_TO_BTF_ID:
 	case PTR_TO_ARENA:
 		return false;
+	case PTR_TO_MEM:
+		return !bpf_may_fault_on_deref(type);
 	default:
 		return true;
 	}
-- 
2.43.0

