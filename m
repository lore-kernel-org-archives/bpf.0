Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032166;
	b=oa0Ga3uoXre9y4Hu4HNnqsqIcz+XezaoDNgAmw6XiwgYjnkVOUmpfBETOVqcy4kYeghS
	 QNdvRDsVL4d6PmTShoc3shc4rXEZczSWL3qU3qykv4qRNqLB+oUCbEiWN9uK3yCvUabEs
	 hIdhNvVWcSh/zgzcV/Gf5+p0lytEIYHO4MbHxdae+E3HYHz2yswkfgbevcrV1kqwu4bRa
	 zX1Hkov1j/URxW/lMuv5m8LcnlZKRdp68WgdmZ50OnLDvNSLLVFf4KHAEGhCBPTlruqTr
	 WpGvcu3w2zkD7XqWv+D8IkjeZQAseExiBhEMeya3YGt13f4289WxqZQEiD1lBZm6E+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GdsDtNMuAKchgTKFVPQmSqRchOy9Cu80YvZfOAk+T+4=;
	b=GkJrHVsC4ih9ayvZnXjvyR9fVeVvGyFqNc/qSAZZ2Xuf6rCHNzr0cH3UE3bGIoPqpBaj
	 0bt9Co/jyzXfltL4Qwzb3A1SaxJaIQHdXv/27ietEtl3OwHQ5odqGa5pzEih7XWiIJkzm
	 0+83dOCIsLexEHmRwyxOtFNSA/p+N16hbBVmjFQRzmyHrFGHgr9LD7t59rvxvE586NQ7O
	 /ZIFF+WL0BulYhODWoTENEAVeKKa3Knca1W3rG9k4pHbg8tld1ZBj/1UxvUxA9sBvIrx4
	 daJw7rtcGn/ylYcaLMzhhcaJGIvfH1a939vz+ewJMn2CeI/12ztB0aEZ2L9+qHr6H5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s88r1f7r;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217B606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3217B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s88r1f7r
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so6324737eec.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793032165; x=1793636965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdsDtNMuAKchgTKFVPQmSqRchOy9Cu80YvZfOAk+T+4=;
        b=s88r1f7rBacXuje4OuI2O9BejlXwi39wsHSRSfqEXG6vDmeOBrNik+u18CpdbNpIjp
         LZeu8HDwQYSWjebKxy9MC1XVK5Jm0Dpp+Zz4ba8as7S66CyLnNAirt0ZAebK0YcT3jmQ
         4t7fgSo2uA4CIhF71ZiK3rp8v9iOuKlxG8a2Pqlxjk2J4/UEy0lOzrKbw1nWGNlrSNR8
         aY99L5mt8Tp+Sfeju/KLz4VU7TnYlGm6CXSWNCFLfgp4H97m9LF45zdwGDmdrZHGECEg
         xoAdGYqCRltg+i9cSz/xZ3G/daPGBryUPdhot2tMxAbTsVihBr1suYom5FXE6IYBvtT+
         n5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032165; x=1793636965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdsDtNMuAKchgTKFVPQmSqRchOy9Cu80YvZfOAk+T+4=;
        b=I1S7sh15lQGDPxl818R8xnlryCZcYvQLKZNSHaHJLVHwXDL1VJxhyeA9wVRRGE/PTg
         ut6SrfS5eUmEeWwwU1xHwpSLIfd9/xeFbcJ6WdsqVQ98gBRAyNNgt1CxAoQcoLBAI2Zh
         /R2kTEx0cRNxb0REalMyfKM9kxAc/yqtDem3E4kErSAnjdaCpB+lG10ly/Vmt1yKUIzN
         0zukBsfdduM0UBKrOqCwyMNhTWrv0v9mqKRg/7ESo5/9vIkNvotpH4dGd53q9msECbji
         MApkjkl+XTbUDfQX9dvMuRKaadd1xWsE49DliGsZ2TyqSr6/WvVWZ/XPUJ6p1ej6eVf7
         Xp4g==
X-Gm-Message-State: AFq9FYLGzdD7Vjj9QO6hK1UVQXE1dVaqt1BG6pvVuukA8hwHMBj+2O0w
	dNBshgA0rVLp6VH7HeFZPTRP+sl2G4jg2VuMRuhftVgF2JLIWzuK0qLt7MedbXZ2
X-Gm-Gg: AYBFou0aCxyCDF6bR83D19QAkNRUnI1yLkAVIFNwFxnj3LsZ2KSJav2aPhk7Xhte0TR
	rOL6KP3Qp64MOCS9IodHwv6TYSzF2bClVptDnLIiFwmkR1Tn6d3fwbaXKN9DMx2d5V/WGpM28Sz
	eVHZZJ94/e+fzXfAGDVfQJpBY5v4d94Di6iRPtii2r+7OaRnBcv2+yceTSQ5GVqgfmfQfcrra1B
	tdnA5yN+1drdZA8bfuIzgDKEpES0DKR1dteBcTDATJ6/1QusYtmNDgNf6NFZsKsFntoX5WvU2DZ
	kYTagI4ItRbYZhgVd/eFEUXXCAXHOgdKC61OaNMucK7Q98GHRTvQk/W620injL/sffh3qUpXUQ8
	aNtGcICAr0blogtSSLXCGi8kCnf9Y3OiVEqlbVrCTLTWpCAfsH1WRoeW7ODSMmUmPk9JdejpDq/
	nTL3chzKa9yTVBsohio7M0HY/maKn3amUGkWB6D2Z/bau6oUwlTBcCfPFdWQYyzWaCoqTJ8dpQN
	+P08O4o90ivS+UlrlowE4oL54dSIQyU1o8Q+BIRB7+DeZatBZFt9kvzflININXuuq8ZmMBWw9Sx
	Fit5Hn1E3xjc6aMKEqLjJecMRQtrg+pdT4hijeIUe9Cg9zywf5DdS/cEQxQASV0Y3HmrKe+IEVw
	=
X-Received: by 2002:a05:7300:8817:b0:369:9062:c392 with SMTP id 5a478bee46e88-369e8622976mr11796578eec.37.1793032164938;
        Mon, 26 Oct 2026 09:29:24 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:f859:3f74:c064:3281])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm36119014eec.19.2026.10.26.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:29:24 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf: Fix overlapping copies in bpf_dynptr_copy()
Date: Mon, 26 Oct 2026 21:58:07 +0530
Message-ID: <20261026162810.12862-1-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
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

bpf_dynptr_copy() can corrupt data when both ranges are in the same xdp
packet and overlap: a slice of one range is used as the buffer for
__bpf_dynptr_read() or __bpf_dynptr_write(), and the chunk loop always
copies forward.

Patch 1 does not use a slice as the buffer for a copy within one packet
and copies from the end when the destination is above the source.
Patch 2 adds selftests. They pass with the fix.

Changes in v2:
- Dropped the bpf_xdp_copy_buf() change and fixed everything in
  bpf_dynptr_copy(), as suggested by Alexei
- Reworked the tests into bpf_dynptr_copy() tests where only one of the
  ranges crosses into frag0

v1: https://lore.kernel.org/bpf/20261024092659.76422-1-ayushmanrout27@gmail.com/

Ayushman Rout (2):
  bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet
  selftests/bpf: Test overlapping dynptr copies on xdp frags

 kernel/bpf/helpers.c                          | 16 +++-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  3 +
 .../selftests/bpf/progs/dynptr_success.c      | 90 +++++++++++++++++++
 3 files changed, 105 insertions(+), 4 deletions(-)

-- 
2.54.0

