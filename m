Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952933DEFA
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966424; cv=none; b=DYdg06Zi28KehMTZ7g/jJNyiw2M6pwhQZtDQf6892/WG5nkmJSyOoMAKIkBRyBCy6pVAv1ugqQWdiZ/83Bfr9WfiNKpp5un/uq2r4+FmLQNgc3XHIZgY05d13eiC3bXXjQIstCUn9MXKSB+qxrUArxMOG+z0r9KRGPIHF4XG5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966424; c=relaxed/simple;
	bh=rHeVGaJKJ+Xpg7xXvz3Ojrc8GrOoLI5XhqatSCP9has=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goMzUBv2/uoSTSl1jFSxmrM5eaVM2HzVddiNELIgdq1O9K9gOeEt3x7gg8XliWEAiaS0WL1WmFQATatkV63pH84KZLUxn8kRVUu7IGBKb49rkcTuXBH9rgIPKas4mbUenxRr+24mjTVMyKNe8ifENCwBDGbhd37rr1DYhyas9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: EosxhEisTVCY7v7WhPMlNw==
X-CSE-MsgGUID: SlKY44MAQiaBdt9OU4HUoA==
X-IPAS-Result: =?us-ascii?q?A2EtBQB5SHBp/zYImYJaglkCm3yeHYF/BgkBAQEBAQEBA?=
 =?us-ascii?q?QFaBAEBhQeNBSc1CA4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEBBQEBAQEBA?=
 =?us-ascii?q?QYDAQECAoEdhglTSQEQAYZAAUaEUoJ0sQOBAd16LVSBMhWBOI1ScYU6gg2Ef?=
 =?us-ascii?q?YQadoV3BIINFXoUlBRIgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuCBEZHYEZC?=
 =?us-ascii?q?j4XgQobBwWBIgaCFYZpD4kzgXYDCxgNSBEsNxQbQm4HkgUHAWIsKlAOgSCPE?=
 =?us-ascii?q?weHd48PoRGEJoRRH5xoTaprLphYpFmGUQGCFE04gyNRGQ/aJIElAgcLAQEDC?=
 =?us-ascii?q?YZ+imyBfwEB?=
IronPort-Data: A9a23:5cCUgqLIcpv50tpCFE+RfJQlxSXFcZb7ZxGr2PjKsXjdYENS12FTz
 2UZC2vUP63eNjf0ed1xady090gFuJeBzd8xTgVorCE8RH9jl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bP656yI6jf3ULlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgX8s9JIGjhMsfzb8Uk35K+aVA4w5zTSW9ga5DcyqFFIVPrzFYnpR1PkT49dGPKNR
 uqr5NmR4mPD8h4xPcium7D9f1diaua60d+m0yc+twCK23CulwRqukoJHKN0hXR/0l1lq+tMJ
 OBl7vRcf+uJ0prkw4zxWzEAe8130DYvFLXveRBTuuTKp6HKnueFL1yDwyjaMKVBktubD12i+
 tQ1Lysdbj2CnN6I64PkVLZThvwGKO/0adZ3VnFIlVk1DN4jUdXPTqHL+9JCzXEti8sIFP2YZ
 dJxhThHNU+YJUQSYRFHTs9i9AurriCXnzlwqUmVpLs+5mH7zBR6lrn2dsfYcZqDToNXhi50o
 0qfpzqoXE9CZI33JTytyXaPt7OTuArCWYs4GKHp0cM2oGCU7zlGYPERfQHi+6bm0x/Wt8hkA
 00P+is/pK073EyzRZ/8RFulrXXCtxVaWcI4LgEhwASdj6bZ5weHC3IVF3hcZddgvcRwRyRCO
 kK1c83BKDt0oL24SGmhyJyl8i3tBigtCGskenpRJeca2OUPtr3fmTrtdr5e/EOdi82wFTz0w
 i6HtjlnwagehogC3OO55TgrYg5ARLCUE2bZBS2OAQpJCz+Vgqb+PuREDnCBsZ59wH6xFAXpg
 ZT9s5H2ASBnJcjleNaxrBox8EGBva/fb2KF0DaD7rE99znl5niiY41K+zBiNQ9uPI4JfTLif
 FXU/AhW4ZpOOnqhZLN2ZISqY/kXIGmJPYqNa804mfIeOMIhL1HapX4GiIz59zmFrXXAWJoXY
 f+zGftAx15AYUi75FJan9sg7II=
IronPort-HdrOrdr: A9a23:FA15YqxsxeWlUe7DtM+xKrPw5b1zdoMgy1knxilNoNJuA7Wlfq
 eV7Y8mPH7P+U4ssR4b6LO90cW7IU80sKQV3WBzB9iftWvdyQ+VxehZhOOIqQEIWReRygc379
 YGT0ERMqyXMXFKyej/pCa1G8s929WcmZrY4Ns2DE0BcShaL49l5wd9TiCBEkN3QwFCQb40Do
 CV6MYChxfIQwV0Ui1zPBU4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AVO9xkWviVgctmpTWdV6h7WpZ6IsIdWbNzFrROHO?=
 =?us-ascii?q?GIlc2VuKqSWe1/IV7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AmOYG4AxLo1NlNeNaZoit8YsUd2iaqJ+qK3FRzbA?=
 =?us-ascii?q?vgsiNHyBsahCg0BSKRaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763391600"; 
   d="scan'208";a="106966090"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 21 Jan 2026 12:33:39 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 4FD57183E391;
	Wed, 21 Jan 2026 12:33:39 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v5 0/2] bpf: Add kfunc bpf_strncasecmp()
Date: Wed, 21 Jan 2026 12:33:26 +0900
Message-ID: <20260121033328.1850010-1-ishiyama@hpc.is.uec.ac.jp>
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

Changes in v5:
- Fixed the test function numbering

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

