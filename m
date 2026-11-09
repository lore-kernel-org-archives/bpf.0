Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197532;
	b=UcVjLou4hvnqRzDfbEVgWQvbxNDbycc7aVtN5QPjPe/yDokq9fGK1jkmc8MJH/9gA+UX
	 8NFRVlrbccjjXl9D569HjwGGyjn52X9ZTJ5M+LdmugzAji53s0/RXVXBVXynk54NsTefr
	 Mf/D9bm2n6QzVjj7s1B/ufYLPYmUZMM6miFyGJJv39RzFzP2yTfehWm29pgbiwLS+VDOl
	 NUUHNblZ5lhpS+2ZFwv79Aj48NsKBN516jhVqKJNNEKhXbeGctYXHpdjHfPlYHKE8//Kl
	 QRyglmM9nNfMyH1U/5BtbTiRKt1hhPF3ZGCs78taMeJI6/yP2dJKZNdDiRPSRVUAylQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197532;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=IVCjuZZQPo7i/RLyprlQW7kGel9zzof2nAxQQyiVyGg=;
	b=UfGT4uTCkj0cT+jw+3g2orG6quGWXXYi7FqhOOVlUmb6FT7+IyyIOoZ4QJu0aRToa9uF
	 d69/lA3muP9kZvwvE8A7MgsSMugbfTFiEEjT5+TjGNHlgWq8cHoGjPfmRY/hgkxR6ZL53
	 k75n+yzNhMR6DC6XeURpgjcPXQlz+Ns/wxFcZVrpeapbbmQMWodBLds14Z2NSMzp43yGe
	 APHLDosiyR1ZKsFE/kLuNDeu0zAFQiWVxWPdsYSiNVAs9Oqax5+yOWKo+0AWgOZIvz7W/
	 Hyo4tkaubNyDGZc6/zStyu9QFlTwneQ0BNOQL7NYILzqZ+IxOghIwh5+Vx1O+ubsvww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F8606A323;
	Mon,  9 Nov 2026 04:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D69F8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxPNIZSPFqlbMdAA--.20495S3;
	Mon, 09 Nov 2026 12:12:09 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxxMwXSPFqQRwzAA--.11813S2;
	Mon, 09 Nov 2026 12:12:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Handle some unexpected failures
Date: Mon,  9 Nov 2026 12:12:05 +0800
Message-ID: <20261109041207.15221-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
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
X-CM-TRANSID:qMiowJDxxMwXSPFqQRwzAA--.11813S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFWrKF13WF4kAw1UKr1ktFc_yoWxtFbE9w
	40qrykXrZ5ZFyYyF15K3WrCr95C3yrZw4xJrWUX34fCr15Zr15XF4kAryvqry8Wa93t34I
	yF1DJa4rWr13XosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==

v2:
  - Use libbpf_probe_bpf_map_type() in prog_tests instead of
     handling EOPNOTSUPP globally in test_loader.
  - Fix unaligned access at the source by applying a bitmask
     'off &= ~1' instead of skipping these tests entirely.
  - Modify the patch subjects and update the commit messages.

Tiezhu Yang (2):
  selftests/bpf: Skip jit_insns_arena tests if not supported
  selftests/bpf: Fix unaligned access failure in fexit_bpf2bpf

 tools/testing/selftests/bpf/prog_tests/jit_insns.c  | 9 ++++++++-
 tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c   | 1 +
 tools/testing/selftests/bpf/progs/test_pkt_access.c | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.42.0

