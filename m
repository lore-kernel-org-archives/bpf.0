Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228E259CBD
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357316; cv=none; b=TsP6hDZE5vFdyeMykWJ5k3a2yJw2wXi5f+0mCNCEMoUb4QDTe3Ip68eYwfsSqdmCyHa7N2NlZ6NygdQ8MbMHK1VJQZcpScUfcctDe6fkdWXyv+f6IBOs6+Q/gZBUsGYYojAPUr+ivOgPqiYrw6fXDKNLSFB0ZIBXAa6UKr+dfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357316; c=relaxed/simple;
	bh=a65CzXx9U5Ab7OEsMU5Lb2kSdX7Bfoqj2I9LLUZkJUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPfbaHqLB5WhR5FuCTSt5cNcaG4igBd5j8y6ISlq/IgbyPZd5NKFDs5WoIcZtrTgGZk2ptiDmb54g4GK9tAnc6biXniI+3lCIXyL+Rdc3/BNkzkAEevX2iF6J+5OqtIRBEXsFekEjEpHz6hFflijQpZkj0jplEQJKPea9l7efbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKH+UNAH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKH+UNAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1BBC4CEF7;
	Tue, 17 Feb 2026 19:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771357316;
	bh=a65CzXx9U5Ab7OEsMU5Lb2kSdX7Bfoqj2I9LLUZkJUc=;
	h=From:To:Cc:Subject:Date:From;
	b=RKH+UNAH0Po3/P0UB2RQNUmlEVB1OuPGkE3dMF+xDLMPyTU3yqAKG9lYDwTWWv+tQ
	 v8tbNx1Mmebvf/QW0c4STc/OsjBv3oomFv5zm3/mbDXAoi8Jwc+KQ5ap9VR5BYVmc5
	 TifDWmx/ALSkl8TWKWUNhDp4UnU8VKlaNlgZCpB/jaxIYfriwNxVGU8Fg/hXHpv+yv
	 BX21morEXFvPy7+Y1cx2Hi7kYHFZkVh1obZUpDPZhKbO8cBc6NJqP1jb1ev6Xrfcnb
	 7NG8VuBFridsMDMdVl6pcE0FetKUYqVv0OduiuEdx86cg5rrW45RoJe8JdSQOa7iTP
	 uZf4ZlAmeW0lg==
From: Jakub Kicinski <kuba@kernel.org>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
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
Subject: [PATCH bpf v3] tools: bpftool: fix truncated netlink dumps
Date: Tue, 17 Feb 2026 11:41:50 -0800
Message-ID: <20260217194150.734701-1-kuba@kernel.org>
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

Acked-by: Quentin Monnet <qmo@kernel.org>
Fixes: 7084566a236f ("tools/bpftool: Remove libbpf_internal.h usage in bpftool")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - add missing new line
v2: https://lore.kernel.org/20260215000656.323486-1-kuba@kernel.org
 - make the same change in libbpf_netlink_recv()
   note that libbpf_netlink_recv() does a PEEK and then realloc
   if the message is larger, so it's technically already safe
   but probably better if we are consistent
 - fprintf(stderr) -> p_err()
 - adjust msg
v1: https://lore.kernel.org/bpf/20251205011823.751868-1-kuba@kernel.org/

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
index c997e69d507f..c9a78fb16f11 100644
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
+			pr_warn("Invalid message or trailing data in Netlink response: %d bytes left\n", len);
 	}
 	ret = 0;
 done:
-- 
2.53.0

