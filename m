Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762623909F
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776959912; cv=none; b=c4WGqMf9IdVKxSH4byEq2wrre+UFvoeLU6ZzwHXUXizUXe4rPtrQFJ47rmojXO2DN6PvjjOu0rYyCSuJYBCWqfACwmSwMHYTVnymo5ng1wnhfsSvvR/h72hnMnwhfC6Xj7gKK0lTXNRHHg8ilM27+uZFQlJzcCkurddptFyfVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776959912; c=relaxed/simple;
	bh=AR1tyKWtZeVWgHbhDNYPsmlXWN6qh8CcT0QwnDPOjPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvYDG9+m7f6qKvAwsHjwixRpIQ9h4ibTbspbTxATQ6hnDAUKoIaqunNqwyvg6PP8Nbtj5skK8ggpVwLC/XlbKHLm8153Wt+u+PB2uqWyWUUEAkEp3NGoPLe6VW4pLNM56Ro8Y0X0EndJeCdrSbc6LDXmVP0Q5cuuAkQOCH1HJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qsnih13R; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsnih13R"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8cc7a77eso3102501c88.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776959910; x=1777564710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lw0eJ0HrBtMu/NfaNFWlMNPqLWJs3EMGa99HbAzS2UY=;
        b=Qsnih13RTYuif+n7XrE3Jslgh/QElLXemxDoJNesFb96kT9AylGiiHX0xD5JnlNsL/
         9bSD6pH6nvaXkTKsvPQWDbjRtWi6xWpvWj/w1YbyE35r6rizeuFPOO9Z8Dwn1K1V58TC
         nmoukm9yhFrSQiVEK9XmHxe/B+mK79N6TVkL+H+d+dz4L2XuHfiuph+SgjAqtoJitYmI
         JvF/nVeMURj8RE9QXpJ7HvjogC+ZYVSd96Ln/r9wHy7S66tL9l54JD+j8CKUyRyrMVSf
         257IScf276DBNFDDQwzRdI+AUXvAAnn49Viw3rvImBj3Psdo4+hscmIaWMoqBDh2/Lff
         7LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776959910; x=1777564710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw0eJ0HrBtMu/NfaNFWlMNPqLWJs3EMGa99HbAzS2UY=;
        b=rygoiBK+h3x6kPClM33HLeWQWVYldbRPWZWn8EAIIGxXAtL3C1EqGXbzLMEW9M5lBo
         wJjP4wzGnZV5DfGQynTtMsNRMFkSEe6nvhE/C/AmPzVHiG257Nncdxw4fxmZzfcRYp33
         il+8pkfj7Eih4gMncjP/Tv551P2dMskJItMHd/+XKjnuguIqk3qQjnwA6D3MQICxbgIt
         oNwReLLYaavloNotVmV5jmvV6yqxXdmSRTGug7GXRGNC27skuawoaxQoLjPhDGySTfiQ
         cGaPNy5QebgwYk4NNYuyCdyVyVYxt5c0vzO4wV2ZwmGhWrXsIgNFBB5Ne+Du5BmiSpvV
         dpkg==
X-Forwarded-Encrypted: i=1; AFNElJ+azWl56BKJWxMWj062IXc50IFcZ1jpGhDvgyVClgxjFfr2jw63UWL1bV4GAjyQmEHdEe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuN+vIVefPTWDDa0gWnrZC5VKj+OLMvbz9CPSe9s8rUgezcE8
	VZymsjnraUtnccjSZtVQITm87WoHRvd2eQV5LWcFHwSHukK8zK88xc0s
X-Gm-Gg: AeBDietkno9eafPG9b+YFJQAnv1BV44URPu2gupE6I/q+nQbDoLW30OgFhHFNqlbwHB
	ETKtohrgLOlYxbnTRAfc0LsxnjSUle6rtTmuukvv306jczPtzC0toIbJVwavtARv6f5w4sSyUho
	/7DvYkj5VLIxfyw+m2AvvgV49VVLiBGPN2ON6jz4JRyA8b2826Lga/tZ9DxwU3ojltSZjka3iSZ
	fDUyroJcpsCFh0jVuoFCVOMkE6/ScNXg2TgmH0jSV5u1EejyXVmoz4IhWZuWaOMzu4sdDF4zsjf
	+sJVqwqEe6ruBWuxRvA8bOHEwMmK77MmTVU5GQIBdGE9fVJKouxvK/8CgEVKgJIsXqZI9EI29Ea
	OigWEOc2n/NosRG9j1kFsHVC3Yd/esS7ZLrp7441S+Nd24DuVeedv0uVQMp86rA64AoJzGKFfVB
	GmuqBQyG3RQ44W/CRWsY9Nglk5lljvK6yZL2DgYGZFUkkwc63d+FOIBPc0xucAahfYX2On5j0CQ
	cbLTwXWXC6m/JxiMiAZeGThzol5wqI=
X-Received: by 2002:a05:7022:b8d:b0:119:e569:f86d with SMTP id a92af1059eb24-12c73b26cc5mr12096979c88.10.1776959909284;
        Thu, 23 Apr 2026 08:58:29 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm35656689c88.14.2026.04.23.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:58:28 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
Date: Thu, 23 Apr 2026 08:58:08 -0700
Message-ID: <20260423155807.1245644-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bpf_msg_push_data() splits a scatterlist element into head and
tail, the tail's page offset is advanced by `start` (absolute message
byte offset) instead of `start - offset` (byte position within the
element). This makes rsge.offset overshoot by `offset` bytes, pointing
to the wrong location within the page or beyond its boundary. Consumers
of the corrupted entry either silently read wrong data or trigger an
out-of-bounds access.

 BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
 Read of size 32752 at addr ffff8881042f0010 by task poc/130
 Call Trace:
  __asan_memcpy (mm/kasan/shadow.c:105)
  bpf_msg_pull_data (net/core/filter.c:2728)
  bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
  sk_psock_msg_verdict (net/core/skmsg.c:934)
  tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
  sock_sendmsg_nosec (net/socket.c:727)

Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3e56b567bd18..f12fbc49bc03 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2865,7 +2865,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,

 		psge->length = start - offset;
 		rsge.length -= psge->length;
-		rsge.offset += start;
+		rsge.offset += start - offset;

 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
--
2.43.0
