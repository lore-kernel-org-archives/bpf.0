Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94455179A3
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584635; cv=pass; b=l/+z15FGcsSkRAUqjzOOrk/xVcFu5eQpFD7rJjCk4X1S4lw6KDGyIhRas1z80rrv2iOsBtMcblIh+A+Fjmkq5vsquomH+s8Ziz8VjTEYTiHOIgzhTjauiQMcK3q8PaU/XuEwZTmW5j0Lyw0fJPoL4LkWl/8nAwjKa+78qIhrPlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584635; c=relaxed/simple;
	bh=RnSnamcaI+bj5vuqbp+NPmDqVJvFSlWWUEcwkCegY7U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EQys4Nu9d6F/IhwPNzPPHxDoLGN/kNOGp+zjF6/NpIe5HuNBIkP9qNFtRlu5QCMChMvvbdHG48jEkYJp2sIThDwJgrZ3as0SJl5TuschcZ/PYirqld2nj/P4jI6d88Jm+eNlJMun03IwAKkydgQ2J6q+IpzFh+vrCpPDkUpRDnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD12XrXG; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD12XrXG"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6626b5ace23so779223d50.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786584632; cv=none;
        d=google.com; s=arc-20260327;
        b=YNWwTd+eUpSle2wZRJNNmiWaDERzH6M7yZacaaLp4ScF1kkYV6aPmN5tIDMC6ZrCN0
         KZueaTjdMYfhnYdGeV/1AJ4s0kac5Ynz7EcKsPb5NpLuapgEcQAZUStWqYaFe84GZqo/
         m2fnJH/tWFKqMgS+U661XDZLTzB/ZcxPf4S+eKRe8+ECkWsvL4ChRPfNSmrT0ovbEAf+
         JWDfJweTdk/HIobWi5Vrgd1SUKAtXsT9KOo3/fwqG9aIkwTDwrtR41e9pxztceS4MPq7
         tLhLCxGlDK/yEZaizVKLyGKcqVluYH+3lBLLSLE9BIoXpVfjXnMexlh/yuvtqNZlQOXY
         aT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=O3u+n04R7Rl+yYfS9fbTXmhf7vD//meRN13d/ftSIjk=;
        fh=DpiJV4lj8uuCA8eLc8ufjfXLe7KIFgBH6vu2Lzsc2tU=;
        b=PTXFmANwYu702f436eIzuwJY8LeTm3uzMCyDpRbdsF1ypWm/ut6nv4PHXruAky75uM
         GMjz6F9raVR1bVmBT7j/xGsZGK09qgaeaiZY6sCQngAUIWe/fA5l946koHf6DmeCW/ha
         ElywXCYWzW2UeXi94qQIF77hH1inu5ysvJvXa962yg6PP/8MB+9KExpFEt3h/EbAgYKT
         BkUJyFa82B3Mir8kQSi779jRSgkRzak2615ePzaHTDSGb63NLk3ZvkxiDSDcrVr3iMBP
         p+GglC2VGgxj3jMW4Su9wxZEDkAyBDhRez9XOHgcT/Ez8EwaSUref/Yx0Tpuux1ykKrD
         ChFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786584632; x=1787189432; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3u+n04R7Rl+yYfS9fbTXmhf7vD//meRN13d/ftSIjk=;
        b=AD12XrXGx1W5CeYeXz6DOZK2aIld6ziLnddYEJLiQCtZqabPPjIOiSC9X98WY1r9jd
         /0nsCRFgGpAmpo13csTnIaLoX+onS9LQ9KZktp5gwhUeSD1OPOASq4USCknLbKlZSGIu
         vDLNkrnoUp+AIT6Tj8hVpoi8ZN+Qsa8ejL1yTo2Ixlbp4iuAgEK+LKt9im3r0AfcS/+2
         phYHoTTgIuz5qzG9TSmS3uttMN47PxwiCTZmjSbA11XuT1qfzVz1F1oUVcKe+rVZ8DGX
         PxNnNCVRnTsj/xyHajMXbaIoZkazptabWevgZWkv7vAshkMBGTeAiu9WirfVjuerxdWm
         S+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786584632; x=1787189432;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O3u+n04R7Rl+yYfS9fbTXmhf7vD//meRN13d/ftSIjk=;
        b=pVX876AaCXzkt+DGGpmOiEYQjQcwqWERgzscGavb+0y5lJ/MN1bMuvq1At0Ja2+HAp
         orbOHk+JV0MAm1m3tMJCX8ABq0v6SO/SiJQCJNeVZ9VxtFXDE/6mc4rFYQoxzPrUXFGc
         hpfHRKIbdEl4T4w2VvQbvVDTaORi6iEs/0rjAownhkBLPeuT9NZ4HgKyJEeq0rcR7LK4
         QMp6VosglIqcLk/CHCQp5pncD2AqK5BS/yiAWhqAfxlG3NwRSQN1xvcMJuu40V2g2bQA
         7M6lFHr0dSKNTb2CFIhLFHT9kAPdPEIkbpe9bHGxbFNt1SbArB03zyvmKA2ugGd6B6Jf
         LfZw==
