Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D630B51A;
	Tue, 23 Jun 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231430; cv=none; b=U20L1VOj+9xj9ReRmX6waUYsup8Osj5/R01zf2Wa6ZagsMbixVc/rXGUjh+eNttpjQNBHPNlxVqnZWE1sVA6uugdd7kk8AxI77IUQHC5f1tyvR7/SsCx5Lzg1QnpH4G2HzlzBrhMrj8H06BBvw5haWirrfcSWVE5vnvwiZJ/udg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231430; c=relaxed/simple;
	bh=5B6C1cdUJ0CwI26cw3hCjX2B1ty28df98tyQqf4NeGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qa8QhqqRg4CAoDZDeBGqeQf/aYbYSC0Qj8fPkcZH2kyOmWLLPV0Y9kgR5l3YD5rbQSEvQ43Su9Yor+PXWZS/wGDHeMkErsa9zbGb+xB1o5rrl3qM7DA7iXt7U0M+leSp2isnU+xvxcFJg5vLSHmo3bQM65+hHCdl2sY+DmVcR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=h1SxqjC3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="h1SxqjC3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=iRlfFKrjNZICVYGWlV6AC+Jcgdafs9XxAUdVcms4smQ=; b=h1SxqjC3DfWZgR7mMCGnziUnP1
	XZJxUUHhxWwosyt3DyYTBDTdURG3J8ekagfq4+5m+S95iyp3b/yI6zVCMdCPPp9cLxtJNG1JDLyy7
	eeh/6oXAujrWdbnvcY9VIomL9DfgrK4n/5pzp0dA8OmYET3rPKsXPY7ntZWKoNgmgW8ZwLzzrkjwp
	5tuRuL76uFPyfJvLJ5MUbYmklBfCs2jT66fUsWV3nJj8yehMYADVROMKyNoXMaCydoY8tlGluJ89g
	X4DFnJgMgtvVAfBHHMQBzy0+n1Yu9ozI6rLcy3tg0HDPlaUGbwdgOqXD40T2taMlf/hh6G2Rlo5Ej
	gAisaaUA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc3o3-001m39-0c;
	Tue, 23 Jun 2026 16:16:59 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 23 Jun 2026 09:15:32 -0700
Subject: [PATCH v6 5/8] bootconfig: add xbc_prepend_embedded_cmdline()
 helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-bootconfig_using_tools-v6-5-640c2f587a3c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5583; i=leitao@debian.org;
 h=from:subject:message-id; bh=5B6C1cdUJ0CwI26cw3hCjX2B1ty28df98tyQqf4NeGg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqOrFXKzG3drTOqleP/j8pogtWF7yMZt8uBMu03
 FlqRBuSe5WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajqxVwAKCRA1o5Of/Hh3
 bePlD/4syzpiKDiJCDpLrVT4qWaCmyb0QAx/vE6ZJpjvUW18i2FA4j7eECPB2Gqm7+6tipgCCh6
 pn1YVmeNDaXINAqxLEChGXTDMqpQ0WColXzH1tnUEcXEgyhYis0BuR87dchlVXgK/CsIjaWkuDG
 p8vnkaCQXsJywhFPdA4cWFRxylY/0Xv/m3NcJX8kVVRSOst3ax61YZYATHw0MxMu0JfA7Xvlx6M
 jdX4bsvSZJrrEttm9iaCyPsfH7sXcmeLMva2u+khMpx4ey2NERVfst7WK6hT8QlAoXzxa5g6CxT
 wg+r7PWTl45EIFZLmk5P7LBGfJw8Fh7aK6edZFXjIFWHZqStqlUWokq6/IIAUq409TZ0NzDBY1E
 B4/tBowKp4vBvDlscTRBFMacjGUGeGXkjqU92tJgNyUGLd9dQ7sWMLM+rUdkUSLfBaEZADXAbos
 zOl8PqJhvDotjXDq0Pag6+CalFYF4fc5wFc8z1IhU+L3aFSxyALsrgT6oVEouP3GQQoL73KGt7g
 gSk+eJCFjloibWgcKN571AgUaHyDJR/Fr+9r4rxBfd6grTxwcH8wpzZniZy7Q39A/W6zzHUB0rc
 a8XMpLCJS/R9Kb7/v9AT8FRbMNQZt0k5fHqfq9+5ZquIZLbjy5BnEwif00jqzsgOQ+i4lyNs1Ig
 N8DjzIZ4ySy6Rwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add a helper that prepends the build-time-rendered embedded bootconfig
"kernel" subtree (embedded_kernel_cmdline[] from embedded-cmdline.S) to
a cmdline buffer with a separating space. Architectures call this from
setup_arch() before parse_early_param() so early_param() handlers
(mem=, earlycon=, loglevel=, ...) see values supplied via the embedded
bootconfig.

The in-place prepend (shift the existing string right, then drop the
embedded string in front) is factored into a small str_prepend() helper.

On overflow the helper logs an error and leaves the cmdline untouched
rather than panicking. Booting without the embedded values is better
than refusing to boot, and the error tells the user why their embedded
keys are missing.

