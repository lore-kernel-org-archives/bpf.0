Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD73E6399
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647086; cv=pass; b=AYLtOZoTyX7GIj4Zy3LASfjw6JpnFlF/LlYVmIg81UCuuex1Xfq9446nVGrEOsWwj3U3Mx9DWuE/9CEaiBr3CC2qnuKufrNWwdQOn/cC48EXNBwWCPDs+8Xktp6Fmu4nNpKsD5gcq7b1F5hV0UgrkpNg9jy/+SYjkYfTmrqfQxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647086; c=relaxed/simple;
	bh=f7DpswdOZY0yzppkFw42r1r6TsqdZnSX60QczJrXHrw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DGCrEwUm5+7VUZQ+3Qs2VFRHlLV4tDkZAoiSHkKuP2OXeDJaaH+bOFrN2g0vvCcC7oUr3breVkwSLyiPR6M35xcZF4kYEoYP15AZFnw4qCWXYSYwiKgdUoP1pWtiFdr9H6nzW0er8EvjZqH2OZFn93D+6RD+a7COSxK2hHBSFQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIJ8mX44; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIJ8mX44"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97c7afa485bso1995827241.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 01:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787647082; cv=none;
        d=google.com; s=arc-20260327;
        b=dmCBnwHU7QlpQxdndMoQIAN9AiHtpMvtcoClQO4KOw+depbUr9wOY2VwPOqLgKj32I
         weXpapLfUPxg5FmPzXqg/pEB9Lg4XavfH9zv/XmXiSHObstlqxRsXh4Jveslt0k201Y9
         etI3xTW7OSHIZ1DsWImX6pxx5KviO87j4wHuoSzVQcZezCtHvWlx4YgAgO61Xx0VOtzO
         wLKKZ1SquW4bfA6sHFmprR0Uefm5aP5kp/0mQbsfUemJ3dnEr9fizQ/OBjruBj15vLCt
         p7A4LDAIljbo6oy9PGfU9pTkWaSotJtG8ZdpZOZQYs48QPXwJuEM8voi9+K3ADycerhs
         z8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PG57M8T+XxQy86DfJQYvhbLh1Wnye1HzwOkfG8uWnDM=;
        fh=lfyNZKVRBbE6Ew+q5skFSouwOM/qftEO6hYMT3kYJes=;
        b=mbuBdEIbY9NR3N1fiK5h582jKOlUDTkL2Y8Oya/ZIB5jZLOUgzA4WIRXYlH6SagUSQ
         QHJ3Y0QiOzi9BreGSMO3R5ia6fQzR1io808oykiKl5QX4KRfn9P/RaCh/zFhKfovq48J
         /kpybmSqeu3UEYZd5c2yHLJszhWdSQMlWSflzIFEB58WireHDmhEQfbSOHtDIjYmuLPt
         4ODePH4j789xbDPFf3WJiSRRR4ScZH3JUwUj9a4sNlJPrHOGp/hoQrm9cyVWORYIcGYx
         L2+V20ZiRvK47hpR/o6O7QjR8/dDw3A8Hy1M4FwCTsmbU9+UHvsdyhln7mERUw+azbx4
         b+Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647082; x=1788251882; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PG57M8T+XxQy86DfJQYvhbLh1Wnye1HzwOkfG8uWnDM=;
        b=aIJ8mX443oXqgn2DGRWutFzff98HdRACNs+ub+R/1+FSSWJv3uAX7pa1LFizJfa4VL
         tKbX66JYEwPJkM4phoEnJXQQEK5wK3EoZYUGAR6DSGXMYuQJFhsGV7sP8VPFFyrXfB1J
         3u5PrmaKHaNk/sfwsuS+LSQl+Ej+mVPvrwxysOOyN5G6LcUfsrmFyO77PaUGLVUk/uzT
         wXXuArRelc98jURdZaalha6lVMoElqgEvbhXsyJ5llGxfnNHugHll44APzuipywozNQr
         2LjfvheTJ5LC0TOsQne5sKy7AeeL+ciKsq7VOnY5Ep4RNSNAnHM/LlajHOwr19FIpU6v
         a2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647082; x=1788251882;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PG57M8T+XxQy86DfJQYvhbLh1Wnye1HzwOkfG8uWnDM=;
        b=QUmINJII/tQxaOEbqFXELaUthsy7W0L2jFi8CkLDTPlD+FT+nvnHmKWYhiHPJEDDYe
         b9igK8wzvLr0lbyZRRaUDD0i3bUIzW21nNh7kZ/R0svpgb3wmvMNU9AUb+9AgfnQuyII
         GuMCA047T0/urCuoLe5EsV00cfpMpxtmDjrF0NBzo4UMAnw0RUh2I2PzI6qLv8M9KObY
         /lyL9a0KYjRUvc7umD04ROIIf695IF8aquaq4NKP4X9dzLeFQmfNKZV+CnU3mlApAJK4
         Ji3oY2scvRSej08tuP0mrslMh/RxsbSLAfIRwytBFiya1LGqkiKw+Mg2UKqn/liBaTjf
         +NCA==
X-Forwarded-Encrypted: i=1; AHgh+RpQmora4/YlLABTQnuaSPWfPZFg/cBW6ze8O3vajGRq8AF7GQ6LRTEisnM4PQIvRIm0BgY=@vger.kernel.org
X-Gm-Message-State: AFuF++lWHwA9gQJbSSdmr6mn7Auit4OJbK5mmK6TAjE6qu4/ceMgJoKB
	IjmmkAvuU4JUmX6NrYH7syjKfLemMD7kJAElbcm4VG8HGLsi5bFy5wUToqFqLniOKyBqP6s0kSv
	V0c5PNNHXkV7AN4UxpgjRW6W7ZyWhvms=
X-Gm-Gg: AR+sD132A4m985WRiM79avZ0LebqGK24XKaGDpvkvdaX9aRwNMvqo9IGdmCyELYcNR/
	3x7AjZ6uOzapPjzfWFYamHsECZfc+ymViuxNTbSrgxeJBuhju+JnrHxmKs/rLZjPNseo7x49XeE
	i9qC6EZv9enC7TgFZ59NaGULGEdGmVSkyGW2yW8s5wBbJkq89UxigSzrI9rrHUfylQ+TupySJYP
	f1oqcK8OA38P7/N/3YlNM4iOxivm8JGDbTc7XjGg59tKAkYrUEQ7Ml7q3rRYTcNphKTZXLvYsC5
	wP7s/pxdTh3lGs/ppqNdXChneY2wun/PEMLMgZnWTvCuKg==
X-Received: by 2002:a05:6102:868a:10b0:780:58be:5a9b with SMTP id
 ada2fe7eead31-78058cdc211mr473402137.8.1787647082417; Tue, 25 Aug 2026
 01:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: gandalf 4a <baksmali404@gmail.com>
Date: Tue, 25 Aug 2026 16:37:48 +0800
X-Gm-Features: AcwNN1XvNaGjeNfYE8N7sbp-s6-kpxm2pVofU9PYISsNNqt6L8Ffd19C8Prnmzs
Message-ID: <CAOHg6aBPdesARUtOwR9NbsWT77L+GqTmfLGsdAQ=hf1YAGOitg@mail.gmail.com>
Subject: [SECURITY] KASAN global-out-of-bounds in BPF disassembler
 (bpf_ldsx_string, kernel 6.4+)
