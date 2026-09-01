Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951E472F95
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252444; cv=none; b=f5FuMaV5uptb0JQ1usVG3iRYFyt3cjEFLn/ZSVWFR/IB0gg0T84oZX98pJcjpvI+W02Z8d6Zx6RhXgsU2FDiDyxFcJPAHVxQGYgHk9BOQj03Nf5F6kawxORQ70FQrZ+JKXCIOXn828bXNrVrubOXokV61uU8BnIdeT1Afw2DTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252444; c=relaxed/simple;
	bh=vEYWpDRYJlt/x20Qp2NH2lICQ3CeU+BjrZBkfkO170Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U+7BcgHd0giKIyKsc9Uq27tQWOZ+bnYw90S16jPtKPby1h91HS/HFa6ieoR8eqNloDsH1NDYTtmfIecCJ93MP0lNgriZvA/Xd7vvw+SkNeP5KzBBJjfEmbd2cIoQKHw0Y+uxjRr9oKWyfQA5Tiznj34Bsl+k21pHGvaZ/smMa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hu9+T87A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfH8F/BZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hu9+T87A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfH8F/BZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z8ov4fvu3pyuSUdXNf/YgYYE8zswwHkIX6MWfjo8QZI=;
	b=hu9+T87AyG+9wrV1Pz6K14mIZU13Q0WG28w6rVRNYdjSZd/EqCH6amCTTTGa2Qu+EeaBU5
	AoqI74qxw1rLRiWUPW84nDVbGsEi2ljcL84Wxd6OGai8KvyPZGY50cJsCg3RT7G8uBXouF
	jHVZJ/26xQ0PzjQtSfspgsYZshq3kj0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-LwfnjcK9MKWgVVlX1hSQ0w-1; Tue, 01 Sept 2026 04:47:13 -0400
X-MC-Unique: LwfnjcK9MKWgVVlX1hSQ0w-1
X-Mimecast-MFC-AGG-ID: LwfnjcK9MKWgVVlX1hSQ0w_1788252433
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48439ef42d8so1996753f8f.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252433; x=1788857233; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z8ov4fvu3pyuSUdXNf/YgYYE8zswwHkIX6MWfjo8QZI=;
        b=FfH8F/BZWZqmgZiMcmUJHpFgmrvecpttBGmws6M2lTb7IZbIZo9izZxkfcMCDuKhco
         3WVRegqG91CC2KR1nAZyvi53PrQy8ibPfXBkezZAbmAbickrVyfro9drfFUlBpOxeWHS
         e7D6LYLIfOiP1No48qshXJi6f3ysxsHeId3HUfCDfLAhlmEEba0uBkBkwgunRlvj/i9w
         jvIqWgtpCqqPYnHUh3NBhrrr0o1EWe/HYZ3XuV4bnGR1yCVanPH1C8KApMATuT0onwqm
         bs7dmiRZ69zNAreNsBsEM0GWDKgv3TguSGDakG+EGtz4qyzBXCCmxf2kSqxuGs2t+uqo
         +ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252433; x=1788857233;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z8ov4fvu3pyuSUdXNf/YgYYE8zswwHkIX6MWfjo8QZI=;
        b=Wb7cdYFnunzp4WRdBJC/oAFMiqg2VFqqz8AZ/TXoQgGrsaQ52gw5b8sLFD0CiOiYoo
         vyy8VNGvUJeDKqFiBWKXJ/otVXvgiTRY4XxxIRMloTPofgeWf5RgXNaRQWLeQrQMjscB
         zVwcNGpoCIWE9TzJNM9Cl12sT0/nhkTJKmtXWpGj5oSQFPaDt2ZCUXdR+jgNH+gKrvEZ
         Z5VzuKfDjMFfqPctRYdlFdghrKZRXXdJjYTq4o0RwMVqwLlxATQCQbtXgdOb4FS+kfeI
         yolWZiaygzVxBq5NsYlcfdJ1JmrB1ORsFcVQkv7e426LkPdc8YoPp6rRcKLlATvO4Vv0
         ebgA==
X-Gm-Message-State: AFuF++nQ1skFDIaZO17ewm++ll0p+JGEMgC6Bg0tgeJq8HfzeLfloes8
	QVvOyo+TBBFpD4IFXIayzeH7UaF7ApeIOa4nP8YDvg7sQMd+HrWRnyySNUH4VTk7XW9FeERbYVZ
	Etz5e1reMfNewYd/r76wihhmgAGBJAFKwcafTHdYY68V+ewGk5VEKSA==
