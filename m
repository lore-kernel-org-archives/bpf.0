Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6743E1694
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173951; cv=none; b=PYROUtMTIUrXNlbQBPiuS9kpugp62jX6F+sXxuMr4nCqqp2288B4G97Tl5nMsxSuQfzvBilmYEHPFFZP8JGHEuhoDNGYSpeQyHCBYAc8046Z+evBOAhRaZM40Z/uU7k+sfusZdAZkA1oy5EsIk/jWwL0jMD4OQ4ajoEEyNS7lMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173951; c=relaxed/simple;
	bh=PgQ4fdNG1I5mzLmR5CztYWodxqeUyQyWr2TX2XRajac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLAWH7IB0R8gjasAi4a2ZJBpDp9MAQf76OhKmrnbwkQafz6mD6aeythdNldsUqZIrbRutHa6PWlpEARM6o4hPj54cOr2SFdb2P+zic8WEbA9EkanpDmg4wSjY1IP+5VpNtWrVizVZJlYNPPx69Msvqv7JXqZgmLeSDLMhCC+s7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPAeyZVt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPAeyZVt"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1182937f8f.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173947; x=1788778747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5W+eR+O08Ek7XrNZ2OE6a0SxFcDnXkOMu9Md6tACuw=;
        b=EPAeyZVtlH136aWeSYWeMtFsuPgQfBfxyqtLjuC4uZ84E8k0HYlYA1GErNap4j1Z7Q
         mb4BvzEDg5Erk6R01o+2hzr5T30Tmil71nvsReI6ZuqgyMVLP7N4B90gSqkJUEKB4+v+
         3xNocrtTO5A406YK7hKKSXbeQjjXpNtsVvFk+AqNujaK53qU93q0KsK5psq3y5tkFGbO
         H55qDqEZDBCVGa75DtzzgUSU23BlKTNQiFtB+DSLrqm4cfgOyIIWQ3BDDPM1M97kkauM
         NqbepOJwWD6KP7EJrYjR0i6ydKREaXhqa760rgO7l6TwnEwY7EItCcRgv/z8fGVus46J
         BcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173947; x=1788778747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5W+eR+O08Ek7XrNZ2OE6a0SxFcDnXkOMu9Md6tACuw=;
        b=UWWMNauldbIp+G79A2aixhIP2JR/Hb4qcqnhKq4Dz7gU2+z3IwI07Q0cXQtOw3VriE
         q4/FHw3nmfMGWLKRF39rPufajQSEspmo1A5M9cfb3ZAegqqbZp3OFLRIu+YwdqeTr6Yi
         lNbAc4X1gaIAyhhPBVkB+zSx7qA4w0xGeQU6sQPSwkDtnfLkPmc4QNwoRuViSBe95kfL
         vo5o3czQ4sJttzMqGhyreGk1pTPq9TuzQJLPLO8SLuBXoIpmevZyaSaW0C2/36aMFK+k
         qzMYsjCLkjC1/e2YLbffy8IBOSphSVLyfxuFzLPas7Rlry9DCM5vTxbImHpiZJVogCls
         8Q5A==
X-Gm-Message-State: AFuF++k1RognT79fyxz7+w2m2BdS0VJn9iHamxi/F1kyNrxbEXmMiR0h
	N8N72VZTDV6v56JCdMX9LPTvXd9GJxbPvSW1BBF63FkILRkn0UUXjarTEr7+qA==
X-Gm-Gg: AYBFou2sHlN3tHc4N8JyDbiVnePugdq7TSzwaChVMrLW1MbHmguk9F6J2LX5IFvDFyr
	5my01iSP8tXoHu1cLi9PDb9qeoj+WZzUyohMWyuQN0oejGlHfwiHfPPCpYkYvn6UQtKySab0Heu
	/e1w6L3bnZRpODeYJrGZBXyC6hpfWrrH0LQlr3knQeHAC7HaXdT0p04Ii5ucpvVxhQD2HUkkBCI
	BpZbjbplgpI0xETO/AptgoHTn0c3018rUo6KAAjKWAYGhBCJ1aBolHpuacCh/KDcw+Q77nCXV/8
	s2ICNLUTEp863qXhg+utUYe0r5LNpiWuB6pxBaNv87Gc/FwMKZiATn2rM0vMYF3j0nKQEcQSVFq
	GfClzD4Y0qJ+oCINWq11xxprCbIbyrFXjPU7sujLlX7nEbcosIHMEn4Vi0oDZiW2o2hW+Ia62V3
	RpEQRSi8B7hdxSA3tGZg2dMXJFBcM5qtGnzCuZiSHQhtOm/oRnVzbELkJEYtijj9Jo45kaqZ96t
	1FELQ==
