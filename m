Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B113E02A
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770528808; cv=none; b=riB+5BeHGpe/o8zcKsbhzkTiH9gUH7inexZH2/HstezeKqYf0Ch1SOdlkgXSWAs1+R57Qrga2Qr1WpQzEkAv2wloGLgBCgMrRMdAkoWjUVktajuRgbkogNlg0SxFK0WPkp+1gcCzHvaEynV0IQJJezQ5bRaMqbf6oxYLO1r6zvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770528808; c=relaxed/simple;
	bh=FD6BjmeoFI8+bG22TYqQeE6y7DzMj6HiX+tZhWNW7w4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RImNQNcjhbn5knw8vnyAlZO45LhoLH2fcqTZDjX78lKRdHehjfmmyxZaVTxr3J5ihw8IU/XM2VsJMFE59V7yT0SPt9s0sungt8RNhIj3EzPJ886axJnic8x5lstl5S6m1FV2OtRbjqvQG0spH3Qkbi5Qrma8ahp3kIficwTp9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp0nCmxM; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp0nCmxM"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso2940443b3a.2
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 21:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770528807; x=1771133607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYwL1EESl4uI9GdV+OkRykkZGeDMHRXuiQ8c1/130nM=;
        b=jp0nCmxMrLPi2wMqF+slQ4/cGBAiItalXEixb6uzppjBl7SE7m4+JyD/ksKRy0z9Lg
         1yKAVSiX5/svSTtR3dQaDiGzspaKxvz0+SRawAllqzkrwZQTDGP0IBddIhcVWxuuiVnn
         UqNE0Ou8Q7UK9Y0ZRJxYEQ+86rGFZASpwOL4k1IvEf0m0+ii71BYetU3U4bjWpUqmHEM
         icfpWtnCBKtyo7ZAtkuaPeszAIbVPZBISOvkdWjv+8XYXsUNkyTbyO4kMpq+zZ5WwzCy
         PzkN9LccAY8NDGUGkZjQ5qIn33Y1E1CiqpudKmSg8nC3716zO/EtP0lauev9DiNaxB69
         tBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770528807; x=1771133607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYwL1EESl4uI9GdV+OkRykkZGeDMHRXuiQ8c1/130nM=;
        b=f1sBLwO/h6htHJMReqNHaPO4lnDnIxXDnwSQvzrGbw6dr4UrWg37HEE0QtRgJKS7Vt
         cRLVw5tU3ELSpl+6TD+SIvzaDHJ6AEe8EORsDK8aXPn94zUZkfvxja1M+ldwvUx1mobD
         afmk53sk3nviImxdGGzlO2hwjKkECBCIgTmKe03AtLZ9cZatpxUOoAl6SMBRM1BPojbR
         cGCNa5Skp/wQaHA1saEbF+3TrH0nTh++c3UGqP3ot8k/PNfy4NRmKJlzCKpnantocjr2
         fkz74Zmxzy8ln0+WIyObxDStX/7SKMWhwjMWuwnClHX/IDA15+zH9WHiW41csCJB/BBl
         OtMA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPPR0252fvdf7nQcaJAeSCSxF0ddgqR//aANOZnRgueOmcH5mONq8TFsyEfhxf7kWG6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYQ8p1tvYt9Jqx0zKfuxsxaqPwUcaI2J8l4fdLsM+U+0QyTnM
	ylSJSjfxR46TM9qmGeHi8b4Y4hbZ0geaIqyuFuTYe5toFKFY+aCOn82/
X-Gm-Gg: AZuq6aKkm+cHOt678bVqYX/BppN6POTH9m45Ik8wbVIgSy2MmrLyuDJm5+DGKg9JgFv
	i0QqU6Bwtp+OM5WIRZrlPmCuYApGyKTi+F3fyW8P5QlYmG1rMcCxu2CCC53UIQ8wHmtSkO35CZg
	qtHI0fxDPacD8+mfI2CG2wIaHI9T/+i4y+PGgf+nNDxgnRw8O6N/PPex9d3sW9XGY1CmZC1b2i+
	2fqYV0xscyQ1LGw+qNIh2xa96Z2XD0UFR5ge1x3P45ZRz7PkLM+XTYhwsVZiWee2OdjNEl+eWr7
	2REKIltOaKb7zjDmz2Y4XmoCnN5trkz6U+TigCRkQakNpFTWg65U44YXQfw56GYN159azAgK4Dm
	3sMYlDNEbjz+Y5JDCQsWJhEGGt/bHVTGhQk2rIOxDwLFxWiNvvvWEjmdYovVeBOOIDV4Gu02Sf0
	hEoaWDfBf8
X-Received: by 2002:a05:6a00:aa09:b0:81f:4063:f1ef with SMTP id d2e1a72fcca58-8244172c192mr7635880b3a.54.1770528807304;
        Sat, 07 Feb 2026 21:33:27 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418de80dsm6067700b3a.62.2026.02.07.21.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 21:33:26 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	bjorn@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH bpf-next v4 0/3] bpf: fsession support for riscv
Date: Sun,  8 Feb 2026 13:33:08 +0800
Message-ID: <20260208053311.698352-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement bpf fsession for the riscv architecture.

Changes v4 -> v3:
* fix the build error
* v3: https://lore.kernel.org/bpf/20260206122002.1494125-1-dongml2@chinatelecom.cn/

Changes v3 -> v2:
* fix some comments.
* v2: https://lore.kernel.org/bpf/20260206115823.1070354-1-dongml2@chinatelecom.cn/T/#t

Changes v2 -> v1:
* use bpf_prog_calls_session_cookie() in invoke_bpf() in the 2nd patch.
* v1: https://lore.kernel.org/bpf/20260203055231.1088479-1-dongml2@chinatelecom.cn/

Menglong Dong (3):
  bpf, riscv: introduce emit_store_stack_imm64() for trampoline
  bpf, riscv: add fsession support for trampolines
  selftests/bpf: enable fsession_test on riscv64

 arch/riscv/net/bpf_jit_comp64.c               | 97 +++++++++++++++----
 .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 3 files changed, 79 insertions(+), 22 deletions(-)

-- 
2.53.0

