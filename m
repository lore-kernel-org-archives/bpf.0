Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B82FFDF7
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089076; cv=none; b=pAwGE/AV7gTJ0umM3B3AtidNNq/TD6/N5Ou37aGhKv6Ei+S25bYQLr5Qicy4kHMV+GZGf1g+R3sYcUScOoOwaSWqwkg7cxEWQA7lcaKwEfbrqGneUL5jNKwVC071QM822/1QRtMot09b40zj83UoEoY63xS43VWw9oC5sjQ5YkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089076; c=relaxed/simple;
	bh=zKMM06qOvu/mCMXUXxru04nLnTga5FtrLZLZn6JRFDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEoHMOO2a4NJrCtZlR4zPePS0Qjw4PxDK0tm6VLWYbryASQpWRuvw6bDFOvfbFyHjj4DNkzlsFvkCv7SdxkUXRcoY/s9C4mrCJt+Y4H8H6X16888lCh6K6pFtEOWJFARIBDKEB5EYgDTLHFlAOhohxZHIg6Jw/vnZ4HgHAIjTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=I8ZEHmkR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="I8ZEHmkR"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a321cc53so134946391cf.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773089074; x=1773693874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9AMIbr67hJmoCuieEFaBPzI9QZ+WTZJBhqy2Onhh18=;
        b=I8ZEHmkRXi6bRolekvRjRzl+1qIwn3MPZzHzHlNWAS6ouD4O/cSIuibbLOmuZuSk/z
         IF04TYsbPgQB5x5tP2XqPsLPP/9MzJw9MlNPqmrQO9gNCzt6bVp0QK57rzqjCRNBR01g
         kli3n5WhYzoGZ6MJn/7S8itt9FJfmSFUZ1ZkNjl1LY9DdbtJMdvbGHJOWuyvXgZMYtn8
         e7j2dMo1OtiA6i9+Vyia5PqoddJ8UCgExW9v65WFuWjY/i0q+4kqaz0T+bASgevG5V+1
         bvsDYwYVeN6HQV755qi7XkMg9asH6Dmk3liUEq/i5rjm2h6VJUZ+MY6G5SUiUHQJGJCt
         9Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773089074; x=1773693874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9AMIbr67hJmoCuieEFaBPzI9QZ+WTZJBhqy2Onhh18=;
        b=X8f8ITg+I+b0ftOp6Gux3MqclcqVM2a4Hbyuo3zHbpJquzAlmTyCIMrqRJtcRX2u5C
         PK4y1s9uIYMcPaX6Vrb7wDyNil6QWojTpQUmwuas8YV3x6xYaJGiLdRaa4nMzMBbN1Wd
         ym9wsYJf6Ct9BlCheXp5HUj3qmTAqXOpO1n8JuaC7q3KO0cPpKOVLrwW4Bz38K/6Cl5S
         y1feNn1jscshwPoqkpfquFVysO4Dp2NJaXEVW9x3zzaOJ3SUeVuveyFF93NUe7xAOUPW
         NcuxbRWGtBu4NO5jTSuCvdciA4/VAQwOtB0+3a9q3ceQtaqlywGiEw+88FxIyRjAYsxi
         Wf/A==
X-Gm-Message-State: AOJu0Yz5hfpBv3O4yEJcabgI3lrY7uAN9kTQU+86OCS2+o0e7PDYGGi8
	g8ioC+RKpLRdT5gr8LzzS8fqmFFEgWsPEQYtnlFXARIJKTvyPBpImzKL89wsSZaCSmZFZY3JRgT
	qB4Fp
X-Gm-Gg: ATEYQzyV+h9q/xvOo8r9EDwr63bggkpQydmVgRiKzddkqtVUNAB2nLpZBKwe0NKUvNt
	PUAmXOy21kI2xvNoNLbDJ1/PF4Cf5v1ZxFlV+Ws5OnabIy3zUVQNq/3JQ/JXk1LFg1IHyU9+kV0
	hz3j+FubxDdcPXnunKZZDWP084/h7w6tvjJ/MWNB9V8xoJLVKHPdM13VZs+N1Fz36fnb/K8fXin
	1EwqniP9CcykrfrzK+az4p8YCxlHIH1pDhmQQpoQoe8rzUUO/uqnzMq7s3Rn15bqXwulL+azsgm
	gUsHWVxMqh+ZE/NttZ+pqwEejQmitP/fU6LNtAot8drRBGvtn7u5IamCNHG/KyernugVpCl6jTi
	NYirxjnkQ8jVhddY0yV9V662H9VVhVljVVICRbxRJ3/A413rsxYchGvXPZgVtZVFM+rsVtv93Mw
	9LAvMOL6+hVgtNAlNblsy0Zg==
X-Received: by 2002:a05:622a:1a94:b0:509:18f4:6dba with SMTP id d75a77b69052e-50918f47210mr70539001cf.62.1773089073790;
        Mon, 09 Mar 2026 13:44:33 -0700 (PDT)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f650ec74sm72109841cf.1.2026.03.09.13.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 13:44:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 0/2] bpf: Relax 8 frame limitation for global subprogs
Date: Mon,  9 Mar 2026 16:44:28 -0400
Message-ID: <20260309204430.201219-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier currently limits the maximum runtime call stack to
8 frames. Larger BPF programs like sched-ext schedulers routinely
fail verification because they exceed this limit, even as they use
very little actual stack space for each frame.

Relax the verifier to permit call stacks > 8 frames deep when the
call stacks include global subprogs. The old 8 stack frame limit now
only applies to call stacks composed entirely of static function calls.
This works because global functions are each verified in isolation, so
the verifier does not need to cross-reference verification state across
the function call boundary, which has been the reason for limiting the
call stack size in the first place.

This patch does not change the verification time limit of 8 stack
frames. Static functions that are inlined for verification purposes
still only go 8 frames deep to avoid changing the verifier's internal
data structures used for verification. These data structures only
support holding information on up to 8 stack frames.

This patch also does not adjust the actual maximum stack size of 512.

CHANGELOG
=========

v3 -> v4 (https://lore.kernel.org/bpf/20260303043106.406099-1-emil@etsalapatis.com/)
- Factor out temp call depth tracking info into its own struct (Eduard)
- Bring depth calculation loop in line with the other instances (Mykyta)
- Add comment on why selftest call stack is 16 bytes/frame (Eduard)
- Rename "cidx" to "caller" for clarity (Mykyta, Eduard)

v2 -> v3 (https://lore.kernel.org/bpf/20260210213606.475415-1-emil@etsalapatis.com/)
- Change logic to remove arbitrary limit on call depth (Eduard)
- Add additional selftests (Eduard)

v1 -> v2 (https://lore.kernel.org/bpf/20260202233716.835638-1-emil@etsalapatis.com)
- Adjust patch to only increase the runtime stack depth, leaving the
verification-time stack depth unchanged (Alexei)

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: Only enforce 8 frame call stack limit for all-static stacks
  bpf: Add deep call stack selftests

 include/linux/bpf_verifier.h                  |  9 ++
 kernel/bpf/verifier.c                         | 52 ++++++++----
 .../bpf/prog_tests/test_global_funcs.c        |  2 +
 .../selftests/bpf/progs/test_global_func3.c   | 18 ++--
 .../bpf/progs/test_global_func_deep_stack.c   | 83 +++++++++++++++++++
 5 files changed, 137 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c

-- 
2.49.0

