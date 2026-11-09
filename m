Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248881;
	b=ljCtiQ8jC/A6vvGpmUbD7Dfv871ypEdUhgfJU5jFlnQ0HMYiyuJ8WHavLvXguhfoQ508
	 hYuz1/9vDphgAoZyA05Zc1bjD6sRoTI/1BP9ZoCLd2pyQBuuBlqcn3rX0r3yjrpk1f0ap
	 tpXpdWyyt53HM4t+qABCB3IgqfUaazQ0CbpcUTN2shDFOf4wjo+Hh0la5e+2QpV9USVrr
	 eDuFySvgwY4mnen47y4hge22PV6KX0aGdUz4finGBQzNMP8XZ4v9bUgYctEcpr9QpwQDO
	 Uo+XRojKcXNFoMidNcJ/cpX/72hlmnS0NAuVC0d503GbCbmcQnimB2zIvvjAd6GSxpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248881;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xT0VWH2oGpx/VesD0XIgBgKoF+CwszVu2kX1aVKxe3M=;
	b=aBpbmdByBUVXsvESha8kkeFEXtm/XaANzllvokDhpyf2bzRNpFsWE3Z1Ri9DyaZZRYnq
	 ugsNMqWQJ0iBm4eGdyq4I5nu+6ZgCOhcm0ZYtdyYOyfiuexEVsexHrWbtyfKo/M79wNcq
	 fsGoKNULT33P5IlWtlVvf1SwPFoHa3ekc5XDu60TyUtdyWG9+SWJDbIdiQuAd2gCdhFvi
	 vE94ftdiuFrQMlZffR/M7l2VjJld2WusdNgia3npTLvuWePT5I4lKGLY6p6e7RbUGl4gj
	 4QbQyK1BmlDgI+kcxK+KyZ39fHrseHR0+S+x64sAjfwnrsi1W0KTVX/lUd6PRlOrB6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bItqaciL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED19B606CC7D;
	Mon,  9 Nov 2026 18:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED19B606CC7D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bItqaciL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BCCC1477;
	Mon,  9 Nov 2026 10:27:57 -0800 (PST)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C813F85F;
	Mon,  9 Nov 2026 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794248880; bh=pQ69fjyhIdbhS3s2N3dwrtnXKaezlpGT3cAPdCuJcjA=;
	h=From:To:Cc:Subject:Date:From;
	b=bItqaciLLopJWotTEoxGYzymdYWEkK21VaOJHjFrpxqMuu7MI5qjzSKoXY3bYMp1+
	 SU95lJZFg61/Gxy+Ue2xKgw0WjjVIf8iItqOhiVfcgvVPWa7LUkoSupjknwpr9aEik
	 ZBhooShOLNsBijcZR/AMkhrq+G1o7uk0Al6u2euw=
From: Bill Roberts <bill.roberts@arm.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	rick.p.edgecombe@intel.com,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Bill Roberts <bill.roberts@arm.com>
Subject: [PATCH v5 0/6] x86: Support shstk via prctl
Date: Mon,  9 Nov 2026 12:27:52 -0600
Message-ID: <20261109182758.252223-1-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
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

This is a continuation of:
  https://lore.kernel.org/lkml/20260916095224.1533971-1-bill.roberts@arm.com/

FWIW, x86 maintainers and Rick, I structured this series so that the
initial bug fixes and additional test (patches 1-3) can be taken
independently of the prctl() enablement. If there are concerns with
the remaining patches that require further work, this allows the
fixes and additional test to be merged without waiting for the
rest of the series.

History:
  - v1: Initial patches
  - v2: NAKed by author
    - Refactor the test suite
  - v3:
    - Fix an existing fork bug pointed out by Sashiko
    - Fix a state rollback issue
    - Fix Makefile dependencies
    - Add a test for shadow stack state locking
    - Refactor the arch_prctl and prctl tests into separate entry
      points using a shared test implementation
  - v4:
    - Fix rollback state logic
  - v5:
    - Expand commit messages to explain behavior and implementation
      rationale
    - Move unsigned long status to the beginning of the function
    - Shorten the comment in arch_set_shadow_stack_status()
    - Rewrite the WRSS comment in imperative mood
    - Remove an unrelated whitespace change in test_shadow_stack.c

Bill Roberts (6):
  selftests/x86: fix Makefile dependencies
  selftests/x86: fix fork bug
  selftests/x86: add shadow stack lock test
  x86/shstk: support via prctl
  selftests/x86: support header files in extra-files
  selftests/x86: add generic prctl shadow stack test

 arch/x86/kernel/shstk.c                       |   80 +
 tools/testing/selftests/x86/Makefile          |   12 +-
 tools/testing/selftests/x86/shadow_stack.c    | 1287 +++++++++++++++++
 tools/testing/selftests/x86/shadow_stack.h    |   14 +
 .../testing/selftests/x86/test_shadow_stack.c | 1167 +--------------
 .../selftests/x86/test_shadow_stack_prctl.c   |   12 +
 6 files changed, 1406 insertions(+), 1166 deletions(-)
 create mode 100644 tools/testing/selftests/x86/shadow_stack.c
 create mode 100644 tools/testing/selftests/x86/shadow_stack.h
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack_prctl.c

-- 
2.55.0

