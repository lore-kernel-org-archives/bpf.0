Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B922170A10;
	Mon, 12 Aug 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459201; cv=none; b=s5V6aae5FvoiEu7QU5ZuibiOdgm043yG9V32eU8MR7etP1E8+yxWFGYVjPo839Y81bbGq+RPLF4L4Xm9VzPiGygLKVbUOP5cDYwo+U3Uvj5TuTxFZSJe1a3c3c6zplpLqjiz7B7LKK9qQAtOZoxusKMcuA+IiMzUFMyBJgAiODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459201; c=relaxed/simple;
	bh=xCsYDVX1SIMmI3WsGtCGKeTYuTPXPlKecf6vZhRK6yU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEpNtgYpXRBsRHvFe2GcJzBG0TRe31yX7uUOXg6vvM96ajpzUVSousW3aNUFjLzEj5Glh+0VycofddwOkb9G96fmjkQJfPAcPFZbi57MJ8vbNkVep9Q/iOzhsD88pVHdCSY6aUYs5HVzSwpY9qUfUzJbrBtcQ9OVkGg9Puh1QMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Andrew Pinski <quic_apinski@quicinc.com>,
	=?UTF-8?q?Kacper=20S=C5=82omi=C5=84ski?= <kacper.slominski72@gmail.com>,
	=?UTF-8?q?Arsen=20Arsenovi=C4=87?= <arsen@gentoo.org>,
	Sam James <sam@gentoo.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] libbpf: workaround -Wmaybe-uninitialized false positive
Date: Mon, 12 Aug 2024 11:37:59 +0100
Message-ID: <12cec1262be71de5f1d9eae121b637041a5ae247.1723459079.git.sam@gentoo.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In `elf_close`, we get this with GCC 15 -O3 (at least):
```
In function ‘elf_close’,
    inlined from ‘elf_close’ at elf.c:53:6,
    inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
elf.c:57:9: warning: ‘elf_fd.elf’ may be used uninitialized [-Wmaybe-uninitialized]
   57 |         elf_end(elf_fd->elf);
      |         ^~~~~~~~~~~~~~~~~~~~
elf.c: In function ‘elf_find_func_offset_from_file’:
elf.c:377:23: note: ‘elf_fd.elf’ was declared here
  377 |         struct elf_fd elf_fd;
      |                       ^~~~~~
In function ‘elf_close’,
    inlined from ‘elf_close’ at elf.c:53:6,
    inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
elf.c:58:9: warning: ‘elf_fd.fd’ may be used uninitialized [-Wmaybe-uninitialized]
   58 |         close(elf_fd->fd);
      |         ^~~~~~~~~~~~~~~~~
elf.c: In function ‘elf_find_func_offset_from_file’:
elf.c:377:23: note: ‘elf_fd.fd’ was declared here
  377 |         struct elf_fd elf_fd;
      |                       ^~~~~~
```

In reality, our use is fine, it's just that GCC doesn't model errno
here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly
by initializing elf_fd.elf to -1.

I've done this in two other functions as well given it could easily
occur there too (same access/use pattern).

Link: https://gcc.gnu.org/PR114952
Signed-off-by: Sam James <sam@gentoo.org>
---
v3: Initialize to -1 instead of using a pragma.

Range-diff against v2:
1:  8f5c3b173e4cb < -:  ------------- libbpf: workaround -Wmaybe-uninitialized false positive
-:  ------------- > 1:  12cec1262be71 libbpf: workaround -Wmaybe-uninitialized false positive

 tools/lib/bpf/elf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index c92e02394159e..00ea3f867bbc8 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -374,7 +374,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
  */
 long elf_find_func_offset_from_file(const char *binary_path, const char *name)
 {
-	struct elf_fd elf_fd;
+	struct elf_fd elf_fd = { .fd = -1 };
 	long ret = -ENOENT;
 
 	ret = elf_open(binary_path, &elf_fd);
@@ -412,7 +412,7 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 	int err = 0, i, cnt_done = 0;
 	unsigned long *offsets;
 	struct symbol *symbols;
-	struct elf_fd elf_fd;
+	struct elf_fd elf_fd = { .fd = -1 };
 
 	err = elf_open(binary_path, &elf_fd);
 	if (err)
@@ -507,7 +507,7 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
 	int sh_types[2] = { SHT_SYMTAB, SHT_DYNSYM };
 	unsigned long *offsets = NULL;
 	size_t cap = 0, cnt = 0;
-	struct elf_fd elf_fd;
+	struct elf_fd elf_fd = { .fd = -1 };
 	int err = 0, i;
 
 	err = elf_open(binary_path, &elf_fd);
-- 
2.45.2

