Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A794D0A03;
	Fri, 25 Sep 2026 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351759; cv=none; b=GApT6pMCKTW4hltUKv5K9Gei+Bp4wL7u5BCqvtqH+LiNWSN9kgZuXtCfTYD0VMFk4sYVsIx79CQsW2uzmZa5NrqXjedriohXlSN3kkFKjOn4gXxOs1zJtZC/X+wWL94k9qZW/uL5AcVGvxo5BYCRgrDYEpfE9kEdY4UrpFpd6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351759; c=relaxed/simple;
	bh=lfVpM8IpSFrl9WMznW6hrKS42NBa9P3vmWzVF/t/mMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D83Mdtle6gH1RVjI7+5ZdQZRVHvj0l0Qg8tzEU6itFKx16xfdFwZStwO+MMpzXodeEpFdsKZKGUBkt5OfraXYOIPETSwEzzcMor8kilgLe/W/1ytzy/ObnuMKvFWFn2+d4h7ZKv2qHJVnYjZ5W4hYSiNwmRZEryt9I9sJwo+0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=U4+izewm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="U4+izewm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=3u8gQhNavMLejnFPYpNP2xX9INk7nYDpIUTibp7qRoY=; b=U4+izewmXDHRTOU1zF9MmQHGpo
	NEX7fFdWzA9JHf+JZ/dLOLELVsbyyX5HyAaIact1j6xeyXeglG7R5eQBMTQKvBZ9cPX2hLw3dtYxL
	f5rzMRGZiQLh/cP5BAgqJgtnjU02w4SzoXxG2R1DSvGC3cLhzl3tBq35RE45YBXSauAH/s+0yle96
	VymHGmhUDDo9bbBIJo8drHM1CQ/ztQ2yTV65ZY5rSLwV93Zb3W6LaJ1dtKA+SCuhqyiOEqiTfPxVb
	cU2f3wtYsNHKUYlmuwgryKBdHPANk5j6q7ewZ3PxVkTxHwKemlCd84MsJDxaf9wapn+2RlnCNebgA
	Nz9Zd/sQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA8HA-005PlE-0z;
	Fri, 25 Sep 2026 15:55:52 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 25 Sep 2026 08:55:16 -0700
Subject: [PATCH net-next 1/6] ipv6: reject a negative optlen in
 do_ipv6_getsockopt()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-sockopt_expand_out_v2-v1-1-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=leitao@debian.org;
 h=from:subject:message-id; bh=lfVpM8IpSFrl9WMznW6hrKS42NBa9P3vmWzVF/t/mMg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqtpl6DxssGJpfQP9/LQtRp4EL37kSDNXrV5A6c
 idTuF8jmV6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaraZegAKCRA1o5Of/Hh3
 bbZcD/9m/HiC9eumuP0yv7ayS5yvRrvYBFG7LqUCtP4VHnnOTd0u+DT/nlbBPzfFbZM0mKgDcIv
 x9AESi1zDKdT2wdWJcbaadNfTi9W8MLzRQ/XGe6uyDZ/BVYDCbDTaQ7fw9Le0joF0bulFGG7usF
 O6NPIZONYzM2P9fpRkiPyh94lrJAmPF7W9dqrcFYPkmQHUXiK3YvDFYrQt4e86aNB11O7AkN4BG
 Tmzq4A+Ib5sC6HdxhM6YmXHQfvkRO/guf3GT1LBdwey+U/D+SDvYSWqWQ8x49p6v72hR51BPq+D
 FER4ce9LnMkYO/lwjfNCQPUNL1/ojLl27WGb05mIf9HLBe+6tqNVp0FmX76uk53l34ChU7GEoSX
 Je8JaBhYDUG83gS/AIj9xL7ayo8MPJ3V5sw6s3/TvxhC2EZk7HKyQQRIKozZGHJsrKXzLPcGrJy
 8OaOqLyx0geHAHvjZozBUEln399j2s2jKe6g1pTChMGnxjXzyZuzXKjfdiIYEYFVOdUnXl/SYkL
 7Tvhsq0LmO5ANKVF1wFp5rmCIK6HndpLCf2F7vTpPOfWwuOY4YWybMGdS4xXO1lxGXIH4pIgHnK
 baKJgYE0p94CaTlNYjdraqJZqkvAql4xI/S/db4DbdXC1LkSnzNVEILOM8aAS0cl3UpYs3Y+W8B
 clxVRjhDy+gpXmw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

IPv4's do_ip_getsockopt() rejects a negative optlen right after reading
it. do_ipv6_getsockopt() never has, and nothing downstream treats it as
an error either: len is an int, but every consumer compares it unsigned,
so -1 behaves as a huge value and each site clamps to its own reply
size.

	len = min_t(unsigned int, sizeof(int), len);

So getsockopt(fd, SOL_IPV6, IPV6_TCLASS, buf, &len) with len set to -1
answers 4 bytes and reports 4, rather than failing.

This is a bug ready to bite us in the near future, let's get this fixed.

I've found this because testing the rest of the patch was returning
inconsistency when optlen = -1.

Later patches make the check unreachable, since sockopt_init_user() and
sockptr_to_sockopt() both reject a negative length before the switch
runs. Keep it as a guard; the fix stands on its own here.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/ipv6_sockglue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4b3536571c9804..5c6a0819a2aaff 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1002,6 +1002,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
+	if (len < 0)
+		return -EINVAL;
 	switch (optname) {
 	case MCAST_MSFILTER:
 		if (in_compat_syscall())

-- 
2.53.0-Meta

