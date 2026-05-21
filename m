Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A13016FC
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401851; cv=none; b=rInHxzKWGdk7zYuzswUspCHYjoF+/kaDFq6GGxQ5ou9aihVTnGIoCCXgG47ab4XafnVM/difBMw9SqK3afOsxFFIHEQC4dlY62T3hzkgjgXv1niRzHstwgRCH4+1AIcMGd4VLr5BfFBwFz9pt/tMiddsttoHE3kMSe8MwHdfy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401851; c=relaxed/simple;
	bh=A6lXaczDHjgNevA0lmJSvS4vtc7KtIgT6xdB5gyEfL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sS9m66cEvt2OCFgT5ucx1dKLF9fyHpu+GPnXTuxZp8wGt2ISbdAcFWOTDapnnOW4sl+ve0otiHYGgdCgV/0nPoyjJqxhQyJqkz4E3kYTmwcz1I/LOaOP0oNyk3UvXspZMI5OG6A+lbwXGjtfiXf3lG1P9eTmJWx6aX4uSH0Vsno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCNEQk+X; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCNEQk+X"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b7105dfb35so85240716d6.3
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779401848; x=1780006648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hU0DVCjQqwiePLyt3GmtYtEALmWzYB8I3V+uH1gF4Rc=;
        b=gCNEQk+XYIJns7O0eI0/4S6wd61rjPiRge41Ta7XyY7s9nFfOTkCYISCaeHnDPKPtc
         i52FNbbxFNR0k20q9xZoXI4B4LCKv23l6mP6VFG7JrAChvA8QCS7MKHz2IkGSxcU5Toc
         Xv4aiu/N5OQQOxb7KNW+/MLy2l3+I/kU7Px5q7t+N148//yyuLaG2GiUBJJmK46ckIiJ
         OHmfA3M0w4YaTo/eMJsllHx619kiVP94v03xHYMfFRVf9/AeJ5Toxv8ZRGzQS9eUVxxv
         e1//me0XSGlqxaSzw7df8cIN3Yd94utnDPQ0otuHSq/7DwGZJqXx2uCe9maIYXbqvk6S
         y4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779401848; x=1780006648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU0DVCjQqwiePLyt3GmtYtEALmWzYB8I3V+uH1gF4Rc=;
        b=CQbn+Lt/yhDVxefS6BWeHXE2xZ59qPpzyvO+TSY+JBtU2R6KhXgptD0xEqp5xdduM4
         ZIJbW0UJijJEFat21K388LYJh+Fl9RsnXrSDc+5q7TGx19zVyE4R8Jz+IKYKIy83dORZ
         iJGx+vV/7LsayGObf9v2YhjVn5VF7dnIGKpMW7bAsg+C3vREq3A1n9EXi0pVhaYTjReB
         q8Kg4/Hx5Ffs4qkc988EvJPS72nhPdpymrSmAcrkhkixx8CGmi+tOMEX9x3ZlptROOhO
         TyqDYuxmUsoB+wNLrVzWHUzpaCMWS6S2PNZjps29VArSMlomYdzyi8nHk3iNrCeU6olV
         PQRw==
X-Forwarded-Encrypted: i=1; AFNElJ9nbEXZYw6r/NnRV1Mp9a+YO3b2Kt+FX6gWfzTWfUiMCE9HD7rbPTn214z8U+o7XVwXQfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37fCdBjXXcGjXUbI6p71hgNLX+S8crzhsEq4KdoGzgAFXIZZ2
	MtwPi/W67X7QX8tEWOpUXNcFwhrJBfGb8ePDBVl2gOkMV0sevttSu3bo
