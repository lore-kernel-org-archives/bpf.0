Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B723A381C
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065177; cv=pass; b=lWSqxIX3RI8xWH8mdeznivYPviKevgGy7Lj033mVBPMGergI8QBv2ql5oKU9Pxd7DjKmtM4uYHmh80RwOdqu2JB3x0+xsrbjx4k0xbBcfCCvHvEjkZkT9Oz/mOyoyWXklido/usA4ViCTkwzyUNQnDL/qPQKIfr6xZ4EQaZu7YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065177; c=relaxed/simple;
	bh=fsOZnsGEZSlKY8sCMjv0Dj1Z9up+Eh82cxaq4JJbeZM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MQH28MVgnPuJPX65Zg07gOL5rhVdqCG7mkeLPTU9q7GQFH104y5qX9wrAujJJnc7Uw0rYi/Dy4Ua+NVVeQ9YGiyqujw1V5vSVKwx+TPPLE/80FwrnVYC87hjX3cIico0QXR5VIxlgRJLLDdMOdeAnJ98GwDVN6PIvmyR+9VBV3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sG3qiZlY; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG3qiZlY"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b0b7464c99so3073860eaf.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 07:59:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787065175; cv=none;
        d=google.com; s=arc-20260327;
        b=qN1eWWiVrjTkBalJPkQ2NdRXpwFyM/4TdHiHrnRcv2tX2ISZqC6FmHspQVHqTvEAwN
         nmj4ShqFBHgpt9XNKrRckaF9oiuGr4nJum1hXGMLmmfi7MzbMHx7qp+6P/8aPXwnSrPs
         5bTO+rIPfk3T7BOw9AVMeoAJGOIR+h87uq2pVjOKMbTi2XszmqxeAVk5jdBv/NObkitd
         TB+KGmNvjvpLwpG4Uj9jvEmXfUFZTijMNNIWd1P+ASClUyMOccFY6OyYF/kDYq2mqF+q
         KMoJ9nLl9ayxLMHT6BwemnW85GdaUFXjTrbbO2e0BBesYvjqZ7dT/lGNohSrnBg6JjOS
         RHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CugeKmYT87+pqueTbULb8VHDLcK5V5YmQTnDuTF5UaM=;
        fh=34UiwQxnVfWDIG5RezE2n654k/hUlpWv3CTaiWKCn54=;
        b=KxQekeG6DHq+po5GUnUw6hOnBz+ZKXqpgR8AeLYfNmVxnLQQgLW0tkVt7ftzNPBrXw
         zIfgyEreOy2+nEp/nXUmHZhWxomzvHygH+EBo/UsZIiL7TGjjB0lsI+FMSeClC0Vq4bq
         19S6laE0YaylM4S06X2XQZ7IqkCN2rJQ12Wt8oNK0t+9uZ9bm6WqiuXTWPS2SxdZSBo5
         Sxoa3mNA5N22JFEd09ZLLlYj2ZT72X+1xeBWd76YZHgmT8EV3eG0Bj+Xa6R1i1OdDSdA
         aozHxWSKhQc5RxXlNsHTy0PT0Jb6hymZuF1PANXgZs8Z8Af8ikUwThNQLpUw6xTjY6F5
         dt8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065175; x=1787669975; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CugeKmYT87+pqueTbULb8VHDLcK5V5YmQTnDuTF5UaM=;
        b=sG3qiZlYKQwQXTeqNkmbkiDCqouGb2wzzQcuUkMtVHptbmE8kPefhb6ge+xYVkGMvb
         +NCy+hFOGVH+JdoRjiMSxFI3C+a8AxMcRDNombzcAaA7YOvzLZSi+tERkeGf7EymRuxW
         qlFMCh+GKi3s3vJMADLZrJAq8w/1hgCUJoswSVwaIqrmv2vOpxLcpimb9qgOXsa7D3+1
         FuI0Y3pNQNY7SPG0qW8cVuK1vFf1DSCYOx/nzwTadcayJqmrLysHB9MwoGFTooj0w4FN
         SavLDMrZrg8uTACsbhMaYQmir1UT/VHl+hmPpf+j+Il3qoH2L2jpqDiccr0E589r3fe4
         emFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065175; x=1787669975;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CugeKmYT87+pqueTbULb8VHDLcK5V5YmQTnDuTF5UaM=;
        b=n8xvtJA7y2yIcU2MrMUnYCXBvr3JjZ4POaw79eo+a5CrH3rZGqBQmeBG0fz5XE6Fs5
         zRmzZVs+me+DXMpw8Iy26kUm3Uu2wc2aU4WzSAtHqPrpTJyqJKRCmUcgjof1q3OLfX5G
         frV17WgMCm4rNSx7zsgqVZ5EijsiHE9RxNgwBBk/OtqRVITabDzvTThBHKlhC07DhjIW
         3CnE1JXq/ec+TBC5coshlMTS5k/kFY8RIDm2yhnpTnOU/FZneTmrQWS9UCVSRz3RA763
         reEYAq8yqV6XMGG3WoyCQF0Gg5S+fsk1CorYuM2HYShKPND++RSlFB1yK2433IYChcIU
         2fJA==
