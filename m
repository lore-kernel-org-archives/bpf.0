Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8692EF653;
	Mon, 15 Jun 2026 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512281; cv=none; b=swDKI5LPB9G594fBO92G+6PngFqnTKww0P7tmbhAdurg07HBXcyxiw2dhGQ1HBsv+DNPGXAKZtBhT2Fp0Mtbu9BlZaE6HBOemJmtg9F8bgIDYD88R0P3RudworZHDFqB+Uxg/N5i9TV6Y1GX0GqCQkiNIp9EY2wDH8tBx5YS8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512281; c=relaxed/simple;
	bh=kRNFVPm1/9VJwVKnAzDE24iu+WJ8qLzeqvdUQY2+XGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndMgtJ0bljnN5lHHpTn1olYRGCGdfZw4j26/7AcgUlSVH3KaqY7bbgAGcstpRg9GiiMQiLyhNVejHK2agQoo/dLZ3TOM4oDCdCFEtalqbPHKLmybZ/MhmoA4++GYthjuzQib6B5I/rIOi01RXn42HIhEg4aAiYKlkM4E0H8VPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=S9LCrWQe; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="S9LCrWQe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=XzLW+TXPmwykPo/jRvr7dIC3M2kmMZm
	4OzqCTe2QK1k=; b=S9LCrWQeE0hGZ7FGtvOKv+KYAuMzq7Wg0xkqrOgKftP+dxE
	AvJ7GUV2mGtvZPykLZGUBMO+b/gTXkZPBYKdaaRALGLlSgRiuVDy1aFMdKtAz5dG
	qt3Hdf3wflJ9R+akTjkEYNRQ8WwZQqYjqp/8trYYy6df9jvPrCp3SyPK/ldw=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQBXEMBFuC9qh8JwAg--.40355S4;
	Mon, 15 Jun 2026 16:31:03 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 15 Jun 2026 16:31:02 +0800
Subject: [PATCH bpf 2/2] selftests/bpf: Cover dynptr probe-read kfunc
 capability gate
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-f01-07-dynptr-probe-read-cap-v1-2-e626cd61a381@mails.tsinghua.edu.cn>
References: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Mykyta Yatsenko <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781512263; l=5979;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=kRNFVPm1/9VJwVKnAzDE24iu+WJ8qLzeqvdUQY2+XGw=;
 b=O0DKuU2/kcLK8+0q9hn0qPPXzaFHWJv51zs3bCIHdTevZVNMpVRWVFCrLu6t0yi3s8NB1W9tC
 oKhApsLX0NMBoDcew7aTKbc1lxGZPnrKBlop4qBiyd5jGwOglyxMF7s
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQBXEMBFuC9qh8JwAg--.40355S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr13Zr4UKFW8GryfGrWktFb_yoWxJF45pF
	WkC34Y9r1FqF17Jry2yw4DXF4rKrs7Xr43GrWvqryfZr48Xr93ur4SgF4UtFn8KrWqgw4Y
	vw1IqFZ5GFWUJFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjcIDcUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgETA2ovr8QSegABsU

Add focused dynptr selftest programs that load socket-filter programs using
bpf_dynptr_from_mem() followed by each nofault probe-read dynptr kfunc:
bpf_probe_read_user_dynptr(), bpf_probe_read_kernel_dynptr(),
bpf_probe_read_user_str_dynptr(), and bpf_probe_read_kernel_str_dynptr().
Declare the dynptr kfuncs used by this BPF object locally in
dynptr_success.c so the dynptr BPF object builds with explicit prototypes.

The harness first verifies that the program loads with the caller's normal
capabilities. It then drops CAP_PERFMON and CAP_SYS_ADMIN while keeping
CAP_BPF effective and expects each same program load to fail with -EACCES.

This covers the policy boundary that these dynptr probe-read kfuncs should
not be callable with CAP_BPF alone.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c    | 66 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c | 75 ++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 5fda11590708..5235b47e3342 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -3,6 +3,7 @@
 
 #include <test_progs.h>
 #include <network_helpers.h>
+#include "cap_helpers.h"
 #include "dynptr_fail.skel.h"
 #include "dynptr_success.skel.h"
 
@@ -53,8 +54,66 @@ static struct {
 	{"test_copy_from_user_task_str_dynptr", SETUP_SYSCALL_SLEEP},
 };
 
+static const char * const probe_read_cap_tests[] = {
+	"test_probe_read_user_dynptr_cap",
+	"test_probe_read_kernel_dynptr_cap",
+	"test_probe_read_user_str_dynptr_cap",
+	"test_probe_read_kernel_str_dynptr_cap",
+};
+
 #define PAGE_SIZE_64K 65536
 
