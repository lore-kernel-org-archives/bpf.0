Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66234D3B0
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973482; cv=none; b=eBYox6/gtV00UWJo85HXzfjS2yd7EX8HUNWacsPNJk/tLQSEbOYsn3Fk6N89PPuJ3jiUkD2SU3ir7a0+RUPLoiVI4lnqTZL8ereG0iOucRoDBuG/HIcAeabJ7C0UTKhGFbfEh2eRmteLW/3xaKHLxBnExCZ0Z0SDAjlRENyHZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973482; c=relaxed/simple;
	bh=lhUWfoXsQWcB2tkn5J8OiyjlLjXiU22pcbQPJkE6ymg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0QTnUZUzRd6KT3DZR+G6l9hDZ1r2jQ9NJrqCSkzkawLFuzunBl/H/IA1/23rwbMUlQfEJQBUIE+f7BPCFiz2IcZ4d5m92uYqQaJ96bVHkWVMw7RiXsizzjXj/ww2wYWxm+7IgUEn9sBZnaSspPV6L9eQphfTisoN9sse20dlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fk/bFwJC; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fk/bFwJC"
Message-ID: <ad19d283-aaab-41f1-b1a5-73de551b03a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782973477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz5tUB5pFkbuDkjCVYTQ7Qj10RhR66LemowS5HsxdaE=;
	b=Fk/bFwJC/fywUV/C1hZ9XwKBHqfiU9K2+7L1jnV+OBl5ZfEQJ7F4jnL5wLckfuntqxLWQi
	HFk/vubILUPxK75z0oKhqxhzdAJjrKUiuCS3orO6K+qFPv04macOq0IJ7nhyH3pX/EsAXu
	Upa2CUqK9YBLGglrCKtGMB9XNkDpNGQ=
Date: Thu, 2 Jul 2026 14:24:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 5/9] bpftool: Generate skeleton for global
 percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-6-leon.hwang@linux.dev>
 <a4e4adfe-4b2e-49c4-a708-89276514f930@kernel.org>
 <CAEf4BzbfA2nySpf3Oh6KVBRjDKMOOYN-NC279Sj73KwH32cGGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbfA2nySpf3Oh6KVBRjDKMOOYN-NC279Sj73KwH32cGGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/7/26 03:32, Andrii Nakryiko wrote:
> On Wed, Jul 1, 2026 at 9:49 AM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2026-06-29 23:24 UTC+0800 ~ Leon Hwang <leon.hwang@linux.dev>
[...]
>>> @@ -254,6 +254,20 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>>>       return NULL;
>>>  }
>>>
>>> +static bool bpf_map_is_skel_data(const struct bpf_map *map)
>>> +{
>>> +     if (!bpf_map__is_internal(map))
>>> +             return false;
>>> +
>>> +     if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
>>> +             return true;
>>> +
>>> +     if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
>>> +             return true;
>>> +
>>> +     return false;
>>> +}
>>> +
>>>  static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>>  {
>>>       size_t tmp_sz;
>>> @@ -263,7 +277,7 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>>               return true;
>>>       }
>>>
>>> -     if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>>> +     if (!bpf_map_is_skel_data(map))
>>>               return false;
>>>
>>>       if (!get_map_ident(map, buf, sz))
>>
>>
>> Thanks! The bpftool patch looks good, with one reservation: after this
>> patch, I believe "is_mmapable_map(map, ...)" will return true if map is
>> a percpu map, although percpu maps aren't mmap-able, so we should
>> probably update the name of that function to avoid any confusion?
>>
> 
> Great observation, Quentin!
> 
> bpf_map_is_skel_data() I think was supposed to be exactly that generic
> name. But it seems like Leon went half-way through with unification.
> Unless there are some subtle situations where per-cpu array shouldn't
> be handled where is_mmapable_map() is handled, we should rename
> is_mmapable_map() and add BPF_MAP_TYPE_PERCPU_ARRAY check (assuming
> it's internal map, of course) there.
> 
> Leon, can you please check?
> 
Aha, my bad.

Try to rename is_mmapable_map() to bpf_map_is_skel_data(). See below patch.

Thanks,
Leon

---

From 654306cd9091a175883dd61c7b251996c42e7cae Mon Sep 17 00:00:00 2001
From: Leon Hwang <leon.hwang@linux.dev>
Date: Mon, 29 Jun 2026 23:24:02 +0800
Subject: [PATCH bpf-next v9 5/9] bpftool: Generate skeleton for global
percpu
 data

Enhance bpftool to generate skeletons that properly handle global percpu
variables. The generated skeleton now includes a dedicated structure for
percpu data, allowing users to initialize and access percpu variables more
efficiently.

For global percpu variables, the skeleton now includes a nested
structure, e.g.:

struct test_global_percpu_data {
	struct bpf_object_skeleton *skeleton;
	struct bpf_object *obj;
	struct {
		struct bpf_map *percpu;
	} maps;
	// ...
	struct test_global_percpu_data__percpu {
		int data;
		char run;
		struct {
			char set;
			int i;
			int nums[7];
		} struct_data;
		int nums[7];
	} *percpu;

	// ...
};

  * The "struct test_global_percpu_data__percpu *percpu" points to
    initialized data, which is actually "maps.percpu->mmaped".
  * Before loading the skeleton, updating the
    "struct test_global_percpu_data__percpu *percpu" modifies the initial
    value of the corresponding global percpu variables.
  * After loading the skeleton, "maps.percpu->mmaped" has been marked as
    read-only in libbpf. If users want to update the global percpu
    variables, they have to update the "maps.percpu" map instead.
  * For lightweight skeleton, "lskel->percpu" will be protected by
    "mprotect(p, sz, PROT_READ)".
  * For subskeleton, those variables of global percpu data will be
    skipped.

Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/gen.c       | 72 ++++++++++++++++++++++++++---------
 tools/lib/bpf/skel_internal.h | 24 +++++++++++-
 2 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 6ae7262ebe0c..798a34366e08 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char
*obj_name, const char *suff

 static bool get_map_ident(const struct bpf_map *map, char *buf, size_t
buf_sz)
 {
-	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".percpu",
".kconfig" };
 	const char *name = bpf_map__name(map);
 	int i, n;

@@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map,
char *buf, size_t buf_sz)

 static bool get_datasec_ident(const char *sec_name, char *buf, size_t
buf_sz)
 {
-	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".percpu",
".kconfig" };
 	int i, n;

 	/* recognize hard coded LLVM section name */
