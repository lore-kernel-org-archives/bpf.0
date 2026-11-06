Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937250;
	b=I3hdXmsbIOyBIHpAXoofAamJpL8FMzjbKL0KvBS5MZPInjNZUwwPQ14DMGKyD4wKurgH
	 A+b7FdRXG3cSvUY+NgGeQ6jc/Iu51O3V1y/vwilKDmOXpn+XIhKPsLf9rbZtleOgtqM3o
	 taMmJJjRzdvlvc26bw+lE6sTPoCV0AjR+qebnfwPjr4TJVQC+a3bGXUlhlG0mmyeXnlD3
	 /mfPlkeBucZVD4vQHe9RA7+osh1ilJiKbtwu5s0b8t8jHO7uVxCHuctvmnSiDwEV7q0eR
	 9nMrTm7IlcN9sOz/83vyF9kTrqX8A2WzkE3PsZmfF+gTcWoQwQ/DnHfSXcYsa8Y/VCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oL2TAr0ctsnRu2vU/884YYomTRPaWNC1Ipz0E5QvtwU=;
	b=YTH9dxMnY2tq6UFclCuN5B1w3LJ8LygP2H34gdqHSO+9SEw1mhHsmpfoLvCg2sN/SDtc
	 aTWUU1DgEqVDG5l+8vYHYruj8fSYFZaSXuB/43cORrGYSQQ/H2t9qviwfYMSJX4WfQ52J
	 aKISmasHXeCp9Je9YaQpEvoPE9/A1U5FX1oEoLlDJsHCuBkYQZW3iFhe+i5SvTmolyuZV
	 t04+M9UqiHZvgxE+tBs4zL/lreqqVf6bSqFCYSkdQW1fUwY3RCn7+GfVnUaj45m2npC+y
	 Qrrf0gD1XAXQXVi+szjyNQfL/C+R36wa+kmdNLZvkdSiSVOOBSp2l+zauD5BRfarPfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VUx3UjCU;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36936606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36936606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VUx3UjCU
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so142810a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937249; x=1794542049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oL2TAr0ctsnRu2vU/884YYomTRPaWNC1Ipz0E5QvtwU=;
        b=VUx3UjCUPDdfH1J7phyJeow34S0A0qlz6Mmv+ZVyzSMHJp8GKXqfxf/ceov4uHwuCV
         MHRvGEQDzCuqUMkMJIjxOICg6BXR5a91ols7vbjgRnE/lQxQqv+wcgbGnELFB158zEqS
         9LetOcnH9IiKygzJG68opZvP/rrLiZHocDzKC6MIKUAppmjd0baqzgdNoTa2JsQDIm8z
         yeccWYICDUwvBuK5yMBtC7MA272f2FRWOryQPCa8TY4FfEcE4yz13NIVrs0NUWzhT/lx
         CGuXPrQHU0uuVe9a71/K+MteSqSoUH8x4HpaDct/R1iRUAC6U3Ph27yPocROUGisDacy
         7liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937249; x=1794542049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oL2TAr0ctsnRu2vU/884YYomTRPaWNC1Ipz0E5QvtwU=;
        b=j1EOLv4lh/hRvH05iNzKGtOnB1WI+zjn9IzUEyc8cxcoQvgj0ppkaFjrZ/9TEvFIsq
         Cc61UYONo0AQpwth/M7Wbm1N7QQ0MFk8TIt/SEpHFY4TT86VXTSRFmx3Bl6fEWaLbTsg
         CebUa2UMJ5bnzu3tvdYI+OO4SVjWI9+d3aL27TaYjNCJOQOjXSnoG9xSlpVyjtMTLUIY
         xxOn+As6Y+iIw9P1tWjXUf7syW76SuqHW9n1tXtXN9Z9RpEEilQDNbY9F5s0L8DXWOql
         2QRT/S4J7nD1ubLBNSurNKP2vL8Np9ZnttQ/IPSXJ4idvxOJ6IA7+2z2C0DeVMY/g8zM
         mYkA==
X-Gm-Message-State: APuU4Z8ARcjLBgwdpsrjEVaSDiMP97kQH6JlJcXEK5iPybhqdmKbBh7q
	tSnV4yEHbN9qJBbeARMbwZvLgtNmrzBhQ2c6eqMTre8eJAiTbBPT+g+BvGCcbA==
