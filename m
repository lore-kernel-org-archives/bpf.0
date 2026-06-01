Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29C37F744;
	Mon,  1 Jun 2026 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296434; cv=none; b=YBqwoOTqI8H5Qi2s7w1bPh1K4nsmCNIEy+TmieOwBa3isCiMDdeJS4yBUiHPW0oAbTIzsD+xfPN9vXHsdAth1PbXUfnSqxa0C7WxzY6F7y+VzSAvWVbWX9TS16aP52vnEnCsPpM0fIYqH/rGw5/GijttGm+YAy+gcnxfnCryWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296434; c=relaxed/simple;
	bh=gLr+ClZ3A5b2vH7EvnMG2NEhGarSI3BDjLmxVJtWzic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u72TRj9bWk3rkIcCjeYEV5VSio8qNdst8SybMOK6x5f3B8go9FyTgzgLUwgLqIoBGRCqfOY9rBgU/mMrmaLsTD6uKr3cRrJqzzs1qNMhR5bmywStEWhAxXAlTP0KfMruAOMYvBCkp+8lsbWcs/HluFeOpwMyDudKl7nPQ4p2jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iYeNzJAV; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iYeNzJAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=Ob//Qxk6+Hxjpn1gRrvIAEZC9CyQs/NQBB29gjaxROQ=;
	b=iYeNzJAVBJVTV7rzRyC3YIKeqZCiWZ8qawwgEVNtBdUGP6zT2JVZrCHT39XRqF
	sZyPYefjDa3iN6jafqJ21jLpTXFhKUo4E3OC9uIHSOzTxWxSFBBrYq0gNHD7L9lU
	kL/0LDb7uBVGHtb/K32tNZbsUj66GJZVY3abDlkE6aw2s=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCH9OC9Kh1qSBTSAg--.66S2;
	Mon, 01 Jun 2026 14:46:24 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v2 0/2] bpf: Fix kfunc implicit arg injection and add selftest
Date: Mon,  1 Jun 2026 14:46:09 +0800
Message-ID: <20260601064611.807637-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260407080900.551797-1-chenyuan_fl@163.com>
References: <20260407080900.551797-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH9OC9Kh1qSBTSAg--.66S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xZry5uFy3KFy8ZF4Dtwb_yoW8Gw4fpF
	W8Xw4Ykrs7AF42qF1fZr4xZryrtws7Jw45JF13G3yFywn0qry0qFykKa15Z398trZ5XFW7
	Z3Z2vFZ5CayjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pizpB3UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gCcWmodKsADSwAA31

From: Yuan Chen <chenyuan@kylinos.cn>

v1: https://lore.kernel.org/bpf/20260407080900.551797-1-chenyuan_fl@163.com/

v1 took the approach of making btf_types_are_same() cross-BTF aware by
comparing kind, size and name.  This was correctly rejected by reviewers
(Alan Maguire, sashiko) because:
  - Two different structs can have the same name and size but different
    members, making this too permissive
  - The real root cause is that pahole 1.30 generated BTF that broke
    the distilled base deduplication for modules, causing the module to
    retain its own copy of struct bpf_prog_aux instead of resolving to
    the vmlinux definition

v2 takes a different approach: instead of weakening btf_types_are_same(),
it introduces a two-layer detection in the verifier's check_kfunc_args()
that cleanly handles the mismatch case.  A selftest is added (patch 2) as
requested by Leon and Alan.

Yuan Chen (2):
  bpf: Fix kfunc implicit arg inject type detection to prevent invalid
    pointer deref
  selftests/bpf: Add regression test for kfunc implicit arg injection
    with stale register

 kernel/bpf/verifier.c                         | 48 ++++++++++++++++++-
 .../bpf/prog_tests/test_struct_ops_assoc.c    |  5 ++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 40 ++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  9 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 5 files changed, 101 insertions(+), 2 deletions(-)

-- 
2.54.0

