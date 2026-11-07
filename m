Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022504;
	b=B9o1OW+RVzgKvxIlPtiV0A2mtZVUKQXDv2CIdtbY6ZX4c6HSb+VTrBiAYPzQHp0MAEC5
	 68Q48Y692yvfKP6J5xCg98qHHr4tKoo34Rwd9lq6F0POlxqfNa4uMtxWgsbKRUUxH4puX
	 PXhdHHejSIxMk0lS9Af+r2vItHjIlOQ7UYnCznh7drLgBMTv+KpBJlhyfLTnZFtGPYgpj
	 srxNw5DocWmbzKXaCsHUDm5GfWrVS7488kqjw85ZnAMjATvNQ5XGIqVsv+uSeQJK2YU6P
	 EWDRXX1gjepD6Y3ry55FZvox/OIVZguUct2nVVaAZ9jIS1AlbMmVSNb5hG2e9yCLJAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y2Cswb7mk/fWftpb46x4/HWwEQMmKQ5VhCwrWS+t9Nk=;
	b=cxPy+pVH0DJGjsObkqe7WawvP9Z4djo2WwG6GH5RNSmJdCtVfAg8fXtRFjMy3c0vy4nq
	 L4BJ6iOkzBYJXeK+8BhBPKnPDyAlXU6zR2PeUShqI3VujHVC9ug4HtQJWavtLLzN06r57
	 lm/rOCgx9VXBQJF1LhbnCC/PDlposOU/MU565j+yXNraY7bDp8VWDnvD/ugpb+H+OZMc4
	 42Nu9UgZdzzjamlREmGVUy8vs9s7RiHM1h11Yu45KHQ8iq/XT3/Rfw8BSMQpIIAVHD7Ms
	 /NRKltTznIbEUtR2T6BGeY6ZAncZjwYmYbNWCYZbW/izMI/RXWvaCg/eL05H2ZBD+8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="TPsp/agT";
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458B606A32D
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2458B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TPsp/agT
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so1491803a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794022502; x=1794627302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2Cswb7mk/fWftpb46x4/HWwEQMmKQ5VhCwrWS+t9Nk=;
        b=TPsp/agTern2Jjik6AxsBYARpOCeOflkig+YBk4Z6XMaQW4d+YOCuPhnay55gc50XA
         fOG0x2AfPerRl6VXRPD/qqWNwMpW4Xw0W0Zz7gxsGzvLEEiMTLXJ/n5lnPlGiI+u7JO3
         QnDxl9f0vdxuhPMci7OrqLpsCCjIuxSYVgN7RfXw5f4Sl5hVFof6LrBqnD4EMIXMhFpv
         JmFPKCiRAHAkCNiJ++34KDNVkh0h17NouO6KXL/lfdrjatFgGgQ6Z09gF2kW7Au1+KY1
         9eE4+IUuArTGFS1ZasTJ9rZWoZ0RgmuOGmhfkT1KEUlv9IrNJLUt/LSCpS9m1+jFgobA
         7Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022503; x=1794627303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2Cswb7mk/fWftpb46x4/HWwEQMmKQ5VhCwrWS+t9Nk=;
        b=KDia7r4XP1mfL1fMImicBD0clvt2u5dugRH9P7mv73pucl3AS5f92LI4/nU2UZGe5C
         XY0yQ5I31lqYI7e4cHjKrE7TkXThcqRtXGiGLIfgL2ofaxBD/T2AS6LnLPR0gE8poni3
         AT9A8WWi/mMGTpdkD35vqLeNFbsFgybiRd3Ym59Lhl9sIMaUX+3oWRSJ11+N6fDWrR9U
         1fSRRg0ljCGmFnYelBEficmGAc+diSNPzwwEPHM6a90wY6/EwtGZRNX0ja137RsBtOsR
         E5o8koPy+7Oezl8Hb/n2pdc47z8Aj9w9BQDM81s/N3KvHRw/sFk0sli/UZFAAU1eNQ9s
         y2VA==
X-Forwarded-Encrypted: i=1; AL+hErHSxTQoNcKCMUpMyNvJ5BvN7ZpEljuGZnVWpao85BCAk9cbrHg630H/wGmFYv1uiMHyMzw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jObqpFRsY4gCj2CUWNfSo46i5RiSqkcSG/nZlwt5asHGeE71C
	gknRZ1Jz4OtsalvoZ1gPB/H3L9qtgGYyeDx4iIM81Rkq131VaU//VZv5y50yi8hR+rQ=
