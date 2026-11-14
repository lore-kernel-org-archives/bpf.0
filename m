Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794639494;
	b=limKdvrzbh2ne/TIRc4MbaFIs26BLyA4boccNGbqIT/IMlpZm2r0UHrexMiqF0Bo4AHE
	 +Dz3+keP/QW55O8iZ1irKqrnfqTJargjgussjRil4Klap9ZUw3yq4XZqKRuXKL7dO264C
	 ISYGFTillopI2Q5mgpvktWHZ81zCaPGH7GKDYpQKw1iIAYtBqhWbsNV1Cz9hnSZWB5weP
	 98/+GNbM/HdUD3SG1Si07UrNik68Rr0DQolV98mqVUblULrhh8VJI1COJV35P+iGkSboh
	 OS//Mc839UdOd4ZcmFhsYRtoXIS7M7TEz7L0fJ0gwB5+K5i/VjBo7EUxdPECc16Colw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794639494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ERt19hwTl9KdBsm8dTCky9arS4UpYC33CQITUvUy7Fc=;
	b=0a3N5ls9IGHtw48veBe1teuYXBc6veuU4+hTWM5emEJI0TBKkxQkLZzFRjIp54las6W6
	 ANw9NWKuigSlRHaCU1D5jZc4ZhjFh0XfcflXCtlbU1Md6xTba9OJzl4u9K9ZqlvEvQ4HG
	 /e9qrdh1/+UEGl+NtuiuVI+CkKAV9N1P1UT0qfvq7d7qLTQX5b9C/xnfxJOkrNpf+Oq+q
	 xkcDmQ3x7j8W9Lo0j6IfR3Ld6N6Q9tWKwcz1JGxyTewVT/JSsA2wzNZJl34l/MUfCK9NL
	 fXGG5PvHbTk650eIOz2TRpf6ZYKo/oimsfjVCtxylYG5LdaQ4y887cJ7M2HGl3ticbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q4ky18Nh;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193DE606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 06:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 193DE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q4ky18Nh
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so5071859eec.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794639493; x=1795244293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ERt19hwTl9KdBsm8dTCky9arS4UpYC33CQITUvUy7Fc=;
        b=Q4ky18Nh1X8Ybygkod2Uz/LMgNUzOU1R7JirxOS/qz5/CiwuXEODFxK5G7qD7NNoM2
         UyTrfz5mlPvT35Fh3pji9fQnBQi8b+PP+cNJAV/Y7ihbtr2FEpMGjyB7J86f1E5ksS4r
         xwI0rvjqsxJp6Y0kxt4OxItj3wyXUUW7MM5tLSEzUNb+vcf/IdplHYubJ6EHmkLHIwGl
         Lh15DuNLqLHVCeorrxXLnBPMogKUll/vopmmAPaz+0sLF4guJxZao78fSLFhMmvr4lTR
         7p8QdqImrg7KPKl9Zy9oF6UJfCmcggeH9MzGj8dLDW78rls/BP4ZbIBi5CHv8ovAFtRv
         eS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794639493; x=1795244293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ERt19hwTl9KdBsm8dTCky9arS4UpYC33CQITUvUy7Fc=;
        b=Me2GP84OcuGHIXa/lbbEskAnwtYSty+KXUHlFjXM4tHDtsC9Y0/3PlxBvkWilq0T4T
         LT0ZIsw6jWSVYVW2P9TkPtHyZQL4WSrrrNPTgrwRJTNybtjo173Br0i4PfiUfnN9BFL5
         HW1hJksoCw0llUv7UkrzJi6bP6/kvIPkErVfM4Sm2IR/ASz8DNLpv6dJEntBKEP0qpp3
         B6GbVw8qQ/3sfLeM2bDZ1vAPGP+iefEGDnAu/fr8A3MrmSazFoaDwNUx3dXCT978TNME
         H4KhMrUeH6XtmcmU51FaQhh/8PAgaeqMxCA2S5KQBeub/ML+iz0/SUbjaxpz5hsjoRuZ
         tbog==
X-Gm-Message-State: APuU4Z+mpQfgf3xhPg4NVIY59enkOQzgF0vyE9D8gHZZGEzscfkGrHGO
	Eoo54/2w/z5i2W6qAJabyzgpb9UN04BbODNr+kXHHaajqe+xHejsl6+pAZRARtR8
