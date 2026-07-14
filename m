Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2113EB0ED;
	Tue, 14 Jul 2026 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021808; cv=none; b=LBvQutBbH4Bz+t6YTglRAxc8Ig1bNhLHF8dQ6T+aKpujVcscK+8HII5vG2lE/OdLg+3n0lTvGwUxd0qKXhbJkPBsxNjCBxKkY0BtkVzm+ga+/Zcd2YK/BIdYLlvwBj2Jfw5fCE60mMiuDXOViAogkWjHgtdPFSwZ3dIafrOn8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021808; c=relaxed/simple;
	bh=hEux7k5pSZ3IIOs91EgSuLNwy3EwS9lRQl1b7Y1xybk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VMN++igciOpJjYP3jYQX4IRI5uJoE2gwXOJW22jSx6I8gwTijipfxxvMQfmW/ZdHfrAyRnbxFWA0L0QzqQheKMe+u2jFSqeij0szPWkj8k0m8mY1HeRDaHo3ACgru6B4H2Tm9ZHHpxuiFNfI3UgcxsnIgOXhor/mq2H2255GGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=mwaHYWDY; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="mwaHYWDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784021801;
	bh=wkoM93T6uZdr6qF1AaxfvKFwkkWIJDmiSU8IcXmoy+E=;
	h=From:To:Cc:Subject:Date;
	b=mwaHYWDYiCkVlphmB9SMN/v3NQdCov9BsOBvYGzi1ZnyARe3MAru4d+pA+rsU8T9u
	 X39ZfZ1FOZ4d2Yap/IOjbVHCoaXQO0CRKg/1bGbquFsQV8TMwDJoZzwGE1xco/JAnv
	 1ehnd/15DeGk6A5Zggec4C8B9j0FfJb1DIzFt5Pg=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 924940A8; Tue, 14 Jul 2026 17:36:36 +0800
X-QQ-mid: xmsmtpt1784021796trc40wcph
Message-ID: <tencent_CEC3C04D48390BE2D24DE5FDD56A140F9105@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahPzKyZrtfPEoDl5+nYLWRhsalihIwZwcpuCXIV08UC/cSTPWIip
	 /wHj7hSHG5EB0qy1PNt+WjmjyDc/6pQIkzqxlmKq/R3bofcYg4tEEscO1p4QDsj6HYYI2hhlxBEK
	 uEO9mrypkuTfiStJ4FRZMJ7wvz8Rx2KBK3+p6LdmmZ/DLWJsRlazfeh3fiyLh1Za3SBMvMHyS7GD
	 pSxZSMsFLO89WU7Qzb5yx+Q7z7tRYN+SUH3rminb6p+OL14MaZ9bN0NXxbCsrea3+D0NfukQdYE1
	 tx3O1/yVz4z0O+Wlf1vKFtP4alEzRa0GK5NsDnyPfXXc5iTmPZLZek4heRBS/95ErUol7o+wN7iv
	 sL6+or9prFsUy5DEvCs2HZPD+BwUZnIPbvFvaI73XdplZM5ukNPKKS519Q+j0z0g+nbPKLMfV9dV
	 gZSgyl0pwPIG0t9W70IUkFfrlYttHrua99XKU+HDH5xq54q4cHfgA+P1tH7vQArf+SFU/spw53EQ
	 Qgoizu8yWpB9x4UBXnqlyS8I9cNrkNRux2DW36RbvTn9ucuArUVEimT02Iu1YyrfMx5j+rELfEpN
	 phme9FebEKVq+TiqFt5Ab4fTpe2ruax+7SDOSZtr3H6K/reEjVhaHPzjGbMYBITTtz5lWB8jO3EX
	 UbqwkRGCLwi51mjU/RgaMn5W46Jt9RgQx+r42Ms2bI4DRSFzLYlZ4xgoVd7lDVSU98MO1k956rOj
	 dqzGIdEEgTwFpg2pcCHdQCdJNYqM5mA7Ru4qpNMze18aI0lrfhYCYdwlgE5NVRJSon/r/42l0RHD
	 uBsA2dZ2/5wqb9Trj0xZzS2CD3keFPhyYFkSq4juI69LWEfqpr+FjIEy/zIPTha+3i04pwkB+UHm
	 hM6Br4caizs0kOEcM7kPPy19Yks0NF2MJKC5CZ8/duaAHYQisqtzau15g/uIykpoKJeN+hJGlxVl
	 V69apKkIQbd4rWeHnhR9QbXIwl4BxmNCIHL9rffCrRzAtFsGDgD+Z9L4k6KQFj2EWlUmfI570m1+
	 8mV2vHPTZNdew+jIwwfh9rNNmju+g=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	vmalik@redhat.com,
	ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	bpf@vger.kernel.org (open list:BPF [SELFTESTS] (Test Runners & Infrastructure)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next 0/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Tue, 14 Jul 2026 17:35:58 +0800
X-OQ-MSGID: <cover.1784021302.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add string concatenation kfuncs.

Rong Tao (2):
  bpf: add bpf_strcat,bpf_strncat kfunc
  selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs

 kernel/bpf/helpers.c                          | 91 +++++++++++++++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure1.c        | 13 +++
 .../bpf/progs/string_kfuncs_failure2.c        |  2 +
 .../bpf/progs/string_kfuncs_success.c         |  3 +
 5 files changed, 111 insertions(+)

-- 
2.55.0

