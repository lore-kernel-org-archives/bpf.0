Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B136A35B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471486; cv=none; b=bnBEjV2t3dGX2ssnK94yA5xfNZuFT2CLYozehGTvGiniL0JULskpOmcTTd9Oet4stivXct51W5FzfPnRlNPe9yJUdNL65ouA416xHJASYgPnHzuFIvv3vmOFSXs/P91x5fFMMwDM1b+hRhJa6a02R2O/x6YLpn/dSvqL5RIsp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471486; c=relaxed/simple;
	bh=Wx19ZE2zP3gFp9WiYMlSru9Iwp2aXn8g74oL7BLzqjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=daB8aUazdKmWknvzuAcoT0EDxPtRpMz9ee5qi3W92QBX+Tj/xkDU53a27GSD10Gw7EHfhw01kQ1K+IjVcJ4owA0ZjyllNPliF23B64kkCGIp6y1NGeZFXR3NuRnld88G9hAOxWnWYpZpQqNknrjPO40VZ+ZPPGzhREK0xMdzvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkcTJLAC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkcTJLAC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso124693a91.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 17:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783471485; x=1784076285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uF1z0i2mWzwSAJJ9hzgV5t32xzkuToRsVsiUns1u7Jc=;
        b=FkcTJLACkxdKmGN6STud+FM9zFBx1cn/1vriZSqAi9rEaxV7qEaOv4dypbDDpvMJAl
         j6oryB54mhQjYGYDo032snioQao7KCI2wWM8va650CpsWZttP2+Y8KGHYiXWF1xR0il1
         ssXWL5NO9R6eSzP2irF3Oz/tHZP3VJwe16XzCDb/Dq1JP0VycVQeRM2Cwk2g2TizGXC3
         tf5VX+Wmb7744uTGP5WzgRd+qmTFK/cpFmsTx6gQoe6mvdsDZX0dit/hw2WUXcr2Dknr
         7HUSYB1dTNFBkQYZpDSprENhhTdpIj64Irm8DcHAVz55Olbsck7hbkC1JwRmXTDme8NI
         qrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783471485; x=1784076285;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uF1z0i2mWzwSAJJ9hzgV5t32xzkuToRsVsiUns1u7Jc=;
        b=oT+cjLwpbA5GBLzdXzV0z/Sg7t+fCGtuhZRM/CsJjbhWD4TAGFdEgc3Xn38b0n1wFM
         SxSoCTyewFDXmBFGzemAyilj0vW56X7eBxwyEMhmE150vdp0xwU3u1JH0m0nsj+27ojh
         oLKuz2yVD8NrmEpRNo439pku+C84v4pjuEE8ZXOzSdhDvVnpmxR6unPy7fsga/tESmBh
         wpNVDqiRCRdXagL3EFlSBm8K/sY6kbeFFphIsj5PMGT0R6XnEcgeEGDWRvaWL5M99cRK
         3XkKVVWJHKqLP9+W0acwyvby60dbfCrgWEwV+jjm3RdlBcnq6P7OJfHfvWJbNY6zicPH
         L2Tg==
X-Gm-Message-State: AOJu0YyjKg3x9jQ2FjDOAM2UH6O/aXQwQXGbUTeL+f8hsf+YNgNuUvZI
	lj56rJV5epAalMUlq+dR+pffnESWgFyjjqIPwwXH2Vfp018ccHOh2221Oaethoqb
X-Gm-Gg: AfdE7cnTFlhTzUiDlOgiN8VPkw9JZsrAWuB5CwMNv3asXKLaCsad/OrAFupN79IQA14
	utsFLqrThXoBwo5Iiso91ofXd3WdTPcicO9ofBLLFRkgaK8z7WWsoaK15kBLP4ns1a2pV927boo
	FC/Vtn+Cmzsuyd9dBCIXPcxuk6DtNoqIfpA02vL+hSPMd/Tvjpt+UYO/RUu/uf1VR/nla06nkR5
	2Ms0HWWodIVEVXbr99WAh2WdfbsWF6K7/F5Hr2hY0/i3904qPYkQg6/fO5dxxYffsb99VBW1DGL
	aB3A4SM9/pLal5Rox7GNGwTmGKsOyU9NgWzBUvJp18TxHCIMG5u0NfD6YdJX5gG3VVQVXSnbQLw
	TQtM1KhTFaMFlI6ISfyeN2+wfaRQb4xcvghPxLyL7K1u5eaJx0SZVdAzzIc8Um8NA6K3PXXAgEW
	p+xU/x1T2hyg5XT/8O//Tc0CWwfkDAL4eMvo+x1HxBD1snpEKoPBbNp3Q+KJcIcONoiipy
X-Received: by 2002:a17:90b:2ccd:b0:381:528a:808a with SMTP id 98e67ed59e1d1-38941cc5987mr173619a91.27.1783471484825;
        Tue, 07 Jul 2026 17:44:44 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:84e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483e0a2sm12371054eec.12.2026.07.07.17.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:44:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: remove artificial limitations on pointer types eligable for spilling
Date: Tue,  7 Jul 2026 17:44:27 -0700
Message-ID: <20260707-missing-spillable-types-v1-0-44a92121dc41@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260707-missing-spillable-types-4cd9350dc3d7
Content-Transfer-Encoding: 8bit

Track spills for the following register types precisely:
- PTR_TO_TP_BUFFER
- PTR_TO_INSN
- CONST_PTR_TO_DYNPTR

---
Eduard Zingerman (2):
      bpf: remove artificial limitations on pointer types eligable for spilling
      selftests/bpf: test cases for missing spill types

 kernel/bpf/verifier.c                              | 39 +++++---------------
 tools/testing/selftests/bpf/progs/verifier_gotox.c | 25 +++++++++++++
 .../selftests/bpf/progs/verifier_spill_fill.c      | 42 ++++++++++++++++++++++
 3 files changed, 75 insertions(+), 31 deletions(-)
---
base-commit: 602701718649936eb287bf6c7ecf870ec54c6f71
change-id: 20260707-missing-spillable-types-4cd9350dc3d7
