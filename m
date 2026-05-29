Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D133C3C12
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047686; cv=none; b=mqi9QzlyEaCwWn8GzDpJAOoOkpgutBJo/SELtOYag/9EpkIwKM2a4IbGNpo3SVSwG9y+dYVuZh/DSc3+/k/a1zQZId5xSEY6l03EPHvan+hzn0yY6otJ6jDrIlvvlwqCPFsIHfw4Aa336wuEB+l54YH34ybD7KZENhuIcFPun20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047686; c=relaxed/simple;
	bh=f5FCkTh7N3CoNp6+BwZO6X7QGCTWaghA6+J3PsnbEY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/qipdr89V6QHpbHoThkPtgzSvk9O9iosVGa5t6wuCRD6wV9FcaFMOgZVAHfYFrjX2c9s117NpHokyQCGElCjQwPtG86w2EmlKiSCNk2JUCHFsCm6PLvHzIfjl/02OnerUjnFfqekRmR14TqdWqk3VtH1qf3vf+eopGZrH9xPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a2lnqLCq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a2lnqLCq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oGAyy0JuFEIGg3zEUEy7aox1powyiXUG5D5FE2CONM4=; b=a2lnqLCqdKbcrvsX9/l8Y01yD9
	xBVEO1WSP74llyJpG5hLtcAypUEBlSNpINb5Zd1wx4dC513aDDL48/QQERGeZVoS1tRwkD0//cGQP
	a2WasTAI124pLSJKLmUz1XYFD63mCQdqY9/k6rH/Ihy/g+nkasEvJQQDPtGOa5hGnWDo3wYUzv0ey
	/Ccz0iiWLTBm6ETxytKH3vuVOIhMiKbyWwdVf9X9k9erX+k8oj9OB9terbjPCP9kqfTcOSwH6Axxx
	pyaFcXMY0VTYh5O0o2gNJmp4cogvI7DqYYY/zlKJHfWGmRb2CQXClbsXXzjS9djOnbeCYAwAmeHn/
	SKkzizqA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wStiS-000LAb-33;
	Fri, 29 May 2026 11:41:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kpsingh@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/3] libbpf: Also reset {insn,data}_cur on realloc failure
Date: Fri, 29 May 2026 11:41:18 +0200
Message-ID: <20260529094119.307264-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529094119.307264-1-daniel@iogearbox.net>
References: <20260529094119.307264-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28015/Fri May 29 08:24:51 2026)

realloc_insn_buf() as well as realloc_data_buf() free and NULL
gen->insn_start / gen->data_start on -ENOMEM but leave gen->insn_cur /
gen->data_cur pointing into the old, freed buffer. Just reset the
cursors to NULL alongside the base pointers so the freed state is
coherent.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/gen_loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 3a6e1d53f287..492360ca07ea 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -63,6 +63,7 @@ static int realloc_insn_buf(struct bpf_gen *gen, __u32 size)
 		gen->error = -ENOMEM;
 		free(gen->insn_start);
 		gen->insn_start = NULL;
+		gen->insn_cur = NULL;
 		return -ENOMEM;
 	}
 	gen->insn_start = insn_start;
@@ -86,6 +87,7 @@ static int realloc_data_buf(struct bpf_gen *gen, __u32 size)
 		gen->error = -ENOMEM;
 		free(gen->data_start);
 		gen->data_start = NULL;
+		gen->data_cur = NULL;
 		return -ENOMEM;
 	}
 	gen->data_start = data_start;
-- 
2.43.0

