Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86A27E05E
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207306; cv=none; b=RvvY1njIjL9dWVHLocjJHGS+UKuqWqtXP8KyxrubfLvQMbqn0caZmhEXMKIKe+I9tXBMRDpjuc/u29FsSRADd89C22SyqFlLyR7lTGIlZ7y5nx5+vYN9SK4smE29hhPfA2Oe/A9DvIE0kUqfvjKRL+Z/HFaJI5kUSJAHAPYmGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207306; c=relaxed/simple;
	bh=mRrVZ6uZ30MBcrGg/JUf1vadHPFlXqtkRqYN4sTjhTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZcphdNt04m3U6jdNNWZRfzXUXJZK2GPjr6gPw1ON3c1omwb0OkPTgla5rMcnPedJabQyXeGiFxfZ93l8LcrISzSp/ln6l9EZ61Um60XAQuK1Ws4nFvgciAT3zRhFaQFprPT2WfUiQmGLeDrIgi7SR0GfMs8DddB9qcVwLpTdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qztNr3Sf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qztNr3Sf"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d65f4073bfso216463685a.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 19:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207301; x=1778812101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stnI15SnX1ppHc39pta6JW4ijwXwltLNVPNKZ2aNoUA=;
        b=qztNr3SfnYWRbTjZ2DecgPJ4O4gE2c+TCNQxDbZere0lyk4Q6xcZYbLJmlH7FidATC
         ZGm4bTlu+MBKpjs9oXOOcZd35s0o4X3zjCh85Y9ernKP5Ce5oHBOHa6dydR7jNsvLGhO
         vqRJx5p6FPWeRuXJ5Q0vbiLlt6V+JJo9TReAGn+S+CER1c9tL5j8OG0eHI8b6C7fXwnF
         FItYT3lC/EPElXo78nQCUC66Vhfbi506SjT0dSsGQCnSXQYoe63LbSiX+PZbxQKKmCYQ
         U9g11fx4QNiW3VG6ysm1RSyggB2Aw7jG+rfzLae1MRxIU9I8ZwY3B1jcCKKywS32jQPX
         5uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207301; x=1778812101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=stnI15SnX1ppHc39pta6JW4ijwXwltLNVPNKZ2aNoUA=;
        b=h7H5G1RGvNJXYLeE0Q0jWl1UEjuYarzUModPpb3Ny2ZNTse3ol3RWY/LRADP/LKWsK
         NlO3gF60LnR9ljO4BJ+D8RWZv/uY/dIDV4ZfGiC0/jdSoceFVpW0wY46MNVwJC6hR3+C
         LbkwevR1gYdPV5XNZzG95b1xIovyWMWl1MEH6sRZJSvk1FzFgfoBalbZjIZtlTVp2H85
         q0MRInb2y3xCGbAgvUVTc4hbreueezyvAuSS1QDqLI0Azi3tmhg08B4V1Lg5Xmh2+9Fo
         exN1MzhtAtKLO2oDNgs0ra/H21I5guyH9tLMYuyXlyiybtyE/9n1Gu5H1kSjbAYFvpLq
         BukA==
X-Forwarded-Encrypted: i=1; AFNElJ+cGBoKLKWVb3yXdeoSBXWIbNsJ2cTj4ip8DT1cN215FIn3pJo+B4+IP/wceZM6ZZmGAH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBytVTN8n78U9jD1UBDnJz8mjGUxubZTuDo1uWn5YVPKi8Xoaj
	WhmhwroAKwBNhI+o8yrfEHBUrlxpNUldKBAY59uASW6/al+4WaSnWdb3
X-Gm-Gg: AeBDiev8vRq9UMcZJyV+vnyWb3BUOHHG1W9LusJvRek359lj0RHTD3Oz/MxBkXxcyvl
	szU/IMQPZa2G17nuznnnym5qyh9nHwz3UBLzHTVWs03tLqlfeoFVZWNigZZU0LN4iRkYxeM+HYl
	eBi9JZyKPxHt3gQeSJqJFhbGQ92uKWummzCCr/NVnhba3CWhQZavL6LLZF8wX62nLMOBiDQ94Ze
	2xZWqKLr4jF7A8EDe5fDA5cMi+Xw4f/nm7O9sir/nXbFB0PVXQxsfr7/frCk+YBr3lmDKfYlN8e
	zyScTVGADPAXGbcDJi3/0or9l9bxbadhnOGo5VEJrWlgE1HvGgdmNlYkK4t0BeNPXouaaKMIJP/
	a2usBpBCxVPvxxeqD+b6Zzs/+kzlCUwfbiE83QgNkt8+jg1AoyWReGg4UQVOwAzFT6pdD8WTI+D
	BNj9biLlLSVkUeOBXdaSr10g==
