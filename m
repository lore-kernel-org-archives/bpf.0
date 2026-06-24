Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB63DA7FB
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316312; cv=none; b=py/G5QI3AjL2cVrwHo548/MDE/bCtSkZO5zSL6gkpOQfye6WSAJ4M9MOFqi5/ked434mxMLbguOhX++6ZDmySPYg29bXBHqyfUZJv+zkltF7ScCvpfUh5tIw/q9nnAJ/lZMlLhM228xJVyf8oD2CtA2QUo1r9si78c15YediNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316312; c=relaxed/simple;
	bh=eEdiH2DZ6grTEca8sTdoE74uau7UH04ShxhYUnJDfb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KK4CQa1eVb9rP04sgolZUe91XKfIepWabz+iCQ3tnm+Ej6YfwlFdkEcZCj0vpwSmpn8vj6DqRHsIplea3o8G3pjOy/IwYnZLUgaEfMpi4vdbGukvyWyMqfdvIGzKODtteLPWzcOdP06eJXGP2hxK3loAQfHNfmgX4GXmp5IWmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AEQahm00; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AEQahm00"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782316296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mdGHVFYD9iU3hOg4N5vQYoEeCEvIQ7tf/XpE/PPWrKo=;
	b=AEQahm00gUOWxn4+rLrCRgemmRQX+rIne367AB04/qpqpVWbkYhdtX7lmjFBbYJxbGapv3
	RAcz77DXo4Y4Q1xGxL8TGVpt/9ir3axHwl1D46KFkG7vlO+PR2ltJ6fF5ERPem8tZFbxTP
	Fds6z/5vYFBo0ZmrXhvux++2NqZAVMQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf 0/2] bpf: Copy per-CPU map value padding in copy_map_value_long()
Date: Wed, 24 Jun 2026 23:51:13 +0800
Message-ID: <20260624155115.85196-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sashiko reported [1]:

This is a pre-existing issue, but does iterating over per-CPU maps expose
uninitialized kernel heap memory?

When working with per-CPU maps, temporary buffers are allocated using kmalloc
without the __GFP_ZERO flag in functions like bpf_iter_init_array_map in
kernel/bpf/arraymap.c:

kernel/bpf/arraymap.c:bpf_iter_init_array_map() {
    ...
    value_buf = kmalloc(buf_size, GFP_USER | __GFP_NOWARN);
    ...
}

This is also done in kernel/bpf/hashtab.c:bpf_iter_init_hash_map().

If the map contains a BTF record, bpf_obj_memcpy in include/linux/bpf.h
explicitly stops at map->value_size instead of filling the entire rounded-up
size:

include/linux/bpf.h:bpf_obj_memcpy() {
    ...
    memcpy(dst + curr_off, src + curr_off, size - curr_off);
    ...
}

This fails to overwrite the padding bytes up to round_up(map->value_size, 8).

[1] https://lore.kernel.org/bpf/20260622150844.28C551F000E9@smtp.kernel.org/

===
For example,

struct map_uninit_value {
	struct prog_test_ref_kfunc __kptr_untrusted *unref_ptr;
	__u32 data;
} __attribute__((packed));

struct {
	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
	__type(key, int);
	__type(value, struct map_uninit_value);
	__uint(max_entries, 1);
} pcpu_array SEC(".maps");

There are 4 padding bytes in the kernel percpu_array map elements.

When lookup element from 'pcpu_array' map, for each CPU, the 4 padding
bytes memory allocated by syscall.c::map_lookup_elem():kvmalloc() could
be exposed to user space.

Without the fix, the selftest could fail with:

test_map_uninit_mem_exposure:FAIL:zeroed tail bytes unexpected memory
mismatch
actual:
	2B 2B 2B 2B
expected:
	00 00 00 00

Leon Hwang (2):
  bpf: Copy per-CPU map value padding in copy_map_value_long()
  selftests/bpf: Verify no non-zeroed kernel heap memory exposure

 include/linux/bpf.h                           |  4 +-
 .../bpf/prog_tests/test_map_uninit.c          | 68 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 12 ++++
 3 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_map_uninit.c

-- 
2.54.0

