Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3D1C84DC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737651; cv=pass; b=Ada/C298Jn8VWnCO6cqjuuarIaEG23FKpxTzDbRezK3HOluYFGeepqJC+jqDbrIEe7tjedUjwBleNxJXzIpPoQwOMA9vUu/Pq9C6EK2ElhA+0E1oZDncHabthncbH85kzlZQy2Ly0i88iaKErVHY5cQ/cKbQym5hnjZPbAcyLKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737651; c=relaxed/simple;
	bh=lsebBxpvUgFttOTxnjqeVX2+aNCYusf/Ez/77qdhDTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqjvWq9P4H12b0Z13/aMsCcYvi6qxAdb6GtSorOnA38hsdAyBN8vgaVNSWIkT/Iz7bgHYsBTE01rrmgkBA0DcNBk8WsAlyDyn5QSy3ScpSwLoHvEm5Uie/vJnFFMhRvye8JSGyC5fFIFzvqFLjIqm0F4ffgA6Cg9+foCqj6dPAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz4v4FAN; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz4v4FAN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso909804a12.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786737649; cv=none;
        d=google.com; s=arc-20260327;
        b=D5OWlOvKN5XI1kwY46QcbrLYwmCWW5C5YDqrJ2JCmbzhVIU4aDm7Er+OSgksJh2bbG
         XkUl3J+iI+haxuqHafhxN0Z6yScPfkktrT1loy1uBVUVFylZ0RDG0PweJp8ng3YjxSBC
         7mowNs5DImMiexFx/jzM3ALPiJJpf/gIpWwkmuA1PjvB4EiDvGdg+ZFbBNMslmvAX9/C
         Hg0X6+TfQxKX6F65ljLHanYjBb7GhXZtghWhuBuHTuIhB65NMo+7+cqt/peZin9uHMWL
         7jnD/FpvHtXWKMVvrVhI5Ed0RAvUygS6et4Tm/IyX/Gw767zLf+F/cTUo4auB/OG5Uo5
         S7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2d+7bkpxKcv0Hxq3gXCJMqN/ocbqGnEaJMieCwQwEII=;
        fh=12rjHB7tsp01as5hjioLYZaBh167RtzDU5IuRoWZc0Q=;
        b=W08a1wsQM9zQIwNql9U5Fqcls3lMgtb1W9bKCld38h+caf+7jtwJhdJZc/mCumxZx8
         kb+SxLhaKSWuIOGF2gCXWpJHCKRC3kvI8Mr5bHYbgbWm/S6n+muIg24nk3XOs0DW1vOV
         CU+fn/u3pYU3mST+r0u+d20nAwDw0qPDO2NpxirmOdqUYETCvRrGS4s4Z6Jdkwk8DKFG
         pwK5T33gPU2cUKccMZsSkgJrDAQaJ2qhIVYu3t3P0pVBveM5ML3PLD8z2+4G3PQiZ6eM
         A+Zw/21u4UOpTYlrD71tDO95aKMGXyTTlH8sEPguErJR8GXcZ/wa2MV4YxuxcvGVckjm
         +spQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786737649; x=1787342449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2d+7bkpxKcv0Hxq3gXCJMqN/ocbqGnEaJMieCwQwEII=;
        b=lz4v4FANdhkhBXOOceggV+bBdiqZf66BZ8FpsJ4LSQb0xYIGS1yDLpatZMPSMeF4of
         AJ3MmiKf+g2XJrCZwbMm09B4zYVo4JL83cDknSibL5Fk7vSkVAja93uQQcEMHqRdiIAq
         zpFSq9TRUmGLeWzgGz57LrlJhSzTps/RGkaDylCbV+JJB99Wwouy9uEVQ6LK+RC82WZ5
         BiRwOA46NgcZdpB6dlhxiVga23Nq8V4hE8v1z+vlIsS1F8oW8HdqzTG3sSxzVq/0fPHS
         L1yA8rZ2krZwofPaeD/HiK/y2c4x/8MuhXDH2tFCuYsvWCA34gnxskKvp7KvfLBTqdez
         QHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786737649; x=1787342449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2d+7bkpxKcv0Hxq3gXCJMqN/ocbqGnEaJMieCwQwEII=;
        b=ct4vt7O4JEG1Cbzhn21MhvB0FSugVf9JHY9ZvY9gZRv6SQV7HPysbZwv11+K+b44DM
         Lf36+xJYKrIC6gCs4HYrLQF24ENDNtJlFaTy1dKRRspKxeeW7Rwh6Xcj90UsSGWge2sM
         l70sgwXquFEokSB6Lsd9GqzjVleeTTqG1vT0ISCVAMziBgP0+K/7VCNnmN8Hw68Jc+7X
         pQevm5Q0So9GaMxA0Acg9eE7Hx3j3Vywh4JYIAsebmQq43roWDlqpKcEkDjopehk84oh
         zQH7L/fO+ixsEzjD9dHAWzQx9Ob4SVi+R0dQPST77GmeD/9NntTSJAmEz8BkZDvBlNVW
         3wLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNeXo4T+a25b2GJDfCiVUlh/dP/FnAfSqkFvnBRZuwIyX10N8zbSkX0GClNafDzjNlQX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsz4/bIbbFY8mV7p4AQSaP3GMnrO9RCAuqEjl30vJhZhj4Gy4z
	h5WpmDmVlaxSbtmFo4ctracYLZHBxuIEEz4UdFDE6fJGawL6R+c7j33wwn5iG8xAtLdgXPoEpTG
	IxctFJkSpeysgBlZUXxFvoOEPrY+fGhE=
