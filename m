Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274217;
	b=uw0fo8d9vs+DeEtrC5wfbqizF6dDUqsZvMnxkuN/u0veAnaYFrqH27M4RntG335V08fd
	 iBfFUSDHwFurj993udczXj9Gux867fC6T1l5Ybcf8wSnFPX6eDMyyfaAhtXbROLjTSLOz
	 rXrUIIYAFB38FQg5seDTIULtIKjPAYZ4HJ16ZHM30+4cLZuxrUrPniVX1aL0y0LbGXD/4
	 63byxjM0qIvY8pTb1/puT+u5ymbOL6H6JDmYSNHzA8dM80mScmxK7vzlwG7E6gvwffEg7
	 mLauOH7tRP9XI/ZxSrByoaj5e2jgOxOU16KoVi+p1lH6MDug/UXK0IWHxawPFS5wyIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274217;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=z0sBoMVqXcWFrJhOqrOl8ERgpdUGWgfd7CzIFPsW82A=;
	b=dIpUbBm6z2gZbbI+53nqVWcUXEl+5Dvz4ONECUm/F0n2vcZ1ZJptvp01j/ofFnpD20H5
	 jekwdX4QXJ9fnjdkhbboYpOwkCmff70wrv24P2inPVKR9prgP84lKAuNTJHYZ2ht6r+KR
	 D/7n3XtMR47gSK0ttCDkPq+umdq3nmN0nCVziPUhOR+jRZSKaPHsJSF7E77cOqi0NFuAo
	 o7mKHWurnrrkSaUyihjMBnvJRqNuClssl8/gly9idu6uSe6Th6M1yiYMfrm0PeDHvUDHe
	 V3RKu0Z9UwpBkiuFwP3FgLdtB3a7Pb0qodP4JT1n2IxgdPla1eTm8tk1zEKVt0AecgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BF606A31E
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 11:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 570BF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jFj6B3fk8z1c0SK
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 19:43:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3B49F40561
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 19:43:31 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDn7gFiMeNqabEECQ--.46399S2;
	Thu, 29 Oct 2026 19:43:31 +0800 (CST)
Message-ID: <63dbd2ab-b403-4769-bf1e-a05a938e6113@huaweicloud.com>
Date: Thu, 29 Oct 2026 19:43:30 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 14/21] bpf, arm64: Shorten the tail call sequence
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, puranjay@kernel.org
Cc: memxor@gmail.com, ast@kernel.org, bpf@vger.kernel.org
References: <20261027182445.1156335-1-daniel@iogearbox.net>
 <20261027182445.1156335-15-daniel@iogearbox.net>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20261027182445.1156335-15-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDn7gFiMeNqabEECQ--.46399S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAq
	zxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUU
	UUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 10/28/2026 2:24 AM, Daniel Borkmann wrote:

[...]

>    d37d7c4b  ubfiz x11, x2, #3, #32
>    f86b694b  ldr x11, [x10, x11]

The two instructions can be replaced with
a single ldr instruction:

ldr x11, [x10, w2, uxtw #3]

ubfiz is not needed.

