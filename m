Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3E3FBB5A;
	Wed, 26 Aug 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759766; cv=none; b=dXTQyv3op2POlJdgdB6fi75S6vuROgNjQthiUUlrh8G1gbjHcF+JV4G3BApSPIIIzIcoFol66GjlB4eUj/puMkdy0cyF2jD+p/oMfh4XMdK92FisMFX/MWBDi5zseAmUkRXAqdwkCyGEB/e50us6vub/0WjJBWOHM5MHW9Jr1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759766; c=relaxed/simple;
	bh=653qz3nDY95B3k6oyXltdsVnQQkTWcEE8ubSGxx0fbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMiiwcTRy3rElDULXI/0Wl2yv0pc9xb5S+swCZFfkwIr/H/OJRa6erHptm9h+V+PyF0D5SHENNfpBL20LC+8WNNm5m0CHw2FC9132cPOyvHwtJhRO1tmNNMCnNVRx+iAzvNEcoEmsJf0NbGu3esjvVKwaLQ+fYTIO0bL2Pm1vUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpNbeG7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpNbeG7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620831F000E9;
	Wed, 26 Aug 2026 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787759764;
	bh=7AJOXS7+FmhIjs+QHaVJiOWkg62Yl8bLA9jCz7ES/Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NpNbeG7QIzDMh6RL6aLU7mL5L8eblE+RXsu59K3or1cIT0ZfKd6YOIDldAxxy6PsE
	 EKZ0/lzI5WH+IZz6S0byhCGimtJ3IlkiBMDu5AMkI9YcIhc4AIK/OYehGL2njx790N
	 FOk1APnd++One2KJ3LZs1dJGUDj1U7eF/a0MeAz/hHa0uqe3oGVF367wiTZpDwupia
	 479kDzuC33TyZz+o9T+67z/py39Ob7GIS7CaTVuWlGk8SO/Ixn8WObgJ6MCU7m0JXY
	 0L5Rbs52IrXmUWlxZSX0rhNoDsqpg2eGreTy7U9pOfS2ddDFHkZD4YC1sQ0s+3hdmP
	 XRPJqbdPBUD/w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 26 Aug 2026 17:55:47 +0200
Subject: [PATCH 2/3] selftests/exec: test delimiter restrictions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-work-binfmt_misc-delim-v1-2-43618adf8599@kernel.org>
References: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
In-Reply-To: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4526; i=brauner@kernel.org;
 h=from:subject:message-id; bh=653qz3nDY95B3k6oyXltdsVnQQkTWcEE8ubSGxx0fbo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT183RnqfOu+t3y0NQ09cTdpOdv9ixyur1gv9XrmKMHt
 775dbrtT0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEousY/ju+ZDrk1WCvmp42
 6xXbpikMBZ9yPEI+PnQ9t2KRxaZYx8eMDBvqXbqXrGSVy55oudc2vvvm4xtJl5peJ638f+Hr/wu
 PJBkB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that the new delimiter restrictions work.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/Makefile            |   4 +
 tools/testing/selftests/exec/binfmt_misc_delim.c | 127 +++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index b640af8f02b5..2220ed345e92 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -45,6 +45,10 @@ TEST_GEN_FILES += binfmt_transparent_interp
 TEST_GEN_PROGS += binfmt_misc_loader
 TEST_GEN_FILES += binfmt_loader_payload binfmt_loader_payload_static
 
+# Only ASCII punctuation delimits the fields of a register string, so a new
+# flag character cannot change which strings register. No bpf toolchain.
+TEST_GEN_PROGS += binfmt_misc_delim
+
 # binfmt_misc bpf-backed ('B') handler test: a libbpf harness plus its
 # struct_ops objects and the test interpreter/app it routes between. Only
 # built when clang, bpftool, the vmlinux BTF and libbpf are all present
