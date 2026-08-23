Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BBB372B27
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787480309; cv=none; b=P3hWbgmZkkbhCe+mwztnYXasEflRaaeJn1BlqVisyumqP1hBpEOBFoLLFsUnakgBJVjhR66ozOXDVpSJPCsIIooAoT4WCehIkaKVRPJvPcbXy9NN71iqjU6kA9q0VD6qEKUTRFbeqDJKkQ3P8ioivfyJhwPxMYXnW4+yKeCFOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787480309; c=relaxed/simple;
	bh=S8BPB7Qjsw6r96pi4uoQRaT+P0oPrJHiJIl1kunlkxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPCI7Xeuhl4T8xMDOrOoyLRiUjgK9BrFqxtla2Mtgpa49ttKsFwBZQ+40Cr1li4XVNC8/oPA68EvCaVzGn46PZw8Uxm7orSi5S8q2Tbu8FjYvVGYn61uH6DE7svrU6vK7wGuqLcR+Pn6FJebnWZQCM/F0hEmKRa5e6FteZY4Jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhRcqSLQ; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhRcqSLQ"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3931e624fd8so1367680a91.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787480308; x=1788085108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSNVncEMgEraytLD+WR3MzrZH+OTuZ38jo7hC58bHW0=;
        b=EhRcqSLQh+BNU1/FNj1zBNreLFib369AjA/8JanTOi+6bmRpIubYUad6T3r0kpFiW7
         OmAImxPrJfoZwUPNQmqQX+aoKTY85NGFnWeKvCpcdYrcn1OXwAgFzDjUqtg4wcwWcwh2
         twm/d38q7bcpRlke2WC3aYtqB7khy7Kyzjp0xDL8Q8QclKnFbB9bN5dlfci+4WteQCFy
         7U1xwKzaQISthLZPB1EP8dXzg8taQjqg3Ba4yyp5X013+UYDVU5RdNyq6Gqm+JlKBjkX
         kxM3dqVdXXZk7vrVoK1zFhfdZfpSNuxBEapigP8MSbCs4GxEMcHz9EtGfz/4lq9A4/Kf
         UREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787480308; x=1788085108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSNVncEMgEraytLD+WR3MzrZH+OTuZ38jo7hC58bHW0=;
        b=Z/4Y255l0mZAtbbywuXTMkYuyXtMEaa4GsM0+qi+qdT5+IXloqgLLi3yvOeFwzTCTA
         2Tl0hnLbmXJWnqqtsLvbsAu3N1w+wdpkGM4EVK1VDg0Np3YTn1KNFTbAf3FOfhKenZrV
         0qlnnMoBuC4PKKbNEsfXuWXmIKIUW7m5LSvXd2WwxZh0j5bdsxvDfmg/r2DIAkpb6EvH
         7gi1pLeSN5RTxJ9A95UMGTXSAZ5rYpiyifvjPLoqntc+Sull3KyYpTeNOhnWx5LqqCaP
         VNZCcAVpGOX85QCzIgrLH4uBO7CiugsJ5JjQeMhfTTQbnHAddAnnyezyh61tZa2q8Cg2
         79zA==
X-Forwarded-Encrypted: i=1; AHgh+RroPcgO8tBy9xxaTkz1Qjg3MH/AA3fEVoiUUJzi6ZI2nTyrM5GJF5Z4RR1Amn5EoWrN/pU=@vger.kernel.org
X-Gm-Message-State: AFuF++lUkV1JFkJ0c2Lq2+iYPABUc+7t9pAkz95e4AaNnGTPhGPFYxV8
	eMpXpy0fR6Tcen9oFg31AZ5OvI40f5ynIZWPAO3edqy5SW8gamznIMS/
