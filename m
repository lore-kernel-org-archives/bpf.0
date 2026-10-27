Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129062;
	b=QXouwyO/b91CRE7T6Zq9J5JJEvQYsE1YyFawHi9guCYT7OFJNpLFyACusiFUBLAXrF8K
	 xusaUWCZixmphS2vWHKIrArdfiR/ZVjg7Oq6d7JLLslm/HDVdGVJ6wgKkopDYbKZHAn3z
	 T36B8Fksmm707vUq+j5uNVQXp71Kbi0ScTfikk3P5m/qD/W1ZPJtGdPhbkwg3P9u9gaOn
	 fsasfZFI6GN8WRney/B9hqs4SAcVyIl6MLhykp9M9UxGhu225kszkYLVTRNYAJ92v3f3p
	 HTPgte5C0KqlueuFOp1sf1Kl2ZaUDjkIlOEKAkCLpkMAll/32mXbqA7AXFf36W29ctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qiw113qmYB6f5WVyzFXHyI7RT9HbYzpvvxsQ7LQ9E1Q=;
	b=zzYihT7nvKTfmkpWtry4mytoQDdofJmDiU2iwLH8n1Ki6JkNwl/ktBbQ+r6FyixoN6Nd
	 yrCbr1u9UR0vI/9Rm9VfkniEI4Nj63giWh/09/DuoARHpHxNsbqMTdhYj7JXl98XpPgdU
	 6yaGoR70xAVY/pIqbIrmAFY6MhlqT13cyKx2Vc6tlGEiWDqM9Dd1DAHndS/OTabeF/de8
	 NYbayUnyahkLxt9utJwPMnsh0r9dx6dIOMYkrphZPfzSxTEfQnFIOPqNjUuNFypJ3mSDl
	 Fv0c27BnGoK6lsI7mnFwj7hFSxL2lxBGx1GWNnVrRmCFe/l0UZhRwvjC34XPAlaqJtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=eBaDVlX9;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23184606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23184606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=eBaDVlX9
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so2182185e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793129060; x=1793733860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qiw113qmYB6f5WVyzFXHyI7RT9HbYzpvvxsQ7LQ9E1Q=;
        b=eBaDVlX90WavqMmxMwWlVXl36+eSVhAIeB1Rq0lBFkVaarKB4RBsOWnTbOyab8vCA+
         baDQm/7hih3X+IJebO/Ler2U90Xhd8kG5OhDwVJbl6XXeL/JP31dbF2hYwUUSAJXUqCm
         XsoHn3D3dGopXx/8A+LR9nslybSRAt96sP5MJr4vGKMdexaCxZDchc6zICuqMp782ntD
         I/THc2TjQ8cqMQlBRLoBkXGIOHtSr/ByTNZ2fP6GpnlzMAgYqwPtmemzwCQvh8f/oX8u
         +bo4pi1wEp7sSml4w754b/HP+nxP6mUTOo8xsI2Ucx5JrVe0JyCUz/X5Iz+Wd3mjGAoY
         kxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129060; x=1793733860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qiw113qmYB6f5WVyzFXHyI7RT9HbYzpvvxsQ7LQ9E1Q=;
        b=dgZI55xCpneqngMxq2IKcMxOoYcpaZ8+VDdj2758c+mPS/m2QA02IBxwVJ5ojPdX5u
         maE65ouKmPgRqkwEWQPWoEkU3fnE+quiY9IqXt7T8pD50wR3QE2Oz9LFahheKSWuoQQ4
         NbyjkiNyVi5IS4oSJItIwa8f0mONpkv/Wn2k0X9QLFFcf0WySxI6vekSTPOR7Rwf82r0
         wzDJ6pC6JbhyyR4gBEe33wEVkPAl7n0Q80h1NCBXhSfM9ojtMNCm6J4aJLcXesvJOJR+
         kdrGiDZ7DS3mQnou464cOn5dCmPcGehDdxIf8BBKIOxSIsz/4Q2YuOM4XZL4gTvWQR9l
         viNA==
