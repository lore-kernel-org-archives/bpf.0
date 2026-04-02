Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6732ED24;
	Thu,  2 Apr 2026 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109841; cv=none; b=pVSgQrIJem+Cx3BS4L5MOSAfkS9FtPkOZljf2PSBD8prgjS4axhZrCCj983fIlXowBGQT2gziB6QjbloSNvKaMF9yxXiulp7S/oY8AfUvtjpnZNYMMd1fI+8FbdpFZV2NRKSJa/Wtwz5JWaID5/Yaq6y5XtTkluy8BBwm8Fd+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109841; c=relaxed/simple;
	bh=eiJF4boIrBTyN64HfgQgLoR7mnMiuDeXH3ha8zf3q9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3G8vA3NLxVzbyg4UvU8l5iY5ntVCPWIZ+07ZJvM6llBqbyQ7+AeaAgrSSYgaMlooHn+jDYJOYXr0vYcMxbYzsbn0kzxvZcyoFugoGBVuD8l3t9F0GCxS35xJkNwX0vk00pn12U/ynPukEMp2w2ebzXTz9M4XOjL1nqM182mo5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=aoN2KUIo; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="aoN2KUIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775109816;
	bh=XAGqGKGgQVUo9QLP4obElwNfeK4IuBA5r1h4Bx8Js9Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=aoN2KUIowwAvW3aNCH4ZZ4/zV69z3VNTL7+LPf8xOlG2cO3nkXEh7Ot2f0UcyQTjv
	 VmCLrh2d9f844ANauyiMVxWE0oqdTnnxvuOiRZd10J3zQdhzLX46n5S5BK+tGim4rj
	 GQu3BFDli33hpWAwYWDx5xCei/JintCF28QrPQJo=
X-QQ-mid: zesmtpip3t1775109806t27ce8bdc
X-QQ-Originating-IP: z80MRyMHkGcqAEWcFGi2CtJ4Da1u/jAS6stTnVdmeyw=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 14:03:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4836813614258835898
EX-QQ-RecipientCnt: 20
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	haoluo@google.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	kernel@uniontech.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Lang Xu <xulang@uniontech.com>
Subject: [PATCH bpf v3 0/2] bpf: Fix OOB in pcpu_init_value
Date: Thu,  2 Apr 2026 14:03:21 +0800
Message-ID: <D56FAE17BDCAA77A+20260402060323.1995132-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MnPkp9g+0/Efdem9gAo5MM77b0TsC2DrngSiSSSM/L0LLnbwPR/go38V
	4wTYK6V0xeADT8G/CcbrixoGhHqVcuoJf/1/eWeBtXXDED5xfc+mN6vPRtIz0KUKWbFTd4W
	lIIqkqhYRc1Gk/9EAIxBbh/lGTF2x/kmjnfUqhiG34eBuq9a93vW/jI0te9qjbeSpsyVm/w
	lxnSmNSqUwE8+uSyAv38tjO1Y6Jx4aqyc/Z+114oW/wTx+TmT/SlpIm1Vqp9G0IS99PSAGL
	EhFFZ0+pN4gMtPp9LTjsEYIGwmgI8bpLK9k98rp3Q/4L81tbm5HUiVKCHajpkkx/Iis7AmR
	3enr7YRd35WjJ3CXhdZpFY+11t+gmaEvS1GAzQg5fEC8gLB0BQDi06Sqy6xLnFIE5qWHifJ
	vAaoIAZYfh7r09uhbKOhYS80nb5LCa3knI6uq+ZMUWE3Q3cdvdPIKeO8O/rnQGsPB9S2ZmF
	mBumkTLRv/ZHqZywVrFKBbnQKEKJ1YiBMRbMv4yF6kf6iNW6lErFIiHniP5gdyZY/y4P50P
	/8pXIQzWFit13/jAKZEOJn0GWrOP4W14zqzKjXEONtar36+e8m7pXlNIZTxUg/KL1wVu/2M
	2jtkVMyBVnnCm99kqiBu5HzGdWnC6PaP6NI7IIX1ke5UiRorY65iteKt1phE4jVxU0MhTes
	bjGzQTVV3EagpzOnL09p/qX1ZU/DErsjzcYTycntCV5TNKxr4Nrme+bij5Jg0WJ3a/zDPnQ
	zSHqsSIydLcabONdapVJ6i5RxQm65Blp4Gy9pIiNcaCYSyspF8k5YkCEtj0R3ZZRs8k7k6L
	pHuSQP3/mydBCdG+p7x9C/1JOMHtt2iEKu+zk4bxTQz5R6HOPObiyWB87aQrVmoZgvCZvL7
	pnIHYv4qyf/olzTh5VGo/9TxjM3GSreLhXdFPRgIEfTIbpkLelmzaiXdbxj5++RCVDrxu8N
	J4oZb9Ovdf1vcVYogvm1mKp4RUsoj20SFyHWsaOIN4IRPZhid9ukOaI9fS+AJPhyZpr2wb7
	+wYYLUJlf880rdCTWq+473EDW+aJfUT3mS36vHRtJVIOkNJBmQhrmJcaM6uEzoqAKNpGVsc
	dXXhmMMiynLNMg/q1kqKMA0w+ybTLTzgw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

Fix OOB read when copying element from a BPF_MAP_TYPE_CGROUP_STORAGE
map to another pcpu map with the same value_size that is not rounded
up to 8 bytes, and add a test case to reproduce the issue.

The root cause is that pcpu_init_value() uses copy_map_value_long() which
rounds up the copy size to 8 bytes, but CGROUP_STORAGE map values are not
8-byte aligned (e.g., 4-byte). This causes a 4-byte OOB read when
the copy is performed.

Lang Xu (2):
  bpf: Fix OOB in pcpu_init_value
  selftests/bpf: Add test for cgroup storage OOB read

Signed-off-by: Lang Xu <xulang@uniontech.com>
---
Changes since v2:
- Fix patch series format issues
- Instead of aligning CGROUP_STORAGE allocation,
  fix it by replacing copy_map_value_long with copy_map_value in
  pcpu_init_value

Changes since v1:
- Add self-test program to reproduce the issue

base-commit: 7aaa8047eafd ("Linux 7.0-rc6")

 kernel/bpf/hashtab.c                          |  2 +-
 .../selftests/bpf/prog_tests/cgroup_storage.c | 46 +++++++++++++++++-
 .../selftests/bpf/progs/cgroup_storage.c      | 43 +++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

--
2.51.0
