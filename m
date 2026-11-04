Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761102;
	b=i0ZAgrjNyYJgZQKOTptVsFKKrGFRT5E0dw6j63ydx/GZYifHO9gu1IX2jKwtrfXkie7e
	 DHMJq0xnwJj+lPllFzEydClHAc9g4olLvztG3AtheHSp0VnYf/3h4EOg2OiGqUJLfDEhl
	 B2aGNpyDFlVFoCqiI07Oo2YmKAsatraMaDz3xz+Hg4TLGiersHqgPdUGz39F0CZ+1pchA
	 jcWCyWhzoSTlH1PXDc+2hYvbJ5QwknF4BpAC6q86J9i30pYtrzdu16GTMne6+Tab6sh6m
	 FGGUbuPk7xxPzlgzsSsFXSHsh1bZELqjjTxh9/kJnzf7bj70LjEiSA7CZ+5mRycfetw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761102;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RVJUiOMzifuWLvORGaPxKr6+HjeI3slXPjpEMS39T2E=;
	b=dLjPC4TImdwHJK8tlxHQ5SBPZLaqxLtcAnr2nFaNOaekw6V3CT4sRBmJcEgBE1yAagRl
	 mFukvLxIHgQ/8fYBUwuYeGuFyAsUQEigTVuqxr/2cSKhvxpylVuESlIZc5P0IEqh2YYhL
	 WQQCQxWbkRRc42Gu78b/gt0ahVK1mBOs+rJ6FICAOaQR4bJyAfViLz2iVw0TTG8gr/Uku
	 eX/Kp8+kK2lWMvwvG1VzAu+Vc+5OlFOwJXukRxP8uSqRWPRU6gUh5FnPvlFIcL8fXvGVL
	 5+KJr0qzYzY2sAxvl0B8YnoVW/q9YeylBVYeKWNRXp/rHvOe5YO7ugbdpaeioxEMjnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24E606A32C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F24E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Qrk/HCSas5sblnUyRAEwqxcGKUjCXAlboGFS9jl9TavaxGu47/Mon8PCqq8C/XItXzYms9iMV3nf0
	 Z6RnMiJCXsbA4B+2Jkb0yKov3NHJAxKtkO5CAY01PUxwDDC05cA+emU+Sv4FP2JMxilTkp7FYsX2x2
	 myH1ggCiM3n+jnns=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26aea9f491a5-d4b0d;
	Wed, 04 Nov 2026 10:58:17 +0800 (CST)
X-RM-TRANSID:2ee26aea9f491a5-d4b0d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16aea9f40f20-10571;
	Wed, 04 Nov 2026 10:58:16 +0800 (CST)
X-RM-TRANSID:2ee16aea9f40f20-10571
From: Gu Bin <gubin@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v4 0/2] Fix OOB read in BTF dumper zero-scan
Date: Wed,  4 Nov 2026 10:58:01 +0800
Message-ID: <20261104025806.1693-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261103032619.1378-1-gubin@cmss.chinamobile.com>
References: <20261103032619.1378-1-gubin@cmss.chinamobile.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 fixed two issues: the missing minus sign in the struct/union
ENODATA comparison, and the unbounded zero-scan.  As Alexei pointed
out, the sign fix has since landed as commit ab332ec8953d ("libbpf:
Fix struct and union zero detection in BTF dumper"), so this respin
is rebased on top of it and covers the OOB only.  The overflow check
runs once at the top of btf_dump_type_data_check_zero(), as
suggested, instead of in both member/element loops, and the direct
*(char *)data == 0 test in the array branch is dropped in favour of
the bounds-checked element-0 recursion.

v3 added the requested selftest.  v4 fixes its expected string: it
must be the partial dump output written before the zero-scan returns
-E2BIG, matching the atomic_t overflow test, and the comment style
was adjusted.

Tested on x86_64 (bpf-next @ cd5bc5528 + this series, clang 20.1.8),
distro 6.8 kernel (the fix is libbpf-only, so no kernel boot was
involved):

  # ./test_progs -t btf_dump
  #55/18 btf_dump/btf_dump: struct_data:OK
  #55 btf_dump:OK
  Summary: 2/24 PASSED, 0 SKIPPED, 0/0 FAILED

The new case covers the fix: with only the libbpf hunk dropped
(selftest kept), it fails with "failed to return -E2BIG: actual 16
!= expected -7" on the same build.

Gu Bin (2):
  libbpf: Fix OOB read in BTF dumper zero-scan
  selftests/bpf: Add overflow test for BTF dump zero-scan

 tools/lib/bpf/btf_dump.c                          | 9 ++++++---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 9 ++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.55.0.windows.3