X-Gm-Gg: AYBFou2paTDvOpkW0h9L6NKuLdyBwJix1Y8XrgWlqWEckHD8N3f0AMiX+eXwDAOkEGK
	QY4smJ7hLyPURooLF5dc1wIWPM+WUO6NJzYfOWPbBo6QowvmyWbZjyHkOk83SmNL53TFNohgtj4
	Qazi2PjnHAU7AyoD2Grcb41NgHcvc9CCJMLsYksHj0W1uAdRymAn+e57K7ecYJL/vtfsY0MZJxO
	x03jmYPdt7JkuyryjsI4Az0XiP/4qzNXMIsvtNzJsZCulVW4f0npQ2vuohDzFQ1wEX3t4Gfppfn
	1v0z9zEFKkqe5bhrseIJBwSMZcazyoHRZOrqiHSJRiGlYy7TDqxKS7evMdHnxML0Q0eOf/Ewat1
	vcR/XHwjVgs12fMwfnsIfgTNerl7J5BjnJ1kNpuohofQh1pV6l/VaL984lvzhmcDhBPcVlTSZin
	7P6vEOf8bc0p9w5TmwZauxisrGTbOJS0YHLQejiFELdxE6LcZBQnLDhcEEwmS9YdHn5NdtOp2ce
	v5Bgt1okvKeYJGsg0Urtay+ZF9kMJ7rwBjLBoOKhq4qlyH79/4UxKR02doDmMoNcel62keprDL1
	2QgwlFVhrBOAwxZMN887oRf3R9M0+/6dURW0gbE03QrMJDAZrzSbOLPDroJigkY=
X-Received: by 2002:a17:907:ea7:b0:c46:cf73:bdf9 with SMTP id a640c23a62f3a-c4d35446bd9mr357150166b.21.1794022502674;
        Fri, 06 Nov 2026 19:35:02 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3562e00dsm121104166b.21.2026.11.06.19.34.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:35:01 -0800 (PST)
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
Subject: [PATCH net-next 8/8] selftests: net: tx_extra_headroom: test veth peer at creation
Date: Sat,  7 Nov 2026 03:34:27 +0000
Message-ID: <73b9d23a4190cdd02e89d3a2ce8a1a21ad5feadb.1794020868.git.tianyi@cloudflare.com>
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

veth_newlink() parses the attributes of the peer from VETH_INFO_PEER and
passes them to rtnl_create_link(). So one request can set
IFLA_TX_EXTRA_HEADROOM on both ends of a veth pair. test_newlink() only
covers a dummy device.

Create a veth pair with ip and give each end a different value. Then
read both values back with YNL. With a different value on each end, the
test fails if one end gets the value of the other end. The YNL rt-link
spec does not describe veth, so ip creates the pair. Skip the test if ip
does not support tx_extra_headroom.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
The test needs the iproute2 patch "iplink: add tx_extra_headroom
attribute", which is sent separately to iproute2-next. With an older
ip, the test is skipped.
---
 tools/testing/selftests/net/tx_extra_headroom.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
index f94eb29a25d9..8a2284f1b343 100755
--- a/tools/testing/selftests/net/tx_extra_headroom.py
+++ b/tools/testing/selftests/net/tx_extra_headroom.py
@@ -141,6 +141,19 @@ def test_not_inherited() -> None:
                 4, "vlan needed_headroom")
 
 
+def test_veth_peer_at_creation() -> None:
+    """ip can set a different value on each end of a new veth pair."""
+    if "tx_extra_headroom" not in cmd("ip link help", fail=False).stderr:
+        raise KsftSkipEx("iproute2 does not support tx_extra_headroom")
+
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add veth0 tx_extra_headroom 256 type veth "
+           "peer name veth1 tx_extra_headroom 128")
+        rtnl = RtnlFamily()
+        ksft_eq(get(rtnl, ifindex("veth0")), 256)
+        ksft_eq(get(rtnl, ifindex("veth1")), 128)
+
+
 def setup_veth(peer_ns):
     """Create veth0 in the current netns and its peer veth1 in peer_ns."""
     ip("link add veth0 type veth peer name veth1")
@@ -307,6 +320,7 @@ def main() -> None:
               test_survives_down_up,
               test_survives_netns_move,
               test_not_inherited,
+              test_veth_peer_at_creation,
               test_push,
               test_peer_xdp])
     ksft_exit()
-- 
2.56.0

