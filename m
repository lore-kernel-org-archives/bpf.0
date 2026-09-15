Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF83DA5A7
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484874; cv=none; b=FBL7GvM4sb6Twul+YG0biqXti5TR91r3VVIw8m5PkOTN5MPXU7gmiHZbC22gJlZWM5SZ7p/x4VZL+aetCK4AkxrFTcjgew0qA0RDvIs32vG+PWfQuEvJVrsSt/7emmkbvPY1kNxgG6nt6X+SyMmaUVT7LoFG14rKTBsXqViWrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484874; c=relaxed/simple;
	bh=nMsJNuf9XWtalCrixrvyPx5t3/GfgVCbQiBRWTTkMp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aon7aWOEwcRGCPdGCpTXE3kYkjOKJ4mJjX3dxMoDbpI/SOWoY8VhgT1J+NLEYZpNLOPcZ6UTkXM2DN83SX5TPSI0CbGI/47el/PpYNmZ3jEFmNe4F/f2KwFZ9O9KSZq5l/kKSzmwS0ujtACx666W8Ax/bw0OE7PRwjaRwLBiRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Vg+9z78a; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Vg+9z78a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rYsuvLVpC9w9s4SQi4rT3invNRRiMstvKaxqXpbT0rU=; b=Vg+9z78aaY8HBwxbwqRUROxWs9
	Efr9F5HSLDwN/x8kqYAX4gEERHX1lla0/VIk/B3UXD64XEdXfSURSxJt9Bce8iTJOmdrhSbjTbbhZ
	GFy6BSLpDWcVlluj5kEOdeqzIXUp/2BXxktBDjbbvz5DMcRZGEASX1qlNsCc8Ivif7j+tGNKYrcHD
	5iDgLiQg6h/o3LUbQqfxobJgqXBzxXInUNLwUc0H/Nq4cJzl/av35MFCFBhYZ90EhKjLuUfbCpqzn
	JD4ff2p5lBzrKheQRM3pAMWxO8oRkjoa09+jxE66dHTA6+yNjNkr8eYRbRVS6erkPC3G4DV5JUduN
	TXA69YJw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6Ul7-0007KW-0O;
	Tue, 15 Sep 2026 17:07:45 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: brauner@kernel.org,
	dwindsor@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 5/8] bpf, lsm: Mark the BPF LSM hook overrides noinline
Date: Tue, 15 Sep 2026 17:07:36 +0200
Message-ID: <20260915150739.284189-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915150739.284189-1-daniel@iogearbox.net>
References: <20260915150739.284189-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28124/Tue Sep 15 08:27:28 2026)

The stubs that bpf_lsm_proto.c overrides are generated as:

  #define LSM_HOOK(RET, DEFAULT, NAME, ...)     \
  __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
  {                                             \
          return DEFAULT;                       \
  }

Mark the overrides noinline as well so they hold up the same contract
as the stubs they replace.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/bpf_lsm_proto.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_lsm_proto.c b/kernel/bpf/bpf_lsm_proto.c
index 4a776df76cbb..b81179ae2e08 100644
--- a/kernel/bpf/bpf_lsm_proto.c
+++ b/kernel/bpf/bpf_lsm_proto.c
@@ -13,8 +13,8 @@
  * explicitly enforces that BPF LSM programs check for NULL before attempting to
  * dereference it.
  */
-int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
-		      unsigned long prot, unsigned long flags)
+noinline int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
+			       unsigned long prot, unsigned long flags)
 {
 	return 0;
 }
@@ -25,10 +25,10 @@ int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
  * suffix marks it as PTR_MAYBE_NULL. BPF LSM programs have to check before
  * dereferencing them or handing them to bpf_inode_init_xattr().
  */
-int bpf_lsm_inode_init_security(struct inode *inode, struct inode *dir,
-				const struct qstr *qstr__nullable,
-				struct xattr *xattrs__nullable,
-				int *xattr_count)
+noinline int bpf_lsm_inode_init_security(struct inode *inode, struct inode *dir,
+					 const struct qstr *qstr__nullable,
+					 struct xattr *xattrs__nullable,
+					 int *xattr_count)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.43.0

