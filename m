Received: from outbound.pv.icloud.com (pv-2005e-snip4-11.eps.apple.com [57.103.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03A22A1D4
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781899093; cv=none; b=nz0bV7t06gefzTnYmdhvuOqqokBleBW3VNW+EZYxWT3OpBSkNe+ZIXZuHxyTdeg6kYL42uEG/bK+PPUtbEOrCfpSenZTijejObAboBvR3IXAY3vJcaAtZj4WORgIGcel2aK7RivTbewbI8tqqPXc1UrvD7Tp3QbQ97fL4QbnTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781899093; c=relaxed/simple;
	bh=iXOV0asxCccyrJebaDoN3IQP5ubOpi/8P+XBmE4OYxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psZK0Ja1jtIXy4RBAlUMc8XyG03k2/GZEEi0LnhAHMRRJpnI1LUqTg8UBpObTHVCdyPLyVLV13lm+I9UpvHS4fs4mo4FzwC38vmyFBD+COICSijac1NR5cb5Qre44jJX5htRRm74muB5OAkr6LAPuW1ILFirzPzrFJ/RsnT2cFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pzsmMuwm; arc=none smtp.client-ip=57.103.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pzsmMuwm"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id 673EA1800204;
	Fri, 19 Jun 2026 19:58:10 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYEWBcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUCXRcDVxxWRVwYQwldBVccHR1BRVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUF4IXh9MHB0OWAYSHVAcDlEFWwBGCU4CVAZSB0cMQR1ZBlkHRBRJHh5eD1YYWApHBVQCUBl5EVABWB5WXloXXlMXH0sAXEVaDlsERxQ=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781899092; x=1784491092; bh=sygBzNXjACQ2HHrw6dFTVMIDduwGR6Qd+HQII4kdHrE=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=pzsmMuwm5z02wfqWeG6D1llpmBZubmssWuoM7SckvCW4my7OkP5NOk2Wddk+5+O/RV5sWgElVAb7r878wPbRR+gxZX/dvMJm5hkYH+uEgrQ0HII2qUkv3d2c21HS+ihJI+QxJgE2BsNZ1TJ7pagNLDwrLZA01H7NyncRW5LxDzPpOua4SXj7rK1BpDqZA917fyVA67xSOiFgM9zxu7AFh+5bD3gF+o/Doe3P5F+/R9pkSE7Fzi4994nMWbvRyA/9y+v/wg7aq/Rp/VN921UOHrAGAdmrTL0C2+bzUWYOFxR9EIM9VhYWCmrP6epeVVPHfV8JhONg7mEbRezt7W/hag==
Received: from cibi (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id D140818001B6;
	Fri, 19 Jun 2026 19:58:06 +0000 (UTC)
From: Siddharth_Cibi <siddharthcibi@icloud.com>
To: ast@kernel.org
Cc: Siddharth_Cibi <siddharthcibi@icloud.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: 
Date: Fri, 19 Jun 2026 19:57:56 +0000
Message-ID: <20260619195759.41254-1-siddharthcibi@icloud.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VZbJ9_7P6w0G_odWh_e7W5cgdlYCTZv6
X-Proofpoint-GUID: VZbJ9_7P6w0G_odWh_e7W5cgdlYCTZv6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE5MSBTYWx0ZWRfXzHWYE+hGpTkC
 MZlSqHWhOna5nBjCkCXWXvtedfRBzQgZX5PwUK/QV4cutm/WWyaZvIxGuUjr4jyj2Dk70+j3gRe
 XsStHuP1CKWzmcxsnn36ICa8PhREK1IIrFjn7HGzTwyneeSIhB/6d+2v37AXMdbNvhHvDuKJrBG
 rzt9r0Q9vxE9HtCG4s91K3JpTj7yelPy8kffgNqYcfe+uhqruUoaoLeP33NwtC9PqbSMPx6VDEO
 GevFxGnJpnKUC4eVZ/tIiFKTqgOicSIuSqBn2uO1R1IGKKVF8D9VMl+8tb/L8ht2tE+3nAbMx8r
 F0zXhyvKZqFK+TW5G2n
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=

Subject: [PATCH 0/2] preserve rx_queue_index across XDP redirects

XDP programs executed after redirect through cpumap and devmap
currently lose ingress RX queue information because rx_queue_index
is not preserved across xdp_buff to xdp_frame conversion.

Preserve rx_queue_index in struct xdp_frame and restore it when
rebuilding xdp_rxq_info for redirected execution paths.

Add a selftest validating that ctx->rx_queue_index remains available
through xdp_metadata after redirect.

Testing:

* Built modified kernel objects
* Ran tools/testing/selftests/bpf/test_progs -t xdp_metadata -v
* Verified xdp_metadata passes
* Added explicit rx_queue_index assertion

Siddharth C (1):
  bpf: preserve rx_queue_index across XDP redirects

Siddharth_Cibi (1):
  selftests/bpf: validate rx_queue_index in xdp_metadata

 include/net/xdp.h                                     | 2 ++
 kernel/bpf/cpumap.c                                   | 2 +-
 kernel/bpf/devmap.c                                   | 5 ++++-
 net/core/xdp.c                                        | 1 +
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 ++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 +-
 tools/testing/selftests/bpf/xdp_metadata.h            | 1 +
 7 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.53.0

