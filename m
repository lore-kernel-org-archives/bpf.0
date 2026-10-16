Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA94E56C2
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168928; cv=none; b=sMXLDFPt1vb34VQcCIIj7nyO7i4gMRwCBJcUshcZ5bRFaMm5N4JhXnwbDN7b/VZl1OkuV6DD3HwAe8X/CYGPaGB6OvcfxN9mCz0SKR9zMnTC0hcsoTFY3ekrCYvziPsK6j4zEilrcZHJDxNWbWd5iXrvU4PuEt3qr/vCAp+yGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168928; c=relaxed/simple;
	bh=DSS/kj+Q/LnprSfzl/F/GxZMBWv4KsNRaTgTf0RzE+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQU6H/K737P9jv5Ahb9+6TLT5qR486b50lCqXwCUcgkTTQgoSpNxvLW3LLcmLVrbZ71WKcBnhavw8KpeNHWVDYxogrE1ONHyrJjQ/+cm//oRunJtjeHnArZgjonxW25wYcV07J2H6yCoZeJ/Fal3MCDtriaE7FCKWZM1rpS7lJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ap45OL6F; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ap45OL6F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=vFzJlXgkioIvRSiGAreQlXQJyWu+1KTL+tmj1VENdGU=; b=ap45OL6FZmQazl1q8ROUXtx1xf
	GJ2iOIWisakcJ3irzUYM8l1pmc/C/5YDwEJ7GkBPDlz2iX6Q1Fut5eZB00+3QytA+ZxHRbnWwDzV5
	8C4mPBFD2VdmsOhhvHdhxO57pslXmc49nFsBqI/SiMmK+IAl9GNYa+fT/x8xbZYIranjNTgTiXOPV
	RqnG04dyze/whxGHQ7SfEVXFA2QYhAMfmXAvWWHG4n/8kWCdNb482RTM2ZwqUy/GlIS84x73ExQNt
	cO0PpAS7N/clxtJNrn25bCZCMhPtj8oHrOep1QG2qo02Epj601XtM31U/XIVNz8BhbdpaOkiEXMIF
	OMU0yupw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHl0D-000Kw0-2G;
	Fri, 16 Oct 2026 18:41:53 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>,
	Tianyi Chen <hi@tychen.cc>,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next] bpf: Don't echo user-supplied map info fields back to userspace
Date: Fri, 16 Oct 2026 18:41:53 +0200
Message-ID: <20261016164153.656430-1-daniel@iogearbox.net>
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
Restore the original behavior by keeping only hash and hash_size from
the user copy and zeroing everything else before the output fields are
filled in.

Fixes: ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
Reported-by: Quentin Monnet <qmo@kernel.org>
Reported-by: Tianyi Chen <hi@tychen.cc>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/syscall.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 654f896af265..0b11ba9837c2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5437,8 +5437,9 @@ static int bpf_map_get_info_by_fd(struct file *file,
 				  union bpf_attr __user *uattr)
 {
 	struct bpf_map_info __user *uinfo = u64_to_user_ptr(attr->info.info);
+	u32 info_len = attr->info.info_len, len, hash_size;
 	struct bpf_map_info info;
-	u32 info_len = attr->info.info_len, len;
+	u64 hash;
 	int err;
 
 	len = offsetofend(struct bpf_map_info, hash_size);
@@ -5450,7 +5451,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	memset(&info, 0, sizeof(info));
 	if (copy_from_user(&info, uinfo, info_len))
 		return -EFAULT;
-
+	hash = info.hash;
+	hash_size = info.hash_size;
+	memset(&info, 0, sizeof(info));
+	info.hash = hash;
+	info.hash_size = hash_size;
 	info.type = map->map_type;
 	info.id = map->id;
 	info.key_size = map->key_size;
-- 
2.43.0

