Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC273932E9;
	Thu, 12 Mar 2026 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773293153; cv=none; b=VpEuBKNKrd2L47MOI2YhXK2Ilz4psuyRLxII4Sy/SPJ0OAGTKJsEyGLAdIMioyxRXwEmHpIeCC48QmbNVIsu2yOqosv3J6Cbd77o/ogqCxm6YoQx3vglKBV5bR5KLkMIWJkPMaKNzQ/hvFUfSGKg7EmNoTTsjzjnHFvfVYqIXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773293153; c=relaxed/simple;
	bh=W6U5osNGJdMj8LvVlf86aq0XyoPI4WAiCnA1DzrX4kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlEjOkD26GbD285jRBswe1oidtkhMdl9Q9qus4n4AO/i2f3MomXLvCcCS4WiH2BX2y1Q1nv4DAm0J8uvu3V2Wx2LaemDw2Y/XM/88uUxDtJNzmt1uWBTu0Uli4d7dJC3sdBRjJ27kgqfBoeGjJ8Kn6OBOlw6rX8k2kKdiKYLaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZXYILeYX; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZXYILeYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1773293140;
	bh=knhVkK/o5wutC2ZYGK/P64zxrAtK3BiS82ZZ/Wcikfs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZXYILeYX2IB2VEPC7Ru7RHqolAjmDeZPTfpMoprWxbvy/nTM3JFbLAE4fERhnHOw7
	 hJBGgHi+3JZjfE8c0PbYAFctV7HnW120RDHOeZRCSl4WYtsoYxsoNsDM7kyyP+SdGR
	 6J4eGHN4Z4iDg3R83i0vWxSyUCL8RjCDuKYygZTI=
X-QQ-mid: zesmtpip2t1773293130t2541aa01
X-QQ-Originating-IP: GPeJVjCYCEWM/dkCDLd605XtREQB8BuN6dQqiruXeyg=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Mar 2026 13:25:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6035558201512336410
EX-QQ-RecipientCnt: 19
From: xulang <xulang@uniontech.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	huyinhao@hust.edu.cn,
	dzm91@hust.edu.cn,
	kernel@uniontech.com,
	linux-kernel@vger.kernel.org,
	Lang Xu <xulang@uniontech.com>
Subject: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
Date: Thu, 12 Mar 2026 13:25:25 +0800
Message-ID: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>
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
X-QQ-XMAILINFO: NThgMOl/3vH770NE2G4V/rDKHRil7K/pSGK692AKRgAXEB3CwgyCK7Kk
	m8ZoTwx/Koze6GCeofExLjBTgWD5axlkvmJHqiKZzlIsMy1Ju/qVH7zslCWEMY6PLXtilZ5
	RnU/jRPxuERFiP4T0nJNoSpfFgtvG/mokl8rZbnJRloY90Jg3+d2e3oj0+T+11k8cM6r7Yr
	+UUimAgQf3umbpRpzrXJBtdJPl5/DQ8n6n1kvkMcpUEG8IXxzlvwNmhHAmqqBGyIVkNRfma
	fEdBoz8aLIkn4hXfcAUWyKu7N3Bn2O0WtSv0QCIXI9U9M5HdlxEoM2o20k8bX5WXUOgSw3a
	9tYtLgEgfIm13betHh5PWM/SjHpyLrm+2vx+oAjBnK0pIE+3zhdqslO4215jWKAioA/9uCp
	L6WRgKWEaxFbur+ZdyG+eHlcySURWnrxESffuh0S61EvhLI/+WZnUWxTVedHN+5qqpBOjpJ
	J91gwQixTHaW/O7QxnBUaRNIJx5ClwRKY0m7GeFHwxQJmREJKxGcztJA6z6m56p+Pgof2MT
	NjxnBOYm4VKJrfsgyWLbCg5KanzVQCVH5mgJg/BEWi75ZrGfmtkI53NU/BetlO8l6tS3QXm
	3YpHNkrBgqAUbIQRVJUrxa2GrLvuCCR79/2gIo91QWzUeCQF0fMQ41xyqE1wz2S/AUQ9ohW
	JAQB0WUF55rZoduh/C6iy0NNnvu4/Lo8SLxIDTbFsBeqJf/BD3yzJJVzDYysYGUL/iBoQRd
	QiQRorW/MjNj+LHHIsSsRUSRAKppB0TDDTqMznJNrer1+Deq+BT1cAoxVRcaAxLbNodO4Ge
	4jsvY80Nzc05uzWRmvsVuzsw8G4/6xKZ+uF33bgFtJvuxviUDQKo9+AF6lyOvlgETdv/E4W
	JwVNKLeSlAWP/5SLMirA2/FYxN+1ixEg/9cl44qpAlwbSuJ8tsYl42VWsOYi5i+WFb55yNW
	2iyLQW6JMH4Mdry4+iMduQvloFBJY/mrCkALtPh7Cs6EOXfXG7bJ/J2GcGm8IG+2bcC7LSd
	3kDQIxqlfOMI9RJJ03FKZFjtvfpc1YHPJgSpVyIpYtKnyl7WhH
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

An out-of-bounds read occurs when copying element from a
BPF_MAP_TYPE_CGROUP_STORAGE map to another map type with the same
value_size that is not 8-byte aligned.

The issue happens when:
1. A CGROUP_STORAGE map is created with value_size not aligned to
   8 bytes (e.g., 4 bytes)
2. A HASH map is created with the same value_size (e.g., 4 bytes)
3. Update element in 2 with data in 1

In the kernel, map elements are typically aligned to 8 bytes. However,
bpf_cgroup_storage_calculate_size() allocates storage based on the exact
value_size without alignment. When copy_map_value_long() is called, it
assumes all map values are 8-byte aligned and rounds up the copy size,
leading to a 4-byte out-of-bounds read from the cgroup storage buffer.

This patch fixes the issue by ensuring cgroup storage allocates 8-byte
aligned buffers, matching the assumptions in copy_map_value_long().

Fixes: b741f1630346 ("bpf: introduce per-cpu cgroup local storage")
Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Lang Xu <xulang@uniontech.com>
---
 kernel/bpf/local_storage.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 8fca0c64f7b1..54b32ba19194 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -487,14 +487,13 @@ static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *pages)
 {
 	size_t size;
 
+	size = round_up(map->value_size, 8);
 	if (cgroup_storage_type(map) == BPF_CGROUP_STORAGE_SHARED) {
-		size = sizeof(struct bpf_storage_buffer) + map->value_size;
+		size += sizeof(struct bpf_storage_buffer);
 		*pages = round_up(sizeof(struct bpf_cgroup_storage) + size,
 				  PAGE_SIZE) >> PAGE_SHIFT;
 	} else {
-		size = map->value_size;
-		*pages = round_up(round_up(size, 8) * num_possible_cpus(),
-				  PAGE_SIZE) >> PAGE_SHIFT;
+		*pages = round_up(size * num_possible_cpus(), PAGE_SIZE) >> PAGE_SHIFT;
 	}
 
 	return size;
-- 
2.51.0

