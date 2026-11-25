Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641572;
	b=DTkogzCekVgwht3TovxNZR461N1nnENMF8Tgwxkp5X8eDHRa6crD3MBNvHy8pZwzdggS
	 VC6+PHbxMtBn8biRkFyGchB1MD0pxusMWGyYalOarOMS86ePicB8qdv8ePZyagRQuH2K6
	 wiSttvRCgkNEA+IuQsaipO1UzvE6xt4y8Zvu2Q8q/NXCJwCmcimNRhzQwNHGHGMEoRwmA
	 e9u7Xi0rI4Xr51bvN89Hyec7iY5pte5DdT7aLL2nrJY6LjGjnP5/KjJXrD+zDxMfDPrBT
	 cKB/wyPTFzNvxddl0eBM7E1SuMouYq5oKN0vt4Ouh7AkisYMFVVS8gW+Q8IwubQFkYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641572;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=PckBMJHu1tKKkh+I2n6DyyQxJfA0GQcy1hIVQJbrmI4=;
	b=S9Rz2q91rxApjmDcyfcYAP9cHnLbkHaH3IK2DTQNtgvF6xJ9Waw9JaR8pnqAbCpYr+YU
	 Exw3Kqx4jkqzoW2m7s3KF4/NwsG68jXOBL01fR0m8aqFeKEIV9RbVhB33YMTpbg4VKmyR
	 JP95v/5D7Gl1dlxazsKIHyEeS/4N1+tS5PhZdtOXg8AWYik+bGeqMwOMh1G2inn1I9Oxg
	 QMmwZrZ9mbG5L4Fk11YzOd4DYfIRmgOC8J66JBXkf0qktzpEmcsy/tbibjWZ1UkslRCpf
	 CL31QmSLckUyPs5w0rvyTTVkJdo3bAI/va/UotE2C+VKYD3XwfM1t/tM2ajk+cclJuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="ElPf4/IV";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24E606A321;
	Wed, 25 Nov 2026 21:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B24E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=ElPf4/IV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=PckBMJHu1tKKkh+I2n6DyyQxJfA0GQcy1hIVQJbrmI4=; b=ElPf4/IVsdPComTheXvr4zqEIQ
	gdatUelZs+ynGxY1Xdkb8BPWSz9aKcra38I38nTjxrYyxUgvIK7Q6aDqbFj1uIcMYrukKJDVe+IW4
	6hqQfVkvgAPyc7UKIVolA6t4drzgRWQc34t90/GTmoOXUwJjB9GYLEwLGKcAOaalzu/HFZp6F0EMX
	QT1q/vl9mzgy1M1kgiSOsY3ELy19da/oL68VEtWYZ+YYqZGuk9ujfcAZY8UG4wIfZnkvHDS6KOv1Z
	ToRSvLtLok4nXRroUfmQMlTNohJFXphowz0/1q7WYLvCJXnUJRyG9ikwmcTqL6h2QafOZsILY4Fnd
	snpAMH8g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xWKOn-0004Hy-0S;
	Wed, 25 Nov 2026 22:19:28 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: brauner@kernel.org
Cc: ast@kernel.org,
	kpsingh@kernel.org,
	dwindsor@gmail.com,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH vfs.bpf] bpf: Read security.bpf xattrs without caller's permission
Date: Wed, 25 Nov 2026 22:19:27 +0100
Message-ID: <20261125211928.3481451-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)

bpf_get_dentry_xattr() and bpf_get_file_xattr() check that the current task
may read the inode before they return an xattr, for user. and security.bpf.
prefixes. A BPF LSM prog keeps its own labels under security.bpf., yet the
permission check is on the task, so the read fails with -EACCES e.g. on
exec of an execute-only binary or unlink of a file the task cannot read.
SELinux and Smack read their own labels with __vfs_getxattr() and no such
check, and xattr_permission() does not restrict security.* reads either.
Thus, skip the permission check for security.bpf. names.

Fixes: 531118f1ccfc ("fs/xattr: bpf: Introduce security.bpf. xattr name prefix")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 35ccd98a4de6..d60093c1401a 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -107,8 +107,9 @@ static int bpf_xattr_read_permission(const char *name, struct inode *inode)
 		return -EINVAL;
 
 	/* Allow reading xattr with user. and security.bpf. prefix */
-	if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
-	    !match_security_bpf_prefix(name))
+	if (match_security_bpf_prefix(name))
+		return 0;
+	if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
 		return -EPERM;
 
 	return inode_permission(&nop_mnt_idmap, inode, MAY_READ);
-- 
2.43.0

