Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504163;
	b=g1kGfxOBxeLsLbyT9KlRXnFiscpQoR4X5KF9h2hs0ZWI9AXr2XfYZIj/M5kjjthN/nWP
	 3NkrD3lDoDWAzLvvPWP1xbIVOnZq0EZXI38x809PyVN+KhhOy9JvNaHpcyg0OZpKtOIj4
	 GAAw6WSs4Kmx5HIV8swM2f5NdhskmPxO4Fxo1NPeSPyCIasWDslRUY7SDvHSmV2wDCyZi
	 cbGH0Eg6A+htMUQQaMzN35RYHrEmecsKyoOUtRJE65+s0uhP5DrRUAneI7SdUnbLu2ywp
	 9xoR68f+R3TVcSc7l/xBxamuw7YUPlouKM6IBqbv7Nlaqpnv1VDCBTt9PWmHC9dnrfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504163;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=BmlOqCCLjgLQNdIbenYay5d5iN3U5aSR2PVFkG5h4Z4=;
	b=5hJtVNBBUZh1iPkUJsTDkAmFdjLl25pEEmm/gYo3/0WpDprVaQILaYnV6I9ei460ymEf
	 1MS4++TKhuuYZHu27RcSMXnsqttJitGIIQ7uyONFgcCeUgMaLx8uCdqv1kr2yBCm2lljr
	 yi+D4vEasgHj+qHW0tXBxDjLPqRWnGF7m6VzW24Iwj6AJxMM7y0eVIWI3N2wH3Rs3AjGn
	 41p+WdtmCD4b4Adx3bb5bAfa66TuShbXBrev3h83A4lcyPIa7zw71RvodVzb4MSwx3mUn
	 ApIsgHX9DLmlYhxSLq2cCqF8DfJVVRKy56kkbet9KdFzQLPusf4gXrSlirIWwsVvk8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD3606AB1F;
	Tue, 20 Oct 2026 13:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBD3606AB1F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKm6ylSzYQtsK;
	Tue, 20 Oct 2026 21:49:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 00A97408E5;
	Tue, 20 Oct 2026 21:49:18 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S3;
	Tue, 20 Oct 2026 21:49:18 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 01/16] libbpf: Collect arena percpu data section
Date: Tue, 20 Oct 2026 13:22:46 +0000
Message-ID: <7b248b2be4834322ddaad8ee08d22d083877a932.1792503001.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW3ZF4ftrWfWF4fZF4xJFb_yoW5uw4fp3
	y3CFy0gw4rXr4I9w1rZayagryY9r4Fvr109a4Yqw18AryrWw1rXa48tFsYvF1agr1fZr15
	X3y09rWxXrWDAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1hFxUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Introduce a new section ".arena.percpu" for the bpf arena. A variable
in this section lives in the bpf arena and has a separate value for
each possible CPU. The initial value is replicated for each CPU at
load time.

Collect the section's data and index so the later steps can size,
place and relocate it.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/libbpf.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8fcb8cf39cc0..d79fc382319e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -573,6 +573,13 @@ struct bpf_struct_ops {
  */
 #define ARENA_DATA_SEC ".arena.data"
 
+/*
+ * A variable in this section is arena percpu data. It lives in the bpf
+ * arena and has a separate value for each possible CPU. The initial value
+ * is replicated for each CPU at load time.
+ */
+#define ARENA_PERCPU_SEC ".arena.percpu"
+
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
 	LIBBPF_MAP_DATA,
@@ -718,6 +725,7 @@ struct elf_state {
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
 	Elf_Data *arena_data;
+	Elf_Data *arena_percpu_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -728,6 +736,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int arena_percpu_shndx;
 	int jumptables_data_shndx;
 };
 
@@ -1645,6 +1654,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
 	obj->efile.arena_data_shndx = -1;
+	obj->efile.arena_percpu_shndx = -1;
 	obj->kconfig_map_idx = -1;
 	obj->arena_map_idx = -1;
 
@@ -1664,6 +1674,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 	obj->efile.ehdr = NULL;
 	obj->efile.symbols = NULL;
 	obj->efile.arena_data = NULL;
+	obj->efile.arena_percpu_data = NULL;
 
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt = 0;
@@ -3201,7 +3212,7 @@ static int bpf_object__init_arena_data(struct bpf_object *obj)
 
 	if (obj->arena_map_idx < 0) {
 		/* bpf_object__init_user_btf_maps() didn't look: there is no .maps section */
-		if (obj->efile.arena_data) {
+		if (obj->efile.arena_data || obj->efile.arena_percpu_data) {
 			pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
 				ARENA_SEC);
 			return -ENOENT;
@@ -3331,6 +3342,12 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 		return -ENOENT;
 	}
 
+	if (obj->efile.arena_percpu_data && obj->arena_map_idx < 0) {
+		pr_warn("elf: sec '%s': to use arena percpu variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
+			ARENA_PERCPU_SEC);
+		return -ENOENT;
+	}
+
 	return 0;
 }
 
@@ -4286,6 +4303,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				obj->efile.arena_data_shndx = idx;
 			} else if (strcmp(name, ARENA_DATA_SEC) == 0) {
 				/* the marker, see the first pass */
+			} else if (strcmp(name, ARENA_PERCPU_SEC) == 0) {
+				obj->efile.arena_percpu_data = data;
+				obj->efile.arena_percpu_shndx = idx;
 			} else if (strcmp(name, JUMPTABLES_SEC) == 0) {
 				obj->jumptables_data = malloc(data->d_size);
 				if (!obj->jumptables_data)
-- 
2.47.3

