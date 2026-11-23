Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408756;
	b=Er38LEPgQYVspMWJ2kprkt7qt8CqroJ7JFtBTeWvZ3wYqKbWYon+rko+QJAvYQrpl3Hn
	 f18WPeaYGXu7hccIHmJLFKIjcTNLM2GuIABfpRKIwhOO/HSzThm6DJ3d16DS76wBlc39x
	 mTHEyXEkmS/LpmTZTDwKMqiGvwe6ND26mWbrcCvPQHcypT4ivxdZnJu8zfwZ/lKEJAAG+
	 pF0Gh9sCWb25MK+rZgQh+eWPkGtb2PbARS3y6+JlVnExJA8Ir40ERh1TfGkq5OzeZ/KD5
	 OiNoKKiRruL00uRgcOgGOEpRB5hbIeIHhyKj6BQPDYav65lLOPtc6hFHk1DlTkSikjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408756;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=Ja+J7AFjxGVS/OpS76/QrYcf6mps2x4KYVMn+97+OA4=;
	b=Sjty85ep+ikUpbc2fWKgvu14cawk7RZRYHNdEMTlpmCzoBB3CkyWa6GlPN6cQg8psH2C
	 O+gGdQjgtKZOhU/PRPIGqi+4HBkL2hhJF/4RRbIwhGMY2L/JO6aPT8hUEmja+GA0C2aab
	 /ldVsRf/0pjAbXslfsypteNuy6KzQ8AZlBc7GgSgwkK3LwCkpp6b54bh3vOPAQfvW+jKJ
	 KuGYFq/MmJy7wAwOWlN75/VGSM0eR54DyIDb4bglWUqzryaeYyK+V/2S2sxATk+bWBYck
	 6JHR7ijqooUgnEBv7907rPE/0Lk7gOfLWg1J9M5DjpLM1we1pL1rsdzOGwgb70drTEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA5606A31A;
	Mon, 23 Nov 2026 04:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AAA5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxX9NwwwNrCx0iAA--.31746S3;
	Mon, 23 Nov 2026 12:39:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs9rwwNra8s2AA--.43419S2;
	Mon, 23 Nov 2026 12:39:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] LoongArch: BPF: Support instructions array, indirect jumps and calls
Date: Mon, 23 Nov 2026 12:39:03 +0800
Message-ID: <20261123043907.20225-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJCxPs9rwwNra8s2AA--.43419S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF47Cw4rGrW5Jr4kAFy7urX_yoWkCwcE9F
	Wfua4xArWxtayYka4293Z5AFWDAay8XFyFkFykXry8Xw15Ar1xZFs5CwnYywn7urZrJ39x
	KF42vr1vvwn0vosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07jjWlkUUUUU=

This series was created on top of the following unmerged patches,
though there is no actual dependency and git am applies cleanly
without them:

LoongArch: BPF: Fix the offset of stptr.w and stptr.d stores
https://lore.kernel.org/loongarch/20261118071444.10258-1-dongtai.guo@linux.dev/

LoongArch: BPF: Optimize doubleword loads with ld.d and ldptr.d
https://lore.kernel.org/loongarch/20261118081201.10498-1-yangtiezhu@loongson.cn/

Tested with the series of BPF selftests, here are the test results:

$ sudo ./test_progs -t bpf_insn_array | tail -1
Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED

$ sudo ./test_progs-cpuv4 -t gotox | tail -1
Summary: 2/14 PASSED, 0 SKIPPED, 0/0 FAILED

$ sudo ./test_progs -t callx | tail -1
Summary: 6/89 PASSED, 6 SKIPPED, 0/0 FAILED

Tiezhu Yang (4):
  LoongArch: BPF: Optimize BPF_CALL control flow
  LoongArch: BPF: Add support for instructions array
  LoongArch: BPF: Add support for indirect jumps
  LoongArch: BPF: Add support for indirect calls

 arch/loongarch/net/bpf_jit.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

-- 
2.42.0

