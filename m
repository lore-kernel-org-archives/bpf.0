Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20493A2576
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416146; cv=none; b=nMHAU3NBawIQcT4y/hiu0Z41zgHR8LJQdaRDnyYtx3bTD8mZZaI64waRrtkLRBPt9fo21R5L9YRXZJAhRT3MlaFLWjXdkPwS8xaJdMyk8MvMAVn6S7XTnWACMHgy+qYCmAkJAKlyeBPRH4kL2GYxGw81yAGB1xg41qCrSx+W3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416146; c=relaxed/simple;
	bh=B7FviiHCkzsgZR03A0gxXSp8daeStyvefpiOcjImf0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQCTik+JsjJjsAV7cDmUnFIqX6X9G1BEKa/68dVVatveZITRJPDLtRNFcSBI56N0MPBCwiv36e7Eg/Yhc2QJrimDsxp9f9apOgLFi1SSsUTUsLY6WFN37unaf+dJWzAwxr72C1u0ukhVBe3hxzseRA1zz9/R1DvgW3RCX1YeSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc16mDBI; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc16mDBI"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d1872504cbso292793a34.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 15:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416143; x=1778020943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/ULgqetM6dptOIHTaR1lnyYobopylpPKgrCCVux36Y=;
        b=Tc16mDBIeZiT4j6j2P9GI0aBPlDJl/3NZWnPXrjaLd+bCCVjRl83xgqY8bLHhxPdaT
         H2M5xAHpjQuH450kzVTF7p/zqanGB2yyQcYTrdpIZXThE3Lx90Ps1EULQCP2Yz56t1dX
         rF5M5UFs/7jhQvK2pLjuvPO+gAz4lU6uinWw9nBTJ0Pm2IPXh7MQKEVaTyFQq+wXem/G
         TILed5xkdSWuJndJhD1KnIJj09o6DDezeRaNiuhUYZ3iNnPLqPzMcDlPWCBgqmLxi4XB
         M7Ybi+TmUOTeDGR4zw+hJKqA1XFu13vfugNMobs1wzjaXBKUtf+xePIIo4cgXgmDzKke
         wjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416143; x=1778020943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S/ULgqetM6dptOIHTaR1lnyYobopylpPKgrCCVux36Y=;
        b=UhMMz4HMgCHijZIsObQCeV5Il5CnV8cktL1O+HohRhIiMHpCEXS9QrtMf/a/0Mz1JX
         8EkHi3uInyyDB+BwxCLggRQkNXZJgnjnKnhkwt4t5kwMJSGeSLwxmxJ3dlnRWHQCqmg1
         xuDZrtTPwCwi+8IssoDhelVoN8G/EX5aGUEXzxabJxHfdTMe1MfB1rW4GRX+7MJiW3Ly
         pq5ADtgiNpd3U8EOgNumcT84DXlR7zxu+ZW0PKVCdpY+YC+rFsAWgTJrYyb7DloZne7P
         UaA4eeBoVuySI82xTXpcEZx++pIChtZwSKTfcZj/HSO1S8SiQxHNYt7y8HZZT2Nstn6p
         mmKg==
X-Forwarded-Encrypted: i=1; AFNElJ8iYL/W5YJ2kyfBv4ZRok/wF3TpFoprGA+nv7BxJq0wVzseGwUTqnDLY3xv1gBkeYQ90Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qajnyAxPMqSrB+wgwH+UaeA6FrTwpitoQs9S/C8CI9pvFCDe
	X1ZyDS+aUfRWct+jcw/+q537Aes57Ff+Cj4QgY0p+E8T9ghEZD91JyOQ
X-Gm-Gg: AeBDievL0Ewzf1YNXSmPiVz2CIbQdvLbpk835I6GTMUFsPacn0jJMqAD/a0/y7SYmiM
	F0N1ZpjezGE6XK2urxqk0d9lnKgM56z/HAdFuM0ClQ/1qI96M43+fUtlAPzpah9ft7PSsF7srCe
	K9Y0SHMkcIjE912Y1YtNBiRXf5d8mS5Zj/EAYwlr7wIjnjxtH3tAjjKvej7/h3IeaD7h63QMO2j
	l0prj5odfnOQPvvvOLuaIWBd84zs+EbBk1CL9+dbDLOP6oZ5aUJGWVgqy5KpyYRUk2OiWiBNF1D
	z/ydMIaQT8z4aA2uTs5iPe+9/gyvkkFnslfYB1fcSF2KWf0x9mL9IkHnYCUVZWHI4kOe0IcfK/N
	M7H+9u1DcFvnibNrsVBJbpdkDC2uCKaN1kD9sxkRDdbnKmxQd9ptkyK/CtEXFDQOJPqFBA3M/Uk
	aV9ERji1wGp4ulEwYJaT7qBoRVAupcSexYBJ+iUMkZ1rM=
X-Received: by 2002:a05:6830:25d6:b0:7d7:ec47:79f6 with SMTP id 46e09a7af769-7dea97ae5e3mr454544a34.13.1777416142670;
        Tue, 28 Apr 2026 15:42:22 -0700 (PDT)
Received: from localhost ([2a03:2880:f812:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deab839620sm143319a34.12.2026.04.28.15.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:05 -0700
Subject: [PATCH net-next 08/11] selftests: drv-net: ncdevmem: add -n flag
 to skip NIC configuration
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-8-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
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
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
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

Assisted-by: Claude Code:claude-sonnet-4-6
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

