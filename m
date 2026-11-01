Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559939;
	b=5Mv2Vr5RTYse16mov7sZ2I5xy53oAGpn8iPLNCAYBfrkncmStLjICsMAtyyYyYyDWz88
	 ukOvplyK1daaSFSuguiI24i4WubNRVSaiwXVIaUftbekbni3WvJSyf+m2KKD16OBMtsKo
	 pBpUAH9USvufSSAtQOKP9pMBipo/s2tO8kajgaAvqAE8kFCs/MYaHDPf6NsFOZS4L/c/z
	 +oeBEW8G87JbPD2H0/HJhtskNrc/7Jia1cqtsYieNAPWtVm1JnRrC+F1p9ZZiEvUrC4eF
	 dd14B0uUrOL2MMs8udtK5G9EoIop2fB4VwgTUMqQWFi6CmbD3emhl0aJcxSgjE+NCjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aAHMZ8nI+Il8kcq5Xp6Q1kXlDMol4bWQsZUaWcfD+lM=;
	b=FgQv8VpUU85RQ74jybpKbtb/IyoNxRaAZIF2eciF7Hoha1/a0s79yUKsUy6Vi8Tskj0b
	 e+sMollJ0Umy82HAEthdbKWD6oMNpxZXfViNjobIzZ+fxpXT2DAWvXROoeoeklcd/+ONj
	 OfWSjo4wJ0DJ/dZ1y0TQRZeVGUKDzSnXu5OKOasLAo1i6YoYAU5bmmhIcUzIrc8Lqb4HF
	 X1P0rUHnXmkvvUnIGoPxd/izwaygmW7HPgQPa80j3fwpUIGnaHrBayT7cAGIAs4Wbfbm0
	 SEL/ft//MchmvUqxfwItDX2lJ7MGhqAu35+i25NPK77rvSjZg+fhYqVvpRo+FXZN0Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcEfl75l;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A586606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A586606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcEfl75l
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1575891a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559939; x=1794164739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAHMZ8nI+Il8kcq5Xp6Q1kXlDMol4bWQsZUaWcfD+lM=;
        b=vcEfl75ln4PYoC0CVIXPpKCAGCOx+9Lw2b3+RLryEKDVxe4Y5GJd6DQGbmyhNLeGTs
         wMD8WaBTsWS1jF6hwPfQyRbnmRffCEsy19jggNfgXCXY/r1Ey5k9U4b1w7nWi6Cj1D5z
         7hACWByfmeFQxQjHolc1EeSUag3IVbTesDgfXrNfjg6ObIrWtMYmfXFR0buRoZcd8rVZ
         OdDZC0gaBeNvXJFXb6tc3or2XO7XD18T9ranV09wAsLq4f3xgYjVlFRrq52VL8exa0t8
         Hkt2CFGDXs2YnqFEyi3zJ6kDdveCnorS5uFsjUhtIoBjlpC0hmmg+MzaE/nMHAtiqspo
         Blug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559939; x=1794164739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAHMZ8nI+Il8kcq5Xp6Q1kXlDMol4bWQsZUaWcfD+lM=;
        b=FUBCc1odfSHOIhL2sDePkY8pq0sFJqIN1ujDDCefRgBw0rWCRgrtXYuQ0h5dHNtGsY
         6gEiT78f7j0bkHxylz12FH2musBbC68Rz3h2Pw4TSrXjeM/b5yT6WLvCTTgHVtNaSQlR
         YG2caDC27qmIjgwirDqjqiKjbHsPylX/K9Sl2i4yfBWn76j9sTKheXiO1FXsCNTfJ9H+
         s8enx+KEMSd7Yef0Ziak/j4suPH46ONg6C2c1iBpcX+P5pOCLs81wHz9AZDEPXRhjktb
         uuum2Hi37GZJaqvWlAS6n0cPxUW8+9fTIDrSdhe/Yv0XIkgnL5TfcJGlzTMJA3aByc8U
         536A==
X-Gm-Message-State: APuU4Z8vRjSkzt9jL5hv4QdAK9EwV67ja3WaVb8z45jIKhlfD8qp0ib8
	YGmdZdAwU7j5QDV8JlVtKGRh2SsVGHkjX+4PWIYdu6fe4AG0c/NS3xPpww5n1Q==
X-Gm-Gg: AYBFou1CB9f0h4RKmjhcmpmYIfWXStQYdYVGZVyJz7anYnztZx5r33VphiwmdfahwqV
	cFq+FORFxJjvm+csK+9/f5NIWRbuHlkaDYLvh/rh8A39ggaJcUd7r8sA6tEusE99Nrk0UXSkoZH
	s7cl1FBurAVSqglTXRN1vGIZM+zs0GWDfM5m/ZlagvxQmxqmIEg0gsWEdA4D0XKIVeyQSzspzmY
	EHAlfJjJ4nRavXgclnoDgdAVqhjliHdHNXxJfGQrwMt26EKQFP3mmH+pV0h2zeiSXAm+fT9FiEd
	56pJXhZuV996HH/IXM7vv7NIPO58gzvugOCFz3+1jhCu2olW7fgwvpDpFrM6zk3PCr+E3kx6cXu
	0VtwHzeqmuSXNwwRREoD1PiIG8WSJNYXBgSa5+2FWKioMac/id1gMOCk2f/aiyp2c64jZnA7Xja
	Ekidlyo/Tu96uBcwzNs6B+VQd7A5bb2rpp78Rw9KIMNUq8kOGvFf5m1BYhEMP67RgAF9W+1n1gW
	tltOZ9JxbuE+Wby+90urHaWXRmLckHS+NAQBpMgbIQXVP1yGpVxt+mPFA8T9xI1m0OIu/MQ2Y4q
	2B+cD8yZRtT+hZo3ImOK0mN61+P9Mapz4gkWrKGIbO95K5BcB24RbLl/x0rhFqy3TDYYG181mc0
	DRUGO4Kbnh2ijov8el6PBdCP1GYkscMOhld1wu/G4ii+7CG13Kvr586KF0+ZmkZhthT1luKFUQg
	==