@@ -254,7 +254,7 @@ static const struct btf_type
*find_type_for_map(struct btf *btf, const char *map
 	return NULL;
 }

-static bool is_mmapable_map(const struct bpf_map *map, char *buf,
size_t sz)
+static bool bpf_map_is_skel_data(const struct bpf_map *map, char *buf,
size_t sz)
 {
 	size_t tmp_sz;

@@ -263,13 +263,19 @@ static bool is_mmapable_map(const struct bpf_map
*map, char *buf, size_t sz)
 		return true;
 	}

-	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) &
BPF_F_MMAPABLE))
+	if (!bpf_map__is_internal(map))
 		return false;

 	if (!get_map_ident(map, buf, sz))
 		return false;

-	return true;
+	if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
+		return true;
+
+	if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
+		return true;
+
+	return false;
 }

 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
@@ -286,8 +292,11 @@ static int codegen_datasecs(struct bpf_object *obj,
const char *obj_name)
 		return -errno;

 	bpf_object__for_each_map(map, obj) {
-		/* only generate definitions for memory-mapped internal maps */
-		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
+		/*
+		 * Only generate definitions for internal maps that have
+		 * mmapped data.
+		 */
+		if (!bpf_map_is_skel_data(map, map_ident, sizeof(map_ident)))
 			continue;

 		sec = find_type_for_map(btf, map_ident);
@@ -339,8 +348,14 @@ static int codegen_subskel_datasecs(struct
bpf_object *obj, const char *obj_name
 		return -errno;

 	bpf_object__for_each_map(map, obj) {
-		/* only generate definitions for memory-mapped internal maps */
-		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
+		/*
+		 * Only generate definitions for internal maps that have
+		 * mmapped data.
+		 */
+		if (!bpf_map_is_skel_data(map, map_ident, sizeof(map_ident)))
+			continue;
+
+		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
 			continue;

 		sec = find_type_for_map(btf, map_ident);
@@ -493,7 +508,10 @@ static size_t bpf_map_mmap_sz(const struct bpf_map
*map)
 	return map_sz;
 }

-/* Emit type size asserts for all top-level fields in memory-mapped
internal maps. */
+/*
+ * Emit type size asserts for all top-level fields in internal maps that
+ * have mmaped data.
+ */
 static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 {
 	struct btf *btf = bpf_object__btf(obj);
@@ -517,7 +535,7 @@ static void codegen_asserts(struct bpf_object *obj,
const char *obj_name)
 		", obj_name);

 	bpf_object__for_each_map(map, obj) {
-		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
+		if (!bpf_map_is_skel_data(map, map_ident, sizeof(map_ident)))
 			continue;

 		sec = find_type_for_map(btf, map_ident);
@@ -669,7 +687,8 @@ static void codegen_destroy(struct bpf_object *obj,
const char *obj_name)
 		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 		if (bpf_map__is_internal(map) &&
-		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+		    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
+		     bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY))
 			printf("\tskel_free_map_data(skel->%1$s,
skel->maps.%1$s.initial_value, %2$zu);\n",
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
@@ -741,7 +760,7 @@ static int gen_trace(struct bpf_object *obj, const
char *obj_name, const char *h
 		const void *mmap_data = NULL;
 		size_t mmap_size = 0;

-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!bpf_map_is_skel_data(map, ident, sizeof(ident)))
 			continue;

 		codegen("\
@@ -847,9 +866,23 @@ static int gen_trace(struct bpf_object *obj, const
char *obj_name, const char *h
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;

-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!bpf_map_is_skel_data(map, ident, sizeof(ident)))
 			continue;

+		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY) {
+			codegen("\
+		\n\
+			err = skel_protect_map_data(skel->%1$s,
&skel->maps.%1$s.initial_value, %2$zd);\n\
+			if (err)					    \n\
+				return err;				    \n\
+		#ifdef __KERNEL__					    \n\
+			skel->%1$s = NULL;				    \n\
+		#endif							    \n\
+			",
+			ident, bpf_map_mmap_sz(map));
+			continue;
+		}
+
 		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
 			mmap_flags = "PROT_READ";
 		else
@@ -953,8 +986,7 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t
map_cnt, bool mmaped, bool
 				map->map = &obj->maps.%s;	    \n\
 			",
 			i, bpf_map__name(map), ident);
