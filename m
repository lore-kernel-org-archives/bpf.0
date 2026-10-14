Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A25335BDC2
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947282; cv=none; b=IlkofgTAfsSm9oK0NJU3wdzT+8sHvRchSrsRGtFsGAslIn+ee1oavDpNvEftEO+Ue6rdi2Qs6ZecQTGHHpzNyD+6L70eMMPWyz6XPGkpcG5XGyrhu6UUGX1U8YTL0KJH9ZOjJRcAABYrnje8Rw4KpjKObRvNnBpf6mmnnvCGe1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947282; c=relaxed/simple;
	bh=qkvwYBHEY8tnKbKt621Drhbco2Nap7blGioKoBbzOtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoPV8BbCgy0x1GTLxLPiiKESyIOvIn6m+CywANYeTxXeE178XcPOiu5C/VQTjrxViJqukoP6AAYpXbXmtEt5VN57imu4NnbTZxOglbh3Cr4DGGSOSLw2ftM9TopyM6oAB1xepdT8Gbc1XN7obPmBMC6F55rDzVDaqH/yfun3CT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=NOL+/0Q9; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="NOL+/0Q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=qkvwYBHEY8tnKbKt621Drhbco2Nap7blGi
	oKoBbzOtg=; b=NOL+/0Q9PV4+DUfGzG18KA6TWtyEf61XIMrfiabAkxjdR+c7ry
	aL6BgYqYaAmGrogDHg7UUV+DDEu87vPelVyU/IEBl1vYlee5nwSSJpovxs01WPQA
	1QP/ieiRi7zrVXXsWU+8zbXxVTpz+b6BPFr2upmnnCsNPR/Bx8wcn9JBc=
Received: from localhost (unknown [222.195.81.103])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBnYikC8s5qd3jnAQ--.117S2;
	Wed, 14 Oct 2026 11:07:46 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Track borrowed iterator result lifetimes
Date: Wed, 14 Oct 2026 11:07:45 +0800
Message-ID: <20261014030745.2614437-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn>
References: <20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBnYikC8s5qd3jnAQ--.117S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW3Wr43CF1rAry8KF45Jrb_yoW3CrX_ur
	92grZ8K3W7t3ya9F47GrsxArnI9393GFyrtr4kKr13Ar1kZr4UJFsxJrZxJryxAFWrJas8
	twnFq397tw1DKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxUx8sqDUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Hi all,

Just following up on this series. v6 implements the opt-out approach
discussed in the v5 review.

I also noticed a Patchwork grouping issue: the iterator series [1]
contains only patch 2/2, while patch 1/2 is listed under the separate
returned-slice series [2].

Both iterator patches are present on lore, with In-Reply-To and
References correctly pointing to this cover letter. The reported CI
run [3] contains the test patch but not the implementation, so it did
not test the complete iterator series.

I'm not sure whether a resend of v6 is needed in this situation.

Thanks,
Yunxiang

[1] https://patchwork.kernel.org/series/1174319/
[2] https://patchwork.kernel.org/series/1174317/
[3] https://github.com/kernel-patches/bpf/actions/runs/36346633709

