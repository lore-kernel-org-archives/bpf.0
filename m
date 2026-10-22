Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663160;
	b=DoOsRyla6w353x4PFtDP8vUk/0PYy2tTu6WthhW6jB6g9/99gX/denmul+yTvVR48n6k
	 bg02TQTUMfC6AekN7REcAA+Q+5YvrmSVXay30Tv14p0wdwSuL7unaFoiJUO9Ea+WJ5VxW
	 OFWl1XHkUPty+Q9KGAbvLqccwo8cpYh/axpQRJXlWLscMz+Yr0vdPrscnbFXrc5rcsbq3
	 AYX4aYET/+/aznbBUJrBfn6edjEtYLHahSfY4u5tvJOmUwLElqnxZJtyI+xHrnzUXP3by
	 m7ugTAJfqTHih/IOapdu5xRo/YIp5PllmVKd1hshvvauVR0AulmQaPPIPIalMo0Jcqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663160;
	h=DMARC-Filter:DKIM-Signature:Subject:Mime-Version:Cc:From:
	 Content-Transfer-Encoding:Date:Message-Id:X-Mailer:To:
	 X-Lms-Return-Path:X-Original-From:Content-Type;
	bh=oqq2H1oItHLFY10BG9vx49q9B4HFJpYgR3Eqv5tnJWs=;
	b=p4TKIeltT4Mx9pTUtMZ81tDg7/KUSBV5hj6OcaLHcPD76Jqe11bHlccykNUPIv31gVJS
	 e2Mu71XAb4x4xMly8YT3EHvk0z1TAS6uwmpoyzZJ3pkeNuuoEL9iBEd4KbUFGbut2vIye
	 PoD8SBD/3ZXOjiXvpJ67kGbaMilvVa6l4wubbU88AjGmMe1PtrpIYu9q87+I1y0XsfBXG
	 AyzZbqTAWSSXreC//BYqMlMDYGvVVBUDuQGlXS8Os7s3JC9IhtExzCSpopwlpnjmSHTDH
	 QMpMLYOCfHgc3fPJVeQDwFUIctBeiKPcHaPBJdaMjzqQX1UakxefgbGHVdWGNwWDkLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=bZC1DzsI;
	arc=none smtp.remote-ip=209.127.231.114
Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0278606A31E
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 09:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0278606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=bZC1DzsI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792663153; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=oqq2H1oItHLFY10BG9vx49q9B4HFJpYgR3Eqv5tnJWs=;
 b=bZC1DzsIIxCXCCUKnCEUsloFBq5SC7cHlB7E3ZlGeJThw96ltK8xYocAR/9uhCZzLaVnKB
 dmOaMKmYLOKCwrnRTvSqXlqGgLiPz6hVqYAGQ3nj2vQabF436eGpGQm+il/jABdxQ9QwWm
 Dny6wqNkI62E4uAyxCnQsSyQ+9rVF5CiVEPMBG/v6+Uac2w2nXm2zYZeiAYFCpD52at2JX
 Q1b7xpU8OzmPFkFcAELcRKRrYqi3Mji3FbCKArNlFDh93GKAI784ya75bgiw+KL7UooEwo
 XEAcI6smCDxrF8OtufExtmKESVZGjegWp/qw6K0zd25WBYp2NVQ6Z2P1LqfTOw==
Subject: [PATCH] bpf, sockmap: Propagate sk_msg_memcopy_from_iter error code
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Cc: "Rui Qi" <qirui.001@bytedance.com>, 
	"John Fastabend" <john.fastabend@gmail.com>, 
	"Jakub Sitnicki" <jakub@cloudflare.com>, 
	"Jiayuan Chen" <jiayuan.chen@linux.dev>, 
	"Eric Dumazet" <edumazet@kernel.org>, 
	"Neal Cardwell" <ncardwell@google.com>, 
	"Kuniyuki Iwashima" <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, 
	"Simon Horman" <horms@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Levi Zim" <rsworktech@outlook.com>, 
	"open list:BPF [L7 FRAMEWORK] (sockmap)" <bpf@vger.kernel.org>, 
	"open list" <linux-kernel@vger.kernel.org>
From: "Rui Qi" <qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Oct 2026 17:58:53 +0800
Message-Id: <20261022095853.1829161-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
To: <netdev@vger.kernel.org>
X-Lms-Return-Path: <lba+26ad9de6f+57aa16+vger.kernel.org+qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8

tcp_bpf_sendmsg() stores the return value of sk_msg_memcopy_from_iter()
in a local variable "ret" and jumps to out_err on failure, but never
copies that value into "err".  The "err" variable therefore keeps
whatever it held before the copy: 0 on the normal allocation path, or
the stale -ENOSPC left behind by a partial sk_msg_alloc().

On the first loop iteration "copied" is still 0, so the function
returns "copied > 0 ? copied : err" -- 0 on the normal path and the
stale -ENOSPC on the partial-allocation path -- instead of the real
error such as -EFAULT.  A blocking sendmsg() handed data but returning
0 with no errno can drive userspace into a busy retry loop or be taken
for a successful short write, and the wrong errno misleads recovery on
the other path.

Propagate the memcopy failure so the real errno reaches userspace,
consistent with every other out_err path in the function.

Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 net/ipv4/tcp_bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 97541acb3cce..8cf63a9e7fed 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -578,6 +578,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 					       copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
+			err = ret;
 			goto out_err;
 		}
 
-- 
2.20.1
