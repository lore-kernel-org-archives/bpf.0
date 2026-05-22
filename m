Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72E1C68F
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779409762; cv=none; b=RRQOBrwh+ul/DEeOF0ORWlNal4CT88DgiAo9wlJLUb7wi9JfrgN1ua8+pv6sdELH+iVejVVSsYWu3JBjg1o67KmaRKctTYfeKy4ySVlwKD7JN8KGYYUU9h68FlG51J7+E10XQbQYjNqzrxCWuVnoAXJyWA2OL2LiECI0mpFa40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779409762; c=relaxed/simple;
	bh=Tx0UAbVekQgC9DOLY1Z8Suf9iCRSMNdRLRWOZdiip7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzS5DExABqD6mZS+lSgASgV55oHnFd8h7iyVLljmX6g895pI7LWUY4s81ZEKEHxyhYCCSScEzqZGRywscV4+liYD7GI9m0dQLxMDms+4KZWXKoQ+ZjxaK5MaPdtP0P5J1PfQ76YA61bBP7TqWtxk6mYsS9f/p8OE3MhI/50tWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvobtDCs; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvobtDCs"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90d042fa745so1155558985a.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779409760; x=1780014560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLnQcby3KpUwl59Q1s2HgeviW26p8AzRTMN1fYgyczM=;
        b=nvobtDCsWGSOR7yd8hY6y/cqnK2gLqbUm7nKmRlvzkmxMUtXjv0FgsHhTQl+E6ao+9
         ykaIKRxDv5AztIwacN+evu9oabSkFKU0AVh8tF7PfB3RPi0JGblEWQEkdIPLwjjq1fWR
         SV2e9yH+RWLQ0Ic1C4ebLNaLykdQVD0QTlHG51F1bhzNAhEVJ+j7V1/9dseGyfDBzMIx
         HrBuRAcU8Q0YIvvA9UmUTYGhf6dJs4o+2Ofd+ufbx9wySXVDbidB4aZquI02MYNBL53k
         7Lh0sqiUg1iWjL2GJEhHMB4uNDsdCPDis8S6mmlQaKFwLydTQQgjaEoPX1TtnJQdO/IW
         TqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779409760; x=1780014560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLnQcby3KpUwl59Q1s2HgeviW26p8AzRTMN1fYgyczM=;
        b=echVE9eUI9/wy2bcQKAmiAZWcymZmXq2KwK1QWJVdgbfKWOa9GCEKZ1MMNdDa6QV/2
         JXrMxq9+wg8B0dzZIb1PsKpe97soBc/qYOF7HWlIZfreCFOEWfOJn3SUOjzh/1Jy/Avm
         C1Um95kjDqeFtk+Mpf+aKAopzalPjPtweP/Q1ehDygwMub7RT+BLsG6FnNlVA5+2DxCA
         7EcytYsTVCImUKRaWR4IaNxhxLUD6pEoHTGCGG4J8xSC2Mv8pH8KpVFFPVZoHI6Wg9r3
         yHEZiR6j+1mqQx9NXvxmQSRRAIZdOpWbzPQ5KKjOMytSRU/zHaiPRfdCcLBwIGLbO5Vo
         RAAA==
X-Forwarded-Encrypted: i=1; AFNElJ/AhzqM1Y/CQRP8RSo/OGOpneKPcePP3YsOTZIgtXbWzc+chMiYNU88BfSgc33mIc7idnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSz5qwdVAZpJtjnZg8yz/AEY+7nleBd2xcwXttDav3llGICZhy
	fBU1rDHdGF4M4Aj7JJk3JU2nmfZU//aBDoWtlHbhg59yIv5YZXhUp6Ev
X-Gm-Gg: Acq92OEUV3R0QrsJShjUiEffxRAooPMBGpswJNIaBnuKAJYHJ8TFK+LCIF9LV6Ioi/9
	Odv1/4OuSbhmiEpaNhWz+RA5Qq+YxNpsOBnR6YGuGwb3hzJbs/uIoKW3iqd6h6PTiE/ikAWHsGJ
	z5YEqz3SdCXpndN9+1m9WB7XqOicJPs6gwOMHGS0043DeNvWkUFQnGwDxYz2W2DJCG8cdXsgVqS
	zIgoPlL9oot0SmNuxN0nAEWsiALD6OBctRe1R6rEg+9HT0E/CvtQ6KDhbGJa9evfSxH2cjmZVCd
	LeTL0YfTQnhAkkD4qVNYNLK6qKFSu9lcVMUf0bx7qErgQkRatBmgx3v9C2guFEoK3yDPrSFF5Sd
	4dvz+t8EvnKFNE6FlAX7C+0FGYnVGJnxL/zFeydDMKFqeK1kov3q26iTmTqs3xilH3CLFiDmw2g
	QQGaODwzrVYs2QMBDqj4vY0veGoFNZ0m/SYctfXzilUqpF0h21dRuA5oewQWF4dxhtz78lk/5r/
	lz1NXt1INZ0biDSUuVQQCkLI9n3gO+TFja24EJYhQ==
X-Received: by 2002:a05:620a:890c:b0:912:5d2a:4bc6 with SMTP id af79cd13be357-914b494e7f5mr241694685a.40.1779409760153;
        Thu, 21 May 2026 17:29:20 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914b5d6c78dsm49727785a.5.2026.05.21.17.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:29:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] libbpf: harden parse_vma_segs() path parsing
Date: Thu, 21 May 2026 20:29:01 -0400
Message-ID: <20260522002901.3493661-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

parse_vma_segs() in tools/lib/bpf/usdt.c parses /proc/<pid>/maps
with two widthless scansets, "%s" into mode[16] and "%[^\n]"
into line[PATH_MAX]. Both assume the kernel caps maps records to
PATH_MAX; it does not.

