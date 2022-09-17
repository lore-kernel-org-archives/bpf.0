Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5987ECAAD3
	for <bpf@archiver.kernel.org>; Sat, 17 Sep 2022 15:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIQPNa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 17 Sep 2022 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIQPN2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 11:13:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC04E2B1B8
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 08:13:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MVDt72g84zKNMG
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 23:11:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMO5CVjskryAw--.61987S6;
        Sat, 17 Sep 2022 23:13:23 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next 02/10] bpf: Add helper btf_type_is_bpf_dynptr()
Date:   Sat, 17 Sep 2022 23:31:17 +0800
Message-Id: <20220917153125.2001645-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220917153125.2001645-1-houtao@huaweicloud.com>
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMO5CVjskryAw--.61987S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CrykJr1fCFyfCF1ktF1fJFb_yoW8AF4Upa
        1DJayxZr48JrWagw1DWa15Cw43Kw4UGw4jyFy2g343tFZIqr9rXF4DKr1xuryYkrWjkr17
        ZrnIg398A34xArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Add helper btf_type_is_bpf_dynptr() to check whether or not the passed
btf type is bpf_dynptr. It will be used by bpf map (e.g. qp-trie) which
uses bpf_dynptr as map key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/btf.h | 1 +
 kernel/bpf/btf.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1fcc833a8690..d52f9979ea49 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -156,6 +156,7 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 					  const struct btf_type *t);
+bool btf_type_is_bpf_dynptr(const struct btf *btf, const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b3940c605aac..f94b6112a649 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3522,6 +3522,13 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	return ERR_PTR(ret);
 }
 
+bool btf_type_is_bpf_dynptr(const struct btf *btf, const struct btf_type *t)
+{
+	return __btf_type_is_struct(t) &&
+	       t->size == sizeof(struct bpf_dynptr) &&
+	       !strcmp("bpf_dynptr", __btf_name_by_offset(btf, t->name_off));
+}
+
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
 			      u32 type_id, void *data, u8 bits_offset,
 			      struct btf_show *show)
-- 
2.29.2