X-Gm-Gg: AR+sD10zmPazKGssUR84iQK5LPfrEirrquj0an1CFajeJ2v2Mf2zJaVI29w0hVPk2MD
	xxDh156yY/wJZPxAUyrOnZr05LA2ip+R5F9DABJzsqlko5LSHs6buraXhMSIGq7YA+KqAWX57zf
	1rIyVlNWnTUApophbxB1osErDhMkAuoXIzaMcujek47MS58n3drrWKatTV33dDbBug7pXDkcrsP
	4ReJp8LXuU0qr1R00hj5V1E7W/1WpPIXgQiIWs3OKtwrCQ72+6BpVw7+bHS/8IWQSoq9FkCiT7j
	kbdCXSUyVkx6bV931j17JhSZvVzv25sVwPmeC2LdkM+nDHN9EVtN5MSoKupOWwuZKa5pSwLZWgi
	Mjh10YrfiviFQuhxYH6bziNd9JQ==
X-Received: by 2002:a05:6a00:6c81:b0:847:439b:ae30 with SMTP id
 d2e1a72fcca58-84fde521e91mr9662650b3a.20.1786737649012; Fri, 14 Aug 2026
 13:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABzjXVyUkn+_1QNM6WmMeuNUbAcQEUtL=feABs6wWooRs2--5Q@mail.gmail.com>
In-Reply-To: <CABzjXVyUkn+_1QNM6WmMeuNUbAcQEUtL=feABs6wWooRs2--5Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 13:00:34 -0700
X-Gm-Features: AUfX_mxy0jYDYJhLRoWehMJ1Qwe5QS7IrPHgM4gHLq1tvKcMowuW1h6xNkAh5FE
Message-ID: <CAEf4BzaeSBQAY9G9L7FbCQBZJs9M9921pbBvuz=O7d52ZxUMcg@mail.gmail.com>
Subject: Re: [BUG] libbpf: OOB access when relocating a terminal LDIMM64
To: Mingpei CAO <caomingpei@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 6:30=E2=80=AFPM Mingpei CAO <caomingpei@gmail.com> =
wrote:
>
> Hello,
>
> Resending as plain text because the previous message was rejected
> by the bpf mailing list due to an HTML MIME part.
>
> I found an out-of-bounds access in libbpf's CO-RE relocation handling. A
> malformed BPF ELF object can place the first half of an LDIMM64 instructi=
on

libbpf doesn't try to protect against maliciously modified BPF ELF
files. You are not supposed to use untrusted ELF files to load BPF
programs into the kernel, which is a hugely privileged operation and
shouldn't be taken lightly.

