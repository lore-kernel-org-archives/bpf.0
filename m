Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093FD2036E9
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585924; cv=none; b=l3sAm/0G048/pVc3gGIl3Cz11K1JetKXpA06MFPs9kDVwDgkSDPuQFa1rg26bJskiWxyHV6Hm23YP+EqlZcwddjY8M8VAJXN+qIhghaNw4tm8f7do+ZMzLJUz2jj7zpu+POEZ9I8ya0vpJHEgXtJGH4ulktwsupsaicqEMfmdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585924; c=relaxed/simple;
	bh=+qITzc0nYndsJnSIl9WaKLt75+TTKnMpfvPRw811BeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3hkscz0xhc90du1duWICGtvdOYK+B8RhBQ4pb23mGwDkLqa9I+oJmD318czSJTczatVGQ64KHxNVS9mAT1s1SUAluha3Np3vImHaaaSnXrRJQai2QkdGh22HPSjiH11ZmGwZym/xKm0uWsojebHTWGeCUPIKkRNx16NnlIvvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=jbLFMr7C; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="jbLFMr7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Cc8rv
	lCVmEmaTW8T4knwa4aBT3r62nlUfZa6t0sDric=; b=jbLFMr7CEf5jUw5XNFfV0
	RMy+t0JrgwWgBIj8MVupGOBIx6HUmuELWuPDbUaT+Onnh0Uh7eb9VAjDvpCsXhtc
	OX19ztFT+36FLBxsosA8l9XUr6HTDxdvLkDJinygnBCiF0oa6nu8IW0m24he6F6J
	AxJn3Sg1a+HWiZwYaddL/c=
Received: from dumpling.. (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQDnnr65lSFqvf8mAg--.4748S2;
	Thu, 04 Jun 2026 23:11:53 +0800 (CST)
From: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: dxu@dxuuu.xyz,
	Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>,
	bpf@vger.kernel.org
Subject: [PATCH bpf 0/2] Keep dynamic inner array lookups nullable
Date: Thu,  4 Jun 2026 23:11:51 +0800
Message-Id: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQDnnr65lSFqvf8mAg--.4748S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1xWr43Xr1rArW3WFykKrg_yoW8Gr1Dp3
	y5Was8Xr1kCF1Iya4fAay7WF1YqF4kJ343CFn5G345Aa4rX34UJFWFgF4avF1YyrWfXw4S
	qw1Iqan8ua4YyFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ryrMxAIw28IcxkI7VAK
	I48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x0JjrManUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEIA2ohcr874wAAsV

An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
inner map template. The flag allows a concrete inner array with a
different max_entries value to replace the template.

The verifier currently uses the template's max_entries to elide
nullness for a constant-key lookup through the inner map pointer. At
runtime, the lookup uses the concrete inner array's max_entries instead.
The verifier can therefore accept an unchecked dereference even though
the runtime helper returns NULL.

Patch 1 keeps lookups through BPF_F_INNER_MAP array templates nullable.
Patch 2 adds a verifier regression test for the unchecked dereference.

Before the fix, the regression program is accepted and the runtime
reproducer triggers a NULL dereference. With the fix, both programs are
rejected with an invalid map_value_or_null access.

Tested by compiling kernel/bpf/verifier.o and
verifier_map_in_map.bpf.o, and by running the regression program and
runtime reproducer in QEMU before and after the fix.

Nuiqi Gui (2):
  bpf: Keep dynamic inner array lookups nullable
  selftests/bpf: Cover dynamic inner array lookup nullability

 kernel/bpf/verifier.c                         | 13 +++---
 .../selftests/bpf/progs/verifier_map_in_map.c | 40 +++++++++++++++++++
 2 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.34.1

