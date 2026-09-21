Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69C36194A;
	Mon, 21 Sep 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970441; cv=none; b=kamIUWgttRrJWWfNb8LJVCcgnDC1Vq2jEUdbQZKqSVBw5D/DSyBRSAwCV/PedkeP6alzFUQNTNzuPDeBinA7+8dYXaG9xVgTSNX2aLrtgi/o+1vKnXnC8RGcxQM1zJ/0ZesUi2tERACb8a+AHS2ZMrw1+DCfSz+7gGgRpaXsChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970441; c=relaxed/simple;
	bh=4zG69CZFDv+RZ4Ce0FKi1VK0WiVt5t0i/2XWwCPH3IQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lj+yp0u9Q1W5RvU6GS77qm3fNJvh46FwjgVMxHT5Fg6qnCQRs9JPFJYQbJceZGV2ZlkZ9GbQdzi4dazd4GHf066wd1fhQenjA8/3T/ISqcK9BK7zXM7YhNUxnDR/qu04v1MUGmOgw7l5kFuuChlg1Jc4C0teHH03i47/YmOmSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1HgvdES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1HgvdES"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81F03C2BCB3;
	Mon, 21 Sep 2026 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789970440;
	bh=4zG69CZFDv+RZ4Ce0FKi1VK0WiVt5t0i/2XWwCPH3IQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=B1HgvdESkJ9mqTQwVKkhLsBzsYIFyY9l2MxRtY7FchAG5kzlq01gQOkCfA3QvJ0IM
	 aZuY7S/wIjdUqLS/G+kMxlWtDq1Rd8P5dURdvz5POPYru2UPir/MaQU3TkL0Mygq2d
	 KI377ifY20EuVATS9mo2Yl1apS4M2n3wV2UyXhgtNkHZbfnNeZLdtn9lWtS7Z6pk1s
	 L6gFRg8ooh61Oi4oIvl7CeB3KnmyCXmKtOhDvs3VvAJlHK1d96wNsEefvN2bLJHlZL
	 M0HS4FymKRV9lqneYcXIhbBlK/ocaFASMzq/dJ7BIcWDKPoxB8APGTEKJRGDzX85O6
	 sjC8kmoT4Nhmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7ECC982ED;
	Mon, 21 Sep 2026 06:00:40 +0000 (UTC)
From: Bochao Cao via B4 Relay <devnull+bochaolucky.gmail.com@kernel.org>
Subject: [PATCH net-next v4 0/2] selftests: Fix and migrate XDP feature
 test
Date: Mon, 21 Sep 2026 14:00:03 +0800
Message-Id: <20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPHsGoC/x3MQQrCQAxG4auUrA2MoSp6FXExNn81m1gmYxkov
 buDy2/x3kaBYgi6DRsVrBb28Y7xMND0zv4Cm3aTJDmnqxy56cIzcv0WBK8jB1xZpqT5pE8RvVB
 Pl4LZ2n97J0dlR6v02Pcf+eWfvXAAAAA=
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Tiezhu Yang <tiozhang@didiglobal.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bochao Cao <bochaolucky@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789970439; l=2678;
 i=bochaolucky@gmail.com; h=from:subject:message-id;
 bh=4zG69CZFDv+RZ4Ce0FKi1VK0WiVt5t0i/2XWwCPH3IQ=;
 b=JlZitjBbieuRAZeg1bXnaBcm29oP9VsbRhAt9M08ArMB6ZeVOyczAN00+ixfN9bO8hjO9uxt7
 hOlxhVtnNmLAHv+SAWbZU8Pv0S9gcg+KRvraldYCqA/FE/kx5hdL1SP
X-Developer-Key: i=bochaolucky@gmail.com; a=ed25519;
 pk=ZYp7O2eXSIrJ9YmKrl0iHDoulPYSG+1lzICsicAvld0=
X-Endpoint-Received: by B4 Relay for bochaolucky@gmail.com/default with
 auth_id=1042
X-Original-From: Bochao Cao <bochaolucky@gmail.com>
Reply-To: bochaolucky@gmail.com

Fix DUT process tracking, readiness retries, and signal cleanup, then
move the XDP feature test to drivers/net/hw as requested during v3 review.
The NetDrvEpEnv runner uses configured DUT and remote interfaces and
reports detected-versus-advertised mismatches as test failures.

Collect results before teardown so the echo used to wake the DUT thread
cannot contaminate tester counters and cause a false XDP_DROP failure.

Changes in v4:
- Correct the description of the set -e readiness behavior.
- Handle signals arriving before DUT PID assignment, including QUIT/ABRT.
- Move the test and build rules to drivers/net/hw and use NetDrvEpEnv.
- Report feature mismatches as failures and sample counters before cleanup.

Testing on Ubuntu 7.0.0-30-generic:
- Built xdp_features; checked shell and Python syntax.
- Original and v4 REDIRECT/NDO_XMIT results matched in three repeated runs
  with GRO enabled and TX checksum offload disabled, as in the old setup.
- Confirmed default veth offload settings reproduce mismatches in both
  versions; these are not migration-specific regressions.
- After fixing cleanup counter contamination, XDP_DROP passed five runs
  and the complete six-test runner passed twice (12 passes, zero failures).
- SIGTERM interruption left no xdp_features processes, veths, or netns.
- Rebased onto net-next commit 8830e65ed46d; repeated the build, Python
  syntax, diff-check, and per-patch checkpatch validation.

Native-XDP hardware traffic testing remains unverified: the available
e1000e interface rejects native-mode attachment with EOPNOTSUPP.

Link: https://lore.kernel.org/r/20260904-xdp-dut-process-lifecycle-gmail-v3-1-5b7eee4f7009@gmail.com

Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
---
Bochao Cao (2):
      selftests/bpf: Track test_xdp_features DUT processes
      selftests/net: Move XDP feature test to driver framework

 tools/testing/selftests/bpf/Makefile               |  11 +-
 tools/testing/selftests/bpf/test_xdp_features.sh   | 107 -----------------
 tools/testing/selftests/drivers/net/hw/.gitignore  |   3 +
 tools/testing/selftests/drivers/net/hw/Makefile    |  22 ++++
 .../net/hw/xdp_features.bpf.c}                     |   0
 .../{bpf => drivers/net/hw}/xdp_features.c         | 126 +++++++++++++++------
 .../{bpf => drivers/net/hw}/xdp_features.h         |   0
 .../selftests/drivers/net/hw/xdp_features.py       | 109 ++++++++++++++++++
 8 files changed, 226 insertions(+), 152 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260921-xdp-features-v4-send-2c0da5db22d7

Best regards,
-- 
Bochao Cao <bochaolucky@gmail.com>


