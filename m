Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454D3F7AB2;
	Fri, 26 Jun 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478281; cv=none; b=Hi8R5c+0nPJUm0VYSN/Tfq8N0N0gaJtyZpC/pKsLTq3ShvKZsivTZbjLH9vNqwGbw1z28ZQ/c9yxyvngLEstjrKnpV/frWK9J6dMFeVJmEHxv2+rBTeoilVNZD6EPiiWPCko5WuDEwTn4VF8f009wqdHhoaQegFFiw/XmzYqd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478281; c=relaxed/simple;
	bh=zZvtWzASsvsaxSDUCIiLZHSYGxQb6JZ96ebCD1nVaGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEVHXC1IPiUWba1/uErqgDcgJCLFne1Ky60Ivpj9JcVnZjX7Rdg/BaZtMKKHAGhGWKHwy8BrkzlPfi8W5aS+6k6cFsgbWj3hZdGpuZUjn0nFyrv1gPhzsFtkENcZBKUzf4KgpOxlDKLYZEvBlu/+WfC9p5D2bDb/ATbgcRustLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uZL6yPPX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uZL6yPPX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=4PAMiAqFNsrj81yLRwXcRBbwJQdqPm0b+bsnVPQXhkY=; b=uZL6yPPXqx75uvg06eBvs6ca6t
	jYgVBD3QhfWiEMkQAX/hz8yNf2+76sE2zPOYfs+2D7eUdKsJPHeNi+6vOZA9Fh37t0xvsF9ltRuq8
	sGzfmeFQ89Ypn4vG7l63E247/RH7YrxmDcpNKse2s4QI6ic8wzqppbZRnz2bP/5zbhs+IMbBGwuWH
	b+w3biLRwUdjclsugvXJ7Uv3PzleVYcGNr5hhy9jVUcsDi87ayDrMYqi8P925B3CmJY9W7uADHs1P
	yRlQsMDH4e6h1DtuFGRp51jj+jldmvOuKgSB6ESL7KaLlUCYTTLGOy3lzF9hUoztqChgZ3mG/2pJ/
	VS9UEyrQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd61e-003ynO-0o;
	Fri, 26 Jun 2026 12:51:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 05:50:18 -0700
Subject: [PATCH v7 9/9] init/main.c: use bootconfig_cmdline_requested() for
 the runtime opt-in
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-bootconfig_using_tools-v7-9-24ab72139c29@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=leitao@debian.org;
 h=from:subject:message-id; bh=zZvtWzASsvsaxSDUCIiLZHSYGxQb6JZ96ebCD1nVaGc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPnWMs55JWa1siFj+4moulinAY7VIL8bQAWYol
 zg63AY4XMSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj51jAAKCRA1o5Of/Hh3
 bWuhEACfepNYrzcwf12YwiwXcjzhQ2lJ0ZGYRZepnOric6sy1vKIgGCiE0zVsG96TykngCCPo4r
 Qo7gnpqjaGsP/ssS7f3BkXeNiQPUYWOpi7+QySvexEbAtxadyh2TJfr7lKHF/sR2EqHbsUkHJHd
 286lD/fON6Lf/y9YwFtn+RX5S5K4D5CPX2LAfASpmylg8RZsV03/8Fc4/4AgiMVu4xdnlkU3TCR
 BBtugg5DJWipqy0nL9u1a1Pn3lW7EJfgmoZTP9mKt6tsCvTjX6N+kiZnkRFgYJCGpd+BhLvLXLA
 fR1WBZNwukkTdfWnVl9hrCty3idcWOZZ16mp/UIhFyuLpKtfRRq4kH5y3QKyv8qfn2DcR8/wduo
 GXS8mitUESgYJY6Xvjj5vwD+pUKeguSu2EcDPViuydOMyh6UIDlBsiFcq/oZZE+GYY0MiB2X8rO
 mLSdIxWspxeoU4OCLHO7yvlOwqrjaTJg2v0XFSRIt/Mbu5zD6QPmyR7Z9p7ZPCgKU2haFcWiPXE
 cPVKSxQAInz+NervxAssCXkb2LC8SZ3Z9CMO5J3rSFA5lWJUBdQEV4KxpvUdHgAuPoZB2L4nkQQ
 k07AztL8e21CFe2Bj6I5+u4YMn3GPeT/sngvTq5GWHq7NxTsEPz3nGdcyzQYV1yaBHgOwuzkcte
 xQmXIaZgF0eh/IQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

setup_boot_config() open-coded the same "is bootconfig requested on the
kernel command line?" check that setup_arch() performs via the shared
bootconfig_cmdline_requested() helper. Switch it to the helper so the
early (setup_arch) and late (setup_boot_config) paths use one parser and
cannot disagree on what counts as opt-in.

The helper also reports the offset of the init arguments following a "--"
separator, which is exactly what initargs_offs needs, so the local
parse_args() call, its bootconfig_params() callback and the tmp_cmdline
copy are removed.

No functional change intended.

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 init/main.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/init/main.c b/init/main.c
index 260bd5242f94e..39a518a472422 100644
--- a/init/main.c
+++ b/init/main.c
@@ -356,28 +356,17 @@ static char * __init xbc_make_cmdline(const char *key)
 	return new_cmdline;
 }
 
-static int __init bootconfig_params(char *param, char *val,
-				    const char *unused, void *arg)
-{
-	if (strcmp(param, "bootconfig") == 0) {
-		bootconfig_found = true;
-	}
-	return 0;
-}
-
 static int __init warn_bootconfig(char *str)
 {
-	/* The 'bootconfig' has been handled by bootconfig_params(). */
+	/* The 'bootconfig' option is handled by setup_boot_config(). */
 	return 0;
 }
 
 static void __init setup_boot_config(void)
 {
-	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	const char *msg, *data;
-	int pos, ret;
+	int pos, ret, offs;
 	size_t size;
-	char *err;
 	bool from_embedded = false;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
@@ -388,16 +377,12 @@ static void __init setup_boot_config(void)
 		from_embedded = true;
 	}
 
-	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
-			 bootconfig_params);
-
-	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
+	bootconfig_found = bootconfig_cmdline_requested(boot_command_line, &offs);
+	if (!(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
 		return;
 
-	/* parse_args() stops at the next param of '--' and returns an address */
-	if (err)
-		initargs_offs = err - tmp_cmdline;
+	/* Offset of the init arguments after a "--", located by the helper. */
+	initargs_offs = offs;
 
 	if (!data) {
 		/* If user intended to use bootconfig, show an error level message */

-- 
2.53.0-Meta