X-Gm-Gg: AR+sD11ccH8AjynrL7JDXBK/dxYGpV2EQHS37N/FIUfvpCyDh7SRcaWnxoGKDX90rXJ
	vS2w+sWhJUclrC5bsyYPu22r1Mbq/5g4mFk4sDxfNLyu6PwS/tiMbqs6BgNyY8V0VDEdfvE8Zxm
	Kv6aZSPQ+9tB3vWzomiPo1CaswG88/MNfdxZRDN45Gb5FES5peFDfmuwXUhZ9Lrpyl89Pi9mz9t
	OjOXoXAYsCiT1MZW0FYhMJhFOX+NyFO4sXN7GmP9q01NpSI/QDnBB4tdneD1iR81AkTxLlkFLFI
	GAAzyqqQMTgF6aDrrFKjjA5dSiC4FOUjYbvSipX6FUKEzZCgRoqZMV2xrJ9KXEFGPCGvg4JAZs6
	Sn0TVp/JEtDC0ZY6KlhMMv4Tsu1oOxVXdxs83jVzDZrtVQiYCrAwcvUg3KslCrlmOKaY9GKssum
	GqGuKbL0glZKO+j0knmLAFUJH7bXlD16N4KytdFdLZc4yYVVu362dZ7QMddchHdtNQ4Jsuk+lEb
	4xYjzR+ow==
X-Received: by 2002:a17:90b:530c:b0:395:5404:95 with SMTP id 98e67ed59e1d1-395c35516a0mr34092527a91.12.1787480307838;
        Sun, 23 Aug 2026 03:18:27 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([2409:8a55:94ee:7131:6dfa:11e6:f115:ea42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e42cc144sm5471603a91.0.2026.08.23.03.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 03:18:27 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joe Stringer <joe@wand.net.nz>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/1] net: Don't deliver IPv6 packets to IPv4 sockets
Date: Sun, 23 Aug 2026 18:17:19 +0800
Message-ID: <20260823101809.26802-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sk_assign() allows a TC ingress program to attach an arbitrary
hashed socket to an skb, without checking that the socket family
matches the packet's network layer. As a result, an IPv6 UDP packet
can be assigned to an AF_INET UDP socket: udpv6_rcv() steals the
socket via inet6_steal_sock(), which also lacks a family check, and
queues the IPv6 skb on the AF_INET socket.

recvmsg() on that socket then runs the IPv4 udp_recvmsg(), which
interprets the IPv6 skb control block as IPv4 IP options. When
IP_RETOPTS is enabled on the target socket, __ip_options_echo()
copies up to 153 bytes of attacker-controlled data from the IPv6
Destination Options extension header into the 40-byte option-data
area of the stack-allocated optbuf in ip_cmsg_recv_retopts():

    BUG: KASAN: stack-out-of-bounds in __ip_options_echo
    Write of size 153
    ...
    __ip_options_echo
    ip_cmsg_recv_offset
    udp_recvmsg

Reject sockets whose family is not AF_INET6 in inet6_steal_sock().
An IPv6 packet can never be legitimately delivered to an AF_INET
socket, so drop the stolen socket and return NULL, letting the
callers continue with the regular IPv6 lookup. When the socket is
refcounted, release it with sock_gen_put(), the same type-safe
helper sock_pfree() and sock_edemux() use, so the release stays
correct no matter which kind of socket a future BPF helper allows
to be assigned. This covers both the UDPv6 and TCPv6 receive
paths. The opposite direction, an IPv4 packet assigned to a
dual-stack AF_INET6 socket, remains allowed since that is a
supported configuration.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Cc: stable@vger.kernel.org
Assisted-by: GLM:GLM-5.3
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 include/net/inet6_hashtables.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 2cc5d416bbb5..b39e59efac8d 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -115,6 +115,12 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
+	if (unlikely(sk->sk_family != AF_INET6)) {
+		if (*refcounted)
+			sock_gen_put(sk);
+		return NULL;
+	}
+
 	if (!prefetched || !sk_fullsock(sk))
 		return sk;
 
-- 
2.43.0
