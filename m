Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E236997A
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039639; cv=none; b=PLknKPB72XbfYbP+tbv1o8JtAlkp/sFfKRgnwg0yfaBhrQTKT/zTvW0ddAceH37cfa5HcNzVGgdHKfBXBMnVt8dOAthjB+zNszpqUU6r1ppWPksJylLktZEj+6icWBlKdRXCXvZ/0Oye4UHTvL7gd4fitFGQ3sZ7KBXQ4zJR97M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039639; c=relaxed/simple;
	bh=y0o92f5za9KoLMNlMSWlWEE6guz/2B6L4ioVx+Yb8EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T72r4tW9E7KJgbbuC+Gqa/Ns+/VmQ63esnKu8sWMWms7Kn7Voby9tVmd0wnEek9ph1QxIyagWx6rza9GhuEzQSRHJ34o+ZtclWMgzpR9CEZ7DKff5V4gZwuiwriCqXg7S/KgXzq9xWE3hWcNdOMJo+qOMT05YsiAR/OMo7UKkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.4.235])
	by mtasvr (Coremail) with SMTP id _____wCnNYU5qIBpK0hvAA--.8122S3;
	Mon, 02 Feb 2026 21:35:53 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.4.235])
	by mail-app2 (Coremail) with SMTP id zC_KCgCXr0M2qIBplsekBQ--.55135S2;
	Mon, 02 Feb 2026 21:35:52 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for BPF_END bitwise tracking
Date: Mon,  2 Feb 2026 21:35:36 +0800
Message-Id: <20260202133536.66207-3-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202133536.66207-1-ziye@zju.edu.cn>
References: <20260202133536.66207-1-ziye@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCXr0M2qIBplsekBQ--.55135S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?KzCqWQXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083uYxgGwm4o3MkAMAFMbdSWj3N697O0FOs8nKjP2lBHm0P+BIhE/hWK9fdrtZhLC1DO/k
	QPstsXzRNj60XEQ4FGQ+NlUreqKaTfCGU1ZYsmm5
X-Coremail-Antispam: 1Uk129KBj9fXoWfGF47Zw4UWr1ktrW7CrWDJrc_yoW8Gry5uo
	W5Wws5ZFZ3Gry5tF1q9ry3CF13Xa1a9a4xKrW8KFy5Gas7A3s5WrWUGw4UZFyruF1Y9Fy5
	Xa43tF43Zw1xt3Zxl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYJ7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2K9aDUUUU

Now BPF_END has bitwise tracking support. This patch adds selftests to
cover various cases of BPF_END (`bswap(16|32|64)`, `be(16|32|64)`,
`le(16|32|64)`) with bitwise propagation.

This patch is based on existing `verifier_bswap.c`, and add several
types of new tests:

1. Unconditional byte swap operations:
   - bswap16: port number routing (network byte order conversion)
   - bswap32: IPv4 subnet routing (network byte order conversion)
   - bswap64: IPv6 subnet routing (network byte order conversion)

2. Endian conversion operations (architecture-aware):
   - be16/be32/be64: convert to big-endian
     * on little-endian: do swap
     * on big-endian: truncation (16/32-bit) or no-op (64-bit)
   - le16/le32/le64: convert to little-endian
     * on big-endian: do swap
     * on little-endian: truncation (16/32-bit) or no-op (64-bit)

Each test simulates realistic networking scenarios where a value is
masked to a specific range (e.g., 0x3f00), then byte-swapped, and the
verifier must prove the result stays within expected bounds.

Specifically, these selftests are based on dead code elimination:
If the BPF verifier can precisely track bitwise through byte swap
operations, it can prune the trap path (invalid memory access) that
should be unreachable, allowing the program to pass verification.
If bitwise tracking is incorrect, the verifier cannot prove the trap
is unreachable, causing verification failure.

