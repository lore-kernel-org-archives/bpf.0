Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E7535CE
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366106; cv=none; b=kEgjWosJ7QgRznXIeiQHt4/VKI1lHQdrgrkfv+9NPpgWR1alOTDMVBBdaecj3aVdCEqio3IPqAC78Oz/lwn8/pQZCrqH+UUCHKfsXOtLVVK2SfKfflHNUWGRSRcpROd7j5bxGVM+M7GZybP97yzF6+lJuqyda09SBdRpKRHjCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366106; c=relaxed/simple;
	bh=a5i1IwWu+cEoud8Oi6bLq8QcSmqrWMW1nZghqaDyHIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AUcNh3b66T8MjvFZ14JN27JNdZvCIzlGrJzeoRJKu0EgbnXo/D5GJ5P3sY+9TgaSipSXGilfTTZE7bHrCf0ssBVZ0k/6YsR5BWgQxRwZ6YvMLFfhi1mxwJ2c7+T0rok6HqbkGCedcEyptMMS0t6VJtJP2hqZqlly/YwE3fY/SlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHsuXu7H; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHsuXu7H"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a068e26d8so3460987b3.3
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710366103; x=1710970903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPB0xtNu2QrfEvyegFqobXEbpn0tXJBka6T9XyBh8Co=;
        b=NHsuXu7HoAA7LwsIFv8AYIj8y4j1VT5BXhGSt1CWsZlo46/MPVsWkuo2PimEQvYgbF
         2oT4FVcNz+NPZtonVpJaVmTdF9t+1cbdZiBnsJ5x8RJRMCDIwCfcnDBe0Lrzs6zAdJaH
         J67qMuFKEwnBvG4aAIzu3sFiiJR+MLUXWLq/xvd+sdzw6Spvp6zamrFR/vmyQNsDv8rj
         YnOT3AA7fjR5Y94ta4xmKAs9PKwyxodgkeYX3e8ivACfUPrGmwSBs8ZmuIAYMK0sbDkh
         yinN67t0iAzrQSBtWM0/VXLg7PtafuApO5Exm4bjvCMqaetpKWnksT5qzDzvLXFse82x
         gLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366103; x=1710970903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPB0xtNu2QrfEvyegFqobXEbpn0tXJBka6T9XyBh8Co=;
        b=Svi18XpBS8veZcZ5xGZsOrVMSz3y0gMi7XUuqlQLHxb64jlDeAQO8UkdY1DfPCCs0M
         LDrirDkomdYAcARA7WaHrGtroRLH77LJBrGESP8ZdeFwbBb/meE8dwObVdOMD+t/aiLa
         pcWxbNm4Y8d6a+69E8jAP/a34qAOaEXv6dU7Kq4/VLtk6ajUvOkL06nemB1ZrNOefzE7
         zAQeqWaVOyUxls0AtefhcWPOjm/eCfMPmtPC5k0P3ebZZ8xjnr94YgQn2I6PJQhEa726
         WEhvf6KPJuwvQp/YbY4WKPN5qoqzvz1/LdIil12ENuvmuiuV7xYVcAtjotg6w0A65QrG
         mGmw==
X-Gm-Message-State: AOJu0Ywj+S2+g/bBGsMo9ktyuTIi6P1TIujOhC+BcZQHjIlSYdlrrzpu
	85HNzNetTKxlIBEKAymqsLCHC+MCmTRyTAFxdQot2th9IrqqOVXCeSf9jXs+
X-Google-Smtp-Source: AGHT+IE6I/xuKztEFZ75nAtvc9/ZDFfP9lG7iXiQZFHyx1r6JbMMMuFQUVT4pna0GPOM4Rj1YernoA==
X-Received: by 2002:a0d:d6c9:0:b0:609:513c:a8f7 with SMTP id y192-20020a0dd6c9000000b00609513ca8f7mr4156926ywd.0.1710366103313;
        Wed, 13 Mar 2024 14:41:43 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:30fd:440:22c1:8047])
        by smtp.gmail.com with ESMTPSA id y74-20020a0dd64d000000b00607b3038a7dsm2678950ywd.9.2024.03.13.14.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:41:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/3] Ignore additional fields in the struct_ops maps in an updated version.
Date: Wed, 13 Mar 2024 14:41:36 -0700
Message-Id: <20240313214139.685112-1-thinker.li@gmail.com>
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

---
Changes from v1:

 - Fix the issue about function pointer fields.

 - Change a warning message, and add an info message for skipping
   fields.

 - Add a small demo of additional arguments that are not in the
   function pointer prototype in the kernel.

v1: https://lore.kernel.org/all/20240312183245.341141-1-thinker.li@gmail.com/

Kui-Feng Lee (3):
  libbpf: Skip zeroed or null fields if not found in the kernel type.
  selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.
  selftests/bpf: Accept extra arguments if they are not used.

 tools/lib/bpf/libbpf.c                        |  24 +++-
 .../bpf/prog_tests/test_struct_ops_module.c   | 103 ++++++++++++++++++
 .../bpf/progs/struct_ops_extra_arg.c          |  49 +++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  16 ++-
 4 files changed, 186 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_extra_arg.c

-- 
2.34.1

