Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422932C92A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510564; cv=none; b=kw44Hd98aYBh8QOK5BKOFiC0SAgmoPmgm93+bXmuVe1fRKZfatRblfnaX2x+F7CEYzsZxcgG4SftHZ/nF8kfTz/we7j9HPwSXRUYchv/5jXnm+Zn6HwIqKh7zPCthf6KClg9gD9+h98uAJdfgjjDzQB4URCMCblYKKWLv2dL88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510564; c=relaxed/simple;
	bh=72FAB5TSLVz4Thr0h+bv9d4S7Ew4e+SEyCe2IkscpHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VXKF8u3ixAOWa/vQ3xnAGQBzYkPHTIQtDN8g/QKXzyn/9I4gqXAtB2G6pAKNSxTupBZNi/46tB+M/Vv86WJymDIwR8YlHFxGKthyTVXeeAbx49DyMUCTkTFovn6ibKS2vnGgLmVKx1ZthDie/fBlSci7pQ23Z5zBCf2V0Q/ldPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+5ED6hl; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+5ED6hl"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so5635443eec.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 18:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510562; x=1792115362; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LL6VJoesIXgvO6dkBve9nwIrZ4XKjap6wkylrhkf3eY=;
        b=I+5ED6hl2joDxXw1Q5YAxVrOqWE5mWNKYYZckxlLrcNffUcL4SZfe0MueN9l7exYVk
         HxDHhJmGcw46oh6qwL4RTOlOYduNnLKOqb71XzjnK5W5IBgbbalw2yl68k4dHktgziRg
         5yhUj9rpRLjfjdZnAE3hVtmkXg4XMAdQR5DLMW9SGrpOn1LwtfTZezO452jpGqMOYbJb
         eHO6ErGuo5wl9UQUbJ0Nnk5U4wjLC4AuwAI1xJr8rpf18ghBXh8jlVZlXRS+Y8Gqt68z
         +BlkEuQSUwo1lsvspP5jpgMh+6BbAVYfg5A4TCWlwGA4HrRta9qV+84IyOZwrS3Q/2ng
         TvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510562; x=1792115362;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LL6VJoesIXgvO6dkBve9nwIrZ4XKjap6wkylrhkf3eY=;
        b=MrirRoM6GkUb0F1CPQ3jeDcnLHvbAsWk0QPoUPDmc19o1Pd3uJPmCqRMaVELIFyqLz
         ixrbmXuX1tmaGKJYKqsDCJOahNWitEjjvtH/ABj/TrajtnN59bE80h4tAXg7oMqNO4QP
         ex6WkJy5PUhwXrXrwYX9QeKn8f1krtzGBzI3WvRAwDwxXv3AYrLqK/cMQpmplbDzj6sD
         3irY2pRLgWc2go3s3HFQCHCb0KR77kVKKnBnPSfyJ+9UQaixdGn0V9U5QrssictMbp/k
         maMBoFoaqHQc1uqECq+9Brh4nkJe01UfprvNTbZqvUGB64eItW9qN1c/5wSziMI8PNWO
         QbeA==
X-Gm-Message-State: AFuF++mEv9VgWMTyNmWhnA2yw0bSOBNSaDZentoPoeRi/V6/LAlIkxhR
	BlOVLI1sWbaqvcBV4N+kfuusrOp7zgqfaFNv+KgSPQYhS6lsJ0r2PPM+YW1Rd1vK6Lc4+Q==
X-Gm-Gg: AYBFou3TMQDxleoCf+P/qoR36drH8JDaS4W1xkDOWgQ38h+WFLM5vRM4w8S9u0JOp8X
	2zMAVyOdkRv5sL2r3dqapcXzL5mRkLnmyYZQQVGonOqNMjTGJL8f2dbD3Xh7iM3Y6jrZWKAZoz4
	RBdsXfvZwgNJi6PfLl6IHSyKqD74KzKcxFLXO3KdFeyw3AO0Su9SVU1cnG2wMDpamdVDTGmLRC+
	OPNEF/iu9kIswdZMxWfxy9bqb+KreM3pxp9/2Ce5c6RZuLEMKSTQoGIPFGrznkEbijWTgu7D4aR
	MLETeQopw+1yX84rUU8WmTm/Xi+BUY1CblUFNSO7o2/vSAO3dBA6vqvURVx/dGRaTwT6rcMeo13
	oIEXM5bdgM8Z+y81KSKOknk5PSfHzoQde9sAMtFiPAJKF1zJ8fRBeyGxBw0wiYtzuFI1OjW3cL/
	cCfhbm1VKJxTIeclHaRtnOmpVKvDZ71Xe79cuGz9wQxySixoHVUOs+1+NiPxxNQeUVAA==
X-Received: by 2002:a05:701b:2908:b0:14d:ef19:246f with SMTP id a92af1059eb24-16a6309ce64mr422027c88.45.1791510561936;
        Thu, 08 Oct 2026 18:49:21 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm3500357c88.13.2026.10.08.18.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:49:21 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 09:49:17 +0800
Subject: [PATCH bpf-next] selftests/bpf: Record only the test ICMP echo in
 tc8 of tc_netkit_scrub
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-tc-netkit-scrub-v1-1-f46c07a40e7c@gmail.com>
X-B4-Tracking: v=1; b=H4sIABxIyGoC/x3MQQrCMBBG4auUWTswLUWJVxEXJv2jgxJLZpRC6
 d0bXX6L91YyVIXRuVup4qum79LQHzpKj1u5g3VqpkGGYy8S2PDKDnPjOGf2xAX+VGdL9RM5C2I
 IMk6STtQec0XW5f+/0C8oWJyu27YDgujyHHkAAAA=
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

tc_netkit_scrub attaches tc8 to the primary netkit device, sends an ICMP
echo with a mark and a priority through it, and checks the mark and the
priority that tc8 saw against what the scrub mode lets through.

tc8 records the mark and priority of every packet it sees, and the
device also carries what the system sends on its own once the device
is up, like IPv6 neighbor discovery or the mDNS of avahi-daemon. When
such a packet goes out after the echo, it overwrites what tc8 recorded,
and the test finds a mark and a priority of 0.

Record only IPv4 ICMP packets in tc8.

Fixes: 716fa7dadf11 ("selftests/bpf: Extend netkit tests to validate skb meta data")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_tc_link.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
index 630f12e51b075..3c44ee06cfae8 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_link.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
@@ -4,6 +4,8 @@
 
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
 #include <linux/stddef.h>
 #include <linux/if_packet.h>
 #include <bpf/bpf_endian.h>
@@ -119,6 +121,14 @@ SEC("tc/egress")
 int tc8(struct __sk_buff *skb)
 {
 	struct net_device *dev = BPF_CORE_READ((struct sk_buff *)skb, dev);
+	__u8 proto;
+
+	/* Look only at the ICMP echo of the test, not at IPv6 ND or mDNS */
+	if (skb->protocol != bpf_htons(ETH_P_IP) ||
+	    bpf_skb_load_bytes(skb, sizeof(struct ethhdr) + offsetof(struct iphdr, protocol),
+			       &proto, sizeof(proto)) ||
+	    proto != IPPROTO_ICMP)
+		return TCX_PASS;
 
 	seen_tc8 = true;
 	mark = skb->mark;

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261009-selftests-bpf-tc-netkit-scrub-f0eb9904d0c7

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

