Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2868306757;
	Tue, 23 Jun 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231438; cv=none; b=l6w3m/6Wcya502tkHsSjyGQxQ6bMOrTKmlyf981C1N3LFYcwovgnSlK7Qblk/V93iyoUu4tfoKaA7KXQTm1KWF/sLZq+CEWZVNk5h3MMItyKW2WkAknh+2m8VpaaqdHW94qC8EGSrDr3QtQmL0VSmtEHulwEsLowNgcBDP51BWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231438; c=relaxed/simple;
	bh=J+Z2iPpCWwRBbXmYsgdLumGKLhOmSsQQOppEgx4Xeto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aukNKjFcSGfiSHSk5melF6tI5Qo9EKng6R/w+egq+KjTteKBMfYimt2gNln9hoP+Ejj8osq4Gi1UYxCk75QFivA+lkelIZheWtvUGO8Csvc7DLKTzsJSelxg5SU57eJt7p65aQDWs266IICD49v3Fc1IgJ57+HRfBxgtzB8XXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bjhOaE3A; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bjhOaE3A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ogu3PFSSJjLtN6B+vWR3mcOxnodDf7G8nYZBsvTRwwI=; b=bjhOaE3AfBytgt0DmOytshi9uE
	k7+Q0KxLkOfaMDRBnvr1iif5txrDmux/CsgP1Et72TtNLR0nEjJi6D5JQbK10rHfokXX56FI9bRhL
	jfd3F4d3HVdLuJEml1ZWSp8jJvLG61jMJ8V0M2q90wf0iE8/XN7Y6SknapPl7UIL2HuUO0lr1rGl1
	LQQM3OtD2ArG671t3YNNG/rBcVjCFEKUYWx1kmeaMg8KOtgM6awICqJHSZ3YulSZB9w8F48Zi+i8G
	HnHaBehE4p1EDZ9ralyvSbJQh/pUgdQYVvWVbrWCsOgSKaVn3wHReQuuUOTj/8tL2FnBphXGuge1j
	V4yHbQwA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc3oE-001m3q-1o;
	Tue, 23 Jun 2026 16:17:10 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 23 Jun 2026 09:15:34 -0700
Subject: [PATCH v6 7/8] bootconfig: skip runtime kernel.* render once
 prepended early
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-bootconfig_using_tools-v6-7-640c2f587a3c@debian.org>
References: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
In-Reply-To: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqOrFXTPkaCSSmS30H3JRKiYc2DjfuuBBSse7Me
 BTr/HiChYKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajqxVwAKCRA1o5Of/Hh3
 bR/sEACHF6UAz3Cj1aOg+jsHZ2YlCCjTaM0W2buI1H38pJrLdGyhVl/XgBuwJscEy5v5NaKhB6w
 S/D0qgjmRuLSRHT9qdccUD+4q21q/OGS8C9AfOp+Ypswqj2VE8oiF9LucGuz5gCa20zGFL0hIMh
 ys/cluHhu63OcPQepCyy/m/umz2YTpDJSUPUwx4RjJWyRr5JM8aUJQ4MEzR8QNv3vpCPB1ewU6Z
 U757fVgiBu0vX+zyWsqNcZDlK+9F0SWVermblU6ktgqC9RfQ2mHaBR6FpcYsFObHX6iyFsS3cLP
 vIts4v2t3hkJ6cQBTcT844OfdVajoEz7dCoYqX5WV2pkpf79rpJh7HNpwWoT03OC2Kbpw0LG+k8
 jkwnJofkNIzEtk+1LvpeBMG5Qnu/wlQyeB0aaH2gxT7641ih4e3jK1+iG1K9jKgX4Dvee+V6sgi
 WGZiHWQ+leZZqVFxOf7Lyj8DUavS/QDE99m4mQ2TX/RfTzI/XFw1MZ3O2A8tfgIRfjCMNglyIyn
 vhJy6Q7OIJrrrnSQuu/0EYUShTY634b8+zW4QGSQ6BU/0cjsPiHd7nsoadO2Rl6y6Gb4FNCqLDR
 dFGqZDoSchCYrHStRh68+4fPFD2BF7tVvJEASQo9J2VOUcErxk2pSDzcC4ff6PIAARJQxQ7u/43
 n/1gk1jz2ok6ZSQ==
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

