Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96D375ACB
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121142; cv=none; b=riNtPIqN8jHVDf1vNsBEldpWjdipBaqOetMvhXBjcbV/f8SaKQz81ZqHkNyucCL47GzDQkxq78dZ/FD3Lf9qNBknYSrJjzyGOb6mkk3txvyr8cHM+gwh29xU0YUE98O1mt55sBVqGiEbrKjsfUve1YdJFERANYwqEv7tx/t0Ato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121142; c=relaxed/simple;
	bh=abwtmiwURinT06F8vjjjeI7AmYc7EHl/p3zOxCDzMLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XOcOpdEgkSsT7gNnW09wDvhGDtBBWJvx66dnxXNiNQ+VZWvlMPr2IFInxHooe/5P6ESpcmD55eMgBEex5BLo1thHIvqv8kwINSIIUXmNfkanFxit9nWYT6zuMlV+9dPSFSPSHXe3xnuIcPTFrSNxHITRdW9mkrXCBdQIwUOUkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaiNgrD7; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaiNgrD7"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-16ad92569b5so5747867c88.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792121141; x=1792725941; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SxVPECSRUSDaMuR9TFbDdAvOjcSyDgcao7qv4wsHXtI=;
        b=QaiNgrD7dv99piQ/CSSGSUFxvc7GrRNfy9pV04lnIOc4T5d+XMz/K65bD6qvOVaRZw
         v90RvsapfRL5ahBxXKPvURD//Obq4ybwJdjbADN8QKfrDonHmcmnvr4yia8W6JvQUnH0
         Znls3M+SmaignWug8+nc+YF9HX9oTIPjzqxTQNPNPYnQoMSWSgkQUlWKNDE8uKvr0frP
         xCuTQbx7XdB4gW6X0pmJqHxdVm0uNwNASVzjPUwnn+TnB0n3vbU/00dj7NvU5/6Mf5Zf
         wqk3wUPCgqN7CDyoWHemdbZ1CcmO9zsrmrpPfyuUlFhTcFbo4BCwpAy84eGomnEg25ip
         2fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121141; x=1792725941;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SxVPECSRUSDaMuR9TFbDdAvOjcSyDgcao7qv4wsHXtI=;
        b=BmVeMC6SajRAxrCJMaaMEuDnhpIkzyaHMAFW5SerEyotlLBthDod+EhVQoLybPi+Nd
         +bbSVple0hgrqrSrf9S1epU9zCtHHAGZ+CZnDaVwdefHP5s42EzMJxA3dfFazy1V4x2F
         u60X4pFYP3Vb9Y0GTn4Vpj5QLpq8APVspf7OhR1bGvQe1jg6TuJF6ugNW6mCCE82NS3U
         gv1b2bbaGBw+UeGjsco0SdlHutWe2hhmSHnbvoyunCm0a8iFUGv4yCfPBIG/ldgEtZmx
         bdEGHbZ1MnJnYsbuJ1g3K2LBaNlzmj8JmMRMbtGNcR4QLQn94Yz9kZ+UOXp92DJjLVrl
         lE7Q==
X-Gm-Message-State: AFq9FYK6+dBu99Rwz3bdJ3Rg4gU+OwOs1Q6Ll3moTT5W1L9EeIszGA4r
	c8YX9DyOL4iX04poCcXiDXL3PDbXcI7qra/71ZdzXy51Eo4aPnVTT4h0
X-Gm-Gg: AYBFou0G3KRaHjfwt+srpz8ZICsKMUv/DQqGpqWCq/SXcppOT88wILgyMndr48AmmA3
	4eAxzgDnV4pRGiRracV3AP+Ug9jI4922QCLGIku8+/E8Ngyj8HWmIDMG8kHPw4eNiuAD8fCWnJg
	C2x/47fs55PP7As83vFO+mzGYXokJGeo+bSkfWayjGwsNmRDTZILXgeGR7670dvrqp7DspgcGuk
	hEKnKbkJjdD7AxYHIuhtdj5qhsjJ3giOlMJ8foEU8sCHdSz1K1Xj1Oja/fp+AbJA1uiRJnO39rn
	Dxjg6hEOrQkC2eIcOGig2Svc6RwIL8DiQoxn+KI+5T8Y20LSk+Hfg10xAxTIJTy9P7bQ13vwJpo
	v4hrTmwWcYnAlnuCPT4xzjtpgzZSDLP4F19/YV9u1XCVLc34r5IItro1DdlsPFw+ys0U2kN50ih
	ioUznIAn5IqgzL2JGPtHHZfZJD80TPwmk8qfNnbsSIIKz3JM2yUxysvz23fRu1d//dgA==
X-Received: by 2002:a05:701b:420a:10b0:14d:3c0c:79e8 with SMTP id a92af1059eb24-16a5afe5490mr27285427c88.10.1792121140488;
        Thu, 15 Oct 2026 20:25:40 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75ac0fsm1758486c88.15.2026.10.15.20.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:25:39 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 16 Oct 2026 11:25:34 +0800
Subject: [PATCH bpf-next v2] selftests/bpf: Record only the test ICMP echo
 in tc8 of tc_netkit_scrub
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-selftests-bpf-tc-netkit-scrub-v2-1-b484a7ce2a63@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC2Z0WoC/42NQQqDMBBFryKz7pSJiGJXvUdxoXGiQzWWTCoW8
 e5NPUGXj8d/fwflIKxwy3YIvIrK4hPklwzs2PqBUfrEkFNeGqIalScXWaNi93IYLXqOT4moNrw
 7dMRdXVPRk60gNV6BnWxn/wG/gectQpPMKBqX8DmPV3P6Pz9WgwZdUVqq2oK4svdhbmW62mWG5
 jiOL9iH30rUAAAA
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

tc_netkit_scrub run 100 times on a bpf-next kernel with KASAN enabled,
x86_64 VM with 32 vCPUs and avahi-daemon running, before and after this
patch:

            before                                after
  outcome   2 of 100 failed (mark and priority 0)   0 of 100 failed

Fixes: 716fa7dadf11 ("selftests/bpf: Extend netkit tests to validate skb meta data")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Check the packet in tc8 the way tc1 and tc7 do, with
  __bpf_constant_htons() and a goto out for each check (Daniel)
- Add before/after data

v1: https://lore.kernel.org/r/20261009-selftests-bpf-tc-netkit-scrub-v1-1-f46c07a40e7c@gmail.com
---
 tools/testing/selftests/bpf/progs/test_tc_link.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
index 630f12e51b075..917d5e6c84c6f 100644
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
@@ -119,11 +121,21 @@ SEC("tc/egress")
 int tc8(struct __sk_buff *skb)
 {
 	struct net_device *dev = BPF_CORE_READ((struct sk_buff *)skb, dev);
+	struct iphdr iph = {};
+
+	/* Look only at the ICMP echo of the test, not at IPv6 ND or mDNS */
+	if (skb->protocol != __bpf_constant_htons(ETH_P_IP))
+		goto out;
+	if (bpf_skb_load_bytes(skb, sizeof(struct ethhdr), &iph, sizeof(iph)))
+		goto out;
+	if (iph.protocol != IPPROTO_ICMP)
+		goto out;
 
 	seen_tc8 = true;
 	mark = skb->mark;
 	prio = skb->priority;
 	headroom = BPF_CORE_READ(dev, needed_headroom);
 	tailroom = BPF_CORE_READ(dev, needed_tailroom);
+out:
 	return TCX_PASS;
 }

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261009-selftests-bpf-tc-netkit-scrub-f0eb9904d0c7

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