X-Received: by 2002:a05:6000:71a:b0:482:e6ec:4edb with SMTP id ffacd0b85a97d-4843efdca56mr3863681f8f.15.1788173947119;
        Mon, 31 Aug 2026 03:59:07 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:59:06 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 7/7] selftests/bpf: Add tests for BPF ethtool hooks
Date: Mon, 31 Aug 2026 11:09:32 +0000
Message-ID: <20260831110934.241898-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831110934.241898-1-a.s.protopopov@gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for the new ethtool BPF hooks. The ioctl tests are
more-or-less straightforward, as there is only one hook point.
However, the doit/dump hooks are called from multiple sites, and the
tests are trying to reach as many of them as possible.  The
exceptions are ethnl_rss_create_doit(), ethnl_rss_delete_doit() and
ethnl_tsinfo_dump_one_phydev(), which aren't reachable via netdevsim.

This is how the list off sub-tests maps to call sites:

  linkstate_get_doit:    netlink.c (ethnl_default_doit)
  linkstate_get_dump:    netlink.c (ethnl_default_dump_one)
  cable_test_act:        cabletest.c (ethnl_act_cable_test)
  cable_test_tdr_act:    cabletest.c (ethnl_act_cable_test_tdr)
  features_set:          features.c (ethnl_set_features)
  module_fw_flash_act:   module.c (ethnl_act_module_fw_flash)
  tunnel_info_get_doit:  tunnels.c (ethnl_tunnel_info_doit)
  tunnel_info_get_dump:  tunnels.c (ethnl_tunnel_info_dumpit)
  tsinfo_get_dump:       tsinfo.c (ethnl_tsinfo_dump_one_netdev)
  rss_get_dump:          rss.c (ethnl_rss_dumpit)
  channels_set_doit:     netlink.c (ethnl_default_set_doit)
  ioctl:                 ioctl.c (ethtool_bpf_ioctl_hook)
  ioctl_sub_cmd:         ioctl.c (ethtool_bpf_ioctl_hook)
  no tests:             rss.c (ethnl_rss_{create,delete}_doit)

Two ioctl tests check, correspondingly, that the cmd and sub_cmd
are passed correctly.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/ethtool_lsm.c    | 330 ++++++++++++++++++
 .../testing/selftests/bpf/progs/ethtool_lsm.c | 168 +++++++++
 2 files changed, 498 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/ethtool_lsm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c b/tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c