X-Gm-Message-State: AOJu0Yx3RfwzOrgf9HreQV5RHsbM3aQzpF9iLRtoUntpYeQQrZKD/Mus
	vlE8J//K54RpEgPEu0sAuc5wPW3FA+9jKT96eSZuKd382yYSnU7Wbkz/Zvtt/5tfWV/LjFt0lZz
	ARqtddxZQyTcR1n6lNC3Du+bsCnhBbqk=
X-Gm-Gg: AR+sD11YlRTeJhNvIydNBAE0w22TpqWDWGxcXxaPV4FdTLMqLaywWBNwujiU+RRK4on
	C9F1hOnYYVcgyjGkmAMIbeFALwWBZk5RcC0SjxqV8f8cRIbo/WE3wJ2Z0n9etHK8hwJfplNHVU7
	DCD4Sga1lNrXCyJxSEBLxIHJJk9NSAyXlJBT7b/6aEUNEStyR+rMbKLdNAlttE0J1bdg0VLnRSS
	oGFJd3TB+kimFhIRr/rPStXE+DwMQALAyUdCZBL9zo1t4effagvKbF0cKZ4GffF4Oe31391PCKZ
	nmzsjuJ3yRnMhBeY9jQvr9Gc1pe6Q62gy8/n/Rmhuv4CBqFUP599xgtc7sX+lRp8RxfHh0ycG/k
	/mA==
X-Received: by 2002:a05:690e:480d:b0:668:b2a7:a1f1 with SMTP id
 956f58d0204a3-66c55567517mr540957d50.22.1786584632246; Wed, 12 Aug 2026
 18:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mingpei CAO <caomingpei@gmail.com>
Date: Thu, 13 Aug 2026 09:30:20 +0800
X-Gm-Features: AUfX_mx0DrtvWHaGZp0iuXEF0L5CX4DibgAOJDDw99QtYCGnF7Sf6aw8zerga10
Message-ID: <CABzjXVyUkn+_1QNM6WmMeuNUbAcQEUtL=feABs6wWooRs2--5Q@mail.gmail.com>
Subject: [BUG] libbpf: OOB access when relocating a terminal LDIMM64
To: andrii@kernel.org, eddyz87@gmail.com
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Resending as plain text because the previous message was rejected
by the bpf mailing list due to an HTML MIME part.

I found an out-of-bounds access in libbpf's CO-RE relocation handling. A
malformed BPF ELF object can place the first half of an LDIMM64 instruction
in the program's final instruction slot and direct a CO-RE relocation to
it. libbpf validates the relocation's starting instruction index, but does
not verify that the required second LDIMM64 slot exists before accessing
insn[1].

The affected path is:
    bpf_object__relocate_core() -> bpf_core_patch_insn()
This affects both normal relocation and relocation poisoning.

