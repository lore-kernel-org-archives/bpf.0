Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735883822A3
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456889; cv=none; b=t/WdQNnJxC1YeUIFBHhOD6ElUruPYhmyONQbgnacYgxgiTT8zwoNoo7inngWZc8pvCIWdyylF4DBfdSTkltDu++V9JjV4e8x8veWvQHeZj4SSSERDZWkNFwVlVmUrDbBddbTzSyAycZuDcVKbH0WsTR3uu0kfccxg2W8UOqJinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456889; c=relaxed/simple;
	bh=C3YMcu5q0iV0F9ogNXtdf6o7OAyFurI+nZuPGZOtZ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5Sr+U/vkWFNHcgbz27aM8MH7vVuMZMPrns/Lk1Mv/VQzKkfZveBTqo3uZ3EBoS9DbjlSZ9AH0EjEi7mJX/AW0q9pKzRSvtBIJFQPV7K0SVZDrCbBpFWvP2Eyd4nAJjzs7MaITtMDpryOXwDS9aA4Bj8fhOrp0V75SzC4gRVD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwSqAsAN; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwSqAsAN"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so2521196eec.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790456887; x=1791061687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0yzDFvmiZHgGacRea7moAzFfluUEx604kiUr4xKwA8=;
        b=MwSqAsAN5NYI4COdAgv2VsFUBtZleKVNdvddE3b3+Fv7HQWikqYtK4DLvXJRq/qyl/
         ZJ+fRIN37T4kju94BsGFb5XubPXt1TZExV9pV+XUIRm+3+Hy4nrd3Cg5hTBNu0pYCrCw
         Ys+8p7DlQJavzDD3DAtAXvkg6IRQWf6GWO30m24M/55/NrLJuYJXY/jpWZzSSNHMr5pR
         whn0KcpcNPAbYKQbRKT1jfUeHycIiJEw+DWFBEEHNSkVE5iMJ08E0DRklTyR/MHxfR33
         yFRKhO8D3vGPN72EqW/xHpJdAwQLi2kRhSzBUca+1u4cv1H7ZaplfcC+XAjwajAS+nmp
         X/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790456887; x=1791061687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q0yzDFvmiZHgGacRea7moAzFfluUEx604kiUr4xKwA8=;
        b=iHASmUEx1CZbIEBC7F1lwLyANtCBdXCkfXZckuUQyIe5s9+niykiwqGGUp+NcnfXOx
         7m1Xy4nlCz2dLjIJUYbzFUcj5d7aXny/tc2FsC7jOn5h6toK/YZf+cD0h4Sp3D8dnmzA
         j2ABhmLvETirDGgePK+7dyn3QrvQZ4M8Jz3CmhhZF/Jw5nyRpyVghsR6HMcP5wjjfxXL
         IlcAZJQeC0nNRddgW7UFKZMc7/kiZde02tEChO101q9I240nzJMRywVbQhl5vK20lCgO
         nXIgzB1ShZK1wE/KaJEYeNA9aZktI59Vrqx3qNzm4UO56XLOs0NF8ybMFzXDvhKsRGSz
         6UPA==
X-Gm-Message-State: AFq9FYJ4mHEqXwTQJdw5OMl1ZImaMfYbQQ6tAe40StdMIbmnZRFPEa9A
	1xu7IeTlDNMSwoYwM+CZrjq450rb0oS24n9pQ2OQdRO7QyG16zkzfKMvV/T69AhwP0A=
