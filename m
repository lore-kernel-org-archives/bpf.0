Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B983F86F7
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545996; cv=none; b=rsUCKoCKbr7Yd8hizklBsT379vpyUseHetOdag7zcrxhKBVHoc7uJ2RDEl+s4O2i8LN0Q8EtYQk03R9fRkTfAy8Z3yQyvQqHn66ugPY+nDAo7+CwMCDtmmyw73apa+W+m1+QuyTr70vqhE8gBlp15Hg1rbCgFq9Smixlr7aAxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545996; c=relaxed/simple;
	bh=yDTgRVrqf1Tr6C+iS9j67wLsZFvzJj7bbcbksxkkSqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HPfptsoziZt33nlYikCbxmCcp60MqbVcgZBE9BcrZbb6/iu7H5ajy7fB2HKCkNSEZl37Al0E6Bb9P7l6BMY9umd6/vZScs82mefBClGP4WfF2OIWlkl9+HLop4pXqNPDAZ+x5hsUhglP3OL30ZXkKeI7DUpBkVfOY8+TDfgkvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d2avIMeP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d2avIMeP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b966dd74so41849635e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784545992; x=1785150792; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fPnERnEjMoji588/XXFZAA9xQr49KY92MrtyF+kfB94=;
        b=d2avIMePt2QJYn1Ddt8ZZkvF4CBfmZcqfXLMAWB8BoGTPK5F7EXt8M32hK8Swbd+Mi
         Ne+BvU3O5eTCSjYXGdCKpwI7fjQSYSd1lkYZB9Oh5sZTh58XDKWcWb8zpYhqTlN3KCno
         9rIdXqxq6L9+wkwoyR7xzLPRWsPxm2zHPu47CzI/Cm78WtiUGRRxrhXbw3v6xwQgJA17
         6Ie5TjLIDH7ERRGvFdqenF2sdWYytIL8IUKzL7SSEybd82HQ5OZR6XvSZ1EuKAmNxFPr
         xWH6Pt0sD/3i/0KtGow39EH9Ck5r2kLaCVSDmi5oYJn9zlJY5NSblIjDbVmMwbhlR3wH
         pfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784545992; x=1785150792;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fPnERnEjMoji588/XXFZAA9xQr49KY92MrtyF+kfB94=;
        b=M5DoXGpSl/D7wl0ODCBZeJw5jRBOVu+XL3V/sgJPA4e1wExkjt4dr6tb0bDPRAuvyL
         2/+fyX7WlN4KvZ78T3nVRCjUYIE8zTZSal8fCZ/FbuKyo5jLX50mIn1MlYQc6KpgNR48
         eQB2K5UsDmlUu+Juiv1rwND+PnPCTbMLC/M5o2Zp0mLk43EHhyLLtrXFStib4LwPaVLp
         FCeYKyLPf8k6gEWCmcLqt94ZM3Kcf2+dJ8WeS8xDVSV29u31EO4SyNJoZoPY+xyL0w3e
         fZqN+ERiZFuBEyOZDkM8wCXWodDnt+ibSY87ei7kXb2WicVawTmjXAsAkjd/Q2O6LG90
         AmTQ==
X-Gm-Message-State: AOJu0YzVgJwfqPtDmmb++j/I7IoQ9z6tZsv23XbT+7fsMPZfWIAxSzHI
	LI5VuEnjsDoZLLHS5IdJLfP6lbTsrr/+P/j9fFURvlv6hrQuPotTMCEjZDOGnP4UCAU=
X-Gm-Gg: AfdE7clHMq19HhN1YN6e2efqTm64H2P8/DSTbQ4re07+UAIRaoab+1VFILJ8gvI89Hy
	e5fLjWUafTP24sTe8pLBaFnzcrYWxPEjbCZB9hmekThW3gYm3SfPj3CbYUPnL62ok88yUAk+SnH
	S2kgvlMwMfuhzVI6FbSIZK15TAR/TMXBskdj9dG9BummP20Gzfgu1qzy4qyIVGX/kyVBs74fN0S
	J9ZyZRm9af6IH3nD7M28EWdJ0/SYnzHjbKxUBuDCEKJOMJkGghmJTlr2KjmjthUqhxd0TjzdSNQ
	JlyCgEhd7RkOsg6FyFkFsbVZjc4b8p7nyFnWIcbqowajyjkKDkYEg5BnyT6GlfPPS+pkR29ROlD
	OMxBSOUDFOZWRqRNnNPNA7EmWlBdmT8OPK+Qb/cN4VSCdPMIE09n/xUYva5UOPTu2rQ==
