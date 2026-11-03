Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671605;
	b=p+yzYBZgNLivADzEBo5FNzKJNQ0Cc6METWjzMwV9amrbC6T1nnIAH4peQRol4WbSokIa
	 qFKqfrIcfesREj1E7q0vilp8OwQz5+1gQ3q9q7LnMDbgGtX2ZN/c4qORzg4g10gqNAJ8r
	 pCS7eWnFKYLnkueAlIwqfIQYjPg23sW6COflgkTyslbb16OIsSlP0Gk/lC1GoLZXBai8Q
	 YEAhTXRYkFGpGPynkWE6S/fqMr1OwjrjnQV2A3E8BrMCFk6O3Z8kwLVuZYEC4HUQVW2p6
	 2YGtCsy0AzetUVfwywhPqxo+qlH2CXOqVn3wPM0xeUC6Ot3Wh5+d6y42C7CJk/lQXVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671605;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=RzX4AQ3e6ZoGE4mUlu6tKG/Oz/H7NA9+yKn3mEmnoXM=;
	b=MvWzgwzxqHwWBcdQ0iKYyoYtNJamXDADtons8poABPyHsfP1U01plCe3uND1Fp9mlOFj
	 nGDLF+bqRrKI3AZrbI3FuK7S0kleFVYAt34y4Kj/cc8uIXHkOMXTbKIQVDr7Hu81Kzvzx
	 PhLAtTmX/fU0HAb63eoh7y0hChPIDXV0ldw2mdAJqJqsDgiashDjXCmWPR/oSU961cHNp
	 qe0WqV67AZM51ux8TLSh1K3NCluZbYXgX1D4LeBQgtN9S371KXziWFaDCPrtEjzlRAWl1
	 nvLpoIWKxnGuIIEvQUfvz2AaIU7bZzBoyEY5JKLV6nKjntAQrVbWnsapYCIpxLHTRzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7341606D80B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7341606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxW_CyQelqO84bAA--.14934S3;
	Tue, 03 Nov 2026 10:06:42 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxtMytQelqpgoyAA--.11150S2;
	Tue, 03 Nov 2026 10:06:38 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Handle unaligned access
 failure in fexit_bpf2bpf
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261102081230.7063-1-yangtiezhu@loongson.cn>
 <20261102081230.7063-3-yangtiezhu@loongson.cn>
 <sashiko-outbox-193100@kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e4c47861-7ba2-d145-f92a-09bf9c1c01f5@loongson.cn>
Date: Tue, 3 Nov 2026 10:06:37 +0800
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
In-Reply-To: <sashiko-outbox-193100@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxtMytQelqpgoyAA--.11150S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFWrCrWDXw17GF4kXFW8AFc_yoW8Ww4Dpa
	s7A34jkrW0gF1Yq3Wjka17Jay5Krn2qay8Kr1rtr9xur18Jr10grn7KF4jg3sIgrZa9rsa
	va93tFs8Z34kZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8U
	UUUU=

On 2026/11/2 下午4:23, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:

...

> Would constraining the alignment of off (or performing a 1-byte modification)
> in test_pkt_write_access_subprog() and new_test_pkt_write_access_subprog()
> allow all of these tests to run on strict-alignment systems?

Will fix unaligned access at the source by applying a bitmask
'off &= ~1' instead of skipping these tests entirely.

Something like this:

```
diff --git a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c 
b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
index f4bbf87b82dd..ed06345825e2 100644
--- a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
@@ -173,6 +173,7 @@ int new_test_pkt_write_access_subprog(struct 
__sk_buff *skb, __u32 off)
  	if (off > sizeof(struct ethhdr) + sizeof(struct ipv6hdr))
  		return -1;

+	off &= ~1;
  	tcp = data + off;
  	if (tcp + 1 > data_end)
  		return -1;
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c 
b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..21f28a762d60 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -91,6 +91,7 @@ int test_pkt_write_access_subprog(struct __sk_buff 
*skb, __u32 off)
  	if (off > sizeof(struct ethhdr) + sizeof(struct ipv6hdr))
  		return -1;

+	off &= ~1;
  	tcp = data + off;
  	if (tcp + 1 > data_end)
  		return -1;
```

I will send out v2 next week if no more comments.

Thanks,
Tiezhu

