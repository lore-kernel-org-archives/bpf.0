Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4403A0B01
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079166; cv=none; b=PZ2hTnKqBDBdpr3WNdN1YmWA+LY8x5ozWd3bJv6N0eqxAOqomhpH/lC935zZSMBoFgcaMcjm3dFi2CW4+tnp7T6uKSjVO3R02LLurxDfh1NyooeZi6IcRggC9wi+AQAKVobT1ndl/K69jq2SL2Yd81zbjLO7Nax7cm+mAWx8iqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079166; c=relaxed/simple;
	bh=3mIefPDB43KmMDQcWcDMAg6qpJoLh01xoGq7lr55mDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YukYBbOF5J9OGTeAuMl/6QArZ6U9NT8ymK2VEOvOxPl+7i2HEqWfj0z5F6QgFftNri8PKg8xeiqaiNfU52ge0bzpQwK29Lp3n1dFaNw5myQzuNR0VMyUZmxbIYJSW4YpQsT2uR8LB64us4Gv4rlm3f72BKWiHlKllgLnJmhPeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr+8qgk9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr+8qgk9"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36da8439078so5735039a91.2
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079164; x=1781683964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAJrDclWsxoQPkhKhcELIufNlH0kXnHvmBTgSWCpEJs=;
        b=Pr+8qgk9P2LjQVCxEYVY3GSKVntPOK/KO8w124W+5BFy63WUMqWnXYMmtEuLwotfYh
         mr8ugKBJ9i/q6t4QjdeO83V/FdVSpkccgZnSWkMVQw5YqToz04TT0n9hrT+CBpZRbnQR
         iTq6OVBucQuEN05DgHBTBlNAqDfYjK5H5rtybVP5FZqfL4A8FGGq5ikthI6v40NCsfix
         2R0DWgWpuArEtXPnWOhn8vPWkOuRdXvvY+Eqvib7Q4gfYgENR1quZXiDDfPYNTqhUNQ2
         6Ev++qkdSu9bb99MTn1FGTclvVQHoG+zC99wnBqG53EYKHp+4lMJUOCdH97OQu+fUszK
         hrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079164; x=1781683964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAJrDclWsxoQPkhKhcELIufNlH0kXnHvmBTgSWCpEJs=;
        b=ONj6FSQvt6inujWJgEdq2uQptKWcS0PIMJa0mI/pzsf9oKLodB9eAN/9NW6WDiVpi9
         LORqEBJI8XfvRP/fUFVwFd2jMeFGAhA2BSYxi2w9TZPAO4g0EdvMyv/DM3hmJfMP4cDy
         6TpKrQLNX0BWM2fHE41Ni0vNMs6PvVWDuvVcx7mOmWetxuaqWAYb0rjv8bN/ONmi4GD0
         4nKsF6/bPSKOGFqz8tyPG4/soYMirTsXlVpndBWad/CSPVK1T6m10L/b28Bz0rqCLALV
         rYQX1zmQglxRleaIIqpPizjE73HxKucU3Q3HTv5h0A47C8TFivCSyaG5x5f3FqKkrntw
         yaFA==
X-Forwarded-Encrypted: i=1; AFNElJ84tQ2GHbbYvFpxiRc57LWhc1nqSmgsSqAhn9OqseehQxdkonxR+Wm4Kv2d+CCLLufWwbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1OByN15vMjMiiESd4Q/8aZ+HiJiy9jg9QHD8snUW3LCvEL3T
	U+Fmxdz0kFLWyT4oJAqieREH9Dbcpok3fR3TmsVQe/qtoWlA+dkkrxGP
X-Gm-Gg: Acq92OFG0xduVyt83mPrp56IDMulY0Q7dBlA+qqoTh1kU3rsdVHyhprDTVTSlYiIl+c
	HQS1IzYD5d+za4ZiN1BIfOh8ZrN2ntf7BbkmUfir6bWUidc7qbrywrd27PL5pXFm+OZJGxaFd/m
	HoxX0ZRHEaZYaZ5mbAxaxllT0sE3qn725eG6t0HWRctUZLk00sDnftqHzzDfZaVu0/0rv3NykX2
	p6W5DX8ptPrpdRdcke6o/K9L0Cr6B4fEWRkuuRKre6RZ4SO/WqWEhMb0qvaDvazpKG8ll4pBZCB
	lRC6U5k0oJ8bUX2ytiBR//pJ5H/M8EnxkMMrOsUseI1B5ouseT8TbQZjh4t1McHIPdlC+7S1hve
	dkdr1GSSADFwtUq/rSILdHBnpQygaKhVX48ya2VA3enLaRwgREQXIs7/XNYegCIA8j59kPbmBys
	EdvkjRbWGBiKYN9dJeAcVRYWJ0AwCVKgXtZ6af2GOzTynP4zEIEFOhkt2Gtrdh6gdzL8BXcbw2
X-Received: by 2002:a17:90a:d40f:b0:36a:a16b:5f65 with SMTP id 98e67ed59e1d1-370ef1f3d01mr25989391a91.11.1781079164425;
        Wed, 10 Jun 2026 01:12:44 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37645c1aeb5sm1241003a91.2.2026.06.10.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:12:43 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf, sockmap: fix bpf_msg_pop_data() integer overflow
Date: Wed, 10 Jun 2026 08:11:52 +0000
Message-ID: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_msg_pop_data() computes "u64 last = start + len" with u32 operands,
so a len close to U32_MAX wraps the sum and passes the bounds check. The
pop loop then walks off the end of the sk_msg scatterlist and
sk_msg_shift_left() calls put_page() on the empty msg->sg.end slot.

v2:
 - add selftest (Cong Wang)
 - change pop to u32 (Emil Tsalapatis)

v1:
 - https://lore.kernel.org/all/20260609183927.4021802-1-rhkrqnwk98@gmail.com/

Sechang Lim (2):
  bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
  selftests/bpf: add test for bpf_msg_pop_data() overflow

 net/core/filter.c                             |  4 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

-- 
2.43.0

