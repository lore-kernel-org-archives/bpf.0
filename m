Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852213C2760
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740121; cv=none; b=O/zR+QHa1CDqJn+D2yc8vZY33oQz84PSReJ773hHdLKykM/9bqxSXwpROSfA8Trrq1YEceJTgB6Zs2HxnbsD1lwymuGsC/x0ulqFoMdSABtd/IG8v720hQ67rJIp0MIkYeKPFs7+YFU8LdjeCJG524QsNS3TDu/gTVK5a9BbMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740121; c=relaxed/simple;
	bh=q3eu6XaXanhB5aDvpqrbX7E7kOX8djjLHzar3ADG08c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EQiMMo22hLbaC6T17Xalb9escOpf5LdJpTzhyVw3dBANZcGMBMnFZXe8+4MsQ2Gn1i3viRpnRZFpBMT3eoXcmmJW9GOnIP2yw628DPpcz7R19iez0O4Zc/Zv8jzJj8j5Y8jHzRalDHFBytqdhNmXNAJK7DzAQDo+ogyDy7TplfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOb0j2H1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOb0j2H1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5069b3e0c66so126535121cf.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772740119; x=1773344919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJRWyg9FSKVsR7jGMz6W1qFvZwfjiIJC6xQ7v73PMeA=;
        b=QOb0j2H119Z6su25zDH4ZRTF7lL4Jh56bEyhhIXEeKNKgW6c5AUph3Xpwur/GA8mw9
         ECQMLFwvIJHok5Lm5YiU0MqXbWL7L1zyHcBXq7mgep7fCwHVs3ElywO02Ch3oySaZX0H
         1nNARu6PT6VD+5AQCpGn5YKJ/QMZDaTWz3VNTBRUckDNKOZ6wZbfDvJiJ62335ACiiz2
         iWCaIw6WaI/iEJRmwF+QF/khZslPUltpaDxsc25dsQTghXb7gYoXuvn+GxYt8txKek+Q
         3HvUqf9CecvAKOhs/V3wpQwx8A0KJdFftKOXXXvuFVAfEtwgM3cfdQwNHl8Udksry5iX
         OLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740119; x=1773344919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJRWyg9FSKVsR7jGMz6W1qFvZwfjiIJC6xQ7v73PMeA=;
        b=oZJ1ZVxdfsNcqCHJ04oZck+C1shcRMSevS0PF9263eUU7hC5x88YOKJw9AlqR0kTN6
         t570h5nqKzox9M0exIISquZ50Tn2BuO456hPGrPr5b3eNYvfVVVV842r0SmhTQhqqbEM
         uPiEkTYMqFNBLlMDQ8XRJRtP8o1ogLssGzH+4619yBFmO5U6aLOODdIQK3j+zxnug7W0
         edR5SVaFsJmyZ4f+XPQ0SFoSzGiw1pxOGAV0U8qqvv75q8sne7PFswoPAM0lrA5OIQH7
         i0enaG87FqsSq9xZQECqSF1re9UgZkmgeIs+MWkex5N473lOc5yUHrB5vubRae2hpTmn
         92PA==
X-Gm-Message-State: AOJu0Yx+PMMka3P6a+M5JATC3RXZBiTrq0WNccVYXbxa5/68CRWHFJfo
	QyACPobX2s8BurB+k+bKq8MfB17dLynQXNRFoZXhILkti/TXG4qEQoJIgCKpbg==
X-Gm-Gg: ATEYQzwiSz0Jdi37RkbGf6crltIH4lrtHgBIMVBRGUOHmu1EPQmLJNjGYnqn0pGw/WQ
	3w3wjvMaWsvrzMvbnbTT4kdCMDrr5Yx7pdgW6HWMVKtDgEXLobQ/J7pl8ByJ2PciQ1ySEKZAdeE
	LWqbIszLrfs3lWhkeCJddC+qTH4K4drMQEJSQ+V+/Jwi4AXEQyWsneSGbP7TMsin4eHLn8H6JON
	eAPz4npLFsigsfo5GlzM1JVKNlvALFXDpILdEfkOvrwJlEE1yUkMWu9w0usFQx5aoB9IqgLNzpm
	o0dmhIVl/MU0GXOXdVBR3rYKsOmfrGzb6TX1HyIq70tmJ7eegxgBRaN+59UoXpNyXCc61RiKtRp
	Fm9hM7K3V1J+CnB2aPBce24czI3XsbYS1ZFg0Iyzq5DUZxa597wzvpHdORRuJJC3HIaSY8d4GXR
	xkWtCWMO5XHV7oxzGZZkEZPsjaejZkQ1HACRpRRX4lvq1RUl+Ah1/efGbgUgB1FGG/GVY=
X-Received: by 2002:ac8:5d07:0:b0:506:1f30:bfc3 with SMTP id d75a77b69052e-508e69c1fdbmr42368651cf.36.1772740119259;
        Thu, 05 Mar 2026 11:48:39 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449874b7sm178755661cf.9.2026.03.05.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:48:38 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	arighi@nvidia.com,
	shung-hsi.yu@suse.com
Subject: [PATCH bpf v2 0/2] bpf: refine u32/s32 bounds when ranges cross min/max boundary
Date: Thu,  5 Mar 2026 11:48:21 -0800
Message-ID: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260305-bpf-32-bit-range-overflow-00351dfb8083
Content-Transfer-Encoding: 8bit

Cover the following cases in range refinement logic for 32-bit ranges:
- s32 range crosses U32_MAX/0 boundary, positive part of the s32 range
  overlaps with u32 range.
- s32 range crosses U32_MAX/0 boundary, negative part of the s32 range
  overlaps with u32 range.

These cases are already handled for 64-bit range refinement.

Changelog:
- v1 -> v2:
  - Extended commit message and comments (Emil)
  - Targeting 'bpf' tree instead of bpf-next (Alexei)

v1: https://lore.kernel.org/bpf/9a23fbacdc6d33ec8fcb3f6988395b5129f75369.camel@gmail.com/T
---
Eduard Zingerman (2):
      bpf: refine u32/s32 bounds when ranges cross min/max boundary
      selftests/bpf: test refining u32/s32 bounds when ranges cross min/max boundary

 kernel/bpf/verifier.c                              | 24 +++++++++
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 62 ++++++++++++++++++++--
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 37 +++++++++++++
 3 files changed, 119 insertions(+), 4 deletions(-)
---
base-commit: 56145d237385ca0e7ca9ff7b226aaf2eb8ef368b
change-id: 20260305-bpf-32-bit-range-overflow-00351dfb8083