X-Gm-Message-State: AOJu0YyHWtLadDD4+Rtji0j9PD4aAUDNODc75R4G+V0n4WRiSwaadOA/
	WmPYRZAZ778VyTU+J5TrWmB3eogm2LdLddPckmLFZdb++HXV/CuKVsMFlSJRZGmVZfc2pe1R49f
	nvN6SL1YpbTvFMYlPUkF4kT/NEJj/Y+NEIijm6SA=
X-Gm-Gg: AR+sD13eKPWRqVxjbXJ1D9nlq/OFrZrvQnDMImNzwRIV8FZ25CDpduIGdDUSCtAkWRF
	etztFEFCC4snfmof5e2r2FF5yXphp2/PMCvgXHdEMXH91UdBeNVkHkdFPqYFJI/fo89cni1V/Xj
	KiqoCbqJvh7NJvVwTCDFwYkFoq0O5OeiEfIe/Krny5JmzbrMbPQ6z+pEP4CvOjWPqItIbnTmGfX
	NuCjG0ja/q1PpSPbTW+qUX1Gs1aP+NbINOcmKma+7AwEgJF4/8LIdGtmk7yA/cuLYOHDfCqTi7D
	CkTDK9hV+wTWRH3mq+dwNWjcG/WniCicBQFWI2ilCwN0tw==
X-Received: by 2002:a05:6820:2916:b0:6ae:5250:dd1c with SMTP id
 006d021491bc7-6b0d68f86damr30268817eaf.29.1787065174844; Tue, 18 Aug 2026
 07:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hiker Cl <clhiker365@gmail.com>
Date: Tue, 18 Aug 2026 22:59:21 +0800
X-Gm-Features: AcwNN1VI0TsmYwGC2oossS0Ko3jNmGFX8QCeNVEf9G_D4ufBZsrpxgM0zr4I1-E
Message-ID: <CAGM=xGB1fJ9kT8XTitVo74B0WGqgjkoUHdLwzytwV0AyqeVApw@mail.gmail.com>
Subject: WARNING in reg_bounds_sanity_check - const subreg tnum out of sync
 after ALU64 add
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi BPF maintainers,

I'm reporting a kernel WARNING (verifier internal-invariant violation) I
encountered on the BPF subsystem, reproducible on Linux 7.2.0-rc6
(bpf-next f5b57e9e9) and 7.2.0-rc7 (mainline 15ef2f78c).

### Summary
A 19-instruction SOCKET_FILTER program, loaded by an unprivileged user
(unprivileged_bpf_disabled=0, no CAP_BPF), triggers:

    verifier bug: REG INVARIANTS VIOLATION (alu): const subreg tnum out of
    sync with range bounds
    r64={.base=0x0, .size=0x0} r32={.base=0x0, .size=0xffffffff}
    var_off=(0x0, 0x0)

The 64-bit register and var_off are both precise (const 0), but the 32-bit
subregister range is fully unknown -- an internal inconsistency in
subregister precision tracking. reg_bounds_sanity_check() fires from the
check_alu_op() path after `r0 += r1` (64-bit add of a map_value pointer and
a ktime-derived bounded scalar). The WARNING only fires on the unprivileged
verification path; the privileged path verifies the same program cleanly.

### Steps to Reproduce (raw instruction sequence)
One ARRAY map (key_size=4, value_size=48, max_entries=1); its fd patched
into insn 6-7 as BPF_PSEUDO_MAP_FD:

     0  r0 = bpf_ktime_get_ns()                 /* call 5 */
     1  *(u64 *)(r10 - 16) = r0
     2  r1 = 0
     3  *(u64 *)(r10 - 8) = r1
     4  r2 = r10
     5  r2 += -8
     6-7  r1 = map fd                           /* LD_IMM64 */
     8  r0 = bpf_map_lookup_elem(r1, r2)        /* call 1 */
     9  if r0 == 0 goto +7
    10  r1 = *(u64 *)(r10 - 16)                 /* reload ktime */
    11  r2 = 0x40000000
    12  if r1 > r2 goto +4
    13  if r1 s> 1 goto +3
                                                /* r1 in [1, 0x40000000] */
    14  r0 += r1                                /* (*) WARNING fires here */
    15  r9 = r0
    16  *(u8 *)r0 = r1
    17  r0 = 0
    18  exit

Full bug report (with kernel log) is filed on Bugzilla:

 https://bugzilla.kernel.org/show_bug.cgi?id=221899

### Notes
This message ("const subreg tnum out of sync with range bounds",
const_tnum_range_mismatch_32, check_alu_op) is distinct from the syzbot
report "WARNING in reg_bounds_sanity_check (2)"
(https://syzbot.org/bug?id=8e3413235092cdd148efd146f97ea9960cdd23ca),
whose message is "range bounds violation" and which fires from the
conditional-jump path (reg_set_min_max). Both the 2025-09 fix and the
2026-03 "Simulate branches" series are present in the kernels tested, yet
this path still triggers.

Please let me know if you need more information or if I can help test a
patch
