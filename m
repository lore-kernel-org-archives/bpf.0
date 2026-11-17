Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794945014;
	b=5mHN82CFEqboXyr0oIrzLhxdLQdL8Iom949CbfMYukWe/L+pysjYnfIHbghWWnFfYyaZ
	 UV3KsY1IG+lIzoAah4Km0bhZheZKyCvsB5TxB6VxtMlbUQJtSpmbDdIrEGcRTQqGahnb8
	 IXCgbSAVedelSXUUhl+WJtwZHxYYVK2LklKwSLVc97fs7SE+hVmEu5EOOUrgEuz3ns3wI
	 GPRTdx5Fy7/Zrrt1TXgGuuTFDAJUQa1gaBbS7jj2X9Kwr6Ywd5PXPNk9fta5DXAQaQ0Ju
	 40dZe6UXG5faiEeicl84ZwTgZwiOWEcmkpm1aOP7xsZl8KbVJYQQsmddXtX3hNFkk0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=YJnDVGxHWCga0DMzSISwU7Rjw8JZrBWf9jVM4Nuybjg=;
	b=FikiJcjk+qdZBogf7sajN4ELu/Z7RUOnh9ZzU+rJhDSlMx88ZJtWpF8U1EHNxJtqSHcG
	 bGjd+1iYm2RzDGlMlQsskPAvJdYoy4mbDadOge/2XlkZ0gJl05nTDM+dUiQprLQeQw5Ki
	 UN/DCbknWfCNkM0V/9177uSmXoe2x+qf998IKDeGCRgScKaazwfY8F+n6G8JQye3kxl2M
	 esbJg5ddTJimZxm8tgduaqZ93aSG+54UlpxraQjM/lrxY5gEY9F7N94TnQaQu4x3EKy2L
	 sNw3BDL7EkEFY5RtzuSwN/8fNFMvoCzl/hS9Vn+SR0cDZApUGF0YqOVGygsVEchfVmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=scarletmail.rutgers.edu;
	spf=pass smtp.mailfrom=scarletmail.rutgers.edu;
	dkim=pass header.d=scarletmail.rutgers.edu header.i=@scarletmail.rutgers.edu header.a=rsa-sha256 header.s=google-20180529 header.b=ebdhYfE0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6C606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50B6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scarletmail.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scarletmail.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scarletmail.rutgers.edu header.i=@scarletmail.rutgers.edu header.a=rsa-sha256 header.s=google-20180529 header.b=ebdhYfE0
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-537548b811aso1637181cf.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:50:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794945013; cv=none;
        d=google.com; s=arc-20260327;
        b=ZwczZbkoKOtVM7rnL8/9oRotrnv+0funhPjlWIzy7RVdhqvlp5uZ7LU9x7qO64sntT
         NvtIUyxG6sKFXW/zjMKs8IoJSxqAivu+LfrH76KszSjFzCqOnr0XOlkeTgEeymAydUtF
         bkeLALwm5bwe8dMZ5S1QmII3NYjIjN/kQ78lZaDGslKCEXZvxr676gUOo4Zjp0XlT16o
         OdybHoNh2qzhmJKxk1RCBHx8KJ7TX+3d+SJyBjKplEA5lAv1iAJMsWTD0CKaUOZ6vid0
         j8KQRdBKwq1Yq/KmAmm3XO4+oYRC+Pn9dPiehg2ukiDxin32/QGWG4RSuUAI+I/GD+Yh
         0z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YJnDVGxHWCga0DMzSISwU7Rjw8JZrBWf9jVM4Nuybjg=;
        fh=DVImKLhcKuounm3K9Xgg4J3osERFJhthSzUJqfpBQU4=;
        b=UOp8xEtk4MM603RtBT2bh5Pj+9BeGBbi9K1DcWfggcl/Vetqu2XIG4oniTlbeh0OXk
         rIh5RF4AGPGYyw+uDXTFLw4CyoGv4PPNa7lh8vV2obppP9pzewUSImCIbo5uNZcqzX9b
         AmRKguP1ywbjORFZh9sQNTjyH7DKkPn0pR3AUd/V+p2sITZgbi3mSmBrDim+u5O8iRuU
         MaC+RBjWggHZnRTwLQtWUVFG0k/ygc8lDWGY0zO9pclf8jEHBisRNz7MEUbP0CjKBdru
         FZvOt16q3Q0qGXR4iy5CIf/msOuyLPx8a9/v81fuU1egDj5m67Mtz6FE7U1iMO+qtWZQ
         /5bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scarletmail.rutgers.edu; s=google-20180529; t=1794945013; x=1795549813; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJnDVGxHWCga0DMzSISwU7Rjw8JZrBWf9jVM4Nuybjg=;
        b=ebdhYfE0Alkdl1oplo5e4RFns8w/BMEocQNDYzDyBaTuu6c6hbHi4nSWX+tCR97ks8
         +WwciCQnBh+PUBmZ6ibmYJRUf16pbKh7HkUtNTCX7BHznxUJUAjBldhOndAGhjmFXuEI
         3iShed8HqTAbg2h5MiqjuctgcFUd2vCoq/qU/Un6SHJ+Cw30bEMAHBOtm6dBJOsUKUeb
         +IV1IHhFtaUKa4Fc38eeUzgqGu09guEsmbBMe2fzmazITrV2aQg+y3dX27JSB4UIo1cl
         1dWt5A4ABb4KaLU/XBGMl1zaT55m8TmOIELVZ3m7GzEoqRKbUsbzf4XVh0daiqdWc76X
         5l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945013; x=1795549813;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YJnDVGxHWCga0DMzSISwU7Rjw8JZrBWf9jVM4Nuybjg=;
        b=XKHYQbBW8AYta/VjzfTOskWNRMZqtZ+u26pV0qepmQ0IPAT8j6kTg4Tpi9AFVRZ8xM
         b08BN44fM8YvJy/uUbrAsnb9a1Y0u1fjMVkDdrPlugMN0cNbV4gylcuIYDc8kNwfyury
         h84eb8/0H+1VOkeRicn2z0WipzOgz41v7vhzJcsdSLqj/kmMACKhpjbsmqByHXD7O18p
         KYF/uSVdG+BblFV0+Pappk8PIXi++B8wN2hddxIATVBmpvSvb0jVLHeDZ1pget2aQLBg
         b/imG/Y7uRDsuUbytbRiIYSf3alnKJOAtp2wC/lOxZkOBNdZYUQ6PSUhrhSQ/8nBgXBI
         vGBA==
