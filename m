Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057112;
	b=WZyw5HYwy7zCn0W7LgmyIBWPz5lP3bey/63BlzUmZgXg4FRqO5W5fBiNN2QqmmCu1GPN
	 EjmQBTwCIs/w2kUgOPteAspiryuQGoC+aQ2D0dXTtipU0g9KeAbFcTzM8B5+h1C98Lqx0
	 hy6PMCprCknayhsS6sLU6jVXjezVCSfuNvSvmQuWAtRtXF4nU5NlgleMzzuQme6GbV/Pt
	 6EpVIAPslrXrl9ahwPtuTbHQeJOjgyTRVNiuDlU8Z8vTHLSwY/FNxrJ9JpH6abD3a2KLq
	 lqjtFZEJ6Du8XQ92ecY9eiDQphwiOiyjfU2ytSydz5A3EB0Ecqc7hQuo8/h6WowiWHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057112;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From;
	bh=HZdie3PW+1vtIp8DWod2GNqosXfOJizp6+UxsGisvRw=;
	b=dyqVWv5hx0BplF35rCkxJ+saxRbe7s8aC9MR4vwswL5Vc3mLigwvNaRGj3gYA0S7hb8Y
	 FIgqZGijKHFlR83b64i08JslGIaUn4ckuH3EpkQqLOudlgi08J5SoYoyesJKvg/UJnXDV
	 hzvyFSHdogXh1wCoL9HVKcsl1/yTgM6aidhc6sSWCZRn01mP15tbCwNS5r/KzICU9LgqN
	 MGw3OPsJ4ji+RPltjpbKwwrZjWgIRZAGZVe+NardRUugTs4cOlo9iaa7iMtX1BTYMqP4o
	 PJg7sDjIBWy7OuTdA6clSCeIpWqU2VOiQHUEbEQ3GE8vrzoyATDRgYqm74gBgZgT2Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=MdnzvFcr;
	arc=none smtp.remote-ip=198.54.127.154
Received: from out-2z4y-a154.jellyfish.systems (out-2z4y-a154.jellyfish.systems [198.54.127.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76C606A32F
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 13:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E76C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=MdnzvFcr
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jMGdq2xlNz8sWN;
	Sat, 07 Nov 2026 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794057090;
	bh=HZdie3PW+1vtIp8DWod2GNqosXfOJizp6+UxsGisvRw=;
	h=From:To:Cc:Subject:Date:From;
	b=MdnzvFcrR9E3Gu7gM39gih+CEOOc8sqG5gUeTWmv969vHRxBW06fsR4ml4fABFpAN
	 Mx+halgLBtrL7kmTxSJd4a7rSLCSELfj8d6S20pna7jELod/ed4/6Yfu935GsRB3wo
	 CbzfhEByiksLEEpffLCEgoEa0Hkc80OyqlZwzYjMr19mak1NpSxSIbCtnH5uAjU2OD
	 dcu9vhgRLzDz5f3yLrp9pefugiSe2a+1a7UL7Xmon1b2RddX1z+C8r0rZWMN+rawJ+
	 Bhwm0jKIVbKJTHrstSVyAUxRJX1qZXz8zzEbnDtkuMc1YoDDoJjBZpo0eRWwExN8Cm
	 GOuI5gam3NrTw==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf: Fix RHASH batch cursor loss
Date: Sat,  7 Nov 2026 22:11:18 +0900
Message-ID: <cover.1794056839.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
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
X-Envelope-From: hi@tychen.cc

RHASH batch lookups can report end-of-map when a key is deleted during
the walk. Return EAGAIN for that case and add a regression test.

Tested in an x86-64 VM: the regression fails without the fix and all
five subtests pass with it. The bpftool batch and recursive tests also
pass, separately and together.

Tianyi Chen (2):
  bpf: Report lost RHASH batch traversal keys as EAGAIN
  selftests/bpf: Cover RHASH batch cursor loss

 kernel/bpf/hashtab.c                          |  13 +-
 .../selftests/bpf/prog_tests/rhash_batch.c    | 181 ++++++++++++++++++
 2 files changed, 188 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhash_batch.c


base-commit: 646114a0d2f39e52f2204196ac12a6fe5a5a3fd3
-- 
2.56.0

