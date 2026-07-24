Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46C25EF87
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878389; cv=none; b=HCDSZ8R5CmsGOChcnrhlDtCB+NlVagYDSyb+ZVREmha5Ny7y7ouNa4lUHNdZes9FfWcEUsMvnS8bSSfb1UZDyihIPJMzS7qEsBGWvhA64khKIGhMny+AzjWV2pVCuBSpq72hiPbve7yPkagpCvJ2PZO5I77iw+9itzT+2KrgIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878389; c=relaxed/simple;
	bh=K2ZrW9rCezfqIr7LbMMmS5LyMGpMM0AES+n7fi9HYDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyy+T7304FVSimxhndqdVWgMjkAYAlEoOSBnJvxSabBBZZ9DXaFaLsWcJoBXWgV5x2gSXNkUPKb3X6vq2chGtMQwj9q/MkLZW9ZlAZ41bjtZZy2CDezB9PMyAkEAOPiR0jV6hG/fP1cLXD0MNCcThiwbHJy8OFSFV7lA/t1iEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Tl4glLYX; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Tl4glLYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rr
	h8Nx816ilEoa+V2dZNqxNQ+ex+5SPnJVoM2Tnbeg0=; b=Tl4glLYXLhWCduWFAc
	BUjE8JF2p/b+iGPknRkuF7l6j87IocxC9btF+ntO/0Iu1LfazXQ9JMaEUdUomZw5
	McBn+KWv+ZbvTixS1912ey2VDJAguEWa8ju9YlL1gdq2Ks0jjvjhP/AYO4UhKzk7
	zxrsUGlhhVU4/qsreLMCyY++M=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnpZ8TFWNquNfKLg--.11016S2;
	Fri, 24 Jul 2026 15:32:36 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	yangfeng59949@163.com
Subject: Re: [PATCH v3 bpf-next 3/5] selftests/bpf: Fix missing allocation null checks in test_progs.c
Date: Fri, 24 Jul 2026 15:32:35 +0800
Message-Id: <20260724073235.693532-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723091756.78C1F1F00A3A@smtp.kernel.org>
References: <20260723091756.78C1F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnpZ8TFWNquNfKLg--.11016S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1UAr4DCrWxuFy5ZF45GFg_yoW3uwbEg3
	WYkrykGFnrA395JwnYyr47tFs5tr15AF48X342yF45JFZ5XFWDZr1kGr15Jw1UWws3tr9r
	K3s3Ka9IqrsrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjiZ27UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzxS9NmpjFRREdAAA3o

On Thu, 23 Jul 2026 09:17:55 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Early return from `dispatch_thread_send_subtests` leaves `subtest_states` partially uninitialized, leading to a crash during cleanup.

The 4th patch has fixed this issue.

> - [High] Missing NULL check for `strdup` in `dispatch_thread_send_subtests` leads to a potential segmentation fault.
> - [High] Updating `subtest_num` before allocating `subtest_states` leads to a NULL pointer dereference during cleanup if an error occurs.
> - [Medium] Failing `realloc` in `test__start_subtest_with_desc` overwrites the original pointer, leaking the array.

The 5th patch has fixed this issue.

> --
> 

[...]

