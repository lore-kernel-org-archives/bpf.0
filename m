Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7923E334
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545350; cv=none; b=Rn2V27mZIQDL8u3uU3GZDHojHXPBeAts4au3wcDcKGgqrQuStO5opskEUVwQV9erEHci4U5eUj/UO7GuTQ+7W8AYDs5PvJLVwsrmdV/xUpBT+W9PAdXHay1uNacb34/YVeVaYRPAs13NoP9JCFKvvcFuh9f6yRlTa+v6fTFjKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545350; c=relaxed/simple;
	bh=2dN93JOTSM1ahE5zktw07DaDNe+T0Bv4o4hH+Ay09+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI429onZhjsLXdDooe7u9+EKP7vPi3cvrOCZHI0qv1+1JyVvXiMFI/uGqAUWUru1/zaS6H4GnoNVxlH3BHxy040/NAOQlLwozvg04PqpQDIsjDWOTewJLXvfG/T0X8LudpLDI4M33MBoFJ2ixAB5Jsi7fL5qRcPrRF8tkaW6me4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XlGLrH47; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XlGLrH47"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UxecRz2pAe9aDYMiff3x04oFsOKEYpOQSBk1AFA8S2s=; b=XlGLrH47RmUzNmO0/L0v+qvHmA
	ZwtsytS9gZ2a5LDJ8FYli7VupBx05tM82K1ZL886gATK4kZCkxa+iEpLgAPy6ra7usyUh1Gh8ihnC
	GOv1PjSG954CD2evnRGzNhRblFX/eT4MjTbEj/Kiwv3N1u+dEqHc+xWEx4pF3NjvA8qkidzS7VgjL
	WMjkXRzm+dGgjeRIbPFe+kIUGqkINvH5Rz/08AwIUyTAFjyjdVhU9Ythvedo480KboYV8gwShUKuQ
	9PC4wHTs5t0WOVoJV3nG/aw0kI5AWKVAMrAVBnlR8tKLkzGgwTYL4aVnfm5Chd8h5T4I/XaBdkcik
	3r2I9twA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whZcK-000OUm-1U;
	Wed, 08 Jul 2026 23:15:40 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/4] bpf: Account scratch buffer in bpf_prog_calc_tag
Date: Wed,  8 Jul 2026 23:15:37 +0200
Message-ID: <20260708211537.371874-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708211537.371874-1-daniel@iogearbox.net>
References: <20260708211537.371874-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28054/Wed Jul  8 08:24:53 2026)

bpf_prog_calc_tag() copies the instructions into a plain vmalloc() scratch
buffer to blind the map fds before hashing. The buffer scales with the
program, up to ~8MB at the 1M instruction limit, and is allocated on every
program load, but unlike the rest of the load-time scratch memory it is
not charged to the loader's memcg. Use GFP_KERNEL_ACCOUNT to account it
like the other allocations scoped to the verification/load.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6e19a030da6f..f2b6e4c888af 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -305,7 +305,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 	bool was_ld_map;
 	u32 i;
 
-	dst = vmalloc(size);
+	dst = __vmalloc(size, GFP_KERNEL_ACCOUNT);
 	if (!dst)
 		return -ENOMEM;
 
-- 
2.43.0

