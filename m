Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C461E52C
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323201; cv=none; b=bA+J/jjRFIBj6zD65w6018miAA5ZGvcwoPShuYYBQhDQLay/JnNmHeiiJWcDepReXjdcWsEgKnmpXUfSaOOF7c2UeRc4LXgr/2Ot91R8C7u648QRkqRAD1nbTQdBfxCFS2mSbqnqdT7nzrnliLqwVyXPEucjDDfPPB2NYBAnNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323201; c=relaxed/simple;
	bh=4OKc4k4lSYnNFy0r5TJCo5yY/4w4yHPdZ0q7aAKtYt0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TJy8fcntwOu3gp/79vVoaeoCOMKDhYlB4QuofIG9xksI1UkqDwSzC9WF0eU4IzHDoGxeb0M3MptZZHFsDQpJqh6Eaz0pLdz0prc2La7ckhrJBsgfMFCHNdS4WJzhN2ZPR+h2iPBnE64wfKaR/8JTLOfAqZognEMF6uhscYRIo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V9zbw199jz4f3lfQ
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 21:19:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9C1611A0572
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 21:19:48 +0800 (CST)
Received: from [10.48.117.177] (unknown [10.48.117.177])
	by APP3 (Coremail) with SMTP id _Ch0CgBHCaFz+g9mw04HJA--.43987S2;
	Fri, 05 Apr 2024 21:19:48 +0800 (CST)
Message-ID: <c9596b70-b7d9-4a88-8c7d-30e5e6ab35f1@huaweicloud.com>
Date: Fri, 5 Apr 2024 21:19:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: puranjay12@gmail.com
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
 martin.lau@kernel.org, pulehui@huawei.com
References: <CANk7y0irLCvngsPtwR007DPoTjgT0BQfmkPW4AOY0hTRkWV8Xw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CANk7y0irLCvngsPtwR007DPoTjgT0BQfmkPW4AOY0hTRkWV8Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBHCaFz+g9mw04HJA--.43987S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5H7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Nice work! Puranjay. I am on festival holiday.