To: security@kernel.org, bpf@vger.kernel.org
Cc: st@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: multipart/mixed; boundary="00000000000054f02a0659db05a4"

--00000000000054f02a0659db05a4
Content-Type: multipart/alternative; boundary="00000000000054f0290659db05a2"

--00000000000054f0290659db05a2
Content-Type: text/plain; charset="UTF-8"

Hi,
I am writing to report a KASAN-detected global-out-of-bounds read
vulnerability in the BPF disassembler that affects Linux kernel v6.4
and later (all versions with BPF_MEMSX support). I have attached a
minimal C reproducer and a one-line fix patch.
== Vulnerability Summary ==
The bpf_ldsx_string[] array in kernel/bpf/disasm.c is missing an
entry for BPF_DW (64-bit). The disassembler function print_bpf_insn()
calculates the index as BPF_SIZE(insn->code) >> 3, which yields 3 for
BPF_DW, but the array only has 3 entries (indices 0-2 for BPF_W,
BPF_H, BPF_B). This causes an 8-byte out-of-bounds read.
Trigger opcode: 0x99 = BPF_LDX (0x01) | BPF_MEMSX (0x80) | BPF_DW (0x18)
== Trigger Path ==
The crash occurs in the diagnostic printing path that runs BEFORE the
verifier validates the instruction:
bpf(BPF_PROG_LOAD)
-> bpf_check() [verifier.c:21097]
-> check_subprogs() [verifier.c:3057] <- early
-> bpf_diag_program_structure() [diagnostics.c:1215]
-> bpf_diag_source() [diagnostics.c:896]
-> format_disasm_line() [diagnostics.c:633]
-> print_bpf_insn() [disasm.c:302] <- CRASH
The verifier correctly rejects BPF_LDX + BPF_MEMSX + BPF_DW in
check_load_mem() (verifier.c:6616-6618), but the disassembler crash
occurs earlier in check_subprogs(), before opcode validation runs.
== Impact ==
- Denial of Service: With panic_on_warn=1 (common in fuzzing/test
environments, also present in some production configs), KASAN
detection triggers a kernel panic.
- Unprivileged trigger: bpf(BPF_PROG_LOAD) with BPF_PROG_TYPE_SCHED_CLS
does not require CAP_BPF. Any unprivileged user can trigger this.
- Info leak (theoretical): On non-KASAN kernels, the 8-byte OOB read
returns data from .rodata after bpf_ldsx_string.
== Affected Versions ==
Linux 6.4 (commit introducing BPF_MEMSX) through 7.2+ (latest mainline).
Verified unfixed against mainline commit 0a0d1d55dad5 (2026-08-23).
== Upstream Status ==
- GitHub torvalds/linux commits: 0 results for "bpf_ldsx_string"
- GitHub torvalds/linux issues: 0 results
- NVD (NIST): 0 results
- No prior reports found. This is a zero-day.
== Reproducer ==
Attached as reproducer.c. Build and run:
gcc -static -o reproducer reproducer.c
./reproducer
The program loads an 8-instruction BPF program where:
- insn[3]: opcode 0x99 (BPF_LDX|BPF_MEMSX|BPF_DW) triggers OOB
- insn[4]: out-of-range jump (off=100) triggers check_subprogs() error
Expected KASAN output:
BUG: KASAN: global-out-of-bounds in print_bpf_insn+0x1f72/0x2480
kernel/bpf/disasm.c:302
Read of size 8 at addr ffffffff98af8ed8 by task reproducer/9362
bpf_ldsx_string+0x18/0x140
Call Trace:
check_subprogs+0x21a/0x350 kernel/bpf/verifier.c:3039
bpf_check+0x6359/0xa320 kernel/bpf/verifier.c:21097
bpf_prog_load+0x12dc/0x1a40 kernel/bpf/inode.c:225
__sys_bpf+0x51d/0x810 kernel/bpf/syscall.c:6191
__x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:6225
== Fix ==
One-line fix (attached as 0001-fix.patch):
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -115,6 +115,7 @@ static const char *const bpf_ldsx_string[] = {
[BPF_W >> 3] = "s32",
[BPF_H >> 3] = "s16",
[BPF_B >> 3] = "s8",
+ [BPF_DW >> 3] = "s64",
};
This makes bpf_ldsx_string structurally consistent with bpf_ldst_string,
which correctly includes all 4 entries.
== Test Environment ==
Kernel: 7.2.0, commit 0a0d1d55dad5 (2026-08-23)
Config: CONFIG_KASAN=y (generic, inline), CONFIG_KCOV=y
Syzkaller: commit 558388e4b6bbf4c1784f71c5e0c80da325d6d9e0 (2026-08-10)
QEMU: 9.2.0, 4 VMs, 2 CPU / 2048MB each
Host: Ubuntu, kernel 7.0.0-29-generic, x86_64, 30GB RAM, 22 cores

== Attachments ==
| File | Size | Description |
|------|------|-------------|
| `reproducer.c` | 4.3K | Reproducer source code |
| `0001-fix.patch` | 1.5K | One-line fix patch |
| `crash-report2-reproducer.txt` | 3.8K | KASAN report triggered by
reproducer |
| `machineInfo.txt` | 1.9K | VM hardware / kernel environment info |

== Reporter ==
Gandalf4a of Xiaomi ShadowBlade Security Lab
baksmali404@gmail.com
Best regards,
Gandalf4a

--00000000000054f0290659db05a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"white-space:pre-wrap"></div><div style=3D"wh=
ite-space:pre-wrap">Hi,</div><div style=3D"white-space:pre-wrap"></div><div=
 style=3D"white-space:pre-wrap">I am writing to report a KASAN-detected glo=
bal-out-of-bounds read</div><div style=3D"white-space:pre-wrap">vulnerabili=
ty in the BPF disassembler that affects Linux kernel v6.4</div><div style=
=3D"white-space:pre-wrap">and later (all versions with BPF_MEMSX support). =
I have attached a</div><div style=3D"white-space:pre-wrap">minimal C reprod=
ucer and a one-line fix patch.</div><div style=3D"white-space:pre-wrap"></d=
iv><div style=3D"white-space:pre-wrap">=3D=3D Vulnerability Summary =3D=3D<=
/div><div style=3D"white-space:pre-wrap"></div><div style=3D"white-space:pr=
e-wrap">The bpf_ldsx_string[] array in kernel/bpf/disasm.c is missing an</d=
iv><div style=3D"white-space:pre-wrap">entry for BPF_DW (64-bit). The disas=
sembler function print_bpf_insn()</div><div style=3D"white-space:pre-wrap">=
calculates the index as BPF_SIZE(insn-&gt;code) &gt;&gt; 3, which yields 3 =
for</div><div style=3D"white-space:pre-wrap">BPF_DW, but the array only has=
 3 entries (indices 0-2 for BPF_W,</div><div style=3D"white-space:pre-wrap"=
>BPF_H, BPF_B). This causes an 8-byte out-of-bounds read.</div><div style=
=3D"white-space:pre-wrap"></div><div style=3D"white-space:pre-wrap">Trigger=
 opcode: 0x99 =3D BPF_LDX (0x01) | BPF_MEMSX (0x80) | BPF_DW (0x18)</div><d=