new file mode 100644
index 000000000000..f4662fb1ae3c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <linux/ethtool_netlink.h>
+#include <linux/genetlink.h>
+#include <net/if.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include "netdevsim_helpers.h"
+#include "network_helpers.h"
+#include "netlink_helpers.h"
+#include "test_progs.h"
+
+#include "ethtool_lsm.skel.h"
+
+/* not probable to encounter this errno in real life */
+#define TEST_ERRNO EDOTDOT
+#define TEST_PHY_INDEX 1
+
+/* ethtool_netlink_generated.h is not copied to tools/include/uapi. */
+#define ETHTOOL_A_MODULE_FW_FLASH_HEADER 1
+#define ETHTOOL_MSG_MODULE_FW_FLASH_ACT 44
+#define ETHTOOL_A_HEADER_PHY_INDEX 4
+
+static int ethnl_request(int fd, __u16 family_id, __u8 cmd, __u16 hdr_attr,
+			 __u16 extra_nest, __u32 ifindex, __u32 phy_index, bool dump)
+{
+	static __u32 sequence = 10;
+	struct genl_req req = {};
+	__u32 seq = sequence++;
+	struct rtattr *nest;
+	int err;
+
+	req.nlh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	req.nlh.nlmsg_type = family_id;
+	req.nlh.nlmsg_flags = NLM_F_REQUEST | (dump ? NLM_F_DUMP : 0);
+	req.nlh.nlmsg_seq = seq;
+	req.genl.cmd = cmd;
+	req.genl.version = ETHTOOL_GENL_VERSION;
+
+	nest = addattr_nest(&req.nlh, sizeof(req), hdr_attr | NLA_F_NESTED);
+	if (ifindex && addattr32(&req.nlh, sizeof(req), ETHTOOL_A_HEADER_DEV_INDEX, ifindex))
+		return -EMSGSIZE;
+	if (phy_index && addattr32(&req.nlh, sizeof(req), ETHTOOL_A_HEADER_PHY_INDEX, phy_index))
+		return -EMSGSIZE;
+	if (addattr32(&req.nlh, sizeof(req), ETHTOOL_A_HEADER_FLAGS, ETHTOOL_FLAG_COMPACT_BITSETS))
+		return -EMSGSIZE;
+	addattr_nest_end(&req.nlh, nest);
+
+	if (extra_nest) {
+		nest = addattr_nest(&req.nlh, sizeof(req), extra_nest | NLA_F_NESTED);
+		addattr_nest_end(&req.nlh, nest);
+	}
+
+	err = genl_send(fd, &req.nlh);
+	if (err)
+		return err;
+
+	return genl_recv(fd, seq, family_id, dump);
+}
+
+static int netdev_set_up(__u32 ifindex)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifinfomsg ifm;
+	} req = {
+		.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.nlh.nlmsg_type = RTM_NEWLINK,
+		.nlh.nlmsg_flags = NLM_F_REQUEST,
+		.ifm.ifi_family = AF_UNSPEC,
+		.ifm.ifi_index = ifindex,
+		.ifm.ifi_flags = IFF_UP,
+		.ifm.ifi_change = IFF_UP,
+	};
+	struct rtnl_handle rth;
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (err)
+		return err;
+	err = rtnl_talk(&rth, &req.nlh, NULL);
+	rtnl_close(&rth);
+
+	return err;
+}
+
+static int ethtool_ioctl(__u32 ifindex, void *data)
+{
+	struct ifreq ifr = {};
+	int fd, err;
+
+	if (!if_indextoname(ifindex, ifr.ifr_name))
+		return -errno;
+
+	fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return -errno;
+
+	ifr.ifr_data = data;
+	err = ioctl(fd, SIOCETHTOOL, &ifr);
+	if (err)
+		err = -errno;
+	close(fd);
+
+	return err;
+}
+
+static void check_doit(struct ethtool_lsm *skel, int fd, __u16 family_id,
+		       __u32 ifindex, __u8 cmd, __u16 hdr_attr,
+		       __u16 extra_nest, __u32 phy_index)
+{
+	int err;
+
+	skel->bss->target_ifindex = ifindex;
+	skel->bss->target_cmd = cmd;
+	skel->bss->target_sub_cmd = 0;
+	skel->bss->target_phy_index = phy_index;
+
+	skel->bss->allow = true;
+	err = ethnl_request(fd, family_id, cmd, hdr_attr, extra_nest, ifindex, phy_index, false);
+	if (!ASSERT_NEQ(err, -TEST_ERRNO, "doit (allow)"))
+		return;
+
+	skel->bss->allow = false;
+	err = ethnl_request(fd, family_id, cmd, hdr_attr, extra_nest, ifindex, phy_index, false);
+	ASSERT_EQ(err, -TEST_ERRNO, "doit (deny)");
+}
+
+static void check_dump(struct ethtool_lsm *skel, int fd, __u16 family_id,
+		       __u32 ifindex, __u8 cmd, __u16 hdr_attr, bool single_dev,
+		       __u32 phy_index)
+{
+	__u32 req_ifindex = single_dev ? ifindex : 0;
+	int err;
+
+	/*
+	 * A phy_index which is not present on netdevsim can fail preparation on
+	 * the first device in a dump, so match the hook on any device here.
+	 */
+	skel->bss->target_ifindex = phy_index ? 0 : ifindex;
+
+	skel->bss->target_cmd = cmd;
+	skel->bss->target_sub_cmd = 0;
+	skel->bss->target_phy_index = phy_index;
+
+	skel->bss->allow = true;
+	err = ethnl_request(fd, family_id, cmd, hdr_attr, 0, req_ifindex, phy_index, true);
+	if (!ASSERT_NEQ(err, -TEST_ERRNO, "dump (allow)"))
+		return;
+
+	skel->bss->allow = false;
+	err = ethnl_request(fd, family_id, cmd, hdr_attr, 0, req_ifindex, phy_index, true);
+	ASSERT_EQ(err, -TEST_ERRNO, "dump (deny)");
+}
+
+static void check_ioctl(struct ethtool_lsm *skel, __u32 ifindex)
+{
+	struct ethtool_value value = { .cmd = ETHTOOL_GLINK };
+	int err;
+
+	skel->bss->target_ifindex = ifindex;
+	skel->bss->target_cmd = ETHTOOL_GLINK;
+	skel->bss->target_sub_cmd = 0;
+	skel->bss->target_phy_index = 0;
+
+	skel->bss->allow = true;
+	err = ethtool_ioctl(ifindex, &value);
+	if (!ASSERT_NEQ(err, -TEST_ERRNO, "ETHTOOL_GLINK (allow)"))
+		return;
+
+	skel->bss->allow = false;
+	err = ethtool_ioctl(ifindex, &value);
+	ASSERT_EQ(err, -TEST_ERRNO, "ETHTOOL_GLINK (deny)");
+}
+
+static void check_ioctl_sub_cmd(struct ethtool_lsm *skel, __u32 ifindex)
+{
+	struct ethtool_per_queue_op req = { .cmd = ETHTOOL_PERQUEUE };
+	int err;
+
+	/*
+	 * ETHTOOL_PERQUEUE is the only cmd where sub_cmd differs from cmd,
+	 * so try to apply policy only to one sub_cmd of two
+	 */
+	skel->bss->target_ifindex = ifindex;
+	skel->bss->target_cmd = ETHTOOL_PERQUEUE;
+	skel->bss->target_sub_cmd = ETHTOOL_SCOALESCE;
+	skel->bss->target_phy_index = 0;
+	skel->bss->allow = false;
+
+	req.sub_command = ETHTOOL_SCOALESCE;
+	err = ethtool_ioctl(ifindex, &req);
+	ASSERT_EQ(err, -TEST_ERRNO, "ETHTOOL_SCOALESCE");
+
+	/* this fails in any case on netdevsim, but the errno is not ours => success */
+	req.sub_command = ETHTOOL_GCOALESCE;
+	ASSERT_NEQ(ethtool_ioctl(ifindex, &req), -TEST_ERRNO, "ETHTOOL_GCOALESCE");
+}
+
+void test_ethtool_lsm(void)
+{
+	__u32 netdevsim_ifindex;
+	struct ethtool_lsm *skel = NULL;
+	struct netns_obj *netns = NULL;
+	struct nstoken *nstoken = NULL;
+	int netdevsim_id = -1, family_id, fd = -1, err;
+
+	SYS_NOFAIL("ip netns del ethtool_lsm_ns");
+	netns = netns_new("ethtool_lsm_ns", false);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto out;
+
+	nstoken = open_netns("ethtool_lsm_ns");
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto out;
+
+	netdevsim_id = netdevsim_create(&netdevsim_ifindex);
+	if (!ASSERT_GE(netdevsim_id, 0, "netdevsim_create"))
+		goto out;
+
+	err = netdev_set_up(netdevsim_ifindex);
+	if (!ASSERT_OK(err, "netdev_set_up"))
+		goto out;
+
+	skel = ethtool_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out;
+
+	/* load-only examples */
+	bpf_program__set_autoattach(skel->progs.cve_2021_46916, false);
+	bpf_program__set_autoattach(skel->progs.cve_2025_21701, false);
+	bpf_program__set_autoattach(skel->progs.cve_2022_50651, false);
+	bpf_program__set_autoattach(skel->progs.cve_2024_46834_ioctl, false);
+	bpf_program__set_autoattach(skel->progs.cve_2024_46834_doit, false);
+
+	skel->bss->monitored_pid = getpid();
+
+	err = ethtool_lsm__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	fd = genl_open(0);
+	if (!ASSERT_OK_FD(fd, "genl_open"))
+		goto out;
+
+	family_id = genl_resolve_family(fd, ETHTOOL_GENL_NAME);
+	if (family_id == -ENOENT) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_GT(family_id, 0, "resolve_ethtool_family"))
+		goto out;
+
+	if (test__start_subtest("linkstate_get_doit"))
+		check_doit(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_LINKSTATE_GET, ETHTOOL_A_LINKSTATE_HEADER, 0, 0);
+
+	if (test__start_subtest("linkstate_get_dump"))
+		check_dump(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_LINKSTATE_GET, ETHTOOL_A_LINKSTATE_HEADER, false, 0);
+
+	if (test__start_subtest("cable_test_act"))
+		check_doit(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_CABLE_TEST_ACT, ETHTOOL_A_CABLE_TEST_HEADER, 0, 0);
+
+	if (test__start_subtest("cable_test_tdr_act"))
+		check_doit(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
+			   ETHTOOL_A_CABLE_TEST_TDR_HEADER, 0, 0);
+
+	if (test__start_subtest("features_set"))
+		check_doit(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_FEATURES_SET, ETHTOOL_A_FEATURES_HEADER,
+			   ETHTOOL_A_FEATURES_WANTED, 0);
+
+	if (test__start_subtest("module_fw_flash_act"))
+		check_doit(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
+			   ETHTOOL_A_MODULE_FW_FLASH_HEADER, 0, 0);
+
+	if (test__start_subtest("tunnel_info_get_doit"))
+		check_doit(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_TUNNEL_INFO_GET, ETHTOOL_A_TUNNEL_INFO_HEADER, 0, 0);
+
+	if (test__start_subtest("tunnel_info_get_dump"))
+		check_dump(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_TUNNEL_INFO_GET, ETHTOOL_A_TUNNEL_INFO_HEADER,
+			   false, 0);
+
+	if (test__start_subtest("tsinfo_get_dump"))
+		check_dump(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_TSINFO_GET, ETHTOOL_A_TSINFO_HEADER, true, 0);
+
+	if (test__start_subtest("rss_get_dump"))
+		check_dump(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_RSS_GET, ETHTOOL_A_RSS_HEADER, true, 0);
+
+	if (test__start_subtest("channels_set_doit"))
+		check_doit(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_CHANNELS_SET, ETHTOOL_A_CHANNELS_HEADER, 0, 0);
+
+	if (test__start_subtest("cable_test_phy_index"))
+		check_doit(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_CABLE_TEST_ACT, ETHTOOL_A_CABLE_TEST_HEADER,
+			   0, TEST_PHY_INDEX);
+
+	if (test__start_subtest("strset_get_phy_index_dump"))
+		check_dump(skel, fd, family_id, netdevsim_ifindex,
+			   ETHTOOL_MSG_STRSET_GET, ETHTOOL_A_STRSET_HEADER, true,
+			   TEST_PHY_INDEX);
+
+	if (test__start_subtest("ioctl"))
+		check_ioctl(skel, netdevsim_ifindex);
+
+	if (test__start_subtest("ioctl_sub_cmd"))
+		check_ioctl_sub_cmd(skel, netdevsim_ifindex);
+
+out:
+	if (fd >= 0)
+		close(fd);
+	ethtool_lsm__destroy(skel);
+	if (netdevsim_id >= 0)
+		netdevsim_destroy(netdevsim_id);
+	close_netns(nstoken);
+	netns_free(netns);
+}
diff --git a/tools/testing/selftests/bpf/progs/ethtool_lsm.c b/tools/testing/selftests/bpf/progs/ethtool_lsm.c
new file mode 100644
index 000000000000..c6b21aeed6fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ethtool_lsm.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <errno.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u32 monitored_pid;
+__u32 target_ifindex;
+__u32 target_cmd;
+__u32 target_sub_cmd;
+__u32 target_phy_index;
+bool allow;
+
+/*
+ * This test is used for all hooks, just checks that it is ours,
+ * and allows/denies based on the "allow" global variable
+ */
+static int test_policy(const struct net_device *dev, __u32 cmd, __u32 sub_cmd, __u32 phy_index)
+{
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	if (!dev || (target_ifindex && dev->ifindex != target_ifindex))
+		return 0;
+
+	if (target_cmd && cmd != target_cmd)
+		return 0;
+
+	if (target_sub_cmd && sub_cmd != target_sub_cmd)
+		return 0;
+
+	if (phy_index != target_phy_index)
+		return -EDOTDOT;
+
+	return allow ? 0 : -EDOTDOT; /* unlikely to see this errno outside this test */
+}
+
+SEC("lsm/ethtool_ioctl")
+int BPF_PROG(test_ethtool_ioctl, const struct net_device *dev, __u32 cmd, __u32 sub_cmd, int ret)
+{
+	if (ret)
+		return ret;
+
+	return test_policy(dev, cmd, sub_cmd, 0);
+}
+
+SEC("lsm/ethtool_netlink_doit")
+int BPF_PROG(test_ethtool_doit, const struct net_device *dev, __u32 cmd, __u32 phy_index, int ret)
+{
+	if (ret)
+		return ret;
+
+	return test_policy(dev, cmd, 0, phy_index);
+}
+
+SEC("lsm/ethtool_netlink_dump")
+int BPF_PROG(test_ethtool_dump, const struct net_device *dev, __u32 cmd, __u32 phy_index, int ret)
+{
+	if (ret)
+		return ret;
+
+	return test_policy(dev, cmd, 0, phy_index);
+}
+
+/*
+ * The programs below are policy examples for four CVEs. They are
+ * load only, and added to illustrate how actual policies might look
+ * like for different types of CVEs.
+ */
+
+#define ETHTOOL_TEST_CMD		0x0000001aU
+#define ETHTOOL_SCHANNELS_CMD		0x0000003dU
+
+static bool is_ixgbe(const struct net_device *dev)
+{
+	char driver_name[16];
+	long len;
+
+	if (!dev || !dev->dev.parent || !dev->dev.parent->driver)
+		return false;
+
+	len = bpf_probe_read_kernel_str(driver_name, sizeof(driver_name),
+					dev->dev.parent->driver->name);
+	if (len < 0)
+		return false;
+
+	return bpf_strncmp(driver_name, 6, "ixgbe") == 0;
+}
+
+/*
+ * CVE-2021-46916 is an example of ioctl-only bug for a particular driver (ixgbe).
+ */
+SEC("lsm/ethtool_ioctl")
+int BPF_PROG(cve_2021_46916, const struct net_device *dev, __u32 cmd, __u32 sub_cmd, int ret)
+{
+	if (ret)
+		return ret;
+
+	if (cmd != ETHTOOL_TEST_CMD)
+		return 0;
+
+	return is_ixgbe(dev) ? -EPERM : 0;
+}
+
+/*
+ * CVE-2025-21701 is an example of a bug which must be mitigated under a lock,
+ * as access to dev->reg_state must be protected.
+ */
+SEC("lsm/ethtool_netlink_doit")
+int BPF_PROG(cve_2025_21701, const struct net_device *dev, __u32 cmd, __u32 phy_index, int ret)
+{
+	if (ret)
+		return ret;
+
+	if (!dev)
+		return 0;
+
+	return dev->reg_state >= NETREG_UNREGISTERING ?  -ENODEV : 0;
+}
+
+/*
+ * CVE-2022-50651 is an example of a bug triggered only by .dump, not by .doit.
+ */
+SEC("lsm/ethtool_netlink_dump")
+int BPF_PROG(cve_2022_50651, const struct net_device *dev, __u32 cmd, __u32 phy_index, int ret)
+{
+	if (ret)
+		return ret;
+
+	return cmd == ETHTOOL_MSG_MODULE_EEPROM_GET ? -EPERM : 0;
+}
+
+/*
+ * CVE-2024-46834 is an example of a bug which requires to filter out both
+ * channels: ioctl and netlink. Note that they receive different cmd values.
+ */
+
+SEC("lsm/ethtool_ioctl")
+int BPF_PROG(cve_2024_46834_ioctl, const struct net_device *dev, __u32 cmd, __u32 sub_cmd, int ret)
+{
+	if (ret)
+		return ret;
+
+	if (cmd == ETHTOOL_SCHANNELS_CMD)
+		return -EPERM;
+
+	return 0;
+}
+
+SEC("lsm/ethtool_netlink_doit")
+int BPF_PROG(cve_2024_46834_doit, const struct net_device *dev, __u32 cmd, __u32 phy_index, int ret)
+{
+	if (ret)
+		return ret;
+
+	if (cmd == ETHTOOL_MSG_CHANNELS_SET)
+		return -EPERM;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

