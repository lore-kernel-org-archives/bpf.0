Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A843C06B
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520314; cv=none; b=bBOeFdLyvlYNGwo34c4C1Tm+nSc0MpZmoMlGAcpJ1k0CjF5zRI1BhE8mc1U+YHZR+aLy+LW7w+vwYZJjgQCObOk2J0eNw75jUvbol5JqCEB4jjudWAP9Zrc1272TliMFJlQ9tRpyJhVL/7+Ab3fuFTpPV9aPIB7BDR9Gi4Tj2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520314; c=relaxed/simple;
	bh=Q9W97QAmcHnM41W/CvDhiiLsOea2EQnPuDC13yTFxkc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VnjflXFNJyBCGikUucISNZ556OsDVsCSseBul0w0uJvn4HbL4/XcZOD218TtxjnLY57s8SX7QJdJMvZV/5cGMDZNhNln+24Z/a/a2s/1/SNv6hiHqDmZv2y9dOKbpPdy9OA2oZRSpEdblzwFr27v6KITeveEyn5zjXo7+Uxz9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kb25Ybrv; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kb25Ybrv"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so2433286b3a.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785520312; x=1786125112; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ghViwiNni4mAFdNIXCmPgEVk4aapNFIVXabsvlrQZCo=;
        b=Kb25Ybrvlca0elRLb26io1Ji8uWWuBOYFaj+A8i775V+PQGFbCttYXuXEWR2BSEnNR
         YgicVgVk0fexCb4H+LpW37tGlqJqrsHrkYjhJlJrl+EDIJExi/pF4qrB9IK9dhe1rhrO
         mmy7SgdHBYPt6O45bcoHWw23YMTR3AN2+SNZG2StHSdrE/obyquRHz2a6W3TptyWwQm5
         YvXhFr2XFYsPoZQlZtRZqYv+Kg61toSXJHAFNFrCoUR9cFB2HrPItF4LhlUZUzwR6fkG
         JURmCAIrJ/M+zASbCxwCQ2Pidy2w44WfwsSGBKfaxOZFUZ305h2m8QIuYD4mS9to5BvS
         fOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520312; x=1786125112;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghViwiNni4mAFdNIXCmPgEVk4aapNFIVXabsvlrQZCo=;
        b=lNvId+DxnET3r5IN4rPwZvlyQZfTlKzm/pmu66mLC63OBTOlI4+Wti6enz5YGh/PTu
         SP1ZztPqtPKPXqbAJ89/hxggKyRTuiQvKOxpTYwJI/8BzfoLgSoBOyvshjRuCPlHB91I
         kDea7I8TJ7ep5l+cFyXRWhLA/YVx3uCKeDAF1Iirm7uf49miEhHN0PZjxGobbIjwzoSv
         OnhJJq5C44Z0bUyVoJk82biMDfatrwVShTmuHmnT6IDnNr3l5ixN1af2V8HY4GAibvnI
         yAbivS7ylfZKMvNPyRYEWGeZba9lEQqbmbl31ZMgi/NN4NiZKpD29CJ/w1BHd9yIiAz+
         VZjw==
X-Gm-Message-State: AOJu0YzI2AVL43fwy4CbduXniRVSgonD5B8jUpsngmCDIoH8RTbXI9lR
	Zkc3fxbeo8luRkvKZQRNC9vfAEqJN5Vd+NJrKS4yczS6Vum4v1vDvvVzr9YhQd0TOJjGdTvu8Vg
	lbfvfvQxJP4JMlDlSBcMI0QWcB3C6oinnWhNme6c0VLskz02pUYwQYAFj7amZiG9JuNlkkzSxla
	3iWjPmWS0HRUHzXKAvlz4sKuawcYv1MJoX7HuPmZrXB+psIQ2uzURF5vddY0U=
X-Received: from pggr14.prod.google.com ([2002:a63:d90e:0:b0:c8f:f76a:4b22])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a92:b0:848:75a1:a0fa with SMTP id d2e1a72fcca58-84ee49bc5a4mr468215b3a.67.1785520311343;
 Fri, 31 Jul 2026 10:51:51 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:51:33 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731175141.284757-1-shivajikant@google.com>
Subject: [PATCH net-next 1/2] bpf: Allow IP_TRANSPARENT and IPV6_TRANSPARENT
 in bpf_{set,get}sockopt()
From: Shivaji Kant <shivajikant@google.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kuniyu@google.com, anubhavsinggh@google.com, 
	Shivaji Kant <shivajikant@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Currently, bpf_setsockopt() and bpf_getsockopt() for SOL_IP and SOL_IPV6
only allow a small subset of socket options (such as IP_TOS,
IPV6_TCLASS, and IPV6_AUTOFLOWLABEL). Calling bpf_setsockopt() with
IP_TRANSPARENT or IPV6_TRANSPARENT fails with -EINVAL.

Transparent proxying (TPROXY) and related networking components often
rely on IP_TRANSPARENT and IPV6_TRANSPARENT to enable binding sockets
to non-local IP addresses.

Allow IP_TRANSPARENT for SOL_IP in sol_ip_sockopt() and
IPV6_TRANSPARENT for SOL_IPV6 in sol_ipv6_sockopt().

Tested-by: Anubhav Singh <anubhavsinggh@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 11bb0d236822..5a5980c671f3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5640,6 +5640,7 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
 
 	switch (optname) {
 	case IP_TOS:
+	case IP_TRANSPARENT:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5666,6 +5667,7 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
 	switch (optname) {
 	case IPV6_TCLASS:
 	case IPV6_AUTOFLOWLABEL:
+	case IPV6_TRANSPARENT:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
-- 
2.55.0.508.g3f0d502094-goog

