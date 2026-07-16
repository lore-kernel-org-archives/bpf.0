Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF13AD526;
	Thu, 16 Jul 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194529; cv=none; b=JO5iMsxvmkG8pERDjakH9/KB8pgTSyZQOUwkOLBaOQqOhKSZYN8kMgdOQ0FbMrmk5YAfylyXbE9+gS0DIe1iap+TV254s0beeoB2sZSUx6SP8Rt5Bt/4Mm8Q5D6tZQuw0HTW+WIy8JgGPmK+v7tOdnKEvROFJObMziOSX63Bp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194529; c=relaxed/simple;
	bh=wIPm0YvSCVPOHbMP6FjooVcjQl5gH/5mwRXACZHmyg4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YcMzz1zIghCa5j7S4Q5ieA1dm6Yi+xOF5o4YkQJYA2q9XA4c3/FbF9LKqYWkibhYVv9quMZ8Dcujn21ALm+vc6rLZ0wnZRGtXzoB8Zstu84/V7YpXdPVi7Vlgqtq996/wNMes4ILYrWQimNGYZTD09zUw5xu0t2YkyLOJKAmJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=qDgjua+v; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="qDgjua+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784194520;
	bh=yRWoze+E/smU6rA6Y95u7tGzO6Y76IPxGKZRDRhFAf4=;
	h=From:To:Cc:Subject:Date;
	b=qDgjua+vyJzF2oj/l99YCge/FHjrMs7+BX3Uraf/7No1ANhg+Z4dMbuv6MGVBj+1g
	 HwVV0p1jphCbqwkIpBF+krS8rI4PVfLjJ4sYVPauLrQhMXvf93GNpXcaP0U84cW9at
	 dmB/ZLUOGzT8qkQsrgKvaKEILYmbcwbkkyurRtwY=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 8CFB3470; Thu, 16 Jul 2026 17:35:15 +0800
X-QQ-mid: xmsmtpt1784194515ticzzfxnr
Message-ID: <tencent_F7CFEBF5E808E2B1018CD05796E66590CA06@qq.com>
X-QQ-XMAILINFO: MNialqGw1zzStIa1G6FORyV6VpSVPcom25+lGFW2SwPiCXlMb+/1USvN6P9jhp
	 9ToZ/Low6K68L8KGpGvd+P7d5gmpPoKZg4jLWI0FVO2sKf2A/VDmwWM6vNr/8eqaismiwvz50RO3
	 oJBIGQWZbft6LgXL2tlB9PjNqr995Rnq7JNixfjkuR2DvndxLUdtOAP9hAKfaEEXXg+5Z6pWi1qJ
	 Xn4XCs+0z6OdM42BT+Fyq8K2WLCTK1QVtjQ1Sx4vJLs9mJvsz0C8AAwOC0Xq1Z0LtOv2jpkIm7KD
	 z3fr5A/qpBvHa3YwjNkC5EvE+Q0Jz286ZsNDulIJ37lxgs47oKp1TDqk5DmTuiu5M1/6sqKIoQaF
	 7fqB75JYnzAxIem4lhucHYr2kSGYBaWo47fcL959I7JQnU7o3M8HW8EDuE4Y3Eo6Ph9g77Ff42G1
	 kfywjTJ+Xemhdg0rRhGbNkxx0n2qTg2jFVMGMYLd65W16duIsgk2tPSwISBEGVhtlfYuDARXx2En
	 W1qaMwjcYqttqjbk+BTkAkv1siktBrg/NoNeTvMoXcCTNAAau+eS/K43QmVETEECaPIHLp+W0HS0
	 0dfCT2JFCeTT9hcD1RrwkjlyskOWhBTjrzqrKkiVjx1+XwoeOT/kGF4Rbrp9Ss+Q1smEA1qfVcjx
	 0+85F80/oNXDPAvN7lmgy7FRmETZp0VBZiGvnDnM8YBaChNRgpQemEyhKYT9cVUTTl62+JcYNYpR
	 63ZVDXQoyPAnWd8cGCLVdcxGfIGZz7YBbs2IgFSHMXpcFqCV0eTshL+z2elfCnBCgKQroYJ4XP9f
	 yglV4gzYeovI2a+UVM4DIHF8+1qjJW32huUFFAIWgIpFkGLvC7qD9ESJfjHIpDtg98yE8BJ/kW4w
	 6O07JNtYLxlv2HLkIbJEiZWYbe5ci3eG3NvwU7k7HXWnXuMHx5u5+qoeCyapSZ8JeAsFRQV1ltg7
	 bW49hiPbzIRQOIBvcbEm0wDtDnO+ShohPbZOygPpODNWLsw1O9eMku/heKTorOi2wY68jbFInknk
	 LE7enxcEQT0gPuqfIl5d9+LkVGl8B8Y19uhmbsUwB+2X6F8JF1lXgwr2lBehQPjOT52Cc1tmXx6p
	 QEBC9tbxOUlIPrWSzzkxgu2jIGhGJFiY0myQyA
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org
Cc: Rong Tao <rtoax@foxmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Rong Tao <rongtao@cestc.cn>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v3 0/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Thu, 16 Jul 2026 17:34:49 +0800
X-OQ-MSGID: <cover.1784194024.git.rtoax@foxmail.com>
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

 kernel/bpf/helpers.c                          | 93 +++++++++++++++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure1.c        | 11 +++
 .../bpf/progs/string_kfuncs_failure2.c        |  2 +
 .../bpf/progs/string_kfuncs_success.c         |  4 +
 5 files changed, 112 insertions(+)

---
v3: Use bpf_probe_read_kernel_str and resolve some bot suggestion issues
v2: Resolve some bot suggestion issues
    https://lore.kernel.org/lkml/tencent_9EC04DC824CBF5124305E73564341511C405@qq.com/
v1: https://lore.kernel.org/lkml/tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com/
-- 
2.55.0