+static int load_probe_read_cap_prog(const char *prog_name)
+{
+	struct bpf_program *prog, *tmp;
+	struct dynptr_success *skel;
+	int err;
+
+	skel = dynptr_success__open();
+	if (!ASSERT_OK_PTR(skel, "dynptr_success__open"))
+		return -EINVAL;
+
+	bpf_object__for_each_program(tmp, skel->obj)
+		bpf_program__set_autoload(tmp, false);
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name")) {
+		err = -ENOENT;
+		goto cleanup;
+	}
+
+	bpf_program__set_autoload(prog, true);
+	err = dynptr_success__load(skel);
+
+cleanup:
+	dynptr_success__destroy(skel);
+	return err;
+}
+
+static void verify_probe_read_cap(const char *prog_name)
+{
+	__u64 old_caps = 0;
+	int err;
+
+	err = load_probe_read_cap_prog(prog_name);
+	if (!ASSERT_OK(err, "full_caps_load"))
+		return;
+
+	err = cap_enable_effective(1ULL << CAP_BPF, &old_caps);
+	if (!ASSERT_OK(err, "enable_cap_bpf"))
+		return;
+
+	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFMON, NULL);
+	if (!ASSERT_OK(err, "disable_cap_sys_admin_perfmon"))
+		goto restore_cap;
+
+	err = load_probe_read_cap_prog(prog_name);
+	ASSERT_EQ(err, -EACCES, "cap_bpf_without_perfmon_load");
+
+restore_cap:
+	cap_enable_effective(old_caps, NULL);
+}
+
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
 {
 	char user_data[384] = {[0 ... 382] = 'a', '\0'};
@@ -185,6 +244,13 @@ void test_dynptr(void)
 {
 	int i;
 
+	for (i = 0; i < ARRAY_SIZE(probe_read_cap_tests); i++) {
+		if (!test__start_subtest(probe_read_cap_tests[i]))
+			continue;
+
+		verify_probe_read_cap(probe_read_cap_tests[i]);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(success_tests); i++) {
 		if (!test__start_subtest(success_tests[i].prog_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e0745b6e467e..5b4e22198598 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -34,6 +34,13 @@ struct {
 	__type(value, __u32);
 } array_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u8[32]);
+} probe_read_map SEC(".maps");
+
 SEC("?tp/syscalls/sys_enter_nanosleep")
 int test_read_write(void *ctx)
 {
@@ -1092,6 +1099,74 @@ int test_probe_read_kernel_str_dynptr(struct xdp_md *xdp)
 	return XDP_PASS;
 }
 
+SEC("?socket")
+int test_probe_read_user_dynptr_cap(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u32 key = 0;
+	void *value;
+
+	value = bpf_map_lookup_elem(&probe_read_map, &key);
+	if (!value)
+		return 0;
+
+	if (bpf_dynptr_from_mem(value, 32, 0, &ptr))
+		return 0;
+
+	return bpf_probe_read_user_dynptr(&ptr, 0, 8, value);
+}
+
+SEC("?socket")
+int test_probe_read_kernel_dynptr_cap(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u32 key = 0;
+	void *value;
+
+	value = bpf_map_lookup_elem(&probe_read_map, &key);
+	if (!value)
+		return 0;
+
+	if (bpf_dynptr_from_mem(value, 32, 0, &ptr))
+		return 0;
+
+	return bpf_probe_read_kernel_dynptr(&ptr, 0, 8, value);
+}
+
+SEC("?socket")
+int test_probe_read_user_str_dynptr_cap(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u32 key = 0;
+	void *value;
+
+	value = bpf_map_lookup_elem(&probe_read_map, &key);
+	if (!value)
+		return 0;
+
+	if (bpf_dynptr_from_mem(value, 32, 0, &ptr))
+		return 0;
+
+	return bpf_probe_read_user_str_dynptr(&ptr, 0, 8, value);
+}
+
+SEC("?socket")
+int test_probe_read_kernel_str_dynptr_cap(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u32 key = 0;
+	void *value;
+
+	value = bpf_map_lookup_elem(&probe_read_map, &key);
+	if (!value)
+		return 0;
+
+	if (bpf_dynptr_from_mem(value, 32, 0, &ptr))
+		return 0;
+
+	return bpf_probe_read_kernel_str_dynptr(&ptr, 0, 8, value);
+}
+
 SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
 int test_copy_from_user_dynptr(void *ctx)
 {

-- 
2.34.1

