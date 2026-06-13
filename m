Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3BF319601;
	Sat, 13 Jun 2026 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343237; cv=none; b=VWieEegdDoaL+ZDo30nwsQJ99iEUbXXTXxWGKE8CSdDacUS9G1ZdtjtTc92mEk8g8W7d4noKeS4fVJ4XQA/1c2Tc6Bc8rOWn3XZIHeRPYsaDIg56vr7OhPVtjXg+k6qggVOqEQT4xJ3kQtPfq3JldLuf1GzMyas8ZNsE4OMY6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343237; c=relaxed/simple;
	bh=kNNImhD37BvWpcdlX5GY4MacUV41wLiV6qX/QHjr45s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=f/0KLSv3VpSHB7UEhP9SI/tkf8EVF7b1fHeuT1IAEL2iMPpEQZwJkI8++bx1Z7d32shzuyJO9MeSyQ8ExQXzfoEy3WK56bhA95rNFdAiKsV/di54JxyEd7K0tANRYsUplbtLVcoJVmG1hrWZYOLKbPBxy2b0XWtJq6bM9GLCdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=lXS5Hc7P; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="lXS5Hc7P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	In-Reply-To:References:To:Cc; bh=QrI11tozgugh0E+hoBVmvLCggPJX5Wl
	q6qP4G9d79EQ=; b=lXS5Hc7PttIVtnRmrimQmzHZ77GEMMQk5s9RA9GJ4XB63uQ
	6Krpci2jxKgC5s+00FoGLB5tZTqm9ev2G9YvFMiNTMxtiklox7WZYEj3St7GdSdQ
	wdmbVRZvOjbEeUG01xX+ZI17BuJXnwsKnJM6OfyNtrrlt0I9yv0tbZU6iPLA=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQB3wo_8Iy1qpi9lAg--.5250S2;
	Sat, 13 Jun 2026 17:33:48 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next v2 0/2] bpf: Enforce gotox targets against subprog
 bounds
Date: Sat, 13 Jun 2026 17:33:44 +0800
Message-Id: <20260613-f01-02-gotox-bpf-next-v2-send-v2-0-ff980bc5a329@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgjLWoC/3WOyw6CMBBFf4XM2iFteQiu/A/DorQD1GghtBAM4
 d8tEJcu72POnRUcjYYc3KIVRpqNM70NQlwiUJ20LaHRQYNgImc5T7BhHJnAtvf9gvXQoKXF4yz
 QkdVYqLRQZZJdtSYIjGGkxiwH/wG/NlRn4qb6Scrv+L3bGef78XO8MvPj4lxl5b/VYGKdplzni
 eRZVt7f0rxc7J2xbTfJmPQUKwvVtm1fY1/7veoAAAA=
X-Change-ID: 20260613-f01-02-gotox-bpf-next-v2-send-8c48c9357dde
In-Reply-To: <20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn>
References: <20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781343229; l=1956;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=kNNImhD37BvWpcdlX5GY4MacUV41wLiV6qX/QHjr45s=;
 b=Yq5+dhNQ0bSybeeLl7uSa8XVf2e5TSKYue0bcikSUoPooEjyPZaUzpmLapinPDz+ZahVPUf3F
 iw2I7yxN0OaDwmOXsZjMyZQJzA2vl+uMqOan2p3GgONhGwcV94i7mZL
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQB3wo_8Iy1qpi9lAg--.5250S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1kuFWDGr4fKF1UZryxKrg_yoW8Zr18pF
	y8Zr4fKr48tayIg3WayF48X345CFZ5Gry5GF1xtw1fJr15KrykKr4fKa4avF9xJFWrZ3y8
	Way0qFsxWF4DZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_GFWl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0YXd5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQARA2oshq+BhQAEs8

For gotox, CFG construction models the indirect-jump target set in
insn_aux_data->jt, but do_check() later follows targets from the runtime
PTR_TO_INSN register's own INSN_ARRAY map. If the same gotox can be
reached with PTR_TO_INSN values from different maps, do_check() can accept
a target outside the subprog that CFG allowed for the gotox instruction.

On x86, that can transfer control into another subprog without a matching
BPF call frame and crash when the program is run.

Fix this by rejecting gotox map targets outside the current gotox subprog.
Add a regression test covering the two-map cross-subprog case.

Validation:

  unpatched bpf-next 7bfb93e3475b with the new selftest:
    bpf_gotox/check-cross-subprog-gotox-target: FAIL
    cross_subprog_gotox_prog_load: actual 23 != expected -22
    __TEST_PROGS_RC__=1

  patched bpf-next 7bfb93e3475b + this series:
    bpf_gotox/check-cross-subprog-gotox-target: OK
    ./test_progs -t bpf_gotox/check-cross-subprog-gotox-target
    Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
    __TEST_PROGS_RC__=0

v1 -> v2:
  - Validate gotox runtime targets against the current subprog bounds instead
    of scanning the CFG jump table.
  - Fix the selftest expected error from -EACCES to -EINVAL.

v1:
  https://lore.kernel.org/bpf/20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn/

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Enforce gotox targets against subprog bounds
      selftests/bpf: Add cross-subprog gotox target coverage

 kernel/bpf/verifier.c                              | 21 +++++++
 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
 2 files changed, 94 insertions(+)
---
base-commit: 7bfb93e3475be9de894f1cecd3a727d3e1649b03
change-id: 20260613-f01-02-gotox-bpf-next-v2-send-8c48c9357dde

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

