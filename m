Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3C3803DB
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592162; cv=none; b=giXH2wW1MWg5jHhmxD/5HEuNGUXaCV5cbSqaNVqsqkOrz7E+JSTAAQMvEJIohd23x2TTC4XjKDHukSAtOji0QvEZGXK9aJ8o1rqIV5XEsi6sUKm4YP6pShTG8PckcCaFVOWrnb0K/vPTQ37CHQy23JolmYLdqbNXRhBg2hzJMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592162; c=relaxed/simple;
	bh=gVNxQNlmrNpqLDCY5JDdEWaKN3Ea1LpqggVDjFURMJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQDEx++X2sV8AcMRln7KXsdngWfqdNHsOYFmgqBgjls7IDXnLN3yGXDyZI3CXg7lIB05XAMzLOS+H8cSsUD0frMa8yxkLCFbyXlWDRaZpI/NkfVBzblRzzrzgIOwtHECnBeKFqTS4azqUT+xA/LngG5KZ1yNjXmox1qZN65ewdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhSyMzX/; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhSyMzX/"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6505ef94043so2945021d50.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592160; x=1776196960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9ku3GPB6bFwaemZLbl5e5kdGQm1EBbT7DCrdV6VHPw=;
        b=lhSyMzX/BypT3IkLcz4XtxywAllYQmzqo9y2QsKEVqfCqLiK2MklYX4qK274TMMQgj
         nwOhTAA5F+/+MpwN67rg6MxrixumoP/4wMZEq67wKDd8VkoJoZ6K27rZFOTpqCIKHjFd
         AWIfZzK9CU30nqebPKFIHGO3zYZ5GJl33nFJfqcQzoH5FehlsLE9vxhcDUR7Sp2U1utV
         MzMRoBlUs+ouuV9ToXfp36+eNax2j+JnWe41yfunxNGoN9dvFlufT9LEURYYlS0HdNZw
         /VE/2zUJgF2tZU+p2DGgBhFQoiv5fbKJKTfYFcoqR5S6K/sAZK9IXyL8yEkUcx237At0
         AGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592160; x=1776196960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9ku3GPB6bFwaemZLbl5e5kdGQm1EBbT7DCrdV6VHPw=;
        b=T5mPrJlfahiuIGV6D7fI16L7Q2JwWdJef3Nc21TL3YdWmAVtlY9k7U+K2LEQEYp/TM
         u2dlzqSGYzwuAg59hsBio87+7+TQXHSDx+3bKk+GALK79mIs5KCElhn+0LTbeE7dTDt/
         6na/X7XZdclL7py0pg7yu/skufIbMztVR7988UmxfpO7BKMfqN5/mqyTP5Tv3hyefyue
         0QsXOCSrxtPmfIwvntEsI4KetX8nSgKn8PgXY/cOChqmoyHTNuUWDNITubjgtsPIYvjI
         16/EcZ4PARr/ycXVv7ecg1dBJXDm/ECtuLREujltGA1pBSl8xqjXmpLw6X2EDoObY13R
         rcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVERNBNtO8qkiwmb3aOtEOoLlFua6JonD8zQeSEKN7VnfsY0NnsjCckHXNekzOruTUIPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUYGnNqYdEPRyBxOnoguIoJaJgLcFGDcbvLp8ctb01qOqYjwx
	UlygK3T7zD3dF+PLU44XC45tw6iDH7x43j68jKzXWOxEWn0EATylVRhM
X-Gm-Gg: AeBDiev6QINwbIjfQfWEjI7InWep7fzHMAApquXNtAknak9CkxRqI8zGjFqG3SwE9p3
	Kxw1cWynbgeSsD+zd69lYLxrevIifWu5S8Nv6lKfUldpdw3dzt4NvJSoh/cW8MHD4YE2n2qW1a6
	IteQqJKk/gNmqJ0Q0oW/g12eeXvcqjTxotZy6/Joylf6m7ju/NOAOUEK04JTgmo4+L12A35lVp6
	P6qm1qOGb9pgGVIygsha2HbiBvL9lsZHP1VkJCtSBBwpWeOHyGrxcpTHRN1leh1TIO4P1N2ohrh
	ZHQ/hySrKi87sJA+sc5jKphSOk/mTQCB66sPvsAH4CQpQ+D48ep0dN98I2IYlNw1KBUqjUVJlQd
	2z8TiL3gyYk83TMUlOjRY1HqjuY/ovRhk1BzfuVkdbrMayQU/6l9dTkw6WZ426YpKeueDN2sSZg
	vyMGdzFQKe3PdmCx/75FyEvqBlxy2szoH6UV0+IPg3wdASFm1o9eMJI1vcR2n1XYGEigmjaLTG
X-Received: by 2002:a05:690e:484e:b0:64e:8a5f:2f1c with SMTP id 956f58d0204a3-650486bf970mr13046607d50.12.1775592160273;
        Tue, 07 Apr 2026 13:02:40 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:40 -0700 (PDT)
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
Subject: [RFC PATCH 13/20] selftests/bpf: Enable Landlock in selftests kernel.
Date: Tue,  7 Apr 2026 16:01:35 -0400
Message-ID: <20260407200157.3874806-14-utilityemal77@gmail.com>
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

Enable the BPF selftests to build the kernel with Landlock built into
the kernel and enabled at boottime. Existing LSMs
(SELinux,BPF,integrity) were moved from x86_64 specific config to be
built into all architectures.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/bpf/config        | 5 +++++
 tools/testing/selftests/bpf/config.x86_64 | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 24855381290d..8eca3773e968 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -115,6 +115,11 @@ CONFIG_RC_CORE=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_LIVEPATCH=m
 CONFIG_SECURITY=y
+CONFIG_SECURITY_LANDLOCK=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SECURITY_PATH=y
+CONFIG_LSM="selinux,bpf,integrity,landlock"
 CONFIG_SECURITYFS=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 42ad817b00ae..8a6d2af3805c 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -126,7 +126,6 @@ CONFIG_LEGACY_VSYSCALL_NONE=y
 CONFIG_LOG_BUF_SHIFT=21
 CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
 CONFIG_LOGO=y
-CONFIG_LSM="selinux,bpf,integrity"
 CONFIG_MAC_PARTITION=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_MCORE2=y
-- 
2.53.0

