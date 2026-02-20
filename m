Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0E126BF1
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606155; cv=none; b=C/QE5N5JPOTt8REdbeNSb9LWV5ynL/2anGc0GoWTCEGNwzdDiaSvHcTdlZy4qYoKtbToQNZT95bWJEAXmkvRhsUyp0zANPtLEelh4nuHjm/pKF3IO9SqHdNJvTN1Ndwn9X6gkrHM/FCqPQifz+RdpiZ59KJ0OlVyCW5Y4+oCP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606155; c=relaxed/simple;
	bh=4iFdTenTyC6jMMTrJdSNRo8bjudctkD3yp4u+/YYA+o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jDM964Kwb4r2tD8/j3ewUOaoyzOJOZhdHc63wLsUNHNw4FHiWdxQd2AtiDxeuYUzahE7WfiBUQ1RLS8cJOXqwzlon1DtOHSwgeNS9baKJbNQfdfgee42Irg6zaJTYbvb6BpQV/xSBSSnTW7IzFBUnky5qyVFsz6Mw9QEWBiHP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=in3Xmxfj; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="in3Xmxfj"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-797de0727a4so21638057b3.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771606152; x=1772210952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWXUG/UGb57F8i96+R8gf7nYhIqF1hGdEKEIHpP/8vA=;
        b=in3XmxfjifvPA48vSKihswlJEyYv6zBPy1gd/wFJx4tWqYMHPVx3n+6RdAF5oAFHBF
         JljowNBNU5J06hQsa0qGUi21B3VOP1N3wnCIF4lZohPUSVHgyMXaffJ6WiSgICi89w82
         mjICG5efYDoQeO43LNnRw3ZTDtEcZxmaA4CNuANdua1EwBUioEBq7s46y5EszkFkDiZ3
         znx+p1hMNzOYbsmrhrhRDCdwmGriq2zZc08wmno6XW7zrYm78eyEw+de5t7Ypf0GUzI0
         yXzn+f5Cf/9zZ4SeSpz9NP1Og6vVZo1z2Yesw7JW8w5cJVuJ60b6ZJr+9mwzANeN3U1O
         8f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606152; x=1772210952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWXUG/UGb57F8i96+R8gf7nYhIqF1hGdEKEIHpP/8vA=;
        b=U+bZwVdTLLTzBmdYZKxbbOfup2VMdBrLA+uaE8DCsERjXXYTvXhrCqZShHOCKfN0bU
         dKpS7gY5FCc5BqL8sL3ZdqkjmXfPvjtEox3vL5qL2ZssNpzsr13BRYmHSdsLnXMNaWHv
         h2ckitcPS/SCK0VD8TVWQ3Sh6MOjMoA7TlNRzhODvPdIURyCxx/sKNDc5NLbgUM3U5Ei
         FWqCfXpu4XwEtKRweFwfv+6OWiuf9YZ/nyxF0K/APrlBEBu8sDFsVB5rtlYfuyZsYcu4
         nYTbLH+Z23ohTAkGGk//31FVp/Hkc79+QM4ZaNgEUT+haDsfjtpODFwg98LNIBalBVti
         97Gw==
X-Gm-Message-State: AOJu0YxKeLjTFDtxKyt/7rPKDeGLPTRF4jAPCjZb0zN4ZqutC4w8XnKj
	QbDp7JXlLyKVRaTmcBzkEh6OpmiP3OZZKbY1BOdyaC/1/p51iRSCXw+8+8624nzMzlgQk/S0X9F
	qJyIBMfF1Ft4I
X-Gm-Gg: AZuq6aK4lV4PTtKrOC87OI35ab6C/j/2+2ZkoXOYolso3mkT/7iTSqF4ndNn+fniPmQ
	KOUMQh4O4woUtLbKWg4RW2OMQMQnu/UvJUCpr6jUSEW77ssXn/2qkbaNcSLHpPcmBM3jhbMzOXQ
	sn3a95wWoOnRPwlRkfXE23AZUCjM4adqS4EOdIr7TxFGQZL6Es5Q65xq4tj9K5c1psjpQ+lTtzG
	qM/saLaGiduRVXtoxda2LNe5+J3zHCyg/4a1qNuTbp7K3DXMYfRGvTGjRk6X1N6FcuMsQY4SQi4
	jRiGjwoS+P0rD3OBMeC8MNpsjn7mnhd+dR/gG9amrAuj41P8FS4nqy0n66ET6R4SQE2RJNNY7oY
	/3Fm2FkCHiPypKCNWGzeGjMIwteT4SXjsI9Mm0oQPWB4YxvDLMtLloei4Yy2aHn0YVZS+fBQsLI
	j3xhBgcJRBGTKecojU8q8VrHzJ1g==
X-Received: by 2002:a05:690c:6ac3:b0:795:1e5b:f72 with SMTP id 00721157ae682-798291796d2mr4702987b3.63.1771606152228;
        Fri, 20 Feb 2026 08:49:12 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c257ed5sm142433077b3.45.2026.02.20.08.49.11
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:49:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH 0/3] libbpf/bpftool: support merging split BTFs
Date: Fri, 20 Feb 2026 11:48:44 -0500
Message-ID: <cover.1771605821.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm extending systing to do introspection on vfio devices, which requires having
the structs I need from the kernel available in userspace. Normally these are
loadable modules, but in the case of vfio there's multiple structs across
multiple modules. Normally you'd do the following to generate your vmlinux.h
with a module

bpftool btf dump file /sys/kernel/btf/<module> format c \
	--base /sys/kernel/btf/vmlinux > vmlinux.h

but if you need multiple modules you have to hack together multiple dumps and
merge them together. This patch series adds support for merging multiple BTF
sources together, so you can do

bpftool btf dump file /sys/kernel/btf/<module1> \
	file /sys/kernel/btf/<module2> format c \
	--base /sys/kernel/btf/vmlinux > vmlinux.h

I tested this with my usecase and it works. Thanks,

Josef

Josef Bacik (3):
  libbpf: support appending split BTF in btf__add_btf()
  bpftool: support merging multiple module BTFs in btf dump
  selftests/bpf: add test for btf__add_btf() with split BTF sources

 tools/bpf/bpftool/btf.c                       | 126 ++++++++++++++++--
 tools/lib/bpf/btf.c                           |  38 ++++--
 .../selftests/bpf/prog_tests/btf_write.c      |  89 +++++++++++++
 3 files changed, 232 insertions(+), 21 deletions(-)

-- 
2.53.0