show_map_vma() emits the path via seq_path() against the seq buffer,
which doubles on overflow (m->size <<= 1 in fs/seq_file.c), so a VMA
whose backing path is a deeply nested directory tree produces a single
maps record longer than PATH_MAX. scanf "%s" / "%[^\n]" without a
width writes until the field terminator regardless of destination size,
so a bpf_program__attach_usdt() consumer attaching against an
attacker-controlled PID overflows its own stack inside parse_vma_segs().

Bound both scansets to the declared buffer sizes ("%15s" for mode[16]
and "%4095[^\n]" for line[PATH_MAX]) and drain any residue past
line[4094] with "%*[^\n]" before the trailing "\n", matching the
libbpf-local fscanf style. Without the drain the residue of an
over-long record would stay in the stream and break the next "%zx-%zx"
parse, so the loop would exit early and any maps records after the
over-long entry would be silently skipped.

Also stop using sscanf(..., "%s") to peel the /proc/<pid>/root prefix
from lib_path. Build the exact prefix for the requested PID with
snprintf(), check it directly, and copy the remainder with
libbpf_strlcpy(). That removes a second unbounded stack write and
preserves paths containing spaces.

Fixes: 3e6fe5ce4d486 ("libbpf: Fix internal USDT address translation logic for shared libraries")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Replace the unbounded /proc/<pid>/root sscanf() path peeling with
  snprintf() + prefix check + libbpf_strlcpy(), addressing review
  feedback on v1 and preserving paths containing spaces.
- Keep the v1 maps parser fix using bounded fscanf() scansets and a
  suppressed scanset drain for over-long records.
- Re-ran real parse_vma_segs() ASAN harnesses for the original maps
  overflow, the proc-root overflow, proc-root paths with spaces, and
  adjacent successful parses after an over-long maps record.

Reproduced with Debian 12 on rootless podman: an unprivileged
container process mkdirs 50 nested 200-char directories and mmaps
a file at the bottom, producing a 10403-byte /proc/<host-pid>/maps
line.  A harness on the host then calls the real parse_vma_segs()
against the container's PID; libbpf is built with
-fsanitize=address and the only local source change is dropping
the "static" keyword on parse_vma_segs so the symbol is linkable
from the harness.

Stock libbpf reports:

  ==ERROR: AddressSanitizer: stack-buffer-overflow
  WRITE of size 10349 at <line> thread T0
    #0 scanf_common -> #1 __isoc99_fscanf
    #3 parse_vma_segs tools/lib/bpf/usdt.c:509
  Address ... in frame parse_vma_segs at offset 8512, just past
  line[PATH_MAX].

Patched libbpf parses the same maps cleanly.  Follow-up calls
return 0 with seg_cnt > 0 for libc.so.6 and for
ld-linux-x86-64.so.2 (format drain), which appears in maps
after the over-long entry.

On normal hardened builds the stack canary aborts the consumer;
on builds without stack protector the bytes past line[] are
attacker-influenced path bytes.  

Selftest gate
=============

tools/testing/selftests/bpf/test_progs -t usdt under QEMU x86_64
(KVM) on the patched kernel: all 6 subtests pass (usdt/basic,
basic_optimized, optimized_attach, multispec, urand_auto_attach,
urand_pid_attach) on both stock and patched libbpf, diff-clean.
The in-tree selftest does not itself exercise long maps records.

 tools/lib/bpf/usdt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index e3710933fd52a..2ed792cf11438 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -471,7 +471,7 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
 	char path[PATH_MAX], line[PATH_MAX], mode[16];
 	size_t seg_start, seg_end, seg_off;
 	struct elf_seg *seg;
-	int tmp_pid, i, err;
+	int n, i, err;
 	FILE *f;
 
 	*seg_cnt = 0;
@@ -480,8 +480,13 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
 	 * /proc/<pid>/root/<path>. They will be reported as just /<path> in
 	 * /proc/<pid>/maps.
 	 */
-	if (sscanf(lib_path, "/proc/%d/root%s", &tmp_pid, path) == 2 && pid == tmp_pid)
+	n = snprintf(line, sizeof(line), "/proc/%d/root", pid);
+	if (n < 0 || n >= (int)sizeof(line))
+		return -ENAMETOOLONG;
+	if (str_has_pfx(lib_path, line) && lib_path[n] == '/') {
+		libbpf_strlcpy(path, lib_path + n, sizeof(path));
 		goto proceed;
+	}
 
 	if (!realpath(lib_path, path)) {
 		pr_warn("usdt: failed to get absolute path of '%s' (err %s), using path as is...\n",
@@ -504,8 +509,11 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
 	 * 7f5c6f5d1000-7f5c6f5d3000 rw-p 001c7000 08:04 21238613      /usr/lib64/libc-2.17.so
 	 * 7f5c6f5d3000-7f5c6f5d8000 rw-p 00000000 00:00 0
 	 * 7f5c6f5d8000-7f5c6f5d9000 r-xp 00000000 103:01 362990598    /data/users/andriin/linux/tools/bpf/usdt/libhello_usdt.so
+	 *
+	 * Bound the writes and drain residue: maps lines can exceed
+	 * PATH_MAX when seq_path() uses a larger seq buffer.
 	 */
-	while (fscanf(f, "%zx-%zx %s %zx %*s %*d%[^\n]\n",
+	while (fscanf(f, "%zx-%zx %15s %zx %*s %*d%4095[^\n]%*[^\n]\n",
 		      &seg_start, &seg_end, mode, &seg_off, line) == 5) {
 		void *tmp;
 
-- 
2.53.0
