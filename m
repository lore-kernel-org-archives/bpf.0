Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676978;
	b=xN2qeG9zRgfN0ZBrsKTGpNbkXji9rcOXBx+GKsoxryT5ENyiNVjhixqKTgjcYpLzeJZX
	 JQMzqpOpa9xv/TYbIjoJ5ulLT4C2/vWlES0RweqEnJNTesInspRmbcyxuC+rrIwA3NUXY
	 0prsj5oc/voTx58eyisNN08/PycO4j23ftqJ+kJ2b9R/0VEXcwqB1pp69tD7ev7d2AB90
	 HDaq3bY6zB2GlPLo3fgV7aPJU8CA0v28ho/HWTng37GhhOl8wn0dvV65R4Bs077ap3K1y
	 +bFo2xw3uTfH9joiGbG7D6qI2lvQkOsjGDz4wEtjalEM3X1ZIu/90XvH9Gcr8AzROBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wsw4x3FfCJ+pN/2oal8RH+4qQ7zCjiSz9UZAU4n7+7g=;
	b=4BQ4D28PVWnj7p8Hd3AFuh9VJvskkrRr+pUSJvbWhhGgJO4NsSJOaHKxeN51NOtDLJHJ
	 VRz0rMnsogO49JrInEomrs94V6Rfdsi9D+vau0ipJ4YHliyKwfmCTfsytydt4IUMpj53B
	 9kpAQlciIgNQpdzIrQGaCksB0afvw1LO1q80MIA15NVbowrQVggaDZ8A5KTw8OWLRY4Oi
	 UVxQrrpcCuGe+lRuqbh+C6wC5Mn6hV7OF4C5bLk3nuwjNm5liv5nEoG6UgW/x6i8A+vkv
	 cXMh/FsUope6/l4wzz8VkzU4j5WXcpaQX2kiSI5E3t0FZclxqvbk1JhnpLu4j16MGNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sc76JSK4;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4364606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 03:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4364606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sc76JSK4
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9912c61b8b8so1879496241.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 19:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793676977; x=1794281777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wsw4x3FfCJ+pN/2oal8RH+4qQ7zCjiSz9UZAU4n7+7g=;
        b=Sc76JSK4zjl2ETNUSMOYa1pklyS18Uew1akrbZZzlCb8K9hW1lB/uHYD3GcM4cGgZn
         KqLZKHrW+2IFnD9oKBqzpbRSWOhzv9P8gEph0+Blr1rHNpOETEpr40sAzBAnHwFNnWfT
         pVsT7EegLiqt0IG2riv/99Kmj2ZTvz4BaxAYn7mWlhSn7WIbZpH4CaGW1ctemEG0OEnD
         NqEFyYQ3XWkWeOs/yCb/LLwF4Kdjx3XsGBcHWeUbeJX96g0Ff/0w3HG8D1CF8erJw0MU
         4JsSM9N5ZUfmZw+Y4nRms01IA+F1ODehxAhukDzZqmS3sYSK60+J66gaZF6604toETdF
         3L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676977; x=1794281777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wsw4x3FfCJ+pN/2oal8RH+4qQ7zCjiSz9UZAU4n7+7g=;
        b=jVGv9xeqRwIhDrJ+fQFawAhOM9sBS6kUisx3xEjELY6z0j+bC2eqv8lQmCrZ9D5mFX
         kh8SYpE9uFDQ+MDbGu0vL40Av4MAFZXzGV5jteMf4oYltYhGH0sSgfk7ZbZw02QxpTAJ
         Q+JX/dqM5AJevwVugeCeE92ssCegsPVgFHU3KEguN9ZxRQ7WyJfpjlnaEvxRjT0Xd0RX
         A8xCl5yfVN/1+EBIO9Dv32aLkJIqwwBowPkK/hzvhX3c8eSMEUc4y2SklhfrROqtbhvL
         91Rq2Y0cfFvR3K8VslX1NKWFwem2OKPgopNipYv3wR/3PZ1tLyaOcmCem4Fko+EKo+B9
         PYmQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5I4IkZqnzVyI3v4uQ/lexue2/FygtTw6Wwfmz5dM4HkFxL484TAQkQaMe3Ms5qV/vmaI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I0uzXxlKXAMiPhUdCKps9Zt/1RaCbdPEHk+KoQnplwjUZ/GO0
	JSvNfj/0joVx+aPufeoc685daAihm6MZkVU351b+CP2Up6KauTLvA9NO