AI assistance was used in preparing this report. I independently reviewed
the source, traced the affected versions, and reproduced both the
out-of-bounds read and write with AddressSanitizer. Reproducer files are
available on request.

Affected versions
-----------------

The poisoning write is present starting in libbpf v0.2. The normal
out-of-bounds read is present starting in v0.5, and both remain present
through v1.7.0 and current master:
    f7081a6baf3f54949aacb8c2fc11bb30783b83e9
Commit f81dbd3475c4 removed the previous check for:
    insn_idx + 1 >= prog->insns_cnt
which made the normal LDIMM64 relocation path susceptible to the
out-of-bounds read.
Thus, the normal read path is affected from v0.5 onward, while the
poisoning write path predates it.

Related public discussion
-------------------------

I found a related 2021 fix:
https://lore.kernel.org/bpf/20211025224531.1088894-2-andrii@kernel.org/
That change corrected the CO-RE relocation index check from '>' to '>=',
but it validates only the first instruction slot. It does not reject a
terminal LDIMM64 instruction whose required second slot is missing.

I therefore do not believe this issue is a duplicate.

Trigger conditions
------------------

A malformed BPF ELF object must contain a program whose final eight-byte
instruction slot starts an LDIMM64 instruction but has no second slot. A
.BTF.ext CO-RE relocation must target that instruction.
The invalid access occurs during user-space relocation, before the
malformed program reaches the kernel.

Root cause
----------

bpf_object__init_prog() allocates exactly the size of the instruction
section at src/libbpf.c:892.

bpf_object__relocate_core() validates only:
    if (insn_idx >= prog->insns_cnt)
        return -EINVAL;
It then passes:
    &prog->insns[insn_idx]
to bpf_core_patch_insn().

For LDIMM64, the normal relocation path reads insn[1] at
src/relo_core.c:1136 and may write insn[1].imm at line 1153.

The poisoning path passes insn + 1 to bpf_core_poison_insn() at
src/relo_core.c:1056, which writes through that pointer at line 991.

Neither path verifies that:
    insn_idx + 1 < prog->insns_cnt

Observed results
----------------

Using GCC 13 and ASan on current libbpf in an Ubuntu 24.04 ARM64
container, with an exact 64-byte instruction allocation, the normal
relocation input produced:

    ERROR: AddressSanitizer: heap-buffer-overflow
    READ of size 4
        #0 bpf_core_patch_insn src/relo_core.c:1136
        #1 bpf_object__relocate_core src/libbpf.c:6178
    0 bytes after 64-byte region
    allocated by bpf_object__init_prog src/libbpf.c:892

The relocation-poisoning input produced:

    ERROR: AddressSanitizer: heap-buffer-overflow
    WRITE of size 1
        #0 bpf_core_poison_insn src/relo_core.c:991
        #1 bpf_core_patch_insn src/relo_core.c:1056
        #2 bpf_object__relocate_core src/libbpf.c:6178
    0 bytes after 64-byte region
    allocated by bpf_object__init_prog src/libbpf.c:892

As controls, current cilium/ebpf rejects the normal relocation input with:
    64bit immediate is missing second half
while current Aya returns:
    InvalidInstructionIndex

Impact
------

The confirmed impact is a heap out-of-bounds read on the normal relocation
path and a heap out-of-bounds write on the poisoning path.

ASan aborts on the first invalid access. I have not demonstrated
exploitation in a production build, memory disclosure, code execution,
privilege escalation, or kernel compromise.

Proposed fix
------------

Reject an LDIMM64 instruction when its second slot lies outside the
program, for example:

    if (is_ldimm64_insn(insn) &&
        insn_idx + 1 >= prog->insns_cnt)
        return -EINVAL;

The check should cover both normal relocation and relocation poisoning.

I applied this guard to the assessed commit and reran both ASan
reproducers. Both completed without sanitizer findings.

A regression test should cover both malformed inputs, together with a
valid two-slot LDIMM64 control.

I can provide the ELF files, full ASan logs, or help test an upstream
patch.

Regards,
Mingpei
