Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A5158535
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114190; cv=none; b=HeAxTbEIFeYusg5rhDP8ddMIHHFFnfl14+ilaci8kfMC434z+b+ULvuXLh/YB5eFuFct/V5mtAIYZM8tDf8P89xdzemRaJk07OCamzTFcfohrVpMQSM1kAVcf6Dfe+r6SK1RtekVZB8J5Xyuct1/ypRzea/zukZsboo9fq3nZ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114190; c=relaxed/simple;
	bh=3JTWcdJZRRCSxNoUsVTit46Hw8vl/f4P2VLDPsxV3RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cm8nK3h5rYeRf5f1SmKvs0kLHgKQkoe5LActRzOh2hpLiP8lfJFPwX7quIxmgDpg8wPB+IlbkXv9EbYNocxCBL2hc6icna4z7MtkiOSKKI6C+qWNWVRap9fTMfjDEF696nR4acxwhFGZ/LZM4FWYCdAqLdMfRjhD7cx2nIw+sGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.4.205])
	by mtasvr (Coremail) with SMTP id _____wDH2mdcy4FphqZ1AA--.1638S3;
	Tue, 03 Feb 2026 18:18:04 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.4.205])
	by mail-app2 (Coremail) with SMTP id zC_KCgDXpTdZy4FpVXOoBQ--.61863S2;
	Tue, 03 Feb 2026 18:18:03 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	shenghaoyuan0928@163.com,
	song@kernel.org,
	tangyazhou518@outlook.com,
	yonghong.song@linux.dev,
	ziye@zju.edu.cn
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bitwise tracking for BPF_END
Date: Tue,  3 Feb 2026 18:17:36 +0800
Message-Id: <20260203101736.4975-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e62c874af12c74ec4442df6e098c6d5000f9540e.camel@gmail.com>
References: <e62c874af12c74ec4442df6e098c6d5000f9540e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDXpTdZy4FpVXOoBQ--.61863S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?PERftAXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083uYxgGwm4o3MkAMAFMbdSWgb3btWnx/H4ChqrOzDo5u58BKQyCnTNddsZhqXbl0eNKKZ
	QTZ4Zi8wLE89CsxZXv27IioAAjnOAt8rYZw12Biq
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWDJFyxAw13Aw4DWF4Dtrc_yoW8Gw4fpa
	yrKF45Kr4DWa4Ika4UZFW7Jry29a13AFWkWayDGr93A3Zaqr18Xr9xt3WUu3WUGr4fuw1Y
	qFs8Z3srurWqyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1iZ23UUUUU==

Hi Eduard,

Thank you for the review and the ack.

On 2/3/26 4:03 AM, Eduard Zingerman wrote:
>> -	/* ALU32 ops are zero extended into 64bit register */
>> -	if (alu32)
>> +	/*
>> +	 * ALU32 ops are zero extended into 64bit register.
>> +	 * BPF_END is already handled inside the helper (truncation),
>> +	 * so skip zext here.
>> +	 */
>> +	if (alu32 && opcode != BPF_END)
>
> Nit: zext after scalar_byte_swap() won't change anything, right?
>      If so, I'd just avoid the special case and skip 'opcode != BPF_END'.

Actually, for BPF_END, the alu32 flag may mislead regarding the actual data width being processed.
The operand size for BPF_END is determined by insn->imm , not by the opcode class. 
So if we simply rely on if (alu32) to perform zext_32_to_64(), we might encounter an unsound state 
in the following cases:

* le64 : opcode=0xd4 (BPF_END | BPF_ALU | BPF_TO_LE)
* be64 : opcode=0xdc (BPF_END | BPF_ALU | BPF_TO_BE)

These instructions belong to BPF_ALU, so alu32 is true. However, it is a 64-bit operation. If we 
perform zext_32_to_64() after scalar_byte_swap(), the verifier would incorrectly zero-out the 
upper 32 bits of a 64-bit result, which is incorrect and unsound.

Since scalar_byte_swap() already handles truncation and zero-extension internally based on the 
precise ' insn->imm ', it's safer to skip the generic alu32 zext for BPF_END altogether.

If you have any more questions, please feel free to reach out.

Best,

Tianci

