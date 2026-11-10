Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274156;
	b=UziY3EFTBYM+O2wNqXXp0RNwxvLeHduOL45DnQP6VGmXnQHhFNMc+rZuY1EL1/+s5kXM
	 ziHHbdE0mMKBWNI8yBPv/RXC0I7Fa1YIiu9gImU/0cOBYKD31aGNTUgLy66yCaAAsppeE
	 IyxW5L3OiRzUPrcIfX8M1KYy/g1V/XqzkCspOENlXbaB8vgm/0lrXYZ8zs7G2ouUjm32X
	 fyUrrkt+qBVai3RQbPZonFoaCrK0WybN4bo61kdnkEznu5aYCsL9R6viWZ0/mgQWhTMaH
	 6BehMviLVT2R+ARjULXInChrAjvtkk8EjNt7wMRmpNe/pY62I0GPsk/L6FUe9t+A0dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274156;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=aVUk5KNfoVM/ifJWEbEfsYize+Uhc5V1gasZQZSUIGY=;
	b=QvFlxPoJhuEV8qe/bUeFzuMSRAdzwkTTzM2JomgJUfrFzYFqluf00AfrUo20DUsvxI3X
	 HqL42ooaPCNRQWY9dtOeIL/g81Nyq837LWS7oJ+lMo0CZZJoKSm30jlHvkgTfeEpkMQ+p
	 KSn7fBbGn4L1ZgQS6+oukbbYjNdlYEn+dFl2+4hcb+A1kLQttvORBw7UiKzcxc2ih6kJO
	 /zD78somK1CVjxz1UMXXzN0uqmBkiMvNL9ZLYA/vRyZCxz737dz+Yo8w17qY+S5kmCyEK
	 6bJ4xpOFw+cWG1/5t1CmYjv/R1tIJkwhqyiHe5t/EglESH2EJFArlN4pfry2b4VmF9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69431606A321;
	Tue, 10 Nov 2026 01:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69431606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxUNFic_JqZQQeAA--.21498S3;
	Tue, 10 Nov 2026 09:29:06 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxTs9gc_Jq7l0zAA--.39359S2;
	Tue, 10 Nov 2026 09:29:05 +0800 (CST)
Subject: Re: [PATCH v2] mm/slub: Genericize x86-specific cmpxchg16b comment
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261109035906.10857-1-yangtiezhu@loongson.cn>
 <DMQW32TTNOPX.24GN6Q7VI6QJR@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <145c23ea-bc4d-b235-c822-df94b00a647a@loongson.cn>
Date: Tue, 10 Nov 2026 09:29:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <DMQW32TTNOPX.24GN6Q7VI6QJR@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxTs9gc_Jq7l0zAA--.39359S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruryxJF1kWr43AFykXF43urX_yoWfGFb_Cw
	n8GF1vkw18XFnayF10kF12vryUuws2qrs7ZrZ8JFyYy34kt3s5CFs5Cr4fGr15XFsayrs3
	Kw4DXF9xZFZxCosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

On 11/10/26 2:25 AM, Alexei Starovoitov wrote:
> On Sun, Nov 08, 2026 at 07:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>> atomic primitive is satisfied by different hardware implementations:
>> (1) arm64: satisfies it via LSE atomics ('casp' instruction)
> [...]
>> Update the comment to "double-width atomic cmpxchg", which provides the
>> following advantages:
>> (1) Accurately describes the cross-platform hardware invariant.
> 
> You ignored Hao's point about shorter commit logs.

If the following shorter commit message is preferred:

   mm/slub: Genericize x86-specific cmpxchg16b comment

   In __kmalloc_nolock_noprof(), update the comment from x86-specific
   "cmpxchg16b" to generic "double-width atomic cmpxchg".

I will wait for a while for more feedback from mm maintainers and send
v3 if necessary.

Thanks,
Tiezhu

