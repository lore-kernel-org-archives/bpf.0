Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509F4CF47D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180124; cv=none; b=WOnF0zKpmiqaNQUlQQfIaXUrAEcyf30pk0V9+7eN+l8lS3klDD0IiYO7fC958mLIFqCnSuNoO9EyDEBseB+e/onE+226O+oHKAnsLGiWLIM55fRR2WIzWrrnBCfiaoFKFe7RciGOu5sUUUpJtKdmWDPi+8XYeVFODgg56zdTPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180124; c=relaxed/simple;
	bh=WiKNW/PdZA6AsaEUnVk4RvU+IxiJoDI+wIAVqyvgIvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMPD6E1wL3Oy3qyZ1YP9mqHDgzzby/xG3I0AODiIo7dOdIHxCm6SgAUs5kgfTmaTs3SObnN78CKAtAy7AuK/rWezT30X5tnAXEXzlIPgf/ftfuN9gDDy+So6vBNXj0ndA3SF53vmOH6LA21AgUAxMVM739y6DBd0Br79MWIqwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqP+xRmy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqP+xRmy"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a87e23860cso3989211fa.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792180121; x=1792784921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0hoxXb4s3UEidbFXZi/a4D2GBpFbA4+399URLR3r0/A=;
        b=LqP+xRmyoZjlOGbfkLxhOZll98LV3Ohn7GatOx7CwSIqbbRnWfvMw2Fp6yvAO1ADjO
         oaomxRsdif5cAP872mbOfhfZXCvVKumQui4/9xqVi+tWvcRDAC7QqiV3+wdy8soKcJ9G
         vrswl8xcqZZ1D5C0PKGCWxChw/1V0/wFz5TFq0jc4p8KNJwCxd6CUMYnJ/EJ5mByQy5F
         V+/wfHFXz8nt7dEaqSAj7xMu/EZs3LzKJFGbYARUPo3GQVlibo0is5sFpU9YtVnXElu7
         Otns6wH3FxiPMGs3hkWutn7ElT3a9dHDCxESuB0hSlw5KMUsvUAVV/5w3MAJO47/9IdM
         J2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792180121; x=1792784921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0hoxXb4s3UEidbFXZi/a4D2GBpFbA4+399URLR3r0/A=;
        b=uSpnqA2qABWibqFq3BoKhr0M+5eMHQoRA1zYxpjtJoDOjdwPRc0PFB+feA9JA1qY17
         StstOz1F+IE6zSzKqtifYD9cjPthAU8h6z96wpP2aLbmg+JoH4A9mz5lSxapOYgJsZ8L
         xRjrNwNxWN4LUxfnmgSIHwn+1FNxQLC0J2HFR+Z3tQgLY3L4HW6E2uektwKTxCASdfAm
         r7DCKUP3Vm/SXIkU1lbBt4l6Am/EcarKNcfGeaQnl/3oUNTNRdHh6Pn1IWUYNQqQpr/0
         BIMJxU3BusnD7yDkTQ23Gf1H/gKu0HTF+/JaDliOYu6yVZIr/uklIgBnn7ZNL6udcIQA
         51KQ==
X-Gm-Message-State: AFq9FYJUgXejfTie+iICNiUnqfPNwX7gnGNKBvShlfCGhKp2FvGqX7eu
	rq9O2Sjv3v5lmYU9DuVDu5IFrF/vU2Wr9DZcEG65JMDJnH6Wy2a9CxzS9mymYLQNT5c=
X-Gm-Gg: AYBFou14WQy7CjgV+Q0hD8Zy9S+YVYT6an+0WXp5xdLYkjH26DB+ggINvpMvnJoxjJw
	kgOCb39Tmph/GU1J2AmXzQ9cr8SVub72dFTZu+d5hdWPsvpx6XByOU3JS7ZDkfLWAeaXrqyCOjB
	R53Wq9z+IHJq/cD3+QJ8bES9Zxl6T/FB9hBwQTf0i9BnlEdBilZajD/lcwkXvQ4sf6Shtu1r3nc
	VCZPgavxRt3TIIp/UoQF6iEbvmU2KcBr8iqWco6dL2gu2tjws9VEz4W6Yi70LwLrVaTBDmCUGUN
	yqvuk9pgACxpR4tsZJWRj5xS9eHE2D37AkzeGQ9XRj7JDyJp/A70Dc5GY/tG9hai95Z9DgLNkOY
	PdM0CCn4O+/RD3izUxeokcWPM0oiTBLp+IvwwWqDktDU0oNFmxtUv1QnSC05GC+M9BZtOW91oGo
	ls1XonCt24mtluGRTCReWSxPXoviGQfJ3vIQ3M5eMNNMoggXK71PkCNAOVvRfWFgXsgnvC0qW9J
	Fuzm+si7GvsendRAQk4iF/0cxGQs9tnoLpDkXGzbCzYo8YWOVah