X-Gm-Gg: AYBFou2X2vM8kIv155DMNEH8EZPuVtexvc+rj5KJf5W45/uSUz6X1SApr+LWcU/38B0
	IdALZYOVkzcTz5V/RKbB2K89OIOGFO+r7xMjIZnsEf3+ONbzvuV+QBPh5ugWN+vJ46DcvBmfxB8
	Yznajt6ick7xURSo588dhCMD8DnuiQAHwkA26s8mcTIxvccN7TE1/X8ebj6rDnFR+5jITykAjuU
	gJBwbSXKkDt0nTUM72U2wEfp8Gs2Tu/Pf43JuAv4HhMZ9mfYQ3+9oBq8M4E7kom6lJb9aWoOq2Q
	CfCtKBYsLWa+MF/KQW5rVhwEHE8tm2fyuovT7mT+xgO1gLOD7fkCZ+DWUQxPeoTinpJeGiEYU3J
	8Ix2E7QSuMjkPPvScW0N+I4a3zdp6cPMJ+W+l26EXdMaJQUVZQxOB2QFcZ4WbdGYP0zliYSKPHC
	fcxkaXQmzmdqLDFdjqp0tEnKgtxSL9Wg9sGhURELILMPxaKKL6omvBKelaylrsbys3L8I0fIkzi
	rwoe0WWgf87/BB6XRQOMWC+xdS8rgZjAGqaveH4xCo=
X-Received: by 2002:a05:7300:fa15:b0:33c:fd92:a7c0 with SMTP id 5a478bee46e88-34273848bd2mr4402886eec.39.1790456887407;
        Sat, 26 Sep 2026 14:08:07 -0700 (PDT)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm17886648eec.25.2026.09.26.14.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:08:06 -0700 (PDT)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: ThisSeanZhang <thisseanzhang@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@openwrt.org>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [RFC bpf-next 0/3] bpf: Add PPPoE encap/decap support to bpf_skb_adjust_room
Date: Sat, 26 Sep 2026 17:07:54 -0400
Message-ID: <20260926210757.2152159-1-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds PPPoE session encapsulation and decapsulation support to
bpf_skb_adjust_room(), allowing TC BPF programs to update packet data and
skb metadata consistently.

A TC program can currently insert bytes with bpf_skb_adjust_room() and
fill them with a PPPoE header, but it cannot decapsulate a PPPoE packet or
update skb->protocol and related header metadata consistently. This prevents
packets modified by a TC BPF program from using the PPPoE GSO/GRO path
correctly. The new flags let the helper insert or remove the fixed-size
header and update the skb metadata, while the BPF program fills in the
header bytes and the ethertype on encapsulation and restores the
ethertype on decapsulation.

This series builds on the PPPoE GRO/GSO support merged by commit
55a5d8fca836 ("net: pppoe: implement GRO/GSO support"). That support is
available to packets whose skb metadata identifies them as ETH_P_PPP_SES;
the flags added here make that metadata transition possible from a TC BPF
program.

Examples:

    bpf_skb_adjust_room(skb, PPPOE_SES_HLEN, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_ENCAP_PPPOE);
    bpf_skb_adjust_room(skb, -PPPOE_SES_HLEN, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_DECAP_PPPOE);

Encapsulation changes skb->protocol to ETH_P_PPP_SES. Decapsulation accepts
only packets whose skb->protocol is ETH_P_PPP_SES, reads the PPP protocol
field, and restores ETH_P_IP or ETH_P_IPV6. Both flags require
BPF_ADJ_ROOM_MAC and a fixed eight-byte adjustment.

The selftest covers IPv4 and IPv6 round trips, protocol transitions, and
invalid flag, size, mode, protocol, and truncated-packet cases. The kernel
and the BPF selftests build cleanly with this series. The selftest also
passes in a QEMU/KVM boot of the resulting kernel (11/11 subtests).

Questions for reviewers:

- Is extending bpf_skb_adjust_room() with dedicated PPPoE flags the
  preferred interface?
- Should the helper validate more of the PPPoE header (version, type,
  code, session ID, length)?
- Should the helper update the Ethernet ethertype during encapsulation
  and decapsulation, or should that remain the BPF program's
  responsibility?

ThisSeanZhang (3):
  bpf: Add PPPoE encap support to bpf_skb_adjust_room
  bpf: Add PPPoE decap support to bpf_skb_adjust_room
  selftests/bpf: Add a test for the PPPoE encap/decap adjust_room flags

 include/uapi/linux/bpf.h                      |  21 ++
 net/core/filter.c                             |  85 +++++-
 tools/include/uapi/linux/bpf.h                |  21 ++
 .../selftests/bpf/prog_tests/tc_pppoe.c       | 249 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/tc_pppoe.c  | 159 +++++++++++
 5 files changed, 532 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe.c

-- 
2.47.3

