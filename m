Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795829344;
	b=XzFFbznFFumRLBDiMhrSOkPWkfC0/kXZVqe7chMxEGWXI+dTDGJTzK/mOamNeci98I3K
	 ggUJ56d55xBQ0RUlAft4fiUObDBf/oq3pFlpPJtRdpW9uewsJFl4OXVB4t2MADki7r8pM
	 RK/fIZNpPn9BoeOxf5InVxPuLvsIxdgk9Gzagac2U9Qsjq9IHtIa2i5ppP7ARmD2TZYZm
	 5TYX+bq9DwhfFtnSOoQMPj9Bu55fVr3hfMLJy83VDKX2cev0aE0Z5jdL3qffpBj21PIZv
	 //WVt8bnSvxullQrY+F1RMW7dblk8NsEtA1Ai9z/LBfWHVMfB8ZsGl1E80poLKJPcoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795829344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=tf7V1cDreqYmUUDBBlmkxSiDEXxG0ihDtwYPUKBZZCo=;
	b=M8HrpFbJdkfyHQRPmZZK5kc0k5KAQ+3sHY0h+5bcIQXsnLEiYK3LfML0lbHWkDd8Abtb
	 SZ91JFhWtZBPR2wrw03onALV0mRypWv0SdIo8TpXBJ3b6CwjHkHLsBz3wkULJkZm6zvEk
	 pGAWd9hfgTJV5ZnCTTMGcIQol2HGO2x7C0dDg5rZ4te9lLnxbTIbs+OPC99JdNe65gR4c
	 ySFsdeOm52smO35ozR9FQJltJZyM1+Yi5e61nok19v5RGMimgCs4ZSYslf5VDv7FRvu5c
	 /5Ki5LEiuKSSSBZecjqo22y4I8q76K75acA6CPxFOx6OtBu/LumcWw9A4Jlwby+Funw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkur3x5z;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41691606A31F
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41691606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkur3x5z
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-8629ff88e68so3104254a34.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795829343; x=1796434143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tf7V1cDreqYmUUDBBlmkxSiDEXxG0ihDtwYPUKBZZCo=;
        b=kkur3x5z7WfTzQR6TN30kS2C75b3dISDwhddpdPbVIOqCdiheREJhOTz0Bz2cY3yg7
         igrGdvPA806rkiwOuYvzwbxdCwvPw7gRpLH4pRhTFsBBmp6HX7OI4HOTVCVFVLl6WHRh
         qWwG4RrEaP2xRwGHRs4fPqW61d//G1f6mzRpsMbmX343suviLOgz8UwWQfi7/h+bjx5x
         bKJc6aw5y/8CAJIKvAjFtEEiWXT13J5hDiuKWxxu/mAACCWf4q6HMrtn3ftWVWbMebRu
         WPehp9e2Dni0MJVgj9zuftvFpnQbkWIHM0vJx8ci/mjiQKW0urVin3y+Mm8i5htwrGSc
         CKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795829343; x=1796434143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tf7V1cDreqYmUUDBBlmkxSiDEXxG0ihDtwYPUKBZZCo=;
        b=h9Gndu5N4h8+wCqfiRD+EzPUp23CVRCokV0xOHzCUJ9hNxqscT4fXOFGhAuQg4yfsC
         KoIW5utzwJqZ53n3gt61tFrTmuq7/vKz1/v94pf2lWNfS5P0qapYkjA/NuIy+VxltoLO
         TvrRn9JApYY2EXBuSwOviRbMEYPMhE71n6TaA+hsUaosrKo0Iv/Fa/pd5ME+Pr2xVfxU
         b1KtI8GGFeKQjRGTBdmTBwTYOEGnLdywqyqtk+4C7xu5sJdqBEfKfvZnQwsDHWzhtG+n
         inE5O8w9BFW0A2xzHvdtXLcInDi/ZLi8ApukcfdlPPeZZztuFCDtRBa6M0ZANn6VuFFm
         vyGw==
X-Gm-Message-State: APuU4Z8wbGdQaxGvGTi83g5zifhIa2t6knpeh0Rjv3mPMhHRfDykMI21
	fXpfOHjY7rM0nNB5iRjUNXgYGrM1hZeHUYJccwTa4pJ9PF0Vc0VMsdH9RgRF2aYwhAk=
X-Gm-Gg: AZFdTZcAHlrOFBqWSt6lb8VIax1/c8QVjHuYbbqiA/Yrr8LoOVy73eudf7mywPsXzU/
	DeCM3JTieBeSrEH2hyTGTcby98WAk0w0je0OflvU68HnH83o38ssaIVfjEENDPbzXR/PhWV6Phu
	vSko/YV4IqXlc1vSaumcunWcEo9xRylCwwVN1LV5EifGDWtbKlk/ReFPX6knnKmqXV7PMhYOU1a
	0Nu5U9Gl6Fj7JCC3pffsY1fW7rD1pa+M9XZMUtQvUkMtNhm/MBmKWlSsTi1hqjng7h78TCFPDza
	5/Gv5/F1ZkI4xHRcX/uUFe1Sw9+DpE+b49ot1UgSEDEHAvsVaw/Dk5lEVo925ZZfPzBBmgYs7tf
	9pbOEOQ5JoNyuf7GV147LYKwg8fO33IAAUXIhqcTu9Ow2h3Sm7pOkjDknMSOOzQcrlrhsf+z6hs
	VGAPJHKdUCwJcMxhuAtu4q5yfhPjLy+noWV2A7vcDwrJKxzZ14vv0BY0rieky2OC0hDcUvA0s43
	N+HEoMx4VuoeE8RWW0L5y0j8sNlOfCbhqKrWSzz9LYHZOvkindgL0f9IlnwrcNY8h7NCn6Jtc8v
	ASeO0KkjN7rfwMWjpFgzgMHf/k57Ai64wtrBVwttKYaeaQIdAJnth0HyggcBesiq6cIX46rSuOO
	pjcycRqRhxxkkzOIbRIub1Yh+Boj3IGaB4eXw
