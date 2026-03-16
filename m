Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA5374730
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700169; cv=none; b=fYQjrwzjcu7vjMl9Dqkv9UXkCS+vhPiADRbd2Y/GuBJbT1rZVQt3WVuhJXV/bu5zhlABg6dZJhBRPoBsUXQAguPPQ+P8hVG/5kbOcPHSJbR/NMst94Z5ZO342CsMgLy7JHD8VuXulEw2RntOxx54BeWF4nGy79ulmhbfcJKbTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700169; c=relaxed/simple;
	bh=/P0d+nw6nfgOf/J+mWp3OvTpE+gexpCsKViZnKl4q1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+BOIGRy8unoGPUoE/Xir6Z7vbsni2e/lwvb2xQ7AGTyMPGZoJesJF1X/XimtYwNkF9GUiDplWqQirT2v08+gSfEt/emgBOCpX4ZWfJNxpK+LnnGq8q1wU5h+i3LKW0OexDouF063gppxq2DNUje3/Auf3bc/A/8gzXNqCYffQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAqOjnGG; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAqOjnGG"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ca2b32f46so3924859d50.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700163; x=1774304963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S96bHHsurulXmzp5TnD3Oxl/rMQZJqmo/NVotofYdL8=;
        b=QAqOjnGG0Jv2OURrXwx7PmcDsowNCIK0MRaxWCN6KFwiag+AaCAw1Cf5WGo8N33byL
         4s4eHKURikLcxJ9LFDzULH3YOfKLg3LGBAoiKTwrB3rBlBbl5GXU6xmOIjmZOHXozb/R
         JLWWf5uT+FoUNeLVgMYFl9VgllYkQKjIDJbACYNL+ct2der+FYRYI4+6ywMcusyEYyJT
         bb6t6TO41s/afoJveIB2x6db6mIqIDT6ouH0whvqw0h9gFGR5InF79IFV2veFr0RsHYY
         CKXaI1r7LX2d5VxV6xVSyncJgVZAVrBS1slXdF/vYWXInwUGoqD2GVHxzldNBAALQXUx
         IIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700163; x=1774304963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S96bHHsurulXmzp5TnD3Oxl/rMQZJqmo/NVotofYdL8=;
        b=lBl6R/Pu3KKp0Y5+tGJnENeYuHkGuQULIj7mFyOcgbLkvGdYbWWV1l/MStihBVIdDI
         S2pJtYM+U6ysyfWiLxLoi2f/fuhJzkA+YlMgl0ubCDbKQuDWrNK8eg9r/+BkCltLkJq2
         G5lpHYqlHmpqypqaeT++yvFn64+P/FH2sPcAMm5uMXs/g0sYl4ueVCtVOIB8eHHlbXc2
         H66LZrS3a9S2O+zrPNpQTghBSU7p7+1tZTe5lK2g47RqOo1VigtyjUa7pkOVy2dPGrOq
         dBXReENjXwsHMKNC2OyvB315HBJm4Bs1fXWqRdAbksnPi1zahTs1FwBKjcud0/6Jr0qU
         Cxjg==
X-Forwarded-Encrypted: i=1; AJvYcCXGL4j7PW39iSt3/hJsoK2H9dA6wa2NIeZiaE1RtiDS7qkctB+AYpGlJvjoirK78kUf1bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkei2R59SHTzZJOR6Sk95666qGB1aQW4NDkwz5VDxTBatisqR
	O6LGKkF6XOOmYPtijR9SIyf0Tx2O2Gsoei6sAUTatr8bDNFhxaQoXbVe
X-Gm-Gg: ATEYQzxa22EiOqS6dJStSk2DoVzKgIY48WAyPJ7nnpuWilSSJVXjlBysAh64z3ktFvU
	K3w/e+ICR/XlWV8Ol23Qw/t/AZLv4N7i2f1Fujjg6D6RT4h2XlHZv0aNzcP9e0s3H3KrjFzOwDG
	9kam1vto8p97wlwAVJ7bLbauSR4vGP8l8CThvDb7M2V7dcii3xj1JgCYBVc4/sxnpbu0OvCJ+ID
	VWgEbw+1fMqj7VbfJQrCKEMr5IkTIHn2zX87iRu0HCm8X6/1tdYf5iW5ELKuqccfh299NyY1ver
	R3iltH94EQDm+qz72VPbjGY7j9scEfFxOkJvkLdxTpcntzKfuMkYYJDZ7nAs9zzZI9yRsFRnWTj
	MTa57LlPFCOrt5WdMgK/NMukTEB/BWlkHQeDDh8N87cadxLdah5cPoeLQmB8chBEEFJjaoGHnTQ
	R5Zoq/csJYN//97bumb8Rmrg==
X-Received: by 2002:a53:7404:0:b0:64c:97ae:2e75 with SMTP id 956f58d0204a3-64e6309ab39mr10701854d50.69.1773700163558;
        Mon, 16 Mar 2026 15:29:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65a3bedcsm6286875d50.1.2026.03.16.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:14 -0700
Subject: [PATCH net-next 3/6] selftests: drv-net: add skip-config flag to
 ncdevmem
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-3-b53c8cd72b23@meta.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a -n flag to ncdevmem that skips hardware configuration (header
split, RSS, flow steering). This is needed when ncdevmem is run inside a
netkit namespace where hardware configuration is managed externally by
the test harness.

When -n is set, ncdevmem skips configure_headersplit(), configure_rss(),
and configure_flow_steering(). The calling environment is expected to
perform this setup prior to invoking ncdevmem.

This is used in subsequent patches of this series that bring up netkit
devmem TX testing. ncdevmem will only have access to the netkit inside
the namespace, and not the physical device. Therefore, in those tests,
the test harness itself does the physical device setup.

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
2.52.0