X-Gm-Message-State: APuU4Z/AnQaqaU3Jwj0HeiBrbHC9RMifB+z8uDGlLg4Yi8/uOs4vIveA
	ih/YO4UPiFtakEXn0KW9/4HTije8m5ykbXUvwPg86L8LzxyVNKES91mFaSL2BuJjHNDbqizJGwD
	8Bk1X0ccHs1SD5/5yOBeTWCY5zhWJne4QdYuGTmlo/q6WQwNtUSpwk866+A==
X-Gm-Gg: AYBFou2djLWUKUhqCZM6APVhVCi0QOm38ofXpC2WdWrCZA8enXerhaET+l7OJ0B3bXn
	xmxTDIEWXZ8pR5ABIMbF2rvs4u8+YRruqNB5hiLFVtMHCajcCxiNupQIh1MTwv2Zp39/U5M33Ay
	r3D/8DdzCJVoXCP8K68KkJ/zBhSIcNlDt7HYbUG4pG2BAsAr4F94MaZSGBGXelEAMsR52BkoFgd
	wUk3HzbYEaHZLs4eYJ5nk/gCyj4/V11vEoFYyhs68Ii/+D6YiicUKkwrZnhctOgLiT+h4IbfkCN
	ZlO00AmObYqx6w+si7FqEbzs/DYJC5U+7U+k2N2otQ2D8NFNLsk63h2UECj0Li43eKIbDQp8X7d
	pwDtvxs1U2RfUeWuKCcLY7w8YlqN/n8FtfvtBNQn9hAdQHSx0oFwc2gvr6ujyhN8XslRBt4o=
X-Received: by 2002:a05:622a:389:b0:55c:cfd:3bd4 with SMTP id
 d75a77b69052e-55d5a6dfadcmr5584161cf.72.1794945012714; Tue, 17 Nov 2026
 11:50:12 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yalu Cai <yc1795@scarletmail.rutgers.edu>