X-Received: by 2002:a05:6830:3e03:b0:7fa:ac4f:793 with SMTP id 46e09a7af769-86315a869d0mr27875825a34.31.1795829343166;
        Fri, 27 Nov 2026 17:29:03 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm18209071a34.14.2026.11.27.17.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:29:01 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] x86/mm: Resolve BPF exception fixups for user address faults under SMAP
Date: Sat, 28 Nov 2026 02:28:54 +0100
Message-ID: <0a30eeab6bea7ddfc0202d1970ab1b7f3a4d580c.1795829324.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795829324.git.memxor@gmail.com>
References: <cover.1795829324.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4240; h=from:subject:message-id; bh=TVNi9BG3YG0nt/vdulBbJnHqRb5zh57klEhRlPH22XU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtLz1eviOf89aedYqdsxdibd7ze805Daeves1oPykIFVeb5 vtrfUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImcb2L4zapwg8FvcZTLHqVnIgULyy 5Nzzp7o/3PiqD9G56xn9e0e8DwV6igan+D8uLwk7l3GJbw8i1kD/h5OaXTVr3e0mpBXmMpNwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BPF tracing programs read through pointers that cannot be checked when the
program is loaded. For example:

  SEC("fentry/tcp_retransmit_skb")
  int BPF_PROG(retrans, struct sock *sk)
  {
          struct file *f = sk->sk_socket->file;
          ...

sk is valid, but sk->sk_socket is NULL for an orphaned socket. The verifier
marks such a load PROBE_MEM and the JIT gives it an exception table entry
of type EX_TYPE_BPF. The load is a single mov, movzx, movsx or movsxd into
a register. On a fault, ex_handler_bpf() zeroes the register and skips the
instruction. The load is not retried.

This does not work for user addresses. With SMAP enabled,
do_user_addr_fault() treats a kernel-mode fault on a user address with
EFLAGS.AC clear as a kernel bug and oopses without looking at the exception
table. So the x86 JIT puts a range check in front of every PROBE_MEM load
to keep user addresses, the guard page above them and the vsyscall page
away from it. For the second load above, with five-level paging, it emits:

  leaq    10485776(%rdi), %r11      # 16 - VSYSCALL_ADDR
  shrq    $57, %r11                 # zero for user and vsyscall addresses
  jne     load
  xorl    %edi, %edi
  jmp     done
load:
  movq    16(%rdi), %rdi            # offsetof(struct socket, file)
done:

That is 17 or 18 bytes of check for a load of three to eight bytes, and it
repeats in software what the CPU already refuses under SMAP. The pointer is
only known at run time, so the check cannot be done at load time.

Fix up the fault through the exception table when it came from kernel mode,
is a read, and the faulting instruction has an EX_TYPE_BPF entry.
error_context() uses ex_get_fixup_type() the same way for machine checks.
SMAP stays on and the access is not retried, so no user memory is read: the
register reads zero, as it does with the range check. The new check only
runs for faults that oops today, and every other fault there still oopses.
With LASS the access raises #GP instead, which already goes through
fixup_exception().

The JIT also uses EX_TYPE_BPF for arena accesses and unwind entries. Arena
addresses are kernel addresses, and no instruction starts at the address of
an unwind entry, so neither can match a fault on a user address.

The addresses a PROBE_MEM load can read stay the same. What changes is who
refuses a user address: a compare in software, or the CPU with a fault and
a fixup.

                              user, guard,                  kernel address
                              vsyscall page  non-canonical  unmapped  mapped
  copy_from_kernel_nofault()  compare        compare        CPU       load
  PROBE_MEM, range check      compare        CPU            CPU       load
  PROBE_MEM, SMAP alone       CPU            CPU            CPU       load

None of the three filters MMIO. ioremap() space is read in every row, and a
BAR mapped into user space is a user address, refused in every row.

This lets the x86 JIT drop the range check when SMAP is enabled. Kernels
without SMAP keep the check and never take this path.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/mm/fault.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index aa88370ce739..9fe8705eff04 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1263,7 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
 		     !(error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC))) {
 		/*
-		 * No extable entry here.  This was a kernel access to an
+		 * The CPU refused the access. If the BPF JIT marked this load
+		 * as one that may fault, skip it and zero the destination.
+		 */
+		if (!user_mode(regs) && !(error_code & X86_PF_WRITE) &&
+		    ex_get_fixup_type(regs->ip) == EX_TYPE_BPF &&
+		    fixup_exception(regs, X86_TRAP_PF, error_code, address))
+			return;
+
+		/*
+		 * No other fixups here.  This was a kernel access to an
 		 * invalid pointer.  get_kernel_nofault() will not get here.
 		 */
 		page_fault_oops(regs, error_code, address);
-- 
2.53.1-Meta