X-Received: by 2002:a05:600c:820f:b0:495:52fc:e235 with SMTP id 5b1f17b1804b1-495532489eamr102047185e9.15.1784545991892;
        Mon, 20 Jul 2026 04:13:11 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:c3e:cc5f:6c4b:db0a:5d2a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c1eee43c99sm8798235e0c.7.2026.07.20.04.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:13:11 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH v2 0/3] selftests/bpf: A few edge case fixes
Date: Mon, 20 Jul 2026 08:13:06 -0300
Message-Id: <20260720-selftests-bpf_fixes-v2-0-b450eda93dfe@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMICXmoC/32OTQ6CMBCFr2K6tloqgeDKexhi2jKFMdKSTiEaw
 t1tce/ye395KyMICMSuh5UFWJDQuwTyeGBmUK4Hjl1iJoWsRF0ITvCyESgS15N9WHwDcVFBoyT
 oi6lqlppTgN1IxXv7Y5r1E0zMUzmhFQHXQTkzZMkH7NGdR0URQvYHpOjDZ7+1FHnn/4Ol4IIrJ
 cvOdpUtbXOjmeBk/Mjabdu+XHmACucAAAA=
X-Change-ID: 20260710-selftests-bpf_fixes-06e9a2eb3c67
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1784545988; l=2760;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=yDTgRVrqf1Tr6C+iS9j67wLsZFvzJj7bbcbksxkkSqY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAojgNCZZr+9KtZtO/ASmZtKEEjCx9Hz6MqIcqvxyGTgZZsls+G9tJCuU3ILNAEoODIsZzHXVXg
 lvFJH54sE8wI=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Hi,

Please consider merging the following fixes, found by means of targeting
BPF selftests through openQA [1].

[1]: e.g. https://openqa.opensuse.org/tests/6087703

1/4 ("libbpf: Search /lib64 and /lib in resolve_full_path()")
- Hit by testing an older SLES root filesystem.

2/4 ("selftests/bpf: Fix lsm_bdev dev_t encoding mismatch")
- https://openqa.opensuse.org/tests/6087703/logfile?filename=test_progs.tap.txt#line-2706

3/4 ("selftests/bpf: Install resolve_btfids.test.o.BTF where the test expects it")
- https://openqa.opensuse.org/tests/6087703/logfile?filename=test_progs.tap.txt#line-3332

4/4 ("selftests/bpf: Install bpftool where test_progs expects to find it")
- https://openqa.opensuse.org/tests/6087703/logfile?filename=test_progs.tap.txt#line-806
- https://openqa.opensuse.org/tests/6087703#step/test_bpftool_build_sh/1
- https://openqa.opensuse.org/tests/6087703#step/test_doc_build_sh/1

The build process is done at runtime with BPF_STRICT_BUILD=0:
https://openqa.opensuse.org/tests/6087703/logfile?filename=serial_terminal.txt#line-1937

Assisted-by: Claude Sonnet 5
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v2:
- Squashed first 2 commits
- Removed redundant copy of bpftool due to TEST_GEN_PROGS_EXTENDED
- Installed *.BTF instead of only resolve_btfids.test.o.BTF
- Link to v1: https://patch.msgid.link/20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com

To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Shuah Khan <shuah@kernel.org>
To: "Alexis Lothoré (eBPF Foundation)" <alexis.lothore@bootlin.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Ricardo B. Marlière (3):
      selftests/bpf: Fix make install target
      selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
      libbpf: Search /lib64 and /lib in resolve_full_path()

 tools/lib/bpf/libbpf.c                            | 3 ++-
 tools/testing/selftests/bpf/Makefile              | 7 ++++---
 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)
---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260710-selftests-bpf_fixes-06e9a2eb3c67

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

