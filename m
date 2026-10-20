Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504163;
	b=qOKdcTXwbV8r5nDZmCEJOdcm6UcAvI6iynMasjRXJe7kaaH4SSWIjYMoYvh49IA3PDyW
	 uoCIpi95KigHswOyJbSJnCutT0303pC63qe19BhmRGKvMl4IxJm+9RwBSHm+MtYMu1VH0
	 4uYwlAE0XVCmA+H8daXzfoYJgWgTmb2EflvYA+vuFkONzaA2WtOpzvIo8GvNQe/qSxzhv
	 CnVeX0ONQPlFJF55LJINH3XJagBTVV0zOEAJdsYBX7AfWpkxP7IL0+8Mf+Pipqa3GZUMV
	 nzoU6dZASNXFPw20ODKBQc3h7Ec3VIGLcqzzvCgTTiuJiT/Ntkr3dmGAyLDTc/fIFqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504163;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=B4XBOXR54p8X1Gek+q5qNs74yiXGndZ+GxTQ8y5U1u8=;
	b=OOkoCgBaTSmY7Cea1LgJKzTvLrBde0mRVYgw3RPDdPAcekkP2ADbSm6NsrTw3JB57PfU
	 Jkuh9iXltwWTkq7PwcBgHvrmHie7A6EECIWO3qp2jzihxBOSuOAUFvVVIsM0jXwMrRTGY
	 osLlen5JX4ZyLXJ/PVJ1TC3e4YlM41uuEYPbg9Xh6LieTQyUw4LzVH83bUhUWH7Wvy89N
	 Em0R+Gm38tL3wNySNP/8Ts5AfS8uIfJmDf0RHzElSXqUWVxt7lcFgqeJ807ur64Md7yGO
	 VmI8h3rYDWICGlYScboHfG3lNaZSX/KCozTutl8moCickpb1TZ0xLlJ7CSWkub/Ak7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF3606AB37;
	Tue, 20 Oct 2026 13:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBF3606AB37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn0pLNzYQtvV;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 19894408EF;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S5;
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
Subject: [PATCH bpf-next 03/16] libbpf: Place the percpu chunks in the bpf arena
Date: Tue, 20 Oct 2026 13:22:48 +0000
Message-ID: <71de6bedb308d1ad6841c0071944426944a5d0ae.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3Gr47JF1DAr4xCr1xKrg_yoW8ZF1kpr
	4fGw12gFZ8Jrn5uw4UWr4rJrW5uFn5Xayxt3W7tFy8Zr17ZF4UG34jya1FyFy5X3yfZr1U
	ta4jqrnrXF4DJr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzo7KUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Place the percpu chunks in the bpf arena, alongside the global arena
data.

When full-range ldimm64 offset is supported, the global data sits at
the end of the arena, place the percpu chunks right before it:

+------------+---------+---------+----+---------+--------+
|            | percpu  | percpu  |... | percpu  | global |
|            | chunk 0 | chunk 1 |    | chunk N | data   |
+------------+---------+---------+----+---------+--------+

Otherwise, the global data region sits at the beginning, place the
percpu chunks right after it:

+---------+---------+---------+----+---------+------------+
| global  | percpu  | percpu  |... | percpu  |            |
| data    | chunk 0 | chunk 1 |    | chunk N |            |
+---------+---------+---------+----+---------+------------+

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/libbpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 02ee57e3f6c7..6fc8c7f549d9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -833,6 +833,7 @@ struct bpf_object {
 		void *chunk; /* copy from section .arena.percpu, zero-padded to chunk size */
 		size_t chunk_sz;	/* chunk size, page-aligned */
 		size_t nr_chunks;	/* how many chunks, one chunk per possible cpu */
+		size_t offset;		/* offset within the arena */
 		bool present;
 	} arena_percpu;
 
@@ -8212,8 +8213,12 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		}
 
 		/* place globals at the end of the arena (if supported) */
-		if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
-			obj->arena_data_off = mmap_sz - data_sz;
+		if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF)) {
+			obj->arena_data_off = data_sz ? mmap_sz - data_sz : 0;
+			obj->arena_percpu.offset = mmap_sz - data_sz - percpu_sz;
+		} else {
+			obj->arena_percpu.offset = data_sz;
+		}
 	}
 
 	err = bpf_object__relocate_data_ptrs(obj);
-- 
2.47.3

