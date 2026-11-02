Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650444;
	b=4aYM6k/UsgDgLDAU4m6ear51xNUyt0QDiQ9bW7uE0IJi+6wIEEpkuGyS4Rzg5I616Cve
	 OKPOwMDfxOKz/OYC7hAdrywyB1iJBnxmgtMAvkeMDSzIBmgVWx8xZhItd3XzWyoVt6OTN
	 qsEFjofl56riExC7mVXkOPLhRcQxlYx01rsm0ncNKmlOeStcJqg2Ar1zqyvw0icNdz4hg
	 kC2K46D25J5xN4Ajc/eVKXudPDBrgILjmtwWS/z9iG3jdjU0kh5W6CH2IJ2MrJbEc5hik
	 CqFuAmiOR18if6xtivpiMBHYE9NzZW/KOfJqdUim4c88lTlqo73H3Hy0OJufiNXwO9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tGanUMfayq3PdyLOv1Doxlx1VPFFMeHl/eaWWctPQ0U=;
	b=Z2hcW+InKp3uiL4/Bl9h7O51IqTFEmQOfCm4k21Yok2w40hhqXhgahbci8iHdAR/THd3
	 0HrMzQHkF23lHnqIe2UuvT9H+nubDvOYxU5Q6CrVZPeDCXbBmbwaZkmbzn2VYqs6s2irI
	 GUooFyw98hNwLim9bMqGwiD/Bi8XHtsQI3RfaewvI+YZkV0WnDonRL4KF+mRW2R+ctrpX
	 KXtz4KF7scdAjD/dXQQAHIuQpS0xRc3zzMS2rQg4So7ER+dRcJbp8rw4sI0Wq45LeJ/3P
	 y3odR9R+o4YSKr4cviU206wu56lKpaYDrb71Caq3y+OLiw2DwuFIlEprBx9cGsVnFHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zixO318e;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3559606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 20:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3559606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zixO318e
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c4649b35bso3280995f8f.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 12:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650442; x=1794255242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tGanUMfayq3PdyLOv1Doxlx1VPFFMeHl/eaWWctPQ0U=;
        b=zixO318eJYLfhb+XNiTcj4Wd8KTuj8oKOfOp7Fqp8NvJFc/1JZBHI6keegIn+u7btr
         CKKm0WeJ7v4EhvVDWDguBbTah0n7jssE4aJOXj/5z27tjK+6U5lClhma48jfdLpNYWJp
         Wi2T5jaYdn/ArobqwxviNhfr4U0CAmYzvuhyX+4yYNYUCwhmQ05bBgyI6F6aICXxcz75
         +4VHeU7duOBeddPuirmFB5z8bWKFF21FZEDwXEGu0ADxleF3gJboUmDE/aGw2unc33L4
         MvNohpwynI346AQ0mB/RMr0S98P5cuSOcOranZBcOrgxmz0XnaSWkLTNSoHMOvZosjWI
         g3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650442; x=1794255242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tGanUMfayq3PdyLOv1Doxlx1VPFFMeHl/eaWWctPQ0U=;
        b=F4fQUurBetk6CxtmBOymxy4P4wk2yZmQVe81wIBNIgqTSeVJd1YfXKn91s4VvbePc3
         gaKsvR738SmYRNYKfxtkZ/4TIKJEklAKlZJoUkB8G1RjPYR7ybwWP9Y3olPgtNf+9bpR
         UYACOJ4fueMd/1A3QV5G/cgGa47CLSN/kBuGfCvt2hgln585+72Q8TRK8WSg7bsJmwqm
         s/WTlpeX6261a5LUasAtG2yUqoSd8EZalBq0jW77JMOHyPQxFOE7TA9fENCeUKKyyXCM
         tELolwuIScn1iKPTVkbTiRn4XGwyxcGpHC6VZB610Ejj9Q6A9/HqmacKZttiQ0Md4ODk
         zpCQ==
X-Gm-Message-State: AFq9FYJaKTwitq4jZqF3ZHwjhCCJc+4W9OHMSKLbPaKElS9Ecb06DVIR
	S1Nmcxrh3a1WrDlFIolO7ClhK5ikkyHJoKlC+2+5Rzu2+D5z12LfuRoRH2ibYhsk99Cs5Q==
