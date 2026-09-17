Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4C3EFFDB;
	Thu, 17 Sep 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632574; cv=none; b=BZ989bWGLznFV9KUajAkb0dLjX8ZZPmAlalB/hFm8kMc4eCa3S9S6G0c154Yg8aO4kOTidw/4l92Rt9QmZiEiXUMSNG5kAU3Q6MIvfPc+V7grywplZn9iMHH9YWnFAGKDgFgu1mtS/boaApk6uqhFu0M9GkxnSolyJa7a0hqq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632574; c=relaxed/simple;
	bh=kbNisIC8nsehDCUxseYPQGDedpTa/h7xeiFUFpHSLC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTIU0y3szTG28BIGkWLWc9Fulr1RkvJZi3q8U8vy5GZiHGcm8cSYh57Iiaru8AFY0Wm+hMKN04VP470tSwOlCo8C32+7fl2+cHGP9QvlhESuIr5J+OS4KkujhTC8HTFSQ2mBCj8CkCXVxp4Tykzf/mZYjAEDTa9Qj0h/PeIVrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ksdL93PW; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ksdL93PW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=L9
	wbep8xI+Cq5KT6p53OQGf/pQSZV5QMee/jAFCwB6c=; b=ksdL93PWuwaBBk+vnJ
	dtrFTCWmCb+7GJ3W2z1JFSFiYtY8U3fCeKrlAzeRyEvITVtpRKJ9kWReyjCQv7QN
	CZnHUOWypA+Ps1wzvPxYTHjdwWQ1TsAKIob3EEaaWT/DbQg+gn/JVuwAI5838jMv
	wgWb52A2eHeRNKzP7WgAirZ8A=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3j70IoKtqR_EaSA--.61734S2;
	Thu, 17 Sep 2026 16:08:41 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/2] selftests/bpf: Fix task work false failures and cleanup
Date: Thu, 17 Sep 2026 16:08:37 +0800
Message-ID: <20260917080839.462038-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3j70IoKtqR_EaSA--.61734S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw15tF4fGF4DJr4kWFyDKFg_yoWfuFbE93
	yvvryvg3yUZrn0k3W293W8Jr48Ca40qry8C3yDtF17XryrAF47WF4kZr15t348Xa9xAryS
	9wsYkFWftr1avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8enQUUUUUU==
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AmvfmqroAlUigAA3C

From: Yun Lu <luyun@kylinos.cn>

Hi,

This series fixes two independent issues in the BPF task work
selftests.

1/2 removes timing-dependent assumptions from the stress
test while retaining its callback accounting checks. 

2/2 routes a task_work__open() failure through the common cleanup
path so that the pipe fds are closed and the forked child is woken
and reaped.

The stress test was run 50 times normally and 50 times with single-CPU
affinity, with all runs passing. A single-scheduler diagnostic also
reproduced the original zero-contention false failure and passed after
the fix.

Thanks,
Yun Lu

Yun Lu (2):
  selftests/bpf: Fix timing-dependent assertions in task work stress test
  selftests/bpf: Clean up child when task_work__open() fails

 .../bpf/prog_tests/task_work_stress.c         | 6 ++----
 .../selftests/bpf/prog_tests/test_task_work.c | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.43.0