X-Received: by 2002:a05:620a:29ca:b0:8e8:ffd2:efa5 with SMTP id af79cd13be357-904d4391f52mr1517946385a.11.1778207300712;
        Thu, 07 May 2026 19:28:20 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:3f::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b966f5f1sm63166985a.8.2026.05.07.19.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:20 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 07 May 2026 19:27:49 -0700
Subject: [PATCH net-next v3 4/8] selftests: drv-net: ncdevmem: add -n flag
 to skip NIC configuration
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tcp-dm-netkit-v3-4-52821445867c@meta.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
In-Reply-To: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a -n (skip_config) flag that causes ncdevmem to skip NIC
configuration when operating as an RX server. When -n is passed,
ncdevmem skips configuring header split, RSS, and flow steering, as well
as their teardown on exit.

This allows ksft tests to pre-configure the NIC in the host namespace
before launching ncdevmem in the guest namespace. This is needed for
netkit devmem tests where the test harness namespace has direct access
to the NIC and the ncdevmem namespace does not.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 58 +++++++++++++----------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index e098d6534c3c..d96e8a3b5a65 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -93,6 +93,7 @@ static char *port;
 static size_t do_validation;
 static int start_queue = -1;
 static int num_queues = -1;
+static int skip_config;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -828,7 +829,7 @@ static struct netdev_queue_id *create_queues(void)
 
 static int do_server(struct memory_buffer *mem)
 {
-	struct ethtool_rings_get_rsp *ring_config;
+	struct ethtool_rings_get_rsp *ring_config = NULL;
 	char ctrl_data[sizeof(int) * 20000];
 	size_t non_page_aligned_frags = 0;
 	struct sockaddr_in6 client_addr;
@@ -851,27 +852,29 @@ static int do_server(struct memory_buffer *mem)
 		return -1;
 	}
 
-	ring_config = get_ring_config();
-	if (!ring_config) {
-		pr_err("Failed to get current ring configuration");
-		return -1;
-	}
+	if (!skip_config) {
+		ring_config = get_ring_config();
+		if (!ring_config) {
+			pr_err("Failed to get current ring configuration");
+			return -1;
+		}
 
-	if (configure_headersplit(ring_config, 1)) {
-		pr_err("Failed to enable TCP header split");
-		goto err_free_ring_config;
-	}
+		if (configure_headersplit(ring_config, 1)) {
+			pr_err("Failed to enable TCP header split");
+			goto err_free_ring_config;
+		}
 
-	/* Configure RSS to divert all traffic from our devmem queues */
-	if (configure_rss()) {
-		pr_err("Failed to configure rss");
-		goto err_reset_headersplit;
-	}
+		/* Configure RSS to divert all traffic from our devmem queues */
+		if (configure_rss()) {
+			pr_err("Failed to configure rss");
+			goto err_reset_headersplit;
+		}
 
-	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering(&server_sin)) {
-		pr_err("Failed to configure flow steering");
-		goto err_reset_rss;
+		/* Flow steer our devmem flows to start_queue */
+		if (configure_flow_steering(&server_sin)) {
+			pr_err("Failed to configure flow steering");
+			goto err_reset_rss;
+		}
 	}
 
 	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
@@ -1052,13 +1055,17 @@ static int do_server(struct memory_buffer *mem)
 err_unbind:
 	ynl_sock_destroy(ys);
 err_reset_flow_steering:
-	reset_flow_steering();
+	if (!skip_config)
+		reset_flow_steering();
 err_reset_rss:
-	reset_rss();
+	if (!skip_config)
+		reset_rss();
 err_reset_headersplit:
-	restore_ring_config(ring_config);
+	if (!skip_config)
+		restore_ring_config(ring_config);
 err_free_ring_config:
-	ethtool_rings_get_rsp_free(ring_config);
+	if (!skip_config)
+		ethtool_rings_get_rsp_free(ring_config);
 	return err;
 }
 
@@ -1404,7 +1411,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:n")) != -1) {
 		switch (opt) {
 		case 'L':
 			fail_on_linear = true;
@@ -1436,6 +1443,9 @@ int main(int argc, char *argv[])
 		case 'z':
 			max_chunk = atoi(optarg);
 			break;
+		case 'n':
+			skip_config = 1;
+			break;
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.53.0-Meta