X-Gm-Gg: AYBFou26nTu8x5zdMfrUeHVr3vKqB5boUVYmz+f38ArGkwGgNbiHp/XqAne6OOH7p3R
	NCJcFEueKQ04XQZVxS0iXH0htTVtU6DcC0nw7AG6rPJPq1ZtTeu3KeOgw1GdGRZ0fsJGUEzW55I
	swm+lp6KJKz9esiLh4ZUDIpCd3YWqDzEfkkfHf9OM7R3jC+6rLwQaSCLib0Apw/0MjJq++01os4
	3QFkNiQsM49CLpFTMnyySPtJi63PZ2iYLNCTt35/7RZsyVnIhGzLdj+Ykfy1f7ccsSfTLJTJaAe
	Af1jTuhD3hjbaonzznsivDbcO6/Jg5x9MHvr80Kg9rZmKZeVtXDiitUNW6Qpr/mXxya3nXwMn1r
	9t7Xi/lppknDYJ3+5az+la6+E0dmUoJ3X4hEWwtqI0jQn5bB1LBtOyfnY9OhT4tlZMsim5HbjTJ
	ACOoglvRvp0VDwW2v+Le9AI73kOr4VtWdXS+MdDyh2FqxFqP2YWoHBrlbrpEEAMQm7TwYxVfYoi
	mWdE0p2aGXeNn7B3uDGxIfHf+IZFq7Yy1aUnjIENwq6ZQW4XWgafRVHM51v8dygNvIj7qFja73Y
	7Rce93NxZKLfh+IIXTSZTVT0sqrgaaToyRByN3H+XYb2zdqpzAMuNIWEHo56k7rA3cZ7RNghOa8
	lEkJrZvFeiVRV/ceuYuWjG7fZ8z7wPmSvTu3c+x8IEaSP3vidx1S20XYx5Yf6pSXoyvnDqanHhE
	c=
X-Received: by 2002:a17:90b:2891:b0:3ac:1c76:61c3 with SMTP id 98e67ed59e1d1-3b0db6f13e2mr1115191a91.27.1793937249578;
        Thu, 05 Nov 2026 19:54:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32b6507sm6606985a91.16.2026.11.05.19.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 30/45] bpf: Don't widen away a register that only the loop sets
Date: Fri,  6 Nov 2026 03:50:54 +0000
Message-ID: <20261106035111.3315285-31-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

  bpf_for(i, 0, 64) {
          if (v[i] != want)
                  continue;
          last = bpf_get_prandom_u32();
          found = true;
  }
  if (found)
          bpf_printk("%llu", last);

clang 18 does not set 'last' in front of the loop. The state that enters
the loop has found = 0 and no 'last'. The state that comes around has
found = 1 and 'last'. At the loop head the two are widened into one state:
found is 0 or 1, 'last' is not set. The prog loaded before states were
joined, and is rejected now:

  R7 !read_ok

Where paths meet outside of a loop flow_unset_differs() keeps such states
apart: nothing is gained from a join that loses a live register. Ask it at
a loop head too. Like there, the rule holds while there is room for states
at the insn.

The progs of rust-bpf take 0.1% to 1.5% more insns, the progs of selftests,
Cilium and sched-ext less than 0.1%.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index d5dbe417421a..6854e795e537 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2328,9 +2328,9 @@ static int flow_merge(struct bpf_verifier_env *env, struct flow_set *set,
 		}
 		if (!widen && flow_cmp_pkt_range(s, t))
 			continue;
-		if (!widen && flow_has_room(env, *nr_states) &&
+		if (flow_has_room(env, *nr_states) &&
 		    (flow_unset_differs(&t->st, &s->st) ||
-		     flow_join_makes_up(flow, &t->st, &s->st)))
+		     (!widen && flow_join_makes_up(flow, &t->st, &s->st))))
 			continue;
 		/*
 		 * Around a loop too:
@@ -2516,8 +2516,8 @@ static int flow_end_walk(struct bpf_verifier_env *env, struct flow_set *set, str
 
 	list_for_each_entry_reverse(t, &set->list, node) {
 		/*
-		 * The rules that hold for what comes around a loop, see flow_merge(). And one
-		 * more: the iteration has set a register, see flow_unset_differs(). The join
+		 * The rules that hold for what comes around a loop, see flow_merge(). One of
+		 * them: the iteration has set a register, see flow_unset_differs(). The join
 		 * would be without it.
 		 */
 		if (flow_trips_behind(&t->st, &s->st) ||
-- 
2.55.0