X-Gm-Gg: AYBFou28IBDUWCTj+jTa4SnQX2T46VKPi4clZVZezF+ihG3uGKeKsmsU4AmAzb341HP
	V0+d7ZUDvcesV5dG9/1ZLRh8EmKWrt6PKkZfz8uDHFdW6ic6B7R/tplP+I7EEPVhdMzbHmW3VSI
	mcb/RgIob8000iMGI60Mf0Hmv/5csG8TxKS+tJbulqB3OylGcZsOpx5sY51u06fGrUKJRF0tx47
	TYK3YwUcNsC2TNVo/YJ332rDtnnxi6eLERjowGZIQt5Q2KjAaywhhwVuD+rdM57HVhJP8F+p1qG
	NwM8OEvvVFXazl8K9Mp3DKV7iQeVxaKP2UHmb72bcs1nJ/AsJa9JDp+vVhSkmJvFJEIXKc1u715
	0fVxOVK/l4CiG3KocrEHVgBHQvj+JYcZBBnCvFPE4XmLe1fJmC3oLdcFhe91nhU3m6d0ni6SEtc
	p7pnToBbxq8cQW75MhEptyWVvqxnPuzm3JEWIAoCZkjTVrY94jZ5iS+GEXI23TUh5vxyTrIid/C
	nqTWuagHPebSXzjDFGEzu/ylR3icAm2ZbALDJc6UuhLf3OCFl15oe9g3LmRAEz/mlNZ9vYVAkOF
	eE5+xXo6wQbQKi1zl4ZsRE2+K/Oy+Fg0tlehWPqA04Lk
X-Received: by 2002:a05:7301:a4:b0:378:b1be:2d3e with SMTP id 5a478bee46e88-37967ae558emr4824571eec.32.1794639493190;
        Fri, 13 Nov 2026 22:58:13 -0800 (PST)
Received: from LAPTOP-G6J9COQB.lan ([182.253.124.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm17823905eec.19.2026.11.13.22.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:58:12 -0800 (PST)
From: Ahmad Wicaksono <supersonix03@gmail.com>
To: bpf@vger.kernel.org
Cc: emil@etsalapatis.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Ahmad Wicaksono <supersonix03@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Remove accidentally committed default.profraw
Date: Sat, 14 Nov 2026 13:57:59 +0700
Message-ID: <20261114065759.46263-1-supersonix03@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

default.profraw is a 160-byte LLVM raw profile data file ("LLVM raw
profile data, version 10") that was committed by accident in commit
86426a28c52d ("selftests/bpf: Add buddy allocator for libarena"), whose
other five files are all libarena sources. It is output produced by
running a clang-instrumented binary, not source, and nothing in the tree
builds, reads or references it.

Delete the file and add *.profraw to the BPF selftests .gitignore so
that stray profiles are not committed again.

Fixes: 86426a28c52d ("selftests/bpf: Add buddy allocator for libarena")
Signed-off-by: Ahmad Wicaksono <supersonix03@gmail.com>
---
An AI coding assistant (Claude, via Claude Code) was used to find this
file and draft the changelog, per
Documentation/process/generated-content.rst.

Not runtime-tested: the patch deletes an unused build artifact and adds
a .gitignore entry, so there is nothing to execute.

 tools/testing/selftests/bpf/.gitignore      |   1 +
 tools/testing/selftests/bpf/default.profraw | Bin 160 -> 0 bytes
 2 files changed, 1 insertion(+)
 delete mode 100644 tools/testing/selftests/bpf/default.profraw

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index e318a38035d..2a7756b7226 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -36,6 +36,7 @@ test_cpp
 /uprobe_multi
 *.ko
 *.tmp
+*.profraw
 xdp_redirect_multi
 xdp_synproxy
 xdp_features
diff --git a/tools/testing/selftests/bpf/default.profraw b/tools/testing/selftests/bpf/default.profraw
deleted file mode 100644
index e865e87829f8662aa272b0d0ca779c890dd26a70..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 160
zcmZoHO3N=Q$obF3009b6n${E()B+JGExb|ZcYWo}X~!y4U)Rnyov5~~E)paK05RPT
AxBvhE


base-commit: 1440a14a7ed58d5fbc3b9170b68fc977939b4985
-- 
2.43.0

