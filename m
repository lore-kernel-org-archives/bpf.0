Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3D30EF90
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480854; cv=none; b=E9hYRPTqrmTn73xwKp+qalSS+LETkFpeSyOsJ44OdUswO0w+3GwXH8scr/ZQG3T+TNEocptN7GPNFnkIAgoQixqJUhxINJgce/8ioLJGYoueyPgAdYeMFhxS8Mbnnipjax6MlR5+vpP25cRBKybs2+kfwyyn5vWPf9JpMZHA7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480854; c=relaxed/simple;
	bh=T+T8duR9CZjW08w8okteh8iEB6zt41jrJ2g1lgvOUxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNL8A7HVwhNe3o8TjtJyZV4j2zsFVXwBHismbxAmomKYFnmh6qQTvUkrOfgmTBUKS1YM8XXzbpQhR3Y3ni47rdwhMFFyVp2odzW8Au6LCKCd+4JSm8GazIVQ15q5nJ9R62hEc1gMzy+gztIA4Twp+sqp115BREYxHsDk98xClo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTinLAoJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTinLAoJ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8acae26e564so96544916d6.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779480850; x=1780085650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy69sv1RlbQPcrl5t6Uo1NfBAD3NLb/c+Z2AAhcBMw8=;
        b=bTinLAoJb4yMuTDJ6HSGwAxUJClaJtAe6blKxubk81soh+eR6PQjqJlLgbbnkHr6r9
         rBH0lCNcxWCfLWsuhHVaLohIB028YqTKrizmvoocA6MUO72VE3+Ej6MrpIayw/kLcKk6
         N8bGrPSGjpyZZR2+jW7jkwRV/i/IvQ0u4wLVlMUU6FEMN2S2GXwgyvfrdenO3HLtrzX8
         EOHbaOohGTP5Z9zOfgbyGR5/RLTlN3kGDqPtDQcEz3T77jj2My0e2EJcijgsoWTfInFJ
         aHN5JvP8vvcOpGM4izCBGrHpThyyJ0H6BDLFjKC6P+3fvWFelZwA2SzZMPChUvIH6rnz
         QsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779480850; x=1780085650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy69sv1RlbQPcrl5t6Uo1NfBAD3NLb/c+Z2AAhcBMw8=;
        b=cD5QrAvFxTPs05uySOAMcCCLwinZPskNZZ9Bejx30t8Au9/9kh8JE+bWkZHxsaPLtI
         +pIze3AF6QhN5oEPO//PN5Z019PN0cg4JD525Oj0dsdJ6KTv+Lk86zp0cxmYLYAG7NpI
         9QnsKjtbaVVejg3+UwUr+Jn7FPQ6IYXKg632xLtN70bcAECOgqgRU36TpJzLm+AYzCk+
         eju9Qx/bMHTobhjw/8JVufmPWVoWrE6PWWkbVuvCE7JmJjD4D8Gjfaq2jn5+B3RAf1CS
         a9CVvvEOv1YXE9k63CsSR0QNj0Bx87KtBdYRhrGLppfMZvjSfsY8wRfAzYGg+0xAwwRF
         St4A==
X-Forwarded-Encrypted: i=1; AFNElJ+RnsuwbUA0WN7zlI4pOvjfP1ZiK1vRArs3peZjRnGXcT+IYySwVfCj+/R+qIliRIMc1Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1nPe3RsRHtfQMzgX6j1weE3IFLnhpWU44CAxL+0SqIe+jog4
	iQEuLN9xzMSPKm+GMiIj33lLY07Rt3vbnJh8OZtYqupssXNLK09joOBu
X-Gm-Gg: Acq92OGI6xo+pqUfWjj7x1MowOI+zNQs2cu9EZ9k++uWIaaaPTRDUuniBEOPWCtpqpT
	lK/DFtaxV1ZQEmf3G0/N74S2qEv8UZ9iX1kFgQyFPabvtWicD2Ut4NZZylYyDTzHLzsnAllsr8D
	R5tlOQsjWKEqc6Xisnol+ib3Xse1O6Zp5JLcVgdw6so4ZZZULsNdvQk8HOMERkNAtv3k/npWnnb
	b+4z/FXi8MzsOyFioQ+vvJhF7wWyyrEZA53WPpTAonPdc04dkAPZb2cgJ5IYoSVXljR2YxINt88
	TNbOr9mbqckcs05bNjt/C5jJ9orpwiAFZpnt9R9dfhtiT+xvL2te3ItOscJNRvWgzEy3634d/4W
	NImgzFJ4MHI/FkjvS7esu2qEGQSh2ONy2xL7KhOZkyoGhwlvxTSarROBCiXqzQNU60IP1TPhm9X
	DJTChs/h7x7X6PWhPZIUzcVgdjkwmgsZp3jABN5cX9m6+8d28SUQsu8bkrO3ZdHMUlM+obIXJfx
	oiqHAdR4bbnVBIkBaDT