X-Received: by 2002:a17:90b:5111:b0:3ab:3384:1a44 with SMTP id 98e67ed59e1d1-3ae897c64b4mr6091759a91.12.1793559938522;
        Sun, 01 Nov 2026 11:05:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae880b1f71sm6264529a91.4.2026.11.01.11.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:05:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 00/27] bpf: Fixes for the verifier, arena, skb and lwt helpers
Date: Sun,  1 Nov 2026 19:05:08 +0000
Message-ID: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

These patches fix bugs in BPF:

  patches  area
  -------  ----------------------------------------------------------------
  01-02    stack traces: the limit of the trace length
  03-07    arena: the range of mmap() and of bpf_arena_free_pages()
  08-12    arguments of kfuncs and of extension progs
  13       cgroup detach: the permission check
  14       cgroup skb progs: the network offset
  15       bpf_skb_adjust_room(): the limit of gso_size
  16-24    lwt and seg6local End.BPF progs: pushed headers, skb->cb, dst
  25-27    skb offsets when a helper adds or removes room

10 of the patches are from Chris Mason and Josef Bacik. Patches 07 and 12
are selftests.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (17):
  bpf: Clamp the trace length before the skip test in stackid_init()
  bpf: Refuse to map an arena at address 0
  bpf: Don't let bpf_arena_free_pages() see a half-set user range
  bpf: Refuse an arena mmap() longer than max_entries pages
  bpf: Remove the WARN from arena_get_unmapped_area()
  selftests/bpf: Test the length and the address of an arena mmap()
  bpf: Don't turn struct arguments of KF_ACQUIRE kfuncs into memory
  bpf: Don't turn kfunc arguments of an empty struct type into memory
  bpf: Compare the arguments of an extension with those of its target
  selftests/bpf: Test the arguments of an extension prog
  bpf: Don't let bpf_skb_adjust_room() raise gso_size to GSO_BY_FRAGS
  bpf: Set a dst for test runs of lwt_in progs
  bpf: Don't look for the SRH again in the End.BPF helpers
  bpf: Don't leave a stale MAC header in bpf_lwt_push_ip_encap()
  bpf: Reset skb->cb after an lwt prog pushes an IP header
  bpf: Require BPF_LWT_REROUTE when an lwt_in prog changes the protocol
  bpf: Don't let lwt_in progs call into IPv6 when it is disabled

Chris Mason (9):
  bpf: Reject memory for kfunc projection type args
  bpf: Require prog fd or capability for cgroup detach
  bpf, cgroup: Keep the skb network offset signed
  bpf: Reject non-IPv6 packets in BPF_LWT_ENCAP_SEG6
  bpf: Limit the SRH length in bpf_lwt_seg6_adjust_srh()
  bpf: Move the MAC header in bpf_lwt_seg6_adjust_srh()
  bpf: Move the transport header with the moved headers
  bpf: Use the inner transport header after a decap
  bpf: Check the offset in bpf_skb_generic_{push,pop}()

Josef Bacik (1):
  bpf: Clamp the trace length in __bpf_get_stack() again

 Documentation/bpf/kfuncs.rst                  |   7 +
 include/linux/bpf.h                           |  10 ++
 include/linux/bpf_verifier.h                  |   8 --
 include/linux/btf.h                           |   1 +
 kernel/bpf/arena.c                            |  16 ++-
 kernel/bpf/btf.c                              |  19 ++-
 kernel/bpf/cgroup.c                           |  26 +++-
 kernel/bpf/stackmap.c                         |  33 +++--
 kernel/bpf/verifier.c                         |  66 ++++++++-
 net/bpf/test_run.c                            |   3 +-
 net/core/filter.c                             | 133 ++++++++++++++----
 net/core/lwt_bpf.c                            |  53 ++++++-
 .../selftests/bpf/prog_tests/arena_mmap.c     |  37 +++++
 .../selftests/bpf/prog_tests/freplace_args.c  |  92 ++++++++++++
 .../selftests/bpf/progs/freplace_args.c       |  53 +++++++
 .../selftests/bpf/progs/freplace_args_tgt.c   |  70 +++++++++
 16 files changed, 564 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_mmap.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/freplace_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_args_tgt.c


base-commit: 5b96632457e4ccae88ecb751cf48176b2e3629a7
-- 
2.55.0

