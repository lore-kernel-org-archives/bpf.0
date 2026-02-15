Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFC3EBF0D
	for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771114023; cv=none; b=kYxexW+Hlgh7qKNmUsnGa5L9UNyAHFMhsZdwvDmSj3vhXXY8gUmkEVlPfTrP0fN9aSTnYS6rH9QwpmaDUta6VeTic/x6wd9NOEIYGYsZrZTAWXclTf+b+ng8yMpdvS9rx/P6iR6F/Dv5jCH48GMFjRjE3E3roweFc5nOHcayAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771114023; c=relaxed/simple;
	bh=OeXJQ/kpHZYZgRZcfTbVqK3QB8Nia9vVIhGlXSym8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRYTeXN3GItSUdCrPV5aAsnU6nDJ8U7yfM0yZFStyftPiOt1kewWs9X83QjXyOPYQ8viyVFHd/Yd0UTThefxjBxiRB/kAujWnCCJOR6xsYePgpT2c/+UOGaiaThMCo71Q0ezumihyIFky96G5aHl4ytmqfPbkFXrAHh0olSo78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPaoZcXy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPaoZcXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B68FC16AAE;
	Sun, 15 Feb 2026 00:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771114023;
	bh=OeXJQ/kpHZYZgRZcfTbVqK3QB8Nia9vVIhGlXSym8Ps=;
	h=From:To:Cc:Subject:Date:From;
	b=PPaoZcXy7/zfap17yFd66+YkS+Qv7WkQp6vlxsJooPR5lnq75cbtFYM/2qqe57GTi
	 +TiviPUCpu+FFVBIpirjG5bt7dKgCSUlX1HRdYR6ctQPyglW9xebYWNaSHdyP4waXh
	 qdLrv4AYt8c5iP+5iGHqwftkUIC6zMJXLxZ7Ofho39fX6YbYQOQ2+oLoccs8gpUDBC
	 bI3VaPKQROHi5DQoNA2mwcdXC0HedJBneWzRnBtz/tTOFnhKZ49rvnsAzOPt/ocS/I
	 only2A16ig0zJYTL+9+gMcSm+oASzM52SH1SCHRuW+Q96TjNBMTCBPzMSQSNIvMsGa
	 HO73tnay2moGg==
From: Jakub Kicinski <kuba@kernel.org>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf v2] tools: bpftool: fix truncated netlink dumps
Date: Sat, 14 Feb 2026 16:06:56 -0800
Message-ID: <20260215000656.323486-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netlink requires that the recv buffer used during dumps is at least
min(PAGE_SIZE, 8k) (see the man page). Otherwise the messages will
get truncated. Make sure bpftool follows this requirement, avoid
missing information on systems with large pages.

Fixes: 7084566a236f ("tools/bpftool: Remove libbpf_internal.h usage in bpftool")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Sorry for the long delay! I haven't CCed netdev@ on v1, and it appears
that CC: bpf@ + kuba@ gets misfiled in my inbox.

v2:
 - make the same change in libbpf_netlink_recv()
   note that libbpf_netlink_recv() does a PEEK and then realloc
   if the message is larger, so it's technically already safe
   but probably better if we are consistent
 - fprintf(stderr) -> p_err()
 - adjust msg
v1: https://lore.kernel.org/bpf/20251205011823.751868-1-kuba@kernel.org/

CC: qmo@kernel.org
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: eddyz87@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: bpf@vger.kernel.org
---
 tools/bpf/bpftool/net.c | 5 ++++-
 tools/lib/bpf/netlink.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index f25d66c8395e..974189da8a91 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -156,7 +156,7 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
 	bool multipart = true;
 	struct nlmsgerr *err;
 	struct nlmsghdr *nh;
-	char buf[4096];
+	char buf[8192];
 	int len, ret;
 
 	while (multipart) {
@@ -201,6 +201,9 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
 					return ret;
 			}
 		}
+
+		if (len)
+			p_err("Invalid message or trailing data in Netlink response: %d bytes left", len);
 	}
 	ret = 0;
 done:
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index c997e69d507f..96c6b09c433e 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -143,7 +143,7 @@ static int libbpf_netlink_recv(int sock, __u32 nl_pid, int seq,
 	struct nlmsghdr *nh;
 	int len, ret;
 
-	ret = alloc_iov(&iov, 4096);
+	ret = alloc_iov(&iov, 8192);
 	if (ret)
 		goto done;
 
@@ -212,6 +212,8 @@ static int libbpf_netlink_recv(int sock, __u32 nl_pid, int seq,
 				}
 			}
 		}
+		if (len)
+			pr_warn("Invalid message or trailing data in Netlink response: %d bytes left", len);
 	}
 	ret = 0;
 done:
-- 
2.53.0