iv style=3D"white-space:pre-wrap"></div><div style=3D"white-space:pre-wrap"=
>=3D=3D Trigger Path =3D=3D</div><div style=3D"white-space:pre-wrap"></div>=
<div style=3D"white-space:pre-wrap">The crash occurs in the diagnostic prin=
ting path that runs BEFORE the</div><div style=3D"white-space:pre-wrap">ver=
ifier validates the instruction:</div><div style=3D"white-space:pre-wrap"><=
/div><div style=3D"white-space:pre-wrap">  bpf(BPF_PROG_LOAD)</div><div sty=
le=3D"white-space:pre-wrap">    -&gt; bpf_check()                         [=
verifier.c:21097]</div><div style=3D"white-space:pre-wrap">      -&gt; chec=
k_subprogs()                  [verifier.c:3057]  &lt;- early</div><div styl=
e=3D"white-space:pre-wrap">        -&gt; bpf_diag_program_structure()    [d=
iagnostics.c:1215]</div><div style=3D"white-space:pre-wrap">          -&gt;=
 bpf_diag_source()             [diagnostics.c:896]</div><div style=3D"white=
-space:pre-wrap">            -&gt; format_disasm_line()        [diagnostics=
.c:633]</div><div style=3D"white-space:pre-wrap">              -&gt; print_=
bpf_insn()          [disasm.c:302]  &lt;- CRASH</div><div style=3D"white-sp=
ace:pre-wrap"></div><div style=3D"white-space:pre-wrap">The verifier correc=
tly rejects BPF_LDX + BPF_MEMSX + BPF_DW in</div><div style=3D"white-space:=
pre-wrap">check_load_mem() (verifier.c:6616-6618), but the disassembler cra=
sh</div><div style=3D"white-space:pre-wrap">occurs earlier in check_subprog=
s(), before opcode validation runs.</div><div style=3D"white-space:pre-wrap=
"></div><div style=3D"white-space:pre-wrap">=3D=3D Impact =3D=3D</div><div =
style=3D"white-space:pre-wrap"></div><div style=3D"white-space:pre-wrap">- =
Denial of Service: With panic_on_warn=3D1 (common in fuzzing/test</div><div=
 style=3D"white-space:pre-wrap">  environments, also present in some produc=
tion configs), KASAN</div><div style=3D"white-space:pre-wrap">  detection t=
riggers a kernel panic.</div><div style=3D"white-space:pre-wrap">- Unprivil=
eged trigger: bpf(BPF_PROG_LOAD) with BPF_PROG_TYPE_SCHED_CLS</div><div sty=
le=3D"white-space:pre-wrap">  does not require CAP_BPF. Any unprivileged us=
er can trigger this.</div><div style=3D"white-space:pre-wrap">- Info leak (=
theoretical): On non-KASAN kernels, the 8-byte OOB read</div><div style=3D"=
white-space:pre-wrap">  returns data from .rodata after bpf_ldsx_string.</d=
iv><div style=3D"white-space:pre-wrap"></div><div style=3D"white-space:pre-=
wrap">=3D=3D Affected Versions =3D=3D</div><div style=3D"white-space:pre-wr=
ap"></div><div style=3D"white-space:pre-wrap">Linux 6.4 (commit introducing=
 BPF_MEMSX) through 7.2+ (latest mainline).</div><div style=3D"white-space:=
pre-wrap">Verified unfixed against mainline commit 0a0d1d55dad5 (2026-08-23=
).</div><div style=3D"white-space:pre-wrap"></div><div style=3D"white-space=
:pre-wrap">=3D=3D Upstream Status =3D=3D</div><div style=3D"white-space:pre=
-wrap"></div><div style=3D"white-space:pre-wrap">- GitHub torvalds/linux co=
mmits: 0 results for &quot;bpf_ldsx_string&quot;</div><div style=3D"white-s=
pace:pre-wrap">- GitHub torvalds/linux issues: 0 results</div><div style=3D=
"white-space:pre-wrap">- NVD (NIST): 0 results</div><div style=3D"white-spa=
ce:pre-wrap">- No prior reports found. This is a zero-day.</div><div style=
=3D"white-space:pre-wrap"></div><div style=3D"white-space:pre-wrap">=3D=3D =
Reproducer =3D=3D</div><div style=3D"white-space:pre-wrap"></div><div style=
=3D"white-space:pre-wrap">Attached as reproducer.c. Build and run:</div><di=
v style=3D"white-space:pre-wrap"></div><div style=3D"white-space:pre-wrap">=
  gcc -static -o reproducer reproducer.c</div><div style=3D"white-space:pre=
-wrap">  ./reproducer</div><div style=3D"white-space:pre-wrap"></div><div s=
tyle=3D"white-space:pre-wrap">The program loads an 8-instruction BPF progra=
m where:</div><div style=3D"white-space:pre-wrap">- insn[3]: opcode 0x99 (B=
PF_LDX|BPF_MEMSX|BPF_DW) triggers OOB</div><div style=3D"white-space:pre-wr=
ap">- insn[4]: out-of-range jump (off=3D100) triggers check_subprogs() erro=
r</div><div style=3D"white-space:pre-wrap"></div><div style=3D"white-space:=
pre-wrap">Expected KASAN output:</div><div style=3D"white-space:pre-wrap"><=
/div><div style=3D"white-space:pre-wrap">  BUG: KASAN: global-out-of-bounds=
 in print_bpf_insn+0x1f72/0x2480 kernel/bpf/disasm.c:302</div><div style=3D=
"white-space:pre-wrap">  Read of size 8 at addr ffffffff98af8ed8 by task re=
producer/9362</div><div style=3D"white-space:pre-wrap">  bpf_ldsx_string+0x=
18/0x140</div><div style=3D"white-space:pre-wrap">  Call Trace:</div><div s=
tyle=3D"white-space:pre-wrap">    check_subprogs+0x21a/0x350 kernel/bpf/ver=
ifier.c:3039</div><div style=3D"white-space:pre-wrap">    bpf_check+0x6359/=
0xa320 kernel/bpf/verifier.c:21097</div><div style=3D"white-space:pre-wrap"=
>    bpf_prog_load+0x12dc/0x1a40 kernel/bpf/inode.c:225</div><div style=3D"=
white-space:pre-wrap">    __sys_bpf+0x51d/0x810 kernel/bpf/syscall.c:6191</=
div><div style=3D"white-space:pre-wrap">    __x64_sys_bpf+0x75/0xb0 kernel/=
bpf/syscall.c:6225</div><div style=3D"white-space:pre-wrap"></div><div styl=
e=3D"white-space:pre-wrap">=3D=3D Fix =3D=3D</div><div style=3D"white-space=
:pre-wrap"></div><div style=3D"white-space:pre-wrap">One-line fix (attached=
 as 0001-fix.patch):</div><div style=3D"white-space:pre-wrap"></div><div st=
