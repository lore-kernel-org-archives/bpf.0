Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47149893B
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048989; cv=none; b=ky94YxVz7818qpxDl9zE9HRrzelac6TgIhJWybIHxTQitYo3ZLPYj967ct5tdqEbyvWMLf+KixT9xnFZ/+d6be+eghSfezjE9tS4JHv7ZBY0Cn0oiWjeD2Yu8ncFcTqKVbPXv1BykOUPqTD0AIAvSAGZ2D/5tuzXZW1IKltQGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048989; c=relaxed/simple;
	bh=Z1zsf7kSU6YpU586R5oKdvSCD6Yvlguf3nXcZLXNukA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTykv8N5nLLydoxxDf75mFHO7cKv2gttWUj0lRbJbCugFpNhAGQuXuqYGTH0KsL0FHi0P5zanhIFlcnj9Vn4E0w8tBvnezkRj6x1e9egANeEdqxqWfOYu6z6o+GAttwKbynANShoNsD/kX3dmsbvxSHQ88yiUdNt9Dz38gOAkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eX6SrdBY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eX6SrdBY"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c259e5c22ffso882198466b.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048985; x=1789653785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dc+oPQbXqp3NHCONxj20iOHPRMo18f1RBk7So0TZeOk=;
        b=eX6SrdBYoJBO8OiqIUa7H016F5ahIAg5y0TbI/jVrmW3u0hFow9oCDXqC0xv9gd80U
         B1n2PUgFq+6Jf9q0CbO6Qa2Ho5Rm+RLkMkG1AdGWUn4Ni8AxJrHslDu3nrrMfd5VMgGd
         rrqV0kH6xlAyy6fawkLpBQGVQwSk1UYf/0KIrDUwdX36SHiWLbV+eDbVzwEyOBsTwMGL
         r7Y1SywolD3ZqCoTxUNsMtrl/Lus+mjVQVrPN5nT2Z8r6GVBXi6BL2aGkd/JAqleUZk2
         NsmQH0yup3InCEk08rBWMTHat0ODrd+7xv0vwZgLHaig3HDC7pq6OxsYUtEzaGZUkywF
         npyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048985; x=1789653785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dc+oPQbXqp3NHCONxj20iOHPRMo18f1RBk7So0TZeOk=;
        b=FBSh/wnGXJK1ETQMxomhalUnMzHBMIJWeLZ7qYu96TKIR+l/Yz2EgcrpwQszF3qHbk
         HEmPAXX5wAz3M0RpQ8F6+bGltOKTc8Kvg1oTaOAXzKzTDAwkHhq/imN3I6TSJC4T2whr
         cFeJpu2BZaPXR8GSDH+XyCvITYZAgNAQ57cwcVqQxqeyApGIL8F7aJsdxpKWGsb65XmO
         WizQDTIBerrRzK1Rgj1A+szctannPZsZwjW65DecbAo4v6yVoIJQr8Ic3Y+haxseungV
         Il9yZwji4yPD6CmaIiFseRr8IM/aZ4Cnubvti3EGTnhYUCffSeHAriPj+syQZBrwDz/2
         dNgA==
X-Gm-Message-State: AFuF++kZAlVcrz/121bPWU3vv1E8I0yfWDrWxiDFvke/At8pzeaK3i2Z
	pkCBSxd7iv2hR+fxTxWN6MlUy8/11E28NZRYiBmUU3qacuIZZIBmml/hNR5vKnpRfvc=
X-Gm-Gg: AYBFou1GDwHL463r1KneObRdf+mPUYZbQ3LuP6PXAxqBKOVi5XSunTMKB28oGDBvB10
	pppJN9LQTEATcVaWooRvg9u+QSWsK8Kmz+aMX7EY0hlX+hOQACDXVs325HugiwPLogACvUAKBG/
	VPY3muI3YJ1Iva3Nr/4QEFxnvtaHwIItSxefm0TcOkfBz+ZJQUBPpzLcGPcj1PH7YwkqRkWfmJT
	ICmC9xsYaD9yNj6PfCxdHUAv1gRBEbdGgs+uNeyhlWlAhKBMWOj5MxRgFaqQU9SR39diwz3GPHZ
	XKBhuYQs84u+raBPbbYjRRsRF0KPjKnx6bO5Ddcv3lwd71uKth8s0Vsr1749uM446JLgcYwikou
	DV0OzCjeV19hwOpWAF0h9m+ca14VvtYof7I0oQxwomnRHcfc7DE/Ikn/miTiFpVIpko+s6kykd6
	CrY5BJffGKvAEc2NhwEgyeKz6mDPx/HH7AOVOVvzb9PJT8g1UHsOGBmjaucQgDukqTPfIXDLA7P
	i5+xDT2wHixTLejTKV8OuN6nIfef4xWf6ttmbTf/hiTqyARok1d+l8KDQ0=
X-Received: by 2002:a17:907:7216:b0:c26:3424:f7df with SMTP id a640c23a62f3a-c263424f912mr1286278866b.30.1789048985387;
        Thu, 10 Sep 2026 07:03:05 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5cfaa2sm926334366b.59.2026.09.10.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:03:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:49 +0200
Subject: [PATCH net-next v2 14/14] selftests/bpf: Use non-trivial test
 payload in xdp_context tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-14-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

Replace the sequential test payload pattern (0x01..0x38) with
higher-entropy values that don't alias common protocol header fields
such as IP version/IHL or ethertype LSBs. This reduces the chance of
false positives from stray packets.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c | 8 ++++----
 tools/testing/selftests/bpf/progs/test_xdp_meta.c             | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 01241276c4d3..9cbb839a55cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -22,10 +22,10 @@
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 5b1a5b9b610e..80cdfee615cc 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -24,10 +24,10 @@
 bool test_pass;
 
 static const __u8 meta_want[META_SIZE] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 static bool check_metadata(const char *file, int line, __u8 *meta_have)

-- 
2.43.0

