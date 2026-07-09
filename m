Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61B329C54
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638167; cv=none; b=DFldbMbQ4BVcmacEgeMYJd6UR/Z2Mob80kbdppL9XPlRj5Dj3DHmQiQXEz25A4Xt54EEej14N2HqWz/rjzunmeFsT6IkMUeRn9S1EWWEGd+f0bx0Cev3aworg8uFMay7nrH9gWWVxAsJvu1KhjQ4t7y7ut54D2ZSt0xY2zj/Zbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638167; c=relaxed/simple;
	bh=Hq+QwzyGq0gYWVERmzUt4NV8pZ3y2Z5qZiIztNz45HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WihvZb21faBe2VtXvuukTxmIYRt5ZuJKKMVaf/kvApAQb/LBYAqiaOQaU15ArLybcu2gNVeOeSd1BLQVXCGBtD0HTjGpILa0DW4TXr268W/7ZjebtyF0HIfOGAd+CH1hm8kMevUVRJfvG9CuKM/nH0CimKS+Qfv6WB7aN8XToUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIItmaow; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIItmaow"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9f69eeb6cso240448a34.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783638165; x=1784242965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sYKVvIr8AjcLqkihUpNDigsrIJJDSwibyST7zi1EiEk=;
        b=OIItmaowYunPJJV7v0k+C8Wr3M6k+M/FFUNQ1AVOIbji+5S/p57WrM9msQkTdIi9XD
         2b9wJquMk/VGrKfFFkG1OiN9wcpk5OjTdPYpxNH6Hfxdof8fsAGr8Z4bnThcyhGJHrce
         HVpWv+QH6VVw/Z0+uMUxKB7tGR0zuRDJRDkxUnAFD/fSDyUTJiH5JRFbl9GH6uqJA1S0
         21LXXVYpIVNNwHGQKt+MxCcRvpS5agJ+jz+NxKaX4oJTO1nDW7mYwrr+8rrgpgJ3XV1o
         BTnD8QscGwE8z/9i6FvgNE7dUQkSRSxHuUq18okbng5AeOtP8s2TDbTzBl5VpJcg9hx6
         3u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638165; x=1784242965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sYKVvIr8AjcLqkihUpNDigsrIJJDSwibyST7zi1EiEk=;
        b=OwIO1pKbpC4UgEftItJwgPGQFcap3qwEpksOo+xPE7XL83eARA4KsKaYRHTwnUq4GV
         Sg6Wg6kx68fkEMaNOrReFkBgzZGYq5nDUOuRKg1vnp8L6kGDmlqRIH+fzHkOV1mlUgdy
         oZVtzyL8C6cIqXZtf40j7PKlvxRGWviTG9gCvK3G0gKKs6bxGvGJH2iReH8Qh444pFEv
         F9ccVM5+4prfhgnJn4IHG439zLGq4YaH4qm9ewkIY6PIlkelhMNiqaaVyAzQckq3BwSt
         Ygaj+R8jS2zTF1B/FpZLcBg4RMBq5Oh8eRoSdp0CLJAbYmop5GjwZfQHvOy8rz3ItvU3
         Xslw==
X-Gm-Message-State: AOJu0YwuEGJMc81YitTW/MpUCZ9sb6vHNWWqCpD7IcohDU5G5JIcKhq7
	+E0TwI7Qce4ntIPtAmlupsbGJs+mexfKof9+Wdd5BBDtpvppYT+u0zbCKoaLgw==
X-Gm-Gg: AfdE7ckRQcs8RIsHVJMS8ksJXA0cFU5OprkSzcg29TDEeQQM0XL7/o1Z4QAxNEEYr6n
	gQlVoK9Q0qocF/YJv4LKKGoPvwP41pW4e4prHUIbZ0K2uTFwz4DlaBn9ZbjuRtUZWNOkS0qqWun
	3vmGQ355nDeKp2gqqBQ/qS/4RkoigYkVQwnLh9S15Q/lwF0NvHFxUA0ZUiclDFAVIDcXnskkLxg
	8aBFfR6K33aEly0AOglq6Jx4rjrarDMWaDrxuiRMAh8vUv9CiLxit4uNPVLyyR2bSXkMcP24msz
	2evUSTIK/XQPb5Yepb96LfLhY6DkLOzb1jiv5pBCsvGTbRIdqwPyetWwu8g9oiRHE5jr3Ee/bXP
	ncZ9c2OTAR176pJ07AtKIrwIIH6LM6CWKWL0Z0po+Ouh3A7KkQ/HSnzCyAfyrIOJYSuI0cz0mqo
	BQFg==
X-Received: by 2002:a05:6830:82aa:b0:7e9:b537:102d with SMTP id 46e09a7af769-7ebcff9cb08mr7178903a34.26.1783638164964;
        Thu, 09 Jul 2026 16:02:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b07e329dsm4954322b6e.17.2026.07.09.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 16:02:44 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/4] Unify helper and kfunc call_arg_meta
Date: Thu,  9 Jul 2026 16:02:37 -0700
Message-ID: <20260709230242.2003459-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I am working toward unifying helper and kfunc handling in the verifier.
Historically, kfunc verification was mostly done separately from helper.
This causes code/logic duplication and may introduce subtle bugs as the
same checks are implemnented differently.

To address this, I plan to unify function call verification, which will
operate on a common function call descriptor bpf_func_proto.

As the first step, this patchset merges bpf_{kfunc_}call_arg_meta of
kfunc and helepr. The structure is used as a scratch pad for different
helper/kfunc verification mechanisms. The previous object tracking
refactor patchset has unified some of them. This patch handles the rest
and finally merge the two different structures.

The next step will be generating bpf_func_proto for kfunc before the
main verification loop and align kfunc and helper argument types.

Then hopefully helper and kfunc can go throguh the same call verification
path.


Amery Hung (4):
  bpf: Remove dynptr check in check_stack_range_initialized()
  bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
  bpf: Unify helper and kfunc allocation-size argument handling
  bpf: Unify helper and kfunc call argument meta

 include/linux/bpf_verifier.h                  |  55 ++--
 kernel/bpf/cfg.c                              |   2 +-
 kernel/bpf/verifier.c                         | 253 +++++++-----------
 .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   4 +-
 5 files changed, 146 insertions(+), 170 deletions(-)

-- 
2.52.0