> in the program's final instruction slot and direct a CO-RE relocation to
> it. libbpf validates the relocation's starting instruction index, but doe=
s
> not verify that the required second LDIMM64 slot exists before accessing
> insn[1].
>
> The affected path is:
>     bpf_object__relocate_core() -> bpf_core_patch_insn()
> This affects both normal relocation and relocation poisoning.
>
> AI assistance was used in preparing this report. I independently reviewed
> the source, traced the affected versions, and reproduced both the
> out-of-bounds read and write with AddressSanitizer. Reproducer files are
> available on request.
>
> Affected versions
> -----------------
>
> The poisoning write is present starting in libbpf v0.2. The normal
> out-of-bounds read is present starting in v0.5, and both remain present
> through v1.7.0 and current master:
>     f7081a6baf3f54949aacb8c2fc11bb30783b83e9
> Commit f81dbd3475c4 removed the previous check for:
>     insn_idx + 1 >=3D prog->insns_cnt
> which made the normal LDIMM64 relocation path susceptible to the
> out-of-bounds read.
> Thus, the normal read path is affected from v0.5 onward, while the
> poisoning write path predates it.
>
> Related public discussion
> -------------------------
>
> I found a related 2021 fix:
> https://lore.kernel.org/bpf/20211025224531.1088894-2-andrii@kernel.org/
> That change corrected the CO-RE relocation index check from '>' to '>=3D'=
,
> but it validates only the first instruction slot. It does not reject a
> terminal LDIMM64 instruction whose required second slot is missing.
>
> I therefore do not believe this issue is a duplicate.
>
> Trigger conditions
> ------------------
>
> A malformed BPF ELF object must contain a program whose final eight-byte
> instruction slot starts an LDIMM64 instruction but has no second slot. A
> .BTF.ext CO-RE relocation must target that instruction.
> The invalid access occurs during user-space relocation, before the
> malformed program reaches the kernel.
>
> Root cause
> ----------
>
> bpf_object__init_prog() allocates exactly the size of the instruction
> section at src/libbpf.c:892.
>
> bpf_object__relocate_core() validates only:
>     if (insn_idx >=3D prog->insns_cnt)
>         return -EINVAL;
> It then passes:
>     &prog->insns[insn_idx]
> to bpf_core_patch_insn().
>
> For LDIMM64, the normal relocation path reads insn[1] at
> src/relo_core.c:1136 and may write insn[1].imm at line 1153.
>
> The poisoning path passes insn + 1 to bpf_core_poison_insn() at
> src/relo_core.c:1056, which writes through that pointer at line 991.
>
> Neither path verifies that:
>     insn_idx + 1 < prog->insns_cnt
>
> Observed results
> ----------------
>
> Using GCC 13 and ASan on current libbpf in an Ubuntu 24.04 ARM64
> container, with an exact 64-byte instruction allocation, the normal
> relocation input produced:
>
>     ERROR: AddressSanitizer: heap-buffer-overflow
>     READ of size 4
>         #0 bpf_core_patch_insn src/relo_core.c:1136
>         #1 bpf_object__relocate_core src/libbpf.c:6178
>     0 bytes after 64-byte region
>     allocated by bpf_object__init_prog src/libbpf.c:892
>
> The relocation-poisoning input produced:
>
>     ERROR: AddressSanitizer: heap-buffer-overflow
>     WRITE of size 1
>         #0 bpf_core_poison_insn src/relo_core.c:991
>         #1 bpf_core_patch_insn src/relo_core.c:1056
>         #2 bpf_object__relocate_core src/libbpf.c:6178
>     0 bytes after 64-byte region
>     allocated by bpf_object__init_prog src/libbpf.c:892
>
> As controls, current cilium/ebpf rejects the normal relocation input with=
:
>     64bit immediate is missing second half
> while current Aya returns:
>     InvalidInstructionIndex
>
> Impact
> ------
>
> The confirmed impact is a heap out-of-bounds read on the normal relocatio=
n
> path and a heap out-of-bounds write on the poisoning path.
>
> ASan aborts on the first invalid access. I have not demonstrated
> exploitation in a production build, memory disclosure, code execution,
> privilege escalation, or kernel compromise.
>
> Proposed fix
> ------------
>
> Reject an LDIMM64 instruction when its second slot lies outside the
> program, for example:
>
>     if (is_ldimm64_insn(insn) &&
>         insn_idx + 1 >=3D prog->insns_cnt)
>         return -EINVAL;
>
> The check should cover both normal relocation and relocation poisoning.
>
> I applied this guard to the assessed commit and reran both ASan
> reproducers. Both completed without sanitizer findings.
>
> A regression test should cover both malformed inputs, together with a
> valid two-slot LDIMM64 control.
>
> I can provide the ELF files, full ASan logs, or help test an upstream
> patch.
>
> Regards,
> Mingpei
>
