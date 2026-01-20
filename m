Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FF3EF0C3
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906831; cv=none; b=Mcq18JLyYC8o1RIuPFO774YtkYM+4ofl23HTucQHraPFFiUJvVErQA76tmbxzC/WlRzlIc4rHjIv6h+HodMzoFN/h7RexhLMzwYH5qXBwL6OPrisDzLQnZwD9IeyQoql37AxIEwmlh/0V/zhj/6hxDatHK9LQs91RDIUjO8L3/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906831; c=relaxed/simple;
	bh=Wfu08jmaP7n47DgVo7hbSDD1lV6lzLUS2DmlbvI+6lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7D5JVE6XkJaExQFzx2HALxG6l6u4QaUHRfPLGPwWwvZ23ZAo0TNmpg5acuYDAz9LYFwyVzIrssaG3kD1+uJbwo7yVIo8ZsMEXCIWs0t5d3ymz/yO1svr/ia6fBeSzM9k0iPMc9q7uBA4gaGIZ2uot8pOy9qxwNIbKd/+QjqB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: DV5eLbXbQV+Kl8pZPLQSZQ==
X-CSE-MsgGUID: spwUqtBzQ+e5uj/gC1zSgw==
X-IPAS-Result: =?us-ascii?q?A2EtBQD5Xm9p/zcImYJaglkCm3yeHYF/BgkBAQEBAQEBA?=
 =?us-ascii?q?QFaBAEBhQeMfCc1CA4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEBBQEBAQEBA?=
 =?us-ascii?q?QYDAQECAoEdhglTSQEQAYZAAUaEUoJ0sGeBAd16LVSBMhWBOI1ScYU6gg2Ef?=
 =?us-ascii?q?YQadoV3BIINFXoUlA5IgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuCBEZHYEZC?=
 =?us-ascii?q?j4XgQobBwWBIgaCFYZpD4kzgV8DCxgNSBEsNxQbQm4HkgEHAWIsKlAOgSCPE?=
 =?us-ascii?q?weHd48PoRGEJoRRH5xoTaprLphYpFmGUQGCFE04gyNRGQ/aP4ElAgcLAQEDC?=
 =?us-ascii?q?YZ+imyBfwEB?=
IronPort-Data: A9a23:OpvFBayuFkcCS9Yy23p6t+eRxyrEfRIJ4+MujC+fZmUNrF6WrkUGm
 mRLCD/Sb/uNZmf9foxxb9i/oBsCv8OGnNUxHgJkpC00HyNBpOP7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG/6yE6jufQGuaU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgWcc3l48sfrZ9ks25qyq4Vv0g3RnDRx1lA6G/5UqJM9HTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVIPBsBOKjAbzsAD+v5T2Mg0MC+7uB3Q9zxF8
 +ihgLTrIesf0g0gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xSun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXABwzMx2njdK8+Yz4ae08nvYbCPDQDrpK7xmMzRmBZRonaZXTBqnH4d5G0S0hwN1DFrDXb
 IwbcVKDbjyZOEUJYwpMTsJ4wbrAanrXKlW0rHqUvqo28mHWxSRxyLOrMcGTZ9GBA8xe2ESAz
 o7D1z2hXEBAbIzAlFJp9Fq3nvDyhD/RSrtRGeCl9LllqwSB/WMMXUh+uVyT+6Dj1RHnCrqzM
 Xc8+zEurLk78UWDTsH2GRyj5mOJtVgVUJxSC4UHBBqlz7qR7wudB3YJVC8bLsErv4k/Tnooz
 jdlgu8FGxRDjuCYbXit/I6q7hC2aTAnFUs7Xh09GF5tD8bYnG0lsv7YZvRbeJNZY/XwCXT8z
 jSLsiUklu9VkMMAkaywu1Lf695NmnQrZlNqjuk0djv6hu+cWGJCT9bwgWU3Fd4acO6koqCp5
 RDpW6G2tYji961haxBhsM1XRev2uK/UWNEtqUJvEtE88TWz9mS4fJxBqDZwbEptP80YYzisa
 0jWvB5X5ZRaIHqta7QfXr9cyq0Ck8DdKDgSfqqEPooUP8MqL1LvEeMHTRf44l0BWXMEyckXU
 ap3u+71ZZrGIcyLFAaLeto=
IronPort-HdrOrdr: A9a23:ttdiXaAJNTrOMlblHelX55DYdb4zR+YMi2TDGXoRdfUzSL39qy
 nOpoV/6faQsl16ZJhOo7290da7MAnhHPJOjbX5Xo3SPjUO2lHJEGgK1+KL/9SHIULDH4VmpM
 RdmsZFZuHYPBxXqvm/xyGdP78bsaG62ZHtqcDgi0pcdC0CUdAY0y5JTj+hNGBLbjQuP+teKL
 OsovAehz2ufx0sH7+G73A+LpX+juyOrrLKCCR2YCIa1A==
X-Talos-CUID: 9a23:vINiWG3H4xL39YiJZ3WK/LxfNv54f1nX/H3pHQybDTZxeoWxcGSiwfYx
X-Talos-MUID: 9a23:kTnkugtDca87qKi9682nnyl9Cd50ybaXS01QjJdBtOLdJxd/JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106920876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery2.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.55])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 20:00:28 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 102381839FB9;
	Tue, 20 Jan 2026 20:00:28 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v4 0/2] bpf: Add kfunc bpf_strncasecmp()
Date: Tue, 20 Jan 2026 20:00:09 +0900
Message-ID: <20260120110011.1805037-1-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces bpf_strncasecmp to allow case-insensitive and
limited-length string comparison. This is useful for parsing protocol
headers like HTTP.

---

Changes in v4:
- Updated the loop variable to maintain style consistency

Changes in v3:
- Use ternary operator to maintain style consistency
- Reverted unnecessary doc comment about XATTR_SIZE_MAX

Changes in v2:
- Compute max_sz upfront and remove len check from the loop body
- Document that @len is limited by XATTR_SIZE_MAX

Yuzuki Ishiyama (2):
  bpf: add bpf_strncasecmp kfunc
  selftests/bpf: Test kfunc bpf_strncasecmp

 kernel/bpf/helpers.c                          | 30 +++++++++++++++----
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  1 +
 .../bpf/progs/string_kfuncs_failure1.c        |  6 ++++
 .../bpf/progs/string_kfuncs_failure2.c        |  1 +
 .../bpf/progs/string_kfuncs_success.c         |  7 +++++
 5 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.52.0

