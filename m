Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B27081E;
	Fri, 19 Jun 2026 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828838; cv=none; b=Jp0fMUSHb4ugH5U2fFtcUyQGZSEXbspgi7wWJLvfdraTbOyDU3lTWTpPvD1r9it7Gqj73v+e3izAkyDpbOcGxxVICN34ayb2e3SBhpKbvyrD4MqwoIKpymQ2em+jgI/LqAsseNNamF6TjQZDt5xkmwV0G7srqyvi0IVMY6RFYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828838; c=relaxed/simple;
	bh=vDiNoB63vp9CNN4dH7gwxlh25SsPTI+fA2yOTDC0cAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSPWq7gvfDi3+er5FIMz1L6Pquv6IwbwuXf/wvnJUyti7j81pyMUp2S7Sbweqyl1CPDtsXqL68xk9swcSlJDI5Y+912gg0hw6gXTt/9afoqBkpOrRE9rz4NlRrCyg5lYaMYL65jqnycvz0jXNU4kNg5h4xUHmi36L2kopU5mRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjUOGOcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjUOGOcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907D61F000E9;
	Fri, 19 Jun 2026 00:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828837;
	bh=2tso89OAXLEG4abmFUORfnswxG8cXfUT2RyTgq1YXRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jjUOGOcEqOqcejvrPh6f+kz5nWl5Tice/PTK+N6+oJaDOigYKQSD2jBJe6sGwcB74
	 Nc1ib5BtXKJLsq4kU5uL7osETYhfM/iCDsYt7X3L3hE5awuCmjLdceLbmzzHEd5K7x
	 XhuxggqTxl4FDADfnZ2ubBc2DwAt0nVQHfXgUa7rM0aI/wBJdNw7Nyh8eMeyk3WuhN
	 Zg+ZzO83/rpYXDIYPpg9RlSa0MBGKkrZfo922nX5qx5RyY+C5qhbwGfcc6HKBaabBj
	 NCQiKleocR5/hUlWkjy4rfXxAOitQQAe8tq/HtiDyo3KQirFxn6krqeBztE18lDqyE
	 HvW2ewd2+R1gA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 18 Jun 2026 20:26:42 -0400
Subject: [PATCH bpf v2 4/8] libbpf: ringbuf: Handle position counter wrap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bpf-ringbuf-fixes-v2-4-33fde039ddf3@kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=tamird@kernel.org;
 h=from:subject:message-id; bh=vDiNoB63vp9CNN4dH7gwxlh25SsPTI+fA2yOTDC0cAE=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPdc2Ftg/39RZZHndX/dj58IylV5TtYMfLQ+4em7JO
 CeQ+aGhYyILgxgXg6WYIkui6KG96am398hmvjsOM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6BgzcHEKwFT/u8jIcOn8FuapShOWd3K0cni0b50avUT06xHxaIOW+HS234818hn+yqpuCPa
 YLOtS07+tIaJ13ZKCwKinu/YIXBA+kRDpvOUxCwA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Ring buffer positions are unsigned long counters and can wrap on 32-bit
systems. ringbuf_process_ring() stops consuming when producer_pos wraps
below consumer_pos because it compares the counters by magnitude.

Compare the positions for equality instead. The producer cannot move
logically behind the consumer in a non-overwrite ring.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Reported-by: Andrew Werner <awerner32@gmail.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/ringbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 5737e02c1670..1c5bce2b5e12 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -274,7 +274,8 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	do {
 		got_new_data = false;
 		prod_pos = smp_load_acquire(r->producer_pos);
-		while (cons_pos < prod_pos) {
+		/* Positions wrap; the consumer cannot logically pass the producer. */
+		while (cons_pos != prod_pos) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = smp_load_acquire(len_ptr);
 

-- 
2.55.0.rc0.159.gbe5d7338c2

