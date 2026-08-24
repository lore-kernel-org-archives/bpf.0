Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0D43BDB0;
	Mon, 24 Aug 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582298; cv=none; b=TCG57MJ7fEAILnTIT0d0NbQFsiXmIFPM3z0McV9xVr+iuRuUNj4g0jRHZ/UtS1FjcxJZbBPlnaY9vbnpG9jGrfape1Cc4MA4vM43lo5i5bBzuttcQwAYhKvPT9006WrEobgvsURRcgdU/xjw+k3DMnlAOY3Xi8bVMGhghbTYVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582298; c=relaxed/simple;
	bh=Mq3JT+y2wtR59Cls9A4fPzAtPv8G+4dAfs0zBYK2vrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bplce2MA+L46DnONBIUtR4HMoIK2zloWu1AVROrNUMkmXTQr75UMKJDs3PRMNIXDm14hEUng8GzIuOxg4nshMttAkKHUNe8q7EMwrEeywoWuvD3JGni9m++40qCUM3px2NtUYNP8kBZxrHj9h2B8q50eUmrHmPTxTBW4IN1t6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aYTFXDlf; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aYTFXDlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8N
	4RqK7HDllSr4FqoWUGorP8PSr122gThyISmvPSrIU=; b=aYTFXDlf7MI4VSSP2+
	MTjIfKyAyyQdgZvaWfMRbMfYjD+qz6V3nmEa3FVRrgbWBzHMHqqZzlJWfvclKUnq
	2yRH6L48mg1yBCIzTF86J36X9PnIhqyYCNxan7wK7hsxVut41dozvSTCBWAdejZZ
	to9H4pht67xRCuX4utEIEiwvA=
Received: from nec8-i7 (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn+osAV4xqIt5SMw--.54939S2;
	Mon, 24 Aug 2026 22:36:49 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v2 0/4] bpf: Cancel special fields in resizable hashtab on recycle
Date: Mon, 24 Aug 2026 22:36:17 +0800
Message-ID: <20260824143621.2098856-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn+osAV4xqIt5SMw--.54939S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar18Kr15XF47uw1DCF4kWFg_yoW5JrW3pF
	W8W34akrn7JFn3G3Z3Ga129ryrG3Z5JF1Ykr43XryYy345JF9rAr4fKr43CF9YyFWvqr1F
	v3saqF93Ga1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSPfdUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgGTUWqMVwG08gAA33

From: Yuan Chen <chenyuan@kylinos.cn>

Posted in reply to Kumar Kartikeya Dwivedi's review [1] of Nuoqi Gui's
overlapping series [2]: switching rhtab to bpf_obj_cancel_fields() alone
leaks referenced kptrs, because rhtab_map_update_elem() zeroes the kptr
slot of a recycled element via check_and_init_map_value() before the
allocator destructor can release it.

The resizable hashtab still eagerly calls bpf_obj_free_fields() on element
delete/replace, which runs kptr destructors from the caller's execution
context (unsafe in NMI). Patch 1 applies the cancel semantics like hash/array
maps (a3a81d247651) and fixes the recycle-path kptr leak with
rhtab_init_map_value(); patch 2 fixes a program-BTF use-after-free in the
mem-alloc destructor found while testing; patches 3-4 add regression tests
(NMI update, and per-field delete/re-insert cycles).

Verified in QEMU (KASAN, current bpf-next): rhtab_kptr, rhtab_fields (4/4)
and rhash pass with the fix; on the unfixed kernel the kptr subtests fail at
the recycle assertions and the program-BTF UAF reproduces.

Changes since v1: fix the recycle-path kptr leak, extend the selftests with
delete/re-insert recycle coverage, add per-field combination tests, fix the
program-BTF UAF (patch 2).

[1] https://lore.kernel.org/bpf/DKEVG8ZVJDDQ.2G40FTOIZKU57@gmail.com/
[2] https://lore.kernel.org/bpf/20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn/

Yuan Chen (4):
  bpf: Cancel special fields in resizable hashtab on recycle
  bpf: Fix use-after-free of program BTF in mem-alloc destructor
  selftests/bpf: Test rhtab kptr recycle from NMI context
  selftests/bpf: Test rhtab special-field combinations

 kernel/bpf/hashtab.c                          | 115 ++++++-
 .../selftests/bpf/prog_tests/rhtab_fields.c   | 213 ++++++++++++
 .../selftests/bpf/prog_tests/rhtab_kptr.c     | 146 +++++++++
 .../selftests/bpf/progs/rhtab_fields.c        | 305 ++++++++++++++++++
 .../testing/selftests/bpf/progs/rhtab_kptr.c  | 132 ++++++++
 5 files changed, 901 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_fields.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhtab_kptr.c

-- 
2.54.0

