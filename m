Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6F45038
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734585; cv=none; b=PzSc/Oi9wUutMvsRwdVTbe/6L2IWrUHvUTAmUk/JcBbSmNQCqzb1Av0vXz3exODGDVjUt5MR60qhPUXVXt9G38De5zJ+ECltkK436jC53Os6SPMQr4+l56t94N5Y0rNldE/QoMBi6mWF/q4jG9NVyADY2dHqqDQLgdESDtz/xTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734585; c=relaxed/simple;
	bh=SPCoPNti9QVQUdX5Pz5VRkSaHJM2AbcuQqFX6Q0JXJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAngiHJHpWQIRZ7S9qdHfZWtVlVSZTqxT/opX7+FDVcM48eV2SD9AagZO8ck5TGQixvjiKsq4+z0jH31Ywgk5e2u0lIGWn/wUij1e3bY7SWRQLwZqYU1k738+kbzhNT3i8RBTpBPe8gVSnMbNVh5FVcv/chAVUux1AOlzwzjC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VG9mwxYD; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VG9mwxYD"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0A8CF80D6E;
	Mon, 07 Sep 2026 00:42:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Vflt9aJgoOw; Mon,  7 Sep 2026 00:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1788734573; bh=SPCoPNti9QVQUdX5Pz5VRkSaHJM2AbcuQqFX6Q0JXJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VG9mwxYD5nhqb/Qgny2tDlDcVkLXETBBXO1RWKQOF05OPfJ9x0RlXbhISkwB1JBao
	 qyaZX2Yj8NbwekNZlH3hA+CrETUuiG8cEEjFZx6QzqussvjaPOGQm+RkQuDVBwlFti
	 nd6BHz26Fbw2QDlbteFEoAfGeQ5WCPkSzsPSH0zwHK6LT7pVA5s7lvJgwebeDmz9zE
	 mp9iCXCyjsEHnS3dP96w8hn+aW5RKgDl7OFNc9hLt1yV+hhh7yFpwV44a3578FnSan
	 DRvLFuGf8f24gcGZ2bOZm++z+tSAW0mCxGRRhAzvvWtO/ocXsgnqMgKppR9e/zLcK6
	 5H+ba9lC7gD8g==
Message-ID: <5574f80b-104c-48d7-8d1e-74b1cc720a41@disroot.org>
Date: Sun, 6 Sep 2026 23:42:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bpf: Fix u32 overflow issue in map batch operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Brian Vazquez <brianvv@google.com>
References: <20260902204439.287888-1-maghasi@disroot.org>
 <20260903082734.623904-1-maghasi@disroot.org>
 <CAADnVQLX5bjLTPm8Ch0wNuojHrKw6R5iJDBRsMJwrWMSupVwew@mail.gmail.com>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <CAADnVQLX5bjLTPm8Ch0wNuojHrKw6R5iJDBRsMJwrWMSupVwew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2026 05:45, Alexei Starovoitov wrote:
> On Thu, Sep 3, 2026 at 1:28 AM Masoud Aghasi <maghasi@disroot.org> wrote:
>>
>> Several map batch operation implementations such as
>> generic_map_lookup_batch() use calculations in the form of
>> "values + cp * map->value_size" to compute the desired userspace memory
>> address for reading or writing. This can overflow the u32 type
>> (the result of "cp * map->value_size") when the map size exceeds 4GB.
>>
>> generic_map_lookup_batch() may corrupt values for some keys in
>> userspace memory, and in some cases it mismatches values for some keys
>> while still reporting success.
> 
> without selftest I have to assume that this is AI hallucination.
> 
> pw-bot: cr

I post the selftest here to make it easier to reproduce the bug
and also not having issues with the CI. I also added the output that
I received locally, which shows tests fail for map sizes bigger
than 4GB. I hope it helps, please let me know if you need any
more clarifications.

