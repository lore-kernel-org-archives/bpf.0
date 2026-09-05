Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE273E4C9F;
	Sat,  5 Sep 2026 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595213; cv=none; b=uty6C0UsFIUbnX9DY0Q3JP+qrSap9CwGkJ9j5zHfKO85xIh+ddcT2cx098av2OSROuCQENG2Z29DoB8N4njahfQPbOVOy0w+Bfk7vWc3Qhfmt5/SQHDtAaUO2eRk0UTOMHF4sundT6Bc5AoPph18lMeUWEBA4SX49IjmmSZuQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595213; c=relaxed/simple;
	bh=Ys0EXsW/iQZvbZ+wdSIk/9ZJlufhqMHJBNUUbCJRhTI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IlcfW4X+yDnl3GxlSHKMk/redK+34ney+sADc2WhNYHgiJgb0EeylEMZQbgxmVdf71ZmxHH1ozH2/BA5kLJuwpZ7Wah6kxyBZT5i5IOv8mGl2qvjg5BpbtHSQ5+nuzAvW0K4q6pYt/6QdkIcz1u7eVHyt0Wl5PyKOayijdhQft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrWmeRH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrWmeRH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74461F00A3D;
	Sat,  5 Sep 2026 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788595212;
	bh=gP9G6nGDbEt6seiJf/e5HFhvzZwqPiQgpFOg/RjaH6s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UrWmeRH0V7G3RqAtg8JnHdCkMuNInzwII1uDMmThveoy65V7BLl3fGSOZfrHiLMzS
	 TloF4wVWA8r+eTv6cQxbGdHOZnc0ssYgKzFuOJAx1bOOciRUazqP+T/YDPenM+HNOV
	 +7R8h+DoxFNszyoQGGeCbUYbbTOUfH+7POKrNsjQ6+adcaYhatlw+pfhjyeL4syJaD
	 TBYwqMZdt/jhqFP036Vw2sdBv3Efcqhf4MUXi3yg9er9eUS6zPJd9QdPaO1bJ41CBn
	 oU8pRXeDDQyGk/GCasPOhqK/ZY5LFHV9PK1O6nK+pBg5RQeOb+WEqFndMOCfqdbcHZ
	 dVVIFNeORQ+Rw==
Content-Type: multipart/mixed; boundary="===============0877743137689148681=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27b33e8d655c23498a546736e58ef01721ddc18462164e181864295a3b01ef42@mail.kernel.org>
In-Reply-To: <20260905070409.4141522-2-pulehui@huaweicloud.com>
References: <20260905070409.4141522-2-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v4 1/3] riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,jiangfeng@kylinos.cn
Cc: bjorn@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,alex@ghiti.fr,pulehui@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 08:00:10 +0000 (UTC)

--===============0877743137689148681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index e7378be171a9..aac128b9f0a4 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

[ ... ]

> @@ -1075,7 +1075,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
>
>  	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
>  	if (save_ret)
> -		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
> +		stack_size += 16; /* Save both T6 (BPF R0) and A0 */

Should the comment read "Save both T6 (BPF R0) and A0"? The patch updates
regmap[BPF_REG_0] from RV_REG_A5 to RV_REG_T6, and the stack slot at
retval_off - 8 is written via regmap[BPF_REG_0] in the save_ret block
(emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx)), so the
comment still naming "A5" contradicts the new mapping. After this series
a5 becomes an argument register (the 6th BPF argument maps to a5 in a
later commit), which makes "A5" actively misleading here since a reader
could mistake this slot for argument spill space rather than R0/return
value storage.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952202002
--===============0877743137689148681==--
