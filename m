Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087213F44E
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268371; cv=none; b=O6XsZGShsmn5r3OLwV67aHP+nrEYaFbqKGTuypK1VRlmPBk80KifmEg/PwLlVmK9ZbespfRLH7D6JmLUhGQ6vaLV0X4P0BQSA5qBBaEddd2YqJ2dB7slBU7wHeFw2fpxHH7e+DuqD5dvi6UQRIY+w+do9q7BgI/lcvu1LXn5N9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268371; c=relaxed/simple;
	bh=d7kfWksCUZGKLmK/LZaIO17+ZMMLqh6F0WlhUO3pu9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QWz4aa3wW1znMS+Wzm/EFi8wywesTBwhXPo9WfmPEo7HtEjyJzNBfat6zt/vcRK6Cw6hdIIiFaiVXzTgVj+sNo29XhR74dAE/IIir346eXUJNroNcDcIEX2rOAhA3wQPVqaY2ZN1rR23RcHp+IRirvfldKPrUT6jlDgnGYWm9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaONcn5/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaONcn5/"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc742543119so4184393276.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710268368; x=1710873168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o9A2WCdTDFOmY8+ZwuqSNoB39/g8W72UZ7dcrVE5diU=;
        b=HaONcn5/xp/txRaUdbPMkr/90/s88RbEKNkE4j7ojgylsZnKkYCL9HviUCn3InFyQK
         8nUzxflNqLRQ+sAHL3lmkwo67kov+iHoEFLkw1u5X2v1kanM5k0qEB7iHNb41sCdOx+4
         ZzZJKMW0w6GE3pm5ZI6Q4U+PvRXlDqh6U1s8dzL4iaj6mWcnT1HTFSY9JJE5nnOo5fe6
         hx7mbwBPfAvjUEbvnGv95eQMFeFXs7hy+7ZuCx0zmY40+bXiDC3oJVo7EEnR1TK1A7LW
         M8vWc3EwGwj2mT4FeUp+q21qh+ZuC8YIuAt9vNr1yvII9lGsusedORQB9eFrUobbzXy8
         bW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268368; x=1710873168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9A2WCdTDFOmY8+ZwuqSNoB39/g8W72UZ7dcrVE5diU=;
        b=rSwp9zKatlYMiRgW/ZD5rUdTs14lSzjFReoUXLdkzEpHyrgpzMUPfYjks3iTJbDdsS
         AiRjaPhBnq9uTrauS6LbuexEqoeydl5LR07CXTdTxY37aaShOhLkDSlbotLSRaOJOHUo
         326Bu9SUOct6rXrFNWeaCQW1yXI1NOQwhvhcqS4aBac5CQJek7X0MlcJK3owZoy9n/VH
         v87yXt/kLS8UBFxjfPw2Jw5qo/rD8hAU9S8bi2wmyjdRuyPuSio01iDJAFyRw950ohDj
         lHC3C2KRRwI3zFIaZWChKoZn43VYH/1q3qMYT+y3mBRiGOiniUiimIATj4A/6ttaCa6S
         G6ag==
X-Gm-Message-State: AOJu0YzrtqBvuqY48zdCCDoRO4rJw4akuDHnVwMl8LLkm/LCEHV33HjO
	RdC7rZ6Q3HD9SeuftmjRKdju8zIV6mquDREEhCFsbvtNoqHj1UnGoAkMi8Id
X-Google-Smtp-Source: AGHT+IGjh6AIHBSrKkeJWfmEDg2SUMQHyCPFyZAl33KZD318QSyih3utY9lizCGJJenorFYfeZj/7Q==
X-Received: by 2002:a25:ce83:0:b0:dcd:aa73:e349 with SMTP id x125-20020a25ce83000000b00dcdaa73e349mr304363ybe.12.1710268368580;
        Tue, 12 Mar 2024 11:32:48 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b4ae:c2f4:b38f:1540])
        by smtp.gmail.com with ESMTPSA id v185-20020a252fc2000000b00dc9c5991ecdsm1868444ybv.50.2024.03.12.11.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:32:48 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 0/2] Ignore additional fields in the struct_ops maps in an updated version.
Date: Tue, 12 Mar 2024 11:32:43 -0700
Message-Id: <20240312183245.341141-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to an offline discussion, it would be beneficial to
implement a backward-compatible method for struct_ops types with
additional fields that are not present in older kernels.

This patchset accepts additional fields of a struct_ops map with all
zero values even if these fields are not in the corresponding type in
the kernel. This provides a way to be backward compatible. User space
programs can use the same map on a machine running an old kernel by
clearing fields that do not exist in the kernel.

For example, in a test case, it adds an additional field "zeroed" that
doesn't exist in struct bpf_testmod_ops of the kernel.

    struct bpf_testmod_ops___zeroed {
    	int (*test_1)(void);
    	void (*test_2)(int a, int b);
    	int (*test_maybe_null)(int dummy, struct task_struct *task);
    	int zeroed;
    };
    
    SEC(".struct_ops.link")
    struct bpf_testmod_ops___zeroed testmod_zeroed = {
    	.test_1 = (void *)test_1,
    	.test_2 = (void *)test_2_v2,
    };

Here, it doesn't assign a value to "zeroed" of testmod_zeroed, and by
default the value of this field will be zero. So, the map will be
accepted by libbpf, but libbpf will skip the "zeroed" field. However,
if the "zeroed" field is assigned to any value other than "0", libbpf
will reject to load this map.

Kui-Feng Lee (2):
  libbpf: Skip zeroed or null fields if not found in the kernel type.
  selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.

 tools/lib/bpf/libbpf.c                        | 30 ++++++++++++----
 .../bpf/prog_tests/test_struct_ops_module.c   | 35 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 13 +++++++
 3 files changed, 71 insertions(+), 7 deletions(-)

-- 
2.34.1

