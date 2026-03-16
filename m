Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89263313546
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677553; cv=none; b=Jk03UwxqdGHWcc5hLjmD4ruqHTTtdFTWW3TxFFwxj6URh/voBhw6tXnIXSB9IJvSXYkfZzXOBo3ArVVaV1zf2LQVB4isDI70Pmy+FcwaHvOCU2WlApcgLVA8iGJnBeWEfLgECbNX4reOHqoWRBRwGGxxTDHt9qFDxBihi28xBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677553; c=relaxed/simple;
	bh=fitoimnsDUwzIRIhBY9H3ZWcGsV1HfRcFqZWwrvSguk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjPtINYBt+hoL8bydC9eI/2m7c6GKjlqRj834ZITHLEsms3LCx3+3zz5v5WhAzKFADsv8M9dyJd9P8X66CMpebPEsSu24xuC3kDVobWrRyA2+FPRU38unaTmtPjRI46vFnjAh+4r4UomR7BwlUvbi6iZM8MdDEnh6ugkrCiM1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=vEDNMOQb; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="vEDNMOQb"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89a1347051aso74890676d6.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773677550; x=1774282350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss2tHWBmM1f0EJ65JH7E8GSfWiqV+4N+4nGqUQy7Pqo=;
        b=vEDNMOQb42q4pd2G1QzTZjVdvup5I1YOc6cy6ycpsdN5jL37GMdr8NN1rtWJIToOU5
         XSsTa7fG4uXzaM4NYdc/dPEkJKHDN6smivLfOg9dj0OLI4BQXlZdj/ZuJcxV1aYkMI2J
         It7Y4WtmaaqAFqATxELvLNL4rtLIYDQLp/d2y7MudeMjvMLJfXiUssbn/ZZcHxYWFaQO
         ssdaliHpR/f1pei6i6JmOY6k3bj9Xia8r7krXiiHcdoYBPN8ldGbbe1zQhPBIIc3Kv27
         B+MEevDJUBLetLN+uCVETAh+Befp5igRhe05lUW3bTspk2RwEyT1jo70P3fEj8LDqosz
         0jJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677550; x=1774282350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss2tHWBmM1f0EJ65JH7E8GSfWiqV+4N+4nGqUQy7Pqo=;
        b=dIrr2mv0cnWtHn2qKc9GnOgxY0UHllFlO9jm3IOfparYc+GMkYYzjT8A1onftQLd+6
         hW7wuNsRUzhxMJh9jy59HrrTF8UPVYgj4Uog7MinMehi1AA7jQkz1o/QzWQF2wPJd8O0
         Cd9GnqY6q+QwGNyMdC7QB42/vGc8q7TjTGShioZoWOJst/o2AFMFwD67t5HiuG6IaQeY
         S4HA9z5gZn4EpFRRzdG3EvBMFoOdc80+Ez7LOSrkTDFp2QGe5Wtmy9gJTYYJpWMW/FTN
         VzYSbOgEBzwRD01tckPVPSVDNs6DCFyuR9kPjEX33zErzI2ttq2cvlTSUrQ/PqhJT8Ts
         Qhpw==
X-Gm-Message-State: AOJu0YyroiQ14YSFh7n7yKHof76ebvEL5ulqK6SBctcm+Ln9pqfS8PPZ
	RWMiBlJjTt8dQl5AN2v6COrc36IpnnR9VtgrzRPmQ4bOhzzjK9/f/xuYH4O4/6k4nYtrrRERMiQ
	m6PCwNL0=
X-Gm-Gg: ATEYQzwXw9YFds6RDlfN+4WShviN8RvBlQnucv0phC6MNBnhPNjHevfLtX/H2/2LMEI
	6P7hi+4+tBohwW505tuywwcEGo8eoy0s7PC3Kiav9qpe3/TYljZnA3kQPnJwiGI3jBEwNNjgRak
	8ADS617nbdgiD78Og7fzQWxcMtdM/GRW/cJjr3iB54Xd9XSsH9Kr7nbwDB3gKoi91UA76iePJL1
	UBX0425bHhkWkkV+y2C+eJLJlHGx2dNVKvm6hyUzkmUBV1zzagARhc6Sajj2jbr7nFKtWcv+5eZ
	l9Ea1JyG0imzZMkgQ5WKUcqGlGiFb7gk/Y68qdRi7MYV/TzOtJsz2fi5lUd5EanYrZI+9o7tcA8
	E0jmltGLMeAFJNcZKBPzkn8YEsHqzLpz0cnZvDm1w6JALMEr8GIPAsWD4ij+eKBPiNwQ+jHeHlS
	IzQH596d2UUV26t1MiU0srFg==
X-Received: by 2002:a05:6214:1c0c:b0:89a:18bc:2b18 with SMTP id 6a1803df08f44-89a82067114mr196382156d6.60.1773677550153;
        Mon, 16 Mar 2026 09:12:30 -0700 (PDT)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c463b0806sm54022626d6.49.2026.03.16.09.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:12:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/2] bpf: Relax 8 frame limitation for global subprogs
Date: Mon, 16 Mar 2026 12:12:23 -0400
Message-ID: <20260316161225.128011-1-emil@etsalapatis.com>
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

v5 -> v6 (https://lore.kernel.org/bpf/20260311182831.91219-1-emil@etsalapatis.com/)
- Make bpf_subprog_call_depth_info internal to verifier.c (Alexei)

v4 -> v5 (https://lore.kernel.org/bpf/20260309204430.201219-1-emil@etsalapatis.com/)
- Move depth tracking state to verifier (Eduard) and free it after verification (Alexei)
- Fix selftest patch title and formatting errors (Yonghong)

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
  selftests/bpf: Add deep call stack selftests

 kernel/bpf/verifier.c                         | 76 ++++++++++-----
 .../bpf/prog_tests/test_global_funcs.c        |  2 +
 .../selftests/bpf/progs/test_global_func3.c   | 18 ++--
 .../bpf/progs/test_global_func_deep_stack.c   | 95 +++++++++++++++++++
 4 files changed, 160 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c

-- 
2.49.0

