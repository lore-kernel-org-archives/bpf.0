Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D01CAA68;
	Tue, 27 Jan 2026 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515551; cv=none; b=qhQmVCeNGfTLrarMBJwf4HQSEEXY9lZKwgG6Kv4VOwK1v/VfuWr+TOwYmxcaWXYl/idjZmN7KJY97hMOhZTAxykwO/SP4NWOdmaTdMoOcxe7hJJ261Qc2eaz5kD5xmp09l0zucWnfJluLuZOUnCVMsZ7Dim0w8u13o3q8tQtF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515551; c=relaxed/simple;
	bh=qk2asS0D1Ie7new1Js/nxvbtuP/JwoVlkGdpRYvaepo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=njDrnCO5hQm8h6D+HOnfRVvqVhEKb1jknxhCiG5L68lSoKYfQrcvaMShtCCv44gplMw6lwC4+3BRa3XPZUbaXLDTTUSYf1wSJkVqOJ+G2TTWNmC9Atf9ZA/+LK/4LmkfXv2ePGQ8rYFXtZblMq+zXsWVokNm4Y8DH4kYio/el/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=crj/Syqf; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="crj/Syqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1769515191; bh=ceKm3tvX+cfQMJRYsVyxaVRalq5rHxn/ijDU8FaAKTY=;
	h=From:To:Subject:Date:From:To:CC:Subject;
	b=crj/SyqfH5wxPA4QBUZ2snxsqBXihBMfQ+Mpr+evmTJg48nbwrD/5eToLQddzoImC
	 cLzY+T6vsBDQL9G0VBYtp33mdP+NrT2C9tOx6SMflLQK+vV0b1YLuuQxaKbJoArwS9
	 S58fmFzt61PXGRTJHOvMowuTCGs2J2xKuadPNYd0xCUJ8ErBypZmK38cclrjpR9ksM
	 iTBrP84ev7Jpu4Ga5gCIF+vRTnnKOyRvSx49E/7eK48mwOg2PbnoTpALMMI4dNfWhc
	 MYb8hFopxRnPGdAUsla3MOouHdjN+x2QodGyh51nYyKifgN21ZnuAbv7wYl1f7thxr
	 6q/nk8r3eQU2w==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4f0kVH280lzPl6t;
	Tue, 27 Jan 2026 12:59:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.20.40.230
Received: from luis-tp.pool.uni-erlangen.de (faustaff-010-020-040-230.pool.uni-erlangen.de [10.20.40.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18BTKOiOmJUisAGUtYWDJx1g8jCUZnPyzI=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4f0kVD43JSzPjq8;
	Tue, 27 Jan 2026 12:59:48 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Ihor Solodrai <isolodrai@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Fix verifier_bug_if to account for BPF_CALL
Date: Tue, 27 Jan 2026 12:59:10 +0100
Message-ID: <20260127115912.3026761-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes the verifier_bug_if() that runs on nospec_result to not trigger
for BPF_CALL (bug reported by Hu, Mei, and Mu). See patch 1 for a full
description and patch 2 for a test (based on the PoC from the report).

While working on this I noticed two other problems:

- nospec_result is currently ignored for BPF_CALL during patching, but it
  may be required if we assume the CPU may speculate into/out of functions.

- Both the instruction patching for nospec and nospec_result erases the
  instruction aux information even thought it might be better to keep that.
  For nospec_result it may be fine as it is only applied to store
  instructions currently (except for when we decide to change the thing
  from above), but nospec may be set for arbitrary instructions and if
  these require rewrites they break.

I assume these issues are better fixed separately, thus I decided to
exclude them from this series.

Luis Gerhorst (2):
  bpf: Fix verifier_bug_if to account for BPF_CALL
  bpf: Test nospec after dead stack write in helper

 kernel/bpf/verifier.c                         | 14 +++++++-----
 .../selftests/bpf/progs/verifier_unpriv.c     | 22 +++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)


base-commit: 8016abd6314ed1ed01ff09404e3c82ceb13c185b
-- 
2.52.0

