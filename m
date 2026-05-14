Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB08344023
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778955; cv=none; b=OqjLKu2tS1iCdBPodqmBkK4DvvMa7fsTIyW+Vakby7h6AfU14rhioVlh9Z71ZLibD6iRUgkZbLRYAEuXah+YKYEi0KqPD34Xk25vE6/o0iDyH3C0W2PQAEwJjaO+U6wkGWBa4ynPgJ1w+3C0ewCVh/UJacnXaXsrTuX0QAcOQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778955; c=relaxed/simple;
	bh=H3A0sq4vu6CTl962RLjPTrzffENAu82hXZ3C6ccm/VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT08iVnjY8VFH/61WxCp8thdia+T8Vi1O3DrtDgq70YFaNj8NOoDsPka5xJj9xdaIkDw1aJKTc1Kmvq8ND6zqRGwCKEC6Nl2WOY+3R5rHxponBxPjCrXfoCtkJtHrvuGHCdZ6z/FFdXQnMyc4DaCpgYjdbk4eXfTrd6MlDDRZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kWOjOnDG; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kWOjOnDG"
Message-ID: <f35f3133-9f1e-4118-8d58-eb29f69f8940@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778778952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7QAIIci8xLeEesMzvjkbogkMCNAxI0hplM1EMDeAxI=;
	b=kWOjOnDGc67r1OnJoNmDnU8mYRv5cjJHYIoRS9/U3QSvAxFWft1xewjcGQHez+B2YIFdPa
	z/m96u8o099jjwKvTkW2k5O8et04jtgL8U2XlL4nBedxbfg+7quYTWxWU0D6MEcaKX1tnX
	uBaduddggk97yb+m2eF2i9C9jB2/YHo=
Date: Thu, 14 May 2026 10:15:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 3/3] bpf: Cache build IDs in sleepable stackmap
 path
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260512032906.2670326-1-ihor.solodrai@linux.dev>
 <20260512032906.2670326-4-ihor.solodrai@linux.dev>
 <6b4e0918-79a5-49ae-a172-c7d6df558dec@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <6b4e0918-79a5-49ae-a172-c7d6df558dec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/26 7:58 AM, Mykyta Yatsenko wrote:
> 
> 
> On 5/12/26 4:29 AM, Ihor Solodrai wrote:
>> Stack traces often contain adjacent IPs from the same VMA or from
>> different VMAs backed by the same ELF file. Cache the last successfully
>> parsed build ID together with the resolved VMA range and backing file
>> so the sleepable build-ID path can avoid repeated VMA locking and file
>> parsing in common cases.
>>
>> Suggested-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  kernel/bpf/stackmap.c | 51 ++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 48 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index c1e96df360c3..318ce9ed0dd5 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -226,13 +226,34 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>>  		.vma = NULL,
>>  		.mm = mm,
>>  	};
>> -	unsigned long vm_pgoff, vm_start;
>> +	struct {
>> +		struct file *file;
>> +		const char *build_id;
>> +		unsigned long vm_start;
>> +		unsigned long vm_end;
>> +		unsigned long vm_pgoff;
>> +	} cache = {};
>> +	unsigned long vm_pgoff, vm_start, vm_end;
>>  	struct vm_area_struct *vma;
>>  	struct file *file;
>>  	u64 ip;
>>  
>>  	for (u32 i = 0; i < trace_nr; i++) {
>>  		ip = READ_ONCE(id_offs[i].ip);
>> +
>> +		/*
>> +		 * Range cache fast path: if ip falls within the previously
>> +		 * resolved VMA range, reuse the cache build_id without
>> +		 * re-acquiring the VMA lock.
>> +		 */
>> +		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
>> +			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
>> +			vm_start = cache.vm_start;
>> +			vm_end = cache.vm_end;
>> +			vm_pgoff = cache.vm_pgoff;
>> +			goto build_id_valid;
>> +		}
>> +
>>  		vma = stack_map_lock_vma(&lock, ip);
>>  		if (!vma || !vma->vm_file) {
>>  			stack_map_build_id_set_ip(&id_offs[i]);
>> @@ -240,9 +261,22 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>>  			continue;
>>  		}
>>  
>> -		file = get_file(vma->vm_file);
>> +		file = vma->vm_file;
>>  		vm_pgoff = vma->vm_pgoff;
>>  		vm_start = vma->vm_start;
>> +		vm_end = vma->vm_end;
>> +
>> +		if (file == cache.file) {
>> +			/*
>> +			 * Same backing file as previous (e.g. different VMAs
>> +			 * of the same ELF binary). Reuse the cache build_id.
>> +			 */
>> +			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
>> +			stack_map_unlock_vma(&lock);
>> +			goto build_id_valid;
>> +		}
>> +
>> +		file = get_file(file);
>>  		stack_map_unlock_vma(&lock);
>>  
>>  		/* build_id_parse_file() may block on filesystem reads */
>> @@ -251,11 +285,22 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>>  			fput(file);
>>  			continue;
>>  		}
>> -		fput(file);
>>  
>> +		if (cache.file)
>> +			fput(cache.file);
>> +		cache.file = file;
>> +		cache.build_id = id_offs[i].build_id;
>> +
>> +build_id_valid:
>> +		cache.vm_start = vm_start;
>> +		cache.vm_end = vm_end;
>> +		cache.vm_pgoff = vm_pgoff;
> 
> nit: Maybe we can also put 
> if (cache.build_id != id_offs[i])
> 	memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX); 
> here? So all writes to the id_offs[i] are at the same place for clearer structure?