The tests use preprocessor conditionals (#ifdef __BYTE_ORDER__) to
verify correct behavior on both little-endian and big-endian
architectures, and require Clang 18+ for bswap instruction support.

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
---
 .../selftests/bpf/progs/verifier_bswap.c      | 321 ++++++++++++++++++
 1 file changed, 321 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index e61755656e8d..76d4fb3fc52c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -48,6 +48,327 @@ __naked void bswap_64(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("BSWAP16 network - port number routing with tnum")
+__success __log_level(2)
+__msg("w0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))") __msg("r0 = bswap16 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))")
+__naked void bswap16_port_routing(void)
+{
+	asm volatile ("					\
+	/* Simulate reading port number from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract byte range 0x0000-0x3f00 */		\
+	w0 &= 0x3f00;					\
+	/* Convert network byte order to host order */	\
+	r0 = bswap16 r0;				\
+	/* Verify range - if tnum works correctly, trap path is dead code */	\
+	if r0 > 0x3f goto trap_%=;			\
+	r0 = 0;						\
+	exit;						\
+trap_%=:	/* Should never reach - r0 must be in [0, 0x3f] */	\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("BSWAP32 network - IPv4 subnet routing with tnum")
+__success __log_level(2)
+__msg("w0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))") __msg("r0 = bswap32 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=0x3f0000,var_off=(0x0; 0x3f0000))")
+__naked void bswap32_ipv4_subnet_routing(void)
+{
+	asm volatile ("					\
+	/* Simulate reading IPv4 from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract second byte (subnet ID) 0x0000-0x3f00 */	\
+	w0 &= 0x3f00;					\
+	/* Convert network byte order to host order */	\
+	r0 = bswap32 r0;				\
+	/* Verify bswap32 result - if tnum works correctly, trap path is dead code */	\
+	if r0 > 0x3f0000 goto trap_%=;			\
+	r0 = 0;						\
+	exit;						\
+trap_%=:	/* Should never reach - r0 must be in [0, 0x3f0000] */	\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("BSWAP64 network - IPv6 subnet routing with tnum")
+__success __log_level(2)
+__msg("r0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))") __msg("r0 = bswap64 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=0x3f000000000000,smax32=umax32=0,var_off=(0x0; 0x3f000000000000))")
+__naked void bswap64_ipv6_subnet_routing(void)
+{
+	asm volatile ("					\
+	/* Simulate reading IPv6 from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract second byte (subnet ID) 0x0000-0x3f00 */	\
+	r0 &= 0x3f00;					\
+	/* Convert network byte order to host order */	\
+	r0 = bswap64 r0;				\
+	/* Verify bswap64 result - if tnum works correctly, trap path is dead code */	\
+	r2 = 0x3f000000000000 ll;	/* Load 64-bit constant */	\
+	if r0 > r2 goto trap_%=;			\
+	r0 = 0;						\
+	exit;						\
+trap_%=:	/* Should never reach - r0 must be in [0, 0x3f000000000000] */	\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("BE16 (to big endian) network - endian conversion with tnum")
+__success __log_level(2)
+__msg("w0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+/* Little endian: be16 = bswap16 */
+__msg("r0 = be16 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))")
+#else
+/* Big endian: be16 = _to_u16 (truncation) */
+__msg("r0 = be16 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#endif
+__naked void be16_network(void)
+{
+	asm volatile ("					\
+	/* Simulate reading from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract byte range 0x0000-0x3f00 */		\
+	w0 &= 0x3f00;					\
+	/* Convert to big endian */			\
+	r0 = be16 r0;					\
+	/* Verify range - if tnum works correctly, trap path is dead code */	\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"if r0 > 0x3f goto trap_%=;			\
+"
+#else
+	"if r0 > 0x3f00 goto trap_%=;			\
+"
+#endif
+	"r0 = 0;					\
+	exit;						\
+trap_%=:	/* Should never reach */		\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("BE32 (to big endian) network - endian conversion with tnum")
+__success __log_level(2)
+__msg("w0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+/* Little endian: be32 = bswap32 */
+__msg("r0 = be32 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=0x3f0000,var_off=(0x0; 0x3f0000))")
+#else
+/* Big endian: be32 = _to_u32 (truncation) */
+__msg("r0 = be32 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#endif
+__naked void be32_network(void)
+{
+	asm volatile ("					\
+	/* Simulate reading from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract byte range 0x0000-0x3f00 */		\
+	w0 &= 0x3f00;					\
+	/* Convert to big endian */			\
+	r0 = be32 r0;					\
+	/* Verify range - if tnum works correctly, trap path is dead code */	\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"if r0 > 0x3f0000 goto trap_%=;			\
+"
+#else
+	"if r0 > 0x3f00 goto trap_%=;			\
+"
+#endif
+	"r0 = 0;					\
+	exit;						\
+trap_%=:	/* Should never reach */		\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("BE64 (to big endian) network - endian conversion with tnum")
+__success __log_level(2)
+__msg("r0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+/* Little endian: be64 = bswap64 */
+__msg("r0 = be64 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=0x3f000000000000,smax32=umax32=0,var_off=(0x0; 0x3f000000000000))")
+#else
+/* Big endian: be64 = no-op */
+__msg("r0 = be64 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#endif
+__naked void be64_network(void)
+{
+	asm volatile ("					\
+	/* Simulate reading from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract byte range 0x0000-0x3f00 */		\
+	r0 &= 0x3f00;					\
+	/* Convert to big endian */			\
+	r0 = be64 r0;					\
+	/* Verify range - if tnum works correctly, trap path is dead code */	\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r2 = 0x3f000000000000 ll;	/* Load 64-bit constant */	\
+	if r0 > r2 goto trap_%=;			\
+"
+#else
+	"if r0 > 0x3f00 goto trap_%=;			\
+"
+#endif
+	"r0 = 0;					\
+	exit;						\
+trap_%=:	/* Should never reach */		\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("LE16 (to little endian) network - endian conversion with tnum")
+__success __log_level(2)
+__msg("w0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+/* Little endian: le16 = _to_u16 (truncation) */
+__msg("r0 = le16 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#else
+/* Big endian: le16 = bswap16 */
+__msg("r0 = le16 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))")
+#endif
+__naked void le16_network(void)
+{
+	asm volatile ("					\
+	/* Simulate reading from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract byte range 0x0000-0x3f00 */		\
+	w0 &= 0x3f00;					\
+	/* Convert to little endian */			\
+	r0 = le16 r0;					\
+	/* Verify range - if tnum works correctly, trap path is dead code */	\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"if r0 > 0x3f00 goto trap_%=;			\
+"
+#else
+	"if r0 > 0x3f goto trap_%=;			\
+"
+#endif
+	"r0 = 0;					\
+	exit;						\
+trap_%=:	/* Should never reach */		\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("LE32 (to little endian) network - endian conversion with tnum")
+__success __log_level(2)
+__msg("w0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+/* Little endian: le32 = _to_u32 (truncation) */
+__msg("r0 = le32 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#else
+/* Big endian: le32 = bswap32 */
+__msg("r0 = le32 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=0x3f0000,var_off=(0x0; 0x3f0000))")
+#endif
+__naked void le32_network(void)
+{
+	asm volatile ("					\
+	/* Simulate reading from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract byte range 0x0000-0x3f00 */		\
+	w0 &= 0x3f00;					\
+	/* Convert to little endian */			\
+	r0 = le32 r0;					\
+	/* Verify range - if tnum works correctly, trap path is dead code */	\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"if r0 > 0x3f00 goto trap_%=;			\
+"
+#else
+	"if r0 > 0x3f0000 goto trap_%=;			\
+"
+#endif
+	"r0 = 0;					\
+	exit;						\
+trap_%=:	/* Should never reach */		\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("LE64 (to little endian) network - endian conversion with tnum")
+__success __log_level(2)
+__msg("r0 &= 16128 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+/* Little endian: le64 = no-op */
+__msg("r0 = le64 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))")
+#else
+/* Big endian: le64 = bswap64 */
+__msg("r0 = le64 r0 {{.*}}; R0=scalar(smin=smin32=0,smax=umax=0x3f000000000000,smax32=umax32=0,var_off=(0x0; 0x3f000000000000))")
+#endif
+__naked void le64_network(void)
+{
+	asm volatile ("					\
+	/* Simulate reading from network packet */	\
+	call %[bpf_get_prandom_u32];			\
+	/* Extract byte range 0x0000-0x3f00 */		\
+	r0 &= 0x3f00;					\
+	/* Convert to little endian */			\
+	r0 = le64 r0;					\
+	/* Verify range - if tnum works correctly, trap path is dead code */	\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"if r0 > 0x3f00 goto trap_%=;			\
+"
+#else
+	"r2 = 0x3f000000000000 ll;	/* Load 64-bit constant */	\
+	if r0 > r2 goto trap_%=;			\
+"
+#endif
+	"r0 = 0;					\
+	exit;						\
+trap_%=:	/* Should never reach */		\
+	r1 = 42;	/* r1 = scalar for trap */	\
+	r0 = *(u64 *)(r1 + 0);	/* Invalid: scalar dereference */	\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #else
 
 SEC("socket")
-- 
2.52.0