X-Gm-Gg: AR+sD11YVS7kghKJySsTI0eEawxFxqP0ABNEYlTD21JDeM/6+zpLIP0ByQ0OG98hgBD
	E1/pvh6dWkLDrKXkWtc1Wr1NDrIGVkFYK5NlB8I21lKhK62ComiYmqdMUAaT8/eOBHOO9SD8xV1
	1u28I63wa+O9U7l7vEM/6brMsuFF7cDWB4f56owKpoYk4pCNZeXrwuIp+2AAidPsHWTLugulcMb
	Wwuoy7Ked/MvvZlUDtHw4FUmjQFA9qYcYBc0/5gwGqfvOfQBGe4+NlDriMCnRloD9Q44OiI++VO
	tthYd+B6MoPqQruQi5yk0TqvvFlFzbQaXYI3ViwU0J8VfVAlGS1QuawNi10rik4TLACBVcmTBkA
	T55HdqL0owSINLCxOHZ/YRcLQ
X-Received: by 2002:a05:600c:81ca:b0:49b:47b3:d6d with SMTP id 5b1f17b1804b1-49b91c3b7c4mr553882405e9.10.1788252432571;
        Tue, 01 Sep 2026 01:47:12 -0700 (PDT)
X-Received: by 2002:a05:600c:81ca:b0:49b:47b3:d6d with SMTP id 5b1f17b1804b1-49b91c3b7c4mr553881435e9.10.1788252432157;
        Tue, 01 Sep 2026 01:47:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a903eebsm220814965e9.4.2026.09.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8AD2497C51E; Tue, 01 Sep 2026 10:47:07 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v3 0/4] libbpf: Move section-defined program flags
 to prog_flags
Date: Tue, 01 Sep 2026 10:46:53 +0200
Message-Id: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBREryKzbiDREtCrlC5M8mO/SCr5tgji3
 U3azcBjZt4BocwkGJoDmb4s/E4FulsD/xrTRIpDYbS6tbrXRi3s3BpVzOMkKi41rQtEPvTWmDv
 Kcc0Uef9JH6jjRPuG57+Rj5vJb9WJ87wAtz1/IYAAAAA=
X-Change-ID: 20260901-libbpf-frags-flags-6bdeecd96114
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.15.2

This series moves the libbpf section-defined program flags into
bpf_program->prog_flags, thereby making them available for applications
to inspect and modify before loading the program into the kernel. See
patch 3 in the series for details.

Setting program flags with bpf_program__set_flags() was always
potentially a destructive action, as it clobbers any existing flags.
Since this changes the flags value to be pre-populated at
initialisation, this clobbering can be visible in cases it wasn't
before. To prevent any fallout, the first two commits fixes up existing
in-tree users of bpf_program__set_flags() to be non-destructive.

v3:
 - Also fix destructive flag setting in bpf_verif_scale.c
 - Reorder patches so fixups precede the libbpf change.
v2:
  - Use a generic section setup function that also applies to BPF_F_SLEEPABLE

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Toke Høiland-Jørgensen (4):
      bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag non-destructively
      selftests/bpf: Set BPF program flags non-destructively
      libbpf: Move section-defined program flags to prog_flags
      selftests/bpf: Check for flag presence in bpf_program__flags()

 tools/bpf/bpftool/prog.c                             |  2 +-
 tools/lib/bpf/libbpf.c                               | 20 ++++++++++++++------
 .../testing/selftests/bpf/prog_tests/attach_probe.c  |  6 ++++--
 .../selftests/bpf/prog_tests/bpf_verif_scale.c       |  2 +-
 tools/testing/selftests/bpf/prog_tests/kernel_flag.c |  3 +++
 .../selftests/bpf/prog_tests/kprobe_multi_test.c     |  2 +-
 .../selftests/bpf/prog_tests/xdp_adjust_frags.c      |  3 +++
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c     |  5 +++++
 .../testing/selftests/bpf/prog_tests/xdp_metadata.c  |  4 ++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c        |  2 +-
 10 files changed, 35 insertions(+), 14 deletions(-)
---
base-commit: 1555de33018fad06ca5dfa2fad5d3d1c6a6eb2fe
change-id: 20260901-libbpf-frags-flags-6bdeecd96114