yle=3D"white-space:pre-wrap">  --- a/kernel/bpf/disasm.c</div><div style=3D=
"white-space:pre-wrap">  +++ b/kernel/bpf/disasm.c</div><div style=3D"white=
-space:pre-wrap">  @@ -115,6 +115,7 @@ static const char *const bpf_ldsx_st=
ring[] =3D {</div><div style=3D"white-space:pre-wrap">   	[BPF_W &gt;&gt; 3=
]  =3D &quot;s32&quot;,</div><div style=3D"white-space:pre-wrap">   	[BPF_H=
 &gt;&gt; 3]  =3D &quot;s16&quot;,</div><div style=3D"white-space:pre-wrap"=
>   	[BPF_B &gt;&gt; 3]  =3D &quot;s8&quot;,</div><div style=3D"white-space=
:pre-wrap">  +	[BPF_DW &gt;&gt; 3] =3D &quot;s64&quot;,</div><div style=3D"=
white-space:pre-wrap">   };</div><div style=3D"white-space:pre-wrap"></div>=
<div style=3D"white-space:pre-wrap">This makes bpf_ldsx_string structurally=
 consistent with bpf_ldst_string,</div><div style=3D"white-space:pre-wrap">=
which correctly includes all 4 entries.</div><div style=3D"white-space:pre-=
wrap"></div><div style=3D"white-space:pre-wrap">=3D=3D Test Environment =3D=
=3D</div><div style=3D"white-space:pre-wrap"></div><div style=3D"white-spac=
e:pre-wrap">  Kernel:  7.2.0, commit 0a0d1d55dad5 (2026-08-23)</div><div st=
yle=3D"white-space:pre-wrap">  Config:  CONFIG_KASAN=3Dy (generic, inline),=
 CONFIG_KCOV=3Dy</div><div style=3D"white-space:pre-wrap">  Syzkaller: comm=
it 558388e4b6bbf4c1784f71c5e0c80da325d6d9e0 (2026-08-10)</div><div style=3D=
"white-space:pre-wrap">  QEMU:    9.2.0, 4 VMs, 2 CPU / 2048MB each</div><d=
iv style=3D"white-space:pre-wrap">  Host:    Ubuntu, kernel 7.0.0-29-generi=
c, x86_64, 30GB RAM, 22 cores</div><div style=3D"white-space:pre-wrap"><br>=
</div><div style=3D"white-space:pre-wrap"><div></div><div><span style=3D"ba=
ckground-color:transparent">=3D=3D </span>Attachments<strong> </strong><spa=
n style=3D"background-color:transparent">=3D=3D </span></div><div></div><di=
v>| File | Size | Description |</div><div>|------|------|-------------|</di=
v><div>| `reproducer.c` | 4.3K | Reproducer source code |</div><div>| `0001=
-fix.patch` | 1.5K | One-line fix patch |</div><div>| `crash-report2-reprod=
ucer.txt` | 3.8K | KASAN report triggered by reproducer |</div><div><span s=
tyle=3D"background-color:transparent">| `machineInfo.txt` | 1.9K | VM hardw=
are / kernel environment info |</span></div><div><br></div></div><div style=
=3D"white-space:pre-wrap"></div><div style=3D"white-space:pre-wrap">=3D=3D =
Reporter =3D=3D</div><div style=3D"white-space:pre-wrap"></div><div style=
=3D"white-space:pre-wrap">Gandalf4a of Xiaomi ShadowBlade Security Lab</div=
><div style=3D"white-space:pre-wrap"><a href=3D"mailto:baksmali404@gmail.co=
m">baksmali404@gmail.com</a></div><div style=3D"white-space:pre-wrap"></div=
><div style=3D"white-space:pre-wrap">Best regards,</div><div style=3D"white=
-space:pre-wrap">Gandalf4a</div></div>

--00000000000054f0290659db05a2--
--00000000000054f02a0659db05a4
Content-Type: text/plain; charset="US-ASCII"; name="machineInfo.txt"
Content-Disposition: attachment; filename="machineInfo.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mt8esgfg1>
X-Attachment-Id: f_mt8esgfg1

UUVNVSBlbXVsYXRvciB2ZXJzaW9uIDkuMi4wCi9ob21lL3VzZXIvLmxvY2FsL2Jpbi9xZW11LXN5
c3RlbS14ODZfNjQgWyItbSIgIjIwNDgiICItc21wIiAiMiIgIi1jaGFyZGV2IiAic29ja2V0LGlk
PVNPQ0tTWVosc2VydmVyPW9uLHdhaXQ9b2ZmLGhvc3Q9bG9jYWxob3N0LHBvcnQ9NDcwMzkiICIt
bW9uIiAiY2hhcmRldj1TT0NLU1laLG1vZGU9Y29udHJvbCIgIi1kaXNwbGF5IiAibm9uZSIgIi1z
ZXJpYWwiICJzdGRpbyIgIi1uby1yZWJvb3QiICItbmFtZSIgIlZNLTEiICItZGV2aWNlIiAidmly
dGlvLXJuZy1wY2kiICItZGV2aWNlIiAiaTYzMDBlc2IiICItd2F0Y2hkb2ctYWN0aW9uIiAiaW5q
ZWN0LW5taSIgIi1kZXZpY2UiICJlMTAwMCxuZXRkZXY9bmV0MCIgIi1uZXRkZXYiICJ1c2VyLGlk
PW5ldDAscmVzdHJpY3Q9b24saG9zdGZ3ZD10Y3A6MTI3LjAuMC4xOjI1MzA2LToyMiIgIi1pbml0
cmQiICIvaG9tZS91c2VyL2Z1enovbGludXhfa2VybmVsL2luaXRyYW1mcy1zc2guY3Bpby5neiIg
Ii1rZXJuZWwiICIvaG9tZS91c2VyL2Z1enovbGludXhfa2VybmVsL2xpbnV4LTcuMi9hcmNoL3g4
Ni9ib290L2J6SW1hZ2UiICItYXBwZW5kIiAicm9vdD0vZGV2L3NkYSBjb25zb2xlPXR0eVMwIHJk
aW5pdD0vaW5pdCBvb3BzPXBhbmljIHBhbmljPS0xIHBhbmljX29uX3dhcm49MSBwYW5pY19vbl9v
b3BzPTEga2FzYW5fbXVsdGlfc2hvdD0xIG5vaHo9b2ZmIl0KCltDUFUgSW5mb10KcHJvY2Vzc29y
ICAgICAgICAgICA6IDAsIDEKdmVuZG9yX2lkICAgICAgICAgICA6IEF1dGhlbnRpY0FNRApjcHUg
ZmFtaWx5ICAgICAgICAgIDogMTUKbW9kZWwgICAgICAgICAgICAgICA6IDEwNwptb2RlbCBuYW1l
ICAgICAgICAgIDogUUVNVSBWaXJ0dWFsIENQVSB2ZXJzaW9uIDIuNSsKc3RlcHBpbmcgICAgICAg
ICAgICA6IDEKbWljcm9jb2RlICAgICAgICAgICA6IDB4MTAwMDA2NQpjcHUgTUh6ICAgICAgICAg
ICAgIDogMjk5NS4yMjkKY2FjaGUgc2l6ZSAgICAgICAgICA6IDUxMiBLQgpwaHlzaWNhbCBpZCAg
ICAgICAgIDogMApzaWJsaW5ncyAgICAgICAgICAgIDogMgpjb3JlIGlkICAgICAgICAgICAgIDog
MCwgMQpjcHUgY29yZXMgICAgICAgICAgIDogMgphcGljaWQgICAgICAgICAgICAgIDogMCwgMQpp
bml0aWFsIGFwaWNpZCAgICAgIDogMCwgMQpmcHUgICAgICAgICAgICAgICAgIDogeWVzCmZwdV9l
eGNlcHRpb24gICAgICAgOiB5ZXMKY3B1aWQgbGV2ZWwgICAgICAgICA6IDEzCndwICAgICAgICAg
ICAgICAgICAgOiB5ZXMKZmxhZ3MgICAgICAgICAgICAgICA6IGZwdSBkZSBwc2UgdHNjIG1zciBw
YWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVzaCBt
bXggZnhzciBzc2Ugc3NlMiBodCBzeXNjYWxsIG54IGxtIHJlcF9nb29kIG5vcGwgeHRvcG9sb2d5
IGNwdWlkIGV4dGRfYXBpY2lkIHBuaSBjeDE2IGh5cGVydmlzb3IgbGFoZl9sbSBjbXBfbGVnYWN5
IHN2bSAzZG5vd3ByZWZldGNoIHZtbWNhbGwKYnVncyAgICAgICAgICAgICAgICA6IGZ4c2F2ZV9s
ZWFrIHN5c3JldF9zc19hdHRycyBudWxsX3NlZyBzd2FwZ3NfZmVuY2UgYW1kX2U0MDAgc3BlY3Ry
ZV92MSBzcGVjdHJlX3YyIHNwZWN0cmVfdjJfdXNlcgpib2dvbWlwcyAgICAgICAgICAgIDogNTk5
MC40NSwgNjAzNC44OQpUTEIgc2l6ZSAgICAgICAgICAgIDogMTAyNCA0SyBwYWdlcwpjbGZsdXNo
IHNpemUgICAgICAgIDogNjQKY2FjaGVfYWxpZ25tZW50ICAgICA6IDY0CmFkZHJlc3Mgc2l6ZXMg
ICAgICAgOiA0MCBiaXRzIHBoeXNpY2FsLCA0OCBiaXRzIHZpcnR1YWwKcG93ZXIgbWFuYWdlbWVu
dCAgICA6IAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCg==
--00000000000054f02a0659db05a4
Content-Type: text/x-csrc; charset="UTF-8"; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mt8esgfw2>
X-Attachment-Id: f_mt8esgfw2

LyoKICogcmVwcm9kdWNlci5jIOKAlCB0cmlnZ2VycyBLQVNBTiBnbG9iYWwtb29iIGluIHByaW50
X2JwZl9pbnNuIChkaXNhc20uYzozMDIpCiAqCiAqIFJvb3QgY2F1c2U6IGJwZl9sZHN4X3N0cmlu
Z1tdIGhhcyBvbmx5IDMgZW50cmllcyAoQlBGX1cvSC9CKSwgbWlzc2luZyBCUEZfRFcuCiAqIE9w
Y29kZSAweDk5ID0gQlBGX0xEWHxCUEZfTUVNU1h8QlBGX0RXIOKGkiBpbmRleCAzIOKGkiBPT0Ig
cmVhZCBvZiA4IGJ5dGVzLgogKgogKiBUcmlnZ2VyIHBhdGggKGNyaXRpY2FsIGluc2lnaHQpOgog
KiAgIGJwZl9wcm9nX2xvYWQoKSDihpIgYnBmX2NoZWNrKCkKICogICAgIOKGkiBjaGVja19zdWJw
cm9ncygpICAgICAgICAgICAgICAgICAgICAvLyBydW5zIEJFRk9SRSBvcGNvZGUgdmFsaWRhdGlv
bgogKiAgICAgICDihpIgZGV0ZWN0cyBvdXQtb2YtcmFuZ2UganVtcAogKiAgICAgICDihpIgYnBm
X2RpYWdfcHJvZ3JhbV9zdHJ1Y3R1cmUoKSAgICAgIC8vIGVycm9yIHJlcG9ydGluZwogKiAgICAg
ICAgIOKGkiBicGZfZGlhZ19zb3VyY2UoKQogKiAgICAgICAgICAg4oaSIGRpYWdfcHJpbnRfaW5z
bl9jb250ZXh0KCkgICAgIC8vIHByaW50cyDCsTIgY29udGV4dCBsaW5lcwogKiAgICAgICAgICAg
ICDihpIgcHJpbnRfYnBmX2luc24oKSAgICAgICAgICAgIC8vIGVuY291bnRlcnMgMHg5OSDihpIg
S0FTQU4gT09CCiAqICAgICDihpIgY2hlY2tfYW5kX3Jlc29sdmVfaW5zbnMoKSAgICAgICAgICAg
Ly8gb3Bjb2RlIGNoZWNrIGlzIEhFUkUsIHRvbyBsYXRlCiAqICAgICAgIOKGkiBicGZfb3Bjb2Rl
X2luX2luc250YWJsZSgweDk5KSAgICAgLy8gcmVqZWN0cywgYnV0IGNyYXNoIGFscmVhZHkgaGFw
cGVuZWQKICoKICogVGhlIHByb2dyYW0gbXVzdCBjb250YWluOgogKiAgIDEuIE9wY29kZSAweDk5
IChCUEZfTERYfEJQRl9NRU1TWHxCUEZfRFcpIOKAlCB0cmlnZ2VycyB0aGUgT09CIGluIGJwZl9s
ZHN4X3N0cmluZwogKiAgIDIuIEEgc3RydWN0dXJhbCBlcnJvciAob3V0LW9mLXJhbmdlIGp1bXAp
IOKAlCB0cmlnZ2VycyB0aGUgZGlzYXNzZW1ibGVyIHBhdGgKICoKICogQnVpbGQ6ICBnY2MgLXN0
YXRpYyAtbyByZXByb2R1Y2VyIHJlcHJvZHVjZXIuYwogKiBSdW46ICAgIC4vcmVwcm9kdWNlciAg
KHJlcXVpcmVzIHJvb3QgKyBLQVNBTiBrZXJuZWwpCiAqIEV4cGVjdDogS0FTQU4gZ2xvYmFsLW91
dC1vZi1ib3VuZHMgaW4gcHJpbnRfYnBmX2luc24sIHRoZW4ga2VybmVsIHBhbmljIGlmIHBhbmlj
X29uX3dhcm49MQogKi8KCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNp
bmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8ZXJybm8uaD4K
I2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxsaW51eC9icGYuaD4KCnN0YXRpYyBp
bnQgYnBmX3Byb2dfbG9hZCh1bmlvbiBicGZfYXR0ciAqYXR0ciwgdW5zaWduZWQgaW50IHNpemUp
CnsKICAgIHJldHVybiBzeXNjYWxsKF9fTlJfYnBmLCBCUEZfUFJPR19MT0FELCBhdHRyLCBzaXpl
KTsKfQoKaW50IG1haW4odm9pZCkKewogICAgLyoKICAgICAqIDgtaW5zdHJ1Y3Rpb24gQlBGIHBy
b2dyYW06CiAgICAgKgogICAgICogIFswXSBCUEZfTERfSU1NNjQgcjAgPSAwICAgICAoMTYgYnl0
ZXMsIGluc24gMC0xKQogICAgICogIFsyXSBCUEZfQUxVNjQgIHIxID0gMAogICAgICogIFszXSBC
UEZfTERYfEJQRl9NRU1TWHxCUEZfRFcgIHIxID0gKihzNjQqKShyMTAgLSA4KSAgIOKGkCBvcGNv
ZGUgMHg5OQogICAgICogIFs0XSBCUEZfSk1QICAgZ290byArMTAwICAgICAg4oaQIGp1bXAgdGFy
Z2V0ID0gaW5zbiA0KzEwMCsxID0gMTA1LCB3YXkgb3V0IG9mIHJhbmdlCiAgICAgKiAgWzVdIEJQ
Rl9BTFU2NCAgcjAgPSAwCiAgICAgKiAgWzZdIEJQRl9BTFU2NCAgcjAgPSAwCiAgICAgKiAgWzdd
IEJQRl9FWElUCiAgICAgKgogICAgICogY2hlY2tfc3VicHJvZ3MoKSBzZWVzIGluc25bNF0ganVt
cCB0YXJnZXQgMTA1ID49IGluc25fY250KDgpLAogICAgICogY2FsbHMgYnBmX2RpYWdfcHJvZ3Jh
bV9zdHJ1Y3R1cmUoKSB0byBwcmludCBjb250ZXh0IGFyb3VuZCBpbnNuWzRdLgogICAgICogQ29u
dGV4dCB3aW5kb3c6IGluc25bMi4uNl0sIHdoaWNoIGluY2x1ZGVzIGluc25bM10gd2l0aCBvcGNv
ZGUgMHg5OS4KICAgICAqIHByaW50X2JwZl9pbnNuKGluc25bM10pIOKGkiBjYXNlIEJQRl9MRFgg
4oaSIGJwZl9sZHN4X3N0cmluZ1szXSDihpIgT09CLgogICAgICovCiAgICBzdHJ1Y3QgYnBmX2lu
c24gcHJvZ1tdID0gewogICAgICAgIC8qIFswLTFdIEJQRl9MRF9JTU02NCByMCA9IDAgKHR3byA4
LWJ5dGUgaGFsdmVzKSAqLwogICAgICAgIHsgLmNvZGUgPSAweDE4LCAuZHN0X3JlZyA9IDAsIC5z
cmNfcmVnID0gMCwgLm9mZiA9IDAsIC5pbW0gPSAwIH0sCiAgICAgICAgeyAuY29kZSA9IDB4MDAs
IC5kc3RfcmVnID0gMCwgLnNyY19yZWcgPSAwLCAub2ZmID0gMCwgLmltbSA9IDAgfSwKICAgICAg
ICAvKiBbMl0gcjEgPSAwICovCiAgICAgICAgeyAuY29kZSA9IDB4YjcsIC5kc3RfcmVnID0gMSwg
LnNyY19yZWcgPSAwLCAub2ZmID0gMCwgLmltbSA9IDAgfSwKICAgICAgICAvKiBbM10gQlBGX0xE
WHxCUEZfTUVNU1h8QlBGX0RXOiByMSA9ICooczY0KikocjEwIC0gOCkg4oCUIFRSSUdHRVIgKi8K
ICAgICAgICB7IC5jb2RlID0gMHg5OSwgLmRzdF9yZWcgPSAxLCAuc3JjX3JlZyA9IDB4QSwgLm9m
ZiA9IC04LCAuaW1tID0gMCB9LAogICAgICAgIC8qIFs0XSBqdW1wICsxMDAgKHRhcmdldCA9IDQg
KyAxMDAgKyAxID0gMTA1LCB3YXkgb3V0IG9mIHJhbmdlKSDigJQgVFJJR0dFUiAqLwogICAgICAg
IHsgLmNvZGUgPSAweDA1LCAuZHN0X3JlZyA9IDAsIC5zcmNfcmVnID0gMCwgLm9mZiA9IDEwMCwg
LmltbSA9IDAgfSwKICAgICAgICAvKiBbNS02XSBwYWRkaW5nICovCiAgICAgICAgeyAuY29kZSA9
IDB4YjcsIC5kc3RfcmVnID0gMCwgLnNyY19yZWcgPSAwLCAub2ZmID0gMCwgLmltbSA9IDAgfSwK
ICAgICAgICB7IC5jb2RlID0gMHhiNywgLmRzdF9yZWcgPSAwLCAuc3JjX3JlZyA9IDAsIC5vZmYg
PSAwLCAuaW1tID0gMCB9LAogICAgICAgIC8qIFs3XSBFWElUICovCiAgICAgICAgeyAuY29kZSA9
IDB4OTUsIC5kc3RfcmVnID0gMCwgLnNyY19yZWcgPSAwLCAub2ZmID0gMCwgLmltbSA9IDAgfSwK
ICAgIH07CgogICAgY2hhciBsb2dfYnVmWzQwOTZdOwogICAgbWVtc2V0KGxvZ19idWYsIDAsIHNp
emVvZihsb2dfYnVmKSk7CgogICAgdW5pb24gYnBmX2F0dHIgYXR0cjsKICAgIG1lbXNldCgmYXR0
ciwgMCwgc2l6ZW9mKGF0dHIpKTsKICAgIGF0dHIucHJvZ190eXBlICA9IEJQRl9QUk9HX1RZUEVf
U0NIRURfQ0xTOwogICAgYXR0ci5pbnNuX2NudCAgID0gc2l6ZW9mKHByb2cpIC8gc2l6ZW9mKHBy
b2dbMF0pOwogICAgYXR0ci5pbnNucyAgICAgID0gKHVuc2lnbmVkIGxvbmcgbG9uZylwcm9nOwog
ICAgYXR0ci5saWNlbnNlICAgID0gKHVuc2lnbmVkIGxvbmcgbG9uZykiR1BMIjsKICAgIGF0dHIu
bG9nX2J1ZiAgICA9ICh1bnNpZ25lZCBsb25nIGxvbmcpbG9nX2J1ZjsKICAgIGF0dHIubG9nX3Np
emUgICA9IHNpemVvZihsb2dfYnVmKTsKICAgIGF0dHIubG9nX2xldmVsICA9IDE7CgogICAgcHJp
bnRmKCJbKl0gVHJpZ2dlcjogb3Bjb2RlIDB4OTkgKEJQRl9MRFh8QlBGX01FTVNYfEJQRl9EVykg
KyBvdXQtb2YtcmFuZ2UganVtcFxuIik7CiAgICBwcmludGYoIlsqXSBQcm9ncmFtOiAlbHUgaW5z
dHJ1Y3Rpb25zXG4iLCAodW5zaWduZWQgbG9uZylhdHRyLmluc25fY250KTsKICAgIHByaW50Zigi
WypdIENhbGxpbmcgYnBmKEJQRl9QUk9HX0xPQUQpLi4uXG4iKTsKCiAgICBpbnQgZmQgPSBicGZf
cHJvZ19sb2FkKCZhdHRyLCBzaXplb2YoYXR0cikpOwogICAgaWYgKGZkIDwgMCkgewogICAgICAg
IHByaW50ZigiWypdIFJldHVybmVkIGZkPSVkLCBlcnJubz0lZCAoJXMpXG4iLCBmZCwgZXJybm8s
IHN0cmVycm9yKGVycm5vKSk7CiAgICAgICAgaWYgKGxvZ19idWZbMF0pIHsKICAgICAgICAgICAg
cHJpbnRmKCJbKl0gVmVyaWZpZXIgbG9nIChmaXJzdCAxMDI0IGJ5dGVzKTpcbiUuMTAyNHNcbiIs
IGxvZ19idWYpOwogICAgICAgIH0KICAgICAgICBwcmludGYoIlsqXSBDaGVjayBkbWVzZyBmb3Ig
S0FTQU4gcmVwb3J0OlxuIik7CiAgICAgICAgcHJpbnRmKCIgICAgZG1lc2cgfCBncmVwIC1BNSAn
S0FTQU4uKnByaW50X2JwZl9pbnNuJ1xuIik7CiAgICB9IGVsc2UgewogICAgICAgIHByaW50Zigi
WyFdIFVuZXhwZWN0ZWQgc3VjY2VzcyAoZmQ9JWQpXG4iLCBmZCk7CiAgICAgICAgY2xvc2UoZmQp
OwogICAgfQogICAgcmV0dXJuIDA7Cn0K
--00000000000054f02a0659db05a4
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-fix.patch"
Content-Disposition: attachment; filename="0001-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mt8esgeo0>
X-Attachment-Id: f_mt8esgeo0

RnJvbTogR2FuZGFsZjRhIG9mIFhpYW9taSBTaGFkb3dCbGFkZSBTZWN1cml0eSBMYWIgPGJha3Nt
YWxpNDA0QGdtYWlsLmNvbT4KRGF0ZTogTW9uLCAyNSBBdWcgMjAyNgpTdWJqZWN0OiBbUEFUQ0hd
IGJwZjogZGlzYXNtOiBmaXggS0FTQU4gZ2xvYmFsLW91dC1vZi1ib3VuZHMgaW4gcHJpbnRfYnBm
X2luc24KCmJwZl9sZHN4X3N0cmluZ1tdIGlzIG1pc3NpbmcgYW4gZW50cnkgZm9yIEJQRl9EVyAo
NjQtYml0KSwgY2F1c2luZyBhbgo4LWJ5dGUgb3V0LW9mLWJvdW5kcyByZWFkIGluIHByaW50X2Jw
Zl9pbnNuKCkgd2hlbiBkaXNhc3NlbWJsaW5nIGEKQlBGX0xEWCBpbnN0cnVjdGlvbiB3aXRoIEJQ
Rl9NRU1TWCBtb2RlIGFuZCBCUEZfRFcgc2l6ZS4KClRoZSBpbmRleCBjYWxjdWxhdGlvbiBCUEZf
U0laRShpbnNuLT5jb2RlKSA+PiAzIHlpZWxkcyAzIGZvciBCUEZfRFcsCmJ1dCBicGZfbGRzeF9z
dHJpbmdbXSBvbmx5IGhhcyAzIGVudHJpZXMgKGluZGljZXMgMC0yIGZvciBCUEZfVywgQlBGX0gs
CkJQRl9CKS4gVGhlIGNvbXBhbmlvbiBhcnJheSBicGZfbGRzdF9zdHJpbmdbXSBjb3JyZWN0bHkg
aW5jbHVkZXMgYWxsIDQKZW50cmllcyBpbmNsdWRpbmcgQlBGX0RXLgoKVGhpcyBjYW4gYmUgdHJp
Z2dlcmVkIGJ5IGFueSB1bnByaXZpbGVnZWQgdXNlciB2aWEgYnBmKEJQRl9QUk9HX0xPQUQpCndp
dGggYSBjcmFmdGVkIEJQRiBwcm9ncmFtIGNvbnRhaW5pbmcgb3Bjb2RlIDB4OTkuIFRoZSBjcmFz
aCBvY2N1cnMgaW4KdGhlIGRpYWdub3N0aWMgcHJpbnRpbmcgcGF0aCAoY2hlY2tfc3VicHJvZ3Mg
LT4gYnBmX2RpYWdfcHJvZ3JhbV9zdHJ1Y3R1cmUKLT4gcHJpbnRfYnBmX2luc24pIHdoaWNoIHJ1
bnMgYmVmb3JlIHRoZSB2ZXJpZmllciByZWplY3RzIHRoZSBpbnZhbGlkCmluc3RydWN0aW9uLgoK
Rml4IGJ5IGFkZGluZyB0aGUgbWlzc2luZyBbQlBGX0RXID4+IDNdID0gInM2NCIgZW50cnkuCgpG
aXhlczogMTE0ZTY2ZmY4ZmExICgiYnBmOiBBZGQgQlBGX01FTVNYIGluc3RydWN0aW9uIHN1cHBv
cnQiKQpTaWduZWQtb2ZmLWJ5OiBHYW5kYWxmNGEgb2YgWGlhb21pIFNoYWRvd0JsYWRlIFNlY3Vy
aXR5IExhYiA8YmFrc21hbGk0MDRAZ21haWwuY29tPgotLS0KIGtlcm5lbC9icGYvZGlzYXNtLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2tlcm5l
bC9icGYvZGlzYXNtLmMgYi9rZXJuZWwvYnBmL2Rpc2FzbS5jCmluZGV4IHh4eHh4eHguLnl5eXl5
eXkgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9icGYvZGlzYXNtLmMKKysrIGIva2VybmVsL2JwZi9kaXNh
c20uYwpAQCAtMTE1LDYgKzExNSw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBicGZfbGRz
eF9zdHJpbmdbXSA9IHsKIAlbQlBGX1cgPj4gM10gID0gInMzMiIsCiAJW0JQRl9IID4+IDNdICA9
ICJzMTYiLAogCVtCUEZfQiA+PiAzXSAgPSAiczgiLAorCVtCUEZfRFcgPj4gM10gPSAiczY0IiwK
IH07Cg==
--00000000000054f02a0659db05a4
Content-Type: text/plain; charset="ISO-8859-1"; name="crash-report2-reproducer.txt"
Content-Disposition: attachment; filename="crash-report2-reproducer.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mt8eumad4>
X-Attachment-Id: f_mt8eumad4

bXNkb3M6IFVua25vd24gcGFyYW1ldGVyICeu+R1NvgOm9WfnJwpFWFQ0LWZzIChsb29wMSk6IHVu
bW91bnRpbmcgZmlsZXN5c3RlbSAwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDAu
Cmxvb3A1OiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDUxMgo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
QlVHOiBLQVNBTjogZ2xvYmFsLW91dC1vZi1ib3VuZHMgaW4gcHJpbnRfYnBmX2luc24rMHgxZjcy
LzB4MjQ4MCBrZXJuZWwvYnBmL2Rpc2FzbS5jOjMwMgpSZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZm
ZmZmZmZmOThhZjhlZDggYnkgdGFzayByZXByb2R1Y2VyLzkzNjIKCkNQVTogMCBVSUQ6IDAgUElE
OiA5MzYyIENvbW06IHJlcHJvZHVjZXIgTm90IHRhaW50ZWQgNy4yLjAtZzBhMGQxZDU1ZGFkNSAj
MyBQUkVFTVBUKGxhenkpIApIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlgg
KyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4xNi4zLTAtZ2E2ZWQ2YjcwMWYwYS1wcmVidWlsdC5x
ZW11Lm9yZyAwNC8wMS8yMDE0CkNhbGwgVHJhY2U6CiA8VEFTSz4KIF9fZHVtcF9zdGFjayBsaWIv
ZHVtcF9zdGFjay5jOjk0IFtpbmxpbmVdCiBkdW1wX3N0YWNrX2x2bCsweDcwLzB4YTAgbGliL2R1
bXBfc3RhY2suYzoxMjAKIHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24gbW0va2FzYW4vcmVwb3J0
LmM6Mzc4IFtpbmxpbmVdCiBwcmludF9yZXBvcnQrMHgxNTMvMHg0YzYgbW0va2FzYW4vcmVwb3J0
LmM6NDgyCiBrYXNhbl9yZXBvcnQrMHhkYS8weDExMCBtbS9rYXNhbi9yZXBvcnQuYzo1OTUKIHBy
aW50X2JwZl9pbnNuKzB4MWY3Mi8weDI0ODAga2VybmVsL2JwZi9kaXNhc20uYzozMDIKIGZvcm1h
dF9kaXNhc21fbGluZSBrZXJuZWwvYnBmL2RpYWdub3N0aWNzLmM6NjMzIFtpbmxpbmVdCiBkaWFn
X3ByaW50X2luc25fY29udGV4dCsweDMyZS8weDg4MCBrZXJuZWwvYnBmL2RpYWdub3N0aWNzLmM6
NzgzCiBicGZfZGlhZ19zb3VyY2UrMHg2MTMvMHgxMzAwIGtlcm5lbC9icGYvZGlhZ25vc3RpY3Mu
Yzo4OTYKIGJwZl9kaWFnX3Byb2dyYW1fc3RydWN0dXJlKzB4MWQxLzB4MjYwIGtlcm5lbC9icGYv
ZGlhZ25vc3RpY3MuYzoxMjE1CiBjaGVja19zdWJwcm9ncyBrZXJuZWwvYnBmL3ZlcmlmaWVyLmM6
MzAzOSBbaW5saW5lXQogYnBmX2NoZWNrKzB4NjM1OS8weGFiYTAga2VybmVsL2JwZi92ZXJpZmll
ci5jOjIxMDk3CiBicGZfcHJvZ19sb2FkKzB4ZTliLzB4MjM5MCBrZXJuZWwvYnBmL3N5c2NhbGwu
YzozMTMzCiBfX3N5c19icGYrMHgyNjU4LzB4NWU5MCBrZXJuZWwvYnBmL3N5c2NhbGwuYzo2MzY3
CiBfX2RvX3N5c19icGYga2VybmVsL2JwZi9zeXNjYWxsLmM6NjQ4NiBbaW5saW5lXQogX19zZV9z
eXNfYnBmIGtlcm5lbC9icGYvc3lzY2FsbC5jOjY0ODMgW2lubGluZV0KIF9feDY0X3N5c19icGYr
MHhjOS8weDE2MCBrZXJuZWwvYnBmL3N5c2NhbGwuYzo2NDgzCiBkb19zeXNjYWxsX3g2NCBhcmNo
L3g4Ni9lbnRyeS9zeXNjYWxsXzY0LmM6NjEgW2lubGluZV0KIGRvX3N5c2NhbGxfNjQrMHhkYS8w
eDRiMCBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxsXzY0LmM6ODQKIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDc3LzB4N2YKUklQOiAwMDMzOjB4NDIyODJkCkNvZGU6IDJlIDBmIDFmIDg0
IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQwIDAwIGYzIDBmIDFlIGZhIDQ4IDg5IGY4IDQ4IDg5IGY3
IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRkIDg5IGMyIDRkIDg5IGM4IDRjIDhiIDRjIDI0IDA4IDBmIDA1
IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggYzcgYzEgZjAgZmYgZmYgZmYgZjcgZDgg
NjQgODkgMDEgNDgKUlNQOiAwMDJiOjAwMDA3ZmZjNGNlZGIyNDggRUZMQUdTOiAwMDAwMDIwNiBP
UklHX1JBWDogMDAwMDAwMDAwMDAwMDE0MQpSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAw
MDAwMDAwMDAwMDAxIFJDWDogMDAwMDAwMDAwMDQyMjgyZApSRFg6IDAwMDAwMDAwMDAwMDAwYTgg
UlNJOiAwMDAwN2ZmYzRjZWRiMmMwIFJESTogMDAwMDAwMDAwMDAwMDAwNQpSQlA6IDAwMDA3ZmZj
NGNlZGIyNjAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogMDAwMDAwYTg0Y2VkYzRiOApSMTA6
IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjA2IFIxMjogMDAwMDdmZmM0Y2Vk
YzRiOApSMTM6IDAwMDA3ZmZjNGNlZGM0YzggUjE0OiAwMDAwMDAwMDAwMDAwMDAyIFIxNTogMDAw
MDAwMDAwMDRhZTE2MAogPC9UQVNLPgoKVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0byB0aGUg
dmFyaWFibGU6CiBicGZfbGRzeF9zdHJpbmcrMHgxOC8weDE0MAoKVGhlIGJ1Z2d5IGFkZHJlc3Mg
YmVsb25ncyB0byB0aGUgcGh5c2ljYWwgcGFnZToKcGFnZTogcmVmY291bnQ6MSBtYXBjb3VudDow
IG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZuOjB4Mjg4ZjgKZmxhZ3M6IDB4
MTAwMDAwMDAwMDAyMDAwKHJlc2VydmVkfG5vZGU9MHx6b25lPTEpCnJhdzogMDEwMDAwMDAwMDAw
MjAwMCBmZmZmZWEwMDAwYTIzZTA4IGZmZmZlYTAwMDBhMjNlMDggMDAwMDAwMDAwMDAwMDAwMApy
YXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMWZmZmZmZmZmIDAw
MDAwMDAwMDAwMDAwMDAKcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46IGJhZCBhY2Nlc3MgZGV0
ZWN0ZWQKCk1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFkZHJlc3M6CiBmZmZmZmZmZjk4
YWY4ZDgwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCBmOSBmOSBmOSBmOQog
ZmZmZmZmZmY5OGFmOGUwMDogMDQgZjkgZjkgZjkgZjkgZjkgZjkgZjkgMDQgZjkgZjkgZjkgZjkg
ZjkgZjkgZjkKPmZmZmZmZmZmOThhZjhlODA6IDAzIGY5IGY5IGY5IGY5IGY5IGY5IGY5IDAwIDAw
IDAwIGY5IGY5IGY5IGY5IGY5CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeCiBmZmZmZmZmZjk4YWY4ZjAwOiAwNCBmOSBmOSBmOSBmOSBmOSBmOSBm
OSAwNCBmOSBmOSBmOSBmOSBmOSBmOSBmOQogZmZmZmZmZmY5OGFmOGY4MDogMDMgZjkgZjkgZjkg
ZjkgZjkgZjkgZjkgMDQgZjkgZjkgZjkgZjkgZjkgZjkgZjkKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmhwZXQ6IExvc3Qg
MSBSVEMgaW50ZXJydXB0cwpsb29wNTogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0
byA1MTIKbG9vcDQ6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gNDA5NgpFWFQ0
LWZzIChsb29wNSk6IG1vdW50ZWQgZmlsZXN5c3RlbSAwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0w
MDAwMDAwMDAwMDAgci93IHdpdGhvdXQgam91cm5hbC4gUXVvdGEgbW9kZTogbm9uZS4KRVhUNC1m
cyAobG9vcDQpOiBtb3VudGVkIGZpbGVzeXN0ZW0gMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAw
MDAwMDAwMDAwIHIvdyB3aXRob3V0IGpvdXJuYWwuIFF1b3RhIG1vZGU6IHdyaXRlYmFjay4KRVhU
NC1mcyAobG9vcDQpOiB1bm1vdW50aW5nIGZpbGVzeXN0ZW0gMDAwMDAwMDAtMDAwMC0wMDAwLTAw
MDAtMDAwMDAwMDAwMDAwLgpFWFQ0LWZzIChsb29wNSk6IHVubW91bnRpbmcgZmlsZXN5c3RlbSAw
MDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDAuCgo8PDw8PDw8PDw8PDw8PDwgdGFp
bCByZXBvcnQgPj4+Pj4+Pj4+Pj4+Pj4+Cgo=
--00000000000054f02a0659db05a4--
