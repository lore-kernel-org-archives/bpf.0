Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7E7263B;
	Sun, 14 Jun 2026 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401271; cv=none; b=H4jRE0puvV/fsVH3F/BgPJGbH+pISfLa9ytINV5VL/Uak8iBzvBZGTbGSax9R2cFt3uVVNDXvvYtXMLT9DG6toulAMJ9wHaxuC6VtNrbM4LblRZjYl4J3PZUyIaOQeU+k2OelSQBHMlhDT5iy72j7eox4P/3ETJfsphvtSDXzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401271; c=relaxed/simple;
	bh=JbZdSQrPsoMtCoCsQlptOjGGwGXcWES02t3ZM4IaYqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WN30PHUTHIn1a5sLy+6yEFwM609MtpkRnU6Sdo80qH9ctFfDRo7yQKUlIT8fxabu5GGnOAwkqc8U7Eu2rBjlFRUyA/fCwz6/Kp3jWKHmP2BA+D1ad0MfI4PLeTUv4npScTgd5I9C0avg1cuZrt1OqTsDy/XkWKD7GarivfsLGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA0axU2h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA0axU2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9749D1F000E9;
	Sun, 14 Jun 2026 01:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401270;
	bh=H2kWOLsf3qvRadBE6Tkjq3oEXqykXbMUDicFB5vUenA=;
	h=From:To:Cc:Subject:Date;
	b=aA0axU2hVYwip/24PcDgxNB4zkkKDLjFpi3oqBAVMNDaoAyAr7CkCLj1ALyhA0IXV
	 Er4wWr2AOOt4cIVmYRzM0oqy/q9lIYElntDWfCuPPEZxXhqemZyYiXf08ZloeEyKm8
	 QT9fSjIK83svkl/gTFvq7nJ8+fXmbf9tRGFmU8UqBkkoGSNrbiwRJOyL4BXoAp5p/S
	 TAZ8ZMnBBSmvbWRqtv+XiQfaMu5SN4IDRB2Uh5uh2y8APd+QrH7SSlcZdjMFM8AfSG
	 IE7MCr0HpzwA1ecIOyijMraIfuAj+eAXvkpKR9ClAxonpTXc7TVnmQE0hxfpaMbi6Q
	 mmIvPf+l7Gcyg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] tls: reject the combination of TLS and sockmap
Date: Sat, 13 Jun 2026 18:40:55 -0700
Message-ID: <20260614014102.461064-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no known TLS+sockmap users and it has some known
hard to solve bugs. Let's reject this configuration as we
discussed a number of times.

Jakub Kicinski (5):
  tls: reject the combination of TLS and sockmap
  tls: remove dead sockmap (psock) handling from the SW path
  selftests/bpf: remove sockmap + ktls tests
  selftests/bpf: drop the unused kTLS program from test_sockmap
  selftests/bpf: test that TLS crypto is rejected on a sockmap socket

 include/linux/skmsg.h                         |   9 -
 .../selftests/bpf/progs/test_sockmap_kern.h   |  56 ---
 net/core/skmsg.c                              |  52 +--
 net/tls/tls_main.c                            |  19 +-
 net/tls/tls_sw.c                              | 399 ++---------------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 420 +++---------------
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  61 ---
 tools/testing/selftests/bpf/test_sockmap.c    | 250 +----------
 8 files changed, 119 insertions(+), 1147 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c

-- 
2.54.0

