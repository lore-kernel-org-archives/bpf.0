Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4F37C906;
	Fri, 10 Jul 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706736; cv=none; b=eyZPk/aZgj2DJQEVdG02do9NDJc6iQIkbad68tFzrwZpv2YpVw297u3C5VV9HTWWmSJYGW+IeFVYrxWVGObq0pOMHkk3yULnUwdgCNqrKahGq1GvuS4NWC/xkFnYyINfw/ouaxTxVDAdAH5QNFTpT4jXqoWY42obDRQ2iUzDeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706736; c=relaxed/simple;
	bh=+02xMsEzYQhTIPnJ8zKzodVzMyFz6JZjuiiF1KJILz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mladaZ4TaK4d2FWr4YHkdLGlQJjsPg1QWYAW7BPGeZxrSY3uAOq4WIUWKFwnbp0JhhYLRBXaaQwPD7DpRlBDI5vY1KUcdZZb7nf1AYITT7tdjO9enaj9ZzBPVH4b15vLHJMBuQV7E2PHzzY3VzYmWORkE2O2jHqGswGe7jTilkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXySV4gN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXySV4gN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3C91F000E9;
	Fri, 10 Jul 2026 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706735;
	bh=RZ1C7cejQoOIpWusJN2i5Bj8ujw9QzmP3ENC6NA6vFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JXySV4gN1ipI4PVPBNL2m8WnXBDTX49PckAfXSNHC4Uin91BdXlroxbotgzYowlkH
	 eKC9rprjLjiW5rYof/12NBWQr74Ny8cyhTmeckULJ0ViBwQwn++LktT8Svls5JLvuN
	 70wR8cikrsM7igVxGojhcx6ICxHEH3UQX6k1Csx31oHn4q2t8hP1J0EOKixGUFjUOe
	 SZsEDQ0HWB+0c30S5W8jffNVaM7E6AfC3l4MllsEDmX5FLFmcDbTwaW5r+gDj/qSu4
	 Jt4eY7fcTMZd49YpwWIxn0/gKOQmEcmjEA+o4uGCLfYzQETlGw0x2ZDTs3yrAWauIm
	 yts7FNMqmlEMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Jul 2026 20:04:46 +0200
Subject: [PATCH net 6/7] selftests: drv-net: add missing kconfig for psp.py
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-net-sft-fix-containers-v1-6-a2915c294ef5@kernel.org>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>, David Wei <dw@davidwei.uk>, 
 Wei Wang <weibunny@fb.com>, bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+02xMsEzYQhTIPnJ8zKzodVzMyFz6JZjuiiF1KJILz8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLICTSJXNhUc3VVWYxf4M26p1r1DXZ9el+bzrCoINWvdl
 1nnEszeUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJEzlowMjSmSJ9zfJakvCzds
 eb5cr676upXLIblHU6bvsHt4Prk6hpHhYRjnswDHFcGTO79Odt/6/Ujj6u77id7ND275dzn0fzv
 MBAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This psp.py selftest was failing on my side when only using the
drivers/net config file on top of the default one -- the recommended way
to execute selftest targets.

It looks like some kernel config are needed to execute the new tc
commands.

Note that this was not visible on NIPA, because these tests are executed
with the drivers/net/hw ones, combining the two config files, and the hw
one contains the missing ones.

Fixes: 3f74d5bb807e ("selftests/net: Add env for container based tests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: Wei Wang <weibunny@fb.com>
Cc: bpf@vger.kernel.org
---
 tools/testing/selftests/drivers/net/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 91d4fd410914..2070e890e064 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -4,6 +4,8 @@ CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_INET_PSP=y
 CONFIG_IPV6=y
 CONFIG_MACSEC=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_CLS_BPF=y
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
@@ -11,6 +13,7 @@ CONFIG_NETDEVSIM=m
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
+CONFIG_NET_SCH_INGRESS=y
 CONFIG_PPP=y
 CONFIG_PPPOE=y
 CONFIG_VLAN_8021Q=m

-- 
2.53.0

