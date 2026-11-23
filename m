Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412571;
	b=U9jNO7K2DtEn2PweJcDsKpLFOA6okfAj1OOEP06uQhpcaiHvYMXuROxJ4EWx7VRpcb63
	 ZS1bZozULH10KIScoR5YQQcaKPgJZs2I8d2OoQTz1mjFBnNWGa/sJY8I1TO4wDVkuE7kz
	 690yeRyAGPPrvr7B6P/RLEr7VwnU7j/KL3MdhEc2H9fMev3X9yDZPL9jVHUka7bSUVJVp
	 Blcm3eYyUICJz8n2s6V5XVcgxNBbtbVlnhPqqbG/WlpzXH/XpjfylrUmp2kxXMOl6SyaH
	 YZswe5Jiox1y4+JPFz6XnMIhT1KsiDMAR3txPxD/USVniZg3V1mK6lxwFAgwYf8lq7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412571;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=XzqBPbsAJ7iRQUzHM2XsULWuUT79ufDyPjza06YYrkM=;
	b=WtcqLrKKE07cdcSy1sa2SyDw4tUesCbIGUjEazAzPN4gZH9g5dnslU/AwE1MENzSyiqq
	 lWI5V4hGWyIKP9aMuaMq51cfoXCC5vY6KNAfo6fLYCdqbqodhss7xR2RhWrkCJ88MqVbl
	 RUU92ClYCn8KpMpaFY+Z8Vk9bObpVMO4wP2iU0pv918r4HCsQHVTWT1m3GUZMOFV9zD0K
	 inLGJ7nehEAWNNETQ2lVXbUFFxg0P6/uiXTB3Fx5OwU9R+l/9x4z0DpXUXRfrHj8VPI14
	 vnPjwGGtXBggEnIIkSFphBAu6r+bESrRG+f9U1YFyDSTPz0h46xS43Wem7e6JOmpqkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jBMphh80;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F586606A31A;
	Mon, 23 Nov 2026 05:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F586606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jBMphh80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xz
	qBPbsAJ7iRQUzHM2XsULWuUT79ufDyPjza06YYrkM=; b=jBMphh80SjsqYMOzff
	DI9r1MEMNtfk5LncTqI0dGkNKypsmKqoMMHc8Cfrgu3lYoL5cd4TPbsyFQlACMdT
	eXLN/SW4JIRyG67D6b/EoBxTyHXRI0HQd3IYGKom+18XIOrOH9qZ/iQu+ZZ8gDdO
	o9+7ekrc6femOqnsOCkXsYmZA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL9ky0gNrZC+QIw--.65118S4;
	Mon, 23 Nov 2026 13:42:13 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v12 2/2] selftests: net: add TAP socket filter attach tests
Date: Mon, 23 Nov 2026 13:42:09 +0800
Message-Id: <20261123054209.89946-3-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261123054209.89946-1-clementwei90@163.com>
References: <20261123054209.89946-1-clementwei90@163.com>
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
X-CM-TRANSID:_____wDnL9ky0gNrZC+QIw--.65118S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3CF47Jw4DAryxCw17ZF15CFg_yoWktr1kpF
	97WayDJr15Xr47Xws7ArW8ZFW3Zw4DGr1rAan5K3s8ZFs8Jry5Ca9YkFWakws7tr48uws0
	kFyaya43WwsxtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j718kUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hVdyGsD0jXr5gAA3g

From: Rongguang Wei <weirongguang@kylinos.cn>

Add tests for TUNATTACHFILTER and TUNDETACHFILTER: a queue re-attached
after the buffer the program came from was made unreadable, a bad program
and a bad length with queues attached and with none, a program configured
before any queue, and the IFF_NOFILTER paths.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 tools/testing/selftests/net/tun.c | 358 ++++++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 34de2580e32e..ac326193867b 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -9,9 +9,11 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/filter.h>
 #include <linux/if_tun.h>
 #include <netinet/tcp.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 
 #include "kselftest_harness.h"
