Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E2369D57
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187766; cv=none; b=k8OziusY5x2KLYTNfNFKMuvJ81Dl+rAty0JJKwDFlFRSS6Y2R0M85oznsREW+jXQVw0Y0iKHBDKuriHn6ErFKZYADhONorGYRdzh5npTP/6hZgdZj+Gcq4n2uWwMKWUi7bq5ePCEjtIoMIroCs4+2PlJcv1jQL2ZYBsPMZo5h7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187766; c=relaxed/simple;
	bh=LNT6YcyLbXAG1yWhR2ERK8jl/auyMXLmzVwA/qk2LR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GENhDSrqBLi64zkbgk1JvD/RDKFpA5vfopVPV8uaz8uLoZ6+fKRlQGGcKKcrTjk5WEcjQ/SZs555fcLxuwfyydwE3oKtGKAzH/EKBcpQKsrcW0m6e8DQdEpusqHHfKvkuGQHlxpJ7XqGzaheVGosym5zJ0X4eMeiu5j7WXMzOFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CTBYDS3h; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CTBYDS3h"
Message-ID: <feda101c-6514-4ea0-b02f-a04b369a612d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779187761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLXJs8LycZcvKaJYylyDE7SjYym6xbt1uCA8DeNxrkE=;
	b=CTBYDS3hE3uo4Bnr/myYqTB9Z8/hvx8N3KDBzOzN7TbYxfvsvQvBuhbJLVMMP+QMH3QyKg
	Q9C+UuXVrKRgYOIgfGy9fzv38GRzApIKQBa9r1JsQ+dt6mdHN3mfCO+u7mO+4t0ljeRthB
	ZLtXVoEEarjFdv4bkIyOr2gDx67UIOI=
Date: Tue, 19 May 2026 18:48:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in
 map_create()
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260518145446.6794-3-leon.hwang@linux.dev>
 <18095298384649847dcbe0293f6b710a1382f9ee3eb9aa2bf8f6d02e56a1f0c4@mail.kernel.org>
 <6d869149-49b2-4a7a-8ed1-7db9b6af8542@linux.dev>
 <CAADnVQ+rBXAWojPPd40XSkqCM_4XWEqu+_GqCWNkDbi13makcw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+rBXAWojPPd40XSkqCM_4XWEqu+_GqCWNkDbi13makcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 19/5/26 11:05, Alexei Starovoitov wrote:
> On Mon, May 18, 2026 at 7:48 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 18/5/26 23:40, bot+bpf-ci@kernel.org wrote:
[...]
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 20c421b43849..a10ef58bb6ea 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -788,6 +788,7 @@ struct bpf_log_attr {
>>         u32 level;
>>         u32 offsetof_true_size;
>>         bpfptr_t uattr;
>> +       bool finalized;
>>  };
> 
> No. That looks worse.
> The suggestion was to do the finalize log _once_ before
> allocating FD.

Understand the suggestion.

When tried to finalize log once without "finalized" guard, it seemed
complicated to modify __map_create() to make sure finalize log once on
all code logic paths.

> Why are you doing it twice?

So, to simplify the change, finalize log the second time with the
"finalized" guard to cover all the check-failure paths.

After thinking hardly, the below patch is the way to make sure finalize
log once before security_bpf_map_create().

It works, but it is not good enough.

Thanks,
Leon

---

From 80f697c30e830786a57787f370299d4e3335fbbc Mon Sep 17 00:00:00 2001
From: Leon Hwang <leon.hwang@linux.dev>
Date: Tue, 19 May 2026 15:32:45 +0800
Subject: [PATCH bpf-next v2] bpf: Fix concurrent regression in map_create()

Because there is time gap between bpf_map_new_fd() and close_fd(), a
concurrent thread is able to close the new fd and opens a new, unrelated
file with the exact same fd number. Thereafter, this close_fd() might
inadvertently close the unrelated file.

To avoid such regression, do finalize log before security_bpf_map_create().

