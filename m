Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED11DE8BF;
	Sun, 10 May 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778382312; cv=none; b=JU7ah9REUQZoGxo3LoymQq4aXMOG6G2U9GZZNwLnUlEgfUYavEZ2/bK4nXOf5lWrr1ab9uA+zmt9KwJptzn5gzQB01qXQuMoRef8EZ7ZjMwUpN9g3TnY2wInJSrROWBzd4yhkO0KMpXh68mWyj1RQ1UVygSBAyxGdvSa/hIIrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778382312; c=relaxed/simple;
	bh=9PNhv6rZaOpSHi4WqwIawCKxB38Hv6i4TloZs7czF6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjWI3mAF7Fn1ySLMaHqbaAQeQGADpQfoPpsIDmm9GFcb68avomKuNnivNdO+TfEnyA3Ex9pTOelXHdAD0Bh3KgYAiY9LtgEsiGZaFlSUWadfqEw4KQx3mkvLiUEFbTciIEIKcW8Y8oF0oV8CwGmICYEpKXHZl9Ax9Z+t7e7mOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BIcdWBUM; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BIcdWBUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lO
	N0wGKbGg/N6mKIGdamcR+BYqfb40Q/Ny2/zgBNHgA=; b=BIcdWBUMkKikag2yw2
	9AZYh0D1eUzomiIGYxlnIaza+E7ke+auuth/CD14Wh+xU1txmfsg827BN6Mctc/6
	XYU0ZanbJGyMcTVXXfUh4U7XNlhcatlPwXO9Ob8nzswf3C8qIPkZhuqHnWwnTq4c
	v1YBCVFU45bcUzlExhkxcq5fk=
Received: from song-MS-7E28.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDn1+4H9f9pWPexBA--.7967S2;
	Sun, 10 May 2026 11:01:28 +0800 (CST)
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
Subject: [PATCH V2 0/2] Enable module kfuncs to override vmlinux kfuncs
Date: Sun, 10 May 2026 11:01:26 +0800
Message-ID: <20260510030126.27853-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1+4H9f9pWPexBA--.7967S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryxKF47trWrZr15Ww48JFb_yoW8Zr1xpF
	n5Gr4Y9r4xJasxWF93Jr47tr1YkayfGrsFgF9xXw1fZr1YyF4vyF1Ikr1rAr9xJry8AF10
	qr12qryj9ryUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziU3kiUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBswjZWWn-9Qh8hgAA3q

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

 kernel/bpf/verifier.c  | 12 ++++++++-
 tools/lib/bpf/libbpf.c | 60 +++++++++++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 16 deletions(-)
 mode change 100644 => 100755 kernel/bpf/verifier.c

-- 
2.43.0

---
changelog:
v1 --- v2:
introduce namespace to specify module name