X-Gm-Gg: Acq92OHVISKcbLllbWBTF8r2+3UAP23gT/s/2wdKlmY1w0Qy2B1ZOKZrhW7o38Yzfeu
	nLFMgzw3/VDmOX/+7COsFP5JJoCTgGCTj7dytTAWZmvJuZlNBs5zGsiFoEFZtkvKF6EHQvLZbus
	9ES7I9w2Vel8vOoD4vVVUlJF3TqxRF70CeHfxFoRw+A4GGQp1yL7qgjtL4erT0HqZvxhsGbqQWS
	71pU96tYGtJX3mvn56zb/NSbS00s6PpBBf+WJVqx4JNycTaAuMmwDGv1y7/qK33RbW1um4UeZMm
	dSmHGTUC70fPyjK7paHYQmp/S6ECAR35IdQeuR2GgLFQBeO0ZpLUbc/YXsoGoR8LL2m4c96G/2P
	2r+F2AVOTGoPSUW9eCYLEnxzshS0EpPMAgcFzPspvL18TRQ5sZGv/FLd0Mr/NTEKN3tFxbGp8aG
	GJDDNJUXpt0gIbrpc7+xD8rEHVJk1rzPkviaGYw44XaOTDc4s6rw+8qRr7/P+ghLhgSnn9dZA6r
	hDJe1tN7SfcdOExrNLmZ9GRTucRRBQ=
X-Received: by 2002:ac8:7e91:0:b0:509:3257:c050 with SMTP id d75a77b69052e-516d42e2cafmr18941051cf.24.1779401847508;
        Thu, 21 May 2026 15:17:27 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d63018fesm3590071cf.1.2026.05.21.15.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:17:27 -0700 (PDT)
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
Subject: [PATCH] libbpf: bound /proc/<pid>/maps scansets in parse_vma_segs()
Date: Thu, 21 May 2026 18:17:12 -0400
Message-ID: <20260521221712.3077276-1-michael.bommarito@gmail.com>
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
into line[PATH_MAX].  Both assume the kernel caps maps records
to PATH_MAX, but it does not.

show_map_vma() emits the path via seq_path() against the seq
buffer, which doubles on overflow (m->size <<= 1 in
fs/seq_file.c), so a VMA whose backing path is a deeply nested
directory tree produces a single maps record longer than
PATH_MAX.  scanf "%s" / "%[^\n]" without a width writes until
the field terminator regardless of destination size, so a
bpf_program__attach_usdt() consumer attaching against
an attacker-controlled PID overflows its own stack inside
parse_vma_segs().

Bound both scansets to the declared buffer sizes ("%15s" for
mode[16] and "%4095[^\n]" for line[PATH_MAX]) and drain any
residue past line[4094] with "%*[^\n]" before the trailing "\n",
matching the libbpf-local fscanf style.  Without the drain the
residue of an over-long record would stay in the stream and
break the next "%zx-%zx" parse, so the loop would exit early and
any maps records after the over-long entry would be silently
skipped.

Fixes: 3e6fe5ce4d486 ("libbpf: Fix internal USDT address translation logic for shared libraries")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
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

 tools/lib/bpf/usdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index e3710933fd52a..e50622ef4c014 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -504,8 +504,11 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
 	 * 7f5c6f5d1000-7f5c6f5d3000 rw-p 001c7000 08:04 21238613      /usr/lib64/libc-2.17.so
 	 * 7f5c6f5d3000-7f5c6f5d8000 rw-p 00000000 00:00 0
 	 * 7f5c6f5d8000-7f5c6f5d9000 r-xp 00000000 103:01 362990598    /data/users/andriin/linux/tools/bpf/usdt/libhello_usdt.so
+	 *
+	 * Bound the writes and drain residue: maps lines can exceed
+	 * PATH_MAX when d_path() expands beyond it.
 	 */
-	while (fscanf(f, "%zx-%zx %s %zx %*s %*d%[^\n]\n",
+	while (fscanf(f, "%zx-%zx %15s %zx %*s %*d%4095[^\n]%*[^\n]\n",
 		      &seg_start, &seg_end, mode, &seg_off, line) == 5) {
 		void *tmp;
 

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