X-Received: by 2002:a2e:a988:0:b0:3a8:7caa:cd4e with SMTP id 38308e7fff4ca-3ab147c819dmr9590771fa.13.1792180120831;
        Fri, 16 Oct 2026 12:48:40 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab2a4691f2sm1179411fa.19.2026.10.16.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:48:40 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: [PATCH bpf-next v5 0/3] bpftool: Fail map dump for maps that can't be iterated
Date: Fri, 16 Oct 2026 22:47:55 +0300
Message-ID: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bpftool map dump" treats only ENOENT from bpf_map_get_next_key() as the
end of the map. Map types that can't be iterated (local storage, ringbuf,
bloom filter, arena, queue, stack) fail on the first key, and bpftool
prints an empty dump, "[]" or "Found 0 elements", with only a non-zero
exit status.

Patch 1 adds a helper that prints ENOTSUPP (524), which the kernel
returns from some BPF commands, as "Operation not supported" instead of
"Unknown error 524", and uses it for map create, map element
operations, map freeze and prog run. Patch 2 asks for the first key
before printing anything and fails with the map type and the error.
Patch 3 adds a test_progs case on a socket storage map, and on a queue
map without BTF for the plain output path.

The new test fails without patches 1-2 and passes with them; the other
bpftool_* selftests pass. v5 was tested on x86_64 under a bpf-next
kernel (d2141481a764e). The ENOTSUPP message was also checked by hand
for map getnext, lookup and dump on ringbuf and socket storage maps,
map create of an LRU hash without preallocation, and prog run on a
kprobe program; map delete, pop and freeze use the same helper but
were not checked by hand.

Changes in v5 (patches 1-2 of v4 are now patches 2-3):
- new patch 1: helper for ENOTSUPP, used in map dump and the other
  places where bpftool prints the result of a command that can return
  it (Daniel)
- patch 2 (map dump) uses the helper; kept Quentin's Acked-by as the
  change is only the error string
- selftests: check the full error text for socket storage
- rebase on current bpf-next

Changes in v4:
- selftests: socket storage always has BTF, so the "Found" check could
  never fail there; check the count on a queue map without BTF instead,
  and fix the comment on create_sk_storage_map() (bpf-ci)
- selftests: split into sk_storage and queue subtests, new subject
- rebase on current bpf-next, patch 1 unchanged

Changes in v3:
- shorter comment on the probe (Quentin)
- selftests: unlink the pin on every exit path, so a killed run doesn't
  leave a stale pin that fails every later run with EEXIST (Sashiko)
- collect Acked-by on patch 1

Changes in v2:
- probe the first key before any output instead of printing a hint for
  ENOTSUPP only, so every non-iterable type gets an error and stdout gets
  no "[]" (Alexei)
- drop the Fixes tag and use a neutral example map (Alexei)
- selftests: check that JSON output is only the error object and plain
  stdout has no elements or count; clear the output buffer before each
  run (Sashiko)
- multi-line comment style (bpf-ci)

v4: https://lore.kernel.org/bpf/20260928001513.7072-1-skokovmaksimevg@gmail.com/
v3: https://lore.kernel.org/bpf/20260926170149.541352-1-skokovmaksimevg@gmail.com/
v2: https://lore.kernel.org/bpf/20260925162031.27259-1-skokovmaksimevg@gmail.com/
v1: https://lore.kernel.org/bpf/20260924160732.485650-1-skokovmaksimevg@gmail.com/

Maxim Skokov (3):
  bpftool: Print ENOTSUPP as "Operation not supported"
  bpftool: Fail map dump for maps that can't be iterated
  selftests/bpf: Test bpftool map dump on maps that can't be iterated

 tools/bpf/bpftool/common.c                    |  11 ++
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       |  40 ++++--
 tools/bpf/bpftool/prog.c                      |   2 +-
 .../bpf/prog_tests/bpftool_map_dump.c         | 133 ++++++++++++++++++
 5 files changed, 175 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: d2141481a764efdfaac70965ea28e8925f6a6b80
-- 
2.47.3

