Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0DA35294E;
	Thu,  2 Jul 2026 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782969122; cv=none; b=C321+b6AG68I7MJAASegh2KqUPF3HzeH9DLZSpKhftvwhl6F/kaIc/jV6FXR8WFaBOMaJpxeCZAgrOnc277F5dXW4dUfMaoKK/ejZJXw6s/E1PrE2uidGZ5N+cvCAqgt/qgGi+Jq85iA2Itx8EcOoLpNj6/wf9RpPOWvsSOTf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782969122; c=relaxed/simple;
	bh=Vmd3c3Ns6qHBgqRx4vL/70sPVgdmABUgQpz8EnCt4DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JysbsaJFdaFlo85VgSa9mUIHdxLbu15H8UmjtxAygb19/tIKBH/6X2zHzTaTrM74HtNrUGpb60HuIaYzzEXQBPXISvWoC1EMYf4tt6mk5ZOz4uPT/LZ96sFxvqoAjgZSwxIRpvocxo3rsxVtKZLAvNvEnHfO8zVxbq9Pe91oes8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ij7hRrCu; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ij7hRrCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Vmd3c3Ns6qHBgqRx4vL/70sPVgdmABUgQp
	z8EnCt4DE=; b=ij7hRrCufGNtFSD9vdbrYd74ltM521OWim+3Y78wuEgj6dzGwT
	z3AFhSxW42zQFFkEO+6T2FRMgdfRtFp7GujU5YWS6o30IHgb2oZWvlywS+r6Zatq
	lfklU31sUVuH0NbabkI4AYGoo6TJL4ALZ5Hfb9Ey8m6WGfuh1JhikB6x0=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQAHvr368kVquHbaAg--.40741S2;
	Thu, 02 Jul 2026 13:11:46 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: emil@etsalapatis.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyy23@mails.tsinghua.edu.cn,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	puranjay@kernel.org,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject arena frees below the arena base
Date: Thu,  2 Jul 2026 05:11:17 +0000
Message-Id: <20260702051117.3484334-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DJNJLQZIR0N9.2V69YW14LMS49@etsalapatis.com>
References: <DJNJLQZIR0N9.2V69YW14LMS49@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQAHvr368kVquHbaAg--.40741S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw15AF1rCFWrJr18GFy5XFb_yoWfGFg_Wa
	1qqFyxCrsrKa47G3WfK3W3CrWfC34xtF1rZrnrX3s7Ar95JF97Gr4Sgrs5uryxJFWUtrn8
	XF97KF1akr1qqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbD8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9189UUUUU
	=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

On Wed, Jul 01, 2026 at 09:12:00PM +0000, Emil Tsalapatis wrote:
> AFAICT this bug returns an address that is not actually
> mapped into userspace and is inaccessible from it, correct?

Yes, that is my understanding as well.

The bad free is below user_vm_start in the user VMA. The issue is that
arena_free_pages() still used the low 32 bits to compute the free-tree
offset, so the one-page-below address wrapped to an out-of-domain pgoff.
A later bpf_arena_alloc_pages() could then return an address outside
[user_vm_start, user_vm_end).

So user space should not be able to access that address through the arena
mmap; the fix is to keep that out-of-domain offset from entering the arena
allocator state in the first place.

> If the above is correct, feel free to add:
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Thanks, will add it to v2.

Yiyang