diff --git a/tools/testing/selftests/exec/binfmt_misc_delim.c b/tools/testing/selftests/exec/binfmt_misc_delim.c
new file mode 100644
index 000000000000..ffc17cb78545
--- /dev/null
+++ b/tools/testing/selftests/exec/binfmt_misc_delim.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test which characters may delimit the fields of a register string.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "binfmt_misc_common.h"
+#include "kselftest_harness.h"
+
+#define ENTRY	"bmdelim"
+/* Shares no character with the sets below, or a refusal proves nothing. */
+#define MAGIC	"bmmagic"
+#define INTERP	"/bin/true"
+
+/*
+ * ASCII punctuation without '\' and '/'. The backslash is refused because
+ * it would cut a magic that uses \x to escape short. '/' is accepted
+ * but cannot delimit a rule that names an absolute interpreter.
+ */
+#define PUNCTUATION	"!\"#$%&'()*+,-.:;<=>?@[]^_`{|}~"
+
+/* 'M', 'E' and 'B' name types, 'P' through 'D' are the flags. */
+#define LETTERS		"MEBPOCFTLDqz"
+#define DIGITS		"0157"
+#define WHITESPACE	" \t\n"
+#define CONTROL		"\001\033\177"
+#define NON_ASCII	"\200\244\377"
+
+/* ':bmdelim:E::bmmagic::/bin/true:' with @del in place of every ':'. */
+static int register_with(char del)
+{
+	char rule[128];
+
+	snprintf(rule, sizeof(rule), "%c%s%cE%c%c%s%c%c%s%c", del, ENTRY, del,
+		 del, del, MAGIC, del, del, INTERP, del);
+	return write_reg(rule);
+}
+
+/* No character of @set may delimit a register string. */
+static void expect_refused(struct __test_metadata *_metadata, const char *set)
+{
+	const char *d;
+
+	for (d = set; *d; d++) {
+		int rc = register_with(*d);
+
+		EXPECT_EQ(rc, -1)
+			TH_LOG("%#x delimited a register string",
+			       (unsigned char)*d);
+		if (rc == 0) {
+			unregister(ENTRY);
+			continue;
+		}
+		EXPECT_EQ(errno, EINVAL);
+	}
+}
+
+FIXTURE(delim) {
+};
+
+FIXTURE_SETUP(delim)
+{
+	if (getuid() != 0)
+		SKIP(return, "test must be run as root");
+	if (!binfmt_misc_available())
+		SKIP(return, "no binfmt_misc");
+
+	/* A kernel without the allow-list takes any character but a flag. */
+	if (register_with('q') == 0) {
+		unregister(ENTRY);
+		SKIP(return, "kernel without the delimiter allow-list");
+	}
+}
+
+FIXTURE_TEARDOWN(delim)
+{
+	unregister(ENTRY);
+}
+
+/* Punctuation delimits, which is all anything deployed ever uses. */
+TEST_F(delim, punctuation_accepted)
+{
+	const char *d;
+
+	for (d = PUNCTUATION; *d; d++) {
+		EXPECT_EQ(register_with(*d), 0)
+			TH_LOG("'%c' refused with errno %d", *d, errno);
+		unregister(ENTRY);
+	}
+}
+
+/* Letters name the types and the flags, so none of them can delimit. */
+TEST_F(delim, letters_refused)
+{
+	expect_refused(_metadata, LETTERS);
+}
+
+/* The offset field is written in digits. */
+TEST_F(delim, digits_refused)
+{
+	expect_refused(_metadata, DIGITS);
+}
+
+TEST_F(delim, whitespace_refused)
+{
+	expect_refused(_metadata, WHITESPACE);
+}
+
+TEST_F(delim, control_refused)
+{
+	expect_refused(_metadata, CONTROL);
+}
+
+TEST_F(delim, non_ascii_refused)
+{
+	expect_refused(_metadata, NON_ASCII);
+}
+
+/* The escape character would cut every magic that uses one short. */
+TEST_F(delim, backslash_refused)
+{
+	expect_refused(_metadata, "\\");
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

