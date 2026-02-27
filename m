Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56D3469F8
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210448; cv=none; b=n+SRgdr5R1FibzboLpS+S8vVNa6cH+XnqjhPIUsiy0ICVm5oS3s6K/Hm1J5e7kv+VJLn+oC4qFR4+8QZdJGPjJ2i02Jm8ConsZKVhNeMPUbSbatM7NgomPYd9gbBpaWzAptvRYWUyoOSOGt2pxitbr4FGh9GyNBZ5L+nInOM4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210448; c=relaxed/simple;
	bh=4Mty48+/NMm2pM1VrZeYRZPJ4CzqBPTwcCf92RhsF/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3+vg+ioQTiHX3oe+YgTYRMR+Ws2Wev6kGEyuXxeKjt0KTFSlacjGiatgjp2pqq9fch9A3Bp7PZsBAcYsmRV0pSEYPpx9YcKDKJ7CDFD7Z/nU/9o3ZFPvQIh1ndDsTRqlW5zAvu88bfKIt1e3nkrCGmmLJol3pvTd43TCtjoPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8N4LdfE; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8N4LdfE"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1372978eec.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772210447; x=1772815247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOxw5RpgBFDN5Zq6jjIzB5x8gvJLjX55MjawpG9JNE8=;
        b=Y8N4LdfExCXopfzSa3LihtwCuxv6N585sQkD2oYLryOJTz+Lncw7Ot4eJdbzfmew+I
         SlX7VP+6B7V0jJfrRNdE+UOrsB4stsUytdI9PaDb/Z/MeqtlKgdcjkgDLa7glyH5s+/5
         JgYVBslKzTehJ3OAr4Dkvw8UJb9pKXmZmRdgcs7fK5veWRJhzK+A/pGLyPLswh9DzEWK
         Q1L+yMdSDj1yvSqnAexHgEdjxnPLZwMs6XZ2wL2gUo2vfXd5zuxItr+KFvraoqZbgaGq
         p1h+QYnoJeH15q/br1IiRKaIQ2s0SvMksbBG2pg0HTck13qa969vIwlFZpH0m2PYtFHS
         RuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210447; x=1772815247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOxw5RpgBFDN5Zq6jjIzB5x8gvJLjX55MjawpG9JNE8=;
        b=BylzYVtx8N3eWDAF81z7Vx+gqaaN4km1ZAPBkEfzxpnZeAn+JTu+YlPaMomhvrWkLD
         Lb92j7Vh8BJlOThF4R39kqEXjc6V2o57sx3kIWpshs9TA+Q6Ky7qGuUpFQMHQaVlK+xO
         ZTP5++zgLKQVcwffjoBmx70SVp51iN5yZlNWcdUoSmDg8SLiXCGaQCbSric+tW+ry4YU
         A3h18I5wWUjTu+dS9zcXyXxWrQtCwEf07nGISlfF2WTxW7o9MBxzDhtfam5Nqwl+iTPd
         vV/ttmzTUS0L2VmzGHWEDPkkzt54fQMYoSG8LEkwfCi6RG96T9m14dgqb6yHahf2B/jF
         iDbg==
X-Forwarded-Encrypted: i=1; AJvYcCW/4ofLItO13jkYKbobns1OhzQN1wyH2hJNYKUrIrmhZFfFDEnhk9OFtHrJQAsZAY4q65k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/mg/GMKuZWweKCwl9umCafffXdEQYNtypk6EaXsTfIkH3qVJ
	IzHgKEHQTONqr79GzhN0tTPqO3QcZRIXM3LJFk7YRJMR7ICqBYNU+llb
X-Gm-Gg: ATEYQzx5crSR4N21D7j7bmnwLW+e19Xx6Bx52mlXzNyyGRYMGlWAbdjMYr1q1IAhVp1
	ho8Sn98g65fr2eb1PRHcg1VOsKYpvatHDavvJ16sKqTP1Mklzb9rhWPcDJl9+V8DChpgCLyXTA2
	HpdXQ9ZQxjqC0Qjm6qMN2/GRPEW5DuInah9UC98WK3Lj1+ijtR55MNR/dDpHmgDuhy31Z1t1HJZ
	iACdCmtGU7lThTH4fWscXTIbtmzp3OHt01xXN5INRIU7lQz7I8A3cozQaa9PToe5g+OqsL/VU8B
	UbV8akjk/jrFV5qI1pVUPz3pMQj/gL2aE60D2Pb50h59s8p0sQIryj2VdVrCwfnr41uM8kytnj4
	IwhkZJ521uCnFbjB9ta5HRqxjDS4IztTEMmmputu36r8BLRgFsgeeUjQ4QPVdbcBm74+CLyyttd
	KdA9P4Y3Ohdf3+Pd3GGIw+GSNQA4PK7wuLGvv+Irjuo6gpWzM7ElcPuhZ9jkihrCGcWDM5hGLV5
	VFUYWjXDqHvy4DDkmd95pc7gik=
X-Received: by 2002:a05:7300:a284:b0:2ba:a387:92f6 with SMTP id 5a478bee46e88-2bdd0fc8189mr2558964eec.13.1772210446551;
        Fri, 27 Feb 2026 08:40:46 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdef9700ffsm220707eec.28.2026.02.27.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:40:46 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 0/2] selftests/bpf: fix bpf_cookie failures
Date: Sat, 28 Feb 2026 00:40:35 +0800
Message-ID: <20260227164037.84110-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1/2 skips kprobe_multi subtests when bpf_testmod isn't available.
Patch 2 makes perf_event triggering reliable on slower systems.

Tested:
  ./test_progs -t bpf_cookie/perf_event -vv (30 runs): 0 failures

Sun Jian (2):
  selftests/bpf: bpf_cookie: skip kprobe_multi tests without bpf_testmod
  selftests/bpf: bpf_cookie: make perf_event subtest trigger reliably

 .../selftests/bpf/prog_tests/bpf_cookie.c     | 29 ++++++++++++++-----
 1 file changed, 21 insertions(+), 8 deletions(-)


base-commit: f4d0ec0aa20d49f09dc01d82894ce80d72de0560
-- 
2.43.0

