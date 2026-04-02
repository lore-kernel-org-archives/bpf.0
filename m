Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237C230BD9;
	Thu,  2 Apr 2026 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111222; cv=none; b=g1dzPBRap+ijVEG9lMm0r3WAonxdN/2xyPK3mgjFqdqSjMMvHu7f8/Bkth4X+aBhFE/FtKUO/ZRsbe8Y1m2M+hmes6RdShNTapePJztYIbDoR7EFd4dl9yiWxcbAXGSii8MhlUyEj9b3xYanw/D7bB/oedIwMhAdvl0RQ38OPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111222; c=relaxed/simple;
	bh=hvElLuPRKq6RITIza7NpIgO7fG4l8Tw41DKqT5RqpZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGTci524bxplET9ypuFlSgoJIlJRYTlBdesJ4vskzu3Q8wp8xu6WnxWRTpddQN1WtmkVtO7Sd8tb+wZZ5kPlLD588MqPbV/8Hs1N6LUJCsSuwXXW3eSK8IRsjwINwQLCQ0kOsBuOjsrivUVyqFkmYIRIUuiNOKj16qwsZ2NuGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=N+mh5I/F; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="N+mh5I/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775111192;
	bh=6qZqK3VDaT1rly6vHBTA8rCgdQJXr2JlN0JxU/c2BFM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=N+mh5I/F+LXJo6z1g3Zck9IuoxGWNy17YQJJYw2+4vHHW3OicIXD+s1/JM5p+DQBs
	 7RUx3kEgmHBJ1WY+ZLdeXJQ2vpVj1NVYMBccOg4z8i9zYVh/gEDo1J9WwGjtXqZZR8
	 awwfmY6rAR7kdwc+lJkM51j+34lFr5lOu1sHnGqI=
X-QQ-mid: zesmtpip2t1775111184t34a60a93
X-QQ-Originating-IP: OscYGYl4mbZM60gaasQYFPvXeK4eTkhOv/cy1AI8li4=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 14:26:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11602306402719568296
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
Subject: [PATCH bpf v4 0/2] bpf: Fix OOB in pcpu_init_value
Date: Thu,  2 Apr 2026 14:26:21 +0800
Message-ID: <5CD977BE2CEFCF6F+20260402062621.2008939-1-xulang@uniontech.com>
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
X-QQ-XMAILINFO: MxX5kg4KifQ2BO6Av/dnQaeudOHNZ+91H+U3U0BbBeaL8Nz6Fs5aqxCr
	tDlZL9R80xKERHhooQD5iziQs5T83/xJQ6/u4uTIkbSTwbIEuDA+I13v5ABlDw2BfYFc1Eq
	ukIwv1aI9oDHEf2ygHavjjHAGFGLKQz8SBvfw78+94QLwmeswyzqp9CO52qrSx2XyO7yrE6
	mR3BcO17oSlJjg3VvHQQYOw2mGJTzfkyfTpajmxn9PEQsmmEhUvH6pvef/ks9wM/6G+0Pit
	Nhm2fv6YCaRfb9eCSTiPVt1jub+qPX1EyZRFu0op065tDufr2/epUzE/HbJEHpg3Z/4jwon
	THqXC2VUht5dH1uWIGkrd2CkxuLy+0hOFnjF7hWMmL5pGvFvU7SI5lueueOvLoEbZSXtrCx
	cfJD5/g50Rau3u/THv0MI8M68adCPELnxnuzwRjbyJralTzq5nCTb5pQw0KoS2ip/eIHSzv
	8IutpKhIaCeRaNvAobCF5y2hfEi2IqxDmzntH6gaT3cKrRC+98RQNddVaUeiEgdm1znqfhu
	/hOvq/WVlAmHAy4YUhfHf9FSr4blHXTeqRjWSW6aw3+DzuIjNgdCTPrNbjnu5o9Za+ZoWGN
	Gkb/HbqDenVdiSmFu7fPxjRa7hQOCqmbjCJEp6f0YIDIzCZ94atARnPaEctIxbOV0KIQgX4
	W6zo1xUog5cFDA2Y0CgbfMlbVV+RyS50F4HPAp9gIm6h3YqkgfM/Ll43WT6zzXiiyupy49l
	Nu7DV1so5g6O7o3hmOjlfqwjcCKhUTgOC747E3sLOHQfEEVjmQkxcBQ2oj1rVRoLbVkIVc9
	Xwon9fGXh6sUfR3KMr4hHKXLyRzmy4Fcz5cq160DSrMXkrhhcbDJ1GaYCQuNsVLJkqClPhs
	clufZHcAPDCS85k/mTf5x9NjrpoHP6pZ+z4yx2E4+A8QnvEdKTBgwuHM6ZcImV0lshr6VwK
	iAyHUWle9sZ/sBnO/er2EAeG8l+iuDbiGRqjNmNz2exOE2SRAkh5605HOqhJztvJY2gXaYr
	HEkjF4GhkEdbmt4L3VDAox7jyXqqTwCVfqekW1AA3cvERzNeZdhaQQpyru1vWzco9vmhZBK
	a9WRz3JeK3OrvoiauPNjXUa4xb6FXUTP2qsRAHXnMsR6269grOEVSeBoUv47jMPPo4DegwA
	3aA/
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
Changes since v3:
- nothing changed, just resend the patch series mannually.
  There is something wrong with my email server(Message-ID overrided).

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
