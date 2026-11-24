Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530708;
	b=beCSbj6ViSr9PnyI7EFt2/cJNYqR2w/7P6+jfbKACCvUrtxu/fyXErS8WBLL+LG/TGYJ
	 wShbuM/ru7u6I9LWNe9qusC3z/005//Wepj/9MSWAypUP+rIuzAEksJpXyAahwFOZKcU0
	 5AKg4C3tqIuiy/9waOOnoz9xUmeyPdoS6WYFERXOUVdBqEqPmvOWN194VW46zCeLu09np
	 83NCHFhV6jINFYSpFTAYOaiEVL0maf7xECazZaFqkirFa5e3v5QrXSEGrN2szAgWq3pUC
	 bk7slZ3sZUWYN0oPH5NR0bGCgrAArgKlZKnY/sXVlROd5osVgzLis5iVNqcSpYuLwlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e5nQK3hY4QWxDiFxG2TVLn0sC87qjDF+NBgRn5G+iKQ=;
	b=DZERc0CGYub7h/uLLP1762aMeqUvm+PCDq4oxyxk7Ysd7jlyUoLQ8JqAoh3KuBEJ+jN2
	 iZ4iD6cmOfWgwicqsiVD642MutqGM4skBmX2U0EIZEj+MBKyyhXfG3WyB6kGRKTnGbNfp
	 3oeRS1esy2CoGXhoTsrIQzUPlTvN7eulD7nG6mlYk1cr52+lUwRMiNCzQ8fTeV1qqHwWE
	 EUtEGpTEvScczh92QcoKAM8/MNnwzSh6A2rz/+cXFXARe4neVlNaNvV/opEb69wZ1zoLl
	 CVeSJSvGGoqDuVkO7isdCiHysThNqEmsKasBh1hax+Ygxa6Aj7KONCCojAGg8BoQ+yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AjEHrqNg;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46678606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46678606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AjEHrqNg
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb628232d2so2513937a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530707; x=1796135507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5nQK3hY4QWxDiFxG2TVLn0sC87qjDF+NBgRn5G+iKQ=;
        b=AjEHrqNgifqF8aPJ7EKJgLp2n35585eq5Lo7NlPgH7Ksj/AuHveZRs0v1+Jj/5Nk9K
         j+m9et26cCVsmUDROlNzguXU7+UAqRX9pNQL7hFerUbgazOwkPflbu4D2dCjEP9v318U
         qcBx5MXmk2SpLe7MhVmj7Gg5OXUqpZfTEYnUYDHGv+r2p9Hz6irlHYxkFGj8qj5h0SFY
         ovU0WeZu93+hL/FsH3taW3Bhd0qh6DJ7hxj19t4Nklc1hcnuguD/v+Bn9VvF03I+OyBm
         TOnOR0wxs8IQjc4nt34T2dTC9NQjZ8PdbM9CZoI00jbSq0z1/poyerK/kqKvJhrtWaIx
         ZxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530707; x=1796135507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5nQK3hY4QWxDiFxG2TVLn0sC87qjDF+NBgRn5G+iKQ=;
        b=f+HuOo28T/phYLLNTiMYf1XIMqXF1ar9CpMKoOJt61sTNdSXEsd8npyhKOCWlmkXHZ
         56jfRFSIBmn7OE7BDrj6u1REbzvjb0desH1jIGcHDEAQ1RJMe5qRaRP9XEvARLsXIt0z
         n+zCU1cY15EhCBnYPHNYh8MwSVBK5PiReTJe7/cXmd7h7O4mwehAFSKdsouxu2wDwhK4
         Z/iuwKiYINyqZXjB5CfHVTZq2iqj+w96WREcU1D0tX9LkQZUkrd9cuAUer6DV7nCuZYK
         1oCgZ+ZIVeFDVtsuBGthUGxD1uz/fehmBoxOmIfyQdQam1l50vWwcKA2jXe0eL4RT4Wq
         uSUg==
