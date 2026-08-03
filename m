Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2C3128B6;
	Mon,  3 Aug 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743595; cv=none; b=Wv96Hy36l9En/mzA5cw+0c5jh8G/yLiKrhhr3MeW5cJsLDq/PPjCWP4OslZwQ82K8I0JnjwO2R8hNyz36dMk8ETLv+LeGs5JZUrmCU0HqcKFP4LirVQGjMy6k15c2iU19LyKvKZnga5TFhrT59PD/b54r6GYYMxP6rqTAdXrjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743595; c=relaxed/simple;
	bh=zumDTv5YwuxKPGlkXIOGUk4c2rGlfu5DlUHEN/GR+Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZKZZwIly+PTaRwIVgaugN1c4hGZfhKo/lIvPPStEz2TSmt/mQAaBKFiQBUXj6PkLV3hoObbeMbFyUyXzViCfQawM9kTl19MQ6F4y9kT5dQ8dlqQpogZD6p9cKBn/erEhtMNgT8xXuh3n62ZtDipCjR5GRUtlqoSdOO6HZBUZ6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKvUM6ui; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+5gkZPfc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKvUM6ui";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+5gkZPfc"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785743592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yLWrh3nf7QHINPJYlFQu73T+dpLYwGxbvXRvM6iGuYo=;
	b=NKvUM6uiH67G2Glga6Gyd/RHeMbOHzCs5pyD61mXml9IDHx9jMIMp+VEEA8cxwXaT/Fxi7
	8Ew+r/j6s2jYy77OUlXwTjvPEhsmLhq3sAzfY0A2nqf5stmSnZBFPQjqU0Y1PMxAaNJGTW
	rP+uURPHsHUFONUdU/RtX+RnaLD9Y/lOZog1BqyEqhrOp/HjlouqedqlDNdPQymoW6t/qH
	tB9Zpxh6tuL/Iy8yeB3JkJN+uYoaMLGQK6Wf/7uhXs+XOLvT+yXA41XrOXKAr/HRKgP9y8
	eQZKl0PVSmN1HFr23XjzVywebdjcth9A9Aj6tcob1px1sFL6lw4akW47mKR/ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785743592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yLWrh3nf7QHINPJYlFQu73T+dpLYwGxbvXRvM6iGuYo=;
	b=+5gkZPfcqtft+yePL1vgen5in5mW7TfwbntfE0PY7cy48Qroci1e2jgBK9vDJKe84x1W3/
	LPEuvlvOhxZ6FfCQ==
Date: Mon, 03 Aug 2026 09:52:39 +0200
Subject: [PATCH bpf-next] btf: Remove the dependency on BPF_SYSCALL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-btf-dep-bpf-syscall-v1-1-a03291e27888@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqDMBAAf0X23IUkBYX+Sukhj11dCGnISlHEf
 2/0ODAzByg1IYXXcECjn6h8Swf7GCAuvsyEkjqDM24009NiWBkTVQyVUXeNPmd01pD37IKJDL2
 sjVi2+/qGSyy0rfA5zz+o6MKPbwAAAA==
X-Change-ID: 20260731-btf-dep-bpf-syscall-210eaaf2b0cf
To: Andrew Morton <akpm@linux-foundation.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785743592; l=1068;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zumDTv5YwuxKPGlkXIOGUk4c2rGlfu5DlUHEN/GR+Dc=;
 b=9YH686mREGpk9bDXOALVrlvxCCkq1BhnTtJToi8I6Y08E0LUXU2hzHQWZkS9D5s16d6b525TK
 Y2Dty9vQBnJA8LNJWRtFlarkHZdvfVv2QyeSieMat8HaBZ8vgiYwqIC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

BTF has become useful without the BPF syscall being present.
It is used by debuggers and introspection tools like pahole.
The dependency prevents the usage of BTF without pulling in the
rest of the BPF subsystem.

Remove the dependency.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294..f9dc5b60d834 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -399,7 +399,6 @@ config DEBUG_INFO_BTF
 	bool "Generate BTF type information"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
-	depends on BPF_SYSCALL
 	depends on PAHOLE_VERSION >= 122
 	# pahole uses elfutils, which does not have support for Hexagon relocations
 	depends on !HEXAGON

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260731-btf-dep-bpf-syscall-210eaaf2b0cf

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