Looks reasonable to me, will do this in v4.

> 
> Overall it looks correct. Did you try to run it to see if we hit this cache at all?

I vibe coded a bit of instrumentation to check. Works on a trivial example.
I think real-world deep stacks should have a high cache hit rate here.


diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 318ce9ed0dd5..be3c41b2c814 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -10,9 +10,19 @@
 #include <linux/btf_ids.h>
 #include <linux/buildid.h>
 #include <linux/mmap_lock.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 #include "percpu_freelist.h"
 #include "mmap_unlock_work.h"
 
+#define DEBUG_BUILD_ID_CACHE
+
+#ifdef DEBUG_BUILD_ID_CACHE
+static atomic64_t bid_cache_range_hits;
+static atomic64_t bid_cache_file_hits;
+static atomic64_t bid_cache_misses;
+#endif
+
 #define STACK_CREATE_FLAG_MASK					\
 	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY |	\
 	 BPF_F_STACK_BUILD_ID)
@@ -247,6 +257,9 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 		 * re-acquiring the VMA lock.
 		 */
 		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
+#ifdef DEBUG_BUILD_ID_CACHE
+			atomic64_inc(&bid_cache_range_hits);
+#endif
 			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
 			vm_start = cache.vm_start;
 			vm_end = cache.vm_end;
@@ -271,6 +284,9 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 			 * Same backing file as previous (e.g. different VMAs
 			 * of the same ELF binary). Reuse the cache build_id.
 			 */
+#ifdef DEBUG_BUILD_ID_CACHE
+			atomic64_inc(&bid_cache_file_hits);
+#endif
 			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
 			stack_map_unlock_vma(&lock);
 			goto build_id_valid;
@@ -279,6 +295,9 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
 		file = get_file(file);
 		stack_map_unlock_vma(&lock);
 
+#ifdef DEBUG_BUILD_ID_CACHE
+		atomic64_inc(&bid_cache_misses);
+#endif
 		/* build_id_parse_file() may block on filesystem reads */
 		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
 			stack_map_build_id_set_ip(&id_offs[i]);
@@ -943,3 +962,23 @@ const struct bpf_map_ops stack_trace_map_ops = {
 	.map_mem_usage = stack_map_mem_usage,
 	.map_btf_id = &stack_trace_map_btf_ids[0],
 };
+
+#ifdef DEBUG_BUILD_ID_CACHE
+static int bid_cache_stats_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "range_hits %lld\nfile_hits %lld\nmisses %lld\n",
+		   (long long)atomic64_read(&bid_cache_range_hits),
+		   (long long)atomic64_read(&bid_cache_file_hits),
+		   (long long)atomic64_read(&bid_cache_misses));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(bid_cache_stats);
+
+static int __init bid_cache_debugfs_init(void)
+{
+	debugfs_create_file("bpf_stackmap_buildid_cache", 0444, NULL, NULL,
+			    &bid_cache_stats_fops);
+	return 0;
+}
+late_initcall(bid_cache_debugfs_init);
+#endif /* DEBUG_BUILD_ID_CACHE */
diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index 3e58a86b8e25..e475298da6d4 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -95,6 +95,23 @@ static int usdt(void)
 extern char build_id_start[];
 extern char build_id_end[];
 
+/* Deep-recursion driver to give the sleepable build_id cache a stack with
+ * many adjacent frames in the same VMA. Used by uprobe-deep mode.
+ */
+static int __attribute__((noinline)) recurse(int depth)
+{
+	if (depth <= 0) {
+		(void)uprobe();
+		return 0;
+	}
+	return recurse(depth - 1) + 1;
+}
+
+static int trigger_uprobe_deep(int depth)
+{
+	return recurse(depth);
+}
+
 int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
 {
 	int page_sz = sysconf(_SC_PAGESIZE);
@@ -142,6 +159,8 @@ int main(int argc, char **argv)
 		return trigger_uprobe(false /* page-out build ID */);
 	if (!strcmp("uprobe-paged-in", argv[1]))
 		return trigger_uprobe(true /* page-in build ID */);
+	if (!strcmp("uprobe-deep", argv[1]))
+		return trigger_uprobe_deep(32);
 
 error:
 	fprintf(stderr, "usage: %s <bench|usdt>\n", argv[0]);



> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
>>  		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>>  		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>>  	}
>> +
>> +	if (cache.file)
>> +		fput(cache.file);
>>  }
>>  
>>  /*
> 