X-Gm-Gg: AYBFou3+BB8kjHh2DON1tLoN8H593qMbGiYjnKHSun9hJ9Fg3Bl0WapXD5+uOMFwcnL
	qOE3mEKyYZfY74iXt8IMjcJNet5g2EUgzWerSOuHNKv1gDWm5LEMUArXkMx+Fl05LMCbw2x50pp
	aogwOox/8yoaGUajhvhTZoNOk3kMlfombYQ+5DdVdaI0Qk1X58OM22s0OTUV4YJU6wIQMg/58Z+
	WCFFlmfswmxf2XnQ3SsAcp+WfmZh0cRgTvkx9+Pxmq3i2/PhXFU8zUyrpVFdKKLuUlR0tmsdL42
	C97+3fGpF2GPqjn60o3s1j8itUSu68MFhFeQCFbvTQyFtSt/al0XJK/4VqJDH7dbVf6hr8K1QxS
	OWKp0NS0BfqZSDeCawBU0qy3HK1JUehSaLuSrp/fwbSabzX810kYJ0IV7S5GSeI8OwwK4jgNEya
	6gO/roV73GVnCYSNqKK391tTo8Tg3I+6AuevK550S2bdlvLSOI0SMuU3McAFCjbP6AK4fivdgSi
	vKZqD++X/NPRSI6FogjqinxMnADYj587GvP/V5tE7HzQE7jije9j5u988uCw87G4TMwy29Xe7ly
	hHWI65KLqQzHFeyDZrcm0L2thGSr1G925DffW5z9gQb4FfH3QdGp6xGVgpus3Uoar+5eiDqWUxJ
	vhjgrU/2niFJlKbBoafVQuwh0j9Jac2OFNTG0iu/ofmrCXUwcCT3Z9wWIjqFvZvnT2ot29URICR
	f22+a2RkRe4R2dq8LyOw==
X-Received: by 2002:a05:6102:6058:b0:7a4:da60:acfb with SMTP id ada2fe7eead31-7d072bb37b9mr3882342137.8.1793676976764;
        Mon, 02 Nov 2026 19:36:16 -0800 (PST)
Received: from willemb.c.googlers.com.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee1d1b35sm13341793241.1.2026.11.02.19.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:36:15 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] docs: netdev: fix iproute2 process documentation
Date: Mon,  2 Nov 2026 22:35:56 -0500
Message-ID: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
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

From: Willem de Bruijn <willemb@google.com>

The instructions on sending patches to iproute2 span both netdev and
bpf docs, contain outdated references and miss some instructions.
Address this:

- Move all info to maintainer-netdev
- Add a link in bpf_devel_QA to this location
- Update URLs to git repositories
- Update URL to patchwork instance
- Update subject prefix rules
- Add suggestion to Cc: maintainers
- Add pointer to iproute2 MAINTAINERS
- Add pointer to iproute2 README.devel

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/bpf/bpf_devel_QA.rst          | 30 ++++---------------
 Documentation/process/maintainer-netdev.rst | 33 +++++++++++++++++++++
 2 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 4729efd657c3..888b29599761 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -304,31 +304,13 @@ downstream distributions.
 
 Q: Do you accept patches as well for iproute2's BPF loader?
 -----------------------------------------------------------
-A: Patches for the iproute2's BPF loader have to be sent to:
+A: Patches for iproute2, including its BPF loader, are sent to
+netdev@vger.kernel.org. For details on iproute2 patch submission, see
+"Co-posting iproute2 patches" in Documentation/process/maintainer-netdev.rst.
 
-  netdev@vger.kernel.org
-
-While those patches are not processed by the BPF kernel maintainers,
-please keep them in Cc as well, so they can be reviewed.
-
-The official git repository for iproute2 is run by Stephen Hemminger
-and can be found at:
-
-  https://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git/
-
-The patches need to have a subject prefix of '``[PATCH iproute2
-master]``' or '``[PATCH iproute2 net-next]``'. '``master``' or
-'``net-next``' describes the target branch where the patch should be
-applied to. Meaning, if kernel changes went into the net-next kernel
-tree, then the related iproute2 changes need to go into the iproute2
-net-next branch, otherwise they can be targeted at master branch. The
-iproute2 net-next branch will get merged into the master branch after
-the current iproute2 version from master has been released.
-
-Like BPF, the patches end up in patchwork under the netdev project and
-are delegated to 'shemminger' for further processing:
-
-  http://patchwork.ozlabs.org/project/netdev/list/?delegate=389
+While iproute2 BPF loader patches are not processed by the BPF kernel
+maintainers, please Cc bpf@vger.kernel.org and the BPF maintainers for
+review.
 
 Q: What is the minimum requirement before I submit my BPF patches?
 ------------------------------------------------------------------
diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index df220a965438..51669d66c272 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -363,6 +363,39 @@ to the mailing list, e.g.::
 Posting as one thread is discouraged because it confuses patchwork
 (as of patchwork 2.2.2).
 
+Co-posting iproute2 patches
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The official git repositories for iproute2 are:
+
+- iproute2: https://git.kernel.org/pub/scm/network/iproute2/iproute2.git
+- iproute2-next: https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
+
+Patches for iproute2 must have a subject prefix of ``[PATCH iproute2]``
+or ``[PATCH iproute2-next]`` to indicate the target repository where the
+patch should be applied. If kernel changes target net-next or bpf-next,
+then the related iproute2 changes need to target iproute2-next, else they
+must target iproute2. The iproute2-next tree will be merged into the
+iproute2 tree after the current iproute2 version has been released.
+
+Patches are tracked in patchwork under the netdevbpf project and delegated
+to 'shemminger' for further processing:
+
+  https://patchwork.kernel.org/project/netdevbpf/list/?delegate=7961&state=*
+
+Send patches to netdev@vger.kernel.org and always include the iproute2
+maintainers in the email Cc: list. See the MAINTAINERS file in the
+repository for email addresses and other details:
+
+  https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/MAINTAINERS
+
+For patches that target iproute2's BPF loader, also include
+bpf@vger.kernel.org and the BPF maintainers.
+
+For more information, see also README.devel in the repository:
+
+  https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/README.devel
+
 Co-posting selftests
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.56.0.385.gac671c819a-goog

