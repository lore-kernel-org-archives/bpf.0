Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC03D88E0
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370781; cv=none; b=VTXRiJzsnxtEkq8nHORDcE4P/8xy+66fEcXBd20nPjzshfO0QyKkWpJz/kvgFzR97gc57mL5Z0y/9E4MgH8+VQ19bsy7jhv+91yaL+PNW4i9xywpvpMONXr2ciFrU2DUmhA5B2UfgPsh0TR3mlbsWno9fTzGMI5X7+hwjCeNGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370781; c=relaxed/simple;
	bh=ZPYPPKo+SXjxtg8ZkHgdLylgXjKk3ywEmI5a8N49kG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUwpIUqWWF0GpqnVWRSUIKe7q0S6cPC4fMm4GD1i7piH7Cip14oENmEFeMmHLuaI5/fS6x+M7cV+MSkzXWt0Ga6htKb2FwAKaaL+GniTzNvKR0wT+TKr/rLtXCPQTvttX7qiaq9UJTX7IJ2eeXYVewnKHmUpPxwuwrk2C7fphoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcJPYI3L; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcJPYI3L"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-7f4f0d1779dso987772a34.2
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370778; x=1790975578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/eJvr+C0gXvAPFnLNCYErzICFs9FzkQc+hmViZZg3JE=;
        b=YcJPYI3LXKRb3xNG1GyOkyHSn7kJPCfkEEvVFIe80FYTDesn0HQiPXVA0f6XrNp2oo
         0Ch6D3TskGu+rVKArCMi+ryA2fE7sGdGl0mS9pCwqEvvo3xmsp4OSeFPNfUT/sokCzpV
         pvRJ0FefnMkGV4+KPWOKrL4FMgsoP5SeqUeNy1dP4w2zMnJ5HWeARqIfqK0h48mb2Zi4
         pOeFF/VL1EHm7ti6o4KfdtcnD9ciZCgIZTj/a3kkqlm5A9Q9ktwIifYsOgiQ84rGvhOp
         eRjkTQ8pnc6bq1AMFlaFNI22t+Ve3Hb+0pUrLGBq4sM7nYiB+sxGeunmJhTMfYgolsKD
         Jdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370778; x=1790975578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eJvr+C0gXvAPFnLNCYErzICFs9FzkQc+hmViZZg3JE=;
        b=aQQ5+WsRfiFGLu5g+YV9Ddi3DGXiSXdTV1fupy3QMXfZbShECYffPNtMwKIxw2gDZH
         BEXEnCTmECvqrzEZ7lDBaBlGZ/8AwEgmiB7VIAU+ru7wMOMmlbJtzoBWl/PHzSpyCNKk
         e7kt9dKGq3A/GpegFZZyZhN06m2ckrNmCt6LS243UkupNLF7zNeJhjpBB99zrjniJ69/
         q3I7q/QlpWvpEZvry6gJ3F6Vwq51FWhpF4Bx9JMZFaD31w1Z3So7oAgRx1/38P3CkYwD
         r8/QnTZKllLP8YICDC6QYwQQAJjky12QloTaTDNz3DbVqEFgBME9+jGYJ+2sg3XDU3mW
         ARFw==
X-Gm-Message-State: AFuF++nKpPLGyy+Sn3aOyMloomgUr0eSA219FTjD1ZmazOA8fTvdWwiB
	rdF+SClERFMFZJ720FGXCif6FAQCYKpwyYlNuFjvkpME+BY8s8fq9EIcGESYMg==
X-Gm-Gg: AYBFou2GOpZT9rhj+a6lJpAraAa6LxGSVKUZhbtBSel0CDptyDSZVIMpPFud6nPBYFM
	uLkUFqhMlYzwWZZIXoE7iUZHLCcvvNhIJcckFCA0DK/k++ZjbwOi6ry25+aEOQbydiIMg+OWZuJ
	yzN5HfXP1ADJUHG2ppT9j46zjLB1fO9xJKLhsAwJrc1gduYax1JKB4/uzoxHByZ80idry6wYiru
	jaHTA86WMcMXPA9LfLkjYnn4YFBlTCy+z9JaiMzO/++ha8q9yhhHZ8xhMT9YmzPCZYQaOb79Aw1
	DL+AsRWw2WJhGjxMSaHiJn8ZXZU9QOY6Ezlf0xP7EmdhaPnBJa1MSDK8jbh7wUZmVz7uULDptsP
	qXBdnutfBNN2Y4LZO84tlIFBNCTbHNbNeWRFgmOfh/ILGYAwKqLpt4O1yoVD/7/eA4aHQaEnde+
	rRVGmfasTdbSJY80JC079egXVzn0svhLHyijQvU7Zc7EY0WvJcKw/djUe3qXXLeA==
X-Received: by 2002:a05:6830:3912:b0:7fa:ac4f:7a2 with SMTP id 46e09a7af769-8178317ca28mr8081294a34.30.1790370778347;
        Fri, 25 Sep 2026 14:12:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e33f6714sm3370162a34.0.2026.09.25.14.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:12:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/12] Unify subprog argument checks
Date: Fri, 25 Sep 2026 14:12:44 -0700
Message-ID: <20260925211256.1834061-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Helper and kfunc calls now validate arguments through check_func_args(),
while subprog calls still duplicate much of the same validation in
btf_check_func_arg_match(). This makes common argument rules and
diagnostics easy to change for one call kind without updating the other.

This series builds a temporary helper-style argument prototype from the
subprog's cached BTF metadata, then moves each supported argument class to
the common checker. The last patch removes the duplicate loop.

The series is organized as follows:

- Patch 1 fixes kfunc nullability diagnostics after wide arguments.
- Patches 2-3 identify subprog calls in common metadata and generate the
  temporary argument prototype.
- Patches 4-9 move scalar, untrusted, context, arena, dynptr, and BTF-ID
  arguments to the common path.
- Patches 10-11 make packet-change tracking common and move memory
  arguments to the common path.
- Patch 12 removes the legacy loop and checks all subprog arguments through
  check_func_args().

This follows the helper/kfunc argument-checking consolidation:
https://lore.kernel.org/bpf/20260911220415.1396439-1-ameryhung@gmail.com/

Amery Hung (12):
  bpf: Fix kfunc nullability diagnostics after wide arguments
  bpf: Identify subprog calls in argument metadata
  bpf: Build argument prototypes for subprog calls
  bpf: Check subprog scalar arguments in the common path
  bpf: Check global subprog untrusted arguments in the common path
  bpf: Check subprog context arguments in the common path
  bpf: Check subprog arena arguments in the common path
  bpf: Check subprog dynptr arguments in the common path
  bpf: Check global subprog BTF-ID arguments in the common path
  bpf: Track packet changes in call metadata
  bpf: Check global subprog memory arguments in the common path
  bpf: Check all subprog arguments in the common path

 include/linux/bpf_verifier.h                  |   4 +-
 kernel/bpf/verifier.c                         | 285 ++++++++----------
 .../selftests/bpf/progs/aggregate_arg_func.c  |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  11 +-
 .../selftests/bpf/progs/test_global_func5.c   |   2 +-
 .../bpf/progs/verifier_global_ptr_args.c      |   7 +-
 .../bpf/progs/verifier_global_subprogs.c      |   2 +-
 7 files changed, 136 insertions(+), 177 deletions(-)

-- 
2.52.0