X-Gm-Message-State: AFq9FYI21ip3dBG66X7K8qAnilbvKBaGCHuIlO3GO0B8B2j5Js6xc9Mx
	nKwdSDs+SXL+ejLTq0ATAP5r0wgb15qDePAKh94uMHsQavePEX7yypKhB9YV6JUO0t9CCgCOyY6
	jzVd98z4EUg==
X-Gm-Gg: AYBFou2oCDqkSrvV3zo9vLrpVIQYZAwQdzF4FDsEr6TcZ4DcCinFntmZ/xF2NeslY88
	oVGtAr/2pdXWIxPBGK1RSNOKmfgoBl0jHJSEFaHgAL/hzDtsbi0K+gWty+GYkdZU6vpy//eddEq
	xIBXjLA74ln/MOvyy7gvpOspasw911vEbzE02iC3nlpZk2WSQ2GZrEysiBG47XIrbYyofZfx120
	uzOSUz6Gf5/KwwI128FFC44C08mty6V5McNDxqArfF+t65+2B/J21JOzpWnOnqZp+0dDYrPQn74
	MOTJMZWtCC0pQGAtTfstxKfcUW2zI2b0jxeggrXcwHWbblYsYuOx/HAWKPYwBx0UBpYy7mXswkk
	e976E9dYB3qd5f2d26KVArIi3y3Yt//eJVGk31djEa0AwGJlRCxmh1BHdptWy5CIooNR+KVOf/d
	Wn3qqplTD9/AHV+BShokYhUsUJ+bq9C5PlyNsgqtDxXATzkR+OB3CN1GGKkAwywFw90STVS3Cz9
	vJeX7gqqQR4t1M00GxkSFuzrG/Yl1QcT1e0BMl02FzE
X-Received: by 2002:a05:600c:3f0d:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4a7c18afbdemr83404615e9.14.1793129060112;
        Tue, 27 Oct 2026 12:24:20 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2eb1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e103d91sm4721385e9.0.2026.10.27.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:24:19 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: libarena: compatibility fixups
Date: Tue, 27 Oct 2026 19:24:09 +0000
Message-ID: <20261027192413.5038-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
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

This patchset fixes several issues found while integrating with large
BPF codebases.

Patch 1 fixes a mismatch between the in-code licenses for some files
that do not actually correspond to the licenses at the top of the file.
Remove the in-code license sections, since libarena is distributed only
as source code anyway.

Patches 2-3 add an explicit allocator growth call. Some allocator
users prefer to explicitly expand the arena instead of implicitly
letting the allocator do so when required to satisfy an alloc. The
change is non-functional for existing users.

Patch 4 changes the type of the volatile zero variable used for loop
convergence to __u32. This is available from <linux/types.h>, while u32
needs to be typedef'ed in for userspace programs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20261027162916.10996-1-emil@etsalapatis.com/)
- Add a "Dual BSD/GPL" license section to the benchmark consumer so
  libarena-malloc and libarena-calloc remain loadable (Sashiko bot).
- Rename buddy_grow()'s size argument to nr_chunks and use a size_t
  loop index to make the chunk-count API explicit (Sashiko bot).



Emil Tsalapatis (4):
  libarena: remove in-code licenses
  selftests/bpf: libarena: make allocator growth on alloc failure
    optional
  selftests/bpf: libarena: add explicit buddy_grow() call
  selftests/bpf: libarena: Make zero variable type __u32 instead of u32

 .../bpf/libarena/benchs/bench_malloc.bpf.c    |  2 +
 .../bpf/libarena/include/libarena/buddy.h     |  2 +
 .../bpf/libarena/include/libarena/common.h    |  2 +-
 .../selftests/bpf/libarena/src/asan.bpf.c     |  2 -
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 48 +++++++++++++++++--
 .../selftests/bpf/libarena/src/common.bpf.c   |  4 +-
 6 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.52.0

