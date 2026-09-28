Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09337204C
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619258; cv=none; b=GplIAxG/6LLGdCiG6vq+nWul1t3ImBL/2KccB/XuEkCRhxvBa4hthqpP1yuxBAkxkmKA5+8Kwv6FVIUTJf1aL4RrIun1YMzgaQsIJZOkWnBMeYn6MzXgsCSSNCRpAUvIlFwXkL4jxzk5sR+G+nPbivxASyErCBejF+e9WocEmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619258; c=relaxed/simple;
	bh=LM+M80QwDRRk+Jdz5eGa82f1bsNGNtVGH6xFRpqdSR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJy0IVACse4/Ph1iypHEWgw9Mtfj57U7IThUNia+TOXacl+OZaGs9AyP+QhZjC7Xfz92VQ2sLLuU5h8RJwjlxAiNqQZRpO5m2X0t2zWFh9olWfmil7d+GOGMZXUbz4MvWYJ2Mdr6JZdpmqA0vFItBsHhzxJLnPZJTvTqE15XNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMIcMXes; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMIcMXes"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-81ad35a4608so70803a34.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619255; x=1791224055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=El1CUcQcdnRepz3zxv1YbWSd5fYer4OyyMawBr9e1sc=;
        b=eMIcMXesPiH6aYhhq2dWfGOjoVhnCruLkSTdWwK/OWafN+eBBS5UcNR0sVnqHhesai
         ofejR3V5SCyLyN5xHHi3ADLHCqYilEuXUQzNo/oZgMogqKc8XGV9mhdR+EMFMDbjooSe
         vdvmrnDp2tqq7S7j7d+8pSgRSe4A7Z8ibV3qOwMMklLfP7ZBv0qZn5moxWC1JkOBMU17
         XMiBF98Mqd2zJRBByxuaRER9/XDqSipJqb2BaXLdlnb4mMo87lUgBZX5PKufloDiWp++
         ZXtkZ2U3G1jBUEZIB9LOHTPC6AsMZh3O4Wzx8YlHvzl1O11Qwiwspc1MaQhXfrGLA+/j
         1pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619255; x=1791224055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=El1CUcQcdnRepz3zxv1YbWSd5fYer4OyyMawBr9e1sc=;
        b=USTnDqL8A7/VK0gAPmgk0R6E56tsWe3LlFyqFln1Pv/Jh3PND798kjUYCP2CpFH5Qp
         YRQQmg7UBq7NUvYOhxprKssN4fQ/n2/ZIFpuSnyjNUWYAdUnZ+MR2Cmmx3tjLqHsr+q/
         mCUSuM+MrwmTy+9yHicmh29wKLZ9SdgNvXFQMWt1MjWenkIamgWTrEvt4iwK1/Ion6M6
         qQYmPFdVWCDtRSfoX3yUnA+7+m0egDW0TPrUhOu8uvEwBV205Y1JYSp5JGYejo3WDaC2
         GJ5eJTn1Jq1WGuUPul3biJho2joPECZ+FaWUUunfIAcM+hN9IOY3j3hGCAYdiFHiLb/f
         AvHA==
X-Gm-Message-State: AFuF++m7fd6r0Pm9NM5FphVOfOwOXyOD2N9RP3z9b6y+m+2+XCXHhVvm
	g8rwCdtXpZYUn0LsOJ966CBCxW6wWmlW1gQLaRBxzUMALPeNkqSEfqvqvKHusg==
X-Gm-Gg: AYBFou3Fc9JWaIdpj3pJbiak7Max/7vXc9Kq8OTVzxiyBhOQDZ/bZvvTi5EAm3u6YH/
	GH47MoDlPV9CxtSZ3VdsZwXuqJrrLkUmO+vi1WSF/O2Q+8r0HxN87JhH9ZkbhDdL8svn6ZK9NUu
	gkmhlJxMXzPoCXTHMk5FHH++BjpsGE+d/ToBw+s4fnoi8paHZU/8WSxDzgh4JgQk+qFh1cirYD3
	qPRIF3HcHjcqB/o9n6malXo7W0r6kiWw20jmqSDEllKQTHR7FbYn6AqB0u81AsZc7Gjks2vxKkw
	eHH6GsT/qSvFzGKDwWR/eui/Iw4V50AG3cG0ZK12MT7EWgZSTGYLEplgZl6uFU8mchNME3/0e1N
	2vBx/fPobL/iSUATZ8N6I9foic6xlgeoXAJwvEgL7i+TXKPeuTa04TMClK8dkkEXi8ZqPOVsRrp
	z0mVPOcTVpVVFDUdL+yTOYSXvZHUhoXFMk244TdzMln3O7dkRJRQiTvqJI6KibziLmD1HaI/Y=
X-Received: by 2002:a9d:66cc:0:b0:81b:ae41:af65 with SMTP id 46e09a7af769-81e737bd4demr86776a34.3.1790619255301;
        Mon, 28 Sep 2026 11:14:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81dcf09f01asm1459376a34.3.2026.09.28.11.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 00/11] Unify subprog argument checks
Date: Mon, 28 Sep 2026 11:14:02 -0700
Message-ID: <20260928181414.644158-1-ameryhung@gmail.com>
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

- Patch 1 fixes kfunc BTF parameter lookups after wide arguments.
- Patches 2-3 identify subprog calls in common metadata and generate the
  temporary argument prototype.
- Patches 4-9 move scalar, untrusted, context, arena, dynptr, and BTF-ID
  arguments to the common path.
- Patch 10 moves global subprog memory arguments and their packet-change
  check to the common path.
- Patch 11 removes the legacy loop and checks all subprog arguments through
  check_func_args().

This follows the helper/kfunc argument-checking consolidation:
https://lore.kernel.org/bpf/20260911220415.1396439-1-ameryhung@gmail.com/

Changes from v1:
- Extend patch 1 to fix the release and iterator BTF parameter lookups
  after wide arguments (Alexei)
- Keep subprog call metadata local to argument checking, leaving callers
  and helper/kfunc handling unchanged (Alexei)

Amery Hung (11):
  bpf: Fix kfunc BTF parameter lookups after wide arguments
  bpf: Identify subprog calls in argument metadata
  bpf: Build argument prototypes for subprog calls
  bpf: Check subprog scalar arguments in the common path
  bpf: Check global subprog untrusted arguments in the common path
  bpf: Check subprog context arguments in the common path
  bpf: Check subprog arena arguments in the common path
  bpf: Check subprog dynptr arguments in the common path
  bpf: Check global subprog BTF-ID arguments in the common path
  bpf: Check global subprog memory arguments in the common path
  bpf: Check all subprog arguments in the common path

 include/linux/bpf_verifier.h                  |   6 +-
 kernel/bpf/verifier.c                         | 271 ++++++++----------
 .../selftests/bpf/progs/aggregate_arg_func.c  |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  11 +-
 .../selftests/bpf/progs/test_global_func5.c   |   2 +-
 .../bpf/progs/verifier_global_ptr_args.c      |   7 +-
 .../bpf/progs/verifier_global_subprogs.c      |   2 +-
 7 files changed, 129 insertions(+), 172 deletions(-)

-- 
2.52.0
