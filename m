Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24B137750;
	Fri, 19 Jun 2026 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828828; cv=none; b=BiKGG4lp4facXuIeAGzKKhWarvmpBZOW8eX/fp2NFWK8MOUnwROsy5Qs3IcDEqrL4Aqbbw09uTu4LtnOgbCiG1B8SvoEQRmjdd14PKVYxZFOEJyDoYQZiBTN/OUf0VlpMRIb731oAedG9WSKOfyZug/jfhdAab2wXJfZcvHzKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828828; c=relaxed/simple;
	bh=N8G4lhILxqbxUOl+DnNqu92qxTo4zm9QVVXVz9zFpg4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c2H7A+cKXkhBOGHWM4wjagKHVKbLOAlJFy9PYmLk9CNrGc0pARnMNhNqzIzq9mhaqiuedlI9+RYy0YlVQpvKUs0KIoNJf/YtRmmrnEGFhBTeZ95EDUAvCwa7JXW3WjqErkWdDJZBk30/8bgCii0vRVuBmKAIgKAVO3qSLm6pWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjaer5Qh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjaer5Qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CDF1F000E9;
	Fri, 19 Jun 2026 00:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828827;
	bh=Aw0ik/UhbN/GA990xplBgiz7Qv76LyMsStJfb5q7APM=;
	h=From:Subject:Date:To:Cc;
	b=fjaer5QhqqTDRox/dKdIFRdkp2n2ax89riaJk9kYCdtiMT94sZTpOgCm4wMEu9dOZ
	 4ShwK0QFQzHtv+VhZURo16Zf/JDVDImr/qCRrI61k+sV35fgZq1jvQXiPQnmg5CHvi
	 a5rxea0Fm6LFXAshTmQF71qkLjn3n33AnajvzDDBDvGlka3GqF/wZF+NXdVmQwMF6d
	 PK/A0Y5KrhrueTmKkOzj5YP9wrdhUTP7xIuvJXb9vYchhFZKT30qZ4g9bHNLiHt0Fg
	 2voXq9iImTe1Enhu6bgR8UKjucLnTu5kmyGZvt44rZeHuH4kYwP9gE3181TAebxML1
	 IO0CmvQtjP/6g==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH bpf v2 0/8] bpf: Fix ring buffer handling
Date: Thu, 18 Jun 2026 20:26:38 -0400
Message-Id: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2TW0YEVO/ofhQOsCq6aQLRAN4
 d8tePc4M29mFggkTAHKZAGhmQP3Pgp9SMB1tW8J+R416FSb1KgM7dCgsG/t1GDDbwpIl7qwmTN
 KnyzE3iC0B7F2g4hD9TPDZB/kxm1twzoOYy+f/XlWO/znZFaYIhmd5YVy9qzz65PE0+vYSwvVu
 q5fwG49W8oAAAA=
X-Change-ID: 20260613-bpf-ringbuf-fixes-e9a8b3c6125b
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Tamir Duberstein <tamird@kernel.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919; i=tamird@kernel.org;
 h=from:subject:message-id; bh=N8G4lhILxqbxUOl+DnNqu92qxTo4zm9QVVXVz9zFpg4=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPRefC+5LflN+/cAfleL5ora8O96urbvgVpYWFRnoU
 rlFdub0joksDGJcDJZiiiyJoof2pqfe3iOb+e44zBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjoGPMwMUpAFN9PI2R4VicvQznT7cK8UdzjM+KfTQ9OXPLrbdLdn8Q388su6F7qzkjw5Iwn5I
 t61Qbn6Z0NdgFH5z9/6Fr67+prxc/9r0btDxkOT8A
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Fix correctness issues in BPF ring buffer handling.

A zero record bound currently consumes one record. A NULL callback is
accepted during manager construction but crashes when callback-based
consumption reaches the ring.

Native-width position counters are also compared by magnitude in
libbpf consumption and pending reservation tracking. The kernel
user-ring drain widens them before arithmetic. On native 32-bit systems
these paths fail after counter wrap.

The libbpf consumer can also miss a readiness notification after
publishing its position and checking for new data without a full
StoreLoad barrier. Use compiler atomics and add the missing barrier
between publishing a consumer position and the next producer-position
load, including across busy retries and early returns.

Callback traversal does not follow the overwrite position maintained by
BPF_F_RB_OVERWRITE maps. Reject callback consumption of those maps, as
discussed here:
https://lore.kernel.org/bpf/CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com/

Andrew Werner found the position-wrap and missed-wakeup failures while
implementing Aya ring buffer support. The original implementation
contains the equality reasoning and edge-triggered regression test:
https://github.com/aya-rs/aya/commit/e2cf734490bc188bcedb1eac92d23d81123e42cd

Aya later corrected the consumer ordering with the same explicit fence:
https://github.com/aya-rs/aya/commit/7277a57ea8cdb74918d3096a4b22b6d814481973

Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
Changes in v2:
- Fix additional native 32-bit wrap paths found by Sashiko review.
- Explain modular position comparisons and leave mixed-bitness ABI work
  separate.
- Preserve the wakeup handshake across bounded and callback returns.
- Follow BPF comment style and simplify wakeup test cleanup.
- Link to v1: https://patch.msgid.link/20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org

---
Tamir Duberstein (8):
      libbpf: ringbuf: Honor zero consume bounds
      libbpf: ringbuf: Prevent NULL callback crash
      libbpf: ringbuf: Reject overwrite callback use
      libbpf: ringbuf: Handle position counter wrap
      bpf: ringbuf: Handle pending position wrap
      bpf: user_ringbuf: Handle position wrap
      libbpf: ringbuf: Use compiler atomics
      libbpf: ringbuf: Prevent missed wakeups

 kernel/bpf/ringbuf.c                             |  12 +-
 tools/lib/bpf/libbpf.h                           |  35 +++-
 tools/lib/bpf/ringbuf.c                          |  97 +++++++---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 228 +++++++++++++++++++++++
 4 files changed, 340 insertions(+), 32 deletions(-)
---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260613-bpf-ringbuf-fixes-e9a8b3c6125b

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>

