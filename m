Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567761;
	b=thIVfEl5Cyj4gVykPlqtFGRaUTvzVCydy31kl/+kQS7whleZAY4xd6woqFrILd86F2xK
	 rcQCZQ8pE3qGxHeftW6XrvADjvOCp0tKlClDETYBsonzpkbQm2gUlMlmvc2pKufegoPvS
	 naherOY0HRB3mXotxsXfLWwqImTcMnvVPoEsogmImlD5VGA+M75QBqWs+btW8MLXX2Cie
	 l4sSlNkoPlgd+hFviHXtvSHOQ3C1pSDTrBqDB20XdR2k4/5v+P6OwelEMsCFziKhjTBKw
	 eWDcTDe+ISXjif5xaqTQUFWEyc3b+sQfJNcYQOC/Kwb0OnD6hLayGnWlCLC4saitXEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=OSLpuH99oHeompfwZo3B6N7fbfKpZMQZXzH6A19PzVM=;
	b=fot+HUrKPIp+ZEIFXUij91NX1TjGWaWSKMoUnOCMp7i3wl5JQP6FxRDfiacQPInjHYBi
	 gvjxVdUvb2epxs+JC5T/GKqAy1UEU/4Ln9a4YiRMBf0VK53hJonoCj3LmrC3tzvi2KG+9
	 YzvAnAcChguTO4ywxx4J05k+JV8rUhdG8mqGVmHPqoYsrIsfZes2YtYoym9muRAUoslOX
	 RyriHvfANgiHKR+zX0cyVRDkYh1+xWSYpbdb4fUWQ+PV8vqbLGJez/MZ1lgqtkSyNNuEU
	 OcpwKqy1lsCN6R+Kub1jqGO6OPCLvBPyqHqsyXe4A1DQdWZz+KHfYa2FF7OhGvBOxxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oTyRTbMG;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEA606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0CEA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oTyRTbMG
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f0578f1d51so50804555ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567760; x=1796172560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OSLpuH99oHeompfwZo3B6N7fbfKpZMQZXzH6A19PzVM=;
        b=oTyRTbMGmb7tBPj7rG68hAy0GONLcoOD0DoRc3AIxteCajXU6YmT2Ov330PckDwljQ
         NAzfTYxtoxuWO3y1XoVr6/kWNY53DNjXsi6NTBI7ZpwOHRCka+57XPUh2k0s9ozX55Hn
         rs74TpBXb2itpQI1P4kx2qsl+6YHp2hgiEWMaWOnAI7jfFJXfspy1WxqeLuItsobX3Qo
         aeiLQuDW+J/jQVh65DhiMUpOYNju/0o/GwYmZkdZuMkeh8pSrkCWwmFEtBC5gBZRvJmW
         yo+xLrEPkh+xJk6egO1BQTUDyj5B0so/KV8EfamlU6dS9tcGvsH9YnreMJ96rtwS5cpJ
         5DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567760; x=1796172560;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OSLpuH99oHeompfwZo3B6N7fbfKpZMQZXzH6A19PzVM=;
        b=LCeUkuQKO3q76tuRfZpHx/VFqN/RZp1duKFMThLNp/dS2HZLZHXnhEv/PbwrvYS4lH
         VRYbdrsdzBfx7ns9uylgzP3NDYTS5CkF2VT5SBlc4hARfpgNciEfsPBuF4QYFq4qZjux
         AI0dWus5cSixfm77+tDjHN/PH14Hf3sEPdwlac8NnB8tkbZ9tI5ebyq10iS+bRGYcUhG
         H7TNhHaOQsIJvScK0NCoKvlCSENUJj1A4qmZqCcCAd+S2ZunbkH3zHzDDslUSSjXwwtP
         pjgzw+Pqf8YwLcCQ7vdaq7gf4mj4aFMqw/bqNXET1i5KfH+bBpc/W4dPGx1Erm2aMb01
         +Ffw==
X-Forwarded-Encrypted: i=1; AL+hErGkn8SmA7IMte379tNCQT9K16bVFb88eGrJjo/c79AsKUKcPpgqoz9MpoVaPYVX8dqIVAo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FQOZ0h4BityHQ2SBhQym7Y/ZfvNMjeosfvfxOjGWcVctv1aEs
	H32yObAmab0S/18x8+5IoX0WCKtt8ZGM9ifZIlmsUdctVndM9+7TtGbXt3jrnSxzRdXhLfbWgOz
	JRA==
X-Received: from pfbcr10.prod.google.com ([2002:a05:6a00:f0a:b0:8b6:29f9:ce4c])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2587:b0:3ed:bdfd:23a8
 with SMTP id adf61e73a8af0-4014ce5d1femr17540776637.61.1795567759846; Tue, 24
 Nov 2026 16:49:19 -0800 (PST)
Date: Wed, 25 Nov 2026 11:49:08 +1100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125004911.3937193-1-tweek@google.com>
Subject: [PATCH bpf 0/3] bpftool: Reject non-autoload programs for light skeletons
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sid Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When generating a light skeleton (bpftool gen skeleton -L),
bpf_object__load() skips non-autoload programs (e.g. SEC("?...")), but
bpftool still emits struct bpf_prog_desc and link fields for all
programs. This causes the loader program to store subsequent program FDs
into preceding struct fields and leave trailing prog_fd fields
unpopulated (0).

Following the discussion on the earlier "skip non-autoload programs"
series [1] and Andrii's feedback [2], this series returns to the initial
approach [3] of rejecting non-autoload programs when generating light
skeletons, while incorporating the prior review feedback (moving
bpf_object__gen_loader()/bpf_object__load() earlier in do_skeleton() so
post-load autoload adjustments are observed and documenting the
restriction in bpftool-gen.rst).

Supporting runtime toggling of non-autoload programs in light skeletons
was considered, but does not fit cleanly with signed light skeletons
where the attested loader blob should remain authoritative.

Patch 1 splits the two SEC("?kprobe") verifier failure tests out of
test_global_percpu_data.c (which is in LSKELS_EXTRA) before Patch 2
rejects them, so selftests continue to build at every commit. Patch 2
implements the rejection in bpftool. Patch 3 adds a selftest verifying
the rejection.

[1] https://lore.kernel.org/bpf/20260918040919.3402577-1-tweek@google.com/
[2] https://lore.kernel.org/bpf/CAEf4BzaeKXEC-gBbxo36wdAGwwZxqkL6pV=3Doo0dk=
e4S2BmuRmg@mail.gmail.com/
[3] https://lore.kernel.org/bpf/20260904031912.2133476-2-tweek@google.com/

Thi=C3=A9baud Weksteen (3):
  selftests/bpf: Move verifier failure tests out of
    test_global_percpu_data
  bpftool: Reject non-autoload programs for light skeletons
  selftests/bpf: Test non-autoload rejection in light skeletons

 .../bpf/bpftool/Documentation/bpftool-gen.rst |  4 +-
 tools/bpf/bpftool/gen.c                       | 68 +++++++++++--------
 .../selftests/bpf/prog_tests/bpftool_gen.c    | 30 ++++++++
 .../bpf/prog_tests/global_data_init.c         |  3 +-
 .../bpf/progs/test_global_percpu_data.c       | 23 -------
 .../progs/test_global_percpu_data_failure.c   | 30 ++++++++
 6 files changed, 106 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_gen.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_da=
ta_failure.c


base-commit: 84afebd853437e44cb71f718be11d90e4c1a59dd
--=20
2.56.1.831.g720f3f5937-goog

