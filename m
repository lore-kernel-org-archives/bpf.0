Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B84389E02;
	Thu, 26 Feb 2026 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091717; cv=none; b=rjdzIYR6T5dr7sMN7z1MR5UEkblbfgkj7acD3dkakEIz/XDsCTkvaRRcSqA5aH6QrwV/Nv3e7t2FvTyianabISDeFKqw1dVz9SKzEOF8lkmd4XlVhS3M3La4WAio1Fkwig/XGReehprX15MnE3Z/sHzvPjMnGJ8VKCzNGCXSaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091717; c=relaxed/simple;
	bh=PXWrOp6y7kEkmQS7Um/XX51tvFno9zCvan7Tjvrgyr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UXsLGxuyLJKFfTZoFYbCQgYNmDzPf+ssHrticNQUJ457fjgslo0KlbWwifvRLqjFs6ZAR3fjQit9nKAkOyVWQiRSaywgIHwdUoj+riYOo4IVqbP0mrEdAu4b/gHaB8DT75xc4AlDhEPSeMZlXzPvnSwkluSSsPvqlWm0uQaxfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGosxN/N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1eSXnx6l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGosxN/N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1eSXnx6l"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772091708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omBfLbFXMCwUSn7dR2xadwZCNA1nUo2zobspzalKetM=;
	b=MGosxN/NL/dy/KF2FZQQc73zWOhAx1ZFOFzfcq2KQd5ZtbM0G+TwS5lmb+tcfJC74Dd4Tj
	pttsKfoN5oaBIxJufXr9wYvjhujhZQwyzXlh+hrUxMRwShXg1K/Z45dLELEwAxrCUqQTat
	0l511t67SFJHn+iAsO4UM6tpAygquJBDYAJodAILjfLbevAQZZhkU/zUovXzapCbdT7tKu
	0+x9ENaKH9GFX5iSi6duACjT9qSHx4DXlpx4qfG1uv+Dze14HbRGwNGPZjzWFNdUhpcMuu
	XslKSDyrDXF6ZPG+ZjwshVQ085ebdm0yqWfOPD6MDTWvgBrKOsNellNOufUMkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772091708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omBfLbFXMCwUSn7dR2xadwZCNA1nUo2zobspzalKetM=;
	b=1eSXnx6l1zfPmi8Oy3i2sf6cNuLixUtuktMAB30izca4JlyNO4Ph4DBJxj1fZqb9tWOw5G
	BkxkcIZC/BMbamCg==
Date: Thu, 26 Feb 2026 08:41:48 +0100
Subject: [PATCH] kbuild: install-extmod-build: Package resolve_btfids if
 necessary
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-kbuild-resolve_btfids-v1-1-2bf38b93dfe7@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M0QpAQBBA0V/RPNtitoRfkbRjBxOhHaTk320ez
 8O9DygHYYU6eSDwJSrbGpGnCfSTW0c24qMBMywyxMLMdMriTWDdlos7OgbxanqH1lalZSKC2O6
 BB7n/b9O+7wdvc4RWZwAAAA==
X-Change-ID: 20260226-kbuild-resolve_btfids-ca233983ebbb
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772091708; l=1162;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=PXWrOp6y7kEkmQS7Um/XX51tvFno9zCvan7Tjvrgyr4=;
 b=6n2Q7uVbmtHxXkatdUk7JfGpkmRO+CWg8qIyVOMgkzoLuJLmOuZ8SM/pwveKnVSP+BMg7M8XA
 dmJ/Kys4aZaAy19jnyQTcznqBHFCkeMYutigU5Tiol2vyrlBrBerUb/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When CONFIG_DEBUG_INFO_BTF_MODULES is enabled and vmlinux is available,
Makefilefile.modfinal and gen-btf.sh will try to use resolve_btfids
on the module .ko. install-extmod-build currently does not package
resolve_btfids, so that step fails.

Also package resolve_btfids if it may get used.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 scripts/package/install-extmod-build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
index 2576cf7902db..f12e1ffe409e 100755
--- a/scripts/package/install-extmod-build
+++ b/scripts/package/install-extmod-build
@@ -32,6 +32,10 @@ mkdir -p "${destdir}"
 		echo tools/objtool/objtool
 	fi
 
+	if is_enabled CONFIG_DEBUG_INFO_BTF_MODULES; then
+		echo tools/bpf/resolve_btfids/resolve_btfids
+	fi
+
 	echo Module.symvers
 	echo "arch/${SRCARCH}/include/generated"
 	echo include/config/auto.conf

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260226-kbuild-resolve_btfids-ca233983ebbb

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

