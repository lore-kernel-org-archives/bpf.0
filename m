Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B135F166;
	Tue, 17 Mar 2026 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741853; cv=none; b=n2glawSKGoNiknFQqTKlMYNoPxBAoY9fF1PnsUAWPbq04e1Fb1LXB/TiWQdWdTvmJWv6Jkb0u+2tVCzn5Y0bZvLNBJXxWd0NTJ1jTDSLUkFRbMBQpOnfscR5/vmoyVFtSJkwGvt9TOrZgrTr+9rxI4mrrmQT/ugEqsecARIyulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741853; c=relaxed/simple;
	bh=W6U5osNGJdMj8LvVlf86aq0XyoPI4WAiCnA1DzrX4kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbKwrHFZXuA8eQ9xJjOA6D/V5gbU4oOoTzTdOsnB2c8LszUtP25EJ9KnT2I//Tui2gZteV/mpwyZkYurVQLi2ewBAwm0kP99phIhfteVFK0dtvEgcz/2+mwhGpQir2x9MSiq5YjGegS50R9Kuk+EE7E1WoVaUY9GCw2cf3B2UYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=m0V0Bp9O; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="m0V0Bp9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1773741817;
	bh=knhVkK/o5wutC2ZYGK/P64zxrAtK3BiS82ZZ/Wcikfs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=m0V0Bp9Oh55pV14otT2MUhXMnmClYYkRVSn0OJACcY9DqO5vu5CdYHMfpV8Qfpq5k
	 7+4+SPp8f+mZ6KoCTxd/guPdVQLv7SUUZcQ14i9rlm8zVWSiZ/CkQRGkrhHIgrnlEa
	 /p8q41LafOXItT3q1hwwe5uaENty4OJAWeaC2zxA=
X-QQ-mid: zesmtpip3t1773741811t9206c7e6
X-QQ-Originating-IP: 8uLP95Gl8inFtF8o38RIhtDlTc0WewOkLWpsEjyPA78=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 18:02:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6445063610275196397
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
Subject: [PATCH bpf 1/2] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
Date: Tue, 17 Mar 2026 18:02:26 +0800
Message-ID: <7A2B50421D98AFDF+20260317100227.2157104-2-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317100227.2157104-1-xulang@uniontech.com>
References: <82ee475b-034a-442c-b290-cc7905a7f33c@linux.dev>
 <20260317100227.2157104-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NOVhbBM8HVHMj5XXgbbgMfYYfYzuNgDQw1i8cdElwNunM5cFcyN4TpBI
	grDZvLnxmsiNDbCmy6EImsiu3IuLAXS6Pw3Grw2ZzG454irtkOleM2U//kVq6EH5PGpOfOi
	qMCU2OEM8+ctRLCx0iLwd60AEmPqZ4NJ4zS+sSotHu38fQzFAR+WM8hKmjqFGx+o/4PWA87
	AIvCKxpTcXU5mHZ9QKBiFryezf1wQPRNAtsuZPpkAscMUPLetQmqIG0rNheHeu8d+bIeJAs
	MOFdg9yI2Hf4uZR3/xL2Z2y81dWRWyI2GL2GiMlGkQxefr46KW4EStj+2jUhHORvFBNu0cs
	Ay+X681qRQeo0pCwsbechG/soKTX8DOAvII/a+PpqZriMZ2Uk5Xb+GECRg7KT/WNbmnxIcY
	rHOJQQFMBufASXl6XZAH0JJdFOaQeyb6gkKhCYPpuO1uR8445gPnC69SuZSHP1OqjsB+cSH
	T74b23PlJrXUySgT4R55O0rx0dsRCKfILni4zMmMJEVL7EzRRy3osHjMT5l9YnxYNAumIbo
	+Itr5607S7Hqvm1DmhcW7dv4IxxkiR4XAKFSwnpvFz14dSNnC/LhDRiUqD0R3RzSO14rCe1
	21LZLU2iQNqV1tMPXmvEEH+m7fn4pOluCvZ97/Ni1qW1BMsUAjPnH2DcWaUpRqp5LahXEBW
	PEsWTu/+ILpAnRtgBA9Q2y+OZQs1diqKx1R4lXRCOvxa8eEyPlu0iD/U1TfQGFKhX8D18PP
	WOSdDItFiJ7U8EEIWchYuRrw5rcsTDMHz6ueJQ2ejBD4O9R3ZUF3QR0iScbWkrzRTpsNED9
	DDSbgpucmOPpeG6uNFc29EGZnE2WSc1Q6mVwwHIKtBMwW2UhDpj4ukdiJn3j620KNkhgBen
	JJqwoWzRcFUr1Iq6PWPlnB/7nRfnKxPNb+hxPfLsryHrITX2iSnG2DuBhimB02p0jDAU6AG
	Sha3PaOS9KFSYeLYPc13oEN2y7tnRqwfnwYMOkNzFxxYrpCKcutvpsFAXtOwVdm5GB8MjwI
	rwqj8E5zR+i0Hk/YQxW5wdrDUBnA86vvOyzFEi4mjn2hze/fQp
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

