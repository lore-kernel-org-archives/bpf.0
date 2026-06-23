Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7038E11A;
	Tue, 23 Jun 2026 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195157; cv=none; b=mDoULwosxeSOob1H/kqAMiqjWIC5bWnMaYXpseELBURbhH1j1PAfyanbc4NnNoYxe6Pgp9fYCUlKLp1mTzXCCUrpp6wWGyBjPfxeREiPP2x2J9a438TMEsL2cbt+mZUnCaVZbgoA02u/HAHRqNyMl4MDefkezu3BlJ7V9SQb2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195157; c=relaxed/simple;
	bh=23lwhzWfgdMDmDczAVwgWgTHK6r/bqze9OcPfuLjQZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVvY6+CHwkBqdRo4yahPRvd+REA12GGLKS3WAMyPqfmffwBh2GzGT7+HEzFSz6yHu1ly9SF571Vn7p6lPFOyOSJb73LO6RN79q6AGpXQwKLqtgOixQpSQiVbAQr87dy34gqe89OfGJ9N1PGqYS8owRjemXnQZoh+knVmcvsmV3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=nu6qsrzI; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="nu6qsrzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=23lwhzWfgdMDmDczAVwgWgTHK6r/bqze9O
	cPfuLjQZg=; b=nu6qsrzIvi6qiOzbiVvLqkbI+ykCOw3XvoAZx70gqKfZGPhyrZ
	43vyYlVA2Lvq4L4A69icsfPenUCoHDvcrVIe1Y7N3l4G+E0saE0FugESecW115zv
	eFAqb4oGXJpaLOVH5E4CgOLUzBnDApSceF3/ThrpntfnTeSGvIFzUXE9g=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQBHk5C4IzpqE2KmAg--.12123S2;
	Tue, 23 Jun 2026 14:12:16 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyy23@mails.tsinghua.edu.cn,
	daniel@iogearbox.net,
	davemarchevsky@fb.com,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	shuah@kernel.org,
	song@kernel.org,
	vmalik@redhat.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover refcount acquire node offsets
Date: Tue, 23 Jun 2026 06:12:05 +0000
Message-Id: <20260623061205.2691322-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170c35441f167931b1a651e5bf07f671bc429368.camel@gmail.com>
References: <170c35441f167931b1a651e5bf07f671bc429368.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBHk5C4IzpqE2KmAg--.12123S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO57AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvE
	ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I
	8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I2
	1c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW8Aw
	CF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVW8ZVWrXwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfU5YFCUUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

On Mon, Jun 22, 2026 at 03:30:57PM -0700, Eduard Zingerman wrote:
> This paragraph is completely unnecessary.
>
> I don't think the fixes tag applies to the test.
>
> Why is this test necessary? Does it exercise any paths that the
> previous one does not check?

Thanks, all addressed in v4.

I removed the paragraph, dropped the Fixes tag from the selftest patch,
and removed the rbtree test. The list-node case exercises the same
refcount-acquire fixed-offset rejection path, so the rbtree variant is
redundant for this regression coverage.

Yiyang