-		/* memory-mapped internal maps */
-		if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
+		if (mmaped && bpf_map_is_skel_data(map, ident, sizeof(ident))) {
 			printf("\tmap->mmaped = (void **)&obj->%s;\n", ident);
 		}

@@ -1738,7 +1770,9 @@ static int do_subskeleton(int argc, char **argv)
 		/* Also count all maps that have a name */
 		map_cnt++;

-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!bpf_map_is_skel_data(map, ident, sizeof(ident)))
+			continue;
+		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
 			continue;

 		map_type_id = bpf_map__btf_value_type_id(map);
@@ -1861,7 +1895,9 @@ static int do_subskeleton(int argc, char **argv)

 	/* walk through each symbol and emit the runtime representation */
 	bpf_object__for_each_map(map, obj) {
-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!bpf_map_is_skel_data(map, ident, sizeof(ident)))
+			continue;
+		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
 			continue;

 		map_type_id = bpf_map__btf_value_type_id(map);
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 74503d358bc8..485b0cd17017 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -135,8 +135,10 @@ static inline void skel_free_map_data(void *p,
__u64 addr, size_t sz)
 {
 	if (addr != ~0ULL)
 		kvfree(p);
-	/* When addr == ~0ULL the 'p' points to
-	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
+	/*
+	 * When addr == ~0ULL the init buffer has already been released.
+	 * For skel_finalize_map_data(), 'p' points to
+	 * ((struct bpf_array *)map)->value.
 	 */
 }

@@ -174,6 +176,15 @@ static inline void *skel_finalize_map_data(__u64
*init_val, size_t mmap_sz, int
 	return addr;
 }

+static inline int skel_protect_map_data(void *p, __u64 *init_val,
size_t sz)
+{
+	(void)sz;
+
+	kvfree(p);
+	*init_val = ~0ULL;
+	return 0;
+}
+
 #else

 static inline void *skel_alloc(size_t size)
@@ -212,6 +223,15 @@ static inline void *skel_finalize_map_data(__u64
*init_val, size_t mmap_sz, int
 		return NULL;
 	return addr;
 }
+
+static inline int skel_protect_map_data(void *p, __u64 *init_val,
size_t sz)
+{
+	(void)init_val;
+
+	if (mprotect(p, sz, PROT_READ))
+		return -errno;
+	return 0;
+}
 #endif

 static inline int skel_closenz(int fd)
-- 
2.54.0