X-Received: by 2002:a05:6214:d6f:b0:89f:9bc2:20d1 with SMTP id 6a1803df08f44-8cc7b6048aamr91125386d6.7.1779480849610;
        Fri, 22 May 2026 13:14:09 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e60ffsm30543336d6.23.2026.05.22.13.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 13:14:09 -0700 (PDT)
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
Subject: [PATCH v4] libbpf: harden parse_vma_segs() path parsing
Date: Fri, 22 May 2026 16:13:53 -0400
Message-ID: <20260522201353.1454653-1-michael.bommarito@gmail.com>
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
into line[4096]. A VMA name in maps is not limited to that local
buffer; a deeply nested backing path can produce a maps record long
enough to overflow the stack buffer.

Bound both scansets to the declared buffer sizes ("%15s" for mode[16]
and "%4095[^\n]" for line[4096]) and drain any residue past line[4094]
with "%*[^\n]" before the trailing "\n". Without the drain, the residue
of an over-long record would stay in the stream and break the next
"%zx-%zx" parse, so the loop would exit early and silently skip later
maps records.

Also stop using sscanf(..., "%s") to peel the /proc/<pid>/root prefix
from lib_path. Parse the pid and prefix length with "%n", check for the
following slash, and copy the remainder with libbpf_strlcpy(). That
removes a second unbounded stack write and preserves paths containing
spaces.

Fixes: 74cc6311cec9 ("libbpf: Add USDT notes parsing and resolution logic")
Cc: stable@vger.kernel.org
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v4:
- Carry Emil's Reviewed-by.
- Simplify the /proc/<pid>/root prefix handling with sscanf() %n,
  removing the unreachable snprintf() length check.
- Initialize and check the %n output before using it, so partial
  literal matches after the pid cannot use an unassigned offset.
- Add a short comment for the %n return-value rule.
- Declare the maps-line buffer as line[4096] to match the %4095
  scanset width.
- Reword the maps-line comment without seq_file implementation detail.

v3:
- Correct Fixes tag to the initial USDT implementation commit,
  per BPF CI review after adding second site.

v2:
- Replace the unbounded /proc/<pid>/root sscanf() path peeling with
  bounded prefix handling, addressing review feedback on v1 and
  preserving paths containing spaces.
- Keep the v1 maps parser fix using bounded fscanf() scansets and a
  suppressed scanset drain for over-long records.
- Re-ran real parse_vma_segs() ASAN harnesses for the original maps
  overflow, the proc-root overflow, proc-root paths with spaces, and
  adjacent successful parses after an over-long maps record.

Reproduced with Debian 12 on rootless podman: an unprivileged
container process mkdirs 50 nested 200-char directories and mmaps
a file at the bottom, producing a >10KB /proc/<host-pid>/maps
line.  A harness on the host then calls the real parse_vma_segs()
against the container's PID; libbpf is built with
-fsanitize=address and the only local source change is dropping
the "static" keyword on parse_vma_segs so the symbol is linkable
from the harness.

Stock libbpf reports:

  ==ERROR: AddressSanitizer: stack-buffer-overflow
  WRITE of size >10KB at <line> thread T0
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

 tools/lib/bpf/usdt.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index e3710933fd52a..57fb82bb81b58 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -468,10 +468,10 @@ static int parse_elf_segs(Elf *elf, const char *path, struct elf_seg **segs, siz
 
 static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs, size_t *seg_cnt)
 {
-	char path[PATH_MAX], line[PATH_MAX], mode[16];
+	char path[PATH_MAX], line[4096], mode[16];
 	size_t seg_start, seg_end, seg_off;
 	struct elf_seg *seg;
-	int tmp_pid, i, err;
+	int tmp_pid, n, i, err;
 	FILE *f;
 
 	*seg_cnt = 0;
@@ -480,8 +480,13 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
 	 * /proc/<pid>/root/<path>. They will be reported as just /<path> in
 	 * /proc/<pid>/maps.
 	 */
-	if (sscanf(lib_path, "/proc/%d/root%s", &tmp_pid, path) == 2 && pid == tmp_pid)
+	/* %n is not counted in sscanf() return value, so initialize it. */
+	n = 0;
+	if (sscanf(lib_path, "/proc/%d/root%n", &tmp_pid, &n) == 1 &&
+	    n > 0 && pid == tmp_pid && lib_path[n] == '/') {
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
+	 * Some VMA names can be longer than the local buffer. Bound the
+	 * writes, but still consume the rest of the line.
 	 */
-	while (fscanf(f, "%zx-%zx %s %zx %*s %*d%[^\n]\n",
+	while (fscanf(f, "%zx-%zx %15s %zx %*s %*d%4095[^\n]%*[^\n]\n",
 		      &seg_start, &seg_end, mode, &seg_off, line) == 5) {
 		void *tmp;
 
-- 
2.53.0
