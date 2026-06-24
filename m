Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F827A91D;
	Wed, 24 Jun 2026 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782269502; cv=none; b=JzFMviMd1JN0HFYASzG6uifr4L86MItAtAE56ZBmIbqSBZsSTB3oJgyZN2ju8wIHW9J3SCNknU0Tf4lXulzAoml41SRacAWRJn1y7SPgfUUfhZY4/oQwfJa6kMLmBHSzWsL9/AFrNpdPBo0cnjwpo9gB4gU8etyLGZkPFxZ33W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782269502; c=relaxed/simple;
	bh=sgupEhadXMBHZAvbeYLxPrEfFCHpwBSIGiQBKC22W7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFq39EmKSJKpRxiKnIMcZEfvMHRD45X3tu9E2lVUtDLFxwhRt88Vyzo2UMOJJR89pwEeksoW5b2OkxP/YuuLmLckqKT72Qo5+8tpRdVmcm4TkZr0inJcsstkSAyTM3ODQXSi8fy18VCEXCSbZCF/oI6UIp2hVs/jJOpJwtCThRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VPPpGiyj; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VPPpGiyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782269488;
	bh=o2/Dqf9hn4yIq5OPcv/EP0vd56PjWw7mwuSSm2nxWd0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VPPpGiyjH91D4jNzJ1d4Fsjmzra/JpjnfaYNeCXz4sOIa6A37dFNqfxutRICz1vyo
	 /28C1YajIQLjqev4G313Co5jLPPLq/SZZoxc2nFJsW5FYGkE8L+q8pZ3dw8Na7ffDq
	 zvLg6RyIOPZUOu4hUpQv4ofCXwHLylsu5tctGCio=
X-QQ-mid: zesmtpsz7t1782269472te33b325e
X-QQ-Originating-IP: Muud9pHUTh9RXd2k9TgI7zf/I46iixaLgNyWnnA9ZZY=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 10:51:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7962279032744178501
EX-QQ-RecipientCnt: 15
From: Yichong Chen <chenyichong@uniontech.com>
To: emil@etsalapatis.com,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: chenyichong@uniontech.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	jiayuan.chen@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
Date: Wed, 24 Jun 2026 10:50:55 +0800
Message-ID: <9F9017160ABE125F+20260624025055.1574875-3-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260624025055.1574875-1-chenyichong@uniontech.com>
References: <20260624025055.1574875-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NRkWGnbnkwTmDJQJfbJbANKU/B+kSohIpLP36Vvyhc9Vsb3JitzR0/3A
	cKadVijDr34lLnbUgeTUcMkXBjEl6kQOJDp6DTKk+nLlFlxs8OhENklwaVI/M4g2Y3h3p/m
	DTHPfOoWyDnG2ye7BxaJBXDq30ohAIdZl3v3kuSLvvODJ11N59VFzTgisOUI5/b/69OCnW3
	NWoGg3aV7/J/cSzolSvER06kH7Een2U0NqXvCNwJEn/c/rpx6+VKgj2mPAa9qKH7Uevzsot
	see+EPyF1seEec5hr9aM62VX6/O6UaEIENBIY4KbiEeQse4Psv2bqS1EDofVHFdOTO585Dy
	RgRWvson9gBjXA73FVkr2OSa/x1Od7r7uuiLIU/VzNgsIPFkWlpy0+HQOICgEWjEbj9WSBp
	sOYxLFQtC/TA1Huv0r1+Cfgqh/vAQ+Z9O/PEBnbTxITK5w7cQ7bK10pijglvs6NffiLIMx8
	Su6B+Uu9o1BDKcbdw6tjAi5p2A+OmhtC1HGxmy3JJ+fP729sI0nGHueK13fwMQ9k0sWN2he
	VYMX7UXo/uYsqHe8Wu2ZUJL7FQrqRpHP4j4wadJLxPYffxnR/nM6u4LbZ8VAKyGXXbk/yui
	FdeEmokgp7wzQbALq4saMjRDwCuMu0sK9+B76c++9fdfa0jOq1xNwTwnNpXM0/cDGcdMXXS
	UGjlDZXXh5j98LRljU5DK2tWouIWG5oZMYjww5ra1eTiL3/9RaFhtrOdzeRcwLiHEB6zrb0
	kxe73RppsSKe6mQyKtx15mcZJU229Isjz+VD7HAM+8qsonND7z8EEWp5h1dtET2MQWu1pGy
	UIxd9lY9CTMKbaOR5dOb/VHkah5GzVY5z7rneLLxLQxnJ7cuccO0ZL9ttwZ9YUdwjXajtxd
	fj975Dp+OBSbF3w9zF5L7w4W8BpzJSXhWtvJdtHJWFgjlvQ1jNS4gF0VBeicMyJUUPszQ+C
	yVyZQ6XxvkG7ikSJJxMUPgORYAepBONdv5Fmn2nN0ZYlzq78/HeLSU0B4uhDQdj7b4QL06J
	B4CT5fJaxQ9EQza771HlO5QBLZ9g+pDYCcrVlqCHwbaW8EOtIwoLWQxqhh5poLXnG5HU4aE
	oinJfYuBI3Bz3Ogi/+jx1FBWm6554xQ+0zMJiI7emtPq0pDUDvAZ5M=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

struct_ops frees the global btf_vmlinux object.

In batch mode, a later struct_ops command can reuse stale state.

Reset the BTF pointer and cached map info state.

Fixes: 65c93628599d ("bpftool: Add struct_ops support")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/bpf/bpftool/struct_ops.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index aa43dead249c..835e5e561f7f 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -643,6 +643,10 @@ int do_struct_ops(int argc, char **argv)
 	err = cmd_select(cmds, argc, argv, do_help);
 
 	btf__free(btf_vmlinux);
+	btf_vmlinux = NULL;
+	map_info_type = NULL;
+	map_info_alloc_len = 0;
+	map_info_type_id = 0;
 
 	return err;
 }
-- 
2.51.0

