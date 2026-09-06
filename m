Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757D35CB6E
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788690213; cv=pass; b=mZBjDfwQ04z9N7h0PHE3lgx/wRD2+RQYIckMTVsAi1WZpYPLc2eKJCDo2Hj611CtParuFCNGs73xQ5HXAkzpfsWa+9KtI8J8GSENtLz2FA9lv9KBE6Z5vznX+70zIP8wXL6hFKWtyPvAsfQPstcMY7tOsY2up679juExyBUjQ2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788690213; c=relaxed/simple;
	bh=6AnFaFx+RRG6xn5VAhjSWlruilEz4mlDdeUuHChP+QE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=J1v1CQ0sCYkKIIY4IyMoTe48f0z0eTnJcnx8xU3rHF97ny2sQrWgpkWtnM0XL2ptESUl1WVLEcWeBpIVUTHQfQnpK2JqC62/Xf0mQSF7/TvozgkW2ZY1BqyFAcJ68yNIhZoHlIUe37n+/neff911kaSj5rqqQ3LAE/ISZ5AvjKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtgbCtcv; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtgbCtcv"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-861f30636f9so35907457b3.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 03:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788690211; cv=none;
        d=google.com; s=arc-20260327;
        b=OW1b8IyJWZed4ugTYKj8HXmFFgn6WJ801mwNHYYiUAWeOwx1firIBpmcMaGF+GKTl7
         OiAxPKI3tVQXeXj1jgjFruIjJxEwwt/2H979MAeI+5UeVOO45eF3KmZ4LaTJEr9WRsKr
         fnxfcbIqiOJ0R0YLXAm32hbpHodK5TTCBtbvbbX0fwaAtQslJDUMVFXL8vt3K6NVe8U0
         9B2uVmIziEd1X6Jezr9iUM0fo2UaI12bvB1X1ywfB4i5Z9i7fapaofTC94wmbEoBSHnL
         FfxMN+m8veGkRhwz5tpU+7u2DjqI//r8Oeq/Bx3QpLUsrJmYZURuwdyphQvvNPgSwzAd
         36+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/4camYOqGuil9HIaZckoEDpQVZS54Qg6B0UmN8nRiig=;
        fh=Ww0AmQ3301TALvE40lWYIrQtjpxr71bg5C19sjr/CqY=;
        b=nN/Caqdu3kqU25KUvAPgt1mkNlOSKL4fJ8aqILiu0wki/EJV5xL8jnOeD0G76ys7tX
         Hhaun0RqIrhUSL9iWtQSsRRJJastTQecvMgAouo7eAY0xgsUom5lJFLeMK3AM1fkQJWI
         ThPUte7/0rVSbx83IY24ptmWjcbA/YBs9wZML7tD6wevNjFBHg5na+0jsPwpXGeRJmV9
         xxr1LyN24F4UrLMKvDXtP00y1JqsUCnNgnv1IY1cTvJQQnqxn6g4ugz5Uk/XsEmZD7kP
         KMJZOemk11uLa52hUPVk9/5VT0cvTZeDtHfAOM+mgL0H5qTVApxFBuDquj4dtDXlf8hS
         QpJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788690211; x=1789295011; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4camYOqGuil9HIaZckoEDpQVZS54Qg6B0UmN8nRiig=;
        b=CtgbCtcve/dOP0Wg5IAcx0Mk7dDazJspRIZpY2g7E/h623jHJrYzSaMj4yWr+p/fzq
         mFmKuycrBh8IesmWh/jIyLqe0Qj2dNRHNRMPaSC1n+nxbyBb4/R8GZopfWxbUvf2BLFB
         33fZ5naEiy9vUIZrsPkcfOcNnXGg/KRIaetZV2AXoRyv9MXavZDwp9jNuaecUHcheO0Z
         +shpCVD1dCf0egahq8fwfHxxRTPuQ8yZMjjx0OT425r/6OZN18VHpIMWrMLMt4ofmoZl
         RxaDKVPiAUsO0a8LqUIwiUPjDaJxT7YnEaRrHeuz7PPBZ3BcEu0TH+3zy26P2JAl8EFN
         QQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788690211; x=1789295011;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/4camYOqGuil9HIaZckoEDpQVZS54Qg6B0UmN8nRiig=;
        b=H9XeW0gRNFor5h9nth/nnjk3SsA5HkMuHMUvI7bPsF3ntwaR0cMPQ312U7RfjtLav8
         hKoWnR91epJn5749ZBFewYI7oJYIAPDATtj1KzLRAMxLrQNsNGje3v7M1viYUHq5T4Uy
         y9txLuPb/mrBpzPRGaXAPxQ28Qb/k6YZU9La/NG+BltAJ+bQ5W7cUZsfoANN2aWrL+As
         SmE8TbfMRlw9BjwpGKyyrSZHYDNvFWtU77jr1/0PUZ5XoHTGKmL5EGCDsPzRjhF0JYnS
         cIkNKuVcIEiKMO28IiIQGbHftmc/YIHxBo8Le7r4fpr+sQv/N+RK3p5BcI2CMza/Shjl
         ze3Q==
X-Gm-Message-State: AFuF++kmgWrILEPQITnUzuQmAUAPYF1bRYxwmopNkfqLB1+OXAqrFYtU
	dOVh6U7xpugUn3DnijH1C4HvlbYt6z3cG7B9EEAnHhJtVotrEu8WVhNSQ9rl+GeVaXFkphJy8y3
	/CbiTAXINYxxXlgDAoUFbCGL8K8QmgsQ2g0kD9iVUsA==
