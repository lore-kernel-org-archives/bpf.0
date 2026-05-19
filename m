Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840721E097
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158932; cv=none; b=XkxXaAszSuIs5LHe/QgOdbQdCjWGkh+qAYLvQ+n4ukduSZVZaQdfkPAzTr1ghdK3tfW9uzs2MSXZkzn17kalfrWpkLD2F/ck74kRgthJwTHYg1JaKH4bORb0tMSsCKnSWvc7m20auzkbm5xpMKvmTsuBm/fUzLftOoyuiBWN2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158932; c=relaxed/simple;
	bh=pc8un1JyFeid330FM0SEG8awLeKBIELwtgDcA18mFgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEUkJwH/tiR7h4/6UcGkXNn/kmanRN2t7l4tdHYuI1iIXuKIywl/w4rxeJTmmrv+ffr/2w3UNAPic923eseMZZkXoPj5oBwJ1dKbfdgvGiZ0+t9sS3VzoyPAdF0HyzT/G6PTu0xUE4yat/unqZH/fOR4lOt6sol/Y/o172dtNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nj1TRCcE; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nj1TRCcE"
Message-ID: <6d869149-49b2-4a7a-8ed1-7db9b6af8542@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779158922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWvVSYcvQ1eF9JjPFwpjh2OuV7mK+T1jCBEgRtYd1A0=;
	b=Nj1TRCcEsMgab3vt9QrDD0BuSCYukMSdiqNJVI905E4XnuGOvOa+0gV6l6jltfMaaH/zrm
	zo/ShVskeWXh0u+lUxG75CqR/NSAscw3/S8un19ZZM669mAAhrmk2LNxcNTuAkoWlHNmjP
	1a4WipEViUBct4WO3WS4+Dws3Jktkc0=
Date: Tue, 19 May 2026 10:48:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in
 map_create()
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260518145446.6794-3-leon.hwang@linux.dev>
 <18095298384649847dcbe0293f6b710a1382f9ee3eb9aa2bf8f6d02e56a1f0c4@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <18095298384649847dcbe0293f6b710a1382f9ee3eb9aa2bf8f6d02e56a1f0c4@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/5/26 23:40, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 83de8fb9b9aa..322865a88b3a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1647,11 +1647,18 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_at
>>
>>  	/* preserve original error even if log finalization is successful */
>>  	ret = bpf_log_attr_finalize(&attr_log, log);
>> -	if (ret) {
>> -		if (err >= 0)
>> -			close_fd(err);
>> +	if (ret && err < 0)
>> +		/*
>> +		 * Failed to finalize the log.
>> +		 * Should not close_fd(err) here. Since the bpf_map_new_fd()
>> +		 * has published the map fd, if a concurrent thread closes the
>> +		 * fd, then opens new, unrelated file that receives the exact
>> +		 * same fd number, close_fd(err) might inadvertently close the
>> +		 * unrelated file.
>> +		 * As a trade-off, override the err only when failed to finalize
>> +		 * the log and failed to create map.
>> +		 */
>>  		err = ret;
> 
> In the v13 review thread, Alexei Starovoitov suggested moving
> bpf_log_attr_finalize() earlier in the flow to eliminate the race
> window entirely:
> 
>   "bot is correct. Let's avoid these races. Pls move
>    bpf_log_attr_finalize() into map_create and do it before
>    security_bpf_map_create."
> 
>   https://lore.kernel.org/bpf/CAADnVQ+XR3kyqizGgGhtG5xiBu3oK3O+COUMfPDQDBSJbm=56A@mail.gmail.com/
> 
> Does the current approach fully address the race concern? While removing
> close_fd() prevents the specific file descriptor hijacking issue, the
> suggestion was to finalize the log before security_bpf_map_create(),
> which would avoid creating the race window in the first place.
> 
> Is there a reason why the log finalization cannot be moved earlier as
> Alexei suggested?
> 
I've tried his suggestion, attached below.

However, I think there should be a simpler approach to fix it.

I preferred this simple one, so I posted it.

Should I follow the suggestion instead of this trade-off approach?

Thanks,
Leon

---

From 7ea7ab53d24b7cf34bd2775ef5c871aa312d07c6 Mon Sep 17 00:00:00 2001
From: Leon Hwang <leon.hwang@linux.dev>
Date: Tue, 19 May 2026 10:32:01 +0800
Subject: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in map_create()

Because there is time gap between bpf_map_new_fd() and close_fd(), a
concurrent thread is able to close the new fd and opens a new, unrelated
file with the exact same fd number. Thereafter, this close_fd() might
inadvertently close the unrelated file.

To avoid such regression, add bpf_log_attr_finalize() before
security_bpf_map_create() to report log_true_size on check-success path.

While keep the original bpf_log_attr_finalize() and avoid finalizing
bpf_log_attr twice, guard the finalization using attr_log->finalized.

Fixes: 49f9b2b2a18c ("bpf: Add syscall common attributes support for
map_create")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/log.c             |  4 ++++
 kernel/bpf/syscall.c         | 21 ++++++++++++++-------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 20c421b43849..a10ef58bb6ea 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -788,6 +788,7 @@ struct bpf_log_attr {
 	u32 level;
 	u32 offsetof_true_size;
 	bpfptr_t uattr;
+	bool finalized;
 };

 int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32
log_size, u32 log_level,
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 62fe6ed18374..71e3035515cd 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -894,6 +894,10 @@ int bpf_log_attr_finalize(struct bpf_log_attr
*attr, struct bpf_verifier_log *lo
 	u32 log_true_size;
 	int err;

+	if (attr->finalized)
+		return 0;
+	attr->finalized = true;
+
 	err = bpf_vlog_finalize(log, &log_true_size);

 	if (attr->offsetof_true_size &&
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83de8fb9b9aa..c117e2286cf0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1359,7 +1359,8 @@ static int map_check_btf(struct bpf_map *map,
struct bpf_token *token,

 #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
-static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct
bpf_verifier_log *log)
+static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct
bpf_verifier_log *log,
+			struct bpf_log_attr *attr_log)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1598,6 +1599,10 @@ static int __map_create(union bpf_attr *attr,
bpfptr_t uattr, struct bpf_verifie
 		goto free_map;
 	}

+	err = bpf_log_attr_finalize(attr_log, log);
+	if (err)
+		goto free_map;
+
 	err = security_bpf_map_create(map, attr, token, uattr.is_kernel);
 	if (err)
 		goto free_map_sec;
@@ -1643,15 +1648,17 @@ static int map_create(union bpf_attr *attr,
bpfptr_t uattr, struct bpf_common_at
 	if (IS_ERR(log))
 		return PTR_ERR(log);

-	err = __map_create(attr, uattr, log);
+	err = __map_create(attr, uattr, log, &attr_log);

-	/* preserve original error even if log finalization is successful */
+	/* preserve original error even if log finalization is
+	successful */
+	/*
+	 * No duplicated finalization here because of attr_log->finalized
+	 * guard in bpf_log_attr_finalize().
+	 */
 	ret = bpf_log_attr_finalize(&attr_log, log);
-	if (ret) {
-		if (err >= 0)
-			close_fd(err);
+	if (ret)
 		err = ret;
-	}

 	kfree(log);
 	return err;
-- 
2.54.0


