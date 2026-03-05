Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4736A02C;
	Thu,  5 Mar 2026 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753537; cv=none; b=Zoek7slmDU/Tkl8qKwRfp5NsrXQl4fmP5KFaUG0y9ubiTn2v4QcAoDbqhmEn+jzPkAQkqTwA4htBndjlEQJ09/6uzxB2JYoamHC3TvgO/GgZYqnCW71hAyW9akpwtnZ4W9on1TfRj335v+5fpc6vmXwIT3d1aQKEI6TCGofskdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753537; c=relaxed/simple;
	bh=dPxiuBeFVLFXcQWhDoQAORF1N20Mja2gEH0QbJScTxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDpxJcGTL3mwlvkmVD0giweanqUDyPfxX+ae4pQzO+qp3CpxHe2f5e4MF5O0NwSFDtXGLuxeU/q5sc35i/DXHGWwibcFyTo2agxx2I/cZ6e5eH3jf6yVbjWqdckRf4lwUPIxhY0Xao480NSX0xsbxvnDYPBCk+wXFQL2yWGepR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=bPcPcFgt; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="bPcPcFgt"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyIAt-00EUi3-Ex; Fri, 06 Mar 2026 00:32:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=RdHEkIIRAhdGMHaZV+5C0ZEGBw8Y9TkMkH8ReCDpSdI=; b=bPcPcFgtE5d6dwCZUfVkoOkYYc
	zGIRT6ZToCxJNhtZ/jcJWqJRkOcDY+nSq5llGhexsFNpe4ASGTPeV/QQsD48MadenHAmiXeP60zXR
	91XcQRyhPRovHaPtTqmTZlVFFhBH/RjSCDwSwUKlKPNA/XunV6Io5aKa7YaZQivf32ByAwt0hOcIB
	vK4KpkMnVxjTv+Mo/IB1pAfF3l8qFpJkEaAZ2xepF+rjXF9RoBdWenWMgLIM2Qmy00VF6io/TGizl
	tyi2nY/FZ3fTyngeOCEblKmdmk8jooTipfd+4BA+aW8MeDwoewlt2q1hZ4tjo2WinN8bC2S5rhnM0
	+Ukl2sXw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyIAj-0004Bv-14; Fri, 06 Mar 2026 00:32:01 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIAL-00141B-Si; Fri, 06 Mar 2026 00:31:37 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 06 Mar 2026 00:30:58 +0100
Subject: [PATCH bpf v3 4/5] selftests/bpf: Extend bpf_iter_unix to attempt
 deadlocking
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-unix-proto-update-null-ptr-deref-v3-4-2f0c7410c523@rbox.co>
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

Updating a sockmap from a unix iterator prog may lead to a deadlock.
Piggyback on the original selftest.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
index fea275df9e22..a2652c8c3616 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -7,6 +7,13 @@
 
 char _license[] SEC("license") = "GPL";
 
+SEC(".maps") struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} sockmap;
+
 static long sock_i_ino(const struct sock *sk)
 {
 	const struct socket *sk_socket = sk->sk_socket;
@@ -76,5 +83,8 @@ int dump_unix(struct bpf_iter__unix *ctx)
 
 	BPF_SEQ_PRINTF(seq, "\n");
 
+	/* Test for deadlock. */
+	bpf_map_update_elem(&sockmap, &(int){0}, sk, 0);
+
 	return 0;
 }

-- 
2.52.0

