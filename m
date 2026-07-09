Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FEB332917
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612736; cv=none; b=LikfXZH6UfNZlYn6GQj1AbgYl7zqHNWLj/Fq/xaiaiYn4BsYs7+Iuc224QPdbhv4c7Sv2IRFopPlISyW0atbABmIQN6P5hQTlkJOdxlDVebn+eKAk91Y9OZrJAcZg72vLzvYbC0QUnY53lOdBcCf43G/pVsFngJIrzm+so+7SBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612736; c=relaxed/simple;
	bh=GVCa3Rl2rpRdfxx7hiY0OM4Wy3eUfzquWTyeuZvOl3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ot48en8rw+aU9I2XhdaGQA/LJeIEOvtLxDCpf27ssNaSTTC6x15dTy1rs4OEqj+6TW/IRB81gHdW9t3TahAAjrcObTw+E61ICuTf2u02SftU9oHUQvWAMuovn5fwZaBkFkRoz0AOb/khHq0vFvK2OvdnA+CbmWZuMETVx9M7gMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqSyYbd4; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqSyYbd4"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f032b47e3cso647296d6.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783612734; x=1784217534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gc+RhHRJOsmH1uv7VvDxQODTiIUqicMF+ZgmSpYy6zs=;
        b=RqSyYbd4S4nDG7BwqbFgr5OAfS5r9dSsbFglSCsaMkJZIt2tsONCFmjqHyeqYk3j16
         CDZX4Wt9pEnqwHUJou/uA11nmIaKF2crFF8009a7eIfrgUCPEzhoNj7aFgdE4Ct+QSwn
         tscRoeBy5UwZ4/Kuj33x3AtjlsevB1RH/8u4DpZAC1gzMTptYREh78tLeih4haLLSSpS
         SpBlUSFd79NJGWO+YAkGzdqCQfYEKOV3VmRNMTI3bHCyCS/ppdVH7pASJRQ0NMRbxKnh
         5JRVEz8j1zOSP/GgThump3pBItx5BsnPbXxE7/5REduodSXy0fgxIrRvoa2aIU/C8E5s
         rWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612734; x=1784217534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gc+RhHRJOsmH1uv7VvDxQODTiIUqicMF+ZgmSpYy6zs=;
        b=eEo3Xxc2GlVkiWR7AJkIxrg5/VLBc8lTOOdOjw1MioB0bbu3En4hIEJpjhKZQL5K1g
         fy8dKsccPJ8q8QKhk0hJmIbSXc5dpc7RTEiObov+6f827fybbCZD6eUIR3TcY39HvZ/k
         31CZ5ckyjAgvDUJNO5Dcb5Y9B9cnKEhw44urjBjwtrLoGJQZ0RzQ0mq4O/8K+BiJw4+Q
         dstBvoGKhACAcV7BZd6Sw6x/YPS9a4umqOmQiq1lCbH5nkHWL0S5eBMiFJkCCEXWj88v
         mNRwA8rUnpmnCxTAVw11qEWeZCDjf7Z8WB60IlEQuUDY+g7XzSGaHnbg6ylUon09c40K
         DLOA==
X-Gm-Message-State: AOJu0Yw59RS+OqNBaj9uK9enajFaF4QuzQzc5UqjxhVvBszf4djTV9+g
	vgR7GO3iIzmD/TikuCYzf/JU5CWxNgkKZPymUwkK7L4pH0UqigyYle0JRHJrbnjd
X-Gm-Gg: AfdE7cmnmrvmhsRncF6377bhombAvRMzmb5AjjEIvY0A7VM2BrNWyDSqVmRRdnn8Sdz
	SUwEveJtEw4G24dL/nvtyXTS6ZQMEyYMXAR0frBjry57KfLCqKnFoVLONaecuq7hHj12/5PJ+Sq
	1L1o1RUozfPKSxAsnqak1adodS6C0pEsuEp/wpUjs6BfR5VdaEnwc3nXepuD5ToH+YWsqpE4Ye1
	qEZw1Wc7Dv/uJkl9njYnl/6rnAJ340ggmuCR01V9Mr5Jsrmv0hLF6rxBpVRjgR2xTI3f6Dvm2Yn
	ppGMx5WkVww9ek58a50dpriMWlfqpQ3FUY5acNEXVNbrMT5Bl37ITAlek7LtXMU1Y53ZdEOUxHt
	zcNgaHmizmo4mQJL30cKJP66eHHrixLeb9m7v2xF6fEfe+XMtI1ljFDArC2QzyiTqhDcDJKl6HW
	Xi0isJLALNhI0qtUr9cCXgxKSYbgjjXA==
X-Received: by 2002:a05:6214:5001:b0:8f0:448c:f9db with SMTP id 6a1803df08f44-8fec0bbda4amr85489436d6.19.1783612733960;
        Thu, 09 Jul 2026 08:58:53 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm20418136d6.6.2026.07.09.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:58:53 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 0/2] bpf: bound rdonly/rdwr_buf_size kfunc return size
Date: Thu,  9 Jul 2026 11:58:35 -0400
Message-Id: <20260709155837.1879230-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() stores a kfunc's rdonly_buf_size/rdwr_buf_size
argument into a u64 that check_kfunc_call() later narrows into the
returned register's u32 mem_size, so a value above U32_MAX truncates
instead of being rejected. Fix it and add a selftest for coverage.

Changelog:
----------
v1 -> v2 (v1 was a private report to security@kernel.org)

 * Split the fix and selftest into separate patches.
 * Target bpf-next instead of bpf.

Nicholas Dudar (2):
  bpf: reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max
  selftests/bpf: add test for oversized rdonly/rdwr_buf_size kfunc
    argument

 kernel/bpf/verifier.c                         |  5 +++
 .../selftests/bpf/prog_tests/kfunc_call.c     |  1 +
 .../selftests/bpf/progs/kfunc_call_fail.c     | 33 +++++++++++++++++++
 3 files changed, 39 insertions(+)


base-commit: 36ffa86c42f91c8a57071e024afc4ffb51a8958f
-- 
2.34.1

