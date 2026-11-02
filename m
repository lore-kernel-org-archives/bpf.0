Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622738;
	b=IEIqBNko7TO/2mvpbzaVK6Sssu+vn2rO7ngS8YjNzumKIietPe8AZX4I/BS4ImGgtet3
	 K8sy529ywb5VdtWWxyl7pi+uPhpu7XiiUghTe4AVcM9Lozz1Qm7nP8eL8pb7XHxJyyGw6
	 J/kD9fyEab1WLRgtL6BmFkUu6cR2S36z7ajvylr4RD7VyVqCtGwtlOXJJaIeoE+/fRnl8
	 7AKBqsporgxKakTF71/k8p4G6Av6CCZsCww/z9kKQNdw/zOG8mt6mCI4wmPkd75YHa3qC
	 j1j0XrptPtB6GKte5fOhE4sinYqPKUkc1LlQv5nGbbdemDx07erA5y9jrlvb3fyYWAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=lfTEZtUhCcU2T3URSEVjIEX2SBlCGYIkFNQ2td3t68s=;
	b=UkXsCKwPKDKn8CcGtMacknyIXgM5IS8+8f+uu9c6MfmkvUXSuC8vCHMgYC6m8/8AqKQQ
	 jCynMdYNuZZFV/Uc9fpKfDXiqhPQtkGGAa4PKNRHa8eq13XWplccDeSVSnX0LsCfcP0om
	 +sElfXlPVAIXntqw6Z4rRNjAJd/xtaaa0dnFQJu8/ECouvKUasNJzHzDFLIstwWvHCok2
	 ngKcmRqaq7x9+YXAM3y2sSIYCJtQ0jBFoaav0ONzu+4LZdwTVNh/oo2XquZRw0xreO5pG
	 766b43Of2PCniCHyob4a3XsdIG8+m6/bdfrfi7OCAmXT2p65/9vYWgk0MoOhrFokDYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IXPnlnEf;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BD606A32C
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C96BD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IXPnlnEf
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1931ff67a29so5386697c88.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622737; x=1794227537; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lfTEZtUhCcU2T3URSEVjIEX2SBlCGYIkFNQ2td3t68s=;
        b=IXPnlnEf1jbwltyqwb/bMrMK51l6iyIhrrQ2fg5JpDukS+CGDClt7341hvbF5LgmoZ
         lDtIXS3hLWs85Dg+lsrWh8miuMxZNQQS1X33IKqRQzG+Iqc1uUlLHJfRn+NEnpfpOkZh
         pjjn/y8s7Jpgswe6EtcawE0iWbKlupkm3mD8iMTbGCNacQe6IvFvCIbyofBbMJ0gvNvh
         KD4xEXocV+m8rLK23MliT6D3sXPLe4KKybWp0FW9gJaSHwAMf0StDJ/ZmLIoDg9ELzzr
         JF8VGiBv5TGe9DFbIpvL60shkoXNgSBo0XqF9V2ABii8GCzN9u3Y9xw/QuF0KJb/Ez93
         y4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622737; x=1794227537;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lfTEZtUhCcU2T3URSEVjIEX2SBlCGYIkFNQ2td3t68s=;
        b=iPgV0mYPyP8YYe7taP3UCSw62ceVwnhD3ZMyacT+uOGOkU92qBjlQPTdAim5iFRYUK
         qV3nqq+EDSnmKMZN8o1s1eDEdBNpV/aBcQw8PIKF0JI+xgX3aOd5fw6u+9mP81RhcDkl
         iQXccHew6tRWqLluV+AocloxJESS5CYL2IYsV/dZ6LSqoQUbNVD3BJqwcAKuJUs3lPLn
         MY8ueo+k3iNffF0Qmyg1c7xr08WT2L08fda6++d3QNsPH+5OnX8Wt++erG6Pt5FGBtw1
         hMTZ+H4J4EdobvJBUrAyDlBX0AVCvKFeeS+URjfyrEVkOBZgCMmdLUu3uW137Kv28pYw
         ecwg==
X-Gm-Message-State: AFq9FYKJjlNDW22skrmxZr3skzV4h9bL2GdUNb4M9pP/xrDW/hxanBt7
	qmoOGP6nR3rNQeit1H9x0EoV6Tas/8nuvxw8wkKCImA2+F3C9fhAhB+b
