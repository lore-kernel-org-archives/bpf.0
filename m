Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0454CF484
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178202; cv=none; b=ZlTKlMuWFvZFsU/j6G4gwRrs//rab3zwM3vWn0J2qw00QoOgjj/QhlZnPy1K6/EDFd5A2ehZl57DxnaXCDilOVBxd9YxK7S+ASuo7+S3o9grOkic5lrStO4WyBJ5Fg28XSRmduTaXp6cx9juwSEgS6m0yaDk809AgyErkH4tbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178202; c=relaxed/simple;
	bh=EJDg1sQf0vI5gRgj8opBHcUpcyt7M+22gyLQ52JWBOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGOwWnKg0+9Hqu4VQ4TT2lZN66uLigjYPjjxVquZT0xz29Vu8BKkFFDZxVMEQx+MzC3/aa43JB8AWLZdVBVbqMGM4sG4wz6WsZJ+H71Jk4CCqSMlDYVQmUL7cyi4dcQzZTyYdWP5p/DrFcjaZHavVX2NvH6cyLEBou0tg47eopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZSO5vgOE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZSO5vgOE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=W/CcH4Su6q0OXsq2OxQ000VdHtk+8wqqckh9hvGD37w=; b=ZSO5vgOE/HMFF+GtngKucbhnx3
	gmxJ0tEGFZte73KEobWgpXuqPUgsI8ab4ESMvpi9EUyIcHxRuvhj6FLLZmVBpmaIrTz5VKxXqEpVW
	VIPhIhzPyP/kJa5FnTlwX3qKmV3KLx18StAVdg+cJ5QY+rNgb1CoP4nVHPSSvfaEv6u6xgG/tHlhy
	hWQJUwNmVhIAYi9BRLnQnK5Rcf9AOpjFs03dZlepvCoMBk6nWWOaRik67HfNBhmHYnzLjLB3RNi0E
	xduOdpwbSr4Y0hB3H76LnQ0L/SVINk4e9SDAc6i1Wy/JoIC+x2eaAJ0Q3xL72xi3cCF/qztdRRgs4
	U17SbbSQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHnPv-0002hM-3A;
	Fri, 16 Oct 2026 21:16:36 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>,
	Tianyi Chen <hi@tychen.cc>,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v2] bpf: Don't echo user-supplied map info fields back to userspace
Date: Fri, 16 Oct 2026 21:16:35 +0200
Message-ID: <20261016191635.662690-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

Commit ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
started copying struct bpf_map_info in from userspace in order to read
the new hash and hash_size input fields. Before that, the kernel ignored
the contents of the user buffer and returned a zeroed structure with only
the output fields filled in.

Some output fields are only set for certain maps: btf_id, btf_key_type_id
and btf_value_type_id when the map has BTF (and btf_vmlinux_id for
struct_ops maps, ifindex, netns_dev and netns_ino when the map is
offloaded). For all other maps, these fields now return whatever
userspace passed in before.

This breaks userspace which reuses one bpf_map_info for several queries.
Restore the original behavior by zeroing the structure and copying in
only hash and hash_size from userspace before the output fields are
filled in.

Fixes: ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
Reported-by: Quentin Monnet <qmo@kernel.org>
Reported-by: Tianyi Chen <hi@tychen.cc>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: KP Singh <kpsingh@kernel.org>
---
 v1 -> v2:
  - simplify, only do memset once (Alexei)

 kernel/bpf/syscall.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 654f896af265..0f27604a54aa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5448,7 +5448,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	info_len = min_t(u32, sizeof(info), info_len);
 
 	memset(&info, 0, sizeof(info));
-	if (copy_from_user(&info, uinfo, info_len))
+	if (info_len >= offsetofend(struct bpf_map_info, hash) &&
+	    get_user(info.hash, &uinfo->hash))
+		return -EFAULT;
+	if (info_len >= offsetofend(struct bpf_map_info, hash_size) &&
+	    get_user(info.hash_size, &uinfo->hash_size))
 		return -EFAULT;
 
 	info.type = map->map_type;
-- 
2.43.0

