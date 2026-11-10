Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273772;
	b=DsjWqwrSLQtsJftP1qgARqI5usD2SZImkNryrxjKgMlJZbLrjq5Qmo9sf3DCXPykhiAG
	 qXxvdTbHUdhFEQvQwS1Cu0xyjTtqFya+nTYLW3j9cMOQTitPoGBptBCQWvUJubmSi1GpS
	 tePI45vxeO8V4rVVu1Ems9Sn6GgkNEMUz9dZpPc99k/ncIkepT1u+CT7G5Ohxj+kga9yc
	 IM9K83e9jfe2tu7y78o50r1kKfRQTnBLQ4IMhWVGQjwuX8kk/jlr1UncXoc0VJoSnuqZx
	 fYy5c1X223KTKOcgVIDvrDWzY4sghEih+QikUlzUZNdr89jSE/fOtV0mCn0HXyhvzkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273772;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=D+N2QRZvzfe+CFAvIEo6YK7+9V99UHaC8NPIhonyKWI=;
	b=ldWZEq8yU9B+3VuG6YLiM1KTp9HCFqLlw/yfgMaiI0X37j5nECBq/EyA/AAYs2ozH0Ak
	 Pe5Iv3OaZ1eH52hXqUb9W0LPaGIqg/TLB551p2fiV3IiOF6CKUPtDNjhFtNa61rBlEZBC
	 iQodWMvJPh8gttsWxurwKpxGeJAROH+pCTUg9rQqmmu1imldHkRfh/BGLKCzDBV20lD+V
	 dk5b9Uye1oPC9Zy9paHwXjkvTWkQBWjWRO1WwPv6MF2Zb75q9d7MmJ3s99FXgpAZyMC2h
	 DZ4D5Tc5DNSMcXhvzN210o2A0CDol25PIST0xrFGle2sjy7IvaozuGkDUjYU5ZjvfwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u1+vQ+IH;
	arc=none smtp.remote-ip=91.218.175.187
Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3460A263E
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 01:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D3460A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u1+vQ+IH
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aonwTnaVCS6JFQJm6qDOQX7pACUW5lsxK/707tA3EJM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794273768; v=1; x=1794878568;
 b=u1+vQ+IH3bB2gezV08+6cO0uTX02FrG5KALC3OLqIChFlm8vuk21aDXD+6oeTBssKnxOW+i+
 qjAAhymLdXgIkC5wBC6nlSHSmDRWMakSPkb9JFUpSBqCRy0ybrqgdpdos6hjbN1gUkKybsZ0UvR
 jQdHrphNv/s7dyerw+L1geAY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5640507009fcdc41;
	Tue, 10 Nov 2026 01:22:47 +0000
X-Mizu-Trace-ID: 5640507009fcdc41
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org
Cc: longman@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	acme@kernel.org,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	llvm@lists.linux.dev,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [RFC PATCH 0/2] percpu, local_lock: drop btf_type_tag where no compiler records it
Date: Mon,  9 Nov 2026 17:22:33 -0800
Message-ID: <20261110012235.1024461-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
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

Hi,

Currently PAHOLE_HAS_BTF_TAG is gated on CC_IS_CLANG and the goal is
to allow CC_IS_GCC. There are GCC fixes (PR128479, PR125991) in the
making [1] but despite all of them an x86 defconfig still emits ~40k
instances of spew like:

  arch/x86/include/asm/processor.h:232:36: warning: ignoring attributes
  applied to 'struct cpuinfo_x86' after definition [-Wattributes]

where one is enough to break a -Werror build.

Making GCC stop warning here was proposed as PR128480 and rejected:
the suggested answer was -Wno-attributes, which the kernel would not
accept just to suppress this noise.

And even if warnings were to be ignored, the build would still fail
with 33 hard errors from a separate GCC bug, PR128477,

  include/linux/percpu-defs.h:216:45: error: initialization from
  pointer to non-enclosed address space

These come from the same tag on the same declarations, so this series
removes them too.

The root cause is where the tag is applied. BTF_TYPE_TAG(percpu)
records that a pointer points to per-cpu memory, but two places apply
it where the thing qualified is an aggregate, which no compiler can
tag (GCC or clang): every variant of an aggregate shares one DIE,
so there is nowhere to put it.

  - __PCPU_ATTRS(), so DECLARE_PER_CPU() and DEFINE_PER_CPU() put the tag
    on the per-cpu variable's own type;
  - the type argument of DEFINE_LOCK_GUARD_1() in local_lock.h, which
    cleanup.h turns into "typedef _type lock_<name>_t".

Nothing reads a tag in either position. The verifier matches "percpu" in
btf_ctx_access() and in the member walk in btf_struct_walk(), and both
check btf_type_is_ptr() first, so it only ever sees the tag on a pointer.

The aggregate case is the only one that warns. Where the per-cpu variable
is a pointer there is no diagnostic, but the record is wrong: GCC puts
the tag on the pointee, so

  static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);

comes out saying hrtimer_running is an ordinary pointer to per-cpu
memory, when in truth it lives in per-cpu memory and points at ordinary
memory. clang records no tag there at all.

The following two patches address this:

 - 1/2 provides a new variant of __percpu, __percpu_var which elides
   the btf tag. Switches __PCPU_ATTRS to use it.
 - 2/2: Applies __percpu_var in local_lock code.

Binary impact, x86 defconfig built with clang: patch 1 drops 280 BTF types
(140 TYPE_TAG and the 140 pointers carrying them, none referenced) and 3360
bytes of .BTF, with .text unchanged. Patch 2 changes nothing at all.

[1] https://inbox.sourceware.org/gcc-patches/20261109213600.772524-1-vineet.gupta@linux.dev/

Vineet Gupta (2):
  percpu: do not put btf_type_tag on per-cpu variable declarations
  local_lock: do not put btf_type_tag on the lock guard type

 include/linux/compiler_types.h | 8 ++++++++
 include/linux/local_lock.h     | 8 ++++----
 include/linux/percpu-defs.h    | 2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.53.0-Meta

