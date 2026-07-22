Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F130D3E7;
	Wed, 22 Jul 2026 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695328; cv=none; b=JI+FVIml5Vns1wm8ZvqBq4aJWWfxT7iM38rf4co0LBS5YoWHGVHya+se/ck1AKl4N8g4upMzy5QwFahF0ftcGYlbBVjPAprnRPpqw79OORNREuOo2q8lsMDnPtBSwAYtr33Wh6hgNksH7fX/9iyp0rlcuZXL45XWUpXixmkqHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695328; c=relaxed/simple;
	bh=d86kgqC0XXQstpT2puTv3THBnEbxtP4E+uuhu4C5g0c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=W7CwpWT62+AK4icENklFbSXe3kyY6PcmEtA9jvUnrltjA08UDXR6jabCCjKubos5uxRsNz4FfIT1kShBZ5P2gbVAk5Y/H2GQcoiJ+RJeQOqyxnkZqqpsvAv8TDx/swmCGekanAg/7IudzGtCiD6MRPd729YybS7IglHb4mrdu3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Lxcymm2H; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Lxcymm2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784695313;
	bh=4eLhN0Pd4R06C2aIEZ+xssToUT7yw/q6wBYljLmxcO4=;
	h=From:To:Cc:Subject:Date;
	b=Lxcymm2Hr+ceeLB8BMc4c8VqzXV0e1TA7wPKdSqax++jqLk0uTcYIMDUOt4JvKVnY
	 Cg0+m/5XuSN0vEJOip3BvlgfXXo2iEWAj5wGyg6Nv9HLzC0CHoet1Ks1Uuqne6V4sa
	 v3pMvZUB81Q95Xf11S3GO/rmIZogQg6oDwhWc4ho=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id A70214ED; Wed, 22 Jul 2026 12:41:48 +0800
X-QQ-mid: xmsmtpt1784695308t02xrgc4h
Message-ID: <tencent_088C5EB146C7119D0D1E84C0B32E2F8B5409@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznTdUZ9CLu4xN/XbsB+gd6xQJR/j4cLh/YBW1QDOlpnbUPVTcWIt
	 areBp3qwCVytjhDgz7ODinnHet7vFFK4gL9Zn9SJPD9xVjkWQkUd+sAtNI4RIwrnNoziZG6mrZ1t
	 Th4PJi0Umm0rytzU4J0xEkfH8+P5uUtSUyPC78/35cIUyG9veqUtpHd2Obiev+am/nI9zMJERUl4
	 3l8Qh9DQy1v8qQ2cXMH/BHpqg4zJZgJ7pKdi4VJnAeVw8z2qH/+stTDO2j/Wh9i1Ms8zvU1D/mol
	 IlCjDFY5yx7gWM2pU/bHzekNTNziif69HSDWNTHOFETAzqMdTQuV2Giid7nd05TKB+NGIuwemiOd
	 Tz+/NlibZOv2KXeEIkoR+jRnjyDIIflvFfW9UItsgmMsDvCfuEPWUSJssmHfZu6IIy9RJZfDKjlY
	 chF8kjipaAoXHaM497BSpsK0SbXC20x1HXuD8NfOwHvKKALUpEzrp9Evs2kQuTLcrtV4JDnoI+52
	 idFFn/MQk4TOMKZQEqPzaMIHOs7iSosRmiBEXGUIOWI/DInADw1DEquSFhDb+Sc4dWkw6wkKtTj5
	 GQuAJ0wiEhxHvyU18yQUWtQ7bmOv7ogYuk+v7dXgVwSMOD8GEReD3CjqbJg0G+O9DgAdECRNGj2C
	 ob+oWOaXxRVZa1+vfoosFXvsO9QpV/sZ7W+Qjb84roFmgim7MAT+C6uwH1X+sby5PZR8OTtUE4Iv
	 0a2jBl9eRW7ZHFQ37R9KWRDNeG6Bkhz8c6rOOe+67JqSbL2dzPx89rQ1C7pVotLqTgnRMsjihQc3
	 8Hfd+krrDlYun6wYRrEZL/WdDaHobWot6NRBumCUnSriaFWv0dwJ+4XT4m71EdQL3C9SfyQ1d5C7
	 KOriJKQfPsri3nP1LmXyv2rT05I5sgeosTDZp/F/ZhzBR/i/FQbnyqJV1FY/1nv0iQz/y2qiz0Nj
	 Z/4Ow5Lic3LCHjNwyIoDe0TVuL1D/PVC5TmZ9koA6Ow/MQvxSioTotpVDBVuwXVp4X/nc9l7Kkxb
	 RVm8zyH45iQVAmAchpkrY4m+SzhfZTv7trpUjKoxPDJQNXE2JtDA0ycUcodFpPaSA0+l39V2P0gt
	 QTsWriwEeuVSKsZbf5vBIGP3oD9g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org
Cc: rtoax@foxmail.com,
	rongtao@cestc.cn,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v5 0/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Wed, 22 Jul 2026 12:41:26 +0800
X-OQ-MSGID: <cover.1784695085.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add string concatenation kfuncs.

Rong Tao (2):
  bpf: add bpf_strcat,bpf_strncat kfunc
  selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs

 kernel/bpf/helpers.c                          | 75 +++++++++++++++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure2.c        |  3 +
 .../bpf/progs/string_kfuncs_success.c         | 12 +++
 4 files changed, 92 insertions(+)

---
v5: Fix CI and Sashiko AI failures.
v4: Addressed Viktor's review comments (see v3)
    https://lore.kernel.org/lkml/tencent_AFC1869057D6C3E59E0AF86BD7A80AA29A06@qq.com/
v3: Use bpf_probe_read_kernel_str and resolve some bot suggestion issues
    https://lore.kernel.org/lkml/3e73aeb2-afce-4ae9-9163-51e4dc1ded01@redhat.com/
v2: Resolve some bot suggestion issues
    https://lore.kernel.org/lkml/tencent_9EC04DC824CBF5124305E73564341511C405@qq.com/
v1: https://lore.kernel.org/lkml/tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com/
-- 
2.55.0

