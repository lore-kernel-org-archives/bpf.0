Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361D43746E
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622641; cv=none; b=tJJ7ZGhWbNMwzJ0wa51s8MM4cXibKMKb/RkT398MYSo2EhTdvow504vd8/yn2djIyMcW7HwZGDl0+7ANV7dQthpTAZdcbOB4auHllyjkFNWH7UnbiOg95F7lR4n3ypY1lcQg+JJA2RWAFF/0IRD/W6St6YvBUSHEJdxG5S21YX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622641; c=relaxed/simple;
	bh=AzEDPy4n/tg2P9pNqq6HFSvn16Pn7gioI4RLhq1dSCY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PAmIq5EgT+E1DZVcwHW6mRo8rfL/zTsJtHF7pOYx5wnYjxCb7tjiheZOkvbmiJTJyvZB2xLt8aBkas3Flu1eH8bwAFXnq4xxsfTsjtAaQFjUrYPhAnaXeXJ8ALif2he13nf+sW3oNBUJXkKC9af1NboJ0ms/IqPkiOzIHilSToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/AxyOAX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/AxyOAX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ec555a26so900885e9.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622638; x=1784227438; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sBGn3ij6+2HsbaUjO7lwDiZD87M45vBU8uaHQgq/mEw=;
        b=k/AxyOAX7qJMRw0x6qVpp4p7muM/ahM1miwmZcUqwaDoqMu8uUhIH5J5RyNg7ndtml
         y1cn5oiPvNovwNHTvjtSaIzpx9ngA3NattfCNmSpe87vxXGDL23COese01rEcF7YZauh
         I+ALiHQ0JeHFz+SG2qUDfTRgHQpRv1Wo0kYSx+YtTPj/EawGxURUnCNxSH3HN32IfyfQ
         gqwCrTH8Ip47hdnuDPyt6gAHGxVkwgbr90GVcNo07VhXyZtL5POrdyqji4RlwloH3CeA
         c97SfYt6Bh1cvXG1X2VzckG8MTO1O0um1c5egDSl0kxccs3UaWXCFYGfRFkVMsk2oVj5
         Wz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622638; x=1784227438;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sBGn3ij6+2HsbaUjO7lwDiZD87M45vBU8uaHQgq/mEw=;
        b=bWudny8BivJ+W3tWFyu5OdG72C3UnvEfKiKlRJZv7SB8BkL8eSFB0jBAnOvRC7L74/
         8wb7GssMqu4PUmV4j9WHZK86F7i0C6uEDGoxaYiiwmpYwje4Njc0uVNHm26GvDoVxfze
         dg8kArQGm9AaeV68TAG0N4WO0pUOBpoht2s+ynAfKngmm5dI7NC+0G5ZZAYE8xz0R/xb
         QXG/XUX9IijUnVQlkOlY0Eb1JtpRK6t1Ckuq5LX6TiX5G+Mgp79JVcSuBiGl/I2zsLt+
         kHLOYzJ8j435lG1gznpDS/zE1Axc5n9Tz4vnqY6NFN2OpPqvAMupN00nGiNGfef8Ezhi
         g2Wg==
X-Forwarded-Encrypted: i=1; AHgh+RpaXU7uR14I5CHvjRGFtgnqJj9iImw38kEdNSnkSij2GMqxcm+yk58DHj/es9fDXaaduj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImVdV3uTVkoZ37KilF/RDrLegwqeDnYwB2zldeZ/3KCG7gT9V
	WT8k89efpRTQWD2OZP/b6E5lW/H+GJCB59TaF6wlEFUMNfwQW19pQf7w
X-Gm-Gg: AfdE7cmOQin0s56td70U6MVic+5DVZUNsEoe3i5yF7/o/q9lriILiLA78QuorS5QyQG
	XunAXZ8sXSjHoe8mD8YTDAg+XYnhQ/+dDWqcYcm7Tev3iFpfPb9YBqonmUqjjObiuPiTT8ztAo9
	/+F/hb3ucZbqc4CroZZaM6kBvFtfGo0+f4X1SUPxASAO+L+8CBDTRaiywYgcuksMEDrsuDfezT6
	O+wNRDS2UJR6wIPCHfHKlCiMHP+WU4iAsAh0b5fSsU+h4jYJc4DyuJfoJwvul3pX7hS2u2b8XZt
	MwGsstvG+hicX791+omg4qBz2f+RebkLnJsJ8cISZ8AH75d6oSwsm78MdEOEOiIqEU5W/IqUWMD
	jnWJqOJPX6u0ZXwC/dUuiZKRBSwFgdGWh0Il/pbuQ7WKd0/UeB80PjKHYI5nNjmTBQtvzpOXlau
	GwJawWq0RiUYNzh8NGdyR3xCqSfZlolyunnDrWVgSte2qXNmOk/AKHcErl7+CZ0bjETdreO086g
	9QF
X-Received: by 2002:a05:600c:4f90:b0:493:e404:3727 with SMTP id 5b1f17b1804b1-493e68c6da4mr94463245e9.23.1783622638328;
        Thu, 09 Jul 2026 11:43:58 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a2e499sm8261895e9.0.2026.07.09.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:43:57 -0700 (PDT)
Date: Thu, 9 Jul 2026 19:43:56 +0100
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com, nnamdi.onyeyiri@squarepoint-capital.com, 
	john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	edumazet@google.com, ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data() causing
 unexpected EAGAIN in recvfrom()
Message-ID: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We've encounted what appears to be a bug with bpf when invoking recvfrom() on
an ipv4 tcp socket that has been added to a sockmap.  It results in unexpected
EAGAIN errors, that we've diagnosed as the result of spurious wakeups from
tcp_msg_wait_data().

This has been confirmed to still be present on the mainline kernel, and I have
written a reproducer at: https://github.com/Nnamdi/recvfrom_sockmap_eagain/

Attched is a patch that we found resolved this using kpatch locally.  It just
causes spurious wakups to go round the loop again.  I'd like to get a sense of
whether this is expected behaviour, or really is a bug, in which case, is this
the correct fix?

Thanks,
Nnamdi.

----8<----
From 0e0c342363b2e435297ab1feda402cde6ad54525 Mon Sep 17 00:00:00 2001
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
Date: Thu, 9 Jul 2026 13:06:33 +0100
Subject: [PATCH] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
when they have a receive timeout configured.  however, adding a blocking
ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
sporadically.

this happens when tcp_msg_wait_data() wakes spuriously (returning 0) in which
case, if no receive timeout is configured, we loop again instead of returning
-EAGAIN.

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 net/ipv4/tcp_bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f3..38fd391ff 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -317,6 +317,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
+		if (!data && timeo == MAX_SCHEDULE_TIMEOUT)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 out:
@@ -390,6 +392,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			sk_psock_put(sk, psock);
 			return tcp_recvmsg(sk, msg, len, flags);
 		}
+		if (!data && timeo == MAX_SCHEDULE_TIMEOUT)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 	ret = copied;
-- 
2.52.0

