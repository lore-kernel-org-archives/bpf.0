Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022491;
	b=ZHZWOTceYPAS7mjSQh1rVWTrMy27PJTHyCHESw/aGP8XANp17ZeUdTh/ms8TdQcWBUw/
	 igrv28+IpcApVELfJJrQXoWuJtpAwcv5tItL1O9+J/fQGdtr/ZaeOrykV44L3krYvMPna
	 gco6Rhw3uNmF1jPgijyfs3mwUcUQQjv9Sd2F5DsP60iEo+bflwfv1MpQQNwUsaCJ/hiS1
	 nsGJxg0jOOgrHgs1sEewIKFxvbU2sm+R36zAcOTPtDXcNbjUcBbd9lRcqewavVj2rpCmS
	 EgOAmkbCZ/+7xU1k8C1k+UNW0G2YjZhz29ulnfImT03wBN2U/BZsEy9ZXUTJ3geKRPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=phfdfz8PzHsM0KuP/80pAKM/8zTKfUk4DuybrzxV7UA=;
	b=tboBY2lr4Sk4Udwf4Aq1dcuqIITxu8+lUgJqiBTxYo2a7NG6TjUFL9FcR/jZ/NY5LfXb
	 xzj4zmb2dW0VfKlM3j+op5QQRKmACyb0mnBWshihL+/VAw/xi6ieHkmzHfYIH83EWpDV9
	 8vsuQl4fgwmZNbhCAR4U5NFFqg2pTdMtnbNdv33+vqqJe6TIv0ZrxNanPRhHRfhTupCmZ
	 HIF7S41kRA8gePjAkr6esWkbH4sEIIqoRycEJt9iwhoDVTlCqB3FTk3m2XfZqb6OPXKXb
	 7v4FEXWVBT7p1jyF28NiFmsMNaYUNonrpCXypV3tgXEnLUsPB7/ebvbEPlSTZolFWaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XEerxCny;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA34606A32D
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA34606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=XEerxCny
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d28f75d62so168855866b.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794022490; x=1794627290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phfdfz8PzHsM0KuP/80pAKM/8zTKfUk4DuybrzxV7UA=;
        b=XEerxCnyjwKcqVqFSagvaAZbHGgSLll5tfTp9WFV+MtB/Xamb/ZOeg7o0c4w0XiEMa
         xMLAkybvutqAKzAPJc3w2D3aLzm53kJswdbjIfF+dsxRxA1fFKLAnFY8qysufmZxqfyF
         ZeBZxaxgZ64egi+JXBsgu+x2yoPK9UKCTuPK3pOYRKOmAIULnss7ZcMXfrmG09bPPOQB
         7j1Oneomtfm8iwJxAb3JPGtNhwUlY9ZcY/9l4XHqDYBv9JIcHC4e+O112WzdidDsC9/W
         EILySWchV9M8g/upHyBA2AGTKppoPkzM9R3XXraFPUnC7o74Ncta280wQseYliN+SdlX
         /lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022490; x=1794627290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=phfdfz8PzHsM0KuP/80pAKM/8zTKfUk4DuybrzxV7UA=;
        b=yVW8/kn7N0qfU6C8NGQ4swIkDAfhgXrNChMhQFbi8dMu+dLdk3ROy2bPMI9DraXOls
         LPLup5TWio+nDt0l7PjxpeAHYh4quppQPXWa7+HcTeqhw7QAZEsWaXkyUrmCn3TWGQHx
         fTJ8d6tCgKjf8HoHjTp05NmBm5z9R8LCG2jUUpnmS0O1dpINrhxZlxR8pynofZTCnQuT
         7vOd0wP1p2Ag+GKcOy0Uvw3O6MeB6d2EUDRMRHMC4/mJUhyv7vBdlXCzkPMnOrhPWLp9
         nwd1FZbYUuGazHGc5RKNNN0D1G2IxzEwUroMzlDvzhKT4mGLYO9wv5zOhfvcz/HnzVGi
         qX0g==
X-Forwarded-Encrypted: i=1; AKwUvBxqzMM4+asXdbJKbxgQLHNlwIr6wVZmhv2Rb3+sefJhPNknni3osTk4yIqyUzobb91jrMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Za4PVy+EKpf/09O+3Uk8NzEkUgT6pasHTeoA+5/4V6O/WRsmL
	fNcHgTZHSgpd1LqGS/60W5lzmeR4nNydFU++0mRemAy05bkgWO76rlMuZUMYF0jr3QU=
