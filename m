Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85CB34167B
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716738; cv=none; b=Euz/MpxhHkLPB3zjxc1EHZ7pxA6JQBzVBCaIfDAVZn9T6aFKbD5oxELG7SeM9aZ/dtdHqxiwVcEcW2hE0W0QhUyf/roA5s6kSpvW8ufLodUoUOXPLBRkHZV/qjRfx6k8lJh3CnsB62NUHaeo3IoDRCprqrXAmfCKOvcOHaNYh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716738; c=relaxed/simple;
	bh=vChaTWOgeoQiB2+MOPcgTkZgz6+rD1NqQf6i+KHys4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGs0wxJYl9EA6sfafCnnFQmZYXDhX/Rx0fHMHVGFzouZ3R+u9p2Wo7Cl8JBpzJJD5lpK0b/Y9q01KglsPEVHMOAZmfWojMXxzRrwnk5wjpT4lp1meBc4mLOlEocYXLxHStiwI0tAa7eZOngufxmZtqy6ouzd26JCPAqCdGHxmmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.4.4])
	by mtasvr (Coremail) with SMTP id _____wBXwUkY_opp_EGdAA--.35481S3;
	Tue, 10 Feb 2026 17:44:57 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.4.4])
	by mail-app1 (Coremail) with SMTP id yy_KCgAHhs4X_oppbVkdBg--.30303S2;
	Tue, 10 Feb 2026 17:44:55 +0800 (CST)
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
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for BPF_END bitwise tracking
Date: Tue, 10 Feb 2026 17:44:54 +0800
Message-Id: <20260210094454.210007-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0e05189fc901cc1952982fe422d11c565f01c7f9.camel@gmail.com>
References: <0e05189fc901cc1952982fe422d11c565f01c7f9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAHhs4X_oppbVkdBg--.30303S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?5xrn1gXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083m9YdTa8lQerqvWm+lkv19DJi6dWAkQPVdJK4yI7GKWFXpEb+WOXd8JEjjoXbvEgqlWv
	b5OaZYQWa3NqE5eEu1g4QwseWFXEgsieRyhUlA/r
X-Coremail-Antispam: 1Uk129KBj93XoWxGryDZr1xWFW5ur48WFWrtFc_yoW5Xryfpa
	nxXrsxKF4kJr47Xw1Dtw17tr1rtF1v9ay8JFs8JrykZrn8Wr1DZw13tF45Ca47Ar4ktr12
	qF1jq34qy3WqvagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

Thu, 05 Feb 2026 10:35:41 -0800, Eduard wrote:

> Depends on how complicated the implementation is.
> Is it just theoretical work or you see some real-world programs that
> fail to verify due to insufficient BPF_END range tracking?

Hi Eduard,

Thanks for the feedback!

This is primarily theoretical research focused on developing an optimal algorithm
for interval analysis on bswap operations. We've been studying how to compute
precise min/max bounds for byte-swapped values given input ranges.

Our current demo implementation is approximately 140 lines of code for the
core bswap interval logic. There's room for optimization to reduce the code
size in future iterations.

We have verified the soundness of our algorithm using the Z3 SMT solver and
extensive randomized testing. Our interval tracking approach provides tighter
bounds than the Linux kernel's approach of converting intervals to tnum via
tnum_range() and then applying tnum_bswap() (kernel/bpf/tnum.c).

Here's a detailed example showing how both algorithms work:

Example: Small range with non-aligned boundaries (64-bits bswap)
Input range: [0x38e4, 0x978b]

* Tnum Algorithm :

   1. tnum_range(0x38e4, 0x978b)  (the function to convert a range to tnum in tnum.c):
      => tnum = {0x0, 0xffff}

   2. tnum_bswap64(tnum = {0x0, 0xffff}):
      - value = bswap64(0x0) = 0x0
      - mask = bswap64(0xffff) = 0xffff000000000000

   3. Extract bounds:
      - min = 0x0
      - max = 0xffff000000000000

   result: tnum:  {value: 0x0, mask: 0xffff000000000000}
           range: [0x0,0xffff000000000000]

* Interval Algorithm: 
   let bswap_min(min,max) = res_min
       bswap_max(min,max) = res_max

   1. Identify common prefix:
      min = 0x38e4, max = 0x978b
      highest 48 bits are the same
      Only the lowest 2 bytes differ

   2. Compute bswap_min(0x38e4, 0x978b):
      0x3900 in range [0x38e4, 0x978b]
      res_min = bswap64(0x3900) = 0x0039000000000000

   3. Compute bswap_max(0x38e4, 0x978b):
      0x96ff in range [0x38e4, 0x978b]
      res_max = bswap64(0x96ff) = 0xff96000000000000

   result: range: [0x0039000000000000, 0xff96000000000000]
           tnum:  {value: 0x0000000000000000, mask: 0xffffffffffffffff}

Comparison:
- Interval range: [0x0039000000000000, 0xff96000000000000]
- Tnum range:     [0x0000000000000000, 0xffff000000000000]

The key difference: Interval algorithm exploits bswap's byte-exchange property
to align boundaries precisely, while tnum conservatively marks all "uncertain"
bits as completely unknown.

Given the modest implementation cost and potential for improved precision, we
believe this could be useful. Would it be helpful if we prepare an RFC with
detailed examples and benchmark data?

Best regards,
Tianci

