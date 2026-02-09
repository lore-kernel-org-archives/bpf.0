Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F562040B6;
	Mon,  9 Feb 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643136; cv=none; b=aypfXKrkmMkjgE2sfuVehItV5mvLOLwxYL48csb6cMNGnnkN+BjRAPlZuQ/KP+EXE2exMa5yzwi4kV1if9rjfOg6HxX4iJsPJNCt73XFO6Kbx+CNM7i//2ScU8J2ZlV6NgOMhuAQGZrkIqt99g1cguq0CYKccVZ3DqAfbeOgllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643136; c=relaxed/simple;
	bh=Or3NiazN/gLOlpbJIThRQOpfISr25Xg1wR/TYqOzeUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fbw53Kr1iPBWYE6U2lj5VDgS6xrxhmPrFFBKnECYAKP3G9IXaP5lqWXg4W5pqh0dgh4KIEHJEeC/fMKwZjhAOyJhHaKa9fhuIeTn2+FZ2OMyq5Tf7vtVpOMffpUUsAvKVmjkmygcWCZ+Ajn3wmdA0uZ646ySXvlVXnpZishB2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0eMI6mgk; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0eMI6mgk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZcnmD8/Oc5SbdX3u+nnGeYLputNhesaaUI5g9TCzBEU=;
	b=0eMI6mgkBu1Wr+5isJ1ZE9QEFCSdGsYtbQ+ZpZyzIEuRMUPDL7pYlRQQPXCXkpyCTXDMl+N63
	y/gZuDvq30Pf7CR7xobigbOmUSHc8AjRPx/cL7vizKJn0b2rStLY6hjn3nxul4S/amnZDk5QhR1
	BYIJiPtv6+PKheIvrteF7IQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f8lXT4fDpzpStM;
	Mon,  9 Feb 2026 21:14:33 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F5744036C;
	Mon,  9 Feb 2026 21:18:53 +0800 (CST)
Received: from [10.67.110.198] (10.67.110.198) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 9 Feb 2026 21:18:52 +0800
Message-ID: <036eb7a9-1759-447b-ad94-2d66928f9d71@huawei.com>
Date: Mon, 9 Feb 2026 21:18:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/3] bpf: fsession support for riscv
To: Menglong Dong <menglong8.dong@gmail.com>, <ast@kernel.org>,
	<bjorn@kernel.org>
CC: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>, <puranjay@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jiang.biao@linux.dev>
References: <20260208053311.698352-1-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260208053311.698352-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/2/8 13:33, Menglong Dong wrote:
> Implement bpf fsession for the riscv architecture.
> 
> Changes v4 -> v3:
> * fix the build error
> * v3: https://lore.kernel.org/bpf/20260206122002.1494125-1-dongml2@chinatelecom.cn/
> 
> Changes v3 -> v2:
> * fix some comments.
> * v2: https://lore.kernel.org/bpf/20260206115823.1070354-1-dongml2@chinatelecom.cn/T/#t
> 
> Changes v2 -> v1:
> * use bpf_prog_calls_session_cookie() in invoke_bpf() in the 2nd patch.
> * v1: https://lore.kernel.org/bpf/20260203055231.1088479-1-dongml2@chinatelecom.cn/
> 
> Menglong Dong (3):
>    bpf, riscv: introduce emit_store_stack_imm64() for trampoline
>    bpf, riscv: add fsession support for trampolines
>    selftests/bpf: enable fsession_test on riscv64
> 
>   arch/riscv/net/bpf_jit_comp64.c               | 97 +++++++++++++++----
>   .../selftests/bpf/progs/get_func_args_test.c  |  2 +-
>   .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
>   3 files changed, 79 insertions(+), 22 deletions(-)
> 

looks good to me, feel free to add

Reviewed-by: Pu Lehui <pulehui@huawei.com>