Date: Tue, 17 Nov 2026 14:50:01 -0500
X-Gm-Features: Aa3M54o1WehE7pPO70ZZ7jw_-GD7ppIvrVXgoW7F7c1bxYXFjB-tmWDugLlNfVQ
Message-ID: <CAPUfTJOD==vidMeytY5vo4h2qZPdM=n5CRUtJttZ5N4oD6Fo1A@mail.gmail.com>
Subject: tracing progs can take a bpf_spin_lock in an inner map -> NMI deadlock
To: bpf@vger.kernel.org
Cc: santosh.nagarakatte@cs.rutgers.edu
Content-Type: multipart/mixed; boundary="000000000000e10f7906607e3362"

--000000000000e10f7906607e3362
Content-Type: text/plain; charset="UTF-8"

Hi,

As part of a research project, we have been trying to formally verify
parts of the eBPF verifier. We found a bug that deadlocks the machine.
Below is the concrete description of the bug:

A perf_event program can take a bpf_spin_lock in a map-in-map's inner map,
even though the verifier rejects the same lock in a directly referenced map.
bpf_spin_lock disables IRQs but not NMIs (local_irq_save()). A cycles NMI can
interrupt the lock holder on the same CPU and spin forever.
Reproduced on 7.4-rc3 and bpf-next (ea80d2afd285), x86_64.

check_map_prog_compatibility() rejects a bpf_spin_lock in a tracing program.

