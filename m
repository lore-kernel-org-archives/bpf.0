Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186A3E7625;
	Fri, 14 Aug 2026 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691595; cv=none; b=nubi4IrW4DmR2/XeZoaSNGXHiQZkCT8MXEUBTWIf6yGz57BhlIwVZWS50XWqDQSBD/M3apmYDBijIKlUHrSfF+zbk0wCYL129QjA5p2zj3UWxbp73rQArlrGzYHvpOSabPIHcHzI4Xb1kUM/Lf1J96RYQ9iz/R2vJdbqA+WbsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691595; c=relaxed/simple;
	bh=yqP4tSBZtLGvea0WQ/QK/61MC4Kyq0gUuWOtLvjgkNo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d/91oqkbVqQ0zHYHJhhqIRfBlJXZT5fb+MUU1wsK6qt7gNnUjBuH5ChFqwH9rKh+R/2jE7Pnelkul6qaObKSpWvmLzxQw/JMLjAjoTAuhR4uIzjs9QCSNhvuFNNLpItHpejE/nt1bvep90UG8jGSxLXPTZu1khl4UU731MMVqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BREEoX6s; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BREEoX6s"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 944F04E41220;
	Fri, 14 Aug 2026 07:13:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E7056046D;
	Fri, 14 Aug 2026 07:13:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 418DB11C4E895;
	Fri, 14 Aug 2026 09:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786691579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=UamOckhX2fid98x7el6hlfeD34U7Ll/vltEZg4yRc0U=;
	b=BREEoX6sWj+t/i1mrq/BtGlEhT+qSkbHCTl+bDELDe8r+AWZcxwY5ZLVlXAwNNSt/4NRgY
	zzu7qj4j9ySzjUE4Mh6F7OH4G7hIkZOnAj93zHut/A672EQIJQwaj5d9+N0Z3oFElzza4G
	nE+DmDrWcIFd85YabaEySGCvmY9D9u1r5LdtAe2KAIkvqY1t1jDtnCwTxRVITFlScny0GU
	LNzYO/tsjcNu5ehCs2+S/TKEKUsN6XL2fg7WgfO7AGfIWwv0VFiWKjAjbUVk4xaIDC/6nN
	8/wulF4ufcyaPRh+wj7wT/N4Vh0SSeOf32Wp1yIR/A8H4v84khuL907NfE/GcQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf v5 0/2] selftest/bpf: make test_tc_tunnel and
 test_tc_edt more robust to CI load
Date: Fri, 14 Aug 2026 09:11:26 +0200
Message-Id: <20260814-tc_tunnel_flaky-v5-0-5b93d030c42c@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOwU4DIRAG4FdpOIsBBpbFk+9hTAPsYNEtNAvd2
 DT77tL1YM3qcSb/fP9cScEpYiFPuyuZcI4l5tQG9bAj/mDTG9I4tJkIJjqmOaPV7+s5JRz3YbQ
 fFyo0GssNdwMD0q5OE4b4uYovxJ0Cef1elrN7R19v1i12iKXm6bL2znwN/1sxc8qpFNY6BcZYa
 Z5dznWM6dHn4+rP4kfoGWwF0YROaSd6PQSr1VaAO4HzrQCU0V53QSJzvmOwFeS98McPsv0ACuQ
 QIKAB9ltYluULUnhjgY0BAAA=
X-Change-ID: 20260710-tc_tunnel_flaky-27e9a191bd03
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this is the v5 of the series aiming to reduce the flakyness of
tc_tunnel/tc_edt tests in CI. This revision just fixes multi-line
comments style, not only for the updated helper but for the whole
network_helpers.c file

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v5:
- reformat multi-line comments
- collect Ihor's Acked-by
- Link to v4: https://patch.msgid.link/20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com

Changes in v4:
- dropped the polling loop in favor of a larger, connect-specific timeout
- drop timeout configuration from tc_edt test
- Link to v3: https://patch.msgid.link/20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com

Changes in v3:
- set errno before logging errors
- respect time budget set by
- respect opts->timeout_ms when polling: only poll for the remaining
  time not already consume by connect()
- keep polling if poll returns with EINTR
- reorder early returns and add intermediate variables to clarify code
  flow
- Link to v2: https://patch.msgid.link/20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com

Changes in v2:
- drop unneeded initialization
- add back error message for immediate connection failure, and slightly
  reword the async connection failure error message
- Link to v1: https://patch.msgid.link/20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Alexis Lothoré (eBPF Foundation) (2):
      bpf/selftests: fix comment style in network_helpers.c
      selftests/bpf: allocate a larger timeout for connection

 tools/testing/selftests/bpf/network_helpers.c | 60 ++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 11 deletions(-)
---
base-commit: 114cb6aa1571c30770715a1756553b812865b1ba
change-id: 20260710-tc_tunnel_flaky-27e9a191bd03

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

