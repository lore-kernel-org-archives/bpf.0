Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934077;
	b=RGig6LgPcp8GlhHHpGhPM78aRwnnb+wkwGijSU6bYfu0nr/s7DoYne5JqJWKYdJgiM4D
	 4bXE5kfWMvVn2lSd94RlWF244/vpehgvzM7w3vzrrmxZrG4je9d6mAfS1NmNwktEuuSVY
	 hzavvUkE3UUEPqUl3vufoCM+c25/8MwBrfklkYBZm+K/+Zixf2BKlHTArfpGOGw90MVU1
	 AiF4dnZcYImtm2mE0EQK0UoGac0ExKNecZlKG7QJU7/2NNWoSwWV1TM54qJM0QaINNrrK
	 E+bqV7JPA5rdB7aUvuaWGsA0mmS7WBwb54LutH03x3S7mSU62su7VVaLk90oDC/nUtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934077;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YLFFgzpWj7A4Qoim2g57jQzVKXzhgMc409wqmO8WDvs=;
	b=1Nxx7rOpZIalgl/3IkDwNXHBQ6aL6MkVQKYFl6PyOwMBNvOns/N80tenNOiPJtrNCRCF
	 jNIXaGiWHUxqW40PdyQ15QB17qJkWlMXVkHyiHBweMPgONmOL5ZqFLoTKYGw2Qlo2ns7R
	 5f30yIc/38pXoAA9p7AN78jMWHJD5btwsjZkPgYpGhfGXIcpZCHUTynqu/nf3pQ2Lx3LN
	 gc+xwzymL6EYkaJ0GRPz29SmrZ2RBkRI7w8x5yOdcNRZK0NUGwz4F6ycbe69BRLwTQmTR
	 u0CqO5UstrKLa8I0L+MY+FdQsaoK9m/Ow7NKeYi6NHiQCQhvwW5ZwpouUZhLAlXQXFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y+phX/0q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD9606A330;
	Tue, 17 Nov 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+phX/0q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8261F000C5;
	Tue, 17 Nov 2026 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794934077;
	bh=YLFFgzpWj7A4Qoim2g57jQzVKXzhgMc409wqmO8WDvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+phX/0qw9/NDsfjegcHIwWfTf4W1bsyQNxa/Daa6zlvulikl+YiNR8cACxNJ5T29
	 a65/BOTZdcoLBUXbN3PC8JkBvzV+Os6zoyN8BrRjNx5p6nNdkq4NtwY86Q0/0tqxZA
	 s7W2Tnj6NgHcGTkryvAd5md3UIyb+IDPRtNSd1txzROia2+gdbjUehS7YFhmsnhWmr
	 pvmo3eSGv4OHPZxeQjiZe8iQqr1/qCM63bIghmtb/dXLks5O7/Tst5oCYXtQEuS8UI
	 qBP5N8FGB26ER/T0qoTeYe/uvuhh9YMoDeo5fLoUSWk53db8WnJjcc1Va9QEDZv77t
	 z1G8XjUXhjwUQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@meta.com,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 5/7] netdevsim: Run native XDP next to devmem
Date: Tue, 17 Nov 2026 17:46:56 +0100
Message-ID: <20261117164700.2157816-6-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117164700.2157816-1-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The attachment rules need a test driver that accepts native XDP and
devmem bindings together. netdevsim runs XDP on ordinary skbs sent by
its peer, not on provider payload.

Declare native XDP support alongside devmem bindings so selftests can
check both attach orders. This tests configuration, not access to
provider data.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0372a9bd63bb..3d1657d24f60 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -880,6 +880,8 @@ static const struct netdev_queue_mgmt_ops nsim_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= nsim_queue_mem_free,
 	.ndo_queue_start	= nsim_queue_start,
 	.ndo_queue_stop		= nsim_queue_stop,
+	/* XDP runs on the skbs of the peer, never on provider memory */
+	.xdp_unreadable		= true,
 };
 
 static ssize_t
-- 
2.56.1

