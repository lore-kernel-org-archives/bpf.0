Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052733A3E72;
	Tue, 17 Mar 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741866; cv=none; b=mJSnjbMDjPOCYeny6ss+scKBlRT/IrsPIUfzAGlwe1yJWh+DvwwKJHls+Rs4DcINDPXFVKEcfAAXd99c76r04LoPvTyQ5oP3x2OIuaBBygOCchz8ObDzno9JMIgfLadlAK8pF/Va7lwNpGRwKzRMWDq3nRw65+a30es+hU0aW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741866; c=relaxed/simple;
	bh=sAqvOunHmLtv+7xluVdlK7Iy5JCwRHjXyYfMLiM2YVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKqZ1IeNXrX/20BMp1vvWpNZJSmz2J+k8VRrVf2OBWiJ6uWNBoyIf/KIjMX/7ZYQdt756o4twly1ySvWwT44XltSFGmWM7pm7kXyGpGTl+jB6OiSy5PYEsazae5XGPby8s2YRTuKwQXUQKRjfcmMUr3H5hAciuVYaMw3onsGeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XZMEF5vI; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XZMEF5vI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1773741782;
	bh=xVRmKDqTK5Ka7naFLpt6V9r/4eQg0zBFtcJqP+cxtZg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XZMEF5vIUNMXhee4tGg3lQNTaZTwnNcM9Q64FVDhEsUW2yWpGghsxFWfkjnHwal2/
	 /zfQLel1dtGFdrGy7WKkyMZ11EXBMr9hVOERSaCRbICiEDgsyFnDo1C152NdBhBnmA
	 mBo5hzLg2g1dAc1mxhfF5WibrCzaRntHPodW6qOQ=
X-QQ-mid: zesmtpip3t1773741776t2e299042
X-QQ-Originating-IP: RyKAFdiYMpNXu2RtUV2r+qFRqW/aArytPp0xTh0WQbU=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 18:02:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15613463377537642525
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
	xulang@uniontech.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf 0/2] bpf: Fix and test cgroup storage OOB issue
Date: Tue, 17 Mar 2026 18:02:25 +0800
Message-ID: <23D29267038E972C+20260317100227.2157104-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <82ee475b-034a-442c-b290-cc7905a7f33c@linux.dev>
References: <82ee475b-034a-442c-b290-cc7905a7f33c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mutteg8H72qDYj1zmlyXnCJTS2oHihWBZheEBKwPXL7tHZ3nNqw+Z+S/
	MgJp2fWLkuqTNfmMfP+eJvEqksjvD7y2tIZsHuuezt4Uf5cTDQVEzBT0xiX58w1yZeFkI4w
	+oixmbmsdHhulDi77kqA7zToLJpnSGasjD2TzO4tCMSRVlFnAGzTuDLsvC9bBwNG1bKLmaO
	VTZ+PQfS4XSkOGtvXG9Nn7v+J4vSjJSgPMsN+k1ygxeGozLXzpUUk2oPSNklBqSCk0qQ1Ll
	TfmwR5lCkzzVJVVmzIY0mXpwsqwCqWHqzKlWWnJSvbTzfY/i0BZPS+rdjtJmih8n4JPQXpW
	lI2rXUsww7fFLsIRnPO9SGy0dCS5EFySJS9MPsNk9r0yWinrMRfkaYVcWEZRgsCsXQLewqW
	sNYjgCWzZGBAJvYt7FIS+PYFgsWtiwrzFVgJA9zO3ie7S6wpWQvH2d9vZc0cM+dp5WPbb67
	kPybUmwaGwnF6WE/kLAo9E/seKfwmi1i36zCy6XfWBqlG1v6kGlrXwn6vQuzEIrL+C2Kdn4
	OMFAu0q/KEFaPM9DUdOVpZIKkiIicnllfooU0C+o28T518vDvzwSIWxCA5/WLrbEYtaoqav
	fjE/Nu/r+VMU3LVPcGUzQVBIgSz52IsU0buUeL4ik4UiPwDEShM7Q+9Ukw0LMRi1CRFv2yI
	OPcdADAqNhN4+8ewidDPPjBe41Xrhk2cx3qrcB8H4v5KoxYEk9HqtaDOTxiTF8VMEfdNy2e
	NWfV9KffoZstokLFCzpf0/AbJRnaiW14dz3e7ZdHOYF6v5OQhyucvgSUvg2i9O83vFt7MoL
	dAQJxjDV+RiccXENn/WFXCQXfNJD0elqxTavTsTQtFyiA20Cx4oJlSTEM8Aau0nWoeVjB5P
	w8FDc2b//iKrZuhFqWjUURgraJFXaH8kogprQLC2A8bgLRGPOAAUf/mBI+VIQzl7n2ocQVy
	o5LuWEJkEpxPXwaDWDLWd57W2UgtT4O9sS81R9euBzX3od0O8MMEu2j0Gp91FDUZeyhUk1j
	XR0G67vQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

This series fixes an out-of-bounds read in BPF cgroup storage when the
value_size is not 8-byte aligned. The fix ensures proper alignment during
buffer allocation, and a test case is added to prevent regression.

Lang Xu (2):
  bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
  selftests/bpf: Add test for cgroup storage OOB read

 kernel/bpf/local_storage.c                    |  7 ++-
 .../selftests/bpf/prog_tests/cgroup_storage.c | 42 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_storage.c      | 43 +++++++++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)

-- 
2.51.0

