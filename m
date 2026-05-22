Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7525B0B1
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454640; cv=none; b=E548dr7Bw1MhLwpEC+EIK0EHrOuPxohgaeUqjpnWp8dlRwieDDi6Tc+tKwsLSQTeHQxAxFIXnxX53qKfPWIlqpASkCfidZRwmPKZRT+UIt8WMkiN22Xq9HL+DFk+L0Gsi32wy8YuJuAV6Qd2YrU9MwtMlp+OCRInhyGEz1kgDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454640; c=relaxed/simple;
	bh=b3yQktpC+Sk1axf9uRzfmXChAC0fkKcq145dDjqD6Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXDNy2+4lJlIZzljQIcbl3cJS22xcH+DCCXeVbuvSP1OnRIhaBYYrx3C6en37eF/r1iBos5WakJMQqfm2/I6qIx4A6tiDN/6cRM8J4UTH01yjSW5cHiCBhGk5OZu2i8o4hvLTuqxJoWPepzkYokfffUOjROCaXTdUbwjV/JgSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYrFXBkP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYrFXBkP"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so131734926d6.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779454638; x=1780059438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y7bHl67RpfSH1i9BIN3c7f7/8VqTkoPZRFRQwzd3Fs=;
        b=bYrFXBkPHycGMDnWXrt/MQDlhTG0lbmhpY/FquF+mEXRCG3CwniP9oK1MLfXPtlmh+
         7Hu8YMFs+gfkK8h3asJFPVCJKMj8chsMMYR+TWgskc9h80ojcM9ai2MPOSU8rwRXoFwQ
         CWFrwcwq7HgFa6Oh6zlOju9HyDL+l6u0SdOdLrc4CPSPui8emXKo8gRUTPz3jIJIp88r
         q2lP9K0gVGdauCQPo8F6ujxztBCbpJnntfwGw6BOB3ByhD47bqwD7af6okXFA61vn2Km
         0YtXXWrENly7PC27zdakDXNgmzhf9Cc/PckIdFQLB6u65Q+wbQtAVBuetz8ai7CTPOZi
         eZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779454638; x=1780059438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y7bHl67RpfSH1i9BIN3c7f7/8VqTkoPZRFRQwzd3Fs=;
        b=Lq0JB+FzNa1WmJWG5//pSMbJGQXCD7fNWEFJUEIDQOVtJ//19e1dE4Ki+T0o5cwLrw
         CC1Vi0pjpiiLZSF+AazD24hQ2MMAaQozS7umUlFuBDh6f4Ffem7sEI+3Cy6wtcklxSoi
         D8K/aVTZr2N3ARgar/QulhvJiNP/NiU29C8Vz13MQ+VJZRneFYLElhDsd+Qozm+F51DU
         CBh5bAfFJ4AeNaEibjqL/PevjiMi7hw5mValdbdZYKJ7tJu4HtyYI73rWcc29JSWsWdW
         7tPf48cUNE5YBf1OEdDre7LfgN35jZ5DcPVE2uN4iEK5m339SymmPxpN6vmFf4KW24w8
         MIfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LV+fhIAa58i1T0ObdT7zpvIFcDqVWxqzDY1dw4WHx32TfPBBIiQFQcCJcLDW6f+0JhF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHXqxRAtUpycSK+PqvU8UzQ6LSKdSkNeWs8ra1kBVwVYJOwCs
	98ZnNq4x+sFuKc0B/O2m6P8F3BENPsvkQi7CBOWfU2UvUkJNAvT+GGv5HQTHEKhOhhA=
X-Gm-Gg: Acq92OHe2WbZHgsOpqTnEl4+DP5EtGJl4DTRnw1f4reCujdlQQ/QNzdNnLLnTWxRri1
	f51jiRlUIOucFyq9fWI4oJEdRoE9xSyzM/iZugejJUwRTOHjzujCdEeXECaF95sZz7PfJdAqUh7
	8kXMK7dp5/8GNkopCghvcCejPWQmK5yVQveqWb9jrjfJWDth8XNNa3n5aO2yf8brO8IT7USUQuv
	y0PLFhptkfWrj/e3/8KTwVaPNtrauLdt37CfUm4RAh/DejdiFpTi5s/NgoP5IXX5JkNDKs0SWeR
	uYxtDl6K5yrPhHlBM/GqN/qB3CkfKaamFXcpoLzvubcVHPTQ/ABykkfuhULYVfWMQNIwwyFVxb7
	UBsSxc2ou2okBThgsA1jTSbK7s+DLsKWpaGguw/JrdnVfuGLFPLns7HiKCIxoyYv7Yu+9XxVRjI
	/CguTDrBpu8fNB/JyVQciFzJofStImXY0v9IfD6AUDfO7IZfdkuS+4dhgBEwR97X1xS0mDfw10z
	Kh6jlhR2wb63zJ6Yz2OAEkDT++aBRc=
X-Received: by 2002:a05:6214:3018:b0:8ac:a689:34ce with SMTP id 6a1803df08f44-8cc7b6a26e7mr57274876d6.45.1779454638141;
        Fri, 22 May 2026 05:57:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131acf9sm16948026d6.43.2026.05.22.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:57:17 -0700 (PDT)
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
Subject: [PATCH v3] libbpf: harden parse_vma_segs() path parsing
Date: Fri, 22 May 2026 08:56:57 -0400
Message-ID: <20260522125657.328840-1-michael.bommarito@gmail.com>
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

Fixes: 74cc6311cec9 ("libbpf: Add USDT notes parsing and resolution logic")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3:
- Correct Fixes tag to the initial USDT implementation commit,
  per BPF CI review after adding second site.

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
