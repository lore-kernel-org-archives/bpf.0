Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1638C2DE;
	Tue, 23 Jun 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236087; cv=none; b=hDxjElvz1sLNgHcdB3h+NS5vk4hOr1LEFOVOgxvarakah0UECmtcU03TTddJxDMRlNqT5+LGYzSydw1PaKSIzKFo1UYOT5KhATbAXjxoUfmBlsF9QY+x6izS18YXqyAqPhJhbEAS3RI+tIm2WKADYXTbj1fMgj/RoWlgioLBSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236087; c=relaxed/simple;
	bh=tGc+DsLWLVZmsJ8f7Q3mGERneX4bO2jZXgT1g+kgfaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZaPnyNyncyub8r1QhnJ295wWXaGkTLxvLnyyctzWbRh4Lo314yLzzARgljlacs6QCLa4rpTITRabEaNRHzvDX2+YAo1ehmgs8jV8nQk2yJBx/HIZOD5kLPqplYLcObF5thgJxAe/NxxUyVr3fK2GRQZZeWzrEIoosBqIS7dsJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=qpwKUVoh; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="qpwKUVoh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=gvK1xxyab+zPTlurcKxkwrhGybVNMZI6D4
	DqAPghVhQ=; b=qpwKUVohrJSvAI8NyHLCtnXczD0t2IyzPh/CMgfwlukjAxg/i9
	8A6Laxd6R/qwt8k/Qcbu0sTWBgaedbn5tBowEdpe1QRe8lnQ1HX0CUGTKTvyI5nN
	7stIYfKh2eVGcUYVbXrodeUj8K0eY/7svw6/zaPUrXpiNKcu5wkdSmFQE=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQBnP5eYwzpqIo19Ag--.49585S3;
	Wed, 24 Jun 2026 01:34:35 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: Reject MEM_ALLOC BTF accesses past object bounds
Date: Tue, 23 Jun 2026 17:34:12 +0000
Message-Id: <703a2cbfeb17ae707fa4a003b795c5326cc0abb8.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQBnP5eYwzpqIo19Ag--.49585S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWfWFy8XF1fWrWxXrykAFb_yoW8KFWUpF
	4rK3srArWFyrWxu3ZxJa15uF4ftFs5Xa1UCF98t34Fvrs0qr1qqF4kKry7Z34Yyr4DC3WI
	qr1qg398ua1xJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
	GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRLiSJUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

BTF struct walks relax the struct-size check for accesses through a
trailing flexible array. That is valid for ordinary BTF type walking, but
PTR_TO_BTF_ID | MEM_ALLOC values point to objects allocated with the static
BTF type size.

When walking a MEM_ALLOC object, reject the access before applying the
flexible-array relaxation if the access range extends past the struct size.
This keeps verifier-approved BTF accesses within the bytes provided by the
allocation kfunc.

Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
Fixes: 36d8bdf75a93 ("bpf: Add alloc/xchg/direct_access support for local percpu kptr")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/btf.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15ae7c43f..3e68af9c1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7069,7 +7069,7 @@ enum bpf_struct_walk_result {
 static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			   const struct btf_type *t, int off, int size,
 			   u32 *next_btf_id, enum bpf_type_flag *flag,
-			   const char **field_name)
+			   const char **field_name, bool is_alloc)
 {
 	u32 i, moff, mtrue_end, msize = 0, total_nelems = 0;
 	const struct btf_type *mtype, *elem_type = NULL;
@@ -7096,11 +7096,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		*flag |= PTR_UNTRUSTED;
 
 	if (off + size > t->size) {
+		struct btf_array *array_elem;
+
+		if (is_alloc)
+			goto error;
+
 		/* If the last element is a variable size array, we may
 		 * need to relax the rule.
 		 */
-		struct btf_array *array_elem;
-
 		if (vlen == 0)
 			goto error;
 
@@ -7363,7 +7366,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
 
 	t = btf_type_by_id(btf, id);
 	do {
-		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag, field_name);
+		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag,
+				      field_name, type_is_alloc(reg->type));
 
 		switch (err) {
 		case WALK_PTR:
@@ -7441,7 +7445,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 	type = btf_type_by_id(btf, id);
 	if (!type)
 		return false;
-	err = btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL);
+	err = btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL, false);
 	if (err != WALK_STRUCT)
 		return false;
 
-- 
2.34.1