X-Gm-Gg: AYBFou3JKisMuh5C41Sm2FQ8SO80bTgSuGpswaCG8wyqvrsgNSavUw8TL8DpWHnLr+A
	SMT910/6AR07rFyzv/FM+Ta7NZwkYLAvJkyhMxX3ttu8RMn9q/9tZ9gg/h50RH8L3WoQcH2WZer
	whohRQ8M7J7WUljOvGFCGCzD70Ua131feaswdvnPisV3TtjI5XZ69rt0NYDpid4FDGAu2NlELGd
	apx2Noufglk3/8mFCn/krvX6Bv0GygRwpXirQpitSmTpqo9IG7GovPo3JPiYGWgEvG1ft/shyvK
	aBO1IzM14+863afSMXP0GWOsnJN585VovwgylArgnWnJ0XQYsTEext4T4x2oF/tqEZDRcAAJ7Wb
	IlMfudXzfIgZsFVMJDC1P6gtJxYLWMwm6QzMWvmYznbOcV7twBLkV6hCHVubrPudgRqcvdvAkPI
	5cGE4X9bbnJtNhXDmBljG4uqOnBBAFLViXIO8fsapU3vFUpdxwSH9rZaPkxSgRj/GG7foJyfTZ7
	D4oQIfR8Mys/AblTNZ7pO+AcQXJ+54X+MDHQ/Upp5baAXe3rtmntFZagUWqIa9mH0zl3y1qgmFG
	hKa2r7q7eeHVOziNGXonHCN/1eNMkY/VdEIScfkiKMvlm4K9ypvzQU6EgL3ToqiUQDpaWoQlira
	ybfmaTaYM
X-Received: by 2002:a17:907:60c8:b0:c34:1ed:54d9 with SMTP id a640c23a62f3a-c4d344a872bmr442362766b.4.1794022489809;
        Fri, 06 Nov 2026 19:34:49 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3562e00dsm121104166b.21.2026.11.06.19.34.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:34:47 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 4/8] selftests: net: add tx_extra_headroom test
Date: Sat,  7 Nov 2026 03:34:23 +0000
Message-ID: <0a1936109734e9bbc443ec34744112a7f6a83976.1794020868.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794020868.git.tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
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

From: David Keogh <dkeogh@amazon.com>

Exercise the IFLA_TX_EXTRA_HEADROOM attribute through YNL: the default
of zero, setting values up to the maximum and back to zero, rejection of
a value above the maximum, supplying the attribute at link creation, the
change notification, persistence across link down/up and across a
network namespace move, and that a VLAN created on top of a configured
device does not inherit the setting. It also checks that setting the
attribute does not change needed_headroom. On a kernel without the
attribute, every case is skipped.

Signed-off-by: David Keogh <dkeogh@amazon.com>
[tianyi: skip on old kernels, check needed_headroom exactly]
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/tx_extra_headroom.py        | 147 ++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100755 tools/testing/selftests/net/tx_extra_headroom.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 9180b9bec515..4a931c010762 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -121,6 +121,7 @@ TEST_PROGS := \
 	test_vxlan_vnifiltering.sh \
 	tfo_passive.sh \
 	traceroute.sh \
+	tx_extra_headroom.py \
 	txtimestamp.sh \
 	udpgro.sh \
 	udpgro_bench.sh \
diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
new file mode 100755
index 000000000000..153384a1fb0d
--- /dev/null
+++ b/tools/testing/selftests/net/tx_extra_headroom.py
@@ -0,0 +1,147 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Tests for the IFLA_TX_EXTRA_HEADROOM link attribute."""
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
+from lib.py import ip
+from lib.py import NetNS, NetNSEnter
+from lib.py import Netlink, NlError, RtnlFamily
+
+ATTR = "tx-extra-headroom"
+MAX = 512
+
+
+def ifindex(name):
+    """Return the ifindex of device name."""
+    return ip(f"link show dev {name}", json=True)[0]["ifindex"]
+
+
+def get(rtnl, idx):
+    """Return the IFLA_TX_EXTRA_HEADROOM value of ifindex idx."""
+    link = rtnl.getlink({"ifi-index": idx})
+    if ATTR not in link:
+        raise KsftSkipEx("no IFLA_TX_EXTRA_HEADROOM support")
+    return link[ATTR]
+
+
+def set_hr(rtnl, idx, val):
+    """Set IFLA_TX_EXTRA_HEADROOM of ifindex idx to val."""
+    get(rtnl, idx)  # an old kernel ignores the attribute
+    rtnl.setlink({"ifi-index": idx, ATTR: val})
+
+
+def test_default_and_set() -> None:
+    """Default is 0, values up to the maximum are accepted, 0 resets."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add dummy0 type dummy")
+        rtnl = RtnlFamily()
+        idx = ifindex("dummy0")
+
+        ksft_eq(get(rtnl, idx), 0)
+        for val in (1, 256, MAX):
+            set_hr(rtnl, idx, val)
+            ksft_eq(get(rtnl, idx), val)
+            ksft_eq(rtnl.getlink({"ifi-index": idx})["headroom"], 0,
+                    "needed_headroom")
+        set_hr(rtnl, idx, 0)
+        ksft_eq(get(rtnl, idx), 0)
+
+
+def test_reject_above_max() -> None:
+    """Values above the maximum are rejected by the policy."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add dummy0 type dummy")
+        rtnl = RtnlFamily()
+        idx = ifindex("dummy0")
+
+        set_hr(rtnl, idx, 128)
+        with ksft_raises(NlError):
+            set_hr(rtnl, idx, MAX + 1)
+        ksft_eq(get(rtnl, idx), 128)
+
+
+def test_newlink() -> None:
+    """The attribute can be supplied when the link is created."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        rtnl = RtnlFamily()
+        rtnl.newlink({"ifname": "dummy0", "linkinfo": {"kind": "dummy"},
+                      ATTR: 64},
+                     flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL])
+        ksft_eq(get(rtnl, ifindex("dummy0")), 64)
+
+
+def test_notification() -> None:
+    """A change produces a link notification carrying the new value."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add dummy0 type dummy")
+        ip("link set dev dummy0 up")
+        rtnl = RtnlFamily()
+        idx = ifindex("dummy0")
+
+        rtnl.ntf_subscribe("rtnlgrp-link")
+        set_hr(rtnl, idx, 192)
+
+        seen = None
+        for msg in rtnl.poll_ntf(duration=1):
+            if msg["name"] == "getlink" and msg["msg"]["ifi-index"] == idx:
+                seen = msg["msg"][ATTR]
+                break
+        ksft_eq(seen, 192)
+
+
+def test_survives_down_up() -> None:
+    """Toggling the link does not reset the value."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add dummy0 type dummy")
+        rtnl = RtnlFamily()
+        idx = ifindex("dummy0")
+
+        set_hr(rtnl, idx, 96)
+        ip("link set dev dummy0 up")
+        ksft_eq(get(rtnl, idx), 96)
+        ip("link set dev dummy0 down")
+        ksft_eq(get(rtnl, idx), 96)
+
+
+def test_survives_netns_move() -> None:
+    """Moving the link to another namespace keeps the value."""
+    with NetNS() as ns1, NetNS() as ns2:
+        with NetNSEnter(str(ns1)):
+            ip("link add dummy0 type dummy")
+            rtnl = RtnlFamily()
+            set_hr(rtnl, ifindex("dummy0"), 160)
+            ip(f"link set dev dummy0 netns {ns2}")
+
+        with NetNSEnter(str(ns2)):
+            rtnl = RtnlFamily()
+            ksft_eq(get(rtnl, ifindex("dummy0")), 160)
+
+
+def test_not_inherited() -> None:
+    """Stacked devices do not inherit the value of the device below."""
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add dummy0 type dummy")
+        rtnl = RtnlFamily()
+        set_hr(rtnl, ifindex("dummy0"), 224)
+
+        ip("link add link dummy0 name dummy0.10 type vlan id 10")
+        ksft_eq(get(rtnl, ifindex("dummy0.10")), 0)
+        ksft_eq(rtnl.getlink({"ifi-index": ifindex("dummy0.10")})["headroom"],
+                4, "vlan needed_headroom")
+
+
+def main() -> None:
+    """Run all test cases."""
+    ksft_run([test_default_and_set,
+              test_reject_above_max,
+              test_newlink,
+              test_notification,
+              test_survives_down_up,
+              test_survives_netns_move,
+              test_not_inherited])
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.56.0