However, to achieve it, move bpf_get_file_flag(),
security_bpf_map_create(), bpf_map_alloc_id(), and bpf_map_new_fd() from
__map_create() to map_create(). And, rename __map_create() to
map_create_alloc() meanwhile.

Fixes: 49f9b2b2a18c ("bpf: Add syscall common attributes support for
map_create")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 79 ++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83de8fb9b9aa..e815457f5b24 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1359,7 +1359,8 @@ static int map_check_btf(struct bpf_map *map,
struct bpf_token *token,

 #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
-static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct
bpf_verifier_log *log)
+static int map_create_alloc(union bpf_attr *attr, bpfptr_t uattr,
struct bpf_verifier_log *log,
+			    struct bpf_map **mapp, struct bpf_token **tokenp)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1367,7 +1368,6 @@ static int __map_create(union bpf_attr *attr,
bpfptr_t uattr, struct bpf_verifie
 	u32 map_type = attr->map_type;
 	struct bpf_map *map;
 	bool token_flag;
-	int f_flags;
 	int err;

 	err = CHECK_ATTR(BPF_MAP_CREATE);
@@ -1403,10 +1403,6 @@ static int __map_create(union bpf_attr *attr,
bpfptr_t uattr, struct bpf_verifie
 		return -EINVAL;
 	}

-	f_flags = bpf_get_file_flag(attr->map_flags);
-	if (f_flags < 0)
-		return f_flags;
-
 	if (numa_node != NUMA_NO_NODE &&
 	    ((unsigned int)numa_node >= nr_node_ids ||
 	     !node_online(numa_node))) {
@@ -1598,6 +1594,48 @@ static int __map_create(union bpf_attr *attr,
bpfptr_t uattr, struct bpf_verifie
 		goto free_map;
 	}

+	*mapp = map;
+	*tokenp = token;
+	return 0;
+
+free_map:
+	bpf_map_free(map);
+put_token:
+	bpf_token_put(token);
+	return err;
+}
+
+static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct
bpf_common_attr *attr_common,
+		      bpfptr_t uattr_common, u32 size_common)
+{
+	struct bpf_token *token = NULL;
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr attr_log;
+	struct bpf_map *map = NULL;
+	int err, ret;
+	int f_flags;
+
+	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common,
size_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
+	err = map_create_alloc(attr, uattr, log, &map, &token);
+
+	/* preserve original error even if log finalization is successful */
+	ret = bpf_log_attr_finalize(&attr_log, log);
+	if (ret)
+		err = ret;
+	kfree(log);
+
+	if (err)
+		goto free_map;
+
+	f_flags = bpf_get_file_flag(attr->map_flags);
+	if (f_flags < 0) {
+		err = f_flags;
+		goto free_map;
+	}
+
 	err = security_bpf_map_create(map, attr, token, uattr.is_kernel);
 	if (err)
 		goto free_map_sec;
@@ -1626,37 +1664,12 @@ static int __map_create(union bpf_attr *attr,
bpfptr_t uattr, struct bpf_verifie
 free_map_sec:
 	security_bpf_map_free(map);
 free_map:
-	bpf_map_free(map);
-put_token:
+	if (map)
+		bpf_map_free(map);
 	bpf_token_put(token);
 	return err;
 }

-static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct
bpf_common_attr *attr_common,
-		      bpfptr_t uattr_common, u32 size_common)
-{
-	struct bpf_verifier_log *log;
-	struct bpf_log_attr attr_log;
-	int err, ret;
-
-	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common,
size_common);
-	if (IS_ERR(log))
-		return PTR_ERR(log);
-
-	err = __map_create(attr, uattr, log);
-
-	/* preserve original error even if log finalization is successful */
-	ret = bpf_log_attr_finalize(&attr_log, log);
-	if (ret) {
-		if (err >= 0)
-			close_fd(err);
-		err = ret;
-	}
-
-	kfree(log);
-	return err;
-}
-
 void bpf_map_inc(struct bpf_map *map)
 {
 	atomic64_inc(&map->refcnt);
-- 
2.54.0