X-Forwarded-Encrypted: i=1; AL+hErHGR9WuuiD3Y08t8bULhCdZHS12YIY07tM53nSV9tzOJvPO+c8DqIxFV2s+hDwHZIkEhJg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9w4a1HL1XFSq2WitB1I7cY5UgCrN62btBNbWiUXskZDz5fP18Z
	6mo796HzeeUtpALxOAf3yI446kvO99oULkspII0H7HJ/EvmU1SIJOqby
X-Gm-Gg: AZFdTZckA0dvfOKXOVIg4BXYn0/4TLGXeYqYLYaQdaFQvwCzn9xqU1WTpXhMHTiNIvG
	F5kSwbye9okWOTo46K0arIEjW8xzRNJug8M9aeSSMXp9nCDaWQr+6C1YXgmhP1lKcklmO9dp+uF
	K7FwJNMVEYSkoXpmxAvOz9y2+UoDlQG4yXZoWVSZEYSqIIji2HkVygq0j5bKfPzgJRpe9jQ0Kqc
	9K9ndiMnWo0hyoQsrx/POGS97Dd2I8x9z8zThgHFUqyMZ1FGFbZfiMmoGhhZBNW8ZK87QDWwOE6
	XmRjFln6Y89ZTy9A5aBJ/gg/QNT7BSeCaUhKgl15PtjzumHAJX/BntgmtWBi26cLGfEDDgWm6yZ
	5vTjmcoxtP7Wgf9ubKL1zzjJpjzwJgEbKgGzT6bRkdCZbmZCd0/UacCoJgj0OLVsfSu5nr8bz7q
	QJ16JC3tWK8tE+dHWMTb355galiQsY/FyygdUDlzOKeYJf+GGduWkQcIciqbYCxZYr0NY6Uih9I
	HygzML7kvyumxEyyOL5kKciMKoaJch0tHN553Ukx9dBee5H5dcP2kwi9mKL86+QF4ODcq4ey1ub
	YObjD8zqNObTW8cKtVeWExj/BFsGGY706FL+pXQ2GQv2xibS3wwg8aLFjxkpjRJGLpeuPS+6Tsr
	gDe3d/daDWw==
X-Received: by 2002:a17:90b:1d03:b0:3b1:96fe:f5d2 with SMTP id 98e67ed59e1d1-3b41c9bacc7mr14862324a91.65.1795530707373;
        Tue, 24 Nov 2026 06:31:47 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc8829sm7171737a12.8.2026.11.24.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:31:47 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Amery Hung <ameryhung@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH bpf 1/3] bpf: Reject sleepable programs in bpf-tcp-cc
Date: Tue, 24 Nov 2026 14:31:13 +0000
Message-ID: <20261124143123.1182108-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
References: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
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

A bpf-tcp-cc program can be loaded with BPF_F_SLEEPABLE, but the TCP
stack calls the congestion control ops in atomic context. For example,
tcp_set_ca_state() is called from tcp_v4_syn_recv_sock() in softirq with
the socket spinlock held.

bpf_tcp_congestion_ops has no check_member, so nothing rejects such a
program. Add one that rejects sleepable programs.

Fixes: 1e12d3ef47d2 ("bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/ipv4/bpf_tcp_ca.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 2a71dc81562f..acd5e84a3dd9 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -208,6 +208,16 @@ static const struct bpf_verifier_ops bpf_tcp_ca_verifier_ops = {
 	.btf_struct_access	= bpf_tcp_ca_btf_struct_access,
 };
 
+static int bpf_tcp_ca_check_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   const struct bpf_prog *prog)
+{
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_tcp_ca_init_member(const struct btf_type *t,
 				  const struct btf_member *member,
 				  void *kdata, const void *udata)
@@ -335,6 +345,7 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.reg = bpf_tcp_ca_reg,
 	.unreg = bpf_tcp_ca_unreg,
 	.update = bpf_tcp_ca_update,
+	.check_member = bpf_tcp_ca_check_member,
 	.init_member = bpf_tcp_ca_init_member,
 	.init = bpf_tcp_ca_init,
 	.validate = bpf_tcp_ca_validate,
-- 
2.56.1

