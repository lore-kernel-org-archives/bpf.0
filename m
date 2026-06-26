Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8B3F65FB;
	Fri, 26 Jun 2026 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478276; cv=none; b=t6HCXojC5TX6rHTFmjc6p629u6wh6FZVNr/ylH9XBmJ6wuuEn7SegWCjIY0EFlIC0w77JWbVhyTCdIg4DbioGxNhwZZ6WMutsiwj+PSJjXxV8HmRDaRGa/zHw5yKstIEKj7Gp/5ZlYmfmgCDGhYIFfhakyRGbR56RAkZ3IDBos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478276; c=relaxed/simple;
	bh=J+Z2iPpCWwRBbXmYsgdLumGKLhOmSsQQOppEgx4Xeto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQYII8K/Psz65WQHWuUfVUzF3z38yb1gPqj28LlvWeR5IASmd0WIjr/Wlb7JuvZDypfPcwj1v4Npe0iBhoQpLCzJOhX8KkfsLXorEeVN6mtpX2StLB/pgI7Rf9lootLHB/LnC8eFNhUjAtoBf3KdID10BLIRAEy0I3ivned41n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WnZjT+mB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WnZjT+mB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ogu3PFSSJjLtN6B+vWR3mcOxnodDf7G8nYZBsvTRwwI=; b=WnZjT+mBs1RWMXhRuwxGseZI2i
	tV0tWAf+JcPqU2MNh7qxoFUqaQCWDu2ZVZn68HIohmPD1mHKO15JXxYYu8BV+dltYu5pp4jKQ/93t
	dsM5sbJH6cHC2u61cOdoFtfwcsZ7ZZHerIXfrtfuIH0kltXVtjfGdGEhbG84R4hwbL6oU+k8mEAY4
	FLWn2Bkd7l7+hpS0yNHJN9nYOgn1OcA9YmzJfpkcx0saRMxlySjYK6rV0I+1Yt7xKAeSmtoNmM7jd
	sui0XZg+LY2mRMGMOfdhAaX3PH9trVknV6X7E4EFPPZW7vFd0Uo8FFTi1T+pn4TG3q8tdXO5PzUSA
	bRFwvm9A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd61Y-003ymw-2t;
	Fri, 26 Jun 2026 12:51:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 05:50:17 -0700
Subject: [PATCH v7 8/9] bootconfig: skip runtime kernel.* render once
 prepended early
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-bootconfig_using_tools-v7-8-24ab72139c29@debian.org>
References: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
In-Reply-To: <20260626-bootconfig_using_tools-v7-0-24ab72139c29@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, 
 Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 linux-doc@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3070; i=leitao@debian.org;
 h=from:subject:message-id; bh=J+Z2iPpCWwRBbXmYsgdLumGKLhOmSsQQOppEgx4Xeto=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPnWLScolxpjW9NybQyHcdpFLqVGiKDQBuvs5z
 ylrkBea5LCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj51iwAKCRA1o5Of/Hh3
 bdFjD/9r1DziWBhJmJnTcZhOi01n/C5rqlYg9xEd1t+i/qz0XsgE4cU6wXCx7rI11ywYP4yb6hZ
 c1v4ZD+1pDYJ4BShcymF/U1WD7WYX5W6WDBtyLj0BijS/82w0/5uSutg3GUs9VPkvwGh1aq4sxD
 akABMw9+lWxxJK+uxX9/72o7UDO9cnxdG73/Sg/mhnGML/lSjEp4DI6oPmD6rh60kptlVtn/cMI
 eryamw4tlaZncmmjrvru9yC7puqq8lDZcxLMakcfRgeFE9p10DXmif0QouIPIoAO1YPmvdxcyMu
 tz6xxuG6YKyunrXhh2Syh4nTRk/JLrQ6y6HLzdSzWdV2A8mZw+VYHyMg8Aue/pl7fSEjnqm4mJ4
 nMV+VxY6gBHqAUk8Eb1g4+LmzeHnFI/qEh1pufLS4fW721DLb4YOpxXomAmrwGKTljvHUWYiipe
 jyUdTuoAAUeuGXhojWB8Id2nyDuQ6Ira+IoFrLYnL1rRHNOCvOWMohy9yflFgmnc/kEO4vrBZib
 3cYpKyXw0m8RsJO8+xp/u4zFfubDg/Tu7JLdaTgcrfJxFLZKMCsqAPKD0pY10eLYZM7ODSgYZA3
 2r7mu2FpQY2ECkuGyjNylf3vKOKQru937qVRTR/+0MktE3y8nayAIlkTso0nOPadI2ax0N4WIno
 sW/jYYVcEFu6f4Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

setup_boot_config() folds the embedded bootconfig "kernel" subtree into
the command line via xbc_make_cmdline("kernel"). A subsequent patch lets
an architecture prepend the build-time-rendered embedded "kernel" keys
to boot_command_line early in setup_arch(); rendering them again here
would then duplicate every key in saved_command_line and make
accumulating handlers (console=, earlycon=, ...) re-register the same
value.

Track whether the bootconfig data came from the embedded source
(from_embedded) and skip the runtime render only when the early prepend
actually happened, as reported by xbc_embedded_cmdline_applied(). On
architectures that do not select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG
that helper is a stub returning false, so this path is unchanged and the
embedded "kernel" keys still reach the cmdline via the runtime parser
exactly as before.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 init/main.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index e363232b428b4..260bd5242f94e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -378,12 +378,15 @@ static void __init setup_boot_config(void)
 	int pos, ret;
 	size_t size;
 	char *err;
+	bool from_embedded = false;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size);
 	/* If there is no bootconfig in initrd, try embedded one. */
-	if (!data)
+	if (!data) {
 		data = xbc_get_embedded_bootconfig(&size);
+		from_embedded = true;
+	}
 
 	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -421,8 +424,24 @@ static void __init setup_boot_config(void)
 	} else {
 		xbc_get_info(&ret, NULL);
 		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
-		/* keys starting with "kernel." are passed via cmdline */
-		extra_command_line = xbc_make_cmdline("kernel");
+		/*
+		 * keys starting with "kernel." are passed via cmdline. When
+		 * this bootconfig came from the embedded source and
+		 * setup_arch() already prepended the rendered "kernel" subtree
+		 * to boot_command_line, rendering again here would duplicate
+		 * the keys in saved_command_line and make accumulating handlers
+		 * (console=, earlycon=, ...) re-register the same value. Skip
+		 * only when the prepend really happened.
+		 *
+		 * On arches that do not select ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG,
+		 * CONFIG_CMDLINE_FROM_BOOTCONFIG is unselectable and
+		 * xbc_embedded_cmdline_applied() collapses to a stub returning
+		 * false, so this path still runs and the embedded "kernel"
+		 * keys reach the cmdline via the runtime parser exactly as
+		 * before this series.
+		 */
+		if (!from_embedded || !xbc_embedded_cmdline_applied())
+			extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
 		extra_init_args = xbc_make_cmdline("init");
 	}

-- 
2.53.0-Meta

