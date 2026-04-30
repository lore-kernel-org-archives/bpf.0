Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CC19D092;
	Thu, 30 Apr 2026 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528105; cv=none; b=bThF/8IdW9Remv6HN5H0k9Z1ggGmOPgS5ST+/7cveJImRQtg86xOjuTlLMBpmRy01Dln/LINt6DOjVHGBQZw/UEfPnD2t1dFHssIQBRMkkr9bL1uh0I+hz8S6vSLVsKD/ApOp0ec0Tq9PlXTCXUsiwjF+o0QabOXAj1REi86OPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528105; c=relaxed/simple;
	bh=1WY75VT/w0VwlkAL5Y7AXVveyinjDi2Vi4M8ASUNo+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oh2mryDGuZXFlRtFBuczhBjuDLbvRdJSKG23vi9I4wOwPqVtFKFMH6ZoR2WQAnM/1pII/iMX8JNSszmQgmsTud3zW/qzHUum/4pftTwO+h1Ueq4xqCLu1+prTdD3YN4Q4prL0+UlgYwYo2bXXUAPzhCSc7IAwzWnGQW1EW+t5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hQd2mI87; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hQd2mI87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=NG
	BKgR7lNIumhboN4r81aFGQc+BncWhO/SMIisMEHLw=; b=hQd2mI87vY3PXUhntz
	Chjg6T+MptEUqQxmoRdI/JKkXlK9GsDAu7rwGrIxr3HGhmaBdW8pvqMrOVM74nFp
	QFfdNy8mg7z7vTsz8/fZGCrN/pEEvGM7rgbIHSHSFlpJ+/T3LTyB5x3gooP43n0x
	GCkMdJGI+3cu3uLjjmPFoY778=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgD3R+zQ7PJpAzMpDw--.47615S2;
	Thu, 30 Apr 2026 13:46:57 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [PATCH 0/2] Enable module kfuncs to override vmlinux kfuncs
Date: Thu, 30 Apr 2026 13:46:54 +0800
Message-ID: <20260430054654.38907-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgD3R+zQ7PJpAzMpDw--.47615S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryxKF47trWrZr15Ww48JFb_yoW8Aw1kpF
	n3Gr4Y9r4xA3sIgas7Jr42vr1aka93WrsFgF9xXa4fZrn0yF4vy3Z2kr1fAF9xJ348AF10
	gr1Iqry0934UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsIDcUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsxSHB2ny7NRb7wAA3w

This patchset implements kfunc live-patching by allowing kernel modules
to override vmlinux kfuncs with the same name. This addresses the use
case suggested by Alexei where modules can provide enhanced, optimized,
or fixed versions of existing kfuncs without modifying the kernel, see [1].

Currently, when a kfunc exists in both vmlinux and a module, the vmlinux
version is always used, making it impossible for modules to override
kernel implementations. This limitation prevents useful scenarios like:
- Testing improved kfunc implementations before upstreaming
- Applying targeted fixes via modules without kernel recompilation
- Providing vendor-specific optimizations for certain kfuncs

The solution involves two coordinated changes:

Patch 1 modifies libbpf's find_ksym_btf_id() to search module BTFs
before vmlinux BTF, and encodes the kfunc source (vmlinux or module)
in the instruction's 'off' field during relocation.

Patch 2 updates the verifier to use insn->off for kfunc address
resolution: when off == 0, it looks up the kfunc in vmlinux via
kallsyms; when off > 0, it searches in the corresponding module's
symbol table.

Together, these changes enable module kfuncs to take precedence over
vmlinux kfuncs, while maintaining backward compatibility for programs
that don't use module BTFs.

[1]:https://lore.kernel.org/all/CAADnVQLVQW-Mb_d+zT+aSpPOZ042erPVcSHVBx9PMGET+a754Q@mail.gmail.com/

Song Chen (2):
  tools/lib/bpf/libbpf: Prioritize module kfuncs over vmlinux kfuncs
  kernel/bpf/verifier: Support module kfunc resolution via instruction
    offset

 kernel/bpf/verifier.c  |  5 ++++-
 tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.43.0

