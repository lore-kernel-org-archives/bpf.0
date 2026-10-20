Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504168;
	b=JSKOJrYawtf57Qu55nKgsLDhJP+vy7PwHx5nDn8x40lycrQ4J0sxNIAi10boGC3XvUb9
	 hySZv5htLqYN5H8k7SL4DgOzTf1bo83bCUNIqufZ4hFWb3MYMOLpJy+54S3fo4KbGIPQ7
	 d7lE5SC2ofe7M6MLvEB1tBUVmcz7mT3c7MDIZGFaeUuCJgj0MtZ4Pgc2HmERrg+IKKrqR
	 Q45Yq/BLnC829T0wgXD/LZ4qa1zsZg4b41NllVv2PtDvBj/yF/apFOB7RBlLNGrJW0b+f
	 OdsrQK0fCeEbJNTk/+Gz9NG04mVqm1tnbrTYCoRS9NIUGHjY+Ame1zINVWI3m/BDXNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504168;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Hvi3uCpaINsi13oQBA18SCLqYurMB7l3si8TGKYhMB4=;
	b=Mx68aDFqMmQ0ZGXr3Sq8TmGi7xaAceHSN9/jkYYBUDOGU51/r2IHWcZAv/8RaO72Fubh
	 WJeZbrWFvk5FaW+EnQGI2n60E5ebiESbQ+b4IQtTnw4sfdlFMFcwxUH+7Yu509Ubh7Kmp
	 pncaNjbwoCoaX+ERyjtnN25adbX2nB1lVKmNJDrqt072BkjRwcsIHBAXtaUkpsFuhBeAU
	 ovmNVtWIWQfc1poX0x7lrZpiN9oIlJUtTQKV0eizGuyX6VcbB3o4jxfJGCCB+IFj3cL3S
	 +anloY0Eu+QJEAN3GXaxzj/k2BjBehe1ZoZHHDI4Ub7A7Y+ZD2wrPRov61mwxp48QxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F760A2600;
	Tue, 20 Oct 2026 13:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 684F760A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn4XYNzYQtwQ;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9DC3D40561;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S15;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
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
Subject: [PATCH bpf-next 13/16] bpftool: Emit the arena percpu datasec into skeleton
Date: Tue, 20 Oct 2026 13:22:58 +0000
Message-ID: <a579251a284c3dd4954c305a04346acef4ec4113.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S15
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4kZFWUKryUCFy3ZryUGFg_yoW5uFyxp3
	WxGFWYkrWUXFy3Cw4fWw4UCryY9r4rX34rAa4ak34rAr4fXr4DJFWIk3WYvF15Kr1SqF4Y
	ga4Svr42kry7JF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r
	43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1KFAJUU
	UUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Emit the arena percpu data into skeleton.

For an object with

__u64 arena_global __arena;
__u64 __arena_percpu data1;
__u64 __arena_percpu data2;

the skeleton gets two data sections for the arena map

struct obj__arena {
	__u64 arena_global;
} *arena;

struct obj__arena_percpu {
	__u64 data1;
	__u64 data2;
} *arena_percpu;

and the load function points arena_percpu at cpu 0's chunk

static inline int
obj__load(struct obj *obj)
{
	int err;

	err = bpf_object__load_skeleton(obj->skeleton);
	if (err)
		return err;

	obj->arena_percpu = bpf_map__arena_percpu_base(obj->maps.arena);

	return 0;
}

Other cpus can be accessed through bpf_map__arena_percpu_ptr().

For an object with only

__u64 __arena_percpu counter;

the skeleton carries a single arena_percpu section

struct obj__arena_percpu {
	__u64 counter;
} *arena_percpu;

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/bpf/bpftool/gen.c | 69 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee680f7c2116..8a321ec1155a 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -132,6 +132,10 @@ static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 		snprintf(buf, buf_sz, "arena");
 		return true;
 	}
+	if (strcmp(sec_name, ".arena.percpu") == 0) {
+		snprintf(buf, buf_sz, "arena_percpu");
+		return true;
+	}
 	for  (i = 0, n = ARRAY_SIZE(pfxs); i < n; i++) {
 		const char *pfx = pfxs[i];
 
@@ -326,6 +330,14 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 		}
 	}
 
+	/* expose arena percpu  as a separate data section */
+	sec = find_type_for_map(btf, "arena_percpu");
+	if (sec) {
+		err = codegen_datasec_def(obj, btf, d, sec, obj_name);
+		if (err)
+			goto out;
+	}
+
 
 out:
 	btf_dump__free(d);
@@ -1511,11 +1523,58 @@ static int do_skeleton(int argc, char **argv)
 			return %1$s__open_opts(NULL);			    \n\
 		}							    \n\
 									    \n\
-		static inline int					    \n\
-		%1$s__load(struct %1$s *obj)				    \n\
-		{							    \n\
-			return bpf_object__load_skeleton(obj->skeleton);    \n\
-		}							    \n\
+		",
+		obj_name
+	);
+
+	/* The per-cpu arena data has no mmaped slot in the map skeleton.
+	 * Point obj->arena_percpu at cpu 0's chunk once the object is
+	 * loaded.
+	 */
+	{
+		char arena_map_ident[256] = "";
+		bool have_percpu_arena = false;
+
+		bpf_object__for_each_map(map, obj) {
+			if (bpf_map__type(map) != BPF_MAP_TYPE_ARENA)
+				continue;
+			if (find_type_for_map(bpf_object__btf(obj), "arena_percpu") &&
+			    get_map_ident(map, arena_map_ident, sizeof(arena_map_ident))) {
+				have_percpu_arena = true;
+				break;
+			}
+		}
+
+		if (have_percpu_arena) {
+			codegen("\
+				\n\
+				static inline int \n\
+				%1$s__load(struct %1$s *obj) \n\
+				{ \n\
+					int err; \n\
+					 \n\
+					err = bpf_object__load_skeleton(obj->skeleton); \n\
+					if (err) \n\
+						return err; \n\
+					obj->arena_percpu = \n\
+						bpf_map__arena_percpu_base(obj->maps.%2$s); \n\
+					return 0; \n\
+				} \n\
+				", obj_name, arena_map_ident);
+		} else {
+			codegen("\
+				\n\
+				static inline int \n\
+				%1$s__load(struct %1$s *obj) \n\
+				{ \n\
+					return bpf_object__load_skeleton(obj->skeleton); \n\
+				} \n\
+				", obj_name);
+		}
+	}
+
+	codegen("\
+		\n\
 									    \n\
 		static inline struct %1$s *				    \n\
 		%1$s__open_and_load(void)				    \n\
-- 
2.47.3

