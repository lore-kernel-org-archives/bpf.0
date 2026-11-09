Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218695;
	b=w0eL/+QG4+YjW0hRuiZJyOBscBtlbTXshamQy4BlAmWfCLsntN0Ut4DKpYiwT5CuspaC
	 zOMSxXGnhUxGTuNt/V47oqKI42hFlNh7sTGF3PxgubBnxCVfzf4jcqbVTqC6Ur/PBFkm2
	 qOybyGzwI8uOS6cMs7UlFcdRar/4fI9ntNE02G4MbPRUjv1pQM+izTNQVrvuxc3fBkdQp
	 lQpGtcKx9CeYMCfuabBrql7wRIgfKrPzc4MLrn3EIiGEwbYtdARIXMdcvqqm/8HRyOtfd
	 5BMVB19AxLsX/bF+aDJGD5ljWTqPRkmDBhHia9yX1DoLy6+QL7bDXpvhU0V7z7eGu9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TwcEd9hq63L/MyMr6mqXIO2VREbB+2vU/8nc1EkdGyQ=;
	b=f+5KBQzltg5u6aNPPOJLClm3Y95Eyjg4QveUN/QtQI/D/YWW2vmuSrFoiRV8ddLg9XUj
	 vn2O/lDCg81O4GuiDeYYE3i6m2U1bQc8lUtOkT9dqGZfepOfm4g7MNPc2vqf/Yfp9IHW5
	 /fvFQacEMt7bS9z0LVbbrPqVBg5TAYNcs+zcAVkrQ7fxJQdcBUyzAODpzMy3C4oV6CcwJ
	 hqmOw9vmGRAvaOaUPgmeYPV+Pdqn849XMQ8mCOdh0kRFnJ1BzpDSvQi32K1RgVX30tB3a
	 4P2dQyxEkwE+bL2fGgzUFEHGcLlDtSFHMFnsPAl6YRMUxYgHSqk9iSW/ZvDtBb0e91A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7Enl3X5;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2A606A323
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 10:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C2A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7Enl3X5
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36f6295304dso775831eec.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 02:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218694; x=1794823494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TwcEd9hq63L/MyMr6mqXIO2VREbB+2vU/8nc1EkdGyQ=;
        b=t7Enl3X5kTALh4nfTW8Scxn/lbAgkhV8oKzFWRGakf0XIa/GEOyRgUQFpOvUefexAv
         bTU5GesXjrWZveB+4bEKyYmX7yp+wGc2F6+KUfV4HB2y/bU9ChmuPuYin4l4nXnyUCBu
         wb27Khg0SutRdG+12L6Ny//p8GUIfUPRwonDqz7OvqrpSfxdDE38PfrExL9T78YiO6a+
         9b31j1+OZZlYQA7DM+lGgapKe1fr8iuR3IYB50CqWgTAcWvE4LY7f+GQOUV/PYpyvsVy
         I/R+vhOcLUkNH/MGya+pAx3fU2H0LrbLPXxoKal+DxSEfAbT3Skp26RVs0RrfMEYuFvc
         DeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218694; x=1794823494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TwcEd9hq63L/MyMr6mqXIO2VREbB+2vU/8nc1EkdGyQ=;
        b=rhrEVrikOP2LgLs3z2eyVhIouuwKF677YLEsHBCCN3oXOgXX/+CvMLHYEOt3cqYJVP
         Lw8UZi2Mb72/WqzJbyVbF7VVuh+mRYETSMVdvpnmuYfod5lmdaFyn3hmp08/gE+wCjNT
         Ksz4/9EglcpONGa+or/B6O9xxXOjASQu6hDgHCeDDBBlT5Iv5oX1PJwDdnQOjCwq7skB
         9eI+rM2NUZn71Sth3b/xJMhCbk4m4Izp8jrgy92HlIeJqTETChR2w6y3RTCdYSFS34Eq
         F1cHoQec95FK/yYbOnf6JnVhcsKM53n7d064NgG86MFkAmDwC/if467ObJuH4Jfp03LQ
         fWrw==
X-Forwarded-Encrypted: i=1; AL+hErH4qBxsFbwk+TmuoQsIIGvWfzbIf50D0Z0z2NrL/K2uFc3pBZS/5icyX0yXDE/5z9t+U6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B2tIK0Dz1NHilMs0DgkM4hEaezIP+H1sgbcMF6Sq7msA1+go4
	n6AjCMV9795YS238C5CURhHd6qopmc+qftSS3ji8YB6NFCAEFDPOhbgn