X-Gm-Gg: AYBFou0Pybvnk7yFwQRYKgkYO+DKAKZfoYFwsSKeOX/qwoBddytYPCKONqwHHkGnPTO
	r2S+npEEkatXoDfDj0ixjg9wCj9HVFQ2D9bo1fmexkOhl1++zN/z8modnObKTKuJVr0HaFLQ/Ab
	QLJxw9xg/EwMPY2eyYWrn2s1ugLeUN7lbSclfHp7IDUlu8dSPcitU2rwA6fqCKYIQJAhQGF7vTY
	KU5o1yaWxfcNuRMb6RwvP7wa6YEjN4rhmmMXhFz3K3aCyRcgYcBbMqGmN+W5oSP7kyE/vGux/Cd
	MsjjPbrrMCz+BTITSfajiiZlWUx09jbwUVbIQAzE2/59gAw7Uo7r15v0KqgsYHdqZX1D3rZ+eyi
	s3m/KT1LlhkzurJ/wH7HCfmq69Oj47xD0VRpore+YWRViXGdjGqVNNc+c28NiT5mg1iJDlcS3VE
	BXHNcFzv209nRdSDtCAaWnkiZCb/CJKaf2cv2Jai9JLndfbINtDxJAnkhiRE9pCCzkW3Z4TtGWk
	NqKfsYzLoHgLeJTvduJOmQFDy8AbAj8/3dUE+UZN0S6F7cqWDdQICJ0qYx6w78/16hP/CG7kEin
	KdVQXWoJcJlpbRD5rK0ZU/Hx7SyQIUKklyMi3QHe+TjpFrKsI+b2fVxTNe8xAu1KRYRYw5Mv+yi
	2
X-Received: by 2002:a05:600c:34d1:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4ac183d136dmr250002875e9.24.1793650442391;
        Mon, 02 Nov 2026 12:14:02 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm21471805f8f.43.2026.11.02.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:14:01 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Tianyi Chen <hi@tychen.cc>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Hui Su <sh_def@163.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/5] libbpf: Support gen loader attach
Date: Mon,  2 Nov 2026 20:13:51 +0000
Message-ID: <20261102201356.5798-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hey,

I've been working on this in the context of Shirudo[^1]. The current
limitations we face is that gen_loader cannot attach the program it
loads so we still need a userspace component to be allowed to
BPF_LINK_CREATE and we'd like to gradually remove the allowed operations
done in userspace to solely rely on the signed program.

Note that there's no kernel modification in this series, it adds the
gen_attach options and code generation to libbpf and do the wiring from
bpftool. The kernel side was already allowed thanks to 'b1d18a7574d0
("bpf: Extend sys_bpf commands for bpf_syscall programs.")'.

Also note that I did some analyzis with Sashiko and it's been
complaining because I've followed the approach with the prog fds being
initialized to 0 (and not fixing the two fds to init to -1 sentinel
value), so maybe we should pre-patch this.

Lastly, I don't know much about bpftool so unsure if the way I've added
it is the most appropriate way for the lskel attach option.

v3 updates:
- rebased again because I had a debug commit in between master and my
  patches that somehow surprisingly conflicted... sorry for the spam!

v2 updates:
- rebased to includes changes from the 'libbpf: BPF program manual
  loading'[^2] patch series that conflicts with that series.

[^1]: https://lpc.events/event/20/contributions/2437/
[^2]: https://lore.kernel.org/bpf/20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com/

Mahe Tardy (5):
  libbpf: Count entry programs for bpf_gen__init()
  libbpf: Track generated loader link FDs
  libbpf: Emit BPF_LINK_CREATE calls in generated loaders
  bpftool: Add attach option for light skeleton generation
  selftests/bpf: Test gen loader attach

 .../bpf/bpftool/Documentation/bpftool-gen.rst |  11 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/gen.c                       |  67 +++--
 tools/lib/bpf/bpf_gen_internal.h              |   7 +
 tools/lib/bpf/gen_loader.c                    |  41 +++-
 tools/lib/bpf/libbpf.c                        |  55 ++++-
 tools/lib/bpf/libbpf.h                        |   3 +-
 tools/lib/bpf/skel_internal.h                 |   4 +
 .../bpf/prog_tests/gen_loader_attach.c        | 229 ++++++++++++++++++
 .../selftests/bpf/progs/gen_loader_attach.c   |  48 ++++
 10 files changed, 435 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/gen_loader_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/gen_loader_attach.c

--
2.43.0

