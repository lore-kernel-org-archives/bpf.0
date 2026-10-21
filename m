Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545185;
	b=UcPjvWxGF36EA550UO+8PUWFeX83+35HEBRlJ+OSyhsdEsVaI3SdZP3utHh9rY4II4cL
	 xgthhee+ho8fNfChQ5QXFChs8ZxMdPv6rF9o23KUojKqOJfKjTV5XYXxZoZZbhZDHdTC9
	 6uOiE5LYsL/nD+nfccJ18O2sh6eDvOiBgB9dTlZQ9qLTds1KIm4oNCSvCLF7iOn0Bp3OV
	 YnipsXQsNFTur+f16AoWk0a45SoIvDUUrmkeOy560fMPdv4PhjNxnY85PL7EXHVSC9KGU
	 +aMnbDK7dXJQaJIvSxUvNRk+y2Ll48F/gLPyfr3sSBBtavnx9LgBaTNXabtquiY3EVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UI/8jF2zmRUZFX2qU2BlOXuRON5Yn5pwYG/RJogvZIY=;
	b=jUD2xTar/ueq6rhI//BQ24J3SVF7hSCAW6wUyroWZ+SXdYdRduyG7ED+3L3sZ6CZHFEK
	 vm5DywnJCel6Z/DQpt/vAR1rMTDGdixAv1rI7h1Pkf3NQvvnPjli0beawoALyNZmFxMdj
	 jo87JD5UHmCPIYnx6i6VZ4QG1y/7H1FmJ/ia50y3Pykdu8a5cqTMJx+/WBoqqgY2y418T
	 jXP6bU5/gEWg5zzaRU2O3HBb8eJoyV3JrOgLnqJiH1pt+3dtEa2ZKrgH06W5ckRVzREmf
	 8DjdPBBpLq5jJ3Uafz6lcdKtaQwhEFLUGxlS65Nmbo8/EK82szkUCE0dLetUE7G06pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BoNrSLbI;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924A606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 01:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3924A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BoNrSLbI
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36681e85e87so302365eec.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792545184; x=1793149984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UI/8jF2zmRUZFX2qU2BlOXuRON5Yn5pwYG/RJogvZIY=;
        b=BoNrSLbI4ZakftpAEcfiiqffyKczaJqfGVG9OtV3rrkwxwT/PIINfvPFJGuNQVsNmw
         ZkGyNwlxY2cpveKNZhgxJfORQPfil4NAp+GCN30K+nVGQFEgfB+kgfC1/6ZLrQPlSjdG
         NgDqWSxk0NXBygTYcCGiy1Q5TMHDtk9o0Jut6/HW7DZivgBIP0HGbhuNN+Q8u+qF75IH
         tLGp4yWumWvCiVvh47agvG4eO6kwVOoLIFwFv9fPyPoZ7K1cCgzhm+6vjOPCWDnsKq5n
         qKodwIk7q5zMiKaBQGu9yndsoNi0A0CEJPVE0MOacFJV977KAL+RY72p83aQQT2r6TlV
         4Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792545184; x=1793149984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UI/8jF2zmRUZFX2qU2BlOXuRON5Yn5pwYG/RJogvZIY=;
        b=InJMZZauQImjWKszRd+ss0tE4cgtjMjk8yvJC/iQqs+jy7tANwwq9S6vD2lsNiep4Y
         XZ7jLV1UCgLBc0EFA69WwsUvbotaQ+SpZBno3WiyWk97UoNKeKuMadrozIMS87q2MHVe
         QAaQZygKqFLLQN+EQDGkfSqlzWWZsdlLQGWfOMm/+tvjwY52cO69f/FrWIUyKIZP1yu4
         jwXSsHn3x0YtjhkYS3KekG3ljZIkyaDgw0W4MHus6nXbSaK9RuXBPKjNtByJHEjxm67O
         tuz5u3tkqglGrRB5mOAdY08Rnd3DIIFL/xitchOp/H3rJaZIjZxKhMjiWFh4+3tUAY/o
         gmGg==
X-Gm-Message-State: AFq9FYKbzFDRt4Fie3IrVoVQoSVtJXItLAotekvsimeq2r6KF9aDPWJr
	o7y7f5cON+TWZUwLyuhxEEHzovfq2OzBXQMyQlLDaIiO11lPNmxAfsgGSwPFEn+iCbyAcUc=