X-Gm-Gg: AYBFou0Yi3iBKToMg1dF6a+8WX9N/hrpAS9qGyXZmeuVqR0bpLzqN0RLrPQQv2MDhgA
	CIS9rYc1wkz6zK9/dgOnAwd0SXyEXGqCS84RCV0ZNJSfpFT/7TER/3F9feS04W46FM2p8ff8u0b
	rITj5wXRqV4qqljmR5RshSzwenF7j0VM4hwdixgMK0cNEAI8GPDtDEvs8FDrdZbWkWhXYqcUihH
	k1kl8xEQWgzKwRD1IOy63rPoFUtqkM0FUiPwLWaGKEGt3YWVK+4gj7oGbburTYf03+HlB3DLG1k
	U2Rl5gPfYeGzyWenLQwQqHPZWVeaMd1fKSfmBGEq9lm4ChOVwgjTt215vC8ehALTfQjwA+ODpPY
	Ptla8Dul7n/W6ZJMdAGc+TpwJwXfXqtNDoF/WjgjQ55M9Tu6yTOUX5OUxJU4qQgfY4RcxOHHyQi
	G82czaKlegaNByZDK0GX0u4WovWuxbt/YjFshHKfY0IxnXjsvE1RFwXHn/zCmPk6hKSc+SaJR29
	Uo63X+j66x8VAUm9M/lexZCIvPRHNFQysqtpT3pwZsznKqnvSsdEv0otGt6KYkq2lfX7tNQGPvA
	o9eOrsBuoe3KaRqYzes+RBOgj/TDIZsA0pu4ZvMfFonulm8qzlAoR3RjQ9RurG3zSg==
X-Received: by 2002:a05:693c:65d7:b0:361:6884:78b1 with SMTP id 5a478bee46e88-372570dea1fmr6321547eec.28.1794218693919;
        Mon, 09 Nov 2026 02:04:53 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:5a62:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm12886710eec.26.2026.11.09.02.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:04:53 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v5 0/2] gve: fix RX page refcount overflow with the pagecnt bias
Date: Mon,  9 Nov 2026 15:34:35 +0530
Message-ID: <20261109100437.331423-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
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

gve's GQI and DQO-QPL RX paths bias every RX page's refcount to INT_MAX,
so a single get_page() from the stack, e.g. splice() of received data,
overflows it: splice/tee fail with EIO/EFAULT and GQI can reset the
NIC. Patch 2 lowers the bias to USHRT_MAX, as other drivers do.

With the smaller bias the driver gives up its last reference on a page
once every USHRT_MAX handoffs instead of once every INT_MAX, which is
only safe while every consumer holds its reference until the buffer is
recycled. That is not the case for an XDP_REDIRECT from DQO-QPL to an
AF_XDP socket in copy mode, a path the driver never meant to support:
commit d8a8ca14c937 dropped the queue_format check that used to refuse
it. Patch 1 refuses XDP on any queue format the driver advertises no
XDP features for, which today means DQO-QPL, so patch 2 depends on it.
Trees before 6.17 still have the old check, so there patch 2 stands
alone.

Harshitha mentioned on v2 that Google would send a patch blocking XDP
on DQO-QPL; if one is already in flight I'm happy to drop patch 1 in
its favour.

v5:
 - Patch 1: check dev->xdp_features instead of queue_format, and
   reword the subject and message around that (Joshua).
 - Patch 2: name INT_MAX in the subject. No code change.
v4: https://lore.kernel.org/netdev/20261106114551.212675-1-amaan.cheval@gmail.com/
 - Add patch 1/2 blocking XDP on DQO-QPL (Sashiko).
 - Say "overflow" instead of "headroom"; use USHRT_MAX directly instead
   of a macro (Maciej).
 - Say which trees need patch 1, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/

Amaan Cheval (2):
  gve: refuse XDP on queue formats without XDP support
  gve: fix RX page refcount overflow from INT_MAX pagecnt_bias

 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_main.c           |  6 ++++++
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 ++++--------
 drivers/net/ethernet/google/gve/gve_utils.h          |  2 +-
 6 files changed, 18 insertions(+), 16 deletions(-)


base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
-- 
2.47.3