```c
// SPDX-License-Identifier: GPL-2.0

#include <test_progs.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>

#include <bpf/bpf.h>
#include <bpf/libbpf.h>

#define TEST_BATCH_LOOKUP 1
#define TEST_BATCH_UPDATE 2

static void validate_batch_lookup(const int map_fd, const __u32 max_entries,
				  void *keys, void *values)
{
	int err;
	__u32 out_batch, count;

	/* Do batch lookup on the map and validate the result */
	count = max_entries;
	err = bpf_map_lookup_batch(map_fd, NULL, &out_batch, keys, values,
				   &count, NULL);
	if (!ASSERT_EQ(err, 0, "map_lookup_batch"))
		return;

	if (!ASSERT_EQ(count, max_entries, "map_lookup_batch_count"))
		return;

	if (!ASSERT_EQ(*(__u64 *)values, 0llu, "map_lookup_batch_value"))
		return;
}

static void validate_batch_update(const int map_fd, const __u32 max_entries,
				  const __u32 value_size, void *keys,
				  void *values)
{
	int err;
	__u32 count, key;

	/* Do batch update on the map */
	count = max_entries;
	err = bpf_map_update_batch(map_fd, keys, values, &count, NULL);
	if (!ASSERT_EQ(err, 0, "map_update_batch"))
		return;

	if (!ASSERT_EQ(count, max_entries, "map_update_batch_count"))
		return;

	/* Validate the last value */
	key = max_entries - 1;
	err = bpf_map_lookup_elem(map_fd, &key, values);
	if (!ASSERT_EQ(err, 0, "map_update_batch_lookup"))
		return;

	if (!ASSERT_EQ(*(__u64 *)values, key, "map_update_batch_value"))
		return;
}

static void test_array_batch_overflow(const __u32 max_entries,
				      const __u32 value_size, int test_type)
{
	int map_fd, err;
	void *keys, *values;
	__u32 i;
	const __u32 key_size = sizeof(int);

	keys = calloc(max_entries, key_size);
	if (!keys) {
		test__skip();
		return;
	}

	values = calloc(max_entries, value_size);
	if (!values) {
		free(keys);
		test__skip();
		return;
	}

	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "array_map", key_size,
				value_size, max_entries, NULL);
	if (map_fd < 0) {
		if (errno == ENOMEM)
			test__skip();
		else
			ASSERT_GE(map_fd, 0, "map_create");

		free(keys);
		free(values);
		return;
	}

	/* Update all elements with unique values */
	for (i = 0; i < max_entries; i++) {
		*(__u32 *)(keys + (__u64)i * key_size) = i;
		*(__u64 *)(values + (__u64)i * value_size) = (__u64)i;
		err = bpf_map_update_elem(map_fd, &i,
					  values + (__u64)i * value_size, 0);
		if (err) {
			ASSERT_EQ(err, 0, "map_update_elem");
			goto cleanup;
		}
	}

	if (test_type == TEST_BATCH_LOOKUP)
		validate_batch_lookup(map_fd, max_entries, keys, values);
	else if (test_type == TEST_BATCH_UPDATE)
		validate_batch_update(map_fd, max_entries, value_size, keys,
				      values);

cleanup:
	free(keys);
	free(values);
	close(map_fd);
}

void test_map_batch_overflow(void)
{
	if (test__start_subtest("array_lookup"))
		test_array_batch_overflow(17, 1024U, TEST_BATCH_LOOKUP);
	if (test__start_subtest("array_lookup_4gb_plus"))
		test_array_batch_overflow(17, 0x10000000U, TEST_BATCH_LOOKUP);
	if (test__start_subtest("array_update"))
		test_array_batch_overflow(17, 1024U, TEST_BATCH_UPDATE);
	if (test__start_subtest("array_update_4gb_plus"))
		test_array_batch_overflow(17, 0x10000000U, TEST_BATCH_UPDATE);
}

```

The output of "sudo ./test_progs -t map_batch_overflow":
#212/1   map_batch_overflow/array_lookup:OK
validate_batch_lookup:PASS:map_lookup_batch 0 nsec
validate_batch_lookup:PASS:map_lookup_batch_count 0 nsec
validate_batch_lookup:FAIL:map_lookup_batch_value unexpected map_lookup_batch_value: actual 16 != expected 0
#212/2   map_batch_overflow/array_lookup_4gb_plus:FAIL
#212/3   map_batch_overflow/array_update:OK
validate_batch_update:PASS:map_update_batch 0 nsec
validate_batch_update:PASS:map_update_batch_count 0 nsec
validate_batch_update:PASS:map_update_batch_lookup 0 nsec
validate_batch_update:FAIL:map_update_batch_value unexpected map_update_batch_value: actual 0 != expected 16
#212/4   map_batch_overflow/array_update_4gb_plus:FAIL
#212     map_batch_overflow:FAIL

All error logs:
validate_batch_lookup:PASS:map_lookup_batch 0 nsec
validate_batch_lookup:PASS:map_lookup_batch_count 0 nsec
validate_batch_lookup:FAIL:map_lookup_batch_value unexpected map_lookup_batch_value: actual 16 != expected 0
#212/2   map_batch_overflow/array_lookup_4gb_plus:FAIL
validate_batch_update:PASS:map_update_batch 0 nsec
validate_batch_update:PASS:map_update_batch_count 0 nsec
validate_batch_update:PASS:map_update_batch_lookup 0 nsec
validate_batch_update:FAIL:map_update_batch_value unexpected map_update_batch_value: actual 0 != expected 16
#212/4   map_batch_overflow/array_update_4gb_plus:FAIL
#212     map_batch_overflow:FAIL
Summary: 0/2 PASSED, 0 SKIPPED, 1 FAILED