X-Gm-Gg: AYBFou345hgodjT7O8pdtuGrbn8nemi1hr9hDD/DtcI7R9N0EZO9rFOlorKiLVMk/Xp
	wK9KCzY9RKf7CfFaJA7KLsCKLQ9eeVoovZayUaSRWFZDT9c9+ht/BDqaQ0sjhke5N5H2eu15aUI
	vAAQle2flZZAG2its2FeQSMUruKtFtXjk9awvndYj/Hqcbu3CwWF8dKZo+wElBuHsb9A1KDW6MX
	qF6O+EB8SUkBe5VMwoGxTJxNUocboCYySNNmtGNJ5o+pvc7fuZct/UnI0L45F6fjTGe8BdtdfIs
	WTXtSpLRR9GeTf5gD7cqfKbw7/gUvW+tLdLRTKZulsH8oA7WbH0QW6DtSlgRbqdJfmKu+NTyCj/
	bS+B5pMgYTHUeDxMq2ejjhjawsZEsu9N8aCtABePKL1xUQwIJiU6octbWGrE7T19YYRns3JOXR6
	2wC7p6zJlAoNO6BR8D4Vhz4wktBlnnUVVLbxHdzRbhAFLsm5i9o3x92mB/q1x7TTX7mLV1WhrNl
	cbmVfS72e6fGD8qB6P6RAMSOxg3eLFfySga4phgEp5qBOoDk+7VZHAPazlqc5ABHl8a8mlzucvy
	CDSWl2W+A+dI
X-Received: by 2002:a05:693c:6391:20b0:351:7ec0:daa3 with SMTP id 5a478bee46e88-3674ed2ce31mr1215797eec.31.1792545184140;
        Tue, 20 Oct 2026 18:13:04 -0700 (PDT)
Received: from localhost.localdomain ([185.220.238.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674206d1f1sm2279025eec.28.2026.10.20.18.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:13:03 -0700 (PDT)
From: Wang Yibo <szwyb123@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 0/6] bpf: Unwinding with unwind_goto and unwind_exit
Date: Wed, 21 Oct 2026 09:12:49 +0800
Message-Id: <20261021011249.17-1-szwyb123@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
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

Hi Alexei,

I tested v3 on arm64. The cover letter says test_progs was only run on
x86-64 and freplace was not run on arm64, so that is the part I tried to
cover.

The tree is bpf-next master b71326388a (7.3.0-rc5) with 0/6 applied on
top. All six patches applied without conflicts, 18 files changed,
+397/-6. Built for arm64 with gcc 15.2 from defconfig plus
selftests/bpf/config, config.aarch64 and config.vm, with
BPF_JIT_ALWAYS_ON=y. test_progs runs in a qemu guest under KVM, 8G and
4 cpus.

Results:

- verifier_unwind: 41/41 OK, no skips. The jit subtest passes too, so
  unwind_goto and unwind_exit are checked against the arm64 JIT output
  and not only in the verifier.
- unwind_attach: OK. freplace_returns returns 9, freplace_unwinds
  returns 13, and attaching freplace_unwinds to global_never_unwinds is
  rejected with the expected message while the target still returns 15.
- unwind_cxx: OK. Stock clang skips this one because the lowering is
  still in review (LLVM PR 233649), so I built clang from that PR to run
  it. catches/does_not_catch and the aggregate_return case pass on
  arm64, including the destructor order and the u128 return in R0:R2.
- Regression: test_bpffs, global_funcs and exceptions, 148 subtests, no
  failures. data_in_arena is 8/8, including the rust prog.

Two things from the setup that took me a while, in case they are worth a
note somewhere:

- the jit subtest is skipped silently when test_progs is built without
  llvm-dev, because the disassembly helper comes from the LLVM C API. A
  line in the commit message, or a skip message that names the missing
  library, would save the next person the bisect.
- bpf_testmod needs pahole 1.32 or newer on this tree. With 1.30 the
  three i128 kfuncs get no BTF func entry, their ids stay zero, and the
  module fails to load with -22 with nothing in dmesg. Unrelated to this
  series, but it looks like a verifier bug until the build log is found.

I only ran with BPF_JIT_ALWAYS_ON, so the JIT-disabled path reported
earlier in this thread is not covered by my run.

Feel free to add:

Tested-by: Wang Yibo <szwyb123@gmail.com>

Thanks,
Wang Yibo
