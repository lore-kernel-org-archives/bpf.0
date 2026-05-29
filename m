Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270C36654C;
	Fri, 29 May 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067702; cv=none; b=VMXCVDiMCD8f5lpf4I6hYbjPiDRUFW59U+Q0FiQCBVacUGpGr38pvhP8IOWYUKgedXQwL7BTbGIchB44DyPFU2RU0i5tQNQJo5fkx3XuOjkjSu5ltZlYKl8wPO5+0r/pcjscu7rvh7zj7VQ9BA2FuBpw/0CiYIlWrh/1pbBBhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067702; c=relaxed/simple;
	bh=BD+fGjyph/ospc62O/7eSoVQx4RfgaqTgXjRSZqH8PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoDIt7QREGW9aJdoOxTxaZUuVtkEl2Z5e5Nv4VDwbwcsIKg9SXncjAMFsTFdJlBiycjdSWEigMUpnt5rci7vgSTIgc53H396FD/Ip10T5hBLCqvPqf3RwXfdC5+bRJoW6ruln9GcIJkNIKZ0Ye/ShuFnM1rSqajjQ/q4g0WqdUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g8e/X6nd; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g8e/X6nd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780067699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLT2gH39dUAUDzhjvHd6hBoqXWfY6t5vMPhXRheOmRk=;
	b=g8e/X6ndtNpsyjwOlQgixqBdWaSfqqVmOam9aZw8oRbAy8svbWxY05Rtam7AiK5irxSqM4
	S6bLRHqkMv1EkH/Lrj2zeAcFUm2GGUT9MKuITvz23aXIjqgH3Zl1iEkX9Rm0qcOOqCE98z
	I3KpZZz0ZQ+8ctnKTJzZFFuH2tCwr8A=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v2 2/4] bpf: Add check iph->ihl < 5 in lwt
Date: Fri, 29 May 2026 23:13:49 +0800
Message-ID: <20260529151351.69911-3-leon.hwang@linux.dev>
In-Reply-To: <20260529151351.69911-1-leon.hwang@linux.dev>
References: <20260529151351.69911-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sashiko pointed out [1]: On architectures like MIPS, the while-loop won't
stop in ip_fast_csum().

To avoid such issues caused by invalid iph->ihl in lwt, add check
"iph->ihl < 5" in bpf_lwt_push_ip_encap() to make sure iph->ihl is valid.

[1] https://lore.kernel.org/bpf/20260525150010.CDEBA1F000E9@smtp.kernel.org/

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 net/core/lwt_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 8009e427851f..c306120e11d2 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -613,7 +613,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	iph = (struct iphdr *)buff;
 	if (iph->version == 4) {
 		ipv4 = true;
-		if (unlikely(len < iph->ihl * 4))
+		if (unlikely(iph->ihl < 5 || len < iph->ihl * 4))
 			return -EINVAL;
 	} else if (iph->version == 6) {
 		ipv4 = false;
-- 
2.54.0