The helper records whether it actually prepended, exposed via
xbc_embedded_cmdline_applied(). setup_boot_config() uses this to decide
whether the runtime "kernel" render would duplicate keys already folded
into boot_command_line.

When CONFIG_CMDLINE_FROM_BOOTCONFIG=n, the public declaration in
<linux/bootconfig.h> resolves to a no-op stub so callers compile
unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/bootconfig.h |  9 ++++++
 lib/bootconfig.c           | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 1c7f3b74ffcf3..43324b477f13a 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -308,4 +308,13 @@ static inline const char *xbc_get_embedded_bootconfig(size_t *size)
 }
 #endif
 
+/* Build-time-rendered bootconfig cmdline prepended in setup_arch() */
+#ifdef CONFIG_CMDLINE_FROM_BOOTCONFIG
+void __init xbc_prepend_embedded_cmdline(char *dst, size_t size);
+bool __init xbc_embedded_cmdline_applied(void);
+#else
+static inline void xbc_prepend_embedded_cmdline(char *dst, size_t size) { }
+static inline bool xbc_embedded_cmdline_applied(void) { return false; }
+#endif
+
 #endif
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 926094d97397e..05cb1ea9afdae 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
+#include <linux/printk.h>
 #include <linux/sprintf.h>
 #include <linux/memblock.h>
 #include <linux/string.h>
@@ -34,6 +35,83 @@ const char * __init xbc_get_embedded_bootconfig(size_t *size)
 	return (*size) ? embedded_bootconfig_data : NULL;
 }
 #endif
+
+#ifdef CONFIG_CMDLINE_FROM_BOOTCONFIG
+/* embedded_kernel_cmdline is defined in embedded-cmdline.S */
+extern __visible const char embedded_kernel_cmdline[];
+extern __visible const char embedded_kernel_cmdline_end[];
+
+/* Set once the embedded cmdline has actually been prepended. */
+static bool xbc_cmdline_applied __initdata;
+
+/*
+ * str_prepend() - Prepend @src in front of the string in @dst, in place
+ * @dst: NUL-terminated destination buffer, currently @dst_len bytes long
+ * @dst_len: length of the current @dst string (excluding its NUL)
+ * @src: bytes to prepend (not NUL-terminated)
+ * @src_len: number of bytes from @src to prepend
+ *
+ * The caller must guarantee @dst has room for src_len + dst_len + 1 bytes.
+ * Moving dst_len + 1 bytes carries @dst's NUL terminator too, so an empty
+ * @dst needs no special case.
+ */
+static void __init str_prepend(char *dst, size_t dst_len,
+			       const char *src, size_t src_len)
+{
+	memmove(dst + src_len, dst, dst_len + 1);
+	memcpy(dst, src, src_len);
+}
+
+/**
+ * xbc_prepend_embedded_cmdline() - Prepend embedded bootconfig cmdline
+ * @dst: cmdline buffer to prepend into (must already contain a NUL byte)
+ * @size: total capacity of @dst in bytes
+ *
+ * Prepend the build-time-rendered "kernel" subtree of the embedded
+ * bootconfig to @dst. The rendered string already ends with a single
+ * space (the xbc_snprint_cmdline() invariant), which serves as the
+ * separator between the embedded keys and any existing content of @dst.
+ * On overflow, log an error and leave @dst untouched rather than
+ * silently truncating: booting without the embedded values is better
+ * than refusing to boot, and the error message tells the user why
+ * their embedded keys are missing.
+ *
+ * Intended to be called from setup_arch() before parse_early_param() so
+ * that early_param() handlers see the embedded values.
+ */
+void __init xbc_prepend_embedded_cmdline(char *dst, size_t size)
+{
+	size_t embed_len = embedded_kernel_cmdline_end - embedded_kernel_cmdline;
+	size_t dst_len;
+
+	if (!size || embed_len <= 1)	/* trailing NUL only */
+		return;
+	embed_len--;			/* exclude trailing NUL byte */
+
+	dst_len = strnlen(dst, size);
+	if (embed_len + dst_len + 1 > size) {
+		pr_err("embedded bootconfig cmdline (%zu bytes) does not fit in COMMAND_LINE_SIZE with %zu bytes already used; ignoring embedded values\n",
+		       embed_len, dst_len);
+		return;
+	}
+
+	str_prepend(dst, dst_len, embedded_kernel_cmdline, embed_len);
+	xbc_cmdline_applied = true;
+}
+
+/**
+ * xbc_embedded_cmdline_applied() - Did the embedded cmdline get prepended?
+ *
+ * Return true if xbc_prepend_embedded_cmdline() actually prepended the
+ * embedded "kernel" subtree. setup_boot_config() uses this to avoid
+ * rendering the same keys a second time.
+ */
+bool __init xbc_embedded_cmdline_applied(void)
+{
+	return xbc_cmdline_applied;
+}
+#endif
+
 #endif
 
 /*

-- 
2.53.0-Meta