X-Gm-Gg: AYBFou2yyOlikxpAAaFUQ3B3Url3H5lnNINQDcd+RQihXFx+OlxeAFVPxMIJdZNNij7
	ndixbtjS6M3i36V1CFQwSJ+sIupHfvh2R6ca5oMOaBWrr0+1pMJRnstDkQWgUbrxplvUeoxCI/g
	iM6FN/+aHI5F58LBYK8Jbf3ahl5rl7YZ8AXlZQKBFLOVeADFg0pzlMKpiD/pogNUJjaUEanio7A
	fawTzQi7WVBw/bEKr4lV1G4BdmVADg5sppsSBMrsghFivRbQiEj8ebmBpUfUSnr+d8yPMGorl51
	6juYkN9z5Uo6r3fzBFu4EF8YAYNizVaqp9PAoXNMDBOtoiwJWT6Ex+8Rq8r/clDgTaqYHQhTom8
	LzwjsJrQ5NV7N2TCioyyEU3UTJwQb4vGrLQ==
X-Received: by 2002:a05:690e:b8d:b0:66f:c7de:e2d2 with SMTP id
 956f58d0204a3-66fc7dee6damr1287904d50.74.1788690211132; Sun, 06 Sep 2026
 03:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mingpei CAO <caomingpei@gmail.com>
Date: Sun, 6 Sep 2026 18:23:20 +0800
X-Gm-Features: AcwNN1WhkYllGO9tuw9BGr9t-W3KwbO_eoEFiqovTw6xPS0HNHx8UutXKL5NoHk
Message-ID: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
Subject: [BUG] libbpf: BTF dedup merges arrays with different element types
To: bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I found a deduplication bug in libbpf's linker. In the recursive identical
type check, libbpf obtains both array descriptors from the first type.
Arrays with the same length but different element types can therefore be
treated as identical. In a valid two-source BPF program, this changed a
CO-RE access from tls_array[0].limit0 to tls_array[0].blob and caused the
verifier to reject.

The two source files and full build and run logs are available on request.

AI assistance was used in preparing this report, I independently reviewed
the source and results.

Affected versions
-----------------

The faulty recursive array comparison was introduced in libbpf v1.6.0. I
verified it in v1.6.0, v1.6.1, v1.6.2, v1.6.3, v1.7.0, current libbpf
master, and current bpf-next as of September 6, 2026. v1.5.1 uses the
earlier two-array comparison and does not contain this root cause. No fixed
release was known at the time of testing.

Trigger conditions
------------------

The reproducer consists of two source files, cu-a.c and cu-b.c. Within each
pipeline, each file is compiled once, producing two compilation units that
are then linked. Both files define struct thread_struct___dedup_probe with
the same name, size, member names, and member offsets.

In cu-a.c, both arrays contain struct wrong_desc, whose only member is the
64-bit field blob. In cu-b.c, the first array also contains wrong_desc,
while the second contains struct desc_struct___dedup_probe, whose first
member is the 16-bit field limit0 followed by padding. Both element records
are exactly eight bytes, so no size adjustment is involved.

The BPF program is defined in cu-b.c and has one CO-RE relocation for:

    thread->tls_array[0].limit0

The first matching array establishes the hypothetical type mapping that
reaches the faulty recursive comparison for the second array.

Root cause
----------

In btf_dedup_identical_types(), the BTF_KIND_ARRAY branch at
src/btf.c:4829-4830 reads t1 twice:

    a1 = btf_array(t1);
    a2 = btf_array(t1);

btf_compat_array(t1, t2) checks common array metadata and the element
count, but intentionally leaves referenced types for the following
recursive checks. Because a1 and a2 both point into t1, their index and
element type IDs are equal, those checks are skipped, and the function
returns true without examining t2's referenced types.

The linker calls btf__dedup() from finalize_btf() in src/linker.c.

Observed results
----------------

I compiled cu-a.c and cu-b.c with clang 18.1.3. For libbpf, each source
file was compiled to one BPF ELF object before linking. For Aya, the same
two source files were compiled to LLVM bitcode before linking with
bpf-linker v0.11.0. I tested both resulting programs in an x86-64 Linux
6.8.12 QEMU guest.

The current libbpf linker collapsed the two outer records into one. The
CO-RE access string remained 0:1:0:0, but its remapped root made that
string describe tls_array[0].blob instead of tls_array[0].limit0. The
matching libbpf loader completed user-space relocation, submitted
BPF_PROG_LOAD, and the verifier rejected the poisoned unresolved CO-RE
relocation with EINVAL. This reproduced with both the BPF JIT enabled and
disabled.

Aya bpf-linker retained both outer records and the intended limit0 access.
The matching Aya loader submitted BPF_PROG_LOAD and the verifier accepted
the program with both the JIT enabled and disabled.

As a causal control, I rebuilt the libbpf linker with only the t1/t2 change
shown below. The same two input objects then retained both outer records
and the limit0 access. The matching libbpf loader accepted the program with
the JIT enabled and disabled.

Impact
------

The confirmed impact is incorrect BTF type identity and CO-RE metadata from
the libbpf linker, causing a valid multi-CU BPF program to be rejected.

Proposed fix
------------

The second array descriptor should be obtained from t2:

    a1 = btf_array(t1);
    a2 = btf_array(t2);

I applied this change to the assessed source and reran the libbpf linker and
loader controls. The output retained both types and the verifier accepted
the program.