if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
if (is_tracing_prog_type(prog_type)) {
verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
return -EINVAL;

This check only sees maps referenced directly by the program. It runs from
__add_used_map() while resolving pseudo_ldimm64 references. The inner map of
an ARRAY_OF_MAPS or HASH_OF_MAPS is not on this path. A lookup through the
outer map gets the inner-map metadata from inner_map_meta, so the check never
examines the inner map. A perf_event program can therefore lock it.

The reproducer has two programs sharing one inner map:

  - hold_lock, SEC("tc"), takes inner0's lock directly in a loop under
    BPF_PROG_TEST_RUN.
  - lock_inner_nmi, SEC("perf_event") on PERF_COUNT_HW_CPU_CYCLES on every
    CPU, reaches the same lock through the ARRAY_OF_MAPS and takes it.

With the lock in a plain array, the perf_event program is rejected. Through
the map-in-map, it is accepted. Either program runs alone, but together
they deadlock the machine.

There is no console output. On a 4-CPU QEMU guest, the monitor shows all four
vCPUs stuck in the same lock path:

__pv_queued_spin_lock_slowpath
__bpf_spin_lock_irqsave
bpf_spin_lock
bpf_prog_...lock_inner_nmi
__perf_event_overflow
perf_event_overflow
handle_pmi_common

It needs a PMU that delivers cycles NMIs (kvm -cpu host here). Loading the
programs requires CAP_BPF and CAP_PERFMON.

The inner-map lock was enabled by b7ff97925b55 ("bpf: Allow locking
bpf_spin_lock in inner map values", 2022), without carrying over the
program-type restriction.

The program-type check needs to cover the inner map when a map-in-map is
used.

Thanks,
Yalu Cai

--000000000000e10f7906607e3362
Content-Type: application/octet-stream; name="prog.c"
Content-Disposition: attachment; filename="prog.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mwl3nzhg0>
X-Attachment-Id: f_mwl3nzhg0

Ly8gQSBwZXJmX2V2ZW50IHByb2dyYW0sIHJ1biBpbiBOTUkgY29udGV4dCwgdGFrZXMgYSBicGZf
c3Bpbl9sb2NrIGluIHRoZQovLyB2YWx1ZSBvZiBhIG1hcCBvZiBtYXBzJyBpbm5lciBtYXAuIGNo
ZWNrX21hcF9wcm9nX2NvbXBhdGliaWxpdHksIHdoaWNoCi8vIHJlZnVzZXMgYSBsb2NrIGluIGEg
dHJhY2luZyBwcm9ncmFtIGJlY2F1c2UgYSB0cmFjaW5nIHByb2dyYW0gaW4gTk1JCi8vIGNvbnRl
eHQgaW50ZXJydXB0aW5nIHRoZSBsb2NrJ3MgaG9sZGVyIGRlYWRsb2NrcywgcnVucyBvbmx5IG9u
IHRoZSBtYXBzIGEKLy8gNjQtYml0IGxvYWQgbmFtZXMsIG5ldmVyIG9uIGFuIGlubmVyIG1hcC4K
Ly8KLy8gaG9sZF9sb2NrLCBhIHRjIHByb2dyYW0sIHRha2VzIHRoZSBzYW1lIGxvY2ssIHdoaWNo
IGl0IG1heTogaXQgbmFtZXMgdGhlCi8vIGlubmVyIG1hcCBkaXJlY3RseS4gUnVuIGJ5IEJQRl9Q
Uk9HX1RFU1RfUlVOLCBpdCBob2xkcyB0aGUgbG9jayBtb3N0IG9mCi8vIHRoZSB0aW1lOyBhIGN5
Y2xlcyBOTUkgb24gaXRzIENQVSBydW5zIGxvY2tfaW5uZXJfbm1pLCB3aGljaCBzcGlucyBvbiB0
aGUKLy8gbG9jayBpdHMgb3duIENQVSBob2xkcywgaW5zaWRlIHRoZSBOTUksIGZvciBnb29kLgoj
aW5jbHVkZSAicG9jLmgiCgpzdHJ1Y3QgdmFsIHsKCXN0cnVjdCBicGZfc3Bpbl9sb2NrIGxvY2s7
CglfX3U2NCBuWzMyXTsKfTsKCnN0cnVjdCBpbm5lciB7CglfX3VpbnQodHlwZSwgQlBGX01BUF9U
WVBFX0FSUkFZKTsKCV9fdWludChtYXhfZW50cmllcywgMSk7CglfX3R5cGUoa2V5LCBfX3UzMik7
CglfX3R5cGUodmFsdWUsIHN0cnVjdCB2YWwpOwp9IGlubmVyMCBTRUMoIi5tYXBzIik7CgpzdHJ1
Y3QgewoJX191aW50KHR5cGUsIEJQRl9NQVBfVFlQRV9BUlJBWV9PRl9NQVBTKTsKCV9fdWludCht
YXhfZW50cmllcywgMSk7CglfX3R5cGUoa2V5LCBfX3UzMik7CglfX2FycmF5KHZhbHVlcywgc3Ry
dWN0IGlubmVyKTsKfSBvdXRlciBTRUMoIi5tYXBzIikgPSB7CgkudmFsdWVzID0geyBbMF0gPSAm
aW5uZXIwIH0sCn07CgpTRUMoInBlcmZfZXZlbnQiKQppbnQgbG9ja19pbm5lcl9ubWkodm9pZCAq
Y3R4KQp7CglfX3UzMiBrID0gMDsKCXZvaWQgKm0gPSBicGZfbWFwX2xvb2t1cF9lbGVtKCZvdXRl
ciwgJmspOwoJc3RydWN0IHZhbCAqdjsKCglpZiAoIW0pCgkJcmV0dXJuIDA7Cgl2ID0gYnBmX21h
cF9sb29rdXBfZWxlbShtLCAmayk7CglpZiAoIXYpCgkJcmV0dXJuIDA7CglicGZfc3Bpbl9sb2Nr
KCZ2LT5sb2NrKTsKCXYtPm5bMF0rKzsKCWJwZl9zcGluX3VubG9jaygmdi0+bG9jayk7CglyZXR1
cm4gMDsKfQoKU0VDKCJ0YyIpCmludCBob2xkX2xvY2soc3RydWN0IF9fc2tfYnVmZiAqc2tiKQp7
CglfX3UzMiBrID0gMDsKCXN0cnVjdCB2YWwgKnYgPSBicGZfbWFwX2xvb2t1cF9lbGVtKCZpbm5l
cjAsICZrKTsKCglpZiAoIXYpCgkJcmV0dXJuIDA7CglicGZfc3Bpbl9sb2NrKCZ2LT5sb2NrKTsK
CS8vIHdpZGVuIHRoZSB0aW1lIHRoZSBsb2NrIGlzIGhlbGQ6IHN0cmFpZ2h0LWxpbmUgc3RvcmVz
LCBubyBjYWxscwojcHJhZ21hIHVucm9sbAoJZm9yIChpbnQgaSA9IDE7IGkgPCAzMjsgaSsrKQoJ
CXYtPm5baV0gKz0gaTsKCWJwZl9zcGluX3VubG9jaygmdi0+bG9jayk7CglyZXR1cm4gMDsKfQo=
--000000000000e10f7906607e3362--
