Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E9C395ADE;
	Thu, 21 May 2026 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346900; cv=none; b=W3s+gg7roM765gqezxaW0kAgKtz9sWPklg62CFdiUj/gQEbtcBET015EWfeSr1B/v+w6EaGC9b9qJj/WoXDG2oVKZqmOzmPtdEEbqYCDvjyJz90nXZF7nL58/qhTA0nINa2qwafVyY7hxAMfTPAltGExs2KkHot1n1kby4IV5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346900; c=relaxed/simple;
	bh=aNcRTshATtqNnQc/ghMcCvS4s9nYtGLN12OVHyuM2yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZRAhfLA4kT1W5oONEyYIk28CJ2Pds/4IrFm0N+SHPcunbEB/+8aiZdpLRWXghrOOMdXFtyL1Q5F0UB709lmbDU5vqtOU/nWLLdVAhHL1Ff/Trr85Fxlcp9LfIzDY5Gx0zvhM1q6mmooySj02OHGBvZZ32np4IK9mOVpnnRuvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxvsDMrQ5qSegLAA--.10961S3;
	Thu, 21 May 2026 15:01:32 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxaeDJrQ5qureKAA--.1831S2;
	Thu, 21 May 2026 15:01:30 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] LoongArch: BPF: Fix some tail call issues
Date: Thu, 21 May 2026 15:01:25 +0800
Message-ID: <20260521070128.28086-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeDJrQ5qureKAA--.1831S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF18ZF4fCF17tr4DJry3Jrc_yoW5Xw1fpF
	9rZwn8XrykZwnayF429w4Iqrn0yF4kXrW5JryfA3sayr4kZryjgF4DCFy8CF98Krs8K3y8
	AF1xZr18J3s5JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUUUUU==

With this series, all of the related testcases passed on LoongArch:

  $ sudo modprobe test_bpf test_suite=test_tail_calls
  test_bpf: #0 Tail call leaf jited:1 17 PASS
  test_bpf: #1 Tail call 2 jited:1 21 PASS
  test_bpf: #2 Tail call 3 jited:1 25 PASS
  test_bpf: #3 Tail call 4 jited:1 28 PASS
  test_bpf: #4 Tail call load/store leaf jited:1 19 PASS
  test_bpf: #5 Tail call load/store jited:1 23 PASS
  test_bpf: #6 Tail call error path, max count reached jited:1 172 PASS
  test_bpf: #7 Tail call count preserved across function calls jited:1 1123 PASS
  test_bpf: #8 Tail call error path, NULL target jited:1 18 PASS
  test_bpf: #9 Tail call error path, index out of range jited:1 18 PASS
  test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]

  $ sudo ./test_progs -t tailcalls
  #465/1   tailcalls/tailcall_1:OK
  #465/2   tailcalls/tailcall_2:OK
  #465/3   tailcalls/tailcall_3:OK
  #465/4   tailcalls/tailcall_4:OK
  #465/5   tailcalls/tailcall_5:OK
  #465/6   tailcalls/tailcall_6:OK
  #465/7   tailcalls/tailcall_bpf2bpf_1:OK
  #465/8   tailcalls/tailcall_bpf2bpf_2:OK
  #465/9   tailcalls/tailcall_bpf2bpf_3:OK
  #465/10  tailcalls/tailcall_bpf2bpf_4:OK
  #465/11  tailcalls/tailcall_bpf2bpf_5:OK
  #465/12  tailcalls/tailcall_bpf2bpf_6:OK
  #465/13  tailcalls/tailcall_bpf2bpf_fentry:OK
  #465/14  tailcalls/tailcall_bpf2bpf_fexit:OK
  #465/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
  #465/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
  #465/17  tailcalls/tailcall_poke:OK
  #465/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
  #465/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
  #465/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
  #465/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
  #465/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
  #465/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
  #465/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
  #465/25  tailcalls/tailcall_freplace:OK
  #465/26  tailcalls/tailcall_bpf2bpf_freplace:OK
  #465/27  tailcalls/tailcall_failure:OK
  #465/28  tailcalls/reject_tail_call_spin_lock:OK
  #465/29  tailcalls/reject_tail_call_rcu_lock:OK
  #465/30  tailcalls/reject_tail_call_preempt_lock:OK
  #465/31  tailcalls/reject_tail_call_ref:OK
  #465/32  tailcalls/tailcall_sleepable:OK
  #465     tailcalls:OK
  Summary: 1/32 PASSED, 0 SKIPPED, 0 FAILED

Tiezhu Yang (3):
  LoongArch: BPF: Fix tail call prologue alignment
  LoongArch: BPF: Fix outdated tail call comments
  LoongArch: BPF: Fix off-by-one error in tail call

 arch/loongarch/net/bpf_jit.c | 38 ++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

-- 
2.42.0