X-Gm-Gg: AYBFou3GbhuKG7BfuNpwTsnHOoCe3PrhOfsXgwX8/im+MzKJIJZTQM1Fe6KaLabcNtH
	Ev7BTOdPpYkyOE0dw5nqGczqM4TMu9YYwDRT5efvegfLAZlCfYgGZulzLha72klgzZNF9o0v+60
	AM4y+QRPlBqGWmOtbEk0tZXmmP0OvTDt/hMiu/LLvoGb/E2l49cRaJBtLRDdvrX9wiBPFEqKFQS
	ob7Fg5X19kw6P3/XakqUEq8kOVMBDomAo81WK8WY+YbsSpGYjt+u3afk6jH7gZt9W+oX4G/Naj6
	gtQ898i0uaBYG1ZaBOxOqRtOMmQ9D2UzOaiOtMsFLanIO1Gzxw13mCR+2SnJp6vqPFrppb0Fyhe
	MiE1nSk+vPtQrS52y3Sk+/67fvwFvRe8XzT3E0kw8aNwcuvVKlzTR1mNuBmpqm+2sB3huIpO1jN
	uFrLD0EIcVikVOYB8CPaJv5xAnFtdhuXbRtpsAfVpPTgUQJXkaWQ+Z5JqzXmHNrDTUldTQQGw90
	RYoLN1HmdJknxcQ7j2kA0BkSNPkbbFtpH9htJA7Hh0X//2OFJzFm9Xj+fNBzgiIQhyxVsD9rkk1
	js04sicw7dlobBF7b5GHxJZ/
X-Received: by 2002:a05:7022:eb50:10b0:14d:baf5:c415 with SMTP id a92af1059eb24-1ac5a0b4324mr16360361c88.7.1793622736733;
        Mon, 02 Nov 2026 04:32:16 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b2360d2066sm4950951c88.11.2026.11.02.04.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:32:16 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH bpf-next 0/4] bpf: Follow up on the patch list
Date: Mon, 02 Nov 2026 07:32:10 -0500
Message-Id: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMqC6GoC/x3MTQqDMBBA4avIrDuQHwjVq5QubJzUgZCETGoF8
 e6mXb7F9w4QqkwC03BApY2Fc+qhbwP4dU5vQl56g1HGaa0MvkrAMje/YmRpGHKM+fspguScvSu
 r/KgtdF4qBd7/6wf8VKK9wfM8LySpHKB0AAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Alexei listed what the patch list series [1] still needed when he
applied it [2]. This series covers items 1, 2, 3 and 5 of that list:

  item  problem                                           patch
  1     the tests break with bpf_jit_harden at 2          2
  2     the out-of-range test ignores the insn number     3
  3     the comments on the aux data rules are gone       1
  5     no test has a second patch with a jump            4

Item 4 is about a commit log that is already in the tree. Items 10-12,
bugs that were there before the series, come as separate fixes.

With net.core.bpf_jit_harden at 0 and at 2 before the run,
verifier_patch_list and patch_list pass and leave the sysctl as it
was. Without patch 2 and with the sysctl at 2, 8 verifier_patch_list
tests and patch_list/line_and_func_info fail. test_verifier and
test_progs show no new failures.

[1] https://lore.kernel.org/r/20261102012940.1756142-1-alexei.starovoitov@gmail.com
[2] https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (4):
      bpf: Document the aux data rules of patched instructions
      selftests/bpf: Run the patch list tests with bpf_jit_harden off
      selftests/bpf: Match the insn number of the out-of-range message
      selftests/bpf: Cover a second patch with a jump behind a barrier

 kernel/bpf/fixups.c                                | 18 +++++++++-
 .../testing/selftests/bpf/prog_tests/patch_list.c  | 10 +++++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  | 17 +++++++--
 .../selftests/bpf/progs/verifier_patch_list.c      | 41 +++++++++++++++++++++-
 4 files changed, 81 insertions(+), 5 deletions(-)
---
base-commit: cd5bc55288d4fd999595c8f2af6a5408cbe92a52
change-id: 20261102-bpf-patch-list-followups-e6638030c913

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

