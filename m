Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAE232395;
	Wed,  4 Feb 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211609; cv=none; b=Jj4RNeYe5b+2ShWsXeJMitzxa/EQ41jWLWT8jr//xPwPtoKZHhhj1jplxvvu+91bxnTrM3196S00JOleGYfa8yi3cn8rn7t/jBNRrywSOmijnzDQ94j9NxXHGMfCuvWwojvORCiNtUSAf0ukymqYVMZbMagwqY2MM/m6UyAJYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211609; c=relaxed/simple;
	bh=U/llW4oZD1dqeKtQHuKdyCEJeTKfe14SLqOiC8Fseik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hN1/oXClU/XZ5LSNkLGbAgnTPo2J0FpcWmQQ/0cqbgHMsw+OAsSpzn1An1KidDG+nRDGE3osIiuFIDGtXoeNyKUeMZovV5hP9vMgzQfZapCy+zP/LUjTauid8zeka5jhbsHaGCTHFW1oKiBfih3MFyzyB/jkeDkqXopzQ6fdSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGVeDora; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGVeDora"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34729C4CEF7;
	Wed,  4 Feb 2026 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770211608;
	bh=U/llW4oZD1dqeKtQHuKdyCEJeTKfe14SLqOiC8Fseik=;
	h=From:To:Cc:Subject:Date:From;
	b=KGVeDoraVD0sVyWBGV0aaMKiFYONM1BjthWXLqs/58XYaoA96/8GpLqnJ5hpL5Lbe
	 hiYpMCGEy9z9Z4Bsz3rGiIDSE+lzNM5xbxrQBuXDi6giEmT/mhyGTVIc6F5VietLf4
	 zFuenXTf+lreEazHmQE3WL9kGHzPyM05OHECUxUGL3AO2opEf/X1YSQodjCYzXCed1
	 +/XmNbfyRE3rA/gdJQlLiLqnLSjL6yzZ4wamciRPow+IASmqKxqkRc95aLvIQPnDdH
	 DNh1NFDEwv8DIuKUIF/hRzqHGp/vTHQJ6+TM61ouI09VuYdsFcnjG4kHlPi2H+aGxN
	 jA8GJ/lQp9izg==
From: Arnd Bergmann <arnd@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] vsnprintf: drop __printf() attributes on binary printing functions
Date: Wed,  4 Feb 2026 14:26:23 +0100
Message-Id: <20260204132643.1302967-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The printf() format attributes are applied inconsistently for the binary
printf helpers, which causes warnings for the bpf_trace code using
them from functions that pass down format strings:

    kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
    kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
      377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
          |         ^~~

This can be addressed either by annotating all five callers in bpf code,
or by removing the annotations on the callees that were added by Andy
Shevchenko last year.

As Alexei Starovoitov points out, there are no callers in C code that
would benefit from the __printf attributes, the only users are in BPF
code or in the do_trace_printk() helper that already checks the arguments.

Drop all three of these annotations, reverting the earlierl commits that
added these, in order to get a clean build with -Wsuggest-attribute=format.

Fixes: 6b2c1e30ad68 ("seq_file: Mark binary printing functions with __printf() attribute")
Fixes: 7bf819aa992f ("vsnprintf: Mark binary printing functions with __printf() attribute")
Link: https://lore.kernel.org/all/CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
For reference, three additional patches are required before we can drop
the Makefile.warn line that currently hides these warnings:

https://lore.kernel.org/lkml/20260203162546.2254900-1-arnd@kernel.org/
https://lore.kernel.org/lkml/20260203163440.2674340-1-arnd@kernel.org/
https://lore.kernel.org/lkml/20260203164545.3174910-1-arnd@kernel.org/

Tested using randconfig builds on arm/arm64/x86
---
 include/linux/seq_file.h | 1 -
 include/linux/string.h   | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index d6ebf0596510..2fb266ea69fa 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -181,7 +181,6 @@ int seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_release_private(struct inode *, struct file *);
 
 #ifdef CONFIG_BINARY_PRINTF
-__printf(2, 0)
 void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary);
 #endif
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 1b564c36d721..b850bd91b3d8 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -336,8 +336,8 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(_a), _s)
 
 #ifdef CONFIG_BINARY_PRINTF
-__printf(3, 0) int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
-__printf(3, 0) int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
+int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
+int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
 #endif
 
 extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
-- 
2.39.5