@@ -548,6 +550,362 @@ TEST_F(tun, reattach_close_delete)
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+/* accept: return skb->len.  Three instructions on purpose, so that the
+ * length read back through TUNGETFILTER tells it apart from a rejected
+ * program that is shorter.
+ */
+static const struct sock_filter filter_accept[] = {
+	BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
+	BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0),
+	BPF_STMT(BPF_RET | BPF_A, 0),
+};
+
+/* Put the instructions in an anonymous mapping, so that the test can make the
+ * address unreadable afterwards.
+ */
+static void *filter_alloc(const struct sock_filter *insns, unsigned int len)
+{
+	void *p;
+
+	p = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED)
+		return NULL;
+
+	memcpy(p, insns, len * sizeof(*insns));
+
+	return p;
+}
+
+static int filter_attach(int fd, const struct sock_filter *insns, unsigned int len)
+{
+	struct sock_fprog fp = {
+		.len = len,
+		.filter = (struct sock_filter *)insns,
+	};
+
+	return ioctl(fd, TUNATTACHFILTER, (void *)&fp);
+}
+
+static int filter_get(int fd, struct sock_fprog *fp)
+{
+	return ioctl(fd, TUNGETFILTER, (void *)fp);
+}
+
+static int tun_get_iff_flags(int fd)
+{
+	struct ifreq ifr = { 0 };
+
+	if (ioctl(fd, TUNGETIFF, (void *)&ifr) < 0)
+		return -1;
+
+	return ifr.ifr_flags;
+}
+
+/*
+ * The program is built when TUNATTACHFILTER is issued, so a queue attached
+ * later does not read the buffer it came from.  Here the mapping is made
+ * unreadable before the queue is attached again, and another queue is then
+ * attached from a fresh socket, which starts without a filter of its own.
+ */
+TEST_F(tun, reattach_filter_without_user_buffer)
+{
+	struct sock_fprog gf = { 0 };
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	void *prog;
+	int fd, ret;
+
+	prog = filter_alloc(filter_accept, ARRAY_SIZE(filter_accept));
+	ASSERT_NE(prog, NULL);
+	ASSERT_EQ(filter_attach(self->fd, prog, ARRAY_SIZE(filter_accept)), 0);
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+
+	/* This memory is no longer readable */
+	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_NONE), 0);
+
+	ret = tun_attach(self->fd, self->ifname);
+	EXPECT_EQ(ret, 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	/* The queue is attached again, not left disabled */
+	EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	/* The two checks below document the expected state, they cannot
+	 * tell an installed filter from no filter: tun_detach() leaves the
+	 * device program alone, and TUNGETFILTER only returns the header.
+	 */
+	EXPECT_EQ(filter_get(self->fd, &gf), 0);
+	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
+
+	/* A new queue starts without a filter, so a clear IFF_NOFILTER shows
+	 * that the filter configured on the device covers it as well.
+	 */
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE;
+	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	close(fd);
+
+	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(munmap(prog, getpagesize()), 0);
+}
+
+/* A new queue attached with IFF_NOFILTER must not get the filter that is
+ * configured on the device.
+ */
+TEST_F(tun, attach_filter_nofilter_flag)
+{
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	int fd;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
+
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NOFILTER;
+	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER);
+
+	close(fd);
+}
+
+/* A later TUNATTACHFILTER covers every queue of the device, including one that
+ * was attached with IFF_NOFILTER.
+ */
+TEST_F(tun, attach_filter_clears_nofilter_queue)
+{
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	int fd;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NOFILTER;
+	ASSERT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER);
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept,
+				ARRAY_SIZE(filter_accept)), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	close(fd);
+}
+
+/* After TUNDETACHFILTER a later attach must not install the filter again */
+TEST_F(tun, detach_filter_clears_reattach)
+{
+	short flags = 0;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
+	EXPECT_EQ(ioctl(self->fd, TUNDETACHFILTER, 0), 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER);
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER);
+}
+
+/* TUNDETACHFILTER must clear the filter of a queue that was detached with
+ * IFF_DETACH_QUEUE as well, not only that of the active queues.
+ */
+TEST_F(tun, detach_filter_clears_detached_queue)
+{
+	short flags = 0;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept,
+				ARRAY_SIZE(filter_accept)), 0);
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+	EXPECT_EQ(ioctl(self->fd, TUNDETACHFILTER, 0), 0);
+	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER);
+}
+
+/* A TUNATTACHFILTER with a bad length must leave the installed program and the
+ * filter state that TUNGETIFF reports alone.
+ */
+TEST_F(tun, attach_filter_bad_len_keeps_program)
+{
+	struct sock_fprog gf = { 0 };
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	int fd;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
+
+	errno = 0;
+	EXPECT_EQ(filter_attach(self->fd, filter_accept, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	EXPECT_EQ(filter_get(self->fd, &gf), 0);
+	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	/* A queue attached afterwards still gets the filter, so the rejected
+	 * ioctl left the program on the device alone.
+	 */
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE;
+	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	close(fd);
+}
+
+/* A TUNATTACHFILTER with instructions that bpf_check_classic() rejects must
+ * be refused, and must leave the program that is installed in place.
+ */
+TEST_F(tun, attach_filter_bad_prog_keeps_program)
+{
+	struct sock_fprog gf = { 0 };
+	struct sock_filter bad[] = {
+		BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 1, 0),
+	};
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	int fd;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept,
+				ARRAY_SIZE(filter_accept)), 0);
+
+	errno = 0;
+	EXPECT_EQ(filter_attach(self->fd, bad, ARRAY_SIZE(bad)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* the program attached before is untouched */
+	EXPECT_EQ(filter_get(self->fd, &gf), 0);
+	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
+
+	/* IFF_NOFILTER comes from the program kept on the device, not from
+	 * the saved header, so a clear flag shows the filter is still there.
+	 */
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	/* A queue attached afterwards still gets the filter, so the rejected
+	 * program never replaced the one on the device.
+	 */
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE;
+	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	close(fd);
+}
+
+/* The program is built by TUNATTACHFILTER itself, so a bad one has to be
+ * refused even when there is no queue attached.  A program that is only
+ * refused when it is built would otherwise be saved and break every later
+ * attach.  Detach all queues, check that a bad length and a bad program are
+ * still refused, and that a re-attached queue gets the program installed
+ * before.
+ */
+TEST_F(tun, attach_filter_bad_keeps_program_without_queues)
+{
+	struct sock_fprog gf = { 0 };
+	struct sock_filter bad[] = {
+		BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 1, 0),
+	};
+	short flags = 0;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept,
+				ARRAY_SIZE(filter_accept)), 0);
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+	EXPECT_EQ(tun_detach(self->fd2, self->ifname), 0);
+
+	errno = 0;
+	EXPECT_EQ(filter_attach(self->fd, filter_accept, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	errno = 0;
+	EXPECT_EQ(filter_attach(self->fd, bad, ARRAY_SIZE(bad)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* The rejected ioctls did not replace the program on the device */
+	EXPECT_EQ(filter_get(self->fd, &gf), 0);
+	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
+
+	/* The queue gets that program again, from the device */
+	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+}
+
+/* A program configured while no queue is attached must cover the queues that
+ * are attached afterwards.
+ */
+TEST_F(tun, attach_filter_without_queues_then_attach)
+{
+	short flags = 0;
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+	EXPECT_EQ(tun_detach(self->fd2, self->ifname), 0);
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept,
+				ARRAY_SIZE(filter_accept)), 0);
+
+	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+}
+
 FIXTURE(tun_vnet_gso)
 {
 	char ifname[IFNAMSIZ];
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

