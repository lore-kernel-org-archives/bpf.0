Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537986;
	b=eYTnpsLU0jzbtG0KNyB6ueHPKnf4BmUXbUPWzk1uLbQ+nd6z3VUSLh3Rf4PM6aXf8gFF
	 Wg8Qqz6WxiD4/fWlb/njqF7XH8py4cFQgU9PLvmnV95D1LBnhbyLeeyTZD3Y5KXQsMz8Y
	 WnxjIKAkh/85SeQIsv67Zm6O84CVr4Xl4JCgMoGupuOVZIDKdYy+qBRvDeWj0aC5rBDEa
	 7WinwbK6R7+BquXDx9gB8tFxwGWudDM1gWXGXD2J3uAk7X5+lipPIaFD50rncLM6JRig+
	 yPbbqMR5QhJq1EB7bkMrHyXcnTQdrNdj5KttBLqjjKI01rpY9s9xXwc9DfayfE4spiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537986;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=BvnjJ+ijwNCz4Oqh6fIRvQJmHHYb6TrYy/+fUMqfBHY=;
	b=jB/vAabZ3BzGJJwzUKudDEQy4JhVrMMCtd//JAbu/euisB/8J7Itbv86VxN9YL7U+dLB
	 PbXlJYb3DeuRe3MwYkX/M2SfkIiYBjT2eD3gaRFRBE3ppz3cqBI6uchNzrtdWCypAxL/6
	 mJieWGeWpqkBXr5j/fTVJcB4DFOfGVbGFbMobpBTQ7rKsiDdvJUwDP73hKW41Qu1Xtyig
	 pTqDL5Ub4DaSmFGr8vKrSsXFrkebGlx5+hrDG7R+P7b7IuAz+jFH+ZA+t8m3/ZHTmAae/
	 FRcV8XenRL0kaDhASI3+3P8F6qPHgCjg9/tvvyhWOXbdsh/hEGaGELsol9WoaP+0K7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b="Eyo/eOwI";
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5670606A321
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5670606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=Eyo/eOwI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794537897;
	bh=BvnjJ+ijwNCz4Oqh6fIRvQJmHHYb6TrYy/+fUMqfBHY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Eyo/eOwIwO5xf0JJeC8k8dv0M6ihtJYsd4Mb0kuC6LV5ramxL6IGPoiDjNyCGeUvY
	 JHgw5x944mB7x1gFGNiKoOQD8DGtHjkBBsmcddG81Xq4zy/i64hqR2sbdV9l3xPepo
	 akihVzLEFSg9RI42A51avSjPgzqQ0gkHkStzbUQc=
X-QQ-mid: zesmtpip4t1794537896t28d3ce76
X-QQ-Originating-IP: 8bNVuMHbsAAJOnkojDgQ/gdWwQl9+fUJephuDPM7+yg=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:44:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2829769366848978719
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: make css iterator stay drained after NULL
Date: Fri, 13 Nov 2026 10:44:52 +0800
Message-Id: <20261113024453.922726-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110125110.2935707-1-k.chen@smail.nju.edu.cn>
References: <20261110125110.2935707-1-k.chen@smail.nju.edu.cn>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MV2yxB34+Q2zqsDWFhKfaL7v4OrNXz6GXsZM2ALSJ+LgytwtwBC3W1C7
	3OJANhrQ8IR0Uqv4+FS/Chpw77z73BTMFRvgJHd7YXpamk6wsBH4yN9ISXzMK4DYRUC2Tjo
	pcHDelRcNVT0VacxaLODxh0Ujx4rIabIAGyijXyCawdsXFsHs82wM3jSYcvXMnA0SZEPE+c
	M0CP1U9rD1y1VJIMLeEJjrCN3DSTZeZMIYu8hdUXuxkvzPrnuzkjrv2uom4vukffvuEHf0P
	x/9Nsdph7XHIl1EdZXWq2l/o2v8QEEUxCi7rc1JtKnp7sXQeX0dPHj/PMV4KEFOGY6Mf3qO
	IZZTayIr3hJ7NxaAFt8L7in2LuWELZrGMrwQUxYbcWNAeDLA2vgxU7LTJ8EWjNb0CdGMe66
	ZTC7gpPWmFrkrKGD1twtOXEBUU6NnnuXncDAmtr48mJVTr4mIFmdKrt3Y2xT69YDBh2p1Mk
	zAJj+9dkHBx+RjYco8xWCXNuZ69wmoStao+n9qWsC+8XxRmPSChRYQ0xzPLx/RRJ04kXa7h
	YF9FoRKbqwznbYW0X6S9Av6GLSSh5pODd6a5TRU0MLH79hPz1cmd3/eqZiMzkLJMmIM0TDK
	zeA5BXLSC8t0+Mvi7GllYi/mHF6O/BDR9KZuDO0U/nW/HyMHY3BsTg8eGHMMAwYX1nP7i/E
	R+r5zGwpOgTT4on9MDBOcJWOu8Jyk7tPPl7VvZFeJMKHZ0YcXOLJMZIlTJcIBUSVKlJBvC9
	v8trSNj9LfK/DR8fxmvyHjYm8NhQb1u8ncUVSL5dofgMYYD5rEK+6gNvJwoItDgSmLK4rGE
	0nry9jc0pP4DIzOS69EV48PfuvT6ujrBbsLQl/KLUa49nr3CFrLGjzcZcBb4OyKD/5r71De
	uP05V37PPHebB1WCB61mA3v1tDhnX9Rla9v9fXL4CKr0ssiQP5+SxP3az7lJ0iuZfIURBWs
	7t3tS599AfrTqF2B+gIJYnyc0gTS/bf9K8dtHXOjjoErOmpHos3vGLsW9DTUFjNY4UgaJky
	ljjv3lwrACCXhAQZ5t
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

bpf_iter_css_next() leaves kit->pos NULL at the end of the walk, but
kit->start still points at the starting css.  css_next_descendant_pre(),
css_next_descendant_post(), css_next_child() and the ancestors walk all
treat a NULL position as "start from @start", so a next() call after
exhaustion returns elements again.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats later next() results as the constant zero.
A restarted css iteration therefore hands the BPF program a kernel
pointer while the verifier believes R0 == 0.

Clear kit->start when the position becomes NULL.  bpf_iter_css_destroy()
is a no-op, so no cleanup depends on @start after exhaustion.

Fixes: 7251d0905e75 ("bpf: Introduce css open-coded iterator kfuncs")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
v2:
- Shorten the code comment; move the rationale to the commit message.

 kernel/bpf/cgroup_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index fd51fe3d92cc..9e466ef2c433 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -365,6 +365,10 @@ __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *i
 		kit->pos = kit->pos ? kit->pos->parent : kit->start;
 	}
 
+	/* Once NULL is returned, next() has to keep returning NULL. */
+	if (!kit->pos)
+		kit->start = NULL;
+
 	return kit->pos;
 }
 
-- 
2.34.1

