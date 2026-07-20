Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C038C421;
	Mon, 20 Jul 2026 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536579; cv=none; b=r7tFclFwbHFd/E8CdLtTGY2041dzTv3uxQ1Q2QmLQ3A6dxiEYQlJoG4BXb6DK0yiiUCckOflOMfsIVHpi7vCLX0cT+bntfElftPlgIiOtJQWVyPV3ed1nXKyHvDS+TTsmH6snhj/7XkBJMVn1b/9a9LvMcb9MU7trNnhKw2qLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536579; c=relaxed/simple;
	bh=aSz6yJjh9Y31JMchfFaHv/fI8sqHWaUDaOmxVfsO4zA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qv7WZckLCWehbMxU6jjEd6oZns9jFDWPgv19iBlvxrHivEXxAsWL4Cqp+TkGrJ1D/ICSGYywu+kHf0UDhyq4P0HM2V0H8aivs3pwaldf3paY17ew+CJ3m3SIkmipwgPX+MkLSNl+aOiKg6JCLT4jlL5+YYndBZklVcSnWl7h28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=L9JnzDE8; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="L9JnzDE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784536563;
	bh=/Wg+TyJxqvxSjsIke7uwO4LU3FX52fhncCeq17O3+Tg=;
	h=From:To:Cc:Subject:Date;
	b=L9JnzDE8SzOgZXj9zK3Ipc6GvgK7HAWq0uJG2Qbvi2QTuBdapTOixdIGYGaoFnT+3
	 ZPB4Nn+dZLwkjgtKnBAuSYyUT+P9eY8Ypf2AFcjc+qbwssGHZP+F+vmo0SBvsoSLIl
	 PRhtq/VbVP9fqjhkmIOuyWngFfdwa/csOgmAz+Ho=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 8A42167D; Mon, 20 Jul 2026 16:34:36 +0800
X-QQ-mid: xmsmtpt1784536476tfu04xk6f
Message-ID: <tencent_BAD40571C74057A822EBE65249A5F1957405@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLvmzXcaAJf2YmgW7qiMtDVxRCf3yIe6ZGDk4dgnPog2GfrPQ0jY
	 eLW9/xyVIsYrGZ69b3uROs3PY1B7LisjxZ6DWUWgIG7cNLAJhb8DhwJ3moT7OLixHcRO/X+nK7zt
	 XgWh+WHo9SlVPdNooxQzsCLCZbwnAi847FGatTwyGE17KE7k58yYHpRAX5KSCsMSgR+TGsobo1fG
	 fZzmOj/vZ1BYMfkGCgob5won06ad/75aadwHXCerp5648E1Mwkm20LAM0wWKmrazfB8GMwiKCxzX
	 KF/bK54bBYpL1mPJY+5mYdPwD8ppsdoiH0P7RRQ7uKMuyG9CQO/OIztfYVbSr3Vw/DxDBpZeG41I
	 RK8/HECUgLrW+hlfTJzpreOAWeSfIaN1xSCDNUHHLG0N8qiqwXZaYfUnBNDaInfCeHqECAdeyN84
	 ToqGPGzfQd2sn9yNr954nWjmqRh4HOVrDFNXPTIU04IKx8QvKUa/BZ/OVcxNFjAnLHhsaAqLIkWY
	 nAJHN4W8Ei0WydAkuy4bcP/s69M5TJ9WcDbObJoIIaI97j/YQ2PlxCxDAh0XhGwUaA/g0XR2d5sU
	 /gtLrwGv0qPgV619f6aP4+DORX0zZt6jP9aZjI7OUz4lcUHcw91bd7ElO40QhF+rAKhouBnmO1Ks
	 mEDdf3rQz4C3YiIOLBPfutlDXRb8KTusICAFh5eSCGXlhl/MX5Ev2sHWv9qOHt1SrvK7+645aXgF
	 gnLI5maZYjJjpIiECAYc5oAERMn8BDBMJyseU5FUJ1m2FRL8NPvnGnS3pXTcxtpYp13nhQthtF4x
	 g+rTOzoGiCFFsHn5QtO/S47GyH4D2x3h4eqdIEM4U7xWgCf4t/dAbkWe9H8bOtbTJZyOdjCMibY+
	 +VCGpuo1j/2TuEy7AqNkSsmDzO34iam2ObsJU39mzjzs4fAysl0s6ENCEkRtXDz0c7oK8EwQI7WF
	 EwweN7rqqlOozlwNcJCNOtLOWe9ewZSH/4R0ojlCeFRpmgPwS8DzgAErlAWH7Kte0d9QDWG0txKf
	 NIOh1bQwm7ssfMP9rkXEwgD4aE7yziIvph70EWD24zgpVLp/mEmMWWN99usTqWxIvy2OizazMEtC
	 pc8i9Wm7uiQQLodPIe2H5PIR1K0g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org
Cc: Rong Tao <rtoax@foxmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Rong Tao <rongtao@cestc.cn>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v4 0/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Mon, 20 Jul 2026 16:34:08 +0800
X-OQ-MSGID: <cover.1784536164.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add string concatenation kfuncs.

Rong Tao (2):
  bpf: add bpf_strcat,bpf_strncat kfunc
  selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs

 kernel/bpf/helpers.c                          | 70 +++++++++++++++++++
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  2 +
 .../bpf/progs/string_kfuncs_failure1.c        | 53 ++++++++------
 .../bpf/progs/string_kfuncs_failure2.c        |  3 +
 .../bpf/progs/string_kfuncs_success.c         | 10 +++
 5 files changed, 117 insertions(+), 21 deletions(-)

---
v4: Addressed Viktor's review comments (see v3)
v3: Use bpf_probe_read_kernel_str and resolve some bot suggestion issues
    https://lore.kernel.org/lkml/3e73aeb2-afce-4ae9-9163-51e4dc1ded01@redhat.com/
v2: Resolve some bot suggestion issues
    https://lore.kernel.org/lkml/tencent_9EC04DC824CBF5124305E73564341511C405@qq.com/
v1: https://lore.kernel.org/lkml/tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com/
-- 
2.55.0

