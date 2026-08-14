Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B043E5A22
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691601; cv=none; b=PzZs2fNLtOZEA6rciv+cFq12PWVs4JxrUWUvCJo0Vm4pwlIv+QeDKrTQX62QhfBY6rhNB64BQl7qdx12qLiDhNOFYTAdsuhfILewGb5KIbwlLS9yyon0dS0QrhDib2ZMH8Mpk5+uQEtAG5v6IGLxFNLEld6oQJ07C8WRHYqN/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691601; c=relaxed/simple;
	bh=zFtNcngtFWoMnpccDfuSCQkGbVwc6Ii4mKhnjDMpm5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5D5GgxzU8Gfj+upk08HljKEXcR5qEv2mjABw028oOYDDFwwB61PYkcO8gOqUJ7XQFr2vg5f9qykv7lkX2OmzWYpQf4iI5xeA58u5ftiz+vDzuhXPHk1yR8e+W7zyg0S0oOTfBo8yTPRnuAFiqUuM7xcPoB5eRtlEcaYHKOUlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y/EZvdlJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="y/EZvdlJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EFFF61A162A;
	Fri, 14 Aug 2026 07:13:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BDA866046D;
	Fri, 14 Aug 2026 07:13:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CBEF11C4E891;
	Fri, 14 Aug 2026 09:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786691585; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kRgIOpocXmWDCj9+e0CmpJoX72P3XcDuoAlPjTPqyK4=;
	b=y/EZvdlJUc0MpNB4aB73uMu6uXZx0cx6WV3f5WG9knOzgolkkU4/xi29bqDXhkSI6evopp
	T3FhkQiNASrrfdYnSasAYAEZLMNs42mettBgMqhkzkHSGhhxpRoQDD9X9CAcVNGsp9emqX
	+yvkaR51r4f/Jb4AVDGzoxJKM6LxAgFbwTLVfwitrLFY2rPYZr83nf5OFZEYIMVAAMmhCW
	mDfxctDrr3vhcKPP+KtZDQvQfyE7hCmSW2zeBhw5QYyAgVwnk6rJ4HQHRHMb4djhvFOg1L
	6xBbDG8hMtgdyshBEoz+r5T2lsD7M+6/i+10ZI9ZEq/j5GvKSCHRwQ2yqF7x6A==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 14 Aug 2026 09:11:27 +0200
Subject: [PATCH bpf v5 1/2] bpf/selftests: fix comment style in
 network_helpers.c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260814-tc_tunnel_flaky-v5-1-5b93d030c42c@bootlin.com>
References: <20260814-tc_tunnel_flaky-v5-0-5b93d030c42c@bootlin.com>
In-Reply-To: <20260814-tc_tunnel_flaky-v5-0-5b93d030c42c@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

BPF subsystem requires multi-line comments to have the opening /* start
on its own line.

Update multi-line comments in network_helpers.c to follow this
requirement.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index db935a9d9fc1..cdf2d7d3ab32 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -424,7 +424,8 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 			*len = sizeof(*sin6);
 		return 0;
 	} else if (family == AF_UNIX) {
-		/* Note that we always use abstract unix sockets to avoid having
+		/*
+		 * Note that we always use abstract unix sockets to avoid having
 		 * to clean up leftover files.
 		 */
 		struct sockaddr_un *sun = (void *)addr;
@@ -865,7 +866,8 @@ static bool is_ethernet(const u_char *packet)
 	memcpy(&arphdr_type, packet + 8, 2);
 	arphdr_type = ntohs(arphdr_type);
 
-	/* Except the following cases, the protocol type contains the
+	/*
+	 * Except the following cases, the protocol type contains the
 	 * Ethernet protocol type for the packet.
 	 *
 	 * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
@@ -1033,19 +1035,22 @@ static void *traffic_monitor_thread(void *arg)
 		if (!packet)
 			continue;
 
-		/* According to the man page of pcap_dump(), first argument
+		/*
+		 * According to the man page of pcap_dump(), first argument
 		 * is the pcap_dumper_t pointer even it's argument type is
 		 * u_char *.
 		 */
 		pcap_dump((u_char *)dumper, &header, packet);
 
-		/* Not sure what other types of packets look like. Here, we
+		/*
+		 * Not sure what other types of packets look like. Here, we
 		 * parse only Ethernet and compatible packets.
 		 */
 		if (!is_ethernet(packet))
 			continue;
 
-		/* Skip SLL2 header
+		/*
+		 * Skip SLL2 header
 		 * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
 		 *
 		 * Although the document doesn't mention that, the payload
@@ -1079,7 +1084,8 @@ static void *traffic_monitor_thread(void *arg)
 	return NULL;
 }
 
-/* Prepare the pcap handle to capture packets.
+/*
+ * Prepare the pcap handle to capture packets.
  *
  * This pcap is non-blocking and immediate mode is enabled to receive
  * captured packets as soon as possible.  The snaplen is set to 1024 bytes
@@ -1150,7 +1156,8 @@ static void encode_test_name(char *buf, size_t len, const char *test_name, const
 
 #define PCAP_DIR "/tmp/tmon_pcap"
 
-/* Start to monitor the network traffic in the given network namespace.
+/*
+ * Start to monitor the network traffic in the given network namespace.
  *
  * netns: the name of the network namespace to monitor. If NULL, the
  *        current network namespace is monitored.
@@ -1255,7 +1262,8 @@ static void traffic_monitor_release(struct tmonitor_ctx *ctx)
 	free(ctx);
 }
 
-/* Stop the network traffic monitor.
+/*
+ * Stop the network traffic monitor.
  *
  * ctx: the context returned by traffic_monitor_start()
  */

-- 
2.55.0

